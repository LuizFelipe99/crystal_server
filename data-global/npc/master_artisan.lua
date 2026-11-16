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

local function findMissingRequirements(player)
	local missingLabels = {}
	for _, requirement in ipairs(craftUnlockRequirements) do
		local missingAmount = requirement.amount - player:getItemCount(requirement.itemId)
		if missingAmount > 0 then
			missingLabels[#missingLabels + 1] = missingAmount .. " " .. requirement.name
		end
	end
	return missingLabels
end

local function consumeRequirements(player)
	for _, requirement in ipairs(craftUnlockRequirements) do
		player:removeItem(requirement.itemId, requirement.amount)
	end
end

local function hasCraftAccess(player)
	return player:getStorageValue(CRAFT_UNLOCK_STORAGE) ~= -1
end

local function explainCraftAccess(npc, creature, player)
	local playerId = player:getId()

	if hasCraftAccess(player) then
		npcHandler:say("You already have access to the Craft Bench. The most powerful recipes are sealed until you complete the {hard} trial deep in the Rotten Blood.", npc, creature)
		npcHandler:setTopic(playerId, TOPIC_NONE)
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

	local missingLabels = findMissingRequirements(player)
	if #missingLabels > 0 then
		npcHandler:say("You are still missing " .. table.concat(missingLabels, ", ") .. ". Come back when you have everything.", npc, creature)
		return
	end

	consumeRequirements(player)
	player:setStorageValue(CRAFT_UNLOCK_STORAGE, 1)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have unlocked access to the Craft Bench!")
	player:sendQuestProgress("Craft Bench", true)
	npcHandler:say("Well done. The Craft Bench is now open to you. Return stronger and seek the {hard} trial to unlock the advanced recipes.", npc, creature)
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

	if MsgContains(message, "hard") then
		npcHandler:say("Somewhere in the Rotten Blood lies a forgotten chest. Whoever claims it unlocks the advanced recipes: gems of level 5 and above and the equipment of the Soul War and beyond.", npc, creature)
		return true
	end

	if npcHandler:getTopic(playerId) ~= TOPIC_AWAITING_DELIVERY then
		return true
	end

	if MsgContains(message, "yes") then
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
