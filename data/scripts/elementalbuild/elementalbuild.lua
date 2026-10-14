local json = dofile("data/libs/dkjson.lua")
dofile("data/scripts/elementalbuild/elementalbuild_config.lua")

local ELEMENTALBUILD_OPCODE = 14
local ELEMENTAL_BUILD_CAP = 500
local ELEMENTAL_BUILD_DAMAGE_RATIO = 1.0

local VALID_COMBAT_TYPES = {
    [0]  = true,
    [1]  = true,
    [2]  = true,
    [3]  = true,
    [9]  = true,
    [10] = true,
    [11] = true,
}

local function buildInvestedPointsPayload(player)
    local investedPoints = {}

    for combatType in pairs(VALID_COMBAT_TYPES) do
        investedPoints[tostring(combatType)] = player:getElementalBuildPoints(combatType)
    end

    return investedPoints
end

local function applyElementalBonuses(player)
    for combatType in pairs(VALID_COMBAT_TYPES) do
        local points = player:getElementalBuildPoints(combatType)
        player:setElementalDamageBonus(combatType, math.floor(points * ELEMENTAL_BUILD_DAMAGE_RATIO))
    end
end

local function isMissionCompleted(player, missionId)
    return player:getStorageValue(ElementalBuildStorage.missionStatus(missionId)) == ELEMENTALBUILD_MISSION_COMPLETED
end

local function markMissionCompleted(player, missionId)
    player:setStorageValue(ElementalBuildStorage.missionStatus(missionId), ELEMENTALBUILD_MISSION_COMPLETED)
end

local function playerHasAllMissionItems(player, mission)
    for _, item in ipairs(mission.items) do
        if player:getItemCount(item.itemId) < item.amount then
            return false
        end
    end
    return true
end

local function removeAllMissionItems(player, mission)
    for _, item in ipairs(mission.items) do
        player:removeItem(item.itemId, item.amount)
    end
end

local function buildMissionItemsPayload(player, mission, missionId)
    local completed = isMissionCompleted(player, missionId)
    local itemsPayload = {}

    for _, item in ipairs(mission.items) do
        local progress = completed and item.amount or math.min(player:getItemCount(item.itemId), item.amount)
        itemsPayload[#itemsPayload + 1] = {
            clientId = item.clientId,
            name     = item.name,
            progress = progress,
            total    = item.amount,
        }
    end

    return itemsPayload
end

local function buildCurrentMissionId(player)
    for missionId, _ in ipairs(ElementalBuildConfig.missions) do
        if not isMissionCompleted(player, missionId) then
            return missionId
        end
    end
    return nil
end

local function buildMissionListPayload(player)
    local missionList    = {}
    local completedCount = 0
    local currentMissionId = buildCurrentMissionId(player)

    for missionId, mission in ipairs(ElementalBuildConfig.missions) do
        local completed = isMissionCompleted(player, missionId)

        if completed then
            completedCount = completedCount + 1
        end

        missionList[#missionList + 1] = {
            id          = missionId,
            name        = mission.name,
            description = mission.description,
            points      = mission.points,
            items       = buildMissionItemsPayload(player, mission, missionId),
            completed   = completed,
            isCurrent   = missionId == currentMissionId,
            isLocked    = not completed and missionId ~= currentMissionId,
        }
    end

    return missionList, completedCount
end

local function sendFullState(player)
    local missionList, completedCount = buildMissionListPayload(player)

    player:sendExtendedOpcode(ELEMENTALBUILD_OPCODE, json.encode({
        action          = "data",
        availablePoints = player:getElementalBuildAvailablePoints(),
        investedPoints  = buildInvestedPointsPayload(player),
        missions        = missionList,
        completedCount  = completedCount,
        totalCount      = #ElementalBuildConfig.missions,
    }))
end

local function sendInvestResult(player, success)
    player:sendExtendedOpcode(ELEMENTALBUILD_OPCODE, json.encode({
        action          = "investResult",
        success         = success,
        availablePoints = player:getElementalBuildAvailablePoints(),
        investedPoints  = buildInvestedPointsPayload(player),
    }))
end

local function sendMissionResult(player, success, missionId)
    local missionList, completedCount = buildMissionListPayload(player)

    player:sendExtendedOpcode(ELEMENTALBUILD_OPCODE, json.encode({
        action          = "missionResult",
        success         = success,
        missionId       = missionId,
        missions        = missionList,
        completedCount  = completedCount,
        totalCount      = #ElementalBuildConfig.missions,
        availablePoints = player:getElementalBuildAvailablePoints(),
    }))
end

local function handleRequest(player)
    sendFullState(player)
end

local function validateInvestPayload(player, pointsPayload)
    if type(pointsPayload) ~= "table" then
        return false
    end

    local totalPoints = 0

    for combatTypeStr, points in pairs(pointsPayload) do
        local combatType = tonumber(combatTypeStr)

        if not combatType or not VALID_COMBAT_TYPES[combatType] then
            return false
        end

        if type(points) ~= "number" or points < 0 or points > ELEMENTAL_BUILD_CAP then
            return false
        end

        totalPoints = totalPoints + points
    end

    if totalPoints > player:getElementalBuildAvailablePoints() then
        return false
    end

    return true
end

local function handleInvest(player, pointsPayload)
    if not validateInvestPayload(player, pointsPayload) then
        sendInvestResult(player, false)
        return
    end

    for combatType in pairs(VALID_COMBAT_TYPES) do
        player:setElementalBuildPoints(combatType, 0)
    end

    for combatTypeStr, points in pairs(pointsPayload) do
        player:setElementalBuildPoints(tonumber(combatTypeStr), points)
    end

    applyElementalBonuses(player)
    sendInvestResult(player, true)
end

local function handleDeliver(player, missionId)
    local mission = ElementalBuildConfig.missions[missionId]

    if not mission then
        sendMissionResult(player, false, missionId)
        return
    end

    if isMissionCompleted(player, missionId) then
        sendMissionResult(player, false, missionId)
        return
    end

    if not playerHasAllMissionItems(player, mission) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You don't have all required items.")
        sendMissionResult(player, false, missionId)
        return
    end

    removeAllMissionItems(player, mission)
    player:setElementalBuildAvailablePoints(player:getElementalBuildAvailablePoints() + mission.points)
    markMissionCompleted(player, missionId)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Mission completed! You earned " .. mission.points .. " elemental build points.")
    sendMissionResult(player, true, missionId)
end

local elementalBuildEvent = CreatureEvent("ElementalBuildOpcode")
elementalBuildEvent:type("extendedopcode")

elementalBuildEvent:onExtendedOpcode(function(player, opcode, buffer)
    if opcode ~= ELEMENTALBUILD_OPCODE then
        return true
    end

    local data, _, err = json.decode(buffer)

    if err or not data or not data.action then
        return true
    end

    if data.action == "request" then
        handleRequest(player)
    elseif data.action == "invest" then
        handleInvest(player, data.points)
    elseif data.action == "deliver" then
        handleDeliver(player, data.missionId)
    end

    return true
end)

elementalBuildEvent:register()

local elementalBuildLoginEvent = CreatureEvent("ElementalBuildLogin")
elementalBuildLoginEvent:type("login")

elementalBuildLoginEvent:onLogin(function(player)
    player:registerEvent("ElementalBuildOpcode")
    return true
end)

elementalBuildLoginEvent:register()