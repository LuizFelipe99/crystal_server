local LASTING_EXERCISE_BOX_ITEM_ID = 60598
local LASTING_EXERCISE_CHARGES = 14400

local lastingExerciseWeapons = {
	{ name = "Lasting Exercise Sword", itemId = 35285 },
	{ name = "Lasting Exercise Axe", itemId = 35286 },
	{ name = "Lasting Exercise Club", itemId = 35287 },
	{ name = "Lasting Exercise Bow", itemId = 35288 },
	{ name = "Lasting Exercise Rod", itemId = 35289 },
	{ name = "Lasting Exercise Wand", itemId = 35290 },
	{ name = "Lasting Exercise Shield", itemId = 44067 },
	{ name = "Lasting Exercise Wraps", itemId = 50295 },
}

local function deliverLastingExerciseWeapon(player, exerciseWeapon)
	if player:getItemCount(LASTING_EXERCISE_BOX_ITEM_ID) < 1 then
		player:sendCancelMessage("You no longer have a lasting exercise box.")
		return
	end

	local canReceive, errorMessage = player:canReceiveStoreItems(exerciseWeapon.itemId, 1)
	if not canReceive then
		player:sendCancelMessage(errorMessage)
		return
	end

	if not player:removeItem(LASTING_EXERCISE_BOX_ITEM_ID, 1) then
		player:sendCancelMessage("You no longer have a lasting exercise box.")
		return
	end

	player:addItemStoreInbox(exerciseWeapon.itemId, LASTING_EXERCISE_CHARGES)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You received a %s. It was sent to your store inbox.", exerciseWeapon.name:lower()))
	player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
end

local function sendExerciseSelectionWindow(player)
	local window = ModalWindow({
		title = "Lasting Exercise Box",
		message = "Choose the lasting exercise weapon you want to receive.",
	})

	for _, exerciseWeapon in ipairs(lastingExerciseWeapons) do
		window:addChoice(exerciseWeapon.name, function(selectingPlayer, button)
			if button.name ~= "Select" then
				return true
			end
			deliverLastingExerciseWeapon(selectingPlayer, exerciseWeapon)
			return true
		end)
	end

	window:addButton("Select")
	window:addButton("Cancel")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

local lastingExerciseBox = Action()

function lastingExerciseBox.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	sendExerciseSelectionWindow(player)
	return true
end

lastingExerciseBox:id(LASTING_EXERCISE_BOX_ITEM_ID)
lastingExerciseBox:register()
