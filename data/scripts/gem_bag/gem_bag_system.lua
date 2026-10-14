local json = dofile("data/libs/dkjson.lua")

local gemBagOpcode = 18
local gemBagSlotCount = 9
local gemCatalogPath = "data/XML/gems.xml"

local function readGemCatalog()
	local gemDefinitionByItemId = {}
	local catalogFile = io.open(gemCatalogPath, "r")
	if not catalogFile then
		print(">> GemBag: could not open " .. gemCatalogPath)
		return gemDefinitionByItemId
	end

	for catalogLine in catalogFile:lines() do
		local itemId = tonumber(catalogLine:match('<gem[^>]-id="(%d+)"'))
		local attribute = catalogLine:match('<gem[^>]-attribute="([^"]+)"')
		local value = tonumber(catalogLine:match('<gem[^>]-value="(%-?%d+)"'))
		if itemId and attribute and value then
			gemDefinitionByItemId[itemId] = { attribute = attribute, value = value }
		end
	end

	catalogFile:close()
	return gemDefinitionByItemId
end

local gemDefinitionByItemId = readGemCatalog()

local function buildSlotDetails(itemId)
	if itemId == 0 then
		return {}
	end

	local gemDefinition = gemDefinitionByItemId[itemId]
	if not gemDefinition then
		return {}
	end

	local itemType = ItemType(itemId)
	return {
		name = itemType and itemType:getName() or nil,
		attribute = gemDefinition.attribute,
		value = gemDefinition.value
	}
end

local function buildGemBagState(player)
	local slots = {}
	local details = {}
	for slotIndex = 0, gemBagSlotCount - 1 do
		local itemId = player:getGemBagSlot(slotIndex)
		table.insert(slots, itemId)
		table.insert(details, buildSlotDetails(itemId))
	end

	return { slots = slots, details = details }
end

local function handleSocketAction(player, actionData)
	local wasSuccessful = player:socketGem(actionData.slotIndex, actionData.itemId)
	if not wasSuccessful then
		return
	end

	player:sendExtendedOpcode(gemBagOpcode, json.encode(buildGemBagState(player)))
end

local function handleUnsocketAction(player, actionData)
	local wasSuccessful = player:unsocketGem(actionData.slotIndex)
	if not wasSuccessful then
		return
	end

	player:sendExtendedOpcode(gemBagOpcode, json.encode(buildGemBagState(player)))
end

local ExtendedEvent = CreatureEvent("GemBagExtended")

function ExtendedEvent.onExtendedOpcode(player, opcode, buffer)
	if opcode ~= gemBagOpcode then
		return
	end

	local actionData = json.decode(buffer)
	if actionData.action == "socket" then
		handleSocketAction(player, actionData)
		return
	end

	if actionData.action == "unsocket" then
		handleUnsocketAction(player, actionData)
	end
end

ExtendedEvent:type("extendedopcode")
ExtendedEvent:register()

local LoginEvent = CreatureEvent("GemBagLogin")

function LoginEvent.onLogin(player)
	player:registerEvent("GemBagExtended")
	player:sendExtendedOpcode(gemBagOpcode, json.encode(buildGemBagState(player)))
	return true
end

LoginEvent:type("login")
LoginEvent:register()

print(">> GemBag system loaded")
