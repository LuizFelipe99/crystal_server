local ELEMENTAL_BUILD_DAMAGE_RATIO = 1.0

local VALID_ELEMENTAL_BUILD_TYPES = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [9] = true,
    [10] = true,
    [11] = true,
}

local restoreElementalBonus = CreatureEvent("RestoreElementalBonus")

function restoreElementalBonus.onLogin(player)
    for combatType, _ in pairs(VALID_ELEMENTAL_BUILD_TYPES) do
        local points = player:getElementalBuildPoints(combatType)
        if points > 0 then
            player:setElementalDamageBonus(combatType, math.floor(points * ELEMENTAL_BUILD_DAMAGE_RATIO))
        end
    end
    return true
end

restoreElementalBonus:register()