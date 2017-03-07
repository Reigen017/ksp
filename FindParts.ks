
function log_parts_and_modules {

FOR P IN SHIP:PARTSINGROUP( LIGHTS ) {
	LOG ("MODULES FOR PART NAMED " + P:NAME) TO MODLIST.
	LOG P:MODULES TO Partlog.txt.
	}.
}
