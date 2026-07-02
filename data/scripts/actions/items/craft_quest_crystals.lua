local ALREADY_COLLECTED_MESSAGE = "Voce ja coletou este item anteriormente."
local NO_CAPACITY_MESSAGE = "Voce nao tem espaco ou capacidade para pegar o item."

local rewardByUniqueId = {
    [30110] = { storageKey = 50001, itemId = 63401, rewardName = "Item 1" },
    [30111] = { storageKey = 50002, itemId = 63400, rewardName = "Item 2" },
    [30112] = { storageKey = 50003, itemId = 51955, rewardName = "Item 3" },
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
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou " .. reward.rewardName .. ".")
    toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    return true
end

itemRewardAction:uid(30110)
itemRewardAction:uid(30111)
itemRewardAction:uid(30112)
itemRewardAction:register()