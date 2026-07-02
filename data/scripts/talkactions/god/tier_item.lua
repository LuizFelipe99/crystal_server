local tier = TalkAction("!tier")


function tier.onSay(player, words, param)
    if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
        return true
    end
    local split = param:split(",")
    local itemType = ItemType(split[1])
    if itemType:getId() == 0 then
        itemType = ItemType(tonumber(split[1]))
        if not tonumber(split[1]) or itemType:getId() == 0 then
            player:sendCancelMessage("The item you want is misspelled or does not exist.")
            return false
        end
    end
    local tier = tonumber(split[2])
    if tier <= 0 or tier == nil or tier > 10 then
        player:sendCancelMessage("ID de Tier null.")
        return false
    end
    player:addItem(itemType:getId(), 1):setTier(tier)
    return false
end

tier:separator(" ")
tier:groupType("god")
tier:register()