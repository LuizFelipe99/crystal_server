local json = dofile("data/libs/dkjson.lua")

local CRAFTBENCH_OPCODE = 13
local CRAFT_UNLOCK_STORAGE = 91003

local recipes = {
    {
        resultName = "Grand Sanguine Bow",
        resultClientId = 43878,
        resultAmount = 1,
        resultDescription = "(Range: 6, Atk +9, Hit% +6, distance fighting +3, protection earth +6%). Augments: (Divine Caldera -> +8% base damage)",
        ingredients = {
            { itemName = "soubleeder",          clientId = 34088, amount = 1 },
            { itemName = "sanguine bow",         clientId = 43877, amount = 1 },
            { itemName = "falcon bow",           clientId = 28718, amount = 1 },
            { itemName = "golden ruby crafter",  clientId = 63401, amount = 5 },
        }
    },

    {
        resultName = "Grand Sanguine Crossbow",
        resultClientId = 43880,
        resultAmount = 1,
        resultDescription = "",
        ingredients = {
            { itemName = "soulpiercer",           clientId = 34089, amount = 1 },
            { itemName = "sanguine crossbow",     clientId = 43879, amount = 1 },
            { itemName = "cobra crossbow",        clientId = 30393, amount = 1 },
            { itemName = "platinum ruby crafter", clientId = 63400, amount = 5 },
        }
    },
    {
        resultName = "Steel Helmet",
        resultClientId = 3355,
        resultAmount = 1,
        resultDescription = "",
        ingredients = {
            { itemName = "steel", clientId = 5880, amount = 5 },
            { itemName = "rope",  clientId = 3002, amount = 2 },
        }
    },
    {
        resultName = "Mana Potion",
        resultClientId = 268,
        resultAmount = 5,
        resultDescription = "",
        ingredients = {
            { itemName = "empty potion flask", clientId = 285,  amount = 5 },
            { itemName = "blue gem",           clientId = 3031, amount = 1 },
        }
    },
    {
        resultName = "Mana Potion",
        resultClientId = 268,
        resultAmount = 5,
        resultDescription = "",
        ingredients = {
            { itemName = "empty potion flask", clientId = 285,  amount = 5 },
            { itemName = "blue gem",           clientId = 3031, amount = 1 },
        }
    },
    {
        resultName = "Grand Sanguine Bow",
        resultClientId = 43878,
        resultAmount = 1,
        resultDescription = "(Range: 6, Atk +9, Hit% +6, distance fighting +3, protection earth +6%). Augments: (Divine Caldera -> +8% base damage)",
        ingredients = {
            { itemName = "soubleeder",          clientId = 34088, amount = 1 },
            { itemName = "sanguine bow",         clientId = 43877, amount = 1 },
            { itemName = "falcon bow",           clientId = 28718, amount = 1 },
            { itemName = "golden ruby crafter",  clientId = 63401, amount = 5 },
        }
    },

    {
        resultName = "Grand Sanguine Bow",
        resultClientId = 43878,
        resultAmount = 1,
        resultDescription = "(Range: 6, Atk +9, Hit% +6, distance fighting +3, protection earth +6%). Augments: (Divine Caldera -> +8% base damage)",
        ingredients = {
            { itemName = "soubleeder",          clientId = 34088, amount = 1 },
            { itemName = "sanguine bow",         clientId = 43877, amount = 1 },
            { itemName = "falcon bow",           clientId = 28718, amount = 1 },
            { itemName = "golden ruby crafter",  clientId = 63401, amount = 5 },
        }
    },
        {
        resultName = "Grand Sanguine Bow",
        resultClientId = 43878,
        resultAmount = 1,
        resultDescription = "(Range: 6, Atk +9, Hit% +6, distance fighting +3, protection earth +6%). Augments: (Divine Caldera -> +8% base damage)",
        ingredients = {
            { itemName = "soubleeder",          clientId = 34088, amount = 1 },
            { itemName = "sanguine bow",         clientId = 43877, amount = 1 },
            { itemName = "falcon bow",           clientId = 28718, amount = 1 },
            { itemName = "golden ruby crafter",  clientId = 63401, amount = 5 },
        }
    },
        {
        resultName = "Grand Sanguine Bow",
        resultClientId = 43878,
        resultAmount = 1,
        resultDescription = "(Range: 6, Atk +9, Hit% +6, distance fighting +3, protection earth +6%). Augments: (Divine Caldera -> +8% base damage)",
        ingredients = {
            { itemName = "soubleeder",          clientId = 34088, amount = 1 },
            { itemName = "sanguine bow",         clientId = 43877, amount = 1 },
            { itemName = "falcon bow",           clientId = 28718, amount = 1 },
            { itemName = "golden ruby crafter",  clientId = 63401, amount = 5 },
        }
    },
        {
        resultName = "Grand Sanguine Bow",
        resultClientId = 43878,
        resultAmount = 1,
        resultDescription = "(Range: 6, Atk +9, Hit% +6, distance fighting +3, protection earth +6%). Augments: (Divine Caldera -> +8% base damage)",
        ingredients = {
            { itemName = "soubleeder",          clientId = 34088, amount = 1 },
            { itemName = "sanguine bow",         clientId = 43877, amount = 1 },
            { itemName = "falcon bow",           clientId = 28718, amount = 1 },
            { itemName = "golden ruby crafter",  clientId = 63401, amount = 5 },
        }
    },
        {
        resultName = "Grand Sanguine Bow",
        resultClientId = 43878,
        resultAmount = 1,
        resultDescription = "(Range: 6, Atk +9, Hit% +6, distance fighting +3, protection earth +6%). Augments: (Divine Caldera -> +8% base damage)",
        ingredients = {
            { itemName = "soubleeder",          clientId = 34088, amount = 1 },
            { itemName = "sanguine bow",         clientId = 43877, amount = 1 },
            { itemName = "falcon bow",           clientId = 28718, amount = 1 },
            { itemName = "golden ruby crafter",  clientId = 63401, amount = 5 },
        }
    },
        {
        resultName = "Grand Sanguine Bow",
        resultClientId = 43878,
        resultAmount = 1,
        resultDescription = "(Range: 6, Atk +9, Hit% +6, distance fighting +3, protection earth +6%). Augments: (Divine Caldera -> +8% base damage)",
        ingredients = {
            { itemName = "soubleeder",          clientId = 34088, amount = 1 },
            { itemName = "sanguine bow",         clientId = 43877, amount = 1 },
            { itemName = "falcon bow",           clientId = 28718, amount = 1 },
            { itemName = "golden ruby crafter",  clientId = 63401, amount = 5 },
        }
    },
        {
        resultName = "Grand Sanguine Bow",
        resultClientId = 43878,
        resultAmount = 1,
        resultDescription = "(Range: 6, Atk +9, Hit% +6, distance fighting +3, protection earth +6%). Augments: (Divine Caldera -> +8% base damage)",
        ingredients = {
            { itemName = "soubleeder",          clientId = 34088, amount = 1 },
            { itemName = "sanguine bow",         clientId = 43877, amount = 1 },
            { itemName = "falcon bow",           clientId = 28718, amount = 1 },
            { itemName = "golden ruby crafter",  clientId = 63401, amount = 5 },
        }
    },
        {
        resultName = "Grand Sanguine Bow",
        resultClientId = 43878,
        resultAmount = 1,
        resultDescription = "(Range: 6, Atk +9, Hit% +6, distance fighting +3, protection earth +6%). Augments: (Divine Caldera -> +8% base damage)",
        ingredients = {
            { itemName = "soubleeder",          clientId = 34088, amount = 1 },
            { itemName = "sanguine bow",         clientId = 43877, amount = 1 },
            { itemName = "falcon bow",           clientId = 28718, amount = 1 },
            { itemName = "golden ruby crafter",  clientId = 63401, amount = 5 },
        }
    },
        {
        resultName = "Grand Sanguine Bow",
        resultClientId = 43878,
        resultAmount = 1,
        resultDescription = "(Range: 6, Atk +9, Hit% +6, distance fighting +3, protection earth +6%). Augments: (Divine Caldera -> +8% base damage)",
        ingredients = {
            { itemName = "soubleeder",          clientId = 34088, amount = 1 },
            { itemName = "sanguine bow",         clientId = 43877, amount = 1 },
            { itemName = "falcon bow",           clientId = 28718, amount = 1 },
            { itemName = "golden ruby crafter",  clientId = 63401, amount = 5 },
        }
    },
}

local function buildRecipeList()
    local result = {}

    for i, recipe in ipairs(recipes) do
        local ingredientList = {}

        for _, ingredient in ipairs(recipe.ingredients) do
            ingredientList[#ingredientList + 1] = {
                name     = ingredient.itemName,
                clientId = ingredient.clientId,
                amount   = ingredient.amount
            }
        end

        result[#result + 1] = {
            index             = i,
            resultName        = recipe.resultName,
            resultClientId    = recipe.resultClientId,
            resultAmount      = recipe.resultAmount,
            resultDescription = recipe.resultDescription or "",
            ingredients       = ingredientList
        }
    end

    return result
end

local function playerHasCraftUnlocked(player)
    return player:getStorageValue(CRAFT_UNLOCK_STORAGE) ~= -1
end

local function findRecipeByIndex(index)
    return recipes[index]
end

local function playerHasIngredients(player, recipe)
    for _, ingredient in ipairs(recipe.ingredients) do
        if player:getItemCount(ingredient.clientId) < ingredient.amount then
            return false, ingredient
        end
    end

    return true, nil
end

local function removeIngredients(player, recipe)
    for _, ingredient in ipairs(recipe.ingredients) do
        player:removeItem(ingredient.clientId, ingredient.amount)
    end
end

local function handleRequest(player)
    if not playerHasCraftUnlocked(player) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa completar a quest para acessar o Craft Bench.")
        return
    end

    player:sendExtendedOpcode(CRAFTBENCH_OPCODE, json.encode({
        action  = "data",
        recipes = buildRecipeList()
    }))
end

local function handleCraft(player, recipeIndex)
    if not playerHasCraftUnlocked(player) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa completar a quest para acessar o Craft Bench.")
        return
    end

    local recipe = findRecipeByIndex(recipeIndex)

    if not recipe then
        return
    end

    local hasIngredients, missingIngredient = playerHasIngredients(player, recipe)

    if not hasIngredients then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You don't have enough " .. missingIngredient.itemName .. ".")

        player:sendExtendedOpcode(CRAFTBENCH_OPCODE, json.encode({
            action  = "craftResult",
            success = false
        }))
        return
    end

    removeIngredients(player, recipe)
    player:addItem(recipe.resultClientId, recipe.resultAmount)

    player:sendTextMessage(
        MESSAGE_EVENT_ADVANCE,
        "You crafted " .. recipe.resultAmount .. "x " .. recipe.resultName .. "!"
    )

    player:sendExtendedOpcode(CRAFTBENCH_OPCODE, json.encode({
        action  = "craftResult",
        success = true
    }))
end

local craftBenchEvent = CreatureEvent("CraftBenchOpcode")
craftBenchEvent:type("extendedopcode")

craftBenchEvent:onExtendedOpcode(function(player, opcode, buffer)
    if opcode ~= CRAFTBENCH_OPCODE then
        return true
    end

    local data, pos, err = json.decode(buffer)

    if err or not data or not data.action then
        return true
    end

    if data.action == "request" then
        handleRequest(player)
    elseif data.action == "craft" then
        handleCraft(player, data.recipeIndex)
    end

    return true
end)

craftBenchEvent:register()

local craftBenchLoginEvent = CreatureEvent("CraftBenchLogin")
craftBenchLoginEvent:type("login")

craftBenchLoginEvent:onLogin(function(player)
    player:registerEvent("CraftBenchOpcode")
    return true
end)

craftBenchLoginEvent:register()

local craftBenchItem = Action()

function craftBenchItem.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local inFight = player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)

    if inFight then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can't use this during a fight.")
        return true
    end

    handleRequest(player)
    return true
end

craftBenchItem:id(60523)
craftBenchItem:register()