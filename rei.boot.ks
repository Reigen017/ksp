// Generalized Boot Script v1.0.0

//SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.

FUNCTION NOTIFY {
	PARAMETER message.
	print "Notify: " + message.
	HUDTEXT("kOS: " + message, 5, 2, 50, YELLOW, false).
}

FUNCTION FULL_PATH {
	PARAMETER path.
	PARAMETER vol.

  set full to vol + ":/" + path.
  return full.
}

// Detect whether a file exists on the specified volume
FUNCTION HAS_FILE {
  PARAMETER path.
  PARAMETER vol.

  set has to EXISTS(FULL_PATH(path,vol)).
  return has.
}

FUNCTION DELAY {
  PARAMETER dTime. // Total delay time
  SET accTime TO 0.                       // Accumulated time

  UNTIL accTime >= dTime {
    SET start TO TIME:SECONDS.
    WAIT UNTIL (TIME:SECONDS - start) > (dTime - accTime) OR NOT HOMECONNECTION:ISCONNECTED.
    SET accTime TO accTime + TIME:SECONDS - start.
  }
}

// Get a file from KSC
FUNCTION DOWNLOAD {
  PARAMETER name.

  NOTIFY("Downloading " + name).
  IF HAS_FILE(name, 0) {
    COPYPATH(FULL_PATH(name, 0),"").
  }
}

// Put a file on KSC
FUNCTION UPLOAD {
  PARAMETER name.

  NOTIFY("Uploading " + name).
  IF HAS_FILE(name, 1) {
    COPYPATH(name, FULL_PATH(name, 0)).
  }
}

// Run a library, downloading it from KSC if necessary
FUNCTION REQUIRE {
  PARAMETER name.
  
  IF NOT HAS_FILE(name, 1) { DOWNLOAD(name). }
  movepath(name,"tmp.exec.ks").
  RUN tmp.exec.ks.
  movepath("tmp.exec.ks",name).
}

// THE ACTUAL BOOTUP PROCESS
SET updateScript TO SHIP:NAME + ".update.ks".
// If we have a connection, see if there are new instructions. If so, download
// and run them.

print "Booting".

IF HOMECONNECTION:ISCONNECTED {
  IF HAS_FILE(updateScript, 0) {
    DOWNLOAD(updateScript).
	movepath(FULL_PATH(updateScript, 0), "0:/done").
    IF HAS_FILE("update.ks", 1) {
      DELETEPATH("update.ks").
    }
    movepath(updateScript,"update.ks").
    RUN update.ks.
    DELETEPATH("update.ks").
  }
}

// If a startup.ks file exists on the disk, run that.
IF HAS_FILE("startup.ks", 1) {
  RUN startup.ks.
} ELSE {
  WAIT UNTIL HOMECONNECTION:ISCONNECTED.
  wait until warp = 0.
  WAIT 10. // Avoid thrashing the CPU (when no startup.ks, but we have a
           // persistent connection, it will continually reboot).
  REBOOT.
}