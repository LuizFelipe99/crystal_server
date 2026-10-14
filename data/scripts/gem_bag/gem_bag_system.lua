local json = dofile("data/libs/dkjson.lua")

local gemBagOpcode = 18
local gemBagSlotCount = 9

local function buildGemBagState(player)
	local slots = {}
	for slotIndex = 0, gemBagSlotCount - 1 do
		table.insert(slots, player:getGemBagSlot(slotIndex))
	end

	return { slots = slots }
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