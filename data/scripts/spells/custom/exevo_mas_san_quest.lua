local SPELL_UNLOCK_STORAGE = 91004

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 535)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 3) + (maglevel * 8)
	local max = (level / 3) + (maglevel * 12)
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    local player = Player(creature)

    if not player then
        return false
    end

    if player:getStorageValue(SPELL_UNLOCK_STORAGE) == -1 then
        player:sendCancelMessage("You have not unlocked this spell yet.")
        return false
    end

    return combat:execute(creature, var)
end

spell:group("attack")
spell:id(299)
spell:name("Super Divine Caldera")
spell:words("exevo gran mas san")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_DIVINE_CALDERA)
spell:level(600)
spell:mana(230)
spell:isPremium(true)
spell:isSelfTarget(true)
spell:cooldown(3 * 1000)
spell:groupCooldown(3 * 1000)

spell:vocation("paladin;true", "royal paladin;true")
spell:register()
