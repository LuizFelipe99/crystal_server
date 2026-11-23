local SELL_PROTECTION_OPCODE = 25
local MAX_PROTECTED_ITEMS = 500
local STORAGE_KEY = "sell-protection-items"
local ITEM_ID_SEPARATOR = ","

local json = dofile("data/libs/dkjson.lua")
local persistThrottle = RequestThrottle.new(2000)
local protectedItemIdsByPlayerGuid = {}
local unsavedPlayerGuids = {}

SellProtection = SellProtection or {}

local function parseStoredItemIds(storedValue)
	local protectedItemIds = {}
	if type(storedValue) ~= "string" then
		return protectedItemIds
	end
	for rawItemId in storedValue:gmatch("[^" .. ITEM_ID_SEPARATOR .. "]+") do
		local itemId = tonumber(rawItemId)
		if itemId then
			protectedItemIds[itemId] = true
		end
	end
	return protectedItemIds
end

local function serializeItemIds(protectedItemIds)
	local itemIds = {}
	for itemId in pairs(protectedItemIds) do
		table.insert(itemIds, tostring(itemId))
	end
	return table.concat(itemIds, ITEM_ID_SEPARATOR)
end

local function loadProtectedItemIds(player)
	local playerGuid = player:getGuid()
	local cachedItemIds = protectedItemIdsByPlayerGuid[playerGuid]
	if cachedItemIds then
		return cachedItemIds
	end
	local storedItemIds = parseStoredItemIds(player:kv():get(STORAGE_KEY))
	protectedItemIdsByPlayerGuid[playerGuid] = storedItemIds
	return storedItemIds
end

local function persistProtectedItemIds(player)
	local playerGuid = player:getGuid()
	local protectedItemIds = protectedItemIdsByPlayerGuid[playerGuid]
	if not protectedItemIds then
		return
	end
	player:kv():set(STORAGE_KEY, serializeItemIds(protectedItemIds))
	unsavedPlayerGuids[playerGuid] = nil
end

function SellProtection.isProtected(player, itemId)
	return loadProtectedItemIds(player)[itemId] == true
end

local function sendProtectedItemIds(player)
	local itemIds = {}
	for itemId in pairs(loadProtectedItemIds(player)) do
		table.insert(itemIds, itemId)
	end
	player:sendExtendedOpcode(SELL_PROTECTION_OPCODE, json.encode({ action = "list", itemIds = itemIds }))
end

local function buildProtectedItemSet(itemIds)
	local protectedItemIds = {}
	local storedCount = 0
	for _, rawItemId in ipairs(itemIds) do
		local itemId = tonumber(rawItemId)
		if itemId and itemId > 0 and storedCount < MAX_PROTECTED_ITEMS then
			protectedItemIds[itemId] = true
			storedCount = storedCount + 1
		end
	end
	return protectedItemIds
end

local function onExtendedOpcodeReceived(player, opcode, buffer)
	if opcode ~= SELL_PROTECTION_OPCODE then
		return true
	end

	local data, _, decodeError = json.decode(buffer)
	if decodeError or type(data) ~= "table" or data.action ~= "sync" or type(data.itemIds) ~= "table" then
		return true
	end

	local playerGuid = player:getGuid()
	protectedItemIdsByPlayerGuid[playerGuid] = buildProtectedItemSet(data.itemIds)
	unsavedPlayerGuids[playerGuid] = true
	if persistThrottle:isThrottled(player) then
		return true
	end
	persistProtectedItemIds(player)
	return true
end

local sellProtectionOpcodeEvent = CreatureEvent("SellProtectionOpcode")
sellProtectionOpcodeEvent:type("extendedopcode")
sellProtectionOpcodeEvent:onExtendedOpcode(onExtendedOpcodeReceived)
sellProtectionOpcodeEvent:register()

local sellProtectionLoginEvent = CreatureEvent("SellProtectionLogin")
sellProtectionLoginEvent:type("login")
sellProtectionLoginEvent:onLogin(function(player)
	player:registerEvent("SellProtectionOpcode")
	sendProtectedItemIds(player)
	return true
end)
sellProtectionLoginEvent:register()

local sellProtectionLogoutEvent = CreatureEvent("SellProtectionLogout")
sellProtectionLogoutEvent:type("logout")
sellProtectionLogoutEvent:onLogout(function(player)
	local playerGuid = player:getGuid()
	if unsavedPlayerGuids[playerGuid] then
		persistProtectedItemIds(player)
	end
	protectedItemIdsByPlayerGuid[playerGuid] = nil
	return true
end)
sellProtectionLogoutEvent:register()
