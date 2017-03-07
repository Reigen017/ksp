
function log_parts_and_modules {


FOR P IN SHIP:SHIP:PARTS{

	print "MODULES FOR PART NAMED " + P:NAME.
	print P:MODULES.
	LOG ("MODULES FOR PART NAMED " + P:NAME) TO "0:/Partlog.txt".
	
	LOG P:MODULES TO "0:/Partlog.txt".
	
	}.

}

