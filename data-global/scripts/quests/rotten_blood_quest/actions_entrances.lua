local entrances = {
	{ position = Position(34092, 31978, 14), destination = Position(33842, 31651, 13) },
	{ position = Position(33842, 31650, 13), destination = Position(34092, 31979, 14) },
	{ position = Position(33905, 31693, 15), destination = Position(32971, 32368, 15) },

	{ position = Position(34093, 32009, 14), destination = Position(33809, 31815, 13) },
	{ position = Position(33809, 31814, 13), destination = Position(34092, 32009, 14) },
	{ position = Position(33902, 31881, 15), destination = Position(33071, 32370, 15) },

	{ position = Position(34117, 32010, 15), destination = Position(34119, 31876, 14) },
	{ position = Position(34119, 31875, 14), destination = Position(34118, 32010, 15) },
	{ position = Position(34002, 31820, 15), destination = Position(33071, 32336, 15) },
}

local function findEntrance(position)
	for _, entrance in ipairs(entrances) do
		if entrance.position == position then
			return entrance
		end
	end
	return nil
end

local rottenBloodEntrances = Action()

function rottenBloodEntrances.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local entrance = findEntrance(item:getPosition())
	if not entrance then
		return false
	end

	player:teleportTo(entrance.destination)
	entrance.destination:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

for _, entrance in ipairs(entrances) do
	rottenBloodEntrances:position(entrance.position)
end
rottenBloodEntrances:register()
