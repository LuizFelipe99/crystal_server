local HARD_CRAFT_CHEST_UID = 30109

local craftUnlockChests = {
	[HARD_CRAFT_CHEST_UID] = {
		grantedStorages = { CRAFT_UNLOCK_STORAGE, CRAFT_ADVANCED_UNLOCK_STORAGE },
		unlockMessage = "You have unlocked the advanced Craft Bench recipes!",
	},
}

local function hasClaimedChest(player, chestConfig)
	local decisiveStorage = chestConfig.grantedStorages[#chestConfig.grantedStorages]
	return player:getStorageValue(decisiveStorage) ~= -1
end

local craftUnlockQuest = Action()

function craftUnlockQuest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local chestConfig = craftUnlockChests[item:getUniqueId()]
	if not chestConfig then
		return false
	end

	if hasClaimedChest(player, chestConfig) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have already claimed this reward.")
		return true
	end

	for _, storage in ipairs(chestConfig.grantedStorages) do
		player:setStorageValue(storage, 1)
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, chestConfig.unlockMessage)
	toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	return true
end

for chestUid in pairs(craftUnlockChests) do
	craftUnlockQuest:uid(chestUid)
end
craftUnlockQuest:register()
