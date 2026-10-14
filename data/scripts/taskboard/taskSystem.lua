local json = dofile("data/libs/dkjson.lua")
local taskConfig = dofile("data/scripts/taskboard/taskConfig.lua")

local taskOpcode = 17
local taskBaseStorage = 1500
local taskCooldownBaseStorage = 2500
local requestThrottle = RequestThrottle.new(300)

local taskDifficulties = taskConfig.taskDifficulties
local configMonsterTasks = taskConfig.configMonsterTasks
local taskTokenItemId = taskConfig.taskTokenItemId

local function getCurrentDayKey()
	return tonumber(os.date("%Y%m%d"))
end

local function scaleAmount(baseAmount, multiplier)
	return math.max(1, math.floor(baseAmount * multiplier + 0.5))
end

local function buildScaledItemRewards(baseItemRewards, rewardMultiplier)
	local scaledItemRewards = {}
	if not baseItemRewards then
		return scaledItemRewards
	end

	for _, baseItemReward in ipairs(baseItemRewards) do
		table.insert(scaledItemRewards, {
			itemId = baseItemReward.itemId,
			count = scaleAmount(baseItemReward.count, rewardMultiplier)
		})
	end

	return scaledItemRewards
end

local taskDifficultyIdOffset = {
	easy = 1,
	medium = 2,
	hard = 3
}

local function buildTaskDefinitions()
	local taskDefinitions = {}

	for _, monsterConfig in ipairs(configMonsterTasks) do
		for _, difficultyKey in ipairs(monsterConfig.difficulties) do
			local difficultyConfig = taskDifficulties[difficultyKey]

			table.insert(taskDefinitions, {
				id = (monsterConfig.id * 10) + taskDifficultyIdOffset[difficultyKey],
				nameOfTheTask = monsterConfig.displayName,
				monsterNames = monsterConfig.monsterNames,
				difficulty = difficultyKey,
				killsRequired = scaleAmount(monsterConfig.baseKillsRequired, difficultyConfig.killsMultiplier),
				rewards = {
					expReward = scaleAmount(monsterConfig.baseRewards.expReward, difficultyConfig.rewardMultiplier),
					itemRewards = buildScaledItemRewards(monsterConfig.baseRewards.itemRewards, difficultyConfig.rewardMultiplier),
					tokenReward = { chance = difficultyConfig.tokenChance or 0, count = difficultyConfig.tokenCount or 0 }
				}
			})
		end
	end

	return taskDefinitions
end

local function resolveMonsterLooktype(monsterName)
	local monsterType = MonsterType(monsterName)
	if not monsterType then
		return { type = 127 }
	end

	local outfit = monsterType:outfit()
	return {
		type = outfit.lookType,
		auxType = outfit.lookTypeEx,
		head = outfit.lookHead,
		body = outfit.lookBody,
		legs = outfit.lookLegs,
		feet = outfit.lookFeet,
		addons = outfit.lookAddons,
		mount = outfit.lookMount
	}
end

local function resolveTaskLooktype(monsterNames)
	return resolveMonsterLooktype(monsterNames[1])
end

local function resolveGroupLooktypes(monsterNames)
	local looktypes = {}

	for _, monsterName in ipairs(monsterNames) do
		table.insert(looktypes, resolveMonsterLooktype(monsterName))
	end

	return looktypes
end

local function resolveItemReward(itemReward)
	local itemType = ItemType(itemReward.itemId)
	if not itemType then
		return nil
	end

	local canReadClientId = itemType.getClientId ~= nil
	local resolvedClientId = canReadClientId and itemType:getClientId() or itemReward.itemId

	return {
		itemId = itemReward.itemId,
		clientId = resolvedClientId,
		count = itemReward.count,
		name = itemType:getName()
	}
end

local function resolveItemRewards(itemRewards)
	local resolvedRewards = {}
	if not itemRewards then
		return resolvedRewards
	end

	for _, itemReward in ipairs(itemRewards) do
		local resolvedReward = resolveItemReward(itemReward)
		if resolvedReward then
			table.insert(resolvedRewards, resolvedReward)
		end
	end

	return resolvedRewards
end

local function registerDeathEventForConfiguredMonsters()
	local alreadyRegisteredMonsters = {}

	for _, monsterConfig in ipairs(configMonsterTasks) do
		for _, monsterName in ipairs(monsterConfig.monsterNames) do
			if not alreadyRegisteredMonsters[monsterName] then
				alreadyRegisteredMonsters[monsterName] = true

				local monsterType = MonsterType(monsterName)
				if monsterType then
					monsterType:registerEvent("TaskSystemDeath")
				end
			end
		end
	end
end

local function isTaskOnCooldown(player, task)
	local lastCompletedDayKey = player:getStorageValue(taskCooldownBaseStorage + task.id)
	if lastCompletedDayKey <= 0 then
		return false
	end

	return lastCompletedDayKey == getCurrentDayKey()
end

local function grantTaskToken(player, task)
	local tokenReward = task.tokenReward
	if not taskTokenItemId or not tokenReward or tokenReward.count <= 0 then
		return
	end

	if math.random(1, 100) > tokenReward.chance then
		return
	end

	player:addItem(taskTokenItemId, tokenReward.count)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received " .. tokenReward.count .. "x task token!")
end

local function buildTokenRewardSnapshot(task)
	local tokenReward = task.tokenReward
	if not taskTokenItemId or not tokenReward or tokenReward.count <= 0 or tokenReward.chance <= 0 then
		return nil
	end

	local itemType = ItemType(taskTokenItemId)
	return {
		itemId = taskTokenItemId,
		clientId = itemType and itemType.getClientId and itemType:getClientId() or taskTokenItemId,
		name = itemType and itemType:getName() or "task token",
		count = tokenReward.count,
		chance = tokenReward.chance
	}
end

local function buildTaskSnapshot(player, task)
	local snapshot = {
		id = task.id,
		name = task.name,
		monsterNames = task.monsterNames,
		difficulty = task.difficulty,
		looktype = task.looktype,
		monsterLooktypes = task.monsterLooktypes,
		kills = task.kills,
		exp = task.exp,
		itemRewards = task.itemRewards,
		tokenReward = buildTokenRewardSnapshot(task),
		onCooldownToday = isTaskOnCooldown(player, task)
	}

	local storedProgress = player:getStorageValue(taskBaseStorage + task.id)
	if storedProgress > 0 then
		snapshot.left = storedProgress
		snapshot.done = task.kills - (storedProgress - 1)
	end

	return snapshot
end

local function sendResponse(player, payload)
	return player:sendExtendedOpcode(taskOpcode, json.encode(payload))
end

TaskSystem = {
	list = {},
	baseStorage = taskBaseStorage,
	maximumTasks = 2,
	countForParty = true,
	maxDist = 7,
	players = {},
	loadDatabase = function()
		if (#TaskSystem.list > 0) then
			return true
		end

		local taskDefinitions = buildTaskDefinitions()

		for _, taskDefinition in ipairs(taskDefinitions) do
			table.insert(TaskSystem.list, {
				id = taskDefinition.id,
				name = taskDefinition.nameOfTheTask,
				monsterNames = taskDefinition.monsterNames,
				difficulty = taskDefinition.difficulty,
				looktype = resolveTaskLooktype(taskDefinition.monsterNames),
				monsterLooktypes = resolveGroupLooktypes(taskDefinition.monsterNames),
				kills = taskDefinition.killsRequired,
				exp = taskDefinition.rewards.expReward,
				itemRewards = resolveItemRewards(taskDefinition.rewards.itemRewards),
				tokenReward = taskDefinition.rewards.tokenReward
			})
		end

		return true
	end,
	getCurrentTasks = function(player)
		local tasks = {}

		for _, task in ipairs(TaskSystem.list) do
			if (player:getStorageValue(TaskSystem.baseStorage + task.id) > 0) then
				table.insert(tasks, buildTaskSnapshot(player, task))
			end
		end

		return tasks
	end,
	getPlayerTaskIds = function(player)
		local tasks = {}

		for _, task in ipairs(TaskSystem.list) do
			if (player:getStorageValue(TaskSystem.baseStorage + task.id) > 0) then
				table.insert(tasks, task.id)
			end
		end

		return tasks
	end,
	onAction = function(player, data)
		if (data['action'] == 'info') then
			TaskSystem.sendData(player)
			TaskSystem.players[player.uid] = 1
			return
		end

		if (data['action'] == 'hide') then
			TaskSystem.players[player.uid] = nil
			return
		end

		if (data['action'] == 'start') then
			local playerTaskIds = TaskSystem.getPlayerTaskIds(player)

			if (#playerTaskIds >= TaskSystem.maximumTasks) then
				return sendResponse(player, {
					message = "You can't take more tasks.",
					color = 'red'
				})
			end

			for _, task in ipairs(TaskSystem.list) do
				if (task.id == data['entry']) then
					if (table.contains(playerTaskIds, task.id)) then
						return sendResponse(player, {
							message = 'You already have this task active.',
							color = 'red'
						})
					end

					if (isTaskOnCooldown(player, task)) then
						return sendResponse(player, {
							message = 'You already completed this task today. Try again tomorrow.',
							color = 'red'
						})
					end

					player:setStorageValue(TaskSystem.baseStorage + task.id, task.kills + 1)
					sendResponse(player, {
						message = 'Task started.',
						color = 'green'
					})

					return TaskSystem.sendData(player)
				end
			end

			return sendResponse(player, {
				message = 'Unknown task.',
				color = 'red'
			})
		end

		if (data['action'] == 'cancel') then
			for _, task in ipairs(TaskSystem.list) do
				if (task.id == data['entry']) then
					local playerTaskIds = TaskSystem.getPlayerTaskIds(player)

					if (not table.contains(playerTaskIds, task.id)) then
						return sendResponse(player, {
							message = "You don't have this task active.",
							color = 'red'
						})
					end

					player:setStorageValue(TaskSystem.baseStorage + task.id, -1)
					sendResponse(player, {
						message = 'Task aborted.',
						color = 'green'
					})

					return TaskSystem.sendData(player)
				end
			end

			return sendResponse(player, {
				message = 'Unknown task.',
				color = 'red'
			})
		end

		if (data['action'] == 'finish') then
			for _, task in ipairs(TaskSystem.list) do
				if (task.id == data['entry']) then
					local playerTaskIds = TaskSystem.getPlayerTaskIds(player)

					if (not table.contains(playerTaskIds, task.id)) then
						return sendResponse(player, {
							message = "You don't have this task active.",
							color = 'red'
						})
					end

					local left = player:getStorageValue(TaskSystem.baseStorage + task.id)

					if (left > 1) then
						return sendResponse(player, {
							message = "Task isn't completed yet.",
							color = 'red'
						})
					end

					player:setStorageValue(TaskSystem.baseStorage + task.id, -1)
					player:setStorageValue(taskCooldownBaseStorage + task.id, getCurrentDayKey())
					player:addExperience(task.exp)

					if task.itemRewards then
						for _, item in ipairs(task.itemRewards) do
							player:addItem(item.itemId, item.count)
						end
					end
					grantTaskToken(player, task)

					sendResponse(player, {
						message = 'Task finished.',
						color = 'green'
					})

					return TaskSystem.sendData(player)
				end
			end

			return sendResponse(player, {
				message = 'Unknown task.',
				color = 'red'
			})
		end
	end,
	killForPlayer = function(player, task)
		local left = player:getStorageValue(TaskSystem.baseStorage + task.id)

		if (left == 1) then
			if (TaskSystem.players[player.uid]) then
				sendResponse(player, {
					message = 'Task finished.',
					color = 'green'
				})
			end

			return true
		end

		player:setStorageValue(TaskSystem.baseStorage + task.id, left - 1)

		if (TaskSystem.players[player.uid]) then
			return TaskSystem.sendData(player)
		end
	end,
	progressTaskForKill = function(player, task, targetPosition)
		local playerTaskIds = TaskSystem.getPlayerTaskIds(player)
		if (not table.contains(playerTaskIds, task.id)) then
			return
		end

		local party = player:getParty()
		if (TaskSystem.countForParty and party and party:getMembers()) then
			for _, member in pairs(party:getMembers()) do
				local memberPosition = member:getPosition()

				if (memberPosition.z == targetPosition.z and memberPosition:getDistance(targetPosition) <= TaskSystem.maxDist) then
					TaskSystem.killForPlayer(member, task)
				end
			end

			local leaderPosition = party:getLeader():getPosition()

			if (leaderPosition.z == targetPosition.z and leaderPosition:getDistance(targetPosition) <= TaskSystem.maxDist) then
				TaskSystem.killForPlayer(party:getLeader(), task)
			end

			return
		end

		TaskSystem.killForPlayer(player, task)
	end,
	taskMatchesMonster = function(task, targetNameLower)
		for _, monsterName in ipairs(task.monsterNames) do
			if monsterName:lower() == targetNameLower then
				return true
			end
		end

		return false
	end,
	onKill = function(player, target)
		local targetName = target:getName():lower()
		local targetPosition = target:getPosition()

		for _, task in ipairs(TaskSystem.list) do
			if TaskSystem.taskMatchesMonster(task, targetName) then
				TaskSystem.progressTaskForKill(player, task, targetPosition)
			end
		end

		return true
	end,
	sendData = function(player)
		local playerTasks = TaskSystem.getCurrentTasks(player)

		local allTasks = {}
		for _, task in ipairs(TaskSystem.list) do
			table.insert(allTasks, buildTaskSnapshot(player, task))
		end

		local response = {
			allTasks = allTasks,
			playerTasks = playerTasks
		}

		return sendResponse(player, response)
	end
}

local globalevent = GlobalEvent('Tasks')

function globalevent.onStartup()
	TaskSystem.loadDatabase()
	registerDeathEventForConfiguredMonsters()
	return true
end

globalevent:register()

local function resolveKillerPlayer(killer)
	if not killer then
		return nil
	end

	local directPlayer = killer:getPlayer()
	if directPlayer then
		return directPlayer
	end

	local master = killer:getMaster()
	if not master then
		return nil
	end

	return master:getPlayer()
end

local TaskDeathEvent = CreatureEvent("TaskSystemDeath")

function TaskDeathEvent.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	if creature:isPlayer() or creature:getMaster() then
		return true
	end

	local killerPlayer = resolveKillerPlayer(killer) or resolveKillerPlayer(mostDamageKiller)
	if not killerPlayer then
		return true
	end

	TaskSystem.onKill(killerPlayer, creature)
	return true
end

TaskDeathEvent:type("death")
TaskDeathEvent:register()

local ExtendedEvent = CreatureEvent("TaskExtended")

function ExtendedEvent.onExtendedOpcode(player, opcode, buffer)
	if opcode ~= taskOpcode then
		return
	end

	local actionData = json.decode(buffer)
	if type(actionData) ~= "table" then
		return
	end

	if actionData.action ~= "hide" and requestThrottle:isThrottled(player) then
		return
	end

	TaskSystem.onAction(player, actionData)
end

ExtendedEvent:type("extendedopcode")
ExtendedEvent:register()

local LoginEvent = CreatureEvent("TaskLogin")

function LoginEvent.onLogin(player)
	player:registerEvent("TaskExtended")
	return true
end

LoginEvent:type("login")
LoginEvent:register()

print(">> TaskSystem loaded")