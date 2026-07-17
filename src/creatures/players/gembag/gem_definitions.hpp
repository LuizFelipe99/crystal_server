#pragma once

#include <cstdint>
#include <string>
#include <unordered_map>

struct GemDefinition {
	std::string type;
	std::string attribute;
	float value = 0;
};

class GemDefinitions {
public:
    bool loadFromXml();
	const GemDefinition* getById(uint16_t itemId) const;

private:
	std::unordered_map<uint16_t, GemDefinition> gemMap;
};

GemDefinitions &g_gemDefinitions();