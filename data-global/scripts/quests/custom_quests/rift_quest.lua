local QUEST_STORAGE = 91002
local ALREADY_CHOSEN_MESSAGE = "Voce ja escolheu seu premio. Nao e possivel abrir outro bau."

local chestRewards = {
    [30105] = { itemId = 22727, count = 1, rewardName = "Rift Lance" },
    [30106] = { itemId = 22726, count = 1, rewardName = "Rift Shield" },
    [30107] = { itemId = 22866, count = 1, rewardName = "Rift Bow" },
    [30108] = { itemId = 22867, count = 1, rewardName = "Rift Crossbow" },
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

choiceQuest:uid(30105)
choiceQuest:uid(30106)
choiceQuest:uid(30107)
choiceQuest:uid(30108)
choiceQuest:register()