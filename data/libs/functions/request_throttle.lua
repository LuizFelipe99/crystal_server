RequestThrottle = {}
RequestThrottle.__index = RequestThrottle

function RequestThrottle.new(intervalMilliseconds)
	return setmetatable({ intervalMilliseconds = intervalMilliseconds, lastRequestAtByGuid = {} }, RequestThrottle)
end

function RequestThrottle:isThrottled(player)
	local playerGuid = player:getGuid()
	local currentTime = systemTime()
	local lastRequestAt = self.lastRequestAtByGuid[playerGuid]
	if lastRequestAt and currentTime - lastRequestAt < self.intervalMilliseconds then
		return true
	end

	self.lastRequestAtByGuid[playerGuid] = currentTime
	return false
end
