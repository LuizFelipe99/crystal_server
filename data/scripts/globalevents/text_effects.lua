local effectsConfig = {
    -- { position = Position(32368, 32235, 7), effect = CONST_ME_POWERFUL_HEARTS, text = "Hello!", interval = 3000 }, -- Effect & Text
    -- { position = Position(1000, 1001, 7), effect = CONST_ME_POWERFUL_HEARTS, interval = 5000 }, -- Only Effect
    { position = Position(32362, 32220, 7), text = "Hunts", interval = 3000 }, -- Only Text
    { position = Position(32362, 32222, 7), text = "Boss", interval = 3000 }, -- Only Text
    { position = Position(32362, 32224, 7), text = "Quests", interval = 3000 }, -- Only Text


    { position = Position(31774, 33254, 7), text = "Easy", interval = 3000 }, -- Only Text
    { position = Position(31777, 33254, 7), text = "Medium", interval = 3000 }, -- Only Text
    { position = Position(31780, 33254, 7), text = "Hard", interval = 3000 }, -- Only Text
}

local MagicEffects = GlobalEvent("MagicEffects")


function MagicEffects.onThink(interval)
    local now = os.time() * 1000 -- milliseconds

    for _, entry in ipairs(effectsConfig) do
        if not entry.lastRun then
            entry.lastRun = 0
        end

        local intervalMs = entry.interval or 5000
        if now - entry.lastRun >= intervalMs then
            if entry.effect and entry.position then
                entry.position:sendMagicEffect(entry.effect)
            end

            if entry.text and entry.text ~= "" and entry.position then
                local spectators = Game.getSpectators(entry.position, true, false, 7, 7, 5, 5)
                if #spectators > 0 then
                    for _, spectator in ipairs(spectators) do
                        spectator:say(entry.text, TALKTYPE_MONSTER_SAY, false, spectator, entry.position)
                    end
                end
            end

            entry.lastRun = now
        end
    end

    return true
end

MagicEffects:interval(1000)
MagicEffects:register()