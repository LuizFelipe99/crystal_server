local updateInterval = 60

local allAmplificationIds = {
	Concoction.Ids.FireAmplification,
	Concoction.Ids.IceAmplification,
	Concoction.Ids.EarthAmplification,
	Concoction.Ids.EnergyAmplification,
	Concoction.Ids.HolyAmplification,
	Concoction.Ids.DeathAmplification,
	Concoction.Ids.PhysicalAmplification,
}

local function scheduleAmplificationTick(concoctionId, playerId, timeDeduction)
	local player = Player(playerId)
	if not player then
		return
	end

	local concoction = Concoction.find(concoctionId)
	if not concoction then
		return
	end

	concoction:tick(player, timeDeduction)
end

local function activateAmplification(player, concoction)
	local cooldownRemaining = concoction:lastActivatedAt(player) + concoction:cooldown() - os.time()
	if cooldownRemaining > 0 then
		return false
	end

	concoction:timeLeft(player, concoction:totalDuration())
	concoction:lastActivatedAt(player, os.time())
	concoction:update(player)

	if concoction.config.callback then
		concoction.config.callback(player, concoction.config)
		return true
	end

	concoction:addCondition(player)
	if concoction:tickType() == ConcoctionTickType.Online then
		addEvent(scheduleAmplificationTick, updateInterval * 1000, concoction.id, player:getId(), updateInterval)
	end

	return true
end

local allAmplificationAction = Action()

function allAmplificationAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player then
		return true
	end

	local activatedCount = 0
	for _, concoctionId in ipairs(allAmplificationIds) do
		local concoction = Concoction.find(concoctionId)
		if concoction and activateAmplification(player, concoction) then
			activatedCount = activatedCount + 1
		end
	end

	if activatedCount == 0 then
		player:sendTextMessage(MESSAGE_FAILURE, "All your amplifications are still on cooldown.")
		return true
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have activated " .. activatedCount .. " amplifications.")
	item:remove(1)
	return true
end

allAmplificationAction:id(60605)
allAmplificationAction:register()