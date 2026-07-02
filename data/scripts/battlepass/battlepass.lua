local json = dofile("data/libs/dkjson.lua")

local function buildDayPreview(player, currentDay, selectedDay, isVip)
    local mission    = BattlePassConfig.missions[selectedDay]
    local isCurrentDay = selectedDay == currentDay

    if not mission then return nil end

    local rawStatus = player:getStorageValue(BattlePassStorage.dayStatus(selectedDay))
    local dayStatus = rawStatus < 0 and BATTLEPASS_STATUS_PENDING or rawStatus

    local itemCount  = isCurrentDay and player:getItemCount(mission.itemId) or 0
    local canDeliver = isCurrentDay and dayStatus == BATTLEPASS_STATUS_PENDING and itemCount >= mission.amount
    local canClaimPro = isCurrentDay and dayStatus == BATTLEPASS_STATUS_DELIVERED and isVip

    local freeRewardStatus
    if not isCurrentDay then
        freeRewardStatus = dayStatus >= BATTLEPASS_STATUS_CLAIMED and "Claimed" or "Locked"
    elseif dayStatus == BATTLEPASS_STATUS_PENDING then
        freeRewardStatus = canDeliver and "Deliver" or "Locked"
    else
        freeRewardStatus = "Claimed"
    end

    local proRewardStatus
    if not isVip then
        proRewardStatus = "Be VIP"
    elseif not isCurrentDay then
        proRewardStatus = dayStatus >= BATTLEPASS_STATUS_CLAIMED and "Claimed" or "Locked"
    elseif dayStatus == BATTLEPASS_STATUS_PENDING then
        proRewardStatus = "Locked"
    elseif dayStatus == BATTLEPASS_STATUS_DELIVERED then
        proRewardStatus = "Claim"
    else
        proRewardStatus = "Claimed"
    end

    local dayStatusText
    if not isCurrentDay then
        local isFuture = selectedDay > currentDay
        dayStatusText = isFuture and "Complete previous days first" or "Completed"
    elseif canDeliver then
        dayStatusText = "Deliver items"
    elseif canClaimPro then
        dayStatusText = "Claim Pro Reward"
    elseif dayStatus == BATTLEPASS_STATUS_CLAIMED then
        dayStatusText = "Completed"
    else
        dayStatusText = "Collect the required items"
    end

    local dayLabel = "DAY " .. selectedDay
    if isCurrentDay then
        dayLabel = dayLabel .. " (CURRENT)"
    elseif selectedDay < currentDay then
        dayLabel = dayLabel .. " (DONE)"
    else
        dayLabel = dayLabel .. " (LOCKED)"
    end

    return {
        selectedDayLabel    = dayLabel,
        selectedDaySubtitle = canDeliver and "Ready to deliver!" or "Collect the required items",
        missionItemId       = mission.itemId,
        missionDescription  = mission.description,
        missionProgress     = isCurrentDay
            and ("You have: " .. itemCount .. "/" .. mission.amount)
            or  ("Required: " .. mission.amount),
        freeRewardItemId    = mission.freeReward.itemId,
        freeRewardLabel     = mission.freeReward.label,
        freeRewardStatus    = freeRewardStatus,
        proRewardItemId     = mission.proReward.itemId,
        proRewardLabel      = mission.proReward.label,
        proRewardStatus     = proRewardStatus,
        dayStatusText       = dayStatusText,
    }
end

local function buildPlayerState(player, selectedDay)
    local currentDay = math.max(1, player:getStorageValue(BattlePassStorage.currentDay))
    local isVip      = player:getStorageValue(BattlePassStorage.isVip) == 1

    selectedDay = selectedDay or currentDay

    if selectedDay < 1 or selectedDay > BattlePassConfig.season.totalDays then
        selectedDay = currentDay
    end

    local dayPreview = buildDayPreview(player, currentDay, selectedDay, isVip)
    if not dayPreview then return nil end

    local days = {}
    for day = 1, BattlePassConfig.season.totalDays do
        local data = BattlePassConfig.missions[day]
        if data then
            local rawS   = player:getStorageValue(BattlePassStorage.dayStatus(day))
            local status = rawS < 0 and BATTLEPASS_STATUS_PENDING or rawS
            days[#days + 1] = {
                number     = day,
                isSelected = day == selectedDay,
                itemId    = data.itemId,
                isCurrent = day == currentDay,
                isDone    = status >= BATTLEPASS_STATUS_CLAIMED,
                label     = status >= BATTLEPASS_STATUS_CLAIMED
                    and "Done"
                    or (day == currentDay and "Current" or "-")
            }
        end
    end

    return {
        action            = "data",
        seasonName        = BattlePassConfig.season.name,
        dateRange         = BattlePassConfig.season.startDate .. " - " .. BattlePassConfig.season.endDate,
        currentDay        = currentDay,
        totalDays         = BattlePassConfig.season.totalDays,
        completedMissions = currentDay - 1,
        totalMissions     = BattlePassConfig.season.totalDays,
        progressPct       = math.floor(((currentDay - 1) / BattlePassConfig.season.totalDays) * 100),
        freeProgress      = (currentDay - 1) .. "/" .. BattlePassConfig.season.totalDays,
        proProgress       = (currentDay - 1) .. "/" .. BattlePassConfig.season.totalDays,
        days              = days,
        finalRewardItemId = BattlePassConfig.finalReward.itemId,
        finalRewardLabel  = BattlePassConfig.finalReward.label,
        dayCounterText    = currentDay .. "/" .. BattlePassConfig.season.totalDays .. " Days",
        isVip             = isVip,

        selectedDayLabel    = dayPreview.selectedDayLabel,
        selectedDaySubtitle = dayPreview.selectedDaySubtitle,
        missionItemId       = dayPreview.missionItemId,
        missionDescription  = dayPreview.missionDescription,
        missionProgress     = dayPreview.missionProgress,
        freeRewardItemId    = dayPreview.freeRewardItemId,
        freeRewardLabel     = dayPreview.freeRewardLabel,
        freeRewardStatus    = dayPreview.freeRewardStatus,
        proRewardItemId     = dayPreview.proRewardItemId,
        proRewardLabel      = dayPreview.proRewardLabel,
        proRewardStatus     = dayPreview.proRewardStatus,
        dayStatusText       = dayPreview.dayStatusText,
    }
end

local function handleRequest(player, selectedDay)
    local state = buildPlayerState(player, selectedDay)
    if not state then return end
    player:sendExtendedOpcode(BattlePassConfig.opcode, json.encode(state))
end

local function handleDeliver(player)
    local currentDay = math.max(1, player:getStorageValue(BattlePassStorage.currentDay))
    local mission    = BattlePassConfig.missions[currentDay]
    local isVip      = player:getStorageValue(BattlePassStorage.isVip) == 1

    if not mission then return end

    local rawStatus = player:getStorageValue(BattlePassStorage.dayStatus(currentDay))
    local dayStatus = rawStatus < 0 and BATTLEPASS_STATUS_PENDING or rawStatus

    if dayStatus ~= BATTLEPASS_STATUS_PENDING then return end

    if player:getItemCount(mission.itemId) < mission.amount then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You don't have enough items.")
        return
    end

    player:removeItem(mission.itemId, mission.amount)
    player:addItem(mission.freeReward.itemId, mission.freeReward.amount)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Free reward granted: " .. mission.freeReward.label)

    if not isVip then
        player:setStorageValue(BattlePassStorage.dayStatus(currentDay), BATTLEPASS_STATUS_CLAIMED)
        player:setStorageValue(BattlePassStorage.currentDay, math.min(currentDay + 1, BattlePassConfig.season.totalDays))
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Day " .. currentDay .. " completed!")
    else
        player:setStorageValue(BattlePassStorage.dayStatus(currentDay), BATTLEPASS_STATUS_DELIVERED)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can now claim your Pro reward!")
    end

    handleRequest(player, currentDay)
end

local function handleClaimPro(player)
    local currentDay = math.max(1, player:getStorageValue(BattlePassStorage.currentDay))
    local mission    = BattlePassConfig.missions[currentDay]
    local isVip      = player:getStorageValue(BattlePassStorage.isVip) == 1

    if not mission then return end

    if not isVip then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need VIP to claim Pro rewards.")
        return
    end

    local rawStatus = player:getStorageValue(BattlePassStorage.dayStatus(currentDay))
    local dayStatus = rawStatus < 0 and BATTLEPASS_STATUS_PENDING or rawStatus

    if dayStatus ~= BATTLEPASS_STATUS_DELIVERED then return end

    player:addItem(mission.proReward.itemId, mission.proReward.amount)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Pro reward granted: " .. mission.proReward.label)

    player:setStorageValue(BattlePassStorage.dayStatus(currentDay), BATTLEPASS_STATUS_CLAIMED)
    player:setStorageValue(BattlePassStorage.currentDay, math.min(currentDay + 1, BattlePassConfig.season.totalDays))
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Day " .. currentDay .. " completed!")

    handleRequest(player, currentDay)
end

local battlepassEvent = CreatureEvent("BattlePassOpcode")
battlepassEvent:type("extendedopcode")

battlepassEvent:onExtendedOpcode(function(player, opcode, buffer)
    if opcode ~= BattlePassConfig.opcode then
        return true
    end

    local data, pos, err = json.decode(buffer)

    if err or not data or not data.action then
        return true
    end

    if data.action == "request" then
        handleRequest(player, data.day)
    elseif data.action == "deliver" then
        handleDeliver(player)
    elseif data.action == "deliverPro" then
        handleClaimPro(player)
    end

    return true
end)

battlepassEvent:register()

local loginEvent = CreatureEvent("BattlePassLogin")
loginEvent:type("login")

loginEvent:onLogin(function(player)
    player:registerEvent("BattlePassOpcode")
    return true
end)

loginEvent:register()