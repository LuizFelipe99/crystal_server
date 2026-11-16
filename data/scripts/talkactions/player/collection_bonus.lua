local COLLECTION_BONUS_DIALOG_ITEM_ID = 64485

local collectionBonusLabels = {
	onslaught = { label = "Onslaught", unit = "%" },
	transcendence = { label = "Transcendence", unit = "%" },
	critChance = { label = "Critical chance", unit = "%" },
	critDamage = { label = "Critical damage", unit = "%" },
	allSkills = { label = "All skills", unit = "" },
	sword = { label = "Sword fighting", unit = "" },
	axe = { label = "Axe fighting", unit = "" },
	club = { label = "Club fighting", unit = "" },
	distance = { label = "Distance fighting", unit = "" },
	fist = { label = "Fist fighting", unit = "" },
	shield = { label = "Shielding", unit = "" },
	magicLevel = { label = "Magic level", unit = "" },
	dodge = { label = "Dodge", unit = "%" },
	resistAll = { label = "All resistances", unit = "%" },
	resistPhysical = { label = "Physical resistance", unit = "%" },
	resistFire = { label = "Fire resistance", unit = "%" },
	resistIce = { label = "Ice resistance", unit = "%" },
	resistEnergy = { label = "Energy resistance", unit = "%" },
	resistEarth = { label = "Earth resistance", unit = "%" },
	resistDeath = { label = "Death resistance", unit = "%" },
	resistHoly = { label = "Holy resistance", unit = "%" },
	healthPercent = { label = "Max health", unit = "%" },
	manaPercent = { label = "Max mana", unit = "%" },
	health = { label = "Max health", unit = "" },
	mana = { label = "Max mana", unit = "" },
	attackSpeedPercent = { label = "Attack speed", unit = "%" },
}

local function describeAttribute(attribute)
	return collectionBonusLabels[attribute] or { label = attribute, unit = "" }
end

local function formatBonusValue(bonusValue)
	if bonusValue == math.floor(bonusValue) then
		return string.format("%d", bonusValue)
	end

	local formattedValue = string.format("%.2f", bonusValue):gsub("0+$", ""):gsub("%.$", "")
	return formattedValue
end

local function describeBonus(attribute, bonusValue)
	local attributeDescription = describeAttribute(attribute)
	return "+" .. formatBonusValue(bonusValue) .. attributeDescription.unit .. " " .. attributeDescription.label
end

local function sumBonusesByAttribute(bonusSources)
	local totalsByAttribute = {}
	local attributeOrder = {}

	for _, bonusSource in ipairs(bonusSources) do
		for _, bonus in ipairs(bonusSource.bonuses) do
			if not totalsByAttribute[bonus.attribute] then
				totalsByAttribute[bonus.attribute] = 0
				attributeOrder[#attributeOrder + 1] = bonus.attribute
			end
			totalsByAttribute[bonus.attribute] = totalsByAttribute[bonus.attribute] + bonus.value
		end
	end

	table.sort(attributeOrder, function(firstAttribute, secondAttribute)
		return describeAttribute(firstAttribute).label < describeAttribute(secondAttribute).label
	end)

	return totalsByAttribute, attributeOrder
end

local function filterSourcesByType(bonusSources, sourceType)
	local filteredSources = {}

	for _, bonusSource in ipairs(bonusSources) do
		if bonusSource.type == sourceType then
			filteredSources[#filteredSources + 1] = bonusSource
		end
	end

	table.sort(filteredSources, function(firstSource, secondSource)
		return firstSource.name < secondSource.name
	end)

	return filteredSources
end

local function describeSourceList(title, bonusSources)
	if #bonusSources == 0 then
		return title .. " (0)\nNone yet."
	end

	local lines = { title .. " (" .. #bonusSources .. ")" }
	for _, bonusSource in ipairs(bonusSources) do
		local bonusDescriptions = {}
		for _, bonus in ipairs(bonusSource.bonuses) do
			bonusDescriptions[#bonusDescriptions + 1] = describeBonus(bonus.attribute, bonus.value)
		end
		lines[#lines + 1] = "- " .. bonusSource.name .. ": " .. table.concat(bonusDescriptions, ", ")
	end

	return table.concat(lines, "\n")
end

local function buildCollectionBonusText(bonusSources)
	local totalsByAttribute, attributeOrder = sumBonusesByAttribute(bonusSources)
	local totalLines = { "Collection bonuses (total)" }

	for _, attribute in ipairs(attributeOrder) do
		totalLines[#totalLines + 1] = describeBonus(attribute, totalsByAttribute[attribute])
	end

	return table.concat({
		table.concat(totalLines, "\n"),
		describeSourceList("Outfits", filterSourcesByType(bonusSources, "outfit")),
		describeSourceList("Mounts", filterSourcesByType(bonusSources, "mount")),
		"Every outfit and mount you own adds its bonus, even when you are not wearing it. Skill bonuses are rounded down.",
	}, "\n\n")
end

local collectionBonusCommand = TalkAction("!bonus")

function collectionBonusCommand.onSay(player, words, param)
	local bonusSources = player:getCollectionBonuses()

	if not bonusSources or #bonusSources == 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have no collection bonuses yet. Collect outfits and mounts to earn permanent bonuses.")
		return true
	end

	player:showTextDialog(COLLECTION_BONUS_DIALOG_ITEM_ID, buildCollectionBonusText(bonusSources))
	return true
end

collectionBonusCommand:setDescription("[Usage]: !bonus to see every bonus granted by your outfits and mounts")
collectionBonusCommand:groupType("normal")
collectionBonusCommand:register()
