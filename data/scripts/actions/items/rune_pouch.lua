local json = dofile("data/libs/dkjson.lua")

local RUNESHOP_OPCODE = 11
local DELIVERY_CONTAINER_ID = 2854
local RUNE_STACK_SIZE = 100
local QUANTITY_OPTIONS = { 100, 300, 500, 1000 }
local SHOP_SESSION_SECONDS = 300

local shopSessionExpiryByGuid = {}
local requestThrottle = RequestThrottle.new(300)

local runes = {
    { itemName = "animate dead rune",        shortName = "Animate Dead",   clientId = 3203, price = 375, category = "support" },
    { itemName = "avalanche rune",           shortName = "Avalanche",      clientId = 3161, price = 70, category = "attack" },
    { itemName = "blank rune",               shortName = "Blank Rune",     clientId = 3147, price = 10, category = "support" },
    { itemName = "chameleon rune",           shortName = "Chameleon",      clientId = 3178, price = 210, category = "support" },
    { itemName = "convince creature rune",   shortName = "Convince",       clientId = 3177, price = 80, category = "support" },
    { itemName = "cure poison rune",         shortName = "Cure Poison",    clientId = 3153, price = 65, category = "healing" },
    { itemName = "destroy field rune",       shortName = "Destroy Field",  clientId = 3148, price = 15, category = "support" },
    { itemName = "disintegrate rune",        shortName = "Disintegrate",   clientId = 3197, price = 26, category = "support" },
    { itemName = "energy field rune",        shortName = "Energy Field",   clientId = 3164, price = 38, category = "field" },
    { itemName = "energy wall rune",         shortName = "Energy Wall",    clientId = 3166, price = 85, category = "field" },
    { itemName = "energy bomb rune",         shortName = "Energy Bomb",    clientId = 3149, price = 203, category = "field" },
    { itemName = "explosion rune",           shortName = "Explosion",      clientId = 3200, price = 31, category = "attack" },
    { itemName = "fire bomb rune",           shortName = "Fire Bomb",      clientId = 3192, price = 147, category = "field" },
    { itemName = "fire field rune",          shortName = "Fire Field",     clientId = 3188, price = 28, category = "field" },
    { itemName = "fire wall rune",           shortName = "Fire Wall",      clientId = 3190, price = 61, category = "field" },
    { itemName = "fireball rune",            shortName = "Fireball",       clientId = 3189, price = 30, category = "attack" },
    { itemName = "great fireball rune",      shortName = "Great Fireball", clientId = 3191, price = 70, category = "attack" },
    { itemName = "heavy magic missile rune", shortName = "Heavy MM",       clientId = 3198, price = 12, category = "attack" },
    { itemName = "holy missile rune",        shortName = "Holy Missile",   clientId = 3182, price = 16, category = "attack" },
    { itemName = "icicle rune",              shortName = "Icicle",         clientId = 3158, price = 30, category = "attack" },
    { itemName = "intense healing rune",     shortName = "Int. Healing",   clientId = 3152, price = 95, category = "healing" },
    { itemName = "light magic missile rune", shortName = "Light MM",       clientId = 3174, price = 4, category = "attack" },
    { itemName = "magic wall rune",          shortName = "Magic Wall",     clientId = 3180, price = 116, category = "support" },
    { itemName = "paralyze rune",            shortName = "Paralyze",       clientId = 3165, price = 700, category = "support" },
    { itemName = "poison bomb rune",         shortName = "Poison Bomb",    clientId = 3173, price = 85, category = "field" },
    { itemName = "poison field rune",        shortName = "Poison Field",   clientId = 3172, price = 21, category = "field" },
    { itemName = "poison wall rune",         shortName = "Poison Wall",    clientId = 3176, price = 52, category = "field" },
    { itemName = "stalagmite rune",          shortName = "Stalagmite",     clientId = 3179, price = 12, category = "attack" },
    { itemName = "stone shower rune",        shortName = "Stone Shower",   clientId = 3175, price = 37, category = "attack" },
    { itemName = "sudden death rune",        shortName = "Sudden Death",   clientId = 3155, price = 170, category = "attack" },
    { itemName = "thunderstorm rune",        shortName = "Thunderstorm",   clientId = 3202, price = 47, category = "attack" },
    { itemName = "ultimate healing rune",    shortName = "Ult. Healing",   clientId = 3160, price = 175, category = "healing" },
    { itemName = "wild growth rune",         shortName = "Wild Growth",    clientId = 3156, price = 160, category = "support" },
}

local function isInFight(player)
    return player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) ~= nil
end

local function openShopSession(player)
    shopSessionExpiryByGuid[player:getGuid()] = os.time() + SHOP_SESSION_SECONDS
end

local function hasActiveShopSession(player)
    local sessionExpiry = shopSessionExpiryByGuid[player:getGuid()]
    return sessionExpiry ~= nil and sessionExpiry >= os.time()
end

local function isValidQuantity(quantity)
    for _, option in ipairs(QUANTITY_OPTIONS) do
        if option == quantity then
            return true
        end
    end
    return false
end

local function getItemWeight(itemId)
    local itemType = ItemType(itemId)
    if not itemType then
        return 0
    end
    return itemType:getWeight()
end

local function buildRuneList()
    local result = {}
    for i, rune in ipairs(runes) do
        result[#result + 1] = {
            index     = i,
            itemName  = rune.itemName,
            shortName = rune.shortName,
            clientId  = rune.clientId,
            price     = rune.price,
            category  = rune.category,
            weight    = getItemWeight(rune.clientId)
        }
    end
    return result
end

local function handleRequest(player)
    player:sendExtendedOpcode(RUNESHOP_OPCODE, json.encode({
        action              = "data",
        runes               = buildRuneList(),
        playerBalance       = player:getBankBalance(),
        freeCapacity        = player:getFreeCapacity(),
        quantities          = QUANTITY_OPTIONS,
        stackSize           = RUNE_STACK_SIZE,
        deliveryContainerId = DELIVERY_CONTAINER_ID,
        containerWeight     = getItemWeight(DELIVERY_CONTAINER_ID)
    }))
end

local function sendBuyResult(player, success, message)
    player:sendExtendedOpcode(RUNESHOP_OPCODE, json.encode({
        action       = "buyResult",
        success      = success,
        message      = message,
        newBalance   = player:getBankBalance(),
        freeCapacity = player:getFreeCapacity()
    }))
end

local function createFilledContainer(runeClientId, quantity)
    local container = Game.createItem(DELIVERY_CONTAINER_ID, 1)
    if not container then
        return nil
    end

    local remaining = quantity
    while remaining > 0 do
        local stackAmount = math.min(RUNE_STACK_SIZE, remaining)
        container:addItem(runeClientId, stackAmount)
        remaining = remaining - stackAmount
    end

    return container
end

local function findRune(clientId)
    for _, rune in ipairs(runes) do
        if rune.clientId == clientId then
            return rune
        end
    end
    return nil
end

local function handleBuy(player, clientId, quantity)
    if not hasActiveShopSession(player) then
        sendBuyResult(player, false, "Your shop session expired. Use the item again to reopen the shop.")
        return
    end

    if isInFight(player) then
        sendBuyResult(player, false, "You can't buy runes during a fight.")
        return
    end

    local rune = findRune(clientId)
    if not rune or not isValidQuantity(quantity) then
        sendBuyResult(player, false, "Invalid purchase.")
        return
    end

    local totalPrice = rune.price * quantity

    if player:getBankBalance() < totalPrice then
        local message = "You don't have enough gold in your bank."
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
        sendBuyResult(player, false, message)
        return
    end

    local container = createFilledContainer(clientId, quantity)
    if not container then
        return
    end

    if player:addItemEx(container, false) ~= RETURNVALUE_NOERROR then
        container:remove()
        local message = "You don't have enough capacity or free space to receive the backpack."
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
        sendBuyResult(player, false, message)
        return
    end

    player:removeMoneyBank(totalPrice)
    local message = "You bought " .. quantity .. "x " .. rune.itemName .. " for " .. totalPrice .. " gold. Check your new backpack!"
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
    sendBuyResult(player, true, message)
end

local runeShopEvent = CreatureEvent("RuneShopOpcode")
runeShopEvent:type("extendedopcode")

runeShopEvent:onExtendedOpcode(function(player, opcode, buffer)
    if opcode ~= RUNESHOP_OPCODE then return true end

    local data, pos, err = json.decode(buffer)
    if err or not data or not data.action then return true end

    if requestThrottle:isThrottled(player) then
        if data.action == "buy" then
            sendBuyResult(player, false, "Please wait a moment before trying again.")
        end
        return true
    end

    if data.action == "request" then
        if hasActiveShopSession(player) then
            handleRequest(player)
        end
    elseif data.action == "buy" then
        handleBuy(player, data.clientId, data.quantity)
    end

    return true
end)

runeShopEvent:register()

local runeShopLoginEvent = CreatureEvent("RuneShopLogin")
runeShopLoginEvent:type("login")

runeShopLoginEvent:onLogin(function(player)
    player:registerEvent("RuneShopOpcode")
    return true
end)

runeShopLoginEvent:register()

local runeShopItem = Action()

function runeShopItem.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if isInFight(player) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can't use this during a fight.")
        return true
    end

    openShopSession(player)
    handleRequest(player)
    return true
end

runeShopItem:id(60655)
runeShopItem:register()