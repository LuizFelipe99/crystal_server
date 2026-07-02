local battlePass = Action()

function battlePass.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    player:sendExtendedOpcode(50, "battlepass")
    player:sendTextMessage(MESSAGE_INFO_DESCR, "Enviando opcode.")
    return true
end

battlePass:id(44604)
battlePass:register()