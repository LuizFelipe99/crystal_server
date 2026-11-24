local internalNpcName = "Kaelor"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

local BOSS_TOKEN_ITEM_ID = 60057

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 150
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 131,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 94,
	lookFeet = 114,
	lookAddons = 3,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.currency = BOSS_TOKEN_ITEM_ID

npcConfig.shop = {
	{ itemName = "stamina extension", clientId = 36725, buy = 5 },
	{ itemName = "prey wildcard", clientId = 60445, buy = 5 },
	{ itemName = "all resilience", clientId = 60606, buy = 5 },
	{ itemName = "all amplification", clientId = 60605, buy = 5 },
	{ itemName = "experience elixir", clientId = 60659, buy = 15 },
	{ itemName = "roulete coin", clientId = 63060, buy = 25 },
	{ itemName = "attribute gem bag", clientId = 60313, buy = 30 },
	{ itemName = "bag you desire", clientId = 34109, buy = 40 },
	{ itemName = "primal bag", clientId = 39546, buy = 50 },
	{ itemName = "upgrade build stone", clientId = 60863, buy = 60 },
}

npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end

npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost) end

npcType.onCheckItem = function(npc, player, clientId, subType) end

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Boss tokens! Trade the trophies of your hardest fights!" },
	{ text = "Stamina, elixirs, rare bags... all for a handful of boss tokens." },
	{ text = "Slain a mighty boss? Show me its token!" },
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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	if not player or not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "token") or MsgContains(message, "trade") then
		npc:openShopWindow(creature)
		npcHandler:say("Every boss of Noxum may leave a {boss token} behind. Bring them to me and pick your reward.", npc, creature)
		return true
	end

	if MsgContains(message, "information") then
		npcHandler:say("I collect boss tokens. Defeat the great bosses of Noxum and some of them will drop a token. Ask me to {trade} when you have some.", npc, creature)
		return true
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Greetings, |PLAYERNAME|. Do you carry any {boss token}s? Say {trade} to see my offers.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Come back with more tokens, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Come back with more tokens.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
