local config = {
	magicFieldId = 39232,
	chargedFlameId = 39230,
	heatedCrystalId = 39168,
	cooledCrystalId = 39169,
	bossPos = Position(33654, 32909, 15),
	timeToLeftAfterKill = 60,
}

local bossZone = Zone("boss.magma-bubble")
local spawnZone = Zone("fight.magma-bubble.spawn")

-- central area where monsters/boss spawns
spawnZone:addArea({ x = 33647, y = 32900, z = 15 }, { x = 33659, y = 32913, z = 15 })

local encounter = Encounter("Magma Bubble", {
	zone = bossZone,
	spawnZone = spawnZone,
	timeToSpawnMonsters = "2s",
})

function encounter:onReset(position)
	encounter:removeMonsters()
	bossZone:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("The Magma Bubble has been defeated. You have %i seconds to leave the room.", config.timeToLeftAfterKill))
	self:addEvent(function(zn)
		zn:refresh()
		zn:removePlayers()
	end, config.timeToLeftAfterKill * 1000, bossZone)
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

local function addShieldStack(player)
	local currentIcon = player:getIcon("magma-bubble")
	if not currentIcon or currentIcon.category ~= CreatureIconCategory_Quests or currentIcon.icon ~= CreatureIconQuests_GreenShield then
		player:setIcon("magma-bubble", CreatureIconCategory_Quests, CreatureIconQuests_GreenShield, 5)
		return true
	end
	player:setIcon("magma-bubble", CreatureIconCategory_Quests, CreatureIconQuests_GreenShield, currentIcon.count + 5)
end

local crystalsCycle = GlobalEvent("self.magma-bubble.crystals.onThink")
function crystalsCycle.onThink(interval, lastExecution)
	local zoneItems = bossZone:getItems()
	local minCooled = 2
	local crystals = {}
	for _, item in ipairs(zoneItems) do
		if item:getId() == config.cooledCrystalId or item:getId() == config.heatedCrystalId then
			table.insert(crystals, item)
		end
	end
	local shouldChange = math.random(1, 100) <= 50
	if shouldChange and #crystals > 0 then
		local item = crystals[math.random(1, #crystals)]
		local newItemId = item:getId() == config.cooledCrystalId and config.heatedCrystalId or config.cooledCrystalId
		item:transform(newItemId)
	end
	local cooledCount = 0
	local heatedCrystals = {}
	for _, item in ipairs(zoneItems) do
		if item:getId() == config.cooledCrystalId then
			cooledCount = cooledCount + 1
		elseif item:getId() == config.heatedCrystalId then
			table.insert(heatedCrystals, item)
		end
	end
	if cooledCount < minCooled then
		for _ = 1, minCooled - cooledCount do
			local index = math.random(1, #heatedCrystals)
			local item = heatedCrystals[index]
			if item then
				table.remove(heatedCrystals, index)
				item:transform(config.cooledCrystalId)
			end
		end
	end
	return true
end

crystalsCycle:interval(4000)
crystalsCycle:register()

local function randomPosition(positions)
	local destination = positions[math.random(1, #positions)]
	local tile = destination:getTile()
	while not tile or not tile:isWalkable(false, false, false, false, true) do
		destination = positions[math.random(1, #positions)]
		tile = destination:getTile()
	end
	return destination
end

local chargedFlameAction = Action()
function chargedFlameAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then
		return false
	end
	if not target or type(target) ~= "userdata" or not target:isItem() then
		return false
	end
	if target:getId() ~= config.cooledCrystalId then
		return false
	end
	target:transform(config.heatedCrystalId)
	local positions = {
		Position(toPosition.x - 1, toPosition.y, toPosition.z),
		Position(toPosition.x + 1, toPosition.y, toPosition.z),
		Position(toPosition.x, toPosition.y - 1, toPosition.z),
		Position(toPosition.x, toPosition.y + 1, toPosition.z),
		Position(toPosition.x - 1, toPosition.y - 1, toPosition.z),
		Position(toPosition.x + 1, toPosition.y + 1, toPosition.z),
		Position(toPosition.x - 1, toPosition.y + 1, toPosition.z),
		Position(toPosition.x + 1, toPosition.y - 1, toPosition.z),
	}
	local position = randomPosition(positions)
	position:sendMagicEffect(CONST_ME_FIREAREA)
	local field = Game.createItem(config.magicFieldId, 1, position)
	field:decay()
	item:remove()
end

chargedFlameAction:id(config.chargedFlameId)
chargedFlameAction:register()

local shieldField = MoveEvent()
function shieldField.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	if not encounter:isInZone(player:getPosition()) then
		return false
	end
	item:remove()
	addShieldStack(player)
end

shieldField:type("stepin")
shieldField:id(config.magicFieldId)
shieldField:register()

local theEndOfDaysHealth = CreatureEvent("fight.magma-bubble.TheEndOfDaysHealth")
function theEndOfDaysHealth.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType)
	if not creature then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	local newHealth = creature:getHealth() - primaryDamage - secondaryDamage
	if newHealth <= creature:getMaxHealth() * 0.5 then
		creature:setHealth(creature:getMaxHealth())
		encounter:spawnMonsters({ name = "Lava Creature", amount = 8 })
		return false
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

theEndOfDaysHealth:register()

local magmaCrystalDeath = CreatureEvent("fight.magma-bubble.MagmaCrystalDeath")
function magmaCrystalDeath.onDeath()
	local crystals = encounter:countMonsters("magma crystal")
	if crystals <= 1 then
		encounter:nextStage()
	else
		encounter:broadcast(MESSAGE_EVENT_ADVANCE, "A magma crystal has been destroyed! " .. crystals .. " remaining.")
	end
end

magmaCrystalDeath:register()

local endOfDaysDeath = CreatureEvent("fight.magma-bubble.TheEndOfDaysDeath")
function endOfDaysDeath.onDeath()
	local monsters = encounter:countMonsters("the end of days")
	if monsters <= 1 then
		encounter:nextStage()
	end
end

endOfDaysDeath:register()

local magmaBubbleDeath = CreatureEvent("fight.magma-bubble.MagmaBubbleDeath")
function magmaBubbleDeath.onDeath()
	encounter:reset()
end

magmaBubbleDeath:register()

local zoneEvent = ZoneEvent(bossZone)
function zoneEvent.afterEnter(_zone, creature)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	player:setIcon("magma-bubble", CreatureIconCategory_Quests, CreatureIconQuests_GreenShield, 0)
end

function zoneEvent.afterLeave(_zone, creature)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	player:removeIcon("magma-bubble")
end

zoneEvent:register()
