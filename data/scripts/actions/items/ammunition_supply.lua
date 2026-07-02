local json = dofile("data/libs/dkjson.lua")

local AMMOSHOP_OPCODE = 12

local ammunitions = {
    { itemName = "arrow",             shortName = "Arrow",             clientId = 3447,  price = 4   },
    { itemName = "bolt",              shortName = "Bolt",              clientId = 3446,  price = 5   },
    { itemName = "spear",             shortName = "Spear",             clientId = 3277,  price = 11  },
    { itemName = "diamond arrow",     shortName = "Diamond Arrow",     clientId = 35901, price = 140 },
    { itemName = "crystalline arrow", shortName = "Crystalline Arrow", clientId = 15793, price = 22  },
    { itemName = "prismatic bolt",    shortName = "Prismatic Bolt",    clientId = 16141, price = 22  },
    { itemName = "spectral bolt",     shortName = "Spectral Bolt",     clientId = 25758, price = 80  },
    { itemName = "crossbow",          shortName = "Crossbow",          clientId = 3349, price = 600  },
    { itemName = "quiver",            shortName = "Quiver",            clientId = 35562, price = 500  },
}

local function buildAmmoList()
    local result = {}

    for i, ammo in ipairs(ammunitions) do
        result[#result + 1] = {
            index = i,
            itemName = ammo.itemName,
            shortName = ammo.shortName,
            clientId = ammo.clientId,
            price = ammo.price
        }
    end

    return result
end

local function handleRequest(player)
    local payload = {
        action = "data",
        ammunitions = buildAmmoList(),
        playerBalance = player:getBankBalance()
    }

    player:sendExtendedOpcode(AMMOSHOP_OPCODE, json.encode(payload))
end

local function handleBuy(player, clientId, quantity)
    local validQuantities = {
        [1] = true,
        [100] = true,
        [300] = true,
        [500] = true,
        [1000] = true
    }

    if not validQuantities[quantity] then
        return
    end

    local ammo = nil

    for _, a in ipairs(ammunitions) do
        if a.clientId == clientId then
            ammo = a
            break
        end
    end

    if not ammo then
        return
    end

    local totalPrice = ammo.price * quantity

    if player:getBankBalance() < totalPrice then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You don't have enough gold in your bank.")

        player:sendExtendedOpcode(AMMOSHOP_OPCODE, json.encode({
            action = "buyResult",
            success = false,
            newBalance = player:getBankBalance()
        }))
        return
    end

    player:removeMoneyBank(totalPrice)
    player:addItem(ammo.clientId, quantity)

    player:sendTextMessage(
        MESSAGE_EVENT_ADVANCE,
        "You bought " .. quantity .. "x " .. ammo.itemName .. " for " .. totalPrice .. " gold!"
    )

    player:sendExtendedOpcode(AMMOSHOP_OPCODE, json.encode({
        action = "buyResult",
        success = true,
        newBalance = player:getBankBalance()
    }))
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
    local inFight = player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)

    if inFight then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can't use this during a fight.")
        return true
    end

    handleRequest(player)
    return true
end

ammoShopItem:id(60653)
ammoShopItem:register()