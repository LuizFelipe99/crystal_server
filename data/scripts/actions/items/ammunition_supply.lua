local json = dofile("data/libs/dkjson.lua")

local AMMOSHOP_OPCODE = 12
local DELIVERY_CONTAINER_ID = 2854
local AMMO_STACK_SIZE = 100
local BULK_QUANTITIES = { 100, 300, 500, 1000 }
local THROWING_QUANTITIES = { 10, 25, 50, 100 }
local SINGLE_QUANTITY = { 1 }

local ammunitions = {
    { itemName = "arrow",             shortName = "Arrow",             clientId = 3447,  price = 4,   category = "arrow",     quantities = BULK_QUANTITIES },
    { itemName = "bolt",              shortName = "Bolt",              clientId = 3446,  price = 5,   category = "bolt",      quantities = BULK_QUANTITIES },
    { itemName = "spear",             shortName = "Spear",             clientId = 3277,  price = 11,  category = "throwing",  quantities = THROWING_QUANTITIES },
    { itemName = "diamond arrow",     shortName = "Diamond Arrow",     clientId = 35901, price = 140, category = "arrow",     quantities = BULK_QUANTITIES },
    { itemName = "crystalline arrow", shortName = "Crystalline Arrow", clientId = 15793, price = 22,  category = "arrow",     quantities = BULK_QUANTITIES },
    { itemName = "prismatic bolt",    shortName = "Prismatic Bolt",    clientId = 16141, price = 22,  category = "bolt",      quantities = BULK_QUANTITIES },
    { itemName = "spectral bolt",     shortName = "Spectral Bolt",     clientId = 25758, price = 80,  category = "bolt",      quantities = BULK_QUANTITIES },
    { itemName = "crossbow",          shortName = "Crossbow",          clientId = 3349,  price = 600, category = "equipment", quantities = SINGLE_QUANTITY },
    { itemName = "quiver",            shortName = "Quiver",            clientId = 35562, price = 500, category = "equipment", quantities = SINGLE_QUANTITY },
}

local function findAmmunition(clientId)
    for _, ammo in ipairs(ammunitions) do
        if ammo.clientId == clientId then
            return ammo
        end
    end
    return nil
end

local function isValidQuantity(ammo, quantity)
    for _, option in ipairs(ammo.quantities) do
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

local function isDeliveredInBackpack(ammo)
    local itemType = ItemType(ammo.clientId)
    return itemType ~= nil and itemType:isStackable()
end

local function buildAmmoList()
    local result = {}
    for i, ammo in ipairs(ammunitions) do
        result[#result + 1] = {
            index             = i,
            itemName          = ammo.itemName,
            shortName         = ammo.shortName,
            clientId          = ammo.clientId,
            price             = ammo.price,
            category          = ammo.category,
            quantities        = ammo.quantities,
            weight            = getItemWeight(ammo.clientId),
            deliverInBackpack = isDeliveredInBackpack(ammo)
        }
    end
    return result
end

local function handleRequest(player)
    player:sendExtendedOpcode(AMMOSHOP_OPCODE, json.encode({
        action              = "data",
        ammunitions         = buildAmmoList(),
        playerBalance       = player:getBankBalance(),
        freeCapacity        = player:getFreeCapacity(),
        stackSize           = AMMO_STACK_SIZE,
        deliveryContainerId = DELIVERY_CONTAINER_ID,
        containerWeight     = getItemWeight(DELIVERY_CONTAINER_ID)
    }))
end

local function sendBuyResult(player, success, message)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
    player:sendExtendedOpcode(AMMOSHOP_OPCODE, json.encode({
        action       = "buyResult",
        success      = success,
        message      = message,
        newBalance   = player:getBankBalance(),
        freeCapacity = player:getFreeCapacity()
    }))
end

local function createFilledContainer(clientId, quantity)
    local container = Game.createItem(DELIVERY_CONTAINER_ID, 1)
    if not container then
        return nil
    end

    local remaining = quantity
    while remaining > 0 do
        local stackAmount = math.min(AMMO_STACK_SIZE, remaining)
        container:addItem(clientId, stackAmount)
        remaining = remaining - stackAmount
    end

    return container
end

local function createDeliveryItem(ammo, quantity)
    if isDeliveredInBackpack(ammo) then
        return createFilledContainer(ammo.clientId, quantity)
    end
    return Game.createItem(ammo.clientId, 1)
end

local function handleBuy(player, clientId, quantity)
    local ammo = findAmmunition(clientId)
    if not ammo then return end
    if not isValidQuantity(ammo, quantity) then return end

    local totalPrice = ammo.price * quantity

    if player:getBankBalance() < totalPrice then
        sendBuyResult(player, false, "You don't have enough gold in your bank.")
        return
    end

    local deliveryItem = createDeliveryItem(ammo, quantity)
    if not deliveryItem then
        return
    end

    if player:addItemEx(deliveryItem, false) ~= RETURNVALUE_NOERROR then
        deliveryItem:remove()
        sendBuyResult(player, false, "You don't have enough capacity or free space to receive this purchase.")
        return
    end

    player:removeMoneyBank(totalPrice)

    local deliveryNote = isDeliveredInBackpack(ammo) and " Check your new backpack!" or ""
    sendBuyResult(player, true, "You bought " .. quantity .. "x " .. ammo.itemName .. " for " .. totalPrice .. " gold." .. deliveryNote)
end

local ammoShopEvent = CreatureEvent("AmmoShopOpcode")
ammoShopEvent:type("extendedopcode")

ammoShopEvent:onExtendedOpcode(function(player, opcode, buffer)
    if opcode ~= AMMOSHOP_OPCODE then
        return true
    end

    local data, pos, err = json.decode(buffer)
    if err or not data or not data.action then
        return true
    end

    if data.action == "request" then
        handleRequest(player)
    elseif data.action == "buy" then
        handleBuy(player, data.clientId, data.quantity)
    end

    return true
end)

ammoShopEvent:register()

local ammoShopLoginEvent = CreatureEvent("AmmoShopLogin")
ammoShopLoginEvent:type("login")

ammoShopLoginEvent:onLogin(function(player)
    player:registerEvent("AmmoShopOpcode")
    return true
end)

ammoShopLoginEvent:register()

local ammoShopItem = Action()

function ammoShopItem.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    handleRequest(player)
    return true
end

ammoShopItem:id(60653)
ammoShopItem:register()
