local function findTargetAndWing(player, param, usage)
	local parameters = param:split(",")
	if #parameters < 2 then
		player:sendCancelMessage(usage)
		return nil, nil
	end

	local target = Player(string.trim(parameters[1]))
	if not target then
		player:sendCancelMessage("Player not found.")
		return nil, nil
	end

	local wingParameter = string.trim(parameters[2])
	return target, tonumber(wingParameter) or wingParameter
end

local addWing = TalkAction("/addwing")

function addWing.onSay(player, words, param)
	logCommand(player, words, param)

	local target, wing = findTargetAndWing(player, param, "Usage: /addwing <playername>, <wing id or name>")
	if not target then
		return true
	end

	if not target:addCustomOutfit("wing", wing) then
		player:sendCancelMessage("Wing not found.")
		return true
	end

	target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received new wings! Open your outfit window to use them.")
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Wing %s added to %s.", tostring(wing), target:getName()))
	return true
end

addWing:separator(" ")
addWing:groupType("god")
addWing:register()

local removeWing = TalkAction("/removewing")

function removeWing.onSay(player, words, param)
	logCommand(player, words, param)

	local target, wing = findTargetAndWing(player, param, "Usage: /removewing <playername>, <wing id or name>")
	if not target then
		return true
	end

	if not target:removeCustomOutfit("wing", wing) then
		player:sendCancelMessage("Wing not found.")
		return true
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Wing %s removed from %s.", tostring(wing), target:getName()))
	return true
end

removeWing:separator(" ")
removeWing:groupType("god")
removeWing:register()
