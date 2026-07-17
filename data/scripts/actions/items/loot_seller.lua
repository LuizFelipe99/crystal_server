sellingTable = {}

local count = 0
for _, eachType in pairs(LootShopConfigTable) do
    for _, eachItem in ipairs(eachType) do
        local insertItem = {name = eachItem.itemName, sell = eachItem.sell}
        table.insert(sellingTable, eachItem.clientId, insertItem)
        count = count + 1
    end
end

logger.info("The price list for the Loot Seller has been updated, with "..count.." items.")

local conf = {
    toggleLogger = true, -- if send terminal message when player use the item
    itemSellerId = 60257, -- register the item
    exhaust = 30,
    lootPouchId = 23721, -- pouchId
    percentPrice = 0.95, -- if u want to change to lose price, use 0.9 to earn 90% of origin price, 0.55 to 55% etc...
    maxValueSell = 300, -- TAKE CARE, it is counted by slots NOT BY COUNT OF STACKABLES, 200 I think is a safe number
	
	-- configure itens for sell in data/scripts/lib/shop.lua
}

local itemSeller = Action()

function itemSeller.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getExhaustion("itemSellerExhaustion") > 0 then
        player:sendCancelMessage("You must to wait 30 seconds between uses of this item.")
        return true
    end

    -- Find loot pouches more efficiently
    local lootPouch = player:getItemById(conf.lootPouchId, true)
    local lootPouchStore = nil
    
    local inbox = player:getStoreInbox()
    if inbox then
        local inboxItems = inbox:getItems()
        for i = 1, #inboxItems do
            local pouch = inboxItems[i]
            if pouch:getId() == conf.lootPouchId then
                lootPouchStore = Container(pouch:getUniqueId())
                break
            end
        end
    end

    if not lootPouch and not lootPouchStore then
        player:sendCancelMessage("You don't have a loot pouch.")
        player:setExhaustion("itemSellerExhaustion", conf.exhaust)
        return true
    end

    -- Check if we have items to sell
    local totalItems = 0
    if lootPouch then totalItems = totalItems + lootPouch:getItemHoldingCount() end
    if lootPouchStore then totalItems = totalItems + lootPouchStore:getItemHoldingCount() end
    
    if totalItems < 1 then
        return player:sendCancelMessage("You don't have anything to sell.")
    end

    -- Process items more efficiently
    local totalEarn = 0
    local totalSold = 0
    local itemsProcessed = 0
    
    -- Function to process a single container
    local function processContainer(container)
        if not container or itemsProcessed >= conf.maxValueSell then return end
        
        local containerItems = container:getItems()
        for i = 1, #containerItems do
            if itemsProcessed >= conf.maxValueSell then break end
            
            local currentItem = containerItems[i]
            if not currentItem:isContainer() then
                local itemId = currentItem:getId()
                local sellData = sellingTable[itemId]
                
                if sellData then
                    local count = currentItem:getCount()
                    if currentItem:remove() then
                        totalSold = totalSold + count
                        totalEarn = totalEarn + (count * sellData.sell * conf.percentPrice)
                        itemsProcessed = itemsProcessed + 1
                    end
                end
            end
        end
    end

    -- Process store pouch first, then regular pouch
    processContainer(lootPouchStore)
    processContainer(lootPouch)

    player:setExhaustion("itemSellerExhaustion", conf.exhaust)
    
    if totalSold < 1 then
        player:sendCancelMessage("You have some items, but none of them are sellable.")
        return true 
    end
    
    Bank.credit(player:getName(), totalEarn)
    player:sendTextMessage(MESSAGE_TRADE, "You sold " .. totalSold .. " items and received " .. totalEarn .. " gold coins, transferred to your bank account.")
    
    if conf.toggleLogger then 
        logger.info(player:getName() .. " used itemSeller and sold " .. totalSold .. " items, received " .. totalEarn .. " gold coins.")
    end
    
    return true
end

itemSeller:id(conf.itemSellerId)
itemSeller:register()