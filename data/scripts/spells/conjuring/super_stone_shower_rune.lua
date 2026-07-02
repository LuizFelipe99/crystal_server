local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(3147, 51955, 8)
end

spell:name("Super Stone Shower Rune")
spell:words("super adori mas tera")
spell:group("support")
spell:vocation("druid;true", "elder druid;true")
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:level(28)
spell:mana(1400)
spell:soul(5)
spell:isAggressive(false)
spell:isPremium(true)

spell:register()
