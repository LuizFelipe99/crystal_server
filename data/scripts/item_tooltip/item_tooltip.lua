local json = dofile("data/libs/dkjson.lua")

local ITEM_TOOLTIP_OPCODE = 21
local INVENTORY_POSITION_X = 0xFFFF
local CONTAINER_ID_FLAG = 0x40
local DESCRIPTION_LOOK_DISTANCE = 2
local requestThrottle = RequestThrottle.new(100)

local function findInventoryItem(player, position)
	if position.y >= CONTAINER_ID_FLAG then
		local container = player:getContainerById(position.y - CONTAINER_ID_FLAG)
		if not container then
			return nil
		end
		local containerIndex = player:getContainerIndex(position.y - CONTAINER_ID_FLAG) or 0
		return container:getItem(containerIndex + position.z)
	end

	return player:getSlotItem(position.y)
end

local function capitalizeFirstLetter(text)
	return (text:gsub("^%l", string.upper))
end

local function buildCompactDescription(item)
	local description = item:getDescription(DESCRIPTION_LOOK_DISTANCE)
	description = description:gsub("^an? ", "")
	description = description:gsub("It can only be wielded properly by ", "Wielded by: ")
	description = description:gsub("\n+$", "")
	return capitalizeFirstLetter(description)
end

local function sendItemTooltip(player, request, description)
	player:sendExtendedOpcode(ITEM_TOOLTIP_OPCODE, json.encode({
		x = request.x,
		y = request.y,
		z = request.z,
		itemId = request.itemId,
		description = description,
	}))
end

local function handleTooltipRequest(player, request)
	if type(request.x) ~= "number" or type(request.y) ~= "number" or type(request.z) ~= "number" or type(request.itemId) ~= "number" then
		return
	end
	if request.x ~= INVENTORY_POSITION_X then
		return
	end

	local item = findInventoryItem(player, request)
	if not item or item:getId() ~= request.itemId then
		return
	end

	sendItemTooltip(player, request, buildCompactDescription(item))
end

local itemTooltipEvent = CreatureEvent("ItemTooltipOpcode")
itemTooltipEvent:type("extendedopcode")

itemTooltipEvent:onExtendedOpcode(function(player, opcode, buffer)
	if opcode ~= ITEM_TOOLTIP_OPCODE then
		return true
	end
	if requestThrottle:isThrottled(player) then
		return true
	end

	local request, _, decodeError = json.decode(buffer)
	if decodeError or type(request) ~= "table" then
		return true
	end

	handleTooltipRequest(player, request)
	return true
end)

itemTooltipEvent:register()

local itemTooltipLoginEvent = CreatureEvent("ItemTooltipLogin")
itemTooltipLoginEvent:type("login")

itemTooltipLoginEvent:onLogin(function(player)
	player:registerEvent("ItemTooltipOpcode")
	return true
end)

itemTooltipLoginEvent:register()
