local json = dofile("data/libs/dkjson.lua")

local RUNESHOP_OPCODE = 11

local runes = {
    { itemName = "animate dead rune",        shortName = "Animate Dead",   clientId = 3203, price = 375 },
    { itemName = "avalanche rune",           shortName = "Avalanche",      clientId = 3161, price = 70  },
    { itemName = "blank rune",               shortName = "Blank Rune",     clientId = 3147, price = 10  },
    { itemName = "chameleon rune",           shortName = "Chameleon",      clientId = 3178, price = 210 },
    { itemName = "convince creature rune",   shortName = "Convince",       clientId = 3177, price = 80  },
    { itemName = "cure poison rune",         shortName = "Cure Poison",    clientId = 3153, price = 65  },
    { itemName = "destroy field rune",       shortName = "Destroy Field",  clientId = 3148, price = 15  },
    { itemName = "disintegrate rune",        shortName = "Disintegrate",   clientId = 3197, price = 26  },
    { itemName = "energy field rune",        shortName = "Energy Field",   clientId = 3164, price = 38  },
    { itemName = "energy wall rune",         shortName = "Energy Wall",    clientId = 3166, price = 85  },
    { itemName = "energy bomb rune",         shortName = "Energy Bomb",    clientId = 3149, price = 203 },
    { itemName = "explosion rune",           shortName = "Explosion",      clientId = 3200, price = 31  },
    { itemName = "fire bomb rune",           shortName = "Fire Bomb",      clientId = 3192, price = 147 },
    { itemName = "fire field rune",          shortName = "Fire Field",     clientId = 3188, price = 28  },
    { itemName = "fire wall rune",           shortName = "Fire Wall",      clientId = 3190, price = 61  },
    { itemName = "fireball rune",            shortName = "Fireball",       clientId = 3189, price = 30  },
    { itemName = "great fireball rune",      shortName = "Great Fireball", clientId = 3191, price = 70  },
    { itemName = "heavy magic missile rune", shortName = "Heavy MM",       clientId = 3198, price = 12  },
    { itemName = "holy missile rune",        shortName = "Holy Missile",   clientId = 3182, price = 16  },
    { itemName = "icicle rune",              shortName = "Icicle",         clientId = 3158, price = 30  },
    { itemName = "intense healing rune",     shortName = "Int. Healing",   clientId = 3152, price = 95  },
    { itemName = "light magic missile rune", shortName = "Light MM",       clientId = 3174, price = 4   },
    { itemName = "magic wall rune",          shortName = "Magic Wall",     clientId = 3180, price = 116 },
    { itemName = "paralyze rune",            shortName = "Paralyze",       clientId = 3165, price = 700 },
    { itemName = "poison bomb rune",         shortName = "Poison Bomb",    clientId = 3173, price = 85  },
    { itemName = "poison field rune",        shortName = "Poison Field",   clientId = 3172, price = 21  },
    { itemName = "poison wall rune",         shortName = "Poison Wall",    clientId = 3176, price = 52  },
    { itemName = "stalagmite rune",          shortName = "Stalagmite",     clientId = 3179, price = 12  },
    { itemName = "stone shower rune",        shortName = "Stone Shower",   clientId = 3175, price = 37  },
    { itemName = "sudden death rune",        shortName = "Sudden Death",   clientId = 3155, price = 170 },
    { itemName = "thunderstorm rune",        shortName = "Thunderstorm",   clientId = 3202, price = 47  },
    { itemName = "ultimate healing rune",    shortName = "Ult. Healing",   clientId = 3160, price = 175 },
    { itemName = "wild growth rune",         shortName = "Wild Growth",    clientId = 3156, price = 160 },
}

local function buildRuneList()
    local result = {}
    for i, rune in ipairs(runes) do
        result[#result + 1] = {
            index     = i,
            itemName  = rune.itemName,
            shortName = rune.shortName,
            clientId  = rune.clientId,
            price     = rune.price
        }
    end
    return result
end

local function handleRequest(player)
    player:sendExtendedOpcode(RUNESHOP_OPCODE, json.encode({
        action        = "data",
        runes         = buildRuneList(),
        playerBalance = player:getBankBalance()
    }))
end

local function handleBuy(player, clientId, quantity)
    local validQuantities = { [100] = true, [300] = true, [500] = true, [1000] = true }

    if not validQuantities[quantity] then return end

    local rune = nil
    for _, r in ipairs(runes) do
        if r.clientId == clientId then
            rune = r
            break
        end
    end

    if not rune then return end

    local totalPrice = rune.price * quantity

    if player:getBankBalance() < totalPrice then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You don't have enough gold in your bank.")
        player:sendExtendedOpcode(RUNESHOP_OPCODE, json.encode({
            action     = "buyResult",
            success    = false,
            newBalance = player:getBankBalance()
        }))
        return
    end

    player:removeMoneyBank(totalPrice)
    player:addItem(clientId, quantity)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You bought " .. quantity .. "x " .. rune.itemName .. " for " .. totalPrice .. " gold!")

    player:sendExtendedOpcode(RUNESHOP_OPCODE, json.encode({
        action     = "buyResult",
        success    = true,
        newBalance = player:getBankBalance()
    }))
end

local runeShopEvent = CreatureEvent("RuneShopOpcode")
runeShopEvent:type("extendedopcode")

runeShopEvent:onExtendedOpcode(function(player, opcode, buffer)
    if opcode ~= RUNESHOP_OPCODE then return true end

    local data, pos, err = json.decode(buffer)
    if err or not data or not data.action then return true end

    if data.action == "request" then
        handleRequest(player)
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
    local inFight = player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)

    if inFight then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can't use this during a fight.")
        return true
    end

    handleRequest(player)
    return true
end

runeShopItem:id(60655)
runeShopItem:register()