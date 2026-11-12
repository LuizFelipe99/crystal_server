#pragma once

#include "config/configmanager.hpp"
#include "items/item.hpp"
#include "utils/utils_definitions.hpp"

namespace ForgeTierWildcard {
	inline constexpr uint8_t CONVERGENCE_CLASSIFICATION = 4;

	inline bool isWildcard(uint16_t itemId) {
		return itemId == ITEM_TRANSFER_TIER_STONE;
	}

	inline uint8_t getClassification(uint16_t itemId) {
		return Item::items[itemId].upgradeClassification;
	}

	inline uint8_t getMaxTier(uint16_t itemId) {
		const auto classification = getClassification(itemId);
		if (classification == CONVERGENCE_CLASSIFICATION) {
			return static_cast<uint8_t>(g_configManager().getNumber(FORGE_MAX_ITEM_TIER));
		}
		return classification;
	}

	inline uint32_t getSlotGroup(uint16_t itemId) {
		const auto slotPosition = Item::items[itemId].slotPosition;
		if ((slotPosition & SLOTP_TWO_HAND) != 0) {
			return SLOTP_HAND;
		}
		return slotPosition;
	}

	inline bool isConvergenceItem(uint16_t itemId) {
		return getClassification(itemId) == CONVERGENCE_CLASSIFICATION;
	}

	inline bool canFuse(uint16_t firstItemId, uint16_t secondItemId, uint8_t tier, bool convergence) {
		if (getClassification(firstItemId) == 0 || getClassification(secondItemId) == 0) {
			return false;
		}
		if (tier >= getMaxTier(firstItemId)) {
			return false;
		}

		const bool usesWildcard = isWildcard(firstItemId) || isWildcard(secondItemId);
		if (convergence) {
			return !usesWildcard;
		}
		return firstItemId == secondItemId || usesWildcard;
	}

	inline bool canTransfer(uint16_t donorItemId, uint16_t receiverItemId, uint8_t tier, bool convergence) {
		if (donorItemId == receiverItemId) {
			return false;
		}
		if (getClassification(donorItemId) == 0 || getClassification(receiverItemId) == 0) {
			return false;
		}

		const uint8_t resultTier = convergence ? tier : static_cast<uint8_t>(tier - 1);
		if (tier == 0 || resultTier == 0 || resultTier > getMaxTier(receiverItemId)) {
			return false;
		}

		if (convergence) {
			return isConvergenceItem(donorItemId) && isConvergenceItem(receiverItemId);
		}

		if (isWildcard(donorItemId) || isWildcard(receiverItemId)) {
			return true;
		}
		return getClassification(donorItemId) == getClassification(receiverItemId) && getSlotGroup(donorItemId) == getSlotGroup(receiverItemId);
	}
}
