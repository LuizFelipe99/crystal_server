local RANDOM_OUTFIT_ITEM_ID = 64484

local grantableOutfits = {
    { outfitName = "Mage", maleLookType = 130, femaleLookType = 138 }, -- ferumbras hat
    { outfitName = "Draccoon Herald", maleLookType = 1722, femaleLookType = 1723 },
    { outfitName = "Celestial Avenger", maleLookType = 1725, femaleLookType = 1726 },
    { outfitName = "Blade Dancer", maleLookType = 1745, femaleLookType = 1746 },
    { outfitName = "Rootwalker", maleLookType = 1774, femaleLookType = 1775 },
    { outfitName = "Beekeeper", maleLookType = 1776, femaleLookType = 1777 },
    { outfitName = "Fiend Slayer", maleLookType = 1809, femaleLookType = 1808 },
    { outfitName = "Field Surgeon", maleLookType = 1814, femaleLookType = 1815 },
    { outfitName = "Winged Druid", maleLookType = 1831, femaleLookType = 1832 },
    { outfitName = "Martial Artist", maleLookType = 1837, femaleLookType = 1838 },
    { outfitName = "Necromancer", maleLookType = 1845, femaleLookType = 1846 },
    { outfitName = "Illuminator", maleLookType = 1860, femaleLookType = 1861 },
    { outfitName = "Bat Knight", maleLookType = 1874, femaleLookType = 1875 },
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