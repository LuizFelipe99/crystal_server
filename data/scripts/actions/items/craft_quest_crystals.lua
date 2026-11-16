local ALREADY_COLLECTED_MESSAGE = "You have already taken the relic from this crystal."
local NO_CAPACITY_MESSAGE = "You do not have enough room or capacity to take the relic."

local rewardByUniqueId = {
    [30110] = { storageKey = 50001, itemId = 63401, rewardName = "a golden ruby crafter nv. 4" },
    [30111] = { storageKey = 50002, itemId = 63400, rewardName = "a platinum ruby crafter nv. 4" },
    [30112] = { storageKey = 50003, itemId = 51955, rewardName = "a super stone shower rune" },
}

local itemRewardAction = Action()

function itemRewardAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local reward = rewardByUniqueId[item:getUniqueId()]

    if not reward then
        return false
    end

    if player:getStorageValue(reward.storageKey) ~= -1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, ALREADY_COLLECTED_MESSAGE)
        return true
    end

    local createdItem = Game.createItem(reward.itemId, 1)
    if not createdItem then
        return false
    end

    if player:addItemEx(createdItem) ~= RETURNVALUE_NOERROR then
        player:sendCancelMessage(NO_CAPACITY_MESSAGE)
        createdItem:remove()
        return true
    end

    player:setStorageValue(reward.storageKey, item:getUniqueId())
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You found " .. reward.rewardName .. ". Bring it to the Master Artisan.")
    toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    return true
end

itemRewardAction:uid(30110)
itemRewardAction:uid(30111)
itemRewardAction:uid(30112)
itemRewardAction:register()