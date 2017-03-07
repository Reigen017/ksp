
function log_parts_and_modules {


FOR P IN SHIP:PARTS{

	print "MODULES FOR PART NAMED " + P:NAME.
	LOG ("MODULES FOR PART NAMED " + P:NAME) TO "0:/Partlog.txt".
	
	
FOR M IN P:MODULES{

		set mod to P:GETMODULE(M).
		LOG "ALL EVENT NAMES:" TO "0:/Partlog.txt".

		LOG mod :ALLEVENTNAMES TO "0:/Partlog.txt".

		LOG "ALL ACTION NAMES:" TO "0:/Partlog.txt".

		LOG mod :ALLACTIONNAMES TO "0:/Partlog.txt".

	}
	}.

}

