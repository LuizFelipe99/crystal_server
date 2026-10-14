local SPELL_UNLOCK_STORAGE = 91004

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_USECHARGES, 1)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onGetFormulaValues(player, skill, attack, factor)
    local level = player:getLevel()
    local min = (level / 3) + (skill * 2.5 + attack) * 1.6
    local max = (level / 3) + (skill * 2.5 + attack) * 3.8
    return -min * 1.1, -max * 1.1
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

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
spell:id(298)
spell:name("Max Berserk")
spell:words("max exori")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_BERSERK)
spell:level(35)
spell:mana(175)
spell:isPremium(true)
spell:needWeapon(true)
spell:cooldown(2 * 3000)
spell:groupCooldown(2 * 3000)
spell:vocation("knight;true", "elite knight;true")
spell:register()