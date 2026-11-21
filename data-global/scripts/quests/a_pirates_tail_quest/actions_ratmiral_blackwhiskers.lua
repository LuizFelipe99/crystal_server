local ratmiralPosition = Position(33904, 31349, 14)
local arenaEntrancePosition = Position(33906, 31355, 14)

local config = {
	boss = {
		name = "Ratmiral Blackwhiskers",
		createFunction = function()
			return Game.createMonster("Ratmiral Blackwhiskers", ratmiralPosition, true, true) ~= nil
		end,
	},
	requiredLevel = 150,
	playerPositions = {
		{ pos = Position(33893, 31388, 15), teleport = arenaEntrancePosition, effect = CONST_ME_TELEPORT },
		{ pos = Position(33894, 31388, 15), teleport = arenaEntrancePosition, effect = CONST_ME_TELEPORT },
		{ pos = Position(33895, 31388, 15), teleport = arenaEntrancePosition, effect = CONST_ME_TELEPORT },
		{ pos = Position(33896, 31388, 15), teleport = arenaEntrancePosition, effect = CONST_ME_TELEPORT },
		{ pos = Position(33897, 31388, 15), teleport = arenaEntrancePosition, effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(33887, 31342, 13),
		to = Position(33921, 31375, 15),
	},
	centerRoom = Position(33902, 31370, 15),

	exit = Position(33891, 31197, 7),

	onUseExtra = function(player)
		local specPos = {
			from = Position(33887, 31342, 13),
			to = Position(33921, 31375, 15),
		}

		local itemsToRemove = { 35686, 5542 }

		for x = specPos.from.x, specPos.to.x do
			for y = specPos.from.y, specPos.to.y do
				for z = specPos.from.z, specPos.to.z do
					local tile = Tile(Position(x, y, z))
					if tile then
						for _, itemId in ipairs(itemsToRemove) do
							local item = tile:getItemById(itemId)
							if item then
								item:remove()
							end
						end
					end
				end
			end
		end

		return true
	end,
}

local lever = BossLever(config)
lever:position(Position(33892, 31388, 15))
lever:register()
