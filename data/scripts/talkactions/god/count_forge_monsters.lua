local talkaction = TalkAction("/countinfluenced")

function talkaction.onSay(player, words, param)
	-- create log
	logCommand(player, words, param)

	local influencedMonsters = Game.getInfluencedMonsters()
	local total = #influencedMonsters

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Total influenced monsters: %d.", total))
	return true
end

talkaction:groupType("god")
talkaction:register()

local talkactionFiendish = TalkAction("/countfiendish")

function talkactionFiendish.onSay(player, words, param)
	-- create log
	logCommand(player, words, param)

	local fiendishMonsters = Game.getFiendishMonsters()
	local total = #fiendishMonsters

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Total fiendish monsters: %d.", total))
	return true
end

talkactionFiendish:groupType("god")
talkactionFiendish:register()

local FORGE_AREA_RANGE_X = 8
local FORGE_AREA_RANGE_Y = 6
local FIENDISH_FORGE_STACK = 15

local function collectForgeAreaSummary(centerPosition)
	local summary = { total = 0, influenced = 0, fiendish = 0, disabledSpecies = {} }
	local spectators = Game.getSpectators(centerPosition, false, false, FORGE_AREA_RANGE_X, FORGE_AREA_RANGE_X, FORGE_AREA_RANGE_Y, FORGE_AREA_RANGE_Y)
	for _, creature in ipairs(spectators) do
		local monster = creature:getMonster()
		if monster and not monster:getMaster() then
			summary.total = summary.total + 1
			local forgeStack = monster:getForgeStack()
			if forgeStack >= FIENDISH_FORGE_STACK then
				summary.fiendish = summary.fiendish + 1
			elseif forgeStack > 0 then
				summary.influenced = summary.influenced + 1
			end
			local monsterType = monster:getType()
			if monsterType and not monsterType:isForgeCreature() then
				summary.disabledSpecies[monsterType:getName()] = true
			end
		end
	end
	return summary
end

local function describeDisabledSpecies(disabledSpecies)
	local names = {}
	for name in pairs(disabledSpecies) do
		names[#names + 1] = name
	end
	table.sort(names)
	return #names > 0 and table.concat(names, ", ") or "none"
end

local talkactionForgeArea = TalkAction("/forgearea")

function talkactionForgeArea.onSay(player, words, param)
	logCommand(player, words, param)

	local summary = collectForgeAreaSummary(player:getPosition())
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format(
		"Forge map: %d influenced, %d fiendish. On screen: %d monsters, %d influenced, %d fiendish. Species with forge disabled on screen: %s.",
		#Game.getInfluencedMonsters(),
		#Game.getFiendishMonsters(),
		summary.total,
		summary.influenced,
		summary.fiendish,
		describeDisabledSpecies(summary.disabledSpecies)
	))
	return true
end

talkactionForgeArea:groupType("god")
talkactionForgeArea:register()
