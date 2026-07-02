local activateBattlePassPro = Action()

local ITEM_PRO_SCROLL_ACTIVE   = 62171
local ITEM_PRO_SCROLL_INACTIVE = 63366  -- mesma aparência, sem action registrada

function activateBattlePassPro.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(BattlePassStorage.isVip) == 1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already have Battle Pass PRO active for this season.")
        item:transform(ITEM_PRO_SCROLL_INACTIVE)
        return true
    end

    player:setStorageValue(BattlePassStorage.isVip, 1)
    item:transform(ITEM_PRO_SCROLL_INACTIVE)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Battle Pass PRO Season " .. BattlePassConfig.season.id .. " activated!")
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    return true
end

activateBattlePassPro:id(ITEM_PRO_SCROLL_ACTIVE)
activateBattlePassPro:register()