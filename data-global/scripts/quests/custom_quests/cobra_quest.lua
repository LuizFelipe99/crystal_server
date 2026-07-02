local QUEST_STORAGE = 91001
local ALREADY_CHOSEN_MESSAGE = "Voce ja escolheu seu premio. Nao e possivel abrir outro bau."

local chestRewards = {
    [30101] = { itemId = 30400, count = 1, rewardName = "Cobra Rod" },
    [30102] = { itemId = 30398, count = 1, rewardName = "Cobra Sword" },
    [30103] = { itemId = 30399, count = 1, rewardName = "Cobra Wand" },
    [30104] = { itemId = 30393, count = 1, rewardName = "Cobra Crossbow" },
}

local choiceQuest = Action()

function choiceQuest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local chestUid = item:getUniqueId()
    local reward = chestRewards[chestUid]

    if not reward then
        return false
    end

    if player:getStorageValue(QUEST_STORAGE) ~= -1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, ALREADY_CHOSEN_MESSAGE)
        return true
    end

    local createdItem = Game.createItem(reward.itemId, reward.count)
    if not createdItem then
        return false
    end

    if player:addItemEx(createdItem) ~= RETURNVALUE_NOERROR then
        player:sendCancelMessage("Voce nao tem espaco ou capacidade para pegar o premio.")
        createdItem:remove()
        return true
    end

    player:setStorageValue(QUEST_STORAGE, chestUid)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou " .. reward.rewardName .. ".")
    toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    return true
end

choiceQuest:uid(30101)
choiceQuest:uid(30102)
choiceQuest:uid(30103)
choiceQuest:uid(30104)
choiceQuest:register()