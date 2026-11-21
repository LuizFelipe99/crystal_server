local SELL_PROTECTION_OPCODE = 25
local MAX_PROTECTED_ITEMS = 500

local json = dofile("data/libs/dkjson.lua")
local requestThrottle = RequestThrottle.new(300)
local protectedItemIdsByPlayerGuid = {}

SellProtection = SellProtection or {}

function SellProtection.isProtected(player, itemId)
	local protectedItemIds = protectedItemIdsByPlayerGuid[player:getGuid()]
	return protectedItemIds ~= nil and protectedItemIds[itemId] == true
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

	if requestThrottle:isThrottled(player) then
		return true
	end

	protectedItemIdsByPlayerGuid[player:getGuid()] = buildProtectedItemSet(data.itemIds)
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
	return true
end)
sellProtectionLoginEvent:register()

local sellProtectionLogoutEvent = CreatureEvent("SellProtectionLogout")
sellProtectionLogoutEvent:type("logout")
sellProtectionLogoutEvent:onLogout(function(player)
	protectedItemIdsByPlayerGuid[player:getGuid()] = nil
	return true
end)
sellProtectionLogoutEvent:register()
