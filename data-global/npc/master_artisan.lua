local internalNpcName = "Master Artisan"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 2101,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

local TOPIC_NONE = 0
local TOPIC_AWAITING_DELIVERY = 1
local TOPIC_AWAITING_ADVANCED_DELIVERY = 2

local ADVANCED_CRAFT_GOLD_COST = 20000000
local ADVANCED_CRAFT_STONE_AMOUNT = 3
local LEVEL_TWO_ATTRIBUTE_STONE_IDS = { 62115, 62112, 62114, 62118, 64487, 64496, 64505, 62113 }
local CRAFT_TRIAL_CRYSTAL_STORAGES = { 50001, 50002, 50003 }

local advancedCraftRelics = {
	{ itemId = 63401, name = "golden ruby crafter nv. 4", amount = 1 },
	{ itemId = 63400, name = "platinum ruby crafter nv. 4", amount = 1 },
	{ itemId = 51955, name = "super stone shower rune", amount = 1 },
}

local craftUnlockRequirements = {
	{ itemId = 5878, name = "minotaur leather", amount = 20 },
	{ itemId = 5880, name = "iron ore", amount = 10 },
	{ itemId = 60057, name = "boss token", amount = 5 },
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

local function describeRequirements()
	local requirementLabels = {}
	for _, requirement in ipairs(craftUnlockRequirements) do
		requirementLabels[#requirementLabels + 1] = requirement.amount .. " " .. requirement.name
	end
	return table.concat(requirementLabels, ", ")
end

local function findMissingItems(player, requirements, missingLabels)
	for _, requirement in ipairs(requirements) do
		local missingAmount = requirement.amount - player:getItemCount(requirement.itemId)
		if missingAmount > 0 then
			missingLabels[#missingLabels + 1] = missingAmount .. " " .. requirement.name
		end
	end
	return missingLabels
end

local function removeItems(player, requirements)
	for _, requirement in ipairs(requirements) do
		player:removeItem(requirement.itemId, requirement.amount)
	end
end

local function countLevelTwoStones(player)
	local stoneCount = 0
	for _, stoneId in ipairs(LEVEL_TWO_ATTRIBUTE_STONE_IDS) do
		stoneCount = stoneCount + player:getItemCount(stoneId)
	end
	return stoneCount
end

local function removeLevelTwoStones(player, amountToRemove)
	local remainingAmount = amountToRemove
	for _, stoneId in ipairs(LEVEL_TWO_ATTRIBUTE_STONE_IDS) do
		if remainingAmount == 0 then
			return
		end

		local removableAmount = math.min(player:getItemCount(stoneId), remainingAmount)
		if removableAmount > 0 then
			player:removeItem(stoneId, removableAmount)
			remainingAmount = remainingAmount - removableAmount
		end
	end
end

local function hasTouchedAllTrialCrystals(player)
	for _, crystalStorage in ipairs(CRAFT_TRIAL_CRYSTAL_STORAGES) do
		if player:getStorageValue(crystalStorage) == -1 then
			return false
		end
	end
	return true
end

local function hasEnoughGold(player, goldAmount)
	return player:getMoney() + player:getBankBalance() >= goldAmount
end

local function findMissingAdvancedRequirements(player)
	local missingLabels = {}

	if not hasTouchedAllTrialCrystals(player) then
		missingLabels[#missingLabels + 1] = "the relics of all three crystals of the Rotten Blood"
	end

	findMissingItems(player, advancedCraftRelics, missingLabels)

	local missingStones = ADVANCED_CRAFT_STONE_AMOUNT - countLevelTwoStones(player)
	if missingStones > 0 then
		missingLabels[#missingLabels + 1] = missingStones .. " attribute stone(s) of level 2"
	end

	if not hasEnoughGold(player, ADVANCED_CRAFT_GOLD_COST) then
		missingLabels[#missingLabels + 1] = FormatNumber(ADVANCED_CRAFT_GOLD_COST) .. " gold"
	end

	return missingLabels
end

local function hasAdvancedCraftAccess(player)
	return player:getStorageValue(CRAFT_ADVANCED_UNLOCK_STORAGE) ~= -1
end

local function hasCraftAccess(player)
	return player:getStorageValue(CRAFT_UNLOCK_STORAGE) ~= -1
end

local function explainAdvancedCraftAccess(npc, creature, player)
	local playerId = player:getId()

	if not hasCraftAccess(player) then
		npcHandler:say("First prove yourself with the basic trial. Ask me about the {craft}.", npc, creature)
		npcHandler:setTopic(playerId, TOPIC_NONE)
		return
	end

	if hasAdvancedCraftAccess(player) then
		npcHandler:say("You have already mastered the Craft Bench. There is nothing left for me to teach you.", npc, creature)
		npcHandler:setTopic(playerId, TOPIC_NONE)
		return
	end

	npcHandler:say({
		"The advanced recipes forge gems of level 5 and above and the equipment of the Soul War and beyond. ...",
		"Deep in the Rotten Blood lie three ancient crystals. Each one guards a relic: a golden ruby crafter nv. 4, a platinum ruby crafter nv. 4 and a super stone shower rune. ...",
		"Bring me those three relics, " .. FormatNumber(ADVANCED_CRAFT_GOLD_COST) .. " gold and " .. ADVANCED_CRAFT_STONE_AMOUNT .. " attribute stones of level 2, of any kind. Do you have everything with you?",
	}, npc, creature)
	npcHandler:setTopic(playerId, TOPIC_AWAITING_ADVANCED_DELIVERY)
end

local function receiveAdvancedDelivery(npc, creature, player)
	local playerId = player:getId()
	npcHandler:setTopic(playerId, TOPIC_NONE)

	local missingLabels = findMissingAdvancedRequirements(player)
	if #missingLabels > 0 then
		npcHandler:say("You are still missing " .. table.concat(missingLabels, ", ") .. ". Come back when you have everything.", npc, creature)
		return
	end

	if not player:removeMoneyBank(ADVANCED_CRAFT_GOLD_COST) then
		npcHandler:say("You do not have enough gold.", npc, creature)
		return
	end

	removeItems(player, advancedCraftRelics)
	removeLevelTwoStones(player, ADVANCED_CRAFT_STONE_AMOUNT)
	player:setStorageValue(CRAFT_ADVANCED_UNLOCK_STORAGE, 1)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have unlocked the advanced Craft Bench recipes!")
	player:sendQuestProgress("Advanced Crafting", true)
	npcHandler:say("Remarkable. Every recipe of the Craft Bench is now yours to forge.", npc, creature)
end

local function explainCraftAccess(npc, creature, player)
	local playerId = player:getId()

	if hasCraftAccess(player) then
		explainAdvancedCraftAccess(npc, creature, player)
		return
	end

	npcHandler:say({
		"The Craft Bench lets you forge equipment, break items down into materials and fuse crafters into stronger ones. ...",
		"I only teach those who prove their worth. Bring me " .. describeRequirements() .. ". ...",
		"Boss tokens are taken from the powerful bosses of Noxum. Do you have everything with you?",
	}, npc, creature)
	npcHandler:setTopic(playerId, TOPIC_AWAITING_DELIVERY)
end

local function receiveDelivery(npc, creature, player)
	local playerId = player:getId()
	npcHandler:setTopic(playerId, TOPIC_NONE)

	local missingLabels = findMissingItems(player, craftUnlockRequirements, {})
	if #missingLabels > 0 then
		npcHandler:say("You are still missing " .. table.concat(missingLabels, ", ") .. ". Come back when you have everything.", npc, creature)
		return
	end

	removeItems(player, craftUnlockRequirements)
	player:setStorageValue(CRAFT_UNLOCK_STORAGE, 1)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have unlocked access to the Craft Bench!")
	player:sendQuestProgress("Craft Bench", true)
	npcHandler:say("Well done. The Craft Bench is now open to you. Return stronger and ask me about the {hard} trial to unlock the advanced recipes.", npc, creature)
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	if not player then
		return false
	end

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local playerId = player:getId()

	if MsgContains(message, "craft") or MsgContains(message, "quest") or MsgContains(message, "mission") then
		explainCraftAccess(npc, creature, player)
		return true
	end

	if MsgContains(message, "hard") or MsgContains(message, "advanced") then
		explainAdvancedCraftAccess(npc, creature, player)
		return true
	end

	local currentTopic = npcHandler:getTopic(playerId)
	if currentTopic == TOPIC_NONE then
		return true
	end

	if MsgContains(message, "yes") then
		if currentTopic == TOPIC_AWAITING_ADVANCED_DELIVERY then
			receiveAdvancedDelivery(npc, creature, player)
			return true
		end

		receiveDelivery(npc, creature, player)
		return true
	end

	if MsgContains(message, "no") then
		npcHandler:say("Then go and gather what I asked for.", npc, creature)
		npcHandler:setTopic(playerId, TOPIC_NONE)
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Greetings, |PLAYERNAME|. I am the Master Artisan. Ask me about the {craft}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "May your forge burn bright.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "May your forge burn bright.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
