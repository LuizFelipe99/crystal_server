local json = dofile("data/libs/dkjson.lua")
dofile("data/scripts/store_packs/store_packs_config.lua")

local STORE_PACKS_OPCODE = StorePacksConfig.opcode
local requestThrottle = RequestThrottle.new(500)

local function findPack(packId)
	for _, pack in ipairs(StorePacksConfig.packs) do
		if pack.id == packId then
			return pack
		end
	end
	return nil
end

local function orderPackItems(pack, knownItemOrder)
	local orderedItems = {}
	for index, packItem in ipairs(pack.items) do
		orderedItems[#orderedItems + 1] = { packItem = packItem, rank = knownItemOrder[packItem.itemId] or math.huge, position = index }
	end
	table.sort(orderedItems, function(left, right)
		if left.rank == right.rank then
			return left.position < right.position
		end
		return left.rank < right.rank
	end)
	return orderedItems
end

local function registerItemOrder(orderedItems, knownItemOrder, nextRank)
	for _, entry in ipairs(orderedItems) do
		if not knownItemOrder[entry.packItem.itemId] then
			knownItemOrder[entry.packItem.itemId] = nextRank
			nextRank = nextRank + 1
		end
	end
	return nextRank
end

local function buildPackItemsPayload(orderedItems)
	local itemsPayload = {}
	for _, entry in ipairs(orderedItems) do
		local packItem = entry.packItem
		local itemType = ItemType(packItem.itemId)
		itemsPayload[#itemsPayload + 1] = {
			clientId = packItem.itemId,
			count = packItem.count,
			name = packItem.name or itemType:getName(),
		}
	end
	return itemsPayload
end

local function buildPacksPayload()
	local packsPayload = {}
	local knownItemOrder = {}
	local nextRank = 1
	for _, pack in ipairs(StorePacksConfig.packs) do
		local orderedItems = orderPackItems(pack, knownItemOrder)
		nextRank = registerItemOrder(orderedItems, knownItemOrder, nextRank)
		packsPayload[#packsPayload + 1] = {
			id = pack.id,
			name = pack.name,
			banner = pack.banner,
			price = pack.price,
			items = buildPackItemsPayload(orderedItems),
		}
	end
	return packsPayload
end

local function sendToPlayer(player, payload)
	player:sendExtendedOpcode(STORE_PACKS_OPCODE, json.encode(payload))
end

local function sendPacks(player)
	sendToPlayer(player, {
		action = "packs",
		balance = player:getTransferableCoins(),
		packs = buildPacksPayload(),
	})
end

local function sendPurchaseResult(player, success, message)
	sendToPlayer(player, {
		action = "purchaseResult",
		success = success,
		message = message,
		balance = player:getTransferableCoins(),
	})
end

local function countInboxSlotsNeeded(pack)
	local slotsNeeded = 0
	for _, packItem in ipairs(pack.items) do
		local itemType = ItemType(packItem.itemId)
		if itemType:isStackable() then
			slotsNeeded = slotsNeeded + math.ceil(packItem.count / itemType:getStackSize())
		elseif itemType:getCharges() > 0 then
			slotsNeeded = slotsNeeded + 1
		else
			slotsNeeded = slotsNeeded + packItem.count
		end
	end
	return slotsNeeded
end

local function hasInboxRoom(player, pack)
	local inbox = player:getStoreInbox()
	if not inbox then
		return false
	end
	return #inbox:getItems(true) + countInboxSlotsNeeded(pack) <= inbox:getMaxCapacity()
end

local function deliverPackItems(player, pack)
	for _, packItem in ipairs(pack.items) do
		local itemType = ItemType(packItem.itemId)
		if itemType:isStackable() or itemType:getCharges() > 0 then
			player:addItemStoreInbox(packItem.itemId, packItem.count, true, false)
		else
			for _ = 1, packItem.count do
				player:addItemStoreInbox(packItem.itemId, 1, true, false)
			end
		end
	end
end

local function registerPurchaseHistory(player, pack)
	if not GameStore or not GameStore.insertHistory then
		return
	end
	GameStore.insertHistory(player:getAccountId(), GameStore.HistoryTypes.HISTORY_TYPE_NONE, pack.name, pack.price * -1, GameStore.CoinType.Transferable)
end

local function refreshStoreBalance(player)
	if sendStoreBalanceUpdating then
		sendStoreBalanceUpdating(player:getId(), true)
	end
end

local function announcePurchase(buyer, pack)
	local announcement = json.encode({
		action = "announcement",
		playerName = buyer:getName(),
		packName = pack.name,
	})
	for _, onlinePlayer in ipairs(Game.getPlayers()) do
		onlinePlayer:sendExtendedOpcode(STORE_PACKS_OPCODE, announcement)
	end
end

local function handlePurchase(player, packId)
	local pack = findPack(packId)
	if not pack then
		sendPurchaseResult(player, false, "This pack is not available.")
		return
	end

	if player:getTransferableCoins() < pack.price then
		sendPurchaseResult(player, false, "You don't have enough transferable Tibia Coins.")
		return
	end

	if not hasInboxRoom(player, pack) then
		sendPurchaseResult(player, false, "Your store inbox doesn't have enough free slots for this pack.")
		return
	end

	if not player:removeTransferableCoins(pack.price) then
		sendPurchaseResult(player, false, "The purchase could not be completed. Please try again.")
		return
	end

	deliverPackItems(player, pack)
	registerPurchaseHistory(player, pack)
	refreshStoreBalance(player)
	player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
	logger.info("[StorePacks] {} bought {} for {} transferable coins", player:getName(), pack.name, pack.price)
	sendPurchaseResult(player, true, "You bought the " .. pack.name .. ". The items were sent to your store inbox.")
	announcePurchase(player, pack)
end

local storePacksEvent = CreatureEvent("StorePacksOpcode")
storePacksEvent:type("extendedopcode")

storePacksEvent:onExtendedOpcode(function(player, opcode, buffer)
	if opcode ~= STORE_PACKS_OPCODE then
		return true
	end
	if requestThrottle:isThrottled(player) then
		return true
	end

	local data, _, decodeError = json.decode(buffer)
	if decodeError or type(data) ~= "table" then
		return true
	end

	if data.action == "request" then
		sendPacks(player)
	elseif data.action == "buy" then
		handlePurchase(player, tonumber(data.packId))
	end
	return true
end)

storePacksEvent:register()

local storePacksLoginEvent = CreatureEvent("StorePacksLogin")
storePacksLoginEvent:type("login")

storePacksLoginEvent:onLogin(function(player)
	player:registerEvent("StorePacksOpcode")
	return true
end)

storePacksLoginEvent:register()
