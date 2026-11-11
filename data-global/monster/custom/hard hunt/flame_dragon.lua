local mType = Game.createMonsterType("Flame Dragon")
local monster = {}

monster.description = "an flame dragon"
monster.experience = 21044
monster.outfit = {
	lookType = 2784,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2696
monster.Bestiary = {
	class = "Dragon",
	race = BESTY_RACE_DRAGON,
	toKill = 6000,
	FirstUnlock = 200,
	SecondUnlock = 2000,
	CharmsPoints = 100,
	Stars = 5,
	Occurrence = 0,
	Locations = "Hard Hunt on Dragon Castle",
}


monster.health = 31000
monster.maxHealth = 31000
monster.race = "blood"
monster.corpse = 5984
monster.speed = 200
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
	{ name = "dragon hammer", chance = 230 },
	{ name = "dragonbone staff", chance = 170 },
	{ name = "life crystal", chance = 170 },
	{ name = "dragon shield", chance = 110 },
}


monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1850 },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -1150, maxDamage = -1650, range = 7, radius = 4, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_FIREDAMAGE, minDamage = -1100, maxDamage = -1500, length = 8, spread = 3, effect = CONST_ME_FIREAREA, target = false },
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
