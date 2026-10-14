local json = dofile("data/libs/dkjson.lua")

local POTION_COOLDOWN_OPCODE = 20

local function calculateReuseCooldownRemaining(player, concoction)
    local lastActivatedAt = concoction:lastActivatedAt(player)
    if lastActivatedAt <= 0 then
        return 0
    end

    local cooldownExpiresAt = lastActivatedAt + concoction:cooldown()
    return math.max(0, cooldownExpiresAt - os.time())
end

local function buildActivePotionCooldownsForPlayer(player)
    local activeCooldowns = {}

    for _, concoction in ipairs(Concoction.getAll()) do
        local remainingSeconds = calculateReuseCooldownRemaining(player, concoction)

        if remainingSeconds > 0 then
            activeCooldowns[#activeCooldowns + 1] = {
                potionId = concoction.id,
                name = concoction.name,
                itemId = concoction.id,
                cooldownExpiresAt = os.time() + remainingSeconds
            }
        end
    end

    return activeCooldowns
end

local function sendPotionCooldownsToPlayer(player)
    local payload = {
        action = "data",
        potions = buildActivePotionCooldownsForPlayer(player)
    }
    player:sendExtendedOpcode(POTION_COOLDOWN_OPCODE, json.encode(payload))
end

local function handleRequest(player)
    sendPotionCooldownsToPlayer(player)
end

local function onExtendedOpcodeReceived(player, opcode, buffer)
    if opcode ~= POTION_COOLDOWN_OPCODE then
        return true
    end

    local data, _, err = json.decode(buffer)

    if err or not data or not data.action then
        return true
    end

    if data.action == "request" then
        handleRequest(player)
    end

    return true
end

function notifyPlayerPotionCooldownsChanged(player)
    sendPotionCooldownsToPlayer(player)
end

local potionCooldownOpcodeEvent = CreatureEvent("PotionCooldownOpcode")
potionCooldownOpcodeEvent:type("extendedopcode")
potionCooldownOpcodeEvent:onExtendedOpcode(onExtendedOpcodeReceived)
potionCooldownOpcodeEvent:register()

local potionCooldownLoginEvent = CreatureEvent("PotionCooldownLogin")
potionCooldownLoginEvent:type("login")

potionCooldownLoginEvent:onLogin(function(player)
    player:registerEvent("PotionCooldownOpcode")
    return true
end)

potionCooldownLoginEvent:register()