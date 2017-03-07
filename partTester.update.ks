// Part Test

	
wait 3.
	
NOTIFY("Starting PartTest").
	
FOR P IN SHIP:SHIP:PARTS{

	print "MODULES FOR PART NAMED " + P:NAME.
	LOG ("MODULES FOR PART NAMED " + P:NAME) TO "0:/Partlog.txt".
	
	LOG P:MODULES TO "0:/Partlog.txt".
	
	}.

