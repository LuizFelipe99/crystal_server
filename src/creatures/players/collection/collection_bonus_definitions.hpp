#pragma once

#include <string>
#include <unordered_map>
#include <vector>

struct CollectionBonusDefinition {
	std::string attribute;
	double value = 0;
};

using CollectionBonusList = std::vector<CollectionBonusDefinition>;

struct CollectionBonusCatalog {
	std::vector<CollectionBonusList> bonusLists;
	std::unordered_map<std::string, size_t> bonusListIndexByName;

	void clear();
	const CollectionBonusList* find(const std::string &name) const;
	CollectionBonusList &findOrCreate(const std::string &name, const std::string &alias);
};

class CollectionBonusDefinitions {
public:
	bool loadFromXml();
	const CollectionBonusList* getOutfitBonuses(const std::string &outfitName) const;
	const CollectionBonusList* getMountBonuses(const std::string &mountName) const;

private:
	static bool loadCatalog(const std::string &filePath, const std::string &entryName, CollectionBonusCatalog &catalog);

	CollectionBonusCatalog outfitCatalog;
	CollectionBonusCatalog mountCatalog;
};

CollectionBonusDefinitions &g_collectionBonusDefinitions();
