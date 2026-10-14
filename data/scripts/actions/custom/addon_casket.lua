local RANDOM_OUTFIT_ITEM_ID = 64484

local grantableOutfits = {
    { outfitName = "Citizen", maleLookType = 128, femaleLookType = 136 },
    { outfitName = "Hunter", maleLookType = 129, femaleLookType = 137 },
    { outfitName = "Mage", maleLookType = 130, femaleLookType = 138 }, -- remover para golden box
    { outfitName = "Knight", maleLookType = 131, femaleLookType = 139 },
    { outfitName = "Noblewoman", maleLookType = 132, femaleLookType = 140 },
    { outfitName = "Summoner", maleLookType = 133, femaleLookType = 141 },
    { outfitName = "Warrior", maleLookType = 134, femaleLookType = 142 },
    { outfitName = "Barbarian", maleLookType = 143, femaleLookType = 147 },
    { outfitName = "Druid", maleLookType = 144, femaleLookType = 148 },
    { outfitName = "Wizard", maleLookType = 145, femaleLookType = 149 },
    { outfitName = "Oriental", maleLookType = 146, femaleLookType = 150 },
    { outfitName = "Pirate", maleLookType = 151, femaleLookType = 155 },
    { outfitName = "Assassin", maleLookType = 152, femaleLookType = 156 },
    { outfitName = "Beggar", maleLookType = 153, femaleLookType = 157 },
    { outfitName = "Shaman", maleLookType = 154, femaleLookType = 158 },
    { outfitName = "Norsewoman", maleLookType = 251, femaleLookType = 252 },
    { outfitName = "Nightmare", maleLookType = 268, femaleLookType = 269 },
    { outfitName = "Jester", maleLookType = 273, femaleLookType = 270 },
    { outfitName = "Brotherhood", maleLookType = 278, femaleLookType = 279 },
    { outfitName = "Demon Hunter", maleLookType = 289, femaleLookType = 288 },
    { outfitName = "Yalaharian", maleLookType = 325, femaleLookType = 324 },
    { outfitName = "Newly Wed", maleLookType = 328, femaleLookType = 329 },
    { outfitName = "Warmaster", maleLookType = 335, femaleLookType = 336 },
    { outfitName = "Wayfarer", maleLookType = 367, femaleLookType = 366 },
    { outfitName = "Afflicted", maleLookType = 430, femaleLookType = 431 },
    { outfitName = "Elementalist", maleLookType = 432, femaleLookType = 433 },
    { outfitName = "Deepling", maleLookType = 463, femaleLookType = 464 },
    { outfitName = "Insectoid", maleLookType = 465, femaleLookType = 466 },
    { outfitName = "Entrepreneur", maleLookType = 472, femaleLookType = 471 },
    { outfitName = "Crystal Warlord", maleLookType = 512, femaleLookType = 513 },
    { outfitName = "Soil Guardian", maleLookType = 516, femaleLookType = 514 },
    { outfitName = "Demon", maleLookType = 541, femaleLookType = 542 },
    { outfitName = "Cave Explorer", maleLookType = 574, femaleLookType = 575 },
    { outfitName = "Dream Warden", maleLookType = 577, femaleLookType = 578 },
    { outfitName = "Glooth Engineer", maleLookType = 610, femaleLookType = 618 },
    { outfitName = "Jersey", maleLookType = 619, femaleLookType = 620 },
    { outfitName = "Champion", maleLookType = 633, femaleLookType = 632 },
    { outfitName = "Conjurer", maleLookType = 634, femaleLookType = 635 },
    { outfitName = "Beastmaster", maleLookType = 637, femaleLookType = 636 },
    { outfitName = "Chaos Acolyte", maleLookType = 665, femaleLookType = 664 },
    { outfitName = "Death Herald", maleLookType = 667, femaleLookType = 666 },
    { outfitName = "Ranger", maleLookType = 684, femaleLookType = 683 },
    { outfitName = "Ceremonial Garb", maleLookType = 695, femaleLookType = 694 },
    { outfitName = "Puppeteer", maleLookType = 697, femaleLookType = 696 },
    { outfitName = "Spirit Caller", maleLookType = 699, femaleLookType = 698 },
    { outfitName = "Evoker", maleLookType = 725, femaleLookType = 724 },
    { outfitName = "Seaweaver", maleLookType = 733, femaleLookType = 732 },
    { outfitName = "Recruiter", maleLookType = 746, femaleLookType = 745 },
    { outfitName = "Sea Dog", maleLookType = 750, femaleLookType = 749 },
    { outfitName = "Royal Pumpkin", maleLookType = 760, femaleLookType = 759 },
    { outfitName = "Rift Warrior", maleLookType = 846, femaleLookType = 845 },
    { outfitName = "Winter Warden", maleLookType = 853, femaleLookType = 852 },
    { outfitName = "Philosopher", maleLookType = 873, femaleLookType = 874 },
    { outfitName = "Arena Champion", maleLookType = 884, femaleLookType = 885 },
    { outfitName = "Lupine Warden", maleLookType = 899, femaleLookType = 900 },
    { outfitName = "Grove Keeper", maleLookType = 908, femaleLookType = 909 },
    { outfitName = "Festive", maleLookType = 931, femaleLookType = 929 },
    { outfitName = "Pharaoh", maleLookType = 955, femaleLookType = 956 },
    { outfitName = "Trophy Hunter", maleLookType = 957, femaleLookType = 958 },
    { outfitName = "Retro Warrior", maleLookType = 962, femaleLookType = 963 },
    { outfitName = "Retro Summoner", maleLookType = 964, femaleLookType = 965 },
    { outfitName = "Retro Noblewoman", maleLookType = 966, femaleLookType = 967 },
    { outfitName = "Retro Mage", maleLookType = 968, femaleLookType = 969 },
    { outfitName = "Retro Knight", maleLookType = 970, femaleLookType = 971 },
    { outfitName = "Retro Hunter", maleLookType = 972, femaleLookType = 973 },
    { outfitName = "Retro Citizen", maleLookType = 974, femaleLookType = 975 },
    { outfitName = "Herbalist", maleLookType = 1021, femaleLookType = 1020 },
    { outfitName = "Sun Priest", maleLookType = 1023, femaleLookType = 1024 },
    { outfitName = "Makeshift Warrior", maleLookType = 1042, femaleLookType = 1043 },
    { outfitName = "Siege Master", maleLookType = 1051, femaleLookType = 1050 },
    { outfitName = "Mercenary", maleLookType = 1056, femaleLookType = 1057 },
    { outfitName = "Battle Mage", maleLookType = 1069, femaleLookType = 1070 },
    { outfitName = "Discoverer", maleLookType = 1094, femaleLookType = 1095 },
    { outfitName = "Sinister Archer", maleLookType = 1102, femaleLookType = 1103 },
    { outfitName = "Pumpkin Mummy", maleLookType = 1127, femaleLookType = 1128 },
    { outfitName = "Dream Warrior", maleLookType = 1146, femaleLookType = 1147 },
    { outfitName = "Percht Raider", maleLookType = 1161, femaleLookType = 1162 },
    { outfitName = "Owl Keeper", maleLookType = 1173, femaleLookType = 1174 },
    { outfitName = "Guidon Bearer", maleLookType = 1186, femaleLookType = 1187 },
    { outfitName = "Void Master", maleLookType = 1202, femaleLookType = 1203 },
    { outfitName = "Veteran Paladin", maleLookType = 1204, femaleLookType = 1205 },
    { outfitName = "Lion of War", maleLookType = 1206, femaleLookType = 1207 },
    { outfitName = "Golden", maleLookType = 1210, femaleLookType = 1211 },
    { outfitName = "Hand of the Inquisition", maleLookType = 1243, femaleLookType = 1244 },
    { outfitName = "Breezy Garb", maleLookType = 1245, femaleLookType = 1246 },
    { outfitName = "Orcsoberfest Garb", maleLookType = 1251, femaleLookType = 1252 },
    { outfitName = "Poltergeist", maleLookType = 1270, femaleLookType = 1271 },
    { outfitName = "Herder", maleLookType = 1279, femaleLookType = 1280 },
    { outfitName = "Falconer", maleLookType = 1282, femaleLookType = 1283 },
    { outfitName = "Dragon Slayer", maleLookType = 1288, femaleLookType = 1289 },
    { outfitName = "Trailblazer", maleLookType = 1292, femaleLookType = 1293 },
    { outfitName = "Revenant", maleLookType = 1322, femaleLookType = 1323 },
    { outfitName = "Jouster", maleLookType = 1331, femaleLookType = 1332 },
    { outfitName = "Moth Cape", maleLookType = 1338, femaleLookType = 1339 },
    { outfitName = "Rascoohan", maleLookType = 1371, femaleLookType = 1372 },
    { outfitName = "Merry Garb", maleLookType = 1382, femaleLookType = 1383 },
    { outfitName = "Rune Master", maleLookType = 1384, femaleLookType = 1385 },
    { outfitName = "Citizen of Issavi", maleLookType = 1386, femaleLookType = 1387 },
    { outfitName = "Forest Warden", maleLookType = 1415, femaleLookType = 1416 },
    { outfitName = "Royal Bounacean Advisor", maleLookType = 1436, femaleLookType = 1437 },
    { outfitName = "Dragon Knight", maleLookType = 1444, femaleLookType = 1445 },
    { outfitName = "Arbalester", maleLookType = 1449, femaleLookType = 1450 },
    { outfitName = "Royal Costume", maleLookType = 1457, femaleLookType = 1456 },
    { outfitName = "Formal Dress", maleLookType = 1460, femaleLookType = 1461 },
    { outfitName = "Ghost Blade", maleLookType = 1489, femaleLookType = 1490 },
    { outfitName = "Nordic Chieftain", maleLookType = 1500, femaleLookType = 1501 },
    { outfitName = "Fire-Fighter", maleLookType = 1568, femaleLookType = 1569 },
    { outfitName = "Fencer", maleLookType = 1575, femaleLookType = 1576 },
    { outfitName = "Shadowlotus Disciple", maleLookType = 1581, femaleLookType = 1582 },
    { outfitName = "Ancient Aucar", maleLookType = 1597, femaleLookType = 1598 },
    { outfitName = "Frost Tracer", maleLookType = 1612, femaleLookType = 1613 },
    { outfitName = "Armoured Archer", maleLookType = 1618, femaleLookType = 1619 },
    { outfitName = "Decaying Defender", maleLookType = 1662, femaleLookType = 1663 },
    { outfitName = "Darklight Evoker", maleLookType = 1675, femaleLookType = 1676 },
    { outfitName = "Flamefury Mage", maleLookType = 1680, femaleLookType = 1681 },
    { outfitName = "Doom Knight", maleLookType = 1713, femaleLookType = 1714 },
}

local function getLookTypeForPlayerSex(player, outfitEntry)
    if player:getSex() == PLAYER_SEX_FEMALE then
        return outfitEntry.femaleLookType
    end

    return outfitEntry.maleLookType
end

local function getOutfitsPlayerDoesNotOwn(player)
    local missingOutfits = {}

    for _, outfitEntry in ipairs(grantableOutfits) do
        local lookTypeForPlayer = getLookTypeForPlayerSex(player, outfitEntry)

        if not player:hasOutfit(lookTypeForPlayer, 3) then
            table.insert(missingOutfits, outfitEntry)
        end
    end

    return missingOutfits
end

local randomOutfitAction = Action()

function randomOutfitAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local missingOutfits = getOutfitsPlayerDoesNotOwn(player)

    if #missingOutfits == 0 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você já possui todas as outfits disponíveis!")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end

    local chosenOutfit = missingOutfits[math.random(#missingOutfits)]
    local lookTypeToGrant = getLookTypeForPlayerSex(player, chosenOutfit)

    player:addOutfit(lookTypeToGrant, 3)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você recebeu a outfit " .. chosenOutfit.outfitName .. "!")
    player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)

    item:remove(1)
    return true
end

randomOutfitAction:id(RANDOM_OUTFIT_ITEM_ID)
randomOutfitAction:register()