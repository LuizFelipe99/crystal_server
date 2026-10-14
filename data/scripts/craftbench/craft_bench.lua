local json = dofile("data/libs/dkjson.lua")

local CRAFTBENCH_OPCODE = 13
local CRAFT_UNLOCK_STORAGE = 91003
local LOCKED_MESSAGE = "You need to complete the quest to access the Craft Bench."
local requestThrottle = RequestThrottle.new(300)
local PARTIAL_LOSS_CATEGORY = "atribute_gem"
local PARTIAL_LOSS_MINIMUM = 0

local craftRecipes = dofile("data/scripts/craftbench/craft_recipes.lua")
local desmancheRecipes = dofile("data/scripts/craftbench/desmanche_recipes.lua")
local fusaoRecipes = dofile("data/scripts/craftbench/fusao_recipes.lua")

local tabConfigs = {
    craft = {
        recipes       = craftRecipes,
        consumesKey   = "ingredients",
        producesKey   = "result",
        unlockStorage = CRAFT_UNLOCK_STORAGE,
        lockedMessage = LOCKED_MESSAGE,
    },
    desmanche = {
        recipes       = desmancheRecipes,
        consumesKey   = "result",
        producesKey   = "ingredients",
        unlockStorage = CRAFT_UNLOCK_STORAGE,
        lockedMessage = LOCKED_MESSAGE,
    },
    fusao = {
        recipes       = fusaoRecipes,
        consumesKey   = "ingredients",
        producesKey   = "result",
        unlockStorage = CRAFT_UNLOCK_STORAGE,
        lockedMessage = LOCKED_MESSAGE,
    },
}

local RESOURCE_DEFINITIONS = {
    { clientId = 60483, name = "Golden Ruby Crafter Nv. 1",   group = "gold" },
    { clientId = 60490, name = "Golden Ruby Crafter Nv. 2",   group = "gold" },
    { clientId = 60497, name = "Golden Ruby Crafter Nv. 3",   group = "gold" },
    { clientId = 63401, name = "Golden Ruby Crafter Nv. 4",   group = "gold" },
    { clientId = 60482, name = "Platinum Ruby Crafter Nv. 1", group = "platinum" },
    { clientId = 60489, name = "Platinum Ruby Crafter Nv. 2", group = "platinum" },
    { clientId = 60496, name = "Platinum Ruby Crafter Nv. 3", group = "platinum" },
    { clientId = 63400, name = "Platinum Ruby Crafter Nv. 4", group = "platinum" },
}

local function buildMaterialGroups()
    local materialGroups = {}

    for _, definition in ipairs(RESOURCE_DEFINITIONS) do
        materialGroups[definition.group] = materialGroups[definition.group] or {}
        table.insert(materialGroups[definition.group], definition.clientId)
    end

    return materialGroups
end

local function getTotalGold(player)
    return player:getMoney() + player:getBankBalance()
end

local function hasEnoughGold(player, cost)
    return getTotalGold(player) >= cost
end

local function rollSuccess(recipe)
    local chance = recipe.successChance or 100
    return math.random(1, 100) <= chance
end

local function spendGold(player, amount)
    local bagMoney = player:getMoney()
    local bagSpend = math.min(bagMoney, amount)
    local bankSpend = amount - bagSpend

    if bagSpend > 0 then
        player:removeMoney(bagSpend)
    end

    if bankSpend > 0 then
        player:setBankBalance(player:getBankBalance() - bankSpend)
    end
end

local function buildResourceSnapshot(player)
    local itemAmounts = {}
    local slots = {}

    for _, definition in ipairs(RESOURCE_DEFINITIONS) do
        local amount = player:getItemCount(definition.clientId)
        itemAmounts[tostring(definition.clientId)] = amount
        slots[#slots + 1] = {
            clientId = definition.clientId,
            name     = definition.name,
            group    = definition.group,
            amount   = amount
        }
    end

    return {
        gold  = getTotalGold(player),
        items = itemAmounts,
        slots = slots
    }
end

local function playerHasUnlocked(player, tabConfig)
    return player:getStorageValue(tabConfig.unlockStorage) ~= -1
end

local function findRecipeByIndex(tabConfig, index)
    return tabConfig.recipes[index]
end

local function getItemList(recipe, key)
    if key == "result" then
        return { { itemName = recipe.resultName, clientId = recipe.resultClientId, amount = recipe.resultAmount } }
    end

    return recipe.ingredients
end

local function resolveItemAmount(item)
    if item.minAmount and item.maxAmount then
        return math.random(item.minAmount, item.maxAmount)
    end

    return item.amount
end

local function playerHasItems(player, itemList)
    for _, item in ipairs(itemList) do
        if player:getItemCount(item.clientId) < item.amount then
            return false, item
        end
    end

    return true, nil
end

local function removeItems(player, itemList)
    for _, item in ipairs(itemList) do
        player:removeItem(item.clientId, item.amount)
    end
end

local function usesPartialLossOnFail(recipe)
    return recipe.vocation == PARTIAL_LOSS_CATEGORY
end

local function removeRandomPortion(player, itemList)
    local totalLost = 0
    for _, item in ipairs(itemList) do
        local lostAmount = math.random(PARTIAL_LOSS_MINIMUM, item.amount)
        if lostAmount > 0 then
            player:removeItem(item.clientId, lostAmount)
            totalLost = totalLost + lostAmount
        end
    end
    return totalLost
end

local function describePartialLoss(totalLost)
    if totalLost == 0 then
        return "The operation failed, but you kept all your gems."
    end

    if totalLost == 1 then
        return "The operation failed. You lost 1 gem."
    end

    return "The operation failed. You lost " .. totalLost .. " gems."
end

local function resolveFailure(player, recipe, requiredItems)
    if not usesPartialLossOnFail(recipe) then
        removeItems(player, requiredItems)
        return "The operation failed. Your materials were lost."
    end

    return describePartialLoss(removeRandomPortion(player, requiredItems))
end

local function grantItems(player, itemList)
    for _, item in ipairs(itemList) do
        player:addItem(item.clientId, resolveItemAmount(item))
    end
end

local function buildIngredientPayload(ingredient, ownedAmount)
    if ingredient.minAmount and ingredient.maxAmount then
        return {
            name      = ingredient.itemName,
            clientId  = ingredient.clientId,
            minAmount = ingredient.minAmount,
            maxAmount = ingredient.maxAmount,
            owned     = ownedAmount
        }
    end

    return {
        name     = ingredient.itemName,
        clientId = ingredient.clientId,
        amount   = ingredient.amount,
        owned    = ownedAmount
    }
end

local function buildRecipeList(recipes, tabConfig, player)
    local result = {}

    local consumesIngredients = tabConfig.consumesKey == "ingredients"
    local totalGold = getTotalGold(player)

    for i, recipe in ipairs(recipes) do
        local ingredientList = {}

        for _, ingredient in ipairs(recipe.ingredients) do
            local ownedAmount = consumesIngredients and player:getItemCount(ingredient.clientId) or nil
            ingredientList[#ingredientList + 1] = buildIngredientPayload(ingredient, ownedAmount)
        end

        local requiredItems = getItemList(recipe, tabConfig.consumesKey)
        local hasRequiredItems = playerHasItems(player, requiredItems)
        local hasEnoughGoldForRecipe = totalGold >= (recipe.goldCost or 0)

        result[#result + 1] = {
            index             = i,
            resultName        = recipe.resultName,
            resultClientId    = recipe.resultClientId,
            resultAmount      = recipe.resultAmount,
            resultDescription = recipe.resultDescription or "",
            classification    = recipe.classification or 0,
            vocation          = recipe.vocation or "",
            goldCost          = recipe.goldCost or 0,
            successChance     = recipe.successChance or 100,
            hasRequiredItems  = hasRequiredItems,
            hasEnoughGold     = hasEnoughGoldForRecipe,
            canExecute        = hasRequiredItems and hasEnoughGoldForRecipe,
            resultOwned       = (not consumesIngredients) and player:getItemCount(recipe.resultClientId) or nil,
            ingredients       = ingredientList
        }
    end

    return result
end

local function sendTabData(player, tabName, tabConfig)
    player:sendExtendedOpcode(CRAFTBENCH_OPCODE, json.encode({
        action    = "data",
        tab       = tabName,
        recipes   = buildRecipeList(tabConfig.recipes, tabConfig, player),
        resources = buildResourceSnapshot(player),
        materialGroups = buildMaterialGroups()
    }))
end

local function sendExecutionResult(player, tabName, tabConfig, success, message)
    player:sendExtendedOpcode(CRAFTBENCH_OPCODE, json.encode({
        action    = "result",
        tab       = tabName,
        success   = success,
        message   = message,
        recipes   = buildRecipeList(tabConfig.recipes, tabConfig, player),
        resources = buildResourceSnapshot(player)
    }))
end

local function handleRequest(player, tabName)
    local tabConfig = tabConfigs[tabName]

    if not tabConfig then
        return
    end

    if not playerHasUnlocked(player, tabConfig) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, tabConfig.lockedMessage)
        return
    end

    sendTabData(player, tabName, tabConfig)
end

local function handleExecute(player, tabName, recipeIndex)
    local tabConfig = tabConfigs[tabName]

    if not tabConfig then
        return
    end

    if not playerHasUnlocked(player, tabConfig) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, tabConfig.lockedMessage)
        return
    end

    local recipe = findRecipeByIndex(tabConfig, recipeIndex)

    if not recipe then
        return
    end

    local requiredItems = getItemList(recipe, tabConfig.consumesKey)

    if #requiredItems == 0 then
        logger.warn("[CraftBench] Recipe '{}' has no required items and was blocked.", recipe.resultName)
        return
    end
    local rewardItems = getItemList(recipe, tabConfig.producesKey)
    local goldCost = recipe.goldCost or 0

    local hasRequiredItems, missingItem = playerHasItems(player, requiredItems)

    if not hasRequiredItems then
        local message = "You don't have enough " .. missingItem.itemName .. "."
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
        sendExecutionResult(player, tabName, tabConfig, false, message)
        return
    end

    if goldCost > 0 and not hasEnoughGold(player, goldCost) then
        local message = "You don't have enough gold for this operation."
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
        sendExecutionResult(player, tabName, tabConfig, false, message)
        return
    end

    if goldCost > 0 then
        spendGold(player, goldCost)
    end

    local succeeded = rollSuccess(recipe)
    local message

    if succeeded then
        removeItems(player, requiredItems)
        grantItems(player, rewardItems)
        message = "Operation completed successfully."
    else
        message = resolveFailure(player, recipe, requiredItems)
    end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
    sendExecutionResult(player, tabName, tabConfig, succeeded, message)
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

    if requestThrottle:isThrottled(player) then
        return true
    end

    local tabName = data.tab or "craft"

    if data.action == "request" then
        handleRequest(player, tabName)
    elseif data.action == "execute" then
        handleExecute(player, tabName, data.recipeIndex)
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
    handleRequest(player, "craft")
    return true
end

craftBenchItem:id(60523)
craftBenchItem:register()