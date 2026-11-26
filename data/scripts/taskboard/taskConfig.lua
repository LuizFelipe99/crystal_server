local taskTokenItemId = 64465

local taskDifficulties = {
	easy = { killsMultiplier = 1, rewardMultiplier = 1, tokenChance = 50, tokenCount = 1 },
	medium = { killsMultiplier = 1, rewardMultiplier = 1, tokenChance = 85, tokenCount = 1 },
	hard = { killsMultiplier = 6, rewardMultiplier = 6, tokenChance = 100, tokenCount = 2 }
}

local configMonsterTasks = {
	{
		id = 1,
		displayName = "Rat",
		monsterNames = { "Rat" },
		difficulties = { "easy" },
		baseKillsRequired = 50,
		baseRewards = {
			expReward = 100000,
			itemRewards = {
				{ itemId = 3043, count = 2 }
			}
		}
	},
	{
		id = 18,
		displayName = "Rotworm",
		monsterNames = { "Rotworm" },
		difficulties = { "easy" },
		baseKillsRequired = 50,
		baseRewards = {
			expReward = 110000,
			itemRewards = {
				{ itemId = 3043, count = 2 }
			}
		}
	},
	{
		id = 15,
		displayName = "Minotaur",
		monsterNames = { "Minotaur", "Minotaur Guard", "Minotaur Archer", "Minotaur Mage" },
		difficulties = { "easy" },
		baseKillsRequired = 100,
		baseRewards = {
			expReward = 210000,
			itemRewards = {
				{ itemId = 3043, count = 3 }
			}
		}
	},
	{
		id = 7,
		displayName = "Elf",
		monsterNames = { "Elf", "Elf Arcanist", "Elf Scout" },
		difficulties = { "easy" },
		baseKillsRequired = 300,
		baseRewards = {
			expReward = 580000,
			itemRewards = {
				{ itemId = 3043, count = 3 }
			}
		}
	},
	{
		id = 10,
		displayName = "Ghoul",
		monsterNames = { "Ghoul" },
		difficulties = { "easy" },
		baseKillsRequired = 50,
		baseRewards = {
			expReward = 146400,
			itemRewards = {
				{ itemId = 3043, count = 3 }
			}
		}
	},
	{
		id = 14,
		displayName = "Kongra",
		monsterNames = { "Kongra", "Sibang", "Merlkin" },
		difficulties = { "easy" },
		baseKillsRequired = 100,
		baseRewards = {
			expReward = 240000,
			itemRewards = {
				{ itemId = 3043, count = 5 }
			}
		}
	},
	{
		id = 17,
		displayName = "Nomad",
		monsterNames = { "Nomad" },
		difficulties = { "easy" },
		baseKillsRequired = 50,
		baseRewards = {
			expReward = 177200,
			itemRewards = {
				{ itemId = 3043, count = 5 }
			}
		}
	},
	{
		id = 2,
		displayName = "Barbarian Headsplitter",
		monsterNames = { "Barbarian Headsplitter", "Barbarian Skullhunter" },
		difficulties = { "easy" },
		baseKillsRequired = 300,
		baseRewards = {
			expReward = 510000,
			itemRewards = {
				{ itemId = 3043, count = 5 }
			}
		}
	},
	{
		id = 3,
		displayName = "Cyclops",
		monsterNames = { "Cyclops" },
		difficulties = { "easy" },
		baseKillsRequired = 100,
		baseRewards = {
			expReward = 300000,
			itemRewards = {
				{ itemId = 3043, count = 3 }
			}
		}
	},
	{
		id = 4,
		displayName = "Deepling Warrior",
		monsterNames = { "Deepling Warrior", "Deepling Scout", "Deepling Spellsinger" },
		difficulties = { "easy" },
		baseKillsRequired = 300,
		baseRewards = {
			expReward = 5300000,
			itemRewards = {
				{ itemId = 3043, count = 5 }
			}
		}
	},
	{
		id = 5,
		displayName = "Demon",
		monsterNames = { "Demon" },
		difficulties = { "medium" },
		baseKillsRequired = 666,
		baseRewards = {
			expReward = 80000000,
			itemRewards = {
				{ itemId = 3043, count = 50 },
				{ itemId = 3388, count = 1 }
			}
		}
	},
	{
		id = 6,
		displayName = "Dragon",
		monsterNames = { "Dragon", "Dragon Lord" },
		difficulties = { "easy" },
		baseKillsRequired = 400,
		baseRewards = {
			expReward = 11000000,
			itemRewards = {
				{ itemId = 3043, count = 10 },
				{ itemId = 3322, count = 3 },
				{ itemId = 3416, count = 3 }
			}
		}
	},
	{
		id = 8,
		displayName = "Frazzlemaw",
		monsterNames = { "Frazzlemaw", "Silencer" },
		difficulties = { "easy" },
		baseKillsRequired = 300,
		baseRewards = {
			expReward = 27000000,
			itemRewards = {
				{ itemId = 3043, count = 10 }
			}
		}
	},
	{
		id = 9,
		displayName = "Frost Dragon",
		monsterNames = { "Frost Dragon", "Frost Dragon Hatchling" },
		difficulties = { "easy" },
		baseKillsRequired = 200,
		baseRewards = {
			expReward = 5700000,
			itemRewards = {
				{ itemId = 3043, count = 10 }
			}
		}
	},
	{
		id = 11,
		displayName = "Glooth Bandit",
		monsterNames = { "Glooth Bandit", "Glooth Brigand" },
		difficulties = { "easy" },
		baseKillsRequired = 700,
		baseRewards = {
			expReward = 27000000,
			itemRewards = {
				{ itemId = 3043, count = 12 }
			}
		}
	},
	{
		id = 12,
		displayName = "Hero",
		monsterNames = { "Hero", "Vicious Squire", "Renegade Knight", "Blood Priest", "Vile Grandmaster" },
		difficulties = { "easy" },
		baseKillsRequired = 500,
		baseRewards = {
			expReward = 11000000,
			itemRewards = {
				{ itemId = 3043, count = 15 },
				{ itemId = 3385, count = 1 },
				{ itemId = 3381, count = 1 },
				{ itemId = 3382, count = 1 }
			}
		}
	},
	{
		id = 13,
		displayName = "Hydra",
		monsterNames = { "Hydra" },
		difficulties = { "easy" },
		baseKillsRequired = 650,
		baseRewards = {
			expReward = 27000000,
			itemRewards = {
				{ itemId = 3043, count = 15 },
				{ itemId = 3079, count = 1 }
			}
		}
	},
	{
		id = 16,
		displayName = "Nightmare",
		monsterNames = { "Nightmare", "Nightmare Scion" },
		difficulties = { "easy" },
		baseKillsRequired = 600,
		baseRewards = {
			expReward = 19000000,
			itemRewards = {
				{ itemId = 3043, count = 20 }
			}
		}
	},
	{
		id = 19,
		displayName = "Skeleton Warrior",
		monsterNames = { "Skeleton Warrior" },
		difficulties = { "easy" },
		baseKillsRequired = 300,
		baseRewards = {
			expReward = 556000,
			itemRewards = {
				{ itemId = 3043, count = 15 }
			}
		}
	},
	{
		id = 20,
		displayName = "Spiky Carnivor",
		monsterNames = { "Spiky Carnivor", "Lumbering Carnivor", "Menacing Carnivor" },
		difficulties = { "easy" },
		baseKillsRequired = 300,
		baseRewards = {
			expReward = 10000000,
			itemRewards = {
				{ itemId = 3043, count = 20 }
			}
		}
	},
	{
		id = 21,
		displayName = "Stonerefiner",
		monsterNames = { "Stonerefiner" },
		difficulties = { "easy" },
		baseKillsRequired = 450,
		baseRewards = {
			expReward = 4500000,
			itemRewards = {
				{ itemId = 3043, count = 15 }
			}
		}
	},
	{
		id = 22,
		displayName = "Werehyaena",
		monsterNames = { "Werehyaena", "Werehyaena Shaman" },
		difficulties = { "easy" },
		baseKillsRequired = 800,
		baseRewards = {
			expReward = 35000000,
			itemRewards = {
				{ itemId = 3043, count = 30 }
			}
		}
	},
	{
		id = 23,
		displayName = "Wyrm",
		monsterNames = { "Wyrm", "Elder Wyrm" },
		difficulties = { "easy" },
		baseKillsRequired = 400,
		baseRewards = {
			expReward = 16000000,
			itemRewards = {
				{ itemId = 3043, count = 10 }
			}
		}
	},
	{
		id = 24,
		displayName = "Asura",
		monsterNames = { "Dawnfire Asura", "Midnight Asura", "Hellspawn" },
		difficulties = { "medium" },
		baseKillsRequired = 900,
		baseRewards = {
			expReward = 64000000,
			itemRewards = {
				{ itemId = 3043, count = 50 }
			}
		}
	},
	{
		id = 25,
		displayName = "Falcon",
		monsterNames = { "Falcon Knight", "Falcon Paladin" },
		difficulties = { "medium" },
		baseKillsRequired = 900,
		baseRewards = {
			expReward = 110000000,
			itemRewards = {
				{ itemId = 3043, count = 50 }
			}
		}
	},
	{
		id = 26,
		displayName = "Cobra",
		monsterNames = { "Cobra Scout", "Cobra Assassin" },
		difficulties = { "medium" },
		baseKillsRequired = 900,
		baseRewards = {
			expReward = 130000000,
			itemRewards = {
				{ itemId = 3043, count = 50 }
			}
		}
	},
	{
		id = 27,
		displayName = "Lion",
		monsterNames = { "Lion Knight", "Lion Warlock" },
		difficulties = { "medium" },
		baseKillsRequired = 600,
		baseRewards = {
			expReward = 900000,
			itemRewards = {
				{ itemId = 3043, count = 25 }
			}
		}
	},
	{
		id = 28,
		displayName = "Werelion",
		monsterNames = { "Werelion", "White Lion", "Werelioness" },
		difficulties = { "medium" },
		baseKillsRequired = 1000,
		baseRewards = {
			expReward = 45000000,
			itemRewards = {
				{ itemId = 3043, count = 60 }
			}
		}
	},
	{
		id = 29,
		displayName = "Inferniarch",
		monsterNames = { "Gorger Inferniarch", "Broodrider Inferniarch", "Sineater Inferniarch" },
		difficulties = { "medium" },
		baseKillsRequired = 600,
		baseRewards = {
			expReward = 91000000,
			itemRewards = {
				{ itemId = 3043, count = 60 }
			}
		}
	},
	{
		id = 30,
		displayName = "Secret Library",
		monsterNames = { "Burning Book", "Energetic Book", "Brain Squid", "Cursed Book", "Ink Blob", "Icecold Book", "Biting Book", "Knowledge Elemental", "Rage Squid", "Guardian of Tales" },
		difficulties = { "medium" },
		baseKillsRequired = 500,
		baseRewards = {
			expReward = 130000000,
			itemRewards = {
				{ itemId = 3043, count = 40 }
			}
		}
	},
	{
		id = 31,
		displayName = "Crazed Summer",
		monsterNames = { "Crazed Summer Vanguard", "Crazed Summer Rearguard" },
		difficulties = { "medium" },
		baseKillsRequired = 600,
		baseRewards = {
			expReward = 58000000,
			itemRewards = {
				{ itemId = 3043, count = 50 }
			}
		}
	},
	{
		id = 32,
		displayName = "Crazed Winter",
		monsterNames = { "Crazed Winter Rearguard", "Crazed Winter Vanguard" },
		difficulties = { "medium" },
		baseKillsRequired = 600,
		baseRewards = {
			expReward = 61000000,
			itemRewards = {
				{ itemId = 3043, count = 50 }
			}
		}
	},
	{
		id = 33,
		displayName = "Girtablilu",
		monsterNames = { "Girtablilu Warrior", "Venerable Girtablilu" },
		difficulties = { "medium" },
		baseKillsRequired = 600,
		baseRewards = {
			expReward = 67000000,
			itemRewards = {
				{ itemId = 3043, count = 30 }
			}
		}
	},
	{
		id = 34,
		displayName = "Emerald Tortoise",
		monsterNames = { "Emerald Tortoise" },
		difficulties = { "hard" },
		baseKillsRequired = 250,
		baseRewards = {
			expReward = 61000000,
			itemRewards = {
				{ itemId = 3043, count = 50 }
			}
		}
	},
	{
		id = 35,
		displayName = "Noxious Ripptor",
		monsterNames = { "Noxious Ripptor" },
		difficulties = { "hard" },
		baseKillsRequired = 250,
		baseRewards = {
			expReward = 66000000,
			itemRewards = {
				{ itemId = 3043, count = 50 }
			}
		}
	},
	{
		id = 36,
		displayName = "Sulphider",
		monsterNames = { "Sulphider" },
		difficulties = { "hard" },
		baseKillsRequired = 250,
		baseRewards = {
			expReward = 67000000,
			itemRewards = {
				{ itemId = 3043, count = 50 }
			}
		}
	},
	{
		id = 37,
		displayName = "Darklight Source",
		monsterNames = { "Darklight Source" },
		difficulties = { "hard" },
		baseKillsRequired = 250,
		baseRewards = {
			expReward = 110000000,
			itemRewards = {
				{ itemId = 3043, count = 50 }
			}
		}
	},
	{
		id = 38,
		displayName = "Rotten Man-Maggot",
		monsterNames = { "Rotten Man-Maggot" },
		difficulties = { "hard" },
		baseKillsRequired = 250,
		baseRewards = {
			expReward = 110000000,
			itemRewards = {
				{ itemId = 3043, count = 50 }
			}
		}
	},
	{
		id = 39,
		displayName = "Bony Sea Devil",
		monsterNames = { "Bony Sea Devil" },
		difficulties = { "hard" },
		baseKillsRequired = 250,
		baseRewards = {
			expReward = 97000000,
			itemRewards = {
				{ itemId = 3043, count = 50 }
			}
		}
	},
	{
		id = 40,
		displayName = "Many Faces",
		monsterNames = { "Many Faces" },
		difficulties = { "hard" },
		baseKillsRequired = 250,
		baseRewards = {
			expReward = 94000000,
			itemRewards = {
				{ itemId = 3043, count = 50 }
			}
		}
	},
	{
		id = 41,
		displayName = "Cloak of Terror",
		monsterNames = { "Cloak of Terror" },
		difficulties = { "hard" },
		baseKillsRequired = 250,
		baseRewards = {
			expReward = 98000000,
			itemRewards = {
				{ itemId = 3043, count = 50 }
			}
		}
	},
	{
		id = 42,
		displayName = "Brachiodemon",
		monsterNames = { "Brachiodemon" },
		difficulties = { "hard" },
		baseKillsRequired = 250,
		baseRewards = {
			expReward = 79000000,
			itemRewards = {
				{ itemId = 3043, count = 50 }
			}
		}
	},
	{
		id = 43,
		displayName = "Hideous Fungus",
		monsterNames = { "Hideous Fungus" },
		difficulties = { "hard" },
		baseKillsRequired = 500,
		baseRewards = {
			expReward = 37000000,
			itemRewards = {
				{ itemId = 3043, count = 30 }
			}
		}
	},
	{
		id = 44,
		displayName = "Magma Crawler",
		monsterNames = { "Magma Crawler" },
		difficulties = { "hard" },
		baseKillsRequired = 500,
		baseRewards = {
			expReward = 39000000,
			itemRewards = {
				{ itemId = 3043, count = 30 }
			}
		}
	},
	{
		id = 45,
		displayName = "Orewalker",
		monsterNames = { "Orewalker" },
		difficulties = { "hard" },
		baseKillsRequired = 500,
		baseRewards = {
			expReward = 59000000,
			itemRewards = {
				{ itemId = 3043, count = 30 }
			}
		}
	}
}

return {
	taskTokenItemId = taskTokenItemId,
	taskDifficulties = taskDifficulties,
	configMonsterTasks = configMonsterTasks
}
