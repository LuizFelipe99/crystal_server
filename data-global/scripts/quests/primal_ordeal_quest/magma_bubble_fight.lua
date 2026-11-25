local config = {
	bossPos = Position(33654, 32909, 15),
}

local bossZone = Zone("boss.magma-bubble")
local spawnZone = Zone("fight.magma-bubble.spawn")

spawnZone:addArea({ x = 33647, y = 32900, z = 15 }, { x = 33659, y = 32913, z = 15 })

local encounter = Encounter("Magma Bubble", {
	zone = bossZone,
	spawnZone = spawnZone,
	timeToSpawnMonsters = "2s",
})

function encounter:onReset(position)
	encounter:removeMonsters()
end

encounter:addRemoveMonsters():autoAdvance()
encounter:addBroadcast("You've entered the volcano."):autoAdvance("1s")

encounter:addSpawnMonsters({
	{
		name = "Magma Bubble",
		event = "fight.magma-bubble.MagmaBubbleDeath",
		positions = { config.bossPos },
	},
})

encounter:register()

local magmaBubbleDeath = CreatureEvent("fight.magma-bubble.MagmaBubbleDeath")
function magmaBubbleDeath.onDeath()
	encounter:reset()
end

magmaBubbleDeath:register()
