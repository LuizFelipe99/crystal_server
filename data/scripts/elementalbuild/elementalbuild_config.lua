ElementalBuildConfig = {
    opcode          = 14,
    storageBase     = 70000,
    damageRatio     = 1.0,
    pointsCap       = 50,
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
        [21] = {
            name        = "Infernal Ranks",
            description = "Climb the infernal hierarchy, from diabolic imps and furies up to the mighty juggernauts.",
            points      = 1,
            items       = {
                { itemId = 3471, clientId = 3471, name = "Cleaver", amount = 20 },
                { itemId = 7456, clientId = 7456, name = "Noble Axe", amount = 10 },
                { itemId = 5021, clientId = 5021, name = "Orichalcum Pearl", amount = 20 },
                { itemId = 7413, clientId = 7413, name = "Titan Axe", amount = 10 },
                { itemId = 9058, clientId = 9058, name = "Gold Ingot", amount = 10 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [22] = {
            name        = "Dragon Hoard",
            description = "Raid the lairs of dragons, frost dragons and ghastly dragons and seize their hoard.",
            points      = 1,
            items       = {
                { itemId = 11457, clientId = 11457, name = "Dragon's Tail", amount = 30 },
                { itemId = 5920, clientId = 5920, name = "Green Dragon Scale", amount = 10 },
                { itemId = 2903, clientId = 2903, name = "Golden Mug", amount = 20 },
                { itemId = 10449, clientId = 10449, name = "Ghastly Dragon Head", amount = 20 },
                { itemId = 10450, clientId = 10450, name = "Undead Heart", amount = 50 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [23] = {
            name        = "Elemental Fury",
            description = "Tame the raw elements, from earth elementals and massive fire elementals to the sulphur spouters.",
            points      = 1,
            items       = {
                { itemId = 10305, clientId = 10305, name = "Lump of Earth", amount = 50 },
                { itemId = 3030, clientId = 3030, name = "Small Ruby", amount = 30 },
                { itemId = 3071, clientId = 3071, name = "Wand of Inferno", amount = 10 },
                { itemId = 39376, clientId = 39376, name = "Sulphur Powder", amount = 30 },
                { itemId = 14042, clientId = 14042, name = "Warrior's Shield", amount = 3 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [24] = {
            name        = "Rotten Roots",
            description = "Cut through haunted treelings, hideous fungi and the ancient rootthing amber shapers.",
            points      = 1,
            items       = {
                { itemId = 9683, clientId = 9683, name = "Haunted Piece of Wood", amount = 30 },
                { itemId = 16140, clientId = 16140, name = "Hideous Chunk", amount = 30 },
                { itemId = 814, clientId = 814, name = "Terra Amulet", amount = 10 },
                { itemId = 48510, clientId = 48510, name = "Demon Root", amount = 10 },
                { itemId = 48413, clientId = 48413, name = "Amber Sickle", amount = 10 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [25] = {
            name        = "Rogues and Usurpers",
            description = "Bring down hunters, warlocks and the usurper knights who betrayed the Order of the Lion.",
            points      = 1,
            items       = {
                { itemId = 11469, clientId = 11469, name = "Hunter's Quiver", amount = 20 },
                { itemId = 5875, clientId = 5875, name = "Sniper Gloves", amount = 3 },
                { itemId = 3062, clientId = 3062, name = "Mind Stone", amount = 10 },
                { itemId = 34162, clientId = 34162, name = "Lion Cloak Patch", amount = 30 },
                { itemId = 34160, clientId = 34160, name = "Lion Crest", amount = 20 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [26] = {
            name        = "Living Stone",
            description = "Shatter stone golems, war golems and orewalkers and salvage the ore from their bodies.",
            points      = 1,
            items       = {
                { itemId = 10315, clientId = 10315, name = "Sulphurous Stone", amount = 30 },
                { itemId = 5880, clientId = 5880, name = "Iron Ore", amount = 10 },
                { itemId = 7428, clientId = 7428, name = "Bonebreaker", amount = 3 },
                { itemId = 16133, clientId = 16133, name = "Pulverized Ore", amount = 30 },
                { itemId = 16135, clientId = 16135, name = "Vein of Ore", amount = 30 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [27] = {
            name        = "Scales and Wings",
            description = "Hunt lizard templars, lizard chosen and the mercurial menaces of the swamps.",
            points      = 1,
            items       = {
                { itemId = 5876, clientId = 5876, name = "Lizard Leather", amount = 10 },
                { itemId = 10410, clientId = 10410, name = "Cursed Shoulder Spikes", amount = 30 },
                { itemId = 11673, clientId = 11673, name = "Scale of Corruption", amount = 20 },
                { itemId = 39395, clientId = 39395, name = "Mercurial Wing", amount = 30 },
                { itemId = 3017, clientId = 3017, name = "Silver Brooch", amount = 5 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [28] = {
            name        = "Giant Slayer",
            description = "Topple cyclopes, behemoths and the hulking prehemoths that roam the wild lands.",
            points      = 1,
            items       = {
                { itemId = 9657, clientId = 9657, name = "Cyclops Toe", amount = 30 },
                { itemId = 11447, clientId = 11447, name = "Battle Stone", amount = 30 },
                { itemId = 5893, clientId = 5893, name = "Perfect Behemoth Fang", amount = 10 },
                { itemId = 39382, clientId = 39382, name = "Prehemoth Horns", amount = 30 },
                { itemId = 39383, clientId = 39383, name = "Prehemoth Claw", amount = 30 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [29] = {
            name        = "Restless Dead",
            description = "Put vampires, lost souls and undead dragons back into their graves for good.",
            points      = 1,
            items       = {
                { itemId = 9685, clientId = 9685, name = "Vampire Teeth", amount = 30 },
                { itemId = 11449, clientId = 11449, name = "Blood Preservation", amount = 20 },
                { itemId = 10316, clientId = 10316, name = "Unholy Bone", amount = 50 },
                { itemId = 7407, clientId = 7407, name = "Haunted Blade", amount = 5 },
                { itemId = 5925, clientId = 5925, name = "Hardened Bone", amount = 30 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [30] = {
            name        = "Moonlit Hunt",
            description = "Track werewolves, werepanthers and white weretigers under the light of the full moon.",
            points      = 1,
            items       = {
                { itemId = 10317, clientId = 10317, name = "Werewolf Fur", amount = 30 },
                { itemId = 5897, clientId = 5897, name = "Wolf Paw", amount = 20 },
                { itemId = 43731, clientId = 43731, name = "Werepanther Claw", amount = 30 },
                { itemId = 43730, clientId = 43730, name = "Weretiger Tooth", amount = 30 },
                { itemId = 22083, clientId = 22083, name = "Moonlight Crystals", amount = 20 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [31] = {
            name        = "Eyes of the Arcane",
            description = "Hunt elder bonelords, medusae and feral sphinxes for the relics of their arcane gaze.",
            points      = 1,
            items       = {
                { itemId = 10276, clientId = 10276, name = "Elder Bonelord Tentacle", amount = 30 },
                { itemId = 5898, clientId = 5898, name = "Bonelord Eye", amount = 10 },
                { itemId = 10309, clientId = 10309, name = "Strand of Medusa Hair", amount = 30 },
                { itemId = 3436, clientId = 3436, name = "Medusa Shield", amount = 10 },
                { itemId = 31437, clientId = 31437, name = "Sphinx Feather", amount = 20 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [32] = {
            name        = "Web of Fangs",
            description = "Tear through giant spiders, spidris elites and the dreaded undertakers.",
            points      = 1,
            items       = {
                { itemId = 5879, clientId = 5879, name = "Spider Silk", amount = 10 },
                { itemId = 3557, clientId = 3557, name = "Plate Legs", amount = 30 },
                { itemId = 14082, clientId = 14082, name = "Spidris Mandible", amount = 50 },
                { itemId = 14083, clientId = 14083, name = "Compound Eye", amount = 30 },
                { itemId = 39380, clientId = 39380, name = "Undertaker Fangs", amount = 30 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [33] = {
            name        = "Wild Pelts",
            description = "Bring back the trophies of mutated tigers, stone rhinos and the savage gorerillas.",
            points      = 1,
            items       = {
                { itemId = 10293, clientId = 10293, name = "Striped Fur", amount = 30 },
                { itemId = 10311, clientId = 10311, name = "Sabretooth", amount = 20 },
                { itemId = 24389, clientId = 24389, name = "Rhino Horn", amount = 30 },
                { itemId = 39392, clientId = 39392, name = "Gorerilla Mane", amount = 30 },
                { itemId = 39393, clientId = 39393, name = "Gorerilla Tail", amount = 30 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [34] = {
            name        = "Horned Warbands",
            description = "Break orc warbands, minotaur amazons and the bulltaur forgepriests.",
            points      = 1,
            items       = {
                { itemId = 11479, clientId = 11479, name = "Orc Leather", amount = 50 },
                { itemId = 11480, clientId = 11480, name = "Skull Belt", amount = 20 },
                { itemId = 21204, clientId = 21204, name = "Cowbell", amount = 30 },
                { itemId = 11472, clientId = 11472, name = "Minotaur Horn", amount = 20 },
                { itemId = 3048, clientId = 3048, name = "Might Ring", amount = 10 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [35] = {
            name        = "Tides of the Deep",
            description = "Dive against deepling warriors, deepling tyrants and the quara plunderers.",
            points      = 1,
            items       = {
                { itemId = 14041, clientId = 14041, name = "Deepling Ridge", amount = 30 },
                { itemId = 14013, clientId = 14013, name = "Deeptags", amount = 30 },
                { itemId = 14044, clientId = 14044, name = "Deepling Claw", amount = 50 },
                { itemId = 14010, clientId = 14010, name = "Deepling Guard Belt Buckle", amount = 30 },
                { itemId = 48508, clientId = 48508, name = "Amber Souvenir", amount = 10 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [36] = {
            name        = "Feathered Hunt",
            description = "Ground the terror birds, jungle moas and the fearsome headpeckers.",
            points      = 1,
            items       = {
                { itemId = 10273, clientId = 10273, name = "Terrorbird Beak", amount = 30 },
                { itemId = 11514, clientId = 11514, name = "Colourful Feather", amount = 10 },
                { itemId = 39404, clientId = 39404, name = "Jungle Moa Claw", amount = 30 },
                { itemId = 39405, clientId = 39405, name = "Jungle Moa Egg", amount = 20 },
                { itemId = 39387, clientId = 39387, name = "Headpecker Beak", amount = 30 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [37] = {
            name        = "Oozing Depths",
            description = "Scrape the remains of acid blobs, defilers and the ancient ink blobs.",
            points      = 1,
            items       = {
                { itemId = 9054, clientId = 9054, name = "Glob of Acid Slime", amount = 50 },
                { itemId = 9055, clientId = 9055, name = "Glob of Tar", amount = 30 },
                { itemId = 5944, clientId = 5944, name = "Soul Orb", amount = 50 },
                { itemId = 28568, clientId = 28568, name = "Inkwell", amount = 5 },
                { itemId = 9640, clientId = 9640, name = "Poisonous Slime", amount = 5 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [38] = {
            name        = "Fey Gardens",
            description = "Gather the treasures of dryads, nymphs and the angry sugar fairies.",
            points      = 1,
            items       = {
                { itemId = 9014, clientId = 9014, name = "Leaf Legs", amount = 5 },
                { itemId = 25691, clientId = 25691, name = "Wild Flowers", amount = 50 },
                { itemId = 25695, clientId = 25695, name = "Dandelion Seeds", amount = 30 },
                { itemId = 25696, clientId = 25696, name = "Colourful Snail Shell", amount = 30 },
                { itemId = 24962, clientId = 24962, name = "Prismatic Quartz", amount = 10 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [39] = {
            name        = "Beyond the Rift",
            description = "Close the rifts by defeating yielothax, dread intruders and the mitmah seers.",
            points      = 1,
            items       = {
                { itemId = 9304, clientId = 9304, name = "Shockwave Amulet", amount = 3 },
                { itemId = 23519, clientId = 23519, name = "Frozen Lightning", amount = 30 },
                { itemId = 23516, clientId = 23516, name = "Instable Proto Matter", amount = 20 },
                { itemId = 23510, clientId = 23510, name = "Odd Organ", amount = 20 },
                { itemId = 22194, clientId = 22194, name = "Opal", amount = 10 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [40] = {
            name        = "Rift Demons",
            description = "Face vexclaws, sineater inferniarchs and the brutal hellflayers.",
            points      = 1,
            items       = {
                { itemId = 22728, clientId = 22728, name = "Vexclaw Talon", amount = 30 },
                { itemId = 3306, clientId = 3306, name = "Golden Sickle", amount = 30 },
                { itemId = 50057, clientId = 50057, name = "Sineater Wing", amount = 10 },
                { itemId = 16096, clientId = 16096, name = "Wand of Defiance", amount = 10 },
                { itemId = 22729, clientId = 22729, name = "Pair of Hellflayer Horns", amount = 3 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [41] = {
            name        = "Draconic Bloodline",
            description = "Slay wyrms, elder wyrms and the draken elite guarding the old bloodline.",
            points      = 1,
            items       = {
                { itemId = 9665, clientId = 9665, name = "Wyrm Scale", amount = 50 },
                { itemId = 8043, clientId = 8043, name = "Focus Cape", amount = 5 },
                { itemId = 11660, clientId = 11660, name = "Broken Draken Mail", amount = 30 },
                { itemId = 11659, clientId = 11659, name = "Draken Wristbands", amount = 20 },
                { itemId = 11658, clientId = 11658, name = "Draken Sulphur", amount = 20 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [42] = {
            name        = "Haunted Legion",
            description = "Banish betrayed wraiths, skeleton elite warriors and the burster spectres.",
            points      = 1,
            items       = {
                { itemId = 7386, clientId = 7386, name = "Mercenary Sword", amount = 5 },
                { itemId = 11481, clientId = 11481, name = "Pelvis Bone", amount = 10 },
                { itemId = 30082, clientId = 30082, name = "Blue Ectoplasm", amount = 30 },
                { itemId = 3067, clientId = 3067, name = "Hailstorm Rod", amount = 20 },
                { itemId = 815, clientId = 815, name = "Glacier Amulet", amount = 20 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [43] = {
            name        = "Molten Constructs",
            description = "Shatter stone devourers, magma crawlers and the lava golems of the deep.",
            points      = 1,
            items       = {
                { itemId = 16137, clientId = 16137, name = "Stone Nose", amount = 30 },
                { itemId = 16138, clientId = 16138, name = "Crystalline Spikes", amount = 30 },
                { itemId = 9636, clientId = 9636, name = "Fiery Heart", amount = 30 },
                { itemId = 16130, clientId = 16130, name = "Magma Clump", amount = 30 },
                { itemId = 16131, clientId = 16131, name = "Blazing Bone", amount = 30 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [44] = {
            name        = "Serpent Court",
            description = "Overthrow corrupt nagas, naga warriors and the noxious ripptors.",
            points      = 1,
            items       = {
                { itemId = 39415, clientId = 39415, name = "Corrupt Naga Scales", amount = 30 },
                { itemId = 39414, clientId = 39414, name = "Naga Warrior Scales", amount = 30 },
                { itemId = 39412, clientId = 39412, name = "Naga Earring", amount = 20 },
                { itemId = 39391, clientId = 39391, name = "Ripptor Scales", amount = 30 },
                { itemId = 39389, clientId = 39389, name = "Ripptor Claw", amount = 20 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [45] = {
            name        = "Ogre Feast",
            description = "Crash the feast of ogre brutes, ogre rowdies and the ogre sages.",
            points      = 1,
            items       = {
                { itemId = 22188, clientId = 22188, name = "Ogre Ear Stud", amount = 50 },
                { itemId = 22189, clientId = 22189, name = "Ogre Nose Ring", amount = 30 },
                { itemId = 22191, clientId = 22191, name = "Skull Fetish", amount = 30 },
                { itemId = 22184, clientId = 22184, name = "Shamanic Talisman", amount = 20 },
                { itemId = 22171, clientId = 22171, name = "Ogre Klubba", amount = 2 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [46] = {
            name        = "Heroes of Old",
            description = "Challenge heroes, priestesses of the wild sun and the burning gladiators.",
            points      = 1,
            items       = {
                { itemId = 11510, clientId = 11510, name = "Scroll of Heroic Deeds", amount = 20 },
                { itemId = 3004, clientId = 3004, name = "Wedding Ring", amount = 10 },
                { itemId = 31443, clientId = 31443, name = "Fafnar Symbol", amount = 30 },
                { itemId = 31433, clientId = 31433, name = "Secret Instruction", amount = 20 },
                { itemId = 3045, clientId = 3045, name = "Strange Talisman", amount = 10 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [47] = {
            name        = "Blood Moon",
            description = "Hunt werefoxes, weretigers and the feral werecrocodiles under the blood moon.",
            points      = 1,
            items       = {
                { itemId = 27462, clientId = 27462, name = "Fox Paw", amount = 20 },
                { itemId = 27463, clientId = 27463, name = "Werefox Tail", amount = 20 },
                { itemId = 7432, clientId = 7432, name = "Furry Club", amount = 20 },
                { itemId = 43729, clientId = 43729, name = "Werecrocodile Tongue", amount = 30 },
                { itemId = 24392, clientId = 24392, name = "Gemmed Figurine", amount = 5 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [48] = {
            name        = "Primal Forces",
            description = "Quell high voltage elementals, lava lurkers and the mighty cliff striders.",
            points      = 1,
            items       = {
                { itemId = 3007, clientId = 3007, name = "Crystal Ring", amount = 10 },
                { itemId = 7449, clientId = 7449, name = "Crystal Sword", amount = 5 },
                { itemId = 676, clientId = 676, name = "Small Enchanted Ruby", amount = 30 },
                { itemId = 16134, clientId = 16134, name = "Cliff Strider Claw", amount = 30 },
                { itemId = 10310, clientId = 10310, name = "Shiny Stone", amount = 30 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [49] = {
            name        = "Ancient Overgrowth",
            description = "Burn through omnivoras, stalking stalks and the rootthing bug trackers.",
            points      = 1,
            items       = {
                { itemId = 16124, clientId = 16124, name = "Blue Crystal Splinter", amount = 10 },
                { itemId = 39384, clientId = 39384, name = "Stalking Seeds", amount = 30 },
                { itemId = 16117, clientId = 16117, name = "Muck Rod", amount = 5 },
                { itemId = 48511, clientId = 48511, name = "Resin Parasite", amount = 10 },
                { itemId = 3575, clientId = 3575, name = "Wood Cape", amount = 3 },
                { itemId = 60863, clientId = 60863, name = "Upgrade Build Stone", amount = 1 },
            }
        },
        [50] = {
            name        = "Nightmare Realm",
            description = "Conquer the nightmare realm of silencers, guzzlemaws and the sights of surrender.",
            points      = 1,
            items       = {
                { itemId = 20200, clientId = 20200, name = "Silencer Claws", amount = 30 },
                { itemId = 20201, clientId = 20201, name = "Silencer Resonating Chamber", amount = 20 },
                { itemId = 20198, clientId = 20198, name = "Frazzle Tongue", amount = 30 },
                { itemId = 20199, clientId = 20199, name = "Frazzle Skin", amount = 30 },
                { itemId = 20183, clientId = 20183, name = "Sight of Surrender's Eye", amount = 10 },
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