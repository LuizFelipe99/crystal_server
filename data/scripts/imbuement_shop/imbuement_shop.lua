local IMBUEMENT_KITS = {
	{
		name = "Strike",
		category = "Critical Hit",
		iconId = 1,
		tiers = {
			{ level = 1, price = 1200, items = { { itemId = 11444, amount = 20 } } },
			{ level = 2, price = 11200, items = { { itemId = 11444, amount = 20 }, { itemId = 10311, amount = 25 } } },
			{ level = 3, price = 16700, items = { { itemId = 11444, amount = 20 }, { itemId = 10311, amount = 25 }, { itemId = 22728, amount = 5 } } },
		},
	},
	{
		name = "Electrify",
		category = "Elemental Damage",
		iconId = 10,
		tiers = {
			{ level = 1, price = 1750, items = { { itemId = 18993, amount = 25 } } },
			{ level = 2, price = 3500, items = { { itemId = 18993, amount = 25 }, { itemId = 21975, amount = 5 } } },
			{ level = 3, price = 3770, items = { { itemId = 18993, amount = 25 }, { itemId = 21975, amount = 5 }, { itemId = 23508, amount = 1 } } },
		},
	},
	{
		name = "Frost",
		category = "Elemental Damage",
		iconId = 19,
		tiers = {
			{ level = 1, price = 7000, items = { { itemId = 9661, amount = 25 } } },
			{ level = 2, price = 9600, items = { { itemId = 9661, amount = 25 }, { itemId = 21801, amount = 10 } } },
			{ level = 3, price = 9750, items = { { itemId = 9661, amount = 25 }, { itemId = 21801, amount = 10 }, { itemId = 9650, amount = 5 } } },
		},
	},
	{
		name = "Reap",
		category = "Elemental Damage",
		iconId = 4,
		tiers = {
			{ level = 1, price = 625, items = { { itemId = 11484, amount = 25 } } },
			{ level = 2, price = 2225, items = { { itemId = 11484, amount = 25 }, { itemId = 9647, amount = 20 } } },
			{ level = 3, price = 3475, items = { { itemId = 11484, amount = 25 }, { itemId = 9647, amount = 20 }, { itemId = 10420, amount = 5 } } },
		},
	},
	{
		name = "Scorch",
		category = "Elemental Damage",
		iconId = 13,
		tiers = {
			{ level = 1, price = 9375, items = { { itemId = 9636, amount = 25 } } },
			{ level = 2, price = 9875, items = { { itemId = 9636, amount = 25 }, { itemId = 5920, amount = 5 } } },
			{ level = 3, price = 14875, items = { { itemId = 9636, amount = 25 }, { itemId = 5920, amount = 5 }, { itemId = 5954, amount = 5 } } },
		},
	},
	{
		name = "Venom",
		category = "Elemental Damage",
		iconId = 7,
		tiers = {
			{ level = 1, price = 500, items = { { itemId = 9686, amount = 25 } } },
			{ level = 2, price = 1500, items = { { itemId = 9686, amount = 25 }, { itemId = 9640, amount = 20 } } },
			{ level = 3, price = 1820, items = { { itemId = 9686, amount = 25 }, { itemId = 9640, amount = 20 }, { itemId = 21194, amount = 2 } } },
		},
	},
	{
		name = "Lich Shroud",
		category = "Elemental Protection (Death)",
		iconId = 25,
		tiers = {
			{ level = 1, price = 750, items = { { itemId = 11466, amount = 25 } } },
			{ level = 2, price = 2150, items = { { itemId = 11466, amount = 25 }, { itemId = 22007, amount = 20 } } },
			{ level = 3, price = 5650, items = { { itemId = 11466, amount = 25 }, { itemId = 22007, amount = 20 }, { itemId = 9660, amount = 5 } } },
		},
	},
	{
		name = "Snake Skin",
		category = "Elemental Protection (Earth)",
		iconId = 28,
		tiers = {
			{ level = 1, price = 750, items = { { itemId = 17823, amount = 25 } } },
			{ level = 2, price = 8750, items = { { itemId = 17823, amount = 25 }, { itemId = 9694, amount = 20 } } },
			{ level = 3, price = 12550, items = { { itemId = 17823, amount = 25 }, { itemId = 9694, amount = 20 }, { itemId = 11702, amount = 10 } } },
		},
	},
	{
		name = "Cloud Fabric",
		category = "Elemental Protection (Energy)",
		iconId = 31,
		tiers = {
			{ level = 1, price = 5300, items = { { itemId = 9644, amount = 20 } } },
			{ level = 2, price = 8450, items = { { itemId = 9644, amount = 20 }, { itemId = 14079, amount = 15 } } },
			{ level = 3, price = 12450, items = { { itemId = 9644, amount = 20 }, { itemId = 14079, amount = 15 }, { itemId = 9665, amount = 10 } } },
		},
	},
	{
		name = "Dragon Hide",
		category = "Elemental Protection (Fire)",
		iconId = 34,
		tiers = {
			{ level = 1, price = 2000, items = { { itemId = 5877, amount = 20 } } },
			{ level = 2, price = 8100, items = { { itemId = 5877, amount = 20 }, { itemId = 16131, amount = 10 } } },
			{ level = 3, price = 10850, items = { { itemId = 5877, amount = 20 }, { itemId = 16131, amount = 10 }, { itemId = 11658, amount = 5 } } },
		},
	},
	{
		name = "Demon Presence",
		category = "Elemental Protection (Holy)",
		iconId = 37,
		tiers = {
			{ level = 1, price = 3750, items = { { itemId = 9639, amount = 25 } } },
			{ level = 2, price = 10750, items = { { itemId = 9639, amount = 25 }, { itemId = 9638, amount = 25 } } },
			{ level = 3, price = 20250, items = { { itemId = 9639, amount = 25 }, { itemId = 9638, amount = 25 }, { itemId = 10304, amount = 20 } } },
		},
	},
	{
		name = "Quara Scale",
		category = "Elemental Protection (Ice)",
		iconId = 40,
		tiers = {
			{ level = 1, price = 500, items = { { itemId = 10295, amount = 25 } } },
			{ level = 2, price = 2750, items = { { itemId = 10295, amount = 25 }, { itemId = 10307, amount = 15 } } },
			{ level = 3, price = 4550, items = { { itemId = 10295, amount = 25 }, { itemId = 10307, amount = 15 }, { itemId = 14012, amount = 10 } } },
		},
	},
	{
		name = "Featherweight",
		category = "Increase Capacity",
		iconId = 76,
		tiers = {
			{ level = 1, price = 4000, items = { { itemId = 25694, amount = 20 } } },
			{ level = 2, price = 9000, items = { { itemId = 25694, amount = 20 }, { itemId = 25702, amount = 10 } } },
			{ level = 3, price = 12250, items = { { itemId = 25694, amount = 20 }, { itemId = 25702, amount = 10 }, { itemId = 20205, amount = 5 } } },
		},
	},
	{
		name = "Swiftness",
		category = "Increase Speed",
		iconId = 73,
		tiers = {
			{ level = 1, price = 300, items = { { itemId = 17458, amount = 15 } } },
			{ level = 2, price = 1425, items = { { itemId = 17458, amount = 15 }, { itemId = 10302, amount = 25 } } },
			{ level = 3, price = 5225, items = { { itemId = 17458, amount = 15 }, { itemId = 10302, amount = 25 }, { itemId = 14081, amount = 20 } } },
		},
	},
	{
		name = "Vampirism",
		category = "Life Leech",
		iconId = 46,
		tiers = {
			{ level = 1, price = 6875, items = { { itemId = 9685, amount = 25 } } },
			{ level = 2, price = 8375, items = { { itemId = 9685, amount = 25 }, { itemId = 9633, amount = 15 } } },
			{ level = 3, price = 10475, items = { { itemId = 9685, amount = 25 }, { itemId = 9633, amount = 15 }, { itemId = 9663, amount = 5 } } },
		},
	},
	{
		name = "Void",
		category = "Mana Leech",
		iconId = 49,
		tiers = {
			{ level = 1, price = 1650, items = { { itemId = 11492, amount = 25 } } },
			{ level = 2, price = 11400, items = { { itemId = 11492, amount = 25 }, { itemId = 20200, amount = 25 } } },
			{ level = 3, price = 17400, items = { { itemId = 11492, amount = 25 }, { itemId = 20200, amount = 25 }, { itemId = 22730, amount = 5 } } },
		},
	},
	{
		name = "Vibrancy",
		category = "Paralysis Removal",
		iconId = 79,
		tiers = {
			{ level = 1, price = 3500, items = { { itemId = 22053, amount = 20 } } },
			{ level = 2, price = 9500, items = { { itemId = 22053, amount = 20 }, { itemId = 23507, amount = 15 } } },
			{ level = 3, price = 15000, items = { { itemId = 22053, amount = 20 }, { itemId = 23507, amount = 15 }, { itemId = 28567, amount = 5 } } },
		},
	},
	{
		name = "Chop",
		category = "Skillboost (Axe Fighting)",
		iconId = 52,
		tiers = {
			{ level = 1, price = 3000, items = { { itemId = 10196, amount = 20 } } },
			{ level = 2, price = 10250, items = { { itemId = 10196, amount = 20 }, { itemId = 11447, amount = 25 } } },
			{ level = 3, price = 13050, items = { { itemId = 10196, amount = 20 }, { itemId = 11447, amount = 25 }, { itemId = 21200, amount = 20 } } },
		},
	},
	{
		name = "Bash",
		category = "Skillboost (Club Fighting)",
		iconId = 55,
		tiers = {
			{ level = 1, price = 1100, items = { { itemId = 9657, amount = 20 } } },
			{ level = 2, price = 4250, items = { { itemId = 9657, amount = 20 }, { itemId = 22189, amount = 15 } } },
			{ level = 3, price = 6250, items = { { itemId = 9657, amount = 20 }, { itemId = 22189, amount = 15 }, { itemId = 10405, amount = 10 } } },
		},
	},
	{
		name = "Precision",
		category = "Skillboost (Distance Fighting)",
		iconId = 58,
		tiers = {
			{ level = 1, price = 1250, items = { { itemId = 11464, amount = 25 } } },
			{ level = 2, price = 3550, items = { { itemId = 11464, amount = 25 }, { itemId = 18994, amount = 20 } } },
			{ level = 3, price = 6750, items = { { itemId = 11464, amount = 25 }, { itemId = 18994, amount = 20 }, { itemId = 10298, amount = 10 } } },
		},
	},
	{
		name = "Punch",
		category = "Skillboost (Fist Fighting)",
		iconId = 61,
		tiers = {
			{ level = 1, price = 2000, items = { { itemId = 10281, amount = 25 } } },
			{ level = 2, price = 7600, items = { { itemId = 10281, amount = 25 }, { itemId = 11489, amount = 20 } } },
			{ level = 3, price = 10225, items = { { itemId = 10281, amount = 25 }, { itemId = 11489, amount = 20 }, { itemId = 40529, amount = 15 } } },
		},
	},
	{
		name = "Epiphany",
		category = "Skillboost (Magic Level)",
		iconId = 64,
		tiers = {
			{ level = 1, price = 1125, items = { { itemId = 9635, amount = 25 } } },
			{ level = 2, price = 1650, items = { { itemId = 9635, amount = 25 }, { itemId = 11452, amount = 15 } } },
			{ level = 3, price = 10650, items = { { itemId = 9635, amount = 25 }, { itemId = 11452, amount = 15 }, { itemId = 10309, amount = 15 } } },
		},
	},
	{
		name = "Blockade",
		category = "Skillboost (Shielding)",
		iconId = 67,
		tiers = {
			{ level = 1, price = 900, items = { { itemId = 9641, amount = 20 } } },
			{ level = 2, price = 6150, items = { { itemId = 9641, amount = 20 }, { itemId = 11703, amount = 25 } } },
			{ level = 3, price = 16150, items = { { itemId = 9641, amount = 20 }, { itemId = 11703, amount = 25 }, { itemId = 20199, amount = 25 } } },
		},
	},
	{
		name = "Slash",
		category = "Skillboost (Sword Fighting)",
		iconId = 70,
		tiers = {
			{ level = 1, price = 1500, items = { { itemId = 9691, amount = 25 } } },
			{ level = 2, price = 4250, items = { { itemId = 9691, amount = 25 }, { itemId = 21202, amount = 25 } } },
			{ level = 3, price = 6550, items = { { itemId = 9691, amount = 25 }, { itemId = 21202, amount = 25 }, { itemId = 9654, amount = 5 } } },
		},
	},
}

local json = dofile("data/libs/dkjson.lua")

local IMBUEMENT_SHOP_OPCODE = 23
local TIER_NAMES = { "Basic", "Intricate", "Powerful" }
local ALLOWED_QUANTITIES = { [1] = true, [2] = true, [5] = true }
local requestThrottle = RequestThrottle.new(500)

local function findKit(kitName)
	for _, kit in ipairs(IMBUEMENT_KITS) do
		if kit.name == kitName then
			return kit
		end
	end
	return nil
end

local function findTier(kit, tierLevel)
	for _, tier in ipairs(kit.tiers) do
		if tier.level == tierLevel then
			return tier
		end
	end
	return nil
end

local function describeItems(items)
	local describedItems = {}
	for _, item in ipairs(items) do
		describedItems[#describedItems + 1] = { id = item.itemId, count = item.amount, name = ItemType(item.itemId):getName() }
	end
	return describedItems
end

local function buildCatalog()
	local catalog = {}
	for _, kit in ipairs(IMBUEMENT_KITS) do
		local tiers = {}
		for _, tier in ipairs(kit.tiers) do
			tiers[#tiers + 1] = { level = tier.level, name = TIER_NAMES[tier.level], price = tier.price, items = describeItems(tier.items) }
		end
		catalog[#catalog + 1] = { name = kit.name, category = kit.category, iconId = kit.iconId, tiers = tiers }
	end
	return catalog
end

local function sendToPlayer(player, payload)
	player:sendExtendedOpcode(IMBUEMENT_SHOP_OPCODE, json.encode(payload))
end

local function sendResult(player, success, message)
	sendToPlayer(player, { action = "result", success = success, message = message, balance = player:getMoney() + player:getBankBalance() })
end

local function handleCatalogRequest(player)
	sendToPlayer(player, { action = "catalog", kits = buildCatalog(), balance = player:getMoney() + player:getBankBalance() })
end

local function multiplyItems(items, quantity)
	local multipliedItems = {}
	for _, item in ipairs(items) do
		multipliedItems[#multipliedItems + 1] = { itemId = item.itemId, amount = item.amount * quantity }
	end
	return multipliedItems
end

local function handlePurchase(player, kitName, tierLevel, requestedQuantity)
	local kit = findKit(kitName)
	if not kit then
		return sendResult(player, false, "This imbuement kit does not exist.")
	end

	local tier = findTier(kit, tonumber(tierLevel))
	if not tier then
		return sendResult(player, false, "This imbuement level does not exist.")
	end

	local quantity = tonumber(requestedQuantity) or 1
	if not ALLOWED_QUANTITIES[quantity] then
		return sendResult(player, false, "Invalid quantity.")
	end

	local totalPrice = tier.price * quantity
	if player:getMoney() + player:getBankBalance() < totalPrice then
		return sendResult(player, false, string.format("You need %d gold to buy this.", totalPrice))
	end

	if not player:removeMoneyBank(totalPrice) then
		return sendResult(player, false, "The payment could not be completed.")
	end

	local kitDescription = string.format("%dx %s %s kit", quantity, TIER_NAMES[tier.level], kit.name)
	if RewardBackpack.deliver(player, multiplyItems(tier.items, quantity)) then
		return sendResult(player, true, string.format("You bought %s for %d gold.", kitDescription, totalPrice))
	end

	sendResult(player, true, string.format("You bought %s for %d gold. You had no room, so it was sent to your depot inbox.", kitDescription, totalPrice))
end

local function onExtendedOpcodeReceived(player, opcode, buffer)
	if opcode ~= IMBUEMENT_SHOP_OPCODE then
		return true
	end

	local data, _, decodeError = json.decode(buffer)
	if decodeError or type(data) ~= "table" then
		return true
	end

	if requestThrottle:isThrottled(player) then
		return true
	end

	if data.action == "catalog" then
		handleCatalogRequest(player)
	elseif data.action == "buy" then
		handlePurchase(player, data.kit, data.tier, data.quantity)
	end
	return true
end

local imbuementShopOpcodeEvent = CreatureEvent("ImbuementShopOpcode")
imbuementShopOpcodeEvent:type("extendedopcode")
imbuementShopOpcodeEvent:onExtendedOpcode(onExtendedOpcodeReceived)
imbuementShopOpcodeEvent:register()

local imbuementShopLoginEvent = CreatureEvent("ImbuementShopLogin")
imbuementShopLoginEvent:type("login")
imbuementShopLoginEvent:onLogin(function(player)
	player:registerEvent("ImbuementShopOpcode")
	return true
end)
imbuementShopLoginEvent:register()
