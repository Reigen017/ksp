// functions that activate specific parts or part groups
function deployChutes{
	WHEN (NOT CHUTESSAFE) THEN {
    CHUTESSAFE ON.
    RETURN (NOT CHUTES).
	}
}
