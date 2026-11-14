local mType = Game.createMonsterType("Vemiath")
local monster = {}

monster.description = "Vemiath"
monster.experience = 3250000
monster.outfit = {
	lookType = 1668,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.events = {
	"RottenBloodBossDeath",
	"VemiathMechanicsDeath",
}

monster.bosstiary = {
	bossRaceId = 2365,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 350000
monster.maxHealth = 350000
monster.race = "undead"
monster.corpse = 44021
monster.speed = 100
monster.manaCost = 0

monster.changeTarget = {
	interval = 10000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 100,
	health = 0,
	damage = 0,
	random = 0,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 98,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.summon = {}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "The light... that... drains!", yell = false },
	{ text = "RAAAR!", yell = false },
	{ text = "WILL ... PUNISH ... YOU!", yell = false },
	{ text = "Darkness ... devours!", yell = false },
}

monster.summon = {}

monster.loot = {
	{ id = 43895, chance = 360, unique = true }, ---bag you covet
	{ name = "crystal coin", chance = 28852, maxCount = 99 },
	{ name = "ultimate mana potion", chance = 21337, maxCount = 211 },
	{ name = "giant emerald", chance = 26423, maxCount = 1 },
	{ name = "supreme health potion", chance = 44385, maxCount = 154 },
	{ name = "yellow gem", chance = 33000, maxCount = 4 },
	{ name = "berserk potion", chance = 28000, maxCount = 37 },
	{ name = "blue gem", chance = 33000, maxCount = 5 },
	{ name = "green gem", chance = 28000, maxCount = 4 },
	{ name = "bullseye potion", chance = 16530, maxCount = 22 },
	{ name = "mastermind potion", chance = 22700, maxCount = 31 },
	{ name = "ultimate spirit potion", chance = 19216, maxCount = 203 },
	{ name = "giant topaz", chance = 11191, maxCount = 1 },
	{ name = "giant amethyst", chance = 18527, maxCount = 1 },
	{ name = "gold ingot", chance = 20866, maxCount = 1 },
	{ id = 3039, chance = 18945, maxCount = 4 }, -- red gem
	{ name = "dragon figurine", chance = 19502, maxCount = 1 },
	{ name = "raw watermelon tourmaline", chance = 19302, maxCount = 1 },
	{ name = "vemiath's infused basalt", chance = 28000, maxCount = 1 },
	{ name = "violet gem", chance = 11100, maxCount = 3 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -1300, maxDamage = -1600 },
	{ name = "chagorzring", interval = 2000, chance = 25, minDamage = -3200, maxDamage = -4000, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_MANADRAIN, minDamage = -100, maxDamage = -500, range = 7, radius = 6, effect = 18, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -100, maxDamage = -500, radius = 6, effect = 18, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_MANADRAIN, minDamage = -100, maxDamage = -500, radius = 6, effect = 32, target = false },
	{ name = "speed", interval = 2000, chance = 20, speedChange = -1600, radius = 7, effect = 20, target = false, duration = 20000 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_DEATHDAMAGE, minDamage = -1500, maxDamage = -2000, length = 8, spread = 0, effect = 221, target = false },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -1000, length = 8, spread = 0, effect = 18, target = false },
}

monster.defenses = {
	defense = 305,
	armor = 305,
	mitigation = 7.16,
	{ name = "combat", interval = 3000, chance = 15, type = COMBAT_HEALING, minDamage = 4700, maxDamage = 6500, effect = 249, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 15 },
	{ type = COMBAT_FIREDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE, percent = 15 },
	{ type = COMBAT_DEATHDAMAGE, percent = 15 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

local aditionalMonsters = {
	{ name = "pillar of dark energy" },
	{ name = "pillar of dark energy" },
	{ name = "pillar of dark energy" },
	{ name = "pillar of dark energy" },
}
local ElderBloodjaws = {
	{ name = "Elder Bloodjaw" },
	{ name = "Elder Bloodjaw" },
}

local accumulatedTime = 0
local summonInterval = 0
local activeSummons = {}

local function getRandomPosition(monsterPosition)
	local offsetX = math.random(-1, 1)
	local offsetY = math.random(-1, 1)
	local offsetZ = monsterPosition.z

	return Position(monsterPosition.x + offsetX, monsterPosition.y + offsetY, offsetZ)
end

local function getClosePosition(centerPos)
	local tries = 10
	for i = 1, tries do
		local offsetX = math.random(-1, 1)
		local offsetY = math.random(-1, 1)
		local tryPos = Position(centerPos.x + offsetX, centerPos.y + offsetY, centerPos.z)
		local tile = Tile(tryPos)
		if tile and tile:isWalkable() then
			return tryPos
		end
	end
	return centerPos
end

local bossStates = {}

local function getPlayerTaintLevel(player)
	local kv = player:kv():scoped("rotten-blood-quest")
	local currentTaintKV = kv:get("taints") or 0
	local currentTaintCondition = 0
	local taintCondition = player:getCondition(CONDITION_BAKRAGORE, CONDITIONID_DEFAULT)
	if taintCondition then
		currentTaintCondition = taintCondition:getParameter(CONDITION_PARAM_SUBID) or 0
	end
	return math.max(currentTaintKV, currentTaintCondition)
end

local function calculateElderBloodjawCount()
	local centerPos = Position(33043, 32335, 15)
	local maxTaintLevel = 0
	local spectators = Game.getSpectators(centerPos, false, true, 15, 15, 15, 15)

	for _, player in ipairs(spectators) do
		if player:isPlayer() then
			local taintLevel = getPlayerTaintLevel(player)
			maxTaintLevel = math.max(maxTaintLevel, taintLevel)
		end
	end

	local baseCount = 2
	local extraCount = 0

	if maxTaintLevel >= 5 then
		extraCount = extraCount + 1
	end
	if maxTaintLevel >= 8 then
		extraCount = extraCount + 1
	end
	if maxTaintLevel >= 9 then
		extraCount = extraCount + 1
	end

	return math.min(baseCount + extraCount, 5)
end

local function areMechanicsDisabled()
	return GlobalRottenBloodStates and GlobalRottenBloodStates["Vemiath"] and GlobalRottenBloodStates["Vemiath"].mechanicsDisabled or false
end

local function initializeBoss()
	if not bossStates["Vemiath"] then
		bossStates["Vemiath"] = {}
	end
	bossStates["Vemiath"].mechanicsDisabled = false

	local function startTeleportCycle()
		bossStates["Vemiath"].teleportTimer = addEvent(function()
			local centerPos = Position(33043, 32335, 15)

			if Game.getStorageValue("VemiathTeleportPaused") == 1 then
				logger.debug("Vemiath teleport system paused, skipping cycle")
				startTeleportCycle()
				return
			end

			local spectators = Game.getSpectators(centerPos, false, false, 15, 15, 15, 15)
			local bossAlive = false
			local elderBloodjawExists = false

			for _, creature in ipairs(spectators) do
				if creature:isMonster() then
					if creature:getName() == "Vemiath" then
						bossAlive = true
					elseif creature:getName():lower() == "elder bloodjaw" then
						elderBloodjawExists = true
					end
				end
			end

			if not bossAlive then
				return
			end

			if elderBloodjawExists then
				local teleport = Game.createItem(37000, 1, centerPos)
				if teleport then
					teleport:setActionId(50001)
					centerPos:sendMagicEffect(CONST_ME_TELEPORT)
					logger.debug("Teleport created for Vemiath with ActionId {}", teleport:getActionId())

					addEvent(function()
						local tile = Tile(centerPos)
						if tile then
							local item = tile:getItemById(37000)
							if item then
								item:remove()
							end
						end
					end, 15000)
				end
			else
				logger.debug("No Elder Bloodjaw found, skipping teleport creation for Vemiath")
			end

			startTeleportCycle()
		end, 90000)
	end

	startTeleportCycle()
end

local function cleanupBoss()
	if bossStates["Vemiath"] then
		if bossStates["Vemiath"].teleportTimer then
			stopEvent(bossStates["Vemiath"].teleportTimer)
		end
		bossStates["Vemiath"] = nil
	end

	if GlobalRottenBloodStates and GlobalRottenBloodStates["Vemiath"] then
		if GlobalRottenBloodStates["Vemiath"].teleportTimer then
			stopEvent(GlobalRottenBloodStates["Vemiath"].teleportTimer)
		end
		GlobalRottenBloodStates["Vemiath"] = nil
	end
end

local function ensureSummons(monster)
	local pos = monster:getPosition()
	local radiusX, radiusY = 17, 17

	local existingBloodjaws = 0
	local existingPillarDark = 0

	for _, cid in ipairs(Game.getSpectators(pos, false, false, radiusX, radiusX, radiusY, radiusY)) do
		if cid:isMonster() then
			local name = cid:getName():lower()
			if name == "elder bloodjaw" then
				existingBloodjaws = existingBloodjaws + 1
			elseif name == "pillar of dark energy" then
				existingPillarDark = existingPillarDark + 1
			end
		end
	end

	if not areMechanicsDisabled() and Game.getStorageValue("VemiathElderBloodjawSpawnPaused") ~= 1 then
		local targetCount = calculateElderBloodjawCount()
		for i = 1, targetCount - existingBloodjaws do
			local summonPos = getClosePosition(pos)
			Game.createMonster("Elder Bloodjaw", summonPos)
		end
	else
		logger.debug("Vemiath mechanics disabled or Elder Bloodjaw spawn paused, not spawning Elder Bloodjaw")
	end

	for i = 1, 4 - existingPillarDark do
		local summonPos = getClosePosition(pos)
		Game.createMonster("pillar of dark energy", summonPos)
	end
end

local playerTracking = {}
local checkInterval = 1000
local checkTime = 0

local bossInitialized = false

mType.onThink = function(monster, interval) end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature) end

mType.onMove = function(_, creature, fromPos, toPos) end

mType.onSay = function(monster, creature, type, message) end

mType:register(monster)
