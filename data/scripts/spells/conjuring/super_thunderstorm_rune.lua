local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(3147, 51953, 5)
end

spell:name("Super Thunderstorm Rune")
spell:words("super adori mas vis")
spell:group("support")
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:level(28)
spell:mana(1500)
spell:soul(5)
spell:isAggressive(false)
spell:isPremium(true)

spell:register()
