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
			expReward = 121000,
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
			expReward = 133100,
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
			expReward = 161100,
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
			expReward = 194900,
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
			expReward = 214400,
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
			expReward = 235800,
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
			expReward = 259400,
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
			expReward = 285300,
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
			expReward = 313800,
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
			expReward = 345200,
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
			expReward = 379700,
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
			expReward = 417700,
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
			expReward = 459500,
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
			expReward = 505400,
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
			expReward = 611600,
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
			expReward = 672700,
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
			expReward = 740000,
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
			expReward = 814000,
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
			expReward = 1350000,
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
			expReward = 1350000,
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
			expReward = 1350000,
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
			expReward = 1500000,
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
			expReward = 900000,
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
			expReward = 750000,
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
			expReward = 900000,
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
			expReward = 900000,
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
			expReward = 900000,
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
