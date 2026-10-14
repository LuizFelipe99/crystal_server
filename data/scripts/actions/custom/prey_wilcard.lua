local preyCardAmount = 25

local preyCardAction = Action()

function preyCardAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then
		return true
	end

	local currentPreyCards = player:getPreyCards()
	if currentPreyCards + preyCardAmount >= GameStore.ItemLimit.PREY_WILDCARD + 1 then
		player:sendTextMessage(MESSAGE_FAILURE, "You cannot own more than " .. GameStore.ItemLimit.PREY_WILDCARD .. " prey wildcards.")
		return true
	end

	player:addPreyCards(preyCardAmount)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have received " .. preyCardAmount .. " prey wildcards.")
	item:remove(1)
	return true
end

preyCardAction:id(60445)
preyCardAction:register()