local BOSS_DAMAGE_MULTIPLIER = 2.0
local BOSS_DAMAGE_EVENT_NAME = "BossDamageBoost"

local function isPlayerSourced(attacker)
	if not attacker then
		return false
	end
	if attacker:isPlayer() then
		return true
	end
	local master = attacker:getMaster()
	return master ~= nil and master:isPlayer()
end

local function isBossMonsterType(monsterType)
	if monsterType:isRewardBoss() then
		return true
	end
	return (monsterType:bossRaceId() or 0) > 0
end

local function boostDamage(damage)
	return math.floor(damage * BOSS_DAMAGE_MULTIPLIER)
end

local bossDamageBoost = CreatureEvent(BOSS_DAMAGE_EVENT_NAME)

function bossDamageBoost.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if primaryType == COMBAT_HEALING or not isPlayerSourced(attacker) then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	return boostDamage(primaryDamage), primaryType, boostDamage(secondaryDamage), secondaryType
end

bossDamageBoost:register()

local registerBossDamageBoost = GlobalEvent("RegisterBossDamageBoost")

function registerBossDamageBoost.onStartup()
	local registeredCount = 0
	for _, monsterType in pairs(Game.getMonsterTypes()) do
		if isBossMonsterType(monsterType) then
			monsterType:registerEvent(BOSS_DAMAGE_EVENT_NAME)
			registeredCount = registeredCount + 1
		end
	end
	logger.info("[BossDamageBoost] Bosses receive {}x damage from players ({} boss types)", BOSS_DAMAGE_MULTIPLIER, registeredCount)
	return true
end

registerBossDamageBoost:register()
