local ropeshovel = TalkAction("!tmenu")

function ropeshovel.onSay(player, words, param)
	-- Cooldown
	local usedelay = 5
	if player:getStorageValue(159753) > os.time() then
		player:sendCancelMessage("You must wait before using this again.")
		return false
	end
	player:setStorageValue(159753, os.time() + usedelay)

	-- Add more items or remove them (according to your preferences)
	local items = {
		{ id = 3457, name = "Shovel" },
		{ id = 3003, name = "Rope" },
		{ id = 3456, name = "Pick" },
		{ id = 5467, name = "Fire Bug" },
		{ id = 9598, name = "Whacking Driller Of Fate" },
		{ id = 9596, name = "Squeezing Gear Of Girlpower" },
		{ id = 3308, name = "Machete" }
	}

	-- Ventana modal
	local window = ModalWindow({
		title = "Tools Menu",
		message = "Select the tool you want to receive.",
	})

	for _, item in ipairs(items) do
		window:addChoice(item.name, function(player, button, choice)
			if button.name ~= "Select" then
				return true
			end

			if player:getItemCount(item.id) >= 1 then
				player:sendCancelMessage("You already have a " .. item.name .. ".")
				player:getPosition():sendMagicEffect(CONST_ME_SMOKE)
			else
				player:addItem(item.id, 1)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have received a " .. item.name .. "!")
				player:getPosition():sendMagicEffect(CONST_ME_PRISMATIC_SPARK)
			end
			return true
		end)
	end

	window:addButton("Select")
	window:addButton("Close")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)

	return false
end

ropeshovel:groupType("god")
ropeshovel:register()