local json = dofile("data/libs/dkjson.lua")
dofile("data/scripts/elementalbuild/elementalbuild_config.lua")

local ELEMENTALBUILD_OPCODE = ElementalBuildConfig.opcode
local ELEMENTAL_BUILD_CAP = ElementalBuildConfig.pointsCap
local ELEMENTAL_BUILD_DAMAGE_RATIO = ElementalBuildConfig.damageRatio

local VALID_COMBAT_TYPES = ElementalBuildConfig.validCombatTypes
local requestThrottle = RequestThrottle.new(300)
local missionDetailThrottle = RequestThrottle.new(50)

local function buildElementsPayload()
    local elementsPayload = {}

    for _, element in ipairs(ElementalBuildConfig.elements) do
        elementsPayload[#elementsPayload + 1] = {
            combatType  = element.combatType,
            key         = element.key,
            name        = element.name,
            description = element.description,
        }
    end

    return elementsPayload
end

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

local function missionGoldCost(missionId)
    return missionId * ElementalBuildConfig.goldCostPerMission
end

local function playerTotalGold(player)
    return player:getMoney() + player:getBankBalance()
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

    local goldCost = missionGoldCost(missionId)
    itemsPayload[#itemsPayload + 1] = {
        clientId = ElementalBuildConfig.goldDisplayClientId,
        name     = "Gold (backpack + bank)",
        progress = completed and goldCost or math.min(playerTotalGold(player), goldCost),
        total    = goldCost,
        isGold   = true,
    }

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

local function countDeliveredMissionItems(itemsPayload)
    local deliveredCount = 0
    for _, item in ipairs(itemsPayload) do
        if item.progress >= item.total then
            deliveredCount = deliveredCount + 1
        end
    end
    return deliveredCount
end

local function buildMissionSummary(player, missionId, currentMissionId)
    local mission = ElementalBuildConfig.missions[missionId]
    local completed = isMissionCompleted(player, missionId)
    local isCurrent = missionId == currentMissionId
    local summary = {
        id        = missionId,
        name      = mission.name,
        itemCount = #mission.items + 1,
        completed = completed,
        isCurrent = isCurrent,
        isLocked  = not completed and not isCurrent,
    }

    if isCurrent then
        summary.deliveredCount = countDeliveredMissionItems(buildMissionItemsPayload(player, mission, missionId))
    end
    return summary
end

local function buildMissionListPayload(player)
    local missionList    = {}
    local completedCount = 0
    local currentMissionId = buildCurrentMissionId(player)

    for missionId in ipairs(ElementalBuildConfig.missions) do
        local summary = buildMissionSummary(player, missionId, currentMissionId)
        if summary.completed then
            completedCount = completedCount + 1
        end
        missionList[#missionList + 1] = summary
    end

    return missionList, completedCount
end

local MAX_DROP_SOURCES_PER_ITEM = 4
local LOOT_CHANCE_SCALE = 1000
local cachedDropSources = nil

local function collectMissionItemIds()
    local missionItemIds = {}
    for _, mission in ipairs(ElementalBuildConfig.missions) do
        for _, item in ipairs(mission.items) do
            missionItemIds[item.itemId] = true
        end
    end
    return missionItemIds
end

local function isRegularCreature(monsterType)
    if monsterType:raceId() == 0 then
        return false
    end
    if monsterType:isRewardBoss() then
        return false
    end
    return monsterType:bossRaceId() == 0
end

local function registerLootChances(lootList, missionItemIds, monsterName, sourcesByItemId)
    for _, lootEntry in ipairs(lootList) do
        if missionItemIds[lootEntry.itemId] and lootEntry.chance > 0 then
            local itemSources = sourcesByItemId[lootEntry.itemId] or {}
            local previousChance = itemSources[monsterName] or 0
            itemSources[monsterName] = math.max(previousChance, lootEntry.chance)
            sourcesByItemId[lootEntry.itemId] = itemSources
        end
        registerLootChances(lootEntry.childLoot or {}, missionItemIds, monsterName, sourcesByItemId)
    end
end

local function formatLootChance(chance)
    local percent = string.format("%.2f", chance / LOOT_CHANCE_SCALE):gsub("0+$", ""):gsub("%.$", "")
    return percent .. "%"
end

local function rankDropSources(itemSources)
    local rankedSources = {}
    for monsterName, chance in pairs(itemSources) do
        rankedSources[#rankedSources + 1] = { name = monsterName, chance = chance }
    end
    table.sort(rankedSources, function(left, right)
        if left.chance == right.chance then
            return left.name < right.name
        end
        return left.chance > right.chance
    end)

    local formattedSources = {}
    for index = 1, math.min(MAX_DROP_SOURCES_PER_ITEM, #rankedSources) do
        local source = rankedSources[index]
        formattedSources[index] = source.name .. " (" .. formatLootChance(source.chance) .. ")"
    end
    return formattedSources
end

local function buildDropSources()
    if cachedDropSources then
        return cachedDropSources
    end

    local missionItemIds = collectMissionItemIds()
    local sourcesByItemId = {}
    for _, monsterType in pairs(Game.getMonsterTypes()) do
        if isRegularCreature(monsterType) then
            registerLootChances(monsterType:getLoot() or {}, missionItemIds, monsterType:name(), sourcesByItemId)
        end
    end

    cachedDropSources = {}
    for itemId, itemSources in pairs(sourcesByItemId) do
        cachedDropSources[tostring(itemId)] = rankDropSources(itemSources)
    end
    return cachedDropSources
end

local function sendFullState(player)
    local missionList, completedCount = buildMissionListPayload(player)

    player:sendExtendedOpcode(ELEMENTALBUILD_OPCODE, json.encode({
        action          = "data",
        pointsCap       = ELEMENTAL_BUILD_CAP,
        damageRatio     = ELEMENTAL_BUILD_DAMAGE_RATIO,
        elements        = buildElementsPayload(),
        availablePoints = player:getElementalBuildAvailablePoints(),
        investedPoints  = buildInvestedPointsPayload(player),
        missions        = missionList,
        completedCount  = completedCount,
        totalCount      = #ElementalBuildConfig.missions,
    }))
end

local function buildMissionDropSources(mission)
    local allDropSources = buildDropSources()
    local missionDropSources = {}
    for _, item in ipairs(mission.items) do
        local itemKey = tostring(item.clientId)
        missionDropSources[itemKey] = allDropSources[tostring(item.itemId)]
    end
    return missionDropSources
end

local function sendMissionDetail(player, missionId)
    local mission = ElementalBuildConfig.missions[missionId]
    if not mission then
        return
    end

    local detail = buildMissionSummary(player, missionId, buildCurrentMissionId(player))
    detail.description = mission.description
    detail.points = mission.points
    detail.items = buildMissionItemsPayload(player, mission, missionId)

    player:sendExtendedOpcode(ELEMENTALBUILD_OPCODE, json.encode({
        action      = "missionDetail",
        mission     = detail,
        dropSources = buildMissionDropSources(mission),
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

    local goldCost = missionGoldCost(missionId)
    if playerTotalGold(player) < goldCost then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need " .. FormatNumber(goldCost) .. " gold (backpack + bank) to complete this mission.")
        sendMissionResult(player, false, missionId)
        return
    end

    if not player:removeMoneyBank(goldCost) then
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

    if data.action == "missionDetail" then
        if not missionDetailThrottle:isThrottled(player) then
            sendMissionDetail(player, tonumber(data.missionId))
        end
        return true
    end

    if requestThrottle:isThrottled(player) then
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