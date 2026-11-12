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

local HIDDEN_FIELD_LABELS = {
	["Tradeable"] = true,
	["Tradeable In Market"] = true,
	["Weight"] = true,
	["Total Weight"] = true,
}

local function isFilledText(text)
	return type(text) == "string" and text ~= ""
end

local function hasDescription(item)
	if isFilledText(item:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION)) then
		return true
	end
	return isFilledText(item:getType():getDescription())
end

local function isVisibleField(item, label)
	if HIDDEN_FIELD_LABELS[label] then
		return false
	end
	if label == "Description" then
		return hasDescription(item)
	end
	return true
end

local function buildTooltipFields(item)
	if not item.getDescriptions then
		return nil
	end

	local fields = {}
	for _, description in ipairs(item:getDescriptions() or {}) do
		if isVisibleField(item, description.label) then
			fields[#fields + 1] = { label = description.label, value = description.value }
		end
	end
	return fields
end

local ELEMENT_KEY_BY_COMBAT_TYPE = {
	[COMBAT_PHYSICALDAMAGE] = "physical",
	[COMBAT_ENERGYDAMAGE] = "energy",
	[COMBAT_EARTHDAMAGE] = "earth",
	[COMBAT_FIREDAMAGE] = "fire",
	[COMBAT_ICEDAMAGE] = "ice",
	[COMBAT_HOLYDAMAGE] = "holy",
	[COMBAT_DEATHDAMAGE] = "death",
}

local ELEMENT_KEY_BY_SHOOT_TYPE = {
	[CONST_ANI_ENERGY] = "energy",
	[CONST_ANI_ENERGYBALL] = "energy",
	[CONST_ANI_EARTH] = "earth",
	[CONST_ANI_SMALLEARTH] = "earth",
	[CONST_ANI_FIRE] = "fire",
	[CONST_ANI_ICE] = "ice",
	[CONST_ANI_SMALLICE] = "ice",
	[CONST_ANI_HOLY] = "holy",
	[CONST_ANI_SMALLHOLY] = "holy",
	[CONST_ANI_DEATH] = "death",
	[CONST_ANI_SUDDENDEATH] = "death",
}

local ELEMENTLESS_WEAPON_TYPES = {
	[WEAPON_NONE] = true,
	[WEAPON_SHIELD] = true,
}

local function resolveWandElement(itemType)
	if not itemType.getCombatType then
		return nil
	end

	local combatElement = ELEMENT_KEY_BY_COMBAT_TYPE[itemType:getCombatType()]
	if combatElement then
		return combatElement
	end
	return ELEMENT_KEY_BY_SHOOT_TYPE[itemType:getShootType()]
end

local function resolveItemElement(item)
	local itemType = item:getType()
	local weaponType = itemType:getWeaponType()
	if ELEMENTLESS_WEAPON_TYPES[weaponType] then
		return nil
	end

	if weaponType == WEAPON_WAND then
		return resolveWandElement(itemType)
	end

	if (itemType:getElementDamage() or 0) > 0 then
		return ELEMENT_KEY_BY_COMBAT_TYPE[itemType:getElementType()] or "physical"
	end
	return "physical"
end

local function sendItemTooltip(player, request, item)
	player:sendExtendedOpcode(ITEM_TOOLTIP_OPCODE, json.encode({
		x = request.x,
		y = request.y,
		z = request.z,
		itemId = request.itemId,
		name = capitalizeFirstLetter(item:getName()),
		element = resolveItemElement(item),
		fields = buildTooltipFields(item),
		description = buildCompactDescription(item),
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

	sendItemTooltip(player, request, item)
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
