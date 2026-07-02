local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(3147, 51954, 5)
end

spell:name("Super Sudden Death Rune")
spell:words("super adori gran mort")
spell:group("support")
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:level(45)
spell:mana(1500)
spell:soul(5)
spell:isAggressive(false)

spell:register()
