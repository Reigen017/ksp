wait until eta:periapsis < 40.
lock steering to retrograde.
wait 45.

set gravity to body:mu / ((ship:altitude + body:radius)^2).
set shiptwr to ship:maxthrust / (ship:mass * gravity). // I think this gives me the current TWR. If it doesn't it gives a number that works the way I want it too, so no further questions.

if shiptwr > 2 {

    lock throttle to 1.
    lock steering to srfretrograde + R(0,(verticalspeed * 5),0).
    wait until groundspeed < 5.

} else {

    lock throttle to 1.
    lock steering to srfretrograde + R(0,(verticalspeed * 10),0).
    wait until groundspeed < 1.
}

lock throttle to 0.
lock steering to srfretrograde.
wait 5.

lock throttle to 0.4.
wait until groundspeed < 0.3.
lock throttle to 0.
lock steering to up.
wait 5.
wait until alt:radar * (gravity * 0.99) < ((alt:radar * gravity) + (0.5 * verticalspeed^2)) / shiptwr.

lock throttle to (1/(constant:e^verticalspeed)) / alt:radar. // Stole this from *SEE BELOW*
when groundspeed > 2 then { lock steering to srfretrograde. }
when alt:radar < 75 then { gear on. }
wait until ship:status = "landed".

lock throttle to 0.
set ship:control:pilotmainthrottle to 0.
unlock all.
SAS on.