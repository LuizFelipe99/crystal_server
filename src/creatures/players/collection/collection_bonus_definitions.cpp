#include "creatures/players/collection/collection_bonus_definitions.hpp"

#include <pugixml.hpp>
#include "utils/tools.hpp"

namespace {
	constexpr auto OUTFIT_BONUS_FILE = "data/XML/outfit_bonus.xml";
	constexpr auto MOUNT_BONUS_FILE = "data/XML/mount_bonus.xml";
}

CollectionBonusDefinitions &g_collectionBonusDefinitions() {
	static CollectionBonusDefinitions instance;
	return instance;
}

void CollectionBonusCatalog::clear() {
	bonusLists.clear();
	bonusListIndexByName.clear();
}

const CollectionBonusList* CollectionBonusCatalog::find(const std::string &name) const {
	const auto it = bonusListIndexByName.find(asLowerCaseString(name));
	if (it == bonusListIndexByName.end()) {
		return nullptr;
	}

	return &bonusLists[it->second];
}

CollectionBonusList &CollectionBonusCatalog::findOrCreate(const std::string &name, const std::string &alias) {
	const std::string nameKey = asLowerCaseString(name);
	const std::string aliasKey = asLowerCaseString(alias);

	auto existing = bonusListIndexByName.find(nameKey);
	if (existing == bonusListIndexByName.end() && !aliasKey.empty()) {
		existing = bonusListIndexByName.find(aliasKey);
	}

	size_t bonusListIndex = 0;
	if (existing != bonusListIndexByName.end()) {
		bonusListIndex = existing->second;
	} else {
		bonusListIndex = bonusLists.size();
		bonusLists.emplace_back();
	}

	bonusListIndexByName[nameKey] = bonusListIndex;
	if (!aliasKey.empty()) {
		bonusListIndexByName[aliasKey] = bonusListIndex;
	}

	return bonusLists[bonusListIndex];
}

bool CollectionBonusDefinitions::loadFromXml() {
	outfitCatalog.clear();
	mountCatalog.clear();

	const bool outfitsLoaded = loadCatalog(OUTFIT_BONUS_FILE, "outfit", outfitCatalog);
	const bool mountsLoaded = loadCatalog(MOUNT_BONUS_FILE, "mount", mountCatalog);

	g_logger().info("Loaded collection bonuses for {} outfits and {} mounts", outfitCatalog.bonusLists.size(), mountCatalog.bonusLists.size());
	return outfitsLoaded && mountsLoaded;
}

bool CollectionBonusDefinitions::loadCatalog(const std::string &filePath, const std::string &entryName, CollectionBonusCatalog &catalog) {
	pugi::xml_document document;
	const pugi::xml_parse_result result = document.load_file(filePath.c_str());
	if (!result) {
		g_logger().error("[CollectionBonusDefinitions::loadCatalog] Failed to load {}: {}", filePath, result.description());
		return false;
	}

	for (const auto &entryNode : document.first_child().children(entryName.c_str())) {
		const std::string name = entryNode.attribute("name").as_string();
		const std::string attribute = entryNode.attribute("attribute").as_string();
		if (name.empty() || attribute.empty()) {
			g_logger().warn("[CollectionBonusDefinitions::loadCatalog] Skipping {} entry without name or attribute in {}", entryName, filePath);
			continue;
		}

		CollectionBonusList &bonusList = catalog.findOrCreate(name, entryNode.attribute("alias").as_string());
		bonusList.push_back({ attribute, entryNode.attribute("value").as_double() });
	}

	return true;
}

const CollectionBonusList* CollectionBonusDefinitions::getOutfitBonuses(const std::string &outfitName) const {
	return outfitCatalog.find(outfitName);
}

const CollectionBonusList* CollectionBonusDefinitions::getMountBonuses(const std::string &mountName) const {
	return mountCatalog.find(mountName);
}
