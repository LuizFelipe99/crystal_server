local config = {
    leverPosition = Position(32201, 32294, 5),
    leverActionId = 41999,
    requiredItemId = 63060,
    leverIds = {
        inactive = 2773,
        active = 2772
    },
    positions = {
        {x = 32207, y = 32292, z = 5},
        {x = 32206, y = 32292, z = 5},
        {x = 32205, y = 32292, z = 5},
        {x = 32204, y = 32292, z = 5},
        {x = 32203, y = 32292, z = 5},
        {x = 32202, y = 32292, z = 5},
        {x = 32201, y = 32292, z = 5}, -- meio / recompensa
        {x = 32200, y = 32292, z = 5},
        {x = 32199, y = 32292, z = 5},
        {x = 32198, y = 32292, z = 5},
        {x = 32197, y = 32292, z = 5},
        {x = 32196, y = 32292, z = 5},
        {x = 32195, y = 32292, z = 5}
    },
    winningPositionIndex = 7,
    items = {

        {id = 62108, minCount = 1, maxCount = 1, chance = 1}, -- health gem lvl 1
        {id = 62115, minCount = 1, maxCount = 1, chance = 1}, -- health gem lvl 2
        {id = 62013, minCount = 1, maxCount = 1, chance = 1}, -- health gem lvl 3

        {id = 62105, minCount = 1, maxCount = 1, chance = 1}, -- mana gem lvl 1
        {id = 62112, minCount = 1, maxCount = 1, chance = 1}, -- mana gem lvl 2
        {id = 62018, minCount = 1, maxCount = 1, chance = 1}, -- mana gem lvl 3
        
        {id = 62107, minCount = 1, maxCount = 1, chance = 1}, -- critical chance gem lvl 1
        {id = 62114, minCount = 1, maxCount = 1, chance = 1}, -- critical chance gem lvl 2
        {id = 62015, minCount = 1, maxCount = 1, chance = 1}, -- critical chance gem lvl 3
        
        {id = 62111, minCount = 1, maxCount = 1, chance = 1}, -- critical damage gem lvl 1
        {id = 62118, minCount = 1, maxCount = 1, chance = 1}, -- critical damage gem lvl 2
        {id = 62065, minCount = 1, maxCount = 1, chance = 1}, -- critical damage gem lvl 3
        
        {id = 62106, minCount = 1, maxCount = 1, chance = 1}, -- attackspeed gem lvl 1
        {id = 62113, minCount = 1, maxCount = 1, chance = 1}, -- attackspeed gem lvl 2
        {id = 62014, minCount = 1, maxCount = 1, chance = 1}, -- attackspeed gem lvl 3
        
        {id = 63060, minCount = 1, maxCount = 1, chance = 2}, -- roulete coin
        {id = 60404, minCount = 1, maxCount = 1, chance = 2}, -- more points wheel
        {id = 3043,  minCount = 1, maxCount = 100, chance = 2}, -- crystal coin
        {id = 37110, minCount = 1, maxCount = 2, chance = 2}, -- exalted core
        {id = 28484, minCount = 1, maxCount = 1, chance = 2}, -- blueberry cupcake
        {id = 28486, minCount = 1, maxCount = 1, chance = 2}, -- lmon cupcake
        {id = 28485, minCount = 1, maxCount = 1, chance = 2}, -- strawberry  cupcake
        {id = 36726, minCount = 1, maxCount = 1, chance = 2}, -- charm upgrade
        {id = 36724, minCount = 1, maxCount = 1, chance = 2}, -- Strike Enhancement
        {id = 18339, minCount = 1, maxCount = 1, chance = 2}, -- Zaoan Chess Box
        {id = 3734,  minCount = 1, maxCount = 1, chance = 2}, -- blood herb
        {id = 60445,  minCount = 1, maxCount = 1, chance = 2}, -- 25x prey wilcard
        
        {id = 64485, minCount = 1, maxCount = 1, chance = 2}, -- mount casket
        {id = 64484, minCount = 1, maxCount = 1, chance = 2}, -- addon casket

        {id = 63400, minCount = 1, maxCount = 2, chance = 2}, -- platinum ruby crafter
        {id = 60482, minCount = 1, maxCount = 2, chance = 2}, -- platinum small ruby crafter
        {id = 60489, minCount = 1, maxCount = 2, chance = 2}, -- platinum medium ruby crafter
        {id = 60496, minCount = 1, maxCount = 2, chance = 2}, -- platinum large ruby crafter

        {id = 60483, minCount = 1, maxCount = 2, chance = 2}, -- golden small ruby crafter
        {id = 60490, minCount = 1, maxCount = 2, chance = 2}, -- golden medium ruby crafter
        {id = 60497, minCount = 1, maxCount = 2, chance = 2}, -- golden large ruby crafter
        {id = 63401, minCount = 1, maxCount = 2, chance = 2}, -- golden ruby crafter

        {id = 36729, minCount = 1, maxCount = 1, chance = 2}, -- fire resilience
        {id = 36730, minCount = 1, maxCount = 1, chance = 2}, -- ice resilience
        {id = 36731, minCount = 1, maxCount = 1, chance = 2}, -- earth resilience
        {id = 36732, minCount = 1, maxCount = 1, chance = 2}, -- energy resilience
        {id = 36733, minCount = 1, maxCount = 1, chance = 2}, -- holy resilience
        {id = 36734, minCount = 1, maxCount = 1, chance = 2}, -- death resilience
        {id = 36735, minCount = 1, maxCount = 1, chance = 2}, -- physical resilience
        {id = 60606, minCount = 1, maxCount = 3, chance = 2}, -- all resilience

        {id = 36736, minCount = 1, maxCount = 1, chance = 2}, -- fire amplification
        {id = 36737, minCount = 1, maxCount = 1, chance = 2}, -- ice amplification
        {id = 36738, minCount = 1, maxCount = 1, chance = 2}, -- earth amplification
        {id = 36739, minCount = 1, maxCount = 1, chance = 2}, -- energy amplification
        {id = 36740, minCount = 1, maxCount = 1, chance = 2}, -- holy amplification
        {id = 36741, minCount = 1, maxCount = 1, chance = 2}, -- death amplification
        {id = 36742, minCount = 1, maxCount = 1, chance = 2}, -- physical amplification
        {id = 60605, minCount = 1, maxCount = 3, chance = 2}, -- all amplification

        {id = 60410, minCount = 1, maxCount = 1, chance = 1}, -- falcon bag
        {id = 60411, minCount = 1, maxCount = 1, chance = 1}, -- lion bag
        {id = 60413, minCount = 1, maxCount = 1, chance = 1}, -- scarlett bag
        {id = 60414, minCount = 1, maxCount = 1, chance = 1}, -- timira bag
        {id = 60412, minCount = 1, maxCount = 1, chance = 1}, -- ratmiral bag
        {id = 60312, minCount = 1, maxCount = 1, chance = 1}, -- init gem bag

        {id = 22118, minCount = 50, maxCount = 150, chance = 1, raro = true}, -- tibia coin
        {id = 34109, minCount = 1, maxCount = 1, chance = 0.5, raro = true}, -- bag you desire
        {id = 39546, minCount = 1, maxCount = 1, chance = 0.5, raro = true}, -- primal bag
        {id = 60422, minCount = 1, maxCount = 1, chance = 0.5, raro = true}, -- 7 dias scroll

        {id = 5903, minCount = 1, maxCount = 1, chance = 0.1, raro = true}, -- ferumbras hat
    },
    ultraRareItems = {22118, 34109, 39546, 60422, 5903},
    ultraRareChatChannel = 15,
    lastPositionClearDelayMs = 1000,
    baseIntervalMs = 20,
    minExtraSteps = 5,
    maxExtraSteps = 10,
    baseSteps = 10
}

local isRouletteRunning = false

local function revertLever(position)
    local tile = Tile(position)
    if not tile then
        return
    end

    local groundItem = tile:getGround()

    local topItem = tile:getTopDownItem()

    local leverItem = tile:getItemById(config.leverIds.active)
    if not leverItem then
        return
    end

    leverItem:transform(config.leverIds.inactive)
end

local function getRandomCount(item)
    if item.minCount and item.maxCount then
        return math.random(item.minCount, item.maxCount)
    end
    return item.count or 1
end

local function clearLastPosition()
    local lastPosition = config.positions[#config.positions]
    local tile = Tile(Position(lastPosition))
    if not tile then
        return
    end
    local item = tile:getTopDownItem()
    if not item then
        return
    end
    item:remove()
end

local function addItemToPlayer(player, item)
    local count = getRandomCount(item)
    player:addItem(item.id, count)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! you won " .. count .. "x " .. ItemType(item.id):getName() .. "!")
    player:getPosition():sendMagicEffect(244)

    if table.contains(config.ultraRareItems, item.id) then
        local message = player:getName() .. " won a ULTRA RARE item: " .. count .. "x " .. ItemType(item.id):getName() .. " on the roulette!"
        sendChannelMessage(config.ultraRareChatChannel, TALKTYPE_CHANNEL_Y, message)
        Game.broadcastMessage(message, MESSAGE_EVENT_ADVANCE)
        return
    end

    if item.raro then
        Game.broadcastMessage(player:getName() .. " won a rare item: " .. count .. "x " .. ItemType(item.id):getName() .. " on the roulette!", MESSAGE_EVENT_ADVANCE)
    end
end

local function getRandomItem()
    local totalWeight = 0
    for _, item in ipairs(config.items) do
        totalWeight = totalWeight + item.chance
    end

    local randomWeight = math.random() * totalWeight
    local cumulativeWeight = 0
    for _, item in ipairs(config.items) do
        cumulativeWeight = cumulativeWeight + item.chance
        if randomWeight <= cumulativeWeight then
            return item
        end
    end

    return config.items[#config.items]
end

local function moveItems()
    for i = #config.positions, 2, -1 do
        local tile = Tile(config.positions[i - 1])
        local item = tile and tile:getTopDownItem()
        if item then
            item:moveTo(config.positions[i])
        end
    end
end

local function clearItems()
    for _, position in ipairs(config.positions) do
        local tile = Tile(Position(position))
        if not tile then
            goto continue
        end
        local item = tile:getTopDownItem()
        while item do
            item:remove()
            item = tile:getTopDownItem()
        end
        ::continue::
    end
end

local function createItemWithEffect(position, item)
    local count = getRandomCount(item)
    Game.createItem(item.id, count, Position(position))
    Position(position):sendMagicEffect(244)
end

local function getItemConfigById(itemId)
    for _, item in ipairs(config.items) do
        if item.id == itemId then
            return item
        end
    end
    return nil
end

local function revealWinningItem(player)
    local winningItem = Tile(Position(config.positions[config.winningPositionIndex])):getTopDownItem()
    if not winningItem then
        return
    end

    local itemConfig = getItemConfigById(winningItem:getId())
    if not itemConfig then
        return
    end

    addItemToPlayer(player, itemConfig)
    Position(config.positions[config.winningPositionIndex]):sendMagicEffect(244)

    addEvent(clearLastPosition, config.lastPositionClearDelayMs)
end

local function advanceReel()
    local lastPositionTile = Tile(Position(config.positions[#config.positions]))
    if not lastPositionTile then
        return
    end
    local lastItem = lastPositionTile:getTopDownItem()
    if not lastItem then
        return
    end
    lastItem:remove()
    Position(config.positions[#config.positions]):sendMagicEffect(244)
end

local function rouletteAction(player)
    isRouletteRunning = true
    clearItems()

    local steps = config.baseSteps + math.random(config.minExtraSteps, config.maxExtraSteps)
    local interval = config.baseIntervalMs

    local currentItem = getRandomItem()
    createItemWithEffect(config.positions[1], currentItem)

    for i = 1, steps do
        addEvent(function()
            moveItems()

            if i == steps then
                revealWinningItem(player)
                isRouletteRunning = false
                return
            end

            advanceReel()
            currentItem = getRandomItem()
            createItemWithEffect(config.positions[1], currentItem)
        end, i * interval)

        interval = interval + config.baseIntervalMs
    end
end

local rouletteLever = Action()

function rouletteLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if isRouletteRunning then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Roulette running. Please wait.")
        return false
    end

    if fromPosition ~= config.leverPosition then
        return false
    end

    local tile = Tile(fromPosition)
    if not tile then
        return false
    end

    local leverItem = tile:getItemById(config.leverIds.inactive) or tile:getItemById(config.leverIds.active)
    if not leverItem then
        return false
    end

    if not player:removeItem(config.requiredItemId, 1) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need a roulete coin.")
        return false
    end

    leverItem:transform(config.leverIds.active)
    addEvent(revertLever, 5 * 1000, fromPosition)
    rouletteAction(player)
    return true
end

rouletteLever:aid(config.leverActionId)
rouletteLever:register()