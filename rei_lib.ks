
FUNCTION ISH {
  PARAMETER a.
  PARAMETER b.
  PARAMETER ishyiness.

  RETURN a - ishyiness < b AND a + ishyiness > b.
}

function ChangePeri{
	parameter peri.
	
	set rate to 0.001.
	SET X TO NODE(TIME:SECONDS+ETA:APOAPSIS, 0, 0, 0).
	ADD X.
	
	set diff to abs(x:ORBIT:PERIAPSIS - peri).
	
	until ish(x:ORBIT:PERIAPSIS, peri) {
		set prevDiff to diff.
		SET X:PROGRADE to X:PROGRADE +rate.
		set diff to abs(x:ORBIT:PERIAPSIS - peri).
		if prevDiff > diff { set rate to rate * -1. }.
	}.
}

function ChangeApo{
	parameter apo.
	
	set rate to 0.001.
	SET X TO NODE(TIME:SECONDS+ETA:PERIAPSIS, 0, 0, 0).
	ADD X.
	
	set diff to abs(x:ORBIT:APOAPSIS - apo).
	
	until ish(x:ORBIT:APOAPSIS, apo) {
		set prevDiff to diff.
		SET X:PROGRADE to X:PROGRADE +rate.
		set diff to abs(x:ORBIT:APOAPSIS - apo).
		if prevDiff > diff { set rate to rate * -1. }.
	}.
}