BattlePassConfig = {
    opcode      = 10,
    storageBase = 90000,

    season = {
        id        = 1,
        name      = "Season 1",
        startDate = "01/07/26",
        endDate   = "15/07/26",
        totalDays = 15
    },

    missions = {
        [1] = {
            description = "Deliver 20x Silver Token",
            itemId      = 22516,
            amount      = 20,
            freeRewards = {
                { itemId = 3043, amount = 100, label = "100x Crystal Coin" },
                { itemId = 36728, amount = 1, label = "Bestiary Betterment" },
                { itemId = 37110, amount = 1, label = "Exalted Core" },
            },
            proRewards = {
                { itemId = 51588, amount = 1, label = "Proficiency Catalyst" },
                { itemId = 36724, amount = 1, label = "Strike Enhancement" },
                { itemId = 51952, amount = 2000, label = "Super Avalanche Rune" },
                { itemId = 37110, amount = 2, label = "Exalted Core" },
                { itemId = 36725, amount = 1, label = "Stamina Extension" },
                { itemId = 60414, amount = 1, label = "Timira Bag" },
                { itemId = 60863, amount = 1, label = "Upgrade Build Stone" },
            }
        },
        [2] = {
            description = "Deliver 20x Gold Token",
            itemId      = 22721,
            amount      = 20,
            freeRewards = {
                { itemId = 3043, amount = 75, label = "Crystal Coin" },
                { itemId = 37110, amount = 2, label = "Exalted Core" },
                { itemId = 36729, amount = 2, label = "Fire Resilience" },
            },
            proRewards = {
                { itemId = 51951, amount = 2000, label = "Super Great Fireball Rune" },
                { itemId = 36725, amount = 1, label = "Stamina Extension" },
                { itemId = 51589, amount = 1, label = "Greater Proficiency Catalyst" },
                { itemId = 36729, amount = 2, label = "Fire Resilience" },
                { itemId = 36730, amount = 2, label = "Ice Resilience" },
            }
        },
        [3] = {
            description = "Deliver 100x Demonic Essence",
            itemId      = 6499,
            amount      = 100,
            freeRewards = {
                { itemId = 3043, amount = 50, label = "Crystal Coin" },
                { itemId = 36731, amount = 2, label = "Earth Resilience" },
                { itemId = 37110, amount = 1, label = "Exalted Core" },
            },
            proRewards = {
                { itemId = 51955, amount = 2000, label = "Super Stone Shower Runes" },
                { itemId = 36727, amount = 1, label = "Wealth Duplex" },
                { itemId = 36731, amount = 2, label = "Earth Resilience" },
                { itemId = 36732, amount = 2, label = "Energy Resilience" },
                { itemId = 63060, amount = 5, label = "Roulete Coin" },
                { itemId = 60863, amount = 1, label = "Upgrade Build Stone" },
            }
        },
        [4] = {
            description = "Deliver 10x Wooden Spellbook",
            itemId      = 25699,
            amount      = 10,
            freeRewards = {
                { itemId = 63060, amount = 2, label = "Roulete Coin" },
                { itemId = 36733, amount = 1, label = "Holy Resilience" },
                { itemId = 51953, amount = 500, label = "Super Thunderstorm Runes" },
            },
            proRewards = {
                { itemId = 51953, amount = 2000, label = "Super Thunderstorm Runes" },
                { itemId = 36733, amount = 2, label = "Holy Resilience" },
                { itemId = 36734, amount = 2, label = "Death Resilience" },
                { itemId = 36735, amount = 2, label = "Physical Resilience" },
                { itemId = 37110, amount = 3, label = "Exalted Core" },
            }
        },
        [5] = {
            description = "Deliver 10x Dragon Shield",
            itemId      = 3416,
            amount      = 10,
            freeRewards = {
                { itemId = 63060, amount = 1, label = "Roulete Coin" },
                { itemId = 36736, amount = 1, label = "Fire Amplification" },
                { itemId = 3043, amount = 50, label = "Crystal Coin" },
            },
            proRewards = {
                { itemId = 51954, amount = 2000, label = "Super Sudden Death Runes" },
                { itemId = 36736, amount = 2, label = "Fire Amplification" },
                { itemId = 36737, amount = 2, label = "Ice Amplification" },
                { itemId = 51589, amount = 1, label = "Greater Proficiency Catalyst" },
                { itemId = 37110, amount = 3, label = "Exalted Core" },
                { itemId = 60863, amount = 1, label = "Upgrade Build Stone" },
            }
        },
        [6] = {
            description = "Deliver 15x Life Crystal",
            itemId      = 3061,
            amount      = 15,
            freeRewards = {
                { itemId = 3043, amount = 50, label = "Crystal Coin" },
                { itemId = 63060, amount = 1, label = "Roulete Coin" },
                { itemId = 36738, amount = 1, label = "Earth Amplification" },
            },
            proRewards = {
                { itemId = 60422, amount = 1, label = "Scroll 7 days premium" },
                { itemId = 34109, amount = 1, label = "Bag You Desire" },
                { itemId = 51588, amount = 1, label = "Proficiency Catalyst" },
                { itemId = 36738, amount = 2, label = "Earth Amplification" },
                { itemId = 36739, amount = 2, label = "Energy Amplification" },
            }
        },
        [7] = {
            description = "Deliver 15x Dragon Hammer",
            itemId      = 3322,
            amount      = 15,
            freeRewards = {
                { itemId = 3043, amount = 50, label = "Crystal Coin" },
                { itemId = 36740, amount = 1, label = "Holy Amplification" },
                { itemId = 18339, amount = 1, label = "Zaoan Chess Box" },
            },
            proRewards = {
                { itemId = 51955, amount = 2000, label = "Super Stone Shower Runes" },
                { itemId = 36740, amount = 2, label = "Holy Amplification" },
                { itemId = 36741, amount = 2, label = "Death Amplification" },
                { itemId = 36742, amount = 2, label = "Physical Amplification" },
                { itemId = 60863, amount = 1, label = "Upgrade Build Stone" },
            }
        },
        [8] = {
            description = "Deliver 1x Lion Rod",
            itemId      = 34151,
            amount      = 1,
            freeRewards = {
                { itemId = 63060, amount = 1, label = "Roulete Coin" },
                { itemId = 63400, amount = 5, label = "Platinum Ruby Crafter" },
                { itemId = 36742, amount = 2, label = "Physical Amplification" },
            },
            proRewards = {
                { itemId = 51953, amount = 2000, label = "Super Thunderstorm Runes" },
                { itemId = 63401, amount = 5, label = "Golden Ruby Crafter" },
                { itemId = 18339, amount = 1, label = "Zaoan Chess Box" },
                { itemId = 36724, amount = 1, label = "Strike Enhancement" },
                { itemId = 36728, amount = 1, label = "Bestiary Betterment" },
            }
        },
        [9] = {
            description = "Deliver 2x Roulete Coin",
            itemId      = 63060,
            amount      = 2,
            freeRewards = {
                { itemId = 3043, amount = 50, label = "Crystal Coin" },
                { itemId = 22721, amount = 10, label = "Gold Token" },
                { itemId = 22516, amount = 1, label = "Silver Token" },
            },
            proRewards = {
                { itemId = 51954, amount = 2000, label = "Super Sudden Death Runes" },
                { itemId = 63400, amount = 5, label = "Platinum Ruby Crafter" },
                { itemId = 36742, amount = 2, label = "Physical Amplification" },
                { itemId = 63401, amount = 5, label = "Golden Ruby Crafter" },
                { itemId = 36728, amount = 1, label = "Bestiary Betterment" },
                { itemId = 60863, amount = 1, label = "Upgrade Build Stone" },
            }
        },
        [10] = {
            description = "Deliver 5x Blood Herbs",
            itemId      = 3734,
            amount      = 5,
            freeRewards = {
                { itemId = 3043, amount = 50, label = "Crystal Coin" },
                { itemId = 64484, amount = 1, label = "Addon Casket" },
                { itemId = 60404, amount = 1, label = "More Points Wheel" },
            },
            proRewards = {
                { itemId = 63060, amount = 2, label = "Roulete Coin" },
                { itemId = 64485, amount = 1, label = "Mount Casket" },
                { itemId = 64484, amount = 1, label = "Addon Casket" },
                { itemId = 60410, amount = 1, label = "Falcon Bag" },
                { itemId = 60404, amount = 1, label = "More Points Wheel" },
                { itemId = 63400, amount = 5, label = "Platinum Ruby Crafter" },
            }
        },
        [11] = {
            description = "Deliver 100x Talons",
            itemId      = 3034,
            amount      = 100,
            freeRewards = {
                { itemId = 3043, amount = 50, label = "Crystal Coin" },
                { itemId = 60411, amount = 1, label = "Lion Bag" },
                { itemId = 63401, amount = 2, label = "Golden Ruby Crafter" },
            },
            proRewards = {
                { itemId = 51955, amount = 2000, label = "Super Stone Shower Runes" },
                { itemId = 64484, amount = 1, label = "Addon Casket" },
                { itemId = 64485, amount = 1, label = "Mount Casket" },
                { itemId = 63060, amount = 2, label = "Roulete Coin" },
                { itemId = 36729, amount = 2, label = "Fire Resilience" },
                { itemId = 60863, amount = 1, label = "Upgrade Build Stone" },
            }
        },
        [12] = {
            description = "Deliver 50x Yellow Gems",
            itemId      = 3037,
            amount      = 50,
            freeRewards = {
                { itemId = 63060, amount = 1, label = "Roulete Coin" },
                { itemId = 36729, amount = 2, label = "Fire Resilience" },
                { itemId = 63401, amount = 1, label = "Golden Ruby Crafter" },
            },
            proRewards = {
                { itemId = 51953, amount = 2000, label = "Super Thunderstorm Runes" },
                { itemId = 36730, amount = 2, label = "Ice Resilience" },
                { itemId = 36731, amount = 2, label = "Earth Resilience" },
                { itemId = 60404, amount = 1, label = "More Points Wheel" },
                { itemId = 51588, amount = 1, label = "Proficiency Catalyst" },
            }
        },
        [13] = {
            description = "Deliver 50x Red Gems",
            itemId      = 3039,
            amount      = 50,
            freeRewards = {
                { itemId = 63060, amount = 1, label = "Roulete Coin" },
                { itemId = 36727, amount = 1, label = "Wealth Duplex" },
                { itemId = 36728, amount = 1, label = "Bestiary Betterment" },
            },
            proRewards = {
                { itemId = 51954, amount = 2000, label = "Super Sudden Death Runes" },
                { itemId = 36727, amount = 1, label = "Wealth Duplex" },
                { itemId = 36728, amount = 1, label = "Bestiary Betterment" },
                { itemId = 37110, amount = 2, label = "Exalted Core" },
                { itemId = 36726, amount = 1, label = "Charm Upgrade" },
                { itemId = 60863, amount = 1, label = "Upgrade Build Stone" },
            }
        },
        [14] = {
            description = "Deliver 15x Demon Horn",
            itemId      = 5954,
            amount      = 15,
            freeRewards = {
                { itemId = 3043, amount = 50, label = "Crystal Coin" },
                { itemId = 36725, amount = 1, label = "Stamina Extension" },
                { itemId = 64485, amount = 1, label = "Mount Casket" },
            },
            proRewards = {
                { itemId = 51954, amount = 2000, label = "Super Sudden Death Runes" },
                { itemId = 36725, amount = 1, label = "Stamina Extension" },
                { itemId = 36724, amount = 1, label = "Strike Enhancement" },
                { itemId = 36736, amount = 1, label = "Fire Amplification" },
                { itemId = 36738, amount = 1, label = "Earth Amplification" },
            }
        },
        [15] = {
            description = "Deliver 10x Roulete Token",
            itemId      = 63060,
            amount      = 10,
            freeRewards = {
                { itemId = 3043, amount = 50, label = "Crystal Coin" },
                { itemId = 36725, amount = 1, label = "Stamina Extension" },
                { itemId = 64484, amount = 1, label = "Addon Casket" },
            },
            proRewards = {
                { itemId = 51954, amount = 2000, label = "Super Sudden Death Runes" },
                { itemId = 36725, amount = 1, label = "Stamina Extension" },
                { itemId = 36724, amount = 1, label = "Strike Enhancement" },
                { itemId = 36736, amount = 1, label = "Fire Amplification" },
                { itemId = 64485, amount = 1, label = "Mount Casket" },
                { itemId = 60863, amount = 1, label = "Upgrade Build Stone" },
            }
        }
    },

    finalReward = {
        itemId = 63365,
        amount = 1,
        label  = "Ironlord Backpack"
    }
}

BattlePassStorage = {
    currentDay = BattlePassConfig.storageBase + (BattlePassConfig.season.id * 1000),
    isVip      = BattlePassConfig.storageBase + (BattlePassConfig.season.id * 1000) + 100,
    dayStatus  = function(day)
        return BattlePassConfig.storageBase + (BattlePassConfig.season.id * 1000) + day
    end
}

BATTLEPASS_STATUS_PENDING   = 0
BATTLEPASS_STATUS_DELIVERED = 1
BATTLEPASS_STATUS_CLAIMED   = 2