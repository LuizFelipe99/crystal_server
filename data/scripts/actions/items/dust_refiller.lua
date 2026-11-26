local DUST_REFILLER_ITEM_ID = 60238

local dustRefiller = Action()

function dustRefiller.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local maximumDust = player:getForgeDustLevel()
	local currentDust = player:getForgeDusts()
	if currentDust >= maximumDust then
		player:sendTextMessage(MESSAGE_FAILURE, "Your dust is already full.")
		return true
	end

	if not item:remove(1) then
		return true
	end

	player:setForgeDusts(maximumDust)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Your dust has been refilled to %d.", maximumDust))
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	return true
end

dustRefiller:id(DUST_REFILLER_ITEM_ID)
dustRefiller:register()
