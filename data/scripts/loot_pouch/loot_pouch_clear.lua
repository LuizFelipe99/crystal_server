local LOOT_POUCH_OPCODE = 24

local json = dofile("data/libs/dkjson.lua")
local requestThrottle = RequestThrottle.new(2000)

local function findLootPouch(player)
	local storeInbox = player:getStoreInbox()
	if not storeInbox then
		return nil
	end
	for _, item in ipairs(storeInbox:getItems()) do
		if item:getId() == ITEM_GOLD_POUCH then
			return item
		end
	end
	return nil
end

local function clearLootPouch(player)
	local lootPouch = findLootPouch(player)
	if not lootPouch then
		player:sendCancelMessage("You do not have a loot pouch.")
		return
	end

	local pouchItems = lootPouch:getItems()
	if #pouchItems == 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your loot pouch is already empty.")
		return
	end

	local removedCount = 0
	for _, item in ipairs(pouchItems) do
		if item:remove() then
			removedCount = removedCount + 1
		end
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Your loot pouch was cleared. %d item(s) removed.", removedCount))
	logger.info("{} cleared the loot pouch removing {} item(s)", player:getName(), removedCount)
end

local function onExtendedOpcodeReceived(player, opcode, buffer)
	if opcode ~= LOOT_POUCH_OPCODE then
		return true
	end

	local data, _, decodeError = json.decode(buffer)
	if decodeError or type(data) ~= "table" or data.action ~= "clear" then
		return true
	end

	if requestThrottle:isThrottled(player) then
		return true
	end

	clearLootPouch(player)
	return true
end

local lootPouchOpcodeEvent = CreatureEvent("LootPouchClearOpcode")
lootPouchOpcodeEvent:type("extendedopcode")
lootPouchOpcodeEvent:onExtendedOpcode(onExtendedOpcodeReceived)
lootPouchOpcodeEvent:register()

local lootPouchLoginEvent = CreatureEvent("LootPouchClearLogin")
lootPouchLoginEvent:type("login")
lootPouchLoginEvent:onLogin(function(player)
	player:registerEvent("LootPouchClearOpcode")
	return true
end)
lootPouchLoginEvent:register()
