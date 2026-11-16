local SPELL_UNLOCK_STORAGE = 91004
local CHEST_UID = 30114

local spellUnlockQuest = Action()

function spellUnlockQuest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(SPELL_UNLOCK_STORAGE) ~= -1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Have you already learned this spell.")
        return true
    end

    player:setStorageValue(SPELL_UNLOCK_STORAGE, 1)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You learning a new spell!")
    toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    return true
end

spellUnlockQuest:uid(CHEST_UID)
spellUnlockQuest:register()