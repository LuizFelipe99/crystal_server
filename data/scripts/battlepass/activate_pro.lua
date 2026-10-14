local PRO_SCROLLS = {
    { seasonId = 1, activeItemId = 62171, inactiveItemId = 63366 },
}

local function findScrollByActiveItemId(activeItemId)
    for _, scroll in ipairs(PRO_SCROLLS) do
        if scroll.activeItemId == activeItemId then
            return scroll
        end
    end
    return nil
end

local activateBattlePassPro = Action()

function activateBattlePassPro.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local scroll = findScrollByActiveItemId(item:getId())
    if not scroll then
        return false
    end

    if scroll.seasonId ~= BattlePassConfig.season.id then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This Battle Pass PRO scroll belongs to another season.")
        return true
    end

    if player:getStorageValue(BattlePassStorage.isVip) == 1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already have Battle Pass PRO active for this season.")
        return true
    end

    player:setStorageValue(BattlePassStorage.isVip, 1)
    item:transform(scroll.inactiveItemId)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Battle Pass PRO Season " .. BattlePassConfig.season.id .. " activated!")
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    return true
end

for _, scroll in ipairs(PRO_SCROLLS) do
    activateBattlePassPro:id(scroll.activeItemId)
end
activateBattlePassPro:register()
