local config = {
	entrance = Position(32953, 32398, 9),
	destination = Position(34070, 31975, 14),
}

local accessBlood = MoveEvent()
function accessBlood.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	if player:getLevel() < 250 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need at least level 250 to enter.")
		player:teleportTo(fromPosition, true)
		return false
	end

	if config.entrance == position then
		player:teleportTo(config.destination)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end

	return true
end

accessBlood:type("stepin")
accessBlood:position(config.entrance)
accessBlood:register()

local leaveBlood = MoveEvent()
function leaveBlood.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	player:teleportTo(Position(32955, 32398, 9))
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

leaveBlood:type("stepin")
leaveBlood:position(Position(34070, 31974, 14))
leaveBlood:register()
