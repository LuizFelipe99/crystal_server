#include "creatures/players/gembag/gem_definitions.hpp"

#include <pugixml.hpp>
#include "utils/tools.hpp"

GemDefinitions &g_gemDefinitions() {
	static GemDefinitions instance;
	return instance;
}

bool GemDefinitions::loadFromXml() {
	pugi::xml_document document;
	const pugi::xml_parse_result result = document.load_file("data/XML/gems.xml");
	if (!result) {
		g_logger().error("[GemDefinitions::load] Failed to load data/XML/gems.xml: {}", result.description());
		return false;
	}

	gemMap.clear();

	for (const auto &gemNode : document.child("gems").children("gem")) {
		const uint16_t itemId = gemNode.attribute("id").as_uint();
		if (itemId == 0) {
			g_logger().warn("[GemDefinitions::load] Skipping gem entry with missing or invalid id");
			continue;
		}

		GemDefinition definition;
		definition.type = gemNode.attribute("type").as_string();
		definition.attribute = gemNode.attribute("attribute").as_string();
		definition.value = gemNode.attribute("value").as_float();

		gemMap[itemId] = definition;
	}

	g_logger().info("Loaded {} gem definitions", gemMap.size());
	return true;
}

const GemDefinition* GemDefinitions::getById(uint16_t itemId) const {
	const auto it = gemMap.find(itemId);
	if (it == gemMap.end()) {
		return nullptr;
	}

	return &it->second;
}