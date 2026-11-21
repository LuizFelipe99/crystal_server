local missionPack = TalkAction("/missionpack")

local function sendUsage(player)
	player:sendCancelMessage("Usage: /missionpack missionNumber (1 to " .. #ElementalBuildConfig.missions .. ")")
end

function missionPack.onSay(player, words, param)
	logCommand(player, words, param)

	local missionId = tonumber(param:trim())
	if not missionId then
		sendUsage(player)
		return true
	end

	local mission = ElementalBuildConfig.missions[missionId]
	if not mission then
		sendUsage(player)
		return true
	end

	local deliveredToBackpack = RewardBackpack.deliver(player, mission.items)
	local destination = deliveredToBackpack and "your backpack" or "your inbox"
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Mission %d (%s) items sent to %s.", missionId, mission.name, destination))
	logger.info("{} created the items of elemental build mission {}", player:getName(), missionId)
	return true
end

missionPack:separator(" ")
missionPack:groupType("god")
missionPack:register()
