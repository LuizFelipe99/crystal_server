local config = {
	bossName = "Drume",
	bossPosition = Position(32444, 32516, 7),
	firstPlayerPosition = Position(32457, 32508, 6),
	playerTilesCount = 5,
	centerPosition = Position(32439, 32523, 7),
	exitPosition = Position(32453, 32503, 7),
	newPosition = Position(32453, 32510, 7),
	rangeX = 22,
	rangeY = 16,
	timeToKill = 20,
}

local currentEvent = nil

local function getRoomSpectators(onlyPlayers)
	return Game.getSpectators(config.centerPosition, false, onlyPlayers, config.rangeX, config.rangeX, config.rangeY, config.rangeY)
end

local function clearRoomDrume()
	for _, spectator in pairs(getRoomSpectators(false)) do
		if spectator:isMonster() then
			spectator:remove()
		end
		if spectator:isPlayer() then
			spectator:teleportTo(config.exitPosition)
			spectator:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your time is over.")
		end
	end
	currentEvent = nil
end

local function collectWaitingPlayers()
	local waitingPlayers = {}
	for tileIndex = 0, config.playerTilesCount - 1 do
		local tile = Tile(Position(config.firstPlayerPosition.x + tileIndex, config.firstPlayerPosition.y, config.firstPlayerPosition.z))
		local topCreature = tile and tile:getTopCreature()
		if topCreature and topCreature:isPlayer() then
			table.insert(waitingPlayers, topCreature)
		end
	end
	return waitingPlayers
end

local function isPlayerWaiting(player, waitingPlayers)
	for _, waitingPlayer in pairs(waitingPlayers) do
		if waitingPlayer:getId() == player:getId() then
			return true
		end
	end
	return false
end

local function findPlayerOnCooldown(waitingPlayers)
	for _, waitingPlayer in pairs(waitingPlayers) do
		if not waitingPlayer:canFightBoss(config.bossName) then
			return waitingPlayer
		end
	end
	return nil
end

local function cancelWithMessage(player, message)
	player:sendCancelMessage(message)
	player:getPosition():sendMagicEffect(CONST_ME_POFF)
	return true
end

local drumeAction = Action()
function drumeAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local waitingPlayers = collectWaitingPlayers()
	if not isPlayerWaiting(player, waitingPlayers) then
		return cancelWithMessage(player, "You need to stand on the tiles in front of the rope to start the fight.")
	end

	if #getRoomSpectators(true) ~= 0 then
		return cancelWithMessage(player, "There's someone already in the skirmish.")
	end

	local playerOnCooldown = findPlayerOnCooldown(waitingPlayers)
	if playerOnCooldown then
		return cancelWithMessage(player, playerOnCooldown:getName() .. " has already fought Drume recently.")
	end

	clearRoomDrume()

	local boss = Game.createMonster(config.bossName, config.bossPosition, false, true)
	if not boss then
		return cancelWithMessage(player, "There was an error, contact an admin.")
	end
	boss:registerEvent("DrumeKill")

	for _, waitingPlayer in pairs(waitingPlayers) do
		waitingPlayer:setBossCooldown(config.bossName, os.time() + configManager.getNumber(configKeys.BOSS_DEFAULT_TIME_TO_FIGHT_AGAIN))
		waitingPlayer:teleportTo(config.newPosition)
		waitingPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have " .. config.timeToKill .. " minutes to defeat Drume.")
	end

	if currentEvent then
		stopEvent(currentEvent)
	end
	currentEvent = addEvent(clearRoomDrume, config.timeToKill * 60 * 1000)
	config.newPosition:sendMagicEffect(CONST_ME_TELEPORT)
	toPosition:sendMagicEffect(CONST_ME_POFF)
	return true
end

drumeAction:aid(59601)
drumeAction:register()
