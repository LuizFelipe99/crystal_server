RottenBloodBakragoreRequirement = {
	requiredBosses = { "murcion", "chagorz", "ichgahal", "vemiath" },
}

local QUEST_SCOPE = "rotten-blood-quest"
local DEFEATED_KEY = "defeated-for-bakragore"

local function getDefeatedScope(player)
	return player:kv():scoped(QUEST_SCOPE):scoped(DEFEATED_KEY)
end

function RottenBloodBakragoreRequirement.getMissingBosses(player)
	local defeatedScope = getDefeatedScope(player)
	local missingBosses = {}
	for _, bossName in ipairs(RottenBloodBakragoreRequirement.requiredBosses) do
		if not defeatedScope:get(bossName) then
			missingBosses[#missingBosses + 1] = (bossName:titleCase())
		end
	end
	return missingBosses
end

function RottenBloodBakragoreRequirement.check(player)
	local missingBosses = RottenBloodBakragoreRequirement.getMissingBosses(player)
	if #missingBosses == 0 then
		return true
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "To face Bakragore you still need to defeat: " .. table.concat(missingBosses, ", ") .. ".")
	player:getPosition():sendMagicEffect(CONST_ME_POFF)
	return false
end

local function registerDefeat(bossName)
	return function(creature, player)
		getDefeatedScope(player):set(bossName, true)
	end
end

local function resetDefeats(creature, player)
	local defeatedScope = getDefeatedScope(player)
	for _, bossName in ipairs(RottenBloodBakragoreRequirement.requiredBosses) do
		defeatedScope:remove(bossName)
	end
end

local rottenBloodBossDeath = CreatureEvent("RottenBloodBossDeath")

function rottenBloodBossDeath.onDeath(creature)
	local bossName = creature:getName():lower()
	if bossName == "bakragore" then
		onDeathForDamagingPlayers(creature, resetDefeats)
		return true
	end

	if not table.contains(RottenBloodBakragoreRequirement.requiredBosses, bossName) then
		return true
	end

	onDeathForDamagingPlayers(creature, registerDefeat(bossName))
	return true
end

rottenBloodBossDeath:register()

local bakragoreEntrance = {
	position = Position(34106, 32054, 13),
	destination = Position(33071, 32403, 15),
}

local bakragoreEntranceAction = Action()

function bakragoreEntranceAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getLevel() < 250 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need at least level 250 to enter.")
		return true
	end

	if not RottenBloodBakragoreRequirement.check(player) then
		return true
	end

	player:teleportTo(bakragoreEntrance.destination)
	bakragoreEntrance.destination:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

bakragoreEntranceAction:position(bakragoreEntrance.position)
bakragoreEntranceAction:register()
