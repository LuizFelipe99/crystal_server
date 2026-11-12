local nictrosArenaPosition = Position(33426, 31437, 13)
local baelocArenaPosition = Position(33424, 31437, 13)

local function createBrotherInArena(name, position)
	local brother = Game.createMonster(name, position, true, true)
	if not brother then
		return nil
	end
	brother:setMoveLocked(false)
	return brother
end

local config = {
	boss = {
		name = "Sir Nictros",
		createFunction = function()
			local nictros = createBrotherInArena("Sir Nictros", nictrosArenaPosition)
			if not nictros then
				return false
			end

			local baeloc = createBrotherInArena("Sir Baeloc", baelocArenaPosition)
			if not baeloc then
				return false
			end

			baeloc:say("Ah look my Brother! Challengers! Let's fight them together!")
			return true
		end,
	},
	requiredLevel = 250,
	playerPositions = {
		{ pos = Position(33424, 31413, 13), teleport = Position(33423, 31448, 13) },
		{ pos = Position(33425, 31413, 13), teleport = Position(33423, 31448, 13) },
		{ pos = Position(33426, 31413, 13), teleport = Position(33423, 31448, 13) },
		{ pos = Position(33427, 31413, 13), teleport = Position(33423, 31448, 13) },
		{ pos = Position(33428, 31413, 13), teleport = Position(33423, 31448, 13) },
	},
	specPos = {
		from = Position(33414, 31426, 13),
		to = Position(33433, 31449, 13),
	},
	exit = Position(33290, 32474, 9),
}

local lever = BossLever(config)
lever:position(Position(33423, 31413, 13))
lever:register()
