local maxPlayersPerLine = 10
local idleTimeThreshold = 5 * 60 * 1000
local categoryOrder = { "Active", "Training", "Idle" }
local playersOnline = TalkAction("!online")

local function formatOnlineEntry(player)
	return ("%s [%d|%s]"):format(player:getName(), player:getLevel(), player:vocationAbbrev())
end

local function getOnlineCategory(targetPlayer)
	if _G.OnExerciseTraining[targetPlayer:getId()] then
		return "Training"
	end
	if targetPlayer:getIdleTime() >= idleTimeThreshold then
		return "Idle"
	end
	return "Active"
end

local function appendCategoryLines(lines, categoryName, categoryPlayers)
	if #categoryPlayers == 0 then
		return
	end

	table.sort(categoryPlayers, function(first, second)
		return first:getLevel() > second:getLevel()
	end)

	local prefix = categoryName .. ": "
	for firstIndex = 1, #categoryPlayers, maxPlayersPerLine do
		local entries = {}
		for playerIndex = firstIndex, math.min(firstIndex + maxPlayersPerLine - 1, #categoryPlayers) do
			table.insert(entries, formatOnlineEntry(categoryPlayers[playerIndex]))
		end
		table.insert(lines, prefix .. table.concat(entries, ", "))
		prefix = ""
	end
end

function playersOnline.onSay(player, words, param)
	local hasAccess = player:getGroup():getAccess()
	local playersByCategory = { Active = {}, Training = {}, Idle = {} }

	for _, targetPlayer in ipairs(Game.getPlayers()) do
		if hasAccess or not targetPlayer:isInGhostMode() then
			table.insert(playersByCategory[getOnlineCategory(targetPlayer)], targetPlayer)
		end
	end

	local onlineCount = #playersByCategory.Active + #playersByCategory.Training + #playersByCategory.Idle
	local lines = {
		("%d players online | Active: %d | Training: %d | Idle: %d"):format(onlineCount, #playersByCategory.Active, #playersByCategory.Training, #playersByCategory.Idle),
	}

	for _, categoryName in ipairs(categoryOrder) do
		appendCategoryLines(lines, categoryName, playersByCategory[categoryName])
	end

	player:sendTextMessage(MESSAGE_LOOK, table.concat(lines, "\n"))
	return true
end

playersOnline:groupType("normal")
playersOnline:register()
