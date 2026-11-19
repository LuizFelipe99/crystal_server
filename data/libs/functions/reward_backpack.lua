RewardBackpack = {}

local REWARD_BACKPACK_ITEM_ID = 2854

local function splitIntoStacks(itemId, amount)
	local itemType = ItemType(itemId)
	local stackSize = itemType:isStackable() and math.max(1, itemType:getStackSize()) or 1
	local stacks = {}
	local remainingAmount = amount
	while remainingAmount > 0 do
		local stackAmount = math.min(stackSize, remainingAmount)
		stacks[#stacks + 1] = stackAmount
		remainingAmount = remainingAmount - stackAmount
	end
	return stacks
end

local function packIntoBackpacks(items)
	local backpacks = {}
	local currentBackpack = nil

	for _, item in ipairs(items) do
		for _, stackAmount in ipairs(splitIntoStacks(item.itemId, item.amount)) do
			if not currentBackpack or currentBackpack:getEmptySlots() == 0 then
				currentBackpack = Game.createItem(REWARD_BACKPACK_ITEM_ID, 1)
				backpacks[#backpacks + 1] = currentBackpack
			end
			currentBackpack:addItem(item.itemId, stackAmount)
		end
	end

	return backpacks
end

local function deliverBackpack(player, backpack)
	if player:addItemEx(backpack, false) == RETURNVALUE_NOERROR then
		return true
	end

	local inbox = player:getInbox()
	if inbox and inbox:addItemEx(backpack, INDEX_WHEREEVER, FLAG_NOLIMIT) == RETURNVALUE_NOERROR then
		return false
	end

	player:addItemEx(backpack, true)
	return true
end

function RewardBackpack.deliver(player, items)
	local deliveredToPlayer = true
	for _, backpack in ipairs(packIntoBackpacks(items)) do
		if not deliverBackpack(player, backpack) then
			deliveredToPlayer = false
		end
	end
	return deliveredToPlayer
end
