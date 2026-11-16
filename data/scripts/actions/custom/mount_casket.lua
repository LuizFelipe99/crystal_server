local MOUNT_CASKET_ITEM_ID = 64485
local HIGHEST_MOUNT_ID_TO_SCAN = 255

local function collectRegisteredMounts()
	local registeredMounts = {}

	for mountId = 1, HIGHEST_MOUNT_ID_TO_SCAN do
		local mount = Mount(mountId)
		if mount then
			registeredMounts[#registeredMounts + 1] = { id = mountId, name = mount:getName() }
		end
	end

	return registeredMounts
end

local function getMountsPlayerDoesNotOwn(player)
	local missingMounts = {}

	for _, mountEntry in ipairs(collectRegisteredMounts()) do
		if not player:hasMount(mountEntry.id) then
			missingMounts[#missingMounts + 1] = mountEntry
		end
	end

	return missingMounts
end

local mountCasketAction = Action()

function mountCasketAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local missingMounts = getMountsPlayerDoesNotOwn(player)

	if #missingMounts == 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already own every available mount!")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	local chosenMount = missingMounts[math.random(#missingMounts)]
	player:addMount(chosenMount.id)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received the " .. chosenMount.name .. " mount!")
	player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)

	item:remove(1)
	return true
end

mountCasketAction:id(MOUNT_CASKET_ITEM_ID)
mountCasketAction:register()
