local mType = Game.createMonsterType("Black Dragon")
local monster = {}

monster.description = "an black dragon"
monster.experience = 20044
monster.outfit = {
	lookType = 2776,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2695
monster.Bestiary = {
	class = "Dragon",
	race = BESTY_RACE_DRAGON,
	toKill = 6000,
	FirstUnlock = 200,
	SecondUnlock = 500,
	CharmsPoints = 100,
	Stars = 5,
	Occurrence = 0,
	Locations = "Hard Hunt on Dragon Castle",
}


monster.health = 28000
monster.maxHealth = 28000
monster.race = "blood"
monster.corpse = 5973
monster.speed = 300
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 0,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 1200,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "FCHHHHH", yell = true },
	{ text = "GROOAAARRR", yell = true },
}

monster.loot = {
	{ name = "gold coin", chance = 89920, maxCount = 102 },
	{ name = "dragon ham", chance = 66270, maxCount = 2 },
	{ name = "steel shield", chance = 15650 },
	{ name = "dragon's tail", chance = 9680 },
	{ name = "crossbow", chance = 9120 },
	{ id = 3449, chance = 8060, maxCount = 10 }, -- burst arrow
	{ name = "longsword", chance = 3830 },
	{ name = "steel helmet", chance = 3490 },
	{ name = "broadsword", chance = 2700 },
	{ name = "plate legs", chance = 2029 },
	{ name = "double axe", chance = 1580 },
	{ name = "strong health potion", chance = 1130 },
	{ name = "green dragon leather", chance = 1070 },
	{ name = "green dragon scale", chance = 1010 },
	{ name = "wand of inferno", chance = 560 },
	{ name = "small diamond", chance = 450 },
	{ name = "serpent sword", chance = 230 },
	{ name = "dragon hammer", chance = 330 },
	{ name = "dragonbone staff", chance = 170 },
	{ name = "life crystal", chance = 170 },
	{ name = "dragon shield", chance = 210 },
}


monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1650 },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_FIREDAMAGE, minDamage = -1250, maxDamage = -1550, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -900, maxDamage = -1300, length = 8, spread = 3, effect = CONST_ME_FIREAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -1000, maxDamage = -1350, radius = 4, effect = CONST_ME_MORTAREA, target = false },
	{ name = "death chain", interval = 2000, chance = 20, minDamage = -1100, maxDamage = -1380, target = true },
}

monster.defenses = {
	defense = 120,
	armor = 120,
	mitigation = 3.33,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 40 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -20 },
	{ type = COMBAT_HOLYDAMAGE, percent = -25 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
