// Part Test

	
wait 3.
	
NOTIFY("Starting PartTest").
	
REQUIRE("findParts.ks").

log_parts_and_modules().