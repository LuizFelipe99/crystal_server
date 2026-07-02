local CRAFT_UNLOCK_STORAGE = 91003
local CHEST_UID = 30109

local craftUnlockQuest = Action()

function craftUnlockQuest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(CRAFT_UNLOCK_STORAGE) ~= -1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja resgatou essa recompensa.")
        return true
    end

    player:setStorageValue(CRAFT_UNLOCK_STORAGE, 1)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce desbloqueou acesso ao Craft Bench!")
    toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    return true
end

craftUnlockQuest:uid(CHEST_UID)
craftUnlockQuest:register()