local json = dofile("data/libs/dkjson.lua")

local DAILY_UNLOCK_HOUR = 0
local NEXT_DAY_UNLOCK_KEY = "next-day-unlock"
local requestThrottle = RequestThrottle.new(300)

local function battlePassStore(player)
    return player:kv():scoped("battlepass")
end

local function calculateNextUnlockTimestamp()
    local now = os.time()
    local unlockMoment = os.date("*t", now)
    unlockMoment.hour = DAILY_UNLOCK_HOUR
    unlockMoment.min = 0
    unlockMoment.sec = 0
    local unlockTimestamp = os.time(unlockMoment)
    if unlockTimestamp <= now then
        unlockMoment.day = unlockMoment.day + 1
        unlockTimestamp = os.time(unlockMoment)
    end
    return unlockTimestamp
end

local function secondsUntilNextDay(player)
    local unlockTimestamp = battlePassStore(player):get(NEXT_DAY_UNLOCK_KEY) or 0
    return math.max(0, unlockTimestamp - os.time())
end

local function isWaitingForNextDay(player)
    return secondsUntilNextDay(player) > 0
end

local function describeWaitTime(remainingSeconds)
    local hours = math.floor(remainingSeconds / 3600)
    local minutes = math.ceil((remainingSeconds % 3600) / 60)
    if minutes == 60 then
        hours = hours + 1
        minutes = 0
    end
    if hours == 0 then
        return minutes .. "m"
    end
    return hours .. "h " .. minutes .. "m"
end

local function completeCurrentDay(player, currentDay)
    player:setStorageValue(BattlePassStorage.dayStatus(currentDay), BATTLEPASS_STATUS_CLAIMED)
    player:setStorageValue(BattlePassStorage.currentDay, math.min(currentDay + 1, BattlePassConfig.season.totalDays))
    if currentDay >= BattlePassConfig.season.totalDays then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Day " .. currentDay .. " completed! You finished the battle pass.")
        return
    end

    battlePassStore(player):set(NEXT_DAY_UNLOCK_KEY, calculateNextUnlockTimestamp())
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Day " .. currentDay .. " completed! The next day unlocks tomorrow.")
end

local function mapRewardsToPayload(rewards)
    local payload = {}
    for index, reward in ipairs(rewards) do
        payload[index] = { itemId = reward.itemId, amount = reward.amount, name = reward.label }
    end
    return payload
end

local function grantRewardList(player, rewards)
    for _, reward in ipairs(rewards) do
        player:addItem(reward.itemId, reward.amount)
    end
end

local function describeRewardList(rewards)
    local labels = {}
    for _, reward in ipairs(rewards) do
        labels[#labels + 1] = reward.label
    end
    return table.concat(labels, ", ")
end

local function resolveRawDayStatus(player, day)
    local raw = player:getStorageValue(BattlePassStorage.dayStatus(day))
    return raw < 0 and BATTLEPASS_STATUS_PENDING or raw
end

local function resolveFreeRewardStatus(isCurrentDay, dayStatus, canDeliver)
    if not isCurrentDay then
        return dayStatus >= BATTLEPASS_STATUS_CLAIMED and "Claimed" or "Locked"
    end
    if dayStatus == BATTLEPASS_STATUS_PENDING then
        return canDeliver and "Deliver" or "Locked"
    end
    return "Claimed"
end

local function resolveProRewardStatus(isVip, isCurrentDay, dayStatus)
    if not isVip then
        return "Be VIP"
    end
    if not isCurrentDay then
        return dayStatus >= BATTLEPASS_STATUS_CLAIMED and "Claimed" or "Locked"
    end
    if dayStatus == BATTLEPASS_STATUS_PENDING then
        return "Locked"
    end
    if dayStatus == BATTLEPASS_STATUS_DELIVERED then
        return "Claim"
    end
    return "Claimed"
end

local function resolveDayStatusText(isCurrentDay, selectedDay, currentDay, canDeliver, canClaimPro, dayStatus, waitSeconds)
    if not isCurrentDay then
        return selectedDay > currentDay and "Complete previous days first" or "Completed"
    end
    if waitSeconds > 0 and dayStatus == BATTLEPASS_STATUS_PENDING then
        return "Unlocks in " .. describeWaitTime(waitSeconds)
    end
    if canDeliver then
        return "Deliver items"
    end
    if canClaimPro then
        return "Claim Pro Reward"
    end
    if dayStatus == BATTLEPASS_STATUS_CLAIMED then
        return "Completed"
    end
    return "Collect the required items"
end

local function resolvePrimaryAction(canDeliver, canClaimPro)
    if canClaimPro then
        return "deliverPro"
    end
    if canDeliver then
        return "deliver"
    end
    return nil
end

local function resolveDayLabel(selectedDay, currentDay)
    if selectedDay == currentDay then
        return "DAY " .. selectedDay .. " (CURRENT)"
    end
    if selectedDay < currentDay then
        return "DAY " .. selectedDay .. " (DONE)"
    end
    return "DAY " .. selectedDay .. " (LOCKED)"
end

local function buildDayPreview(player, currentDay, selectedDay, isVip)
    local mission      = BattlePassConfig.missions[selectedDay]
    local isCurrentDay = selectedDay == currentDay

    if not mission then
        return nil
    end

    local dayStatus   = resolveRawDayStatus(player, selectedDay)
    local waitSeconds = secondsUntilNextDay(player)
    local itemCount   = isCurrentDay and player:getItemCount(mission.itemId) or 0
    local canDeliver  = isCurrentDay and dayStatus == BATTLEPASS_STATUS_PENDING and itemCount >= mission.amount and waitSeconds == 0
    local canClaimPro = isCurrentDay and dayStatus == BATTLEPASS_STATUS_DELIVERED and isVip

    return {
        selectedDayLabel   = resolveDayLabel(selectedDay, currentDay),
        missionItemId      = mission.itemId,
        missionDescription = mission.description,
        missionProgress    = isCurrentDay
            and ("You have: " .. itemCount .. "/" .. mission.amount)
            or  ("Required: " .. mission.amount),
        freeRewards        = mapRewardsToPayload(mission.freeRewards),
        freeRewardStatus   = resolveFreeRewardStatus(isCurrentDay, dayStatus, canDeliver),
        proRewards         = mapRewardsToPayload(mission.proRewards),
        proRewardStatus    = resolveProRewardStatus(isVip, isCurrentDay, dayStatus),
        dayStatusText      = resolveDayStatusText(isCurrentDay, selectedDay, currentDay, canDeliver, canClaimPro, dayStatus, waitSeconds),
        missionItemCount   = itemCount,
        missionAmount      = mission.amount,
        canDeliver         = canDeliver,
        canClaimPro        = canClaimPro,
        primaryAction      = resolvePrimaryAction(canDeliver, canClaimPro),
    }
end

local function buildDayList(player, currentDay, selectedDay)
    local dayList = {}

    for dayNumber = 1, BattlePassConfig.season.totalDays do
        local mission = BattlePassConfig.missions[dayNumber]
        if mission then
            local dayStatus = resolveRawDayStatus(player, dayNumber)
            dayList[#dayList + 1] = {
                number    = dayNumber,
                itemId    = mission.itemId,
                isCurrent = dayNumber == currentDay,
                isDone    = dayStatus >= BATTLEPASS_STATUS_CLAIMED,
                label     = dayStatus >= BATTLEPASS_STATUS_CLAIMED and "Done"
                    or (dayNumber == currentDay and "Current" or "-")
            }
        end
    end

    return dayList
end

local function buildPlayerState(player, selectedDay)
    local currentDay = math.max(1, player:getStorageValue(BattlePassStorage.currentDay))
    local isVip      = player:getStorageValue(BattlePassStorage.isVip) == 1

    selectedDay = selectedDay or currentDay

    if selectedDay < 1 or selectedDay > BattlePassConfig.season.totalDays then
        selectedDay = currentDay
    end

    local dayPreview = buildDayPreview(player, currentDay, selectedDay, isVip)

    if not dayPreview then
        return nil
    end

    local completedDays = currentDay - 1

    return {
        action             = "data",
        seasonName         = BattlePassConfig.season.name,
        dateRange          = BattlePassConfig.season.startDate .. " - " .. BattlePassConfig.season.endDate,
        currentDay         = currentDay,
        totalDays          = BattlePassConfig.season.totalDays,
        completedMissions  = completedDays,
        totalMissions      = BattlePassConfig.season.totalDays,
        progressPct        = math.floor((completedDays / BattlePassConfig.season.totalDays) * 100),
        freeProgress       = completedDays .. "/" .. BattlePassConfig.season.totalDays,
        proProgress        = completedDays .. "/" .. BattlePassConfig.season.totalDays,
        days               = buildDayList(player, currentDay, selectedDay),
        finalRewardItemId  = BattlePassConfig.finalReward.itemId,
        finalRewardLabel   = BattlePassConfig.finalReward.label,
        dayCounterText     = currentDay .. "/" .. BattlePassConfig.season.totalDays .. " Days",
        isVip              = isVip,
        selectedDay        = selectedDay,
        selectedDayLabel   = dayPreview.selectedDayLabel,
        missionItemId      = dayPreview.missionItemId,
        missionDescription = dayPreview.missionDescription,
        missionProgress    = dayPreview.missionProgress,
        freeRewards        = dayPreview.freeRewards,
        freeRewardStatus   = dayPreview.freeRewardStatus,
        proRewards         = dayPreview.proRewards,
        proRewardStatus    = dayPreview.proRewardStatus,
        dayStatusText      = dayPreview.dayStatusText,
        missionItemCount   = dayPreview.missionItemCount,
        missionAmount      = dayPreview.missionAmount,
        canDeliver         = dayPreview.canDeliver,
        canClaimPro        = dayPreview.canClaimPro,
        primaryAction      = dayPreview.primaryAction,
    }
end

local function sendStateToPlayer(player, selectedDay)
    local state = buildPlayerState(player, selectedDay)
    if not state then
        return
    end
    player:sendExtendedOpcode(BattlePassConfig.opcode, json.encode(state))
end

local function handleRequest(player, selectedDay)
    sendStateToPlayer(player, selectedDay)
end

local function handleDeliver(player)
    local currentDay = math.max(1, player:getStorageValue(BattlePassStorage.currentDay))
    local mission    = BattlePassConfig.missions[currentDay]
    local isVip      = player:getStorageValue(BattlePassStorage.isVip) == 1

    if not mission then
        return
    end

    local dayStatus = resolveRawDayStatus(player, currentDay)

    if dayStatus ~= BATTLEPASS_STATUS_PENDING then
        return
    end

    if isWaitingForNextDay(player) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Day " .. currentDay .. " unlocks in " .. describeWaitTime(secondsUntilNextDay(player)) .. ".")
        sendStateToPlayer(player, currentDay)
        return
    end

    if player:getItemCount(mission.itemId) < mission.amount then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You don't have enough items.")
        return
    end

    player:removeItem(mission.itemId, mission.amount)
    grantRewardList(player, mission.freeRewards)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Free reward granted: " .. describeRewardList(mission.freeRewards))

    if not isVip then
        completeCurrentDay(player, currentDay)
    else
        player:setStorageValue(BattlePassStorage.dayStatus(currentDay), BATTLEPASS_STATUS_DELIVERED)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can now claim your Pro reward!")
    end

    sendStateToPlayer(player, currentDay)
end

local function handleClaimPro(player)
    local currentDay = math.max(1, player:getStorageValue(BattlePassStorage.currentDay))
    local mission    = BattlePassConfig.missions[currentDay]
    local isVip      = player:getStorageValue(BattlePassStorage.isVip) == 1

    if not mission then
        return
    end

    if not isVip then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need VIP to claim Pro rewards.")
        return
    end

    local dayStatus = resolveRawDayStatus(player, currentDay)

    if dayStatus ~= BATTLEPASS_STATUS_DELIVERED then
        return
    end

    grantRewardList(player, mission.proRewards)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Pro reward granted: " .. describeRewardList(mission.proRewards))

    completeCurrentDay(player, currentDay)

    sendStateToPlayer(player, currentDay)
end

local function onExtendedOpcodeReceived(player, opcode, buffer)
    if opcode ~= BattlePassConfig.opcode then
        return true
    end

    local data, _, err = json.decode(buffer)

    if err or not data or not data.action then
        return true
    end

    if requestThrottle:isThrottled(player) then
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
end

local battlepassOpcodeEvent = CreatureEvent("BattlePassOpcode")
battlepassOpcodeEvent:type("extendedopcode")
battlepassOpcodeEvent:onExtendedOpcode(onExtendedOpcodeReceived)
battlepassOpcodeEvent:register()

local battlepassLoginEvent = CreatureEvent("BattlePassLogin")
battlepassLoginEvent:type("login")

battlepassLoginEvent:onLogin(function(player)
    player:registerEvent("BattlePassOpcode")
    return true
end)

battlepassLoginEvent:register()