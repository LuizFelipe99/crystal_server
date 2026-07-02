local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(3147, 51952, 5)
end

spell:name("Super Avalanche Rune")
spell:words("super adori mas frigo")
spell:group("support")
spell:vocation("druid;true", "elder druid;true")
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:level(30)
spell:mana(1500)
spell:soul(5)
spell:isAggressive(false)

spell:register()
