local destinationPosition = Position(32814, 32754, 9)

local asuraMirror = Action()

function asuraMirror.onUse(player, item, fromPosition, itemEx, toPosition)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:teleportTo(destinationPosition)
	destinationPosition:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

asuraMirror:aid(4910)
asuraMirror:register()
