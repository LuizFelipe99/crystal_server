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

local setElementalBonus = TalkAction("/setelementalbonus")

function setElementalBonus.onSay(player, words, param)
    logCommand(player, words, param)

    if param == "" then
        player:sendCancelMessage("Usage: /setelementalbonus playername, points")
        return true
    end

    local split = param:split(",")
    if #split < 2 then
        player:sendCancelMessage("Usage: /setelementalbonus playername, points")
        return true
    end

    local targetName = Game.getNormalizedPlayerName(split[1]:trim())
    if not targetName then
        player:sendCancelMessage("Player not found.")
        return true
    end

    local points = tonumber(split[2]:trim())
    if not points or points <= 0 then
        player:sendCancelMessage("Invalid points.")
        return true
    end

    local targetPlayer = Player(targetName)
    if not targetPlayer then
        player:sendCancelMessage("Player " .. targetName .. " is not online.")
        return true
    end

    targetPlayer:setElementalBuildAvailablePoints(targetPlayer:getElementalBuildAvailablePoints() + points)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Added " .. points .. " elemental build points to " .. targetName .. ". Total: " .. targetPlayer:getElementalBuildAvailablePoints())
    logger.info("{} added {} elemental build points to {}", player:getName(), points, targetName)
    return true
end

setElementalBonus:separator(" ")
setElementalBonus:groupType("god")
setElementalBonus:register()