local BOOST_DURATION_SECONDS = 60 * 60

local experienceBoosts = {
	{ itemId = 60661, percent = 10, timeLeftStorage = 64200, lastActivatedAtStorage = 64201 },
	{ itemId = 60659, percent = 20, timeLeftStorage = 64202, lastActivatedAtStorage = 64203 },
	{ itemId = 60660, percent = 30, timeLeftStorage = 64204, lastActivatedAtStorage = 64205 },
}

local function findActiveBoost(player)
	for _, boost in ipairs(experienceBoosts) do
		if boost.concoction:active(player) then
			return boost
		end
	end
	return nil
end

local function activateBoost(concoction, player, item)
	local activeBoost = findActiveBoost(player)
	if activeBoost then
		local timeLeft = activeBoost.concoction:timeLeft(player)
		player:sendTextMessage(MESSAGE_FAILURE, "Your " .. activeBoost.concoction.name .. " is still active for another " .. Game.getTimeInWords(timeLeft) .. ".")
		return
	end
	Concoction.activate(concoction, player, item)
end

for _, boost in ipairs(experienceBoosts) do
	local concoction = Concoction.new({
		id = boost.itemId,
		timeLeftStorage = boost.timeLeftStorage,
		lastActivatedAtStorage = boost.lastActivatedAtStorage,
		config = {
			durationOverride = BOOST_DURATION_SECONDS,
			cooldownOverride = BOOST_DURATION_SECONDS,
			tickTypeOverride = ConcoctionTickType.Online,
			showsEffectTime = true,
		},
	})
	concoction.activate = activateBoost
	concoction:register()
	boost.concoction = concoction
end

local experienceBoostCallback = EventCallback("ExperienceBoostElixirs")

function experienceBoostCallback.playerOnGainExperience(player, target, exp, rawExp)
	if not target or target:isPlayer() then
		return exp
	end

	local activeBoost = findActiveBoost(player)
	if not activeBoost then
		return exp
	end

	return exp + math.floor(exp * activeBoost.percent / 100)
end

experienceBoostCallback:register()
