ElementalBuildConfig = {
    opcode          = 14,
    storageBase     = 70000,
    damageRatio     = 1.0,
    pointsCap       = 500,
    goldCostPerMission  = 1000000,
    goldDisplayClientId = 3043,

    cycle = {
        id    = 1,
        year  = 2025,
        month = 7,
    },

    missions = {
        [1] = {
            name        = "Demonic Offering",
            description = "Hunt down cursed relics forged in dragon fire and devil steel to complete this dark offering.",
            points      = 1,
            items       = {
                { itemId = 3322, clientId = 3322, name = "Dragon Hammer", amount = 20 },
                { itemId = 3356, clientId = 3356, name = "Devil Helmet", amount = 20 },
                { itemId = 3385, clientId = 3385, name = "Crown Helmet", amount = 20 },
                { itemId = 3373, clientId = 3373, name = "Strange Helmet", amount = 20 },
                { itemId = 3416, clientId = 3416, name = "Dragon Shield", amount = 20 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [2] = {
            name        = "Warrior's Arsenal",
            description = "Bring back battle-worn weapons and armor from fallen warriors and hunters across the land.",
            points      = 1,
            items       = {
                { itemId = 7438, clientId = 7438, name = "Elvish Bow", amount = 20 },
                { itemId = 8043, clientId = 8043, name = "Focus Cape", amount = 20 },
                { itemId = 3344, clientId = 3344, name = "Beastslayer Axe", amount = 20 },
                { itemId = 3318, clientId = 3318, name = "Knight Axe", amount = 20 },
                { itemId = 3369, clientId = 3369, name = "Warrior Helmet", amount = 20 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [3] = {
            name        = "Relics of Old",
            description = "Deliver ancient weapons of dragon bone and battle-forged steel to prove your combat prowess.",
            points      = 1,
            items       = {
                { itemId = 7430, clientId = 7430, name = "Dragonbone Staff",   amount = 20  },
                { itemId = 3415, clientId = 3415, name = "Guardian Shield",   amount = 20  },
                { itemId = 21175,clientId = 21175, name = "Mino Shield",   amount = 20  },
                { itemId = 3280, clientId = 3280, name = "Fire Sword",   amount = 20  },
                { itemId = 3370, clientId = 3370, name = "Knight Armor",   amount = 20  },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [4] = {
            name        = "Frostbound Regalia",
            description = "Collect the frost-forged garments and arcane tomes hidden within the glacier's icy depths.",
            points      = 1,
            items       = {
                { itemId = 819, clientId = 819, name = "Glacier Shoes",   amount = 20  },
                { itemId = 823, clientId = 823, name = "Glacier Kilt",   amount = 20  },
                { itemId = 824, clientId = 824, name = "Glacier Robe",   amount = 20  },
                { itemId = 8072, clientId = 8072, name = "Spellbook of Enlightenment",   amount = 20  },
                { itemId = 3324, clientId = 3324, name = "Skull Staff",   amount = 20  },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [5] = {
            name        = "Molten Regalia",
            description = "Retrieve the molten regalia of the Magma set, forged deep within the burning core of the earth.",
            points      = 1,
            items       = {
                { itemId = 818, clientId = 818, name = "Magma Boots",   amount = 20  },
                { itemId = 821, clientId = 821, name = "Magma Legs",   amount = 20  },
                { itemId = 826, clientId = 826, name = "Magma Coat",   amount = 20  },
                { itemId = 827, clientId = 827, name = "Magma Monocle",   amount = 20  },
                { itemId = 817, clientId = 817, name = "Magma Amulet",   amount = 20  },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [6] = {
            name        = "Earthen Ward",
            description = "Gather the earthbound relics of the Terra set, blessed by the stone spirits of the wilds.",
            points      = 1,
            items       = {
                { itemId = 813, clientId = 813, name = "Terra Boots",   amount = 20  },
                { itemId = 812, clientId = 812, name = "Terra Legs",   amount = 20  },
                { itemId = 811, clientId = 811, name = "Terra Mantle",   amount = 20  },
                { itemId = 830, clientId = 830, name = "Terra Hood",   amount = 20  },
                { itemId = 814, clientId = 814, name = "Terra Amulet",   amount = 20  },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [7] = {
            name        = "Storm's Wrath",
            description = "Seize the storm-charged pieces of the Lightning set, crackling with raw elemental energy.",
            points      = 1,
            items       = {
                { itemId = 820, clientId = 820, name = "Lightning Boots",   amount = 20  },
                { itemId = 822, clientId = 822, name = "Lightning Legs",   amount = 20  },
                { itemId = 825, clientId = 825, name = "Lightning Robe",   amount = 20  },
                { itemId = 828, clientId = 828, name = "Lightning Headband",   amount = 20  },
                { itemId = 816, clientId = 816, name = "Lightning Pendant",   amount = 20  },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [8] = {
            name        = "Foreign Steel",
            description = "Bring together gear from distant lands, from knightly steel to the exotic craft of Zaoan.",
            points      = 1,
            items       = {
                { itemId = 3371, clientId = 3371, name = "Knight Legs",   amount = 20  },
                { itemId = 3428, clientId = 3428, name = "Tower Shield",   amount = 20  },
                { itemId = 10386, clientId = 10386, name = "Zaoan Shoes",   amount = 20  },
                { itemId = 7452, clientId = 7452, name = "Spiked Squelcher",   amount = 20  },
                { itemId = 21981, clientId = 21981, name = "Oriental Shoes",   amount = 20  },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [9] = {
            name        = "Crown of Nobility",
            description = "Assemble the regal pieces of the Crown set, symbols of nobility and battlefield authority.",
            points      = 1,
            items       = {
                { itemId = 3385, clientId = 3385, name = "Crown Helmet",   amount = 20  },
                { itemId = 3381, clientId = 3381, name = "Crown Armor",   amount = 20  },
                { itemId = 3382, clientId = 3382, name = "Crown Legs",   amount = 20  },
                { itemId = 3419, clientId = 3419, name = "Crown Shield",   amount = 20  },
                { itemId = 3572, clientId = 3572, name = "Scarf ",   amount = 20  },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [10] = {
            name        = "Shield Wall",
            description = "Recover legendary shields from across the realm, each forged to withstand the fiercest of blows.",
            points      = 1,
            items       = {
                { itemId = 3436, clientId = 3436, name = "Medusa Shield",   amount = 20  },
                { itemId = 3414, clientId = 3414, name = "Mastermind Shield",   amount = 20  },
                { itemId = 3428, clientId = 3428, name = "Tower Shield",   amount = 20  },
                { itemId = 3420, clientId = 3420, name = "Demon Shield",   amount = 20  },
                { itemId = 22726, clientId = 22726, name = "Rift Shield",   amount = 20  },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [11] = {
            name        = "Grimeleech Harvest",
            description = "Strip the grimeleech of their wings, blood and cursed rods deep in the infernal caverns.",
            points      = 1,
            items       = {
                { itemId = 22730, clientId = 22730, name = "Some Grimeleech Wings", amount = 50 },
                { itemId = 6558, clientId = 6558, name = "Flask of Demonic Blood", amount = 50 },
                { itemId = 8082, clientId = 8082, name = "Underworld Rod", amount = 10 },
                { itemId = 8094, clientId = 8094, name = "Wand of Voodoo", amount = 10 },
                { itemId = 3356, clientId = 3356, name = "Devil Helmet", amount = 5 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [12] = {
            name        = "Demonic Legion",
            description = "Break the ranks of destroyers and hellspawns and claim the spoils of the demonic legion.",
            points      = 1,
            items       = {
                { itemId = 10298, clientId = 10298, name = "Metal Spike", amount = 30 },
                { itemId = 3383, clientId = 3383, name = "Dark Armor", amount = 20 },
                { itemId = 10304, clientId = 10304, name = "Hellspawn Tail", amount = 50 },
                { itemId = 3371, clientId = 3371, name = "Knight Legs", amount = 10 },
                { itemId = 6499, clientId = 6499, name = "Demonic Essence", amount = 100 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [13] = {
            name        = "Bad Dreams",
            description = "Hunt the nightmares that roam the dark and gather the remains of their haunting essence.",
            points      = 1,
            items       = {
                { itemId = 10306, clientId = 10306, name = "Essence of a Bad Dream", amount = 50 },
                { itemId = 10312, clientId = 10312, name = "Scythe Leg", amount = 30 },
                { itemId = 5944, clientId = 5944, name = "Soul Orb", amount = 50 },
                { itemId = 3432, clientId = 3432, name = "Ancient Shield", amount = 5 },
                { itemId = 6558, clientId = 6558, name = "Flask of Demonic Blood", amount = 30 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [14] = {
            name        = "Asura Treasures",
            description = "Claim the oriental treasures guarded by the asuras of the Asura Palace.",
            points      = 1,
            items       = {
                { itemId = 21974, clientId = 21974, name = "Golden Lotus Brooch", amount = 30 },
                { itemId = 21975, clientId = 21975, name = "Peacock Feather Fan", amount = 30 },
                { itemId = 21981, clientId = 21981, name = "Oriental Shoes", amount = 3 },
                { itemId = 3403, clientId = 3403, name = "Tribal Mask", amount = 10 },
                { itemId = 8074, clientId = 8074, name = "Spellbook of Mind Control", amount = 3 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [15] = {
            name        = "Scorpion Carapace",
            description = "Pierce the shells of the girtablilu and bring back their carapaces and charms.",
            points      = 1,
            items       = {
                { itemId = 36971, clientId = 36971, name = "Girtablilu Warrior Carapace", amount = 20 },
                { itemId = 36972, clientId = 36972, name = "Old Girtablilu Carapace", amount = 20 },
                { itemId = 36822, clientId = 36822, name = "Scorpion Charm", amount = 30 },
                { itemId = 16126, clientId = 16126, name = "Red Crystal Fragment", amount = 20 },
                { itemId = 8083, clientId = 8083, name = "Northwind Rod", amount = 10 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [16] = {
            name        = "Bashmu Hunt",
            description = "Track the serpentine bashmu and collect the trophies of the desert hunt.",
            points      = 1,
            items       = {
                { itemId = 36823, clientId = 36823, name = "Bashmu Feather", amount = 30 },
                { itemId = 36821, clientId = 36821, name = "Bashmu Tongue", amount = 30 },
                { itemId = 36820, clientId = 36820, name = "Bashmu Fang", amount = 20 },
                { itemId = 3315, clientId = 3315, name = "Guardian Halberd", amount = 20 },
                { itemId = 9302, clientId = 9302, name = "Sacred Tree Amulet", amount = 10 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [17] = {
            name        = "Frozen Archives",
            description = "Explore the ice section of the Secret Library and recover its frozen relics.",
            points      = 1,
            items       = {
                { itemId = 9661, clientId = 9661, name = "Frosty Heart", amount = 30 },
                { itemId = 28566, clientId = 28566, name = "Silken Bookmark", amount = 30 },
                { itemId = 28567, clientId = 28567, name = "Quill", amount = 20 },
                { itemId = 3284, clientId = 3284, name = "Ice Rapier", amount = 5 },
                { itemId = 829, clientId = 829, name = "Glacier Mask", amount = 2 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [18] = {
            name        = "Burning Archives",
            description = "Brave the fire section of the Secret Library and salvage what the flames left behind.",
            points      = 1,
            items       = {
                { itemId = 7451, clientId = 7451, name = "Shadow Sceptre", amount = 20 },
                { itemId = 826, clientId = 826, name = "Magma Coat", amount = 10 },
                { itemId = 827, clientId = 827, name = "Magma Monocle", amount = 5 },
                { itemId = 3124, clientId = 3124, name = "Burnt Scroll", amount = 30 },
                { itemId = 2848, clientId = 2848, name = "Purple Tome", amount = 10 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [19] = {
            name        = "Overgrown Archives",
            description = "Cleanse the earth section of the Secret Library of its cursed and biting books.",
            points      = 1,
            items       = {
                { itemId = 28569, clientId = 28569, name = "Book Page", amount = 30 },
                { itemId = 3084, clientId = 3084, name = "Protection Amulet", amount = 20 },
                { itemId = 7387, clientId = 7387, name = "Diamond Sceptre", amount = 10 },
                { itemId = 830, clientId = 830, name = "Terra Hood", amount = 5 },
                { itemId = 813, clientId = 813, name = "Terra Boots", amount = 3 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [20] = {
            name        = "Charged Archives",
            description = "Discharge the energy section of the Secret Library and secure its crackling artifacts.",
            points      = 1,
            items       = {
                { itemId = 9663, clientId = 9663, name = "Piece of Dead Brain", amount = 30 },
                { itemId = 23523, clientId = 23523, name = "Energy Ball", amount = 10 },
                { itemId = 816, clientId = 816, name = "Lightning Pendant", amount = 10 },
                { itemId = 828, clientId = 828, name = "Lightning Headband", amount = 5 },
                { itemId = 16096, clientId = 16096, name = "Wand of Defiance", amount = 5 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
    },

    validCombatTypes = {
        [0]  = true,
        [1]  = true,
        [2]  = true,
        [3]  = true,
        [9]  = true,
        [10] = true,
        [11] = true,
    },

    elements = {
        { combatType = 0,  key = "physical", name = "Physical", description = "Increases all physical damage from melee attacks and physical spells." },
        { combatType = 1,  key = "energy",   name = "Energy",   description = "Increases damage from energy spells like Thunderstorm and Energy Beam." },
        { combatType = 2,  key = "earth",    name = "Earth",    description = "Increases damage from earth spells like Stone Shower and Terra Strike." },
        { combatType = 3,  key = "fire",     name = "Fire",     description = "Increases damage from fire spells like Great Fireball and Fire Wave." },
        { combatType = 9,  key = "ice",      name = "Ice",      description = "Increases damage from ice spells, runes and imbuements like Avalanche and Ice Wave." },
        { combatType = 10, key = "holy",     name = "Holy",     description = "Increases damage from holy spells like Divine Missile and Holy Flash." },
        { combatType = 11, key = "death",    name = "Death",    description = "Increases damage from death spells like Sudden Death and Death Strike." },
    }
}

ElementalBuildStorage = {
    missionStatus = function(missionId)
        local cycleKey = ElementalBuildConfig.cycle.year * 100 + ElementalBuildConfig.cycle.month
        return ElementalBuildConfig.storageBase + (cycleKey * 1000) + missionId
    end
}

ELEMENTALBUILD_MISSION_PENDING   = 0
ELEMENTALBUILD_MISSION_COMPLETED = 1