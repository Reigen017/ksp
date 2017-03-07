// functions that activate specific parts or part groups
function deployChutes{
	WHEN (NOT CHUTESSAFE) THEN {
    CHUTESSAFE ON.
    RETURN (NOT CHUTES).
	}
}

declare function ListScienceModules {
    declare local scienceModules to list().
    declare local partList to ship:parts.

    for thePart in partList {
        declare local moduleList to thePart:modules.
        from {local i is 0.} until i = moduleList:length step {set i to i+1.} do {
            set theModule to moduleList[i].
            // just check for the Module Name. This might be extended in the future.
            if (theModule = "ModuleScienceExperiment") or (theModule = "DMModuleScienceAnimate") {
                scienceModules:add(thePart:getModuleByIndex(i)). // add it to the list
            }
        }
    }
    LOG scienceModules TO "0:/SciMods.txt".
    return scienceModules.
}

function runAllScience {
	for mod in ListScienceModules(){
	mod.DOEVENT("").
	}
}