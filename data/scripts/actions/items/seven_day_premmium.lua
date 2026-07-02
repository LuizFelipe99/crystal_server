local premiumGrantScroll = Action()

local PREMIUM_DAYS_TO_GRANT = 7

function premiumGrantScroll.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    player:addPremiumDays(PREMIUM_DAYS_TO_GRANT)
    item:remove(1)
    player:say("A magical energy surrounds you as " .. PREMIUM_DAYS_TO_GRANT .. " days of premium time are granted.", TALKTYPE_MONSTER_SAY)
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    return true
end

premiumGrantScroll:id(60422)
premiumGrantScroll:register()