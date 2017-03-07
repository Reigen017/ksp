// Part Test

	
wait 3.
	
NOTIFY("Starting PartTest").
	
REQUIRE("FindParts.ks").
REQUIRE("parts.ks").

log_parts_and_modules().
ListScienceModules().