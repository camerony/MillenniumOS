; Toggle Touch Probe.g

if { global.mosFeatTouchProbe }
    M291 R"MillenniumOS: Toggle Touch Probe" P"Disable Touch Probe? This will enable guided manual workpiece probing." S3
    if { result == -1 }
        M99

; These 3 values are required for touch probe use.
if { global.mosTPID == null || global.mosTPRP == null || global.mosTPR == null || global.mosTPD == null }
    M291 R"MillenniumOS: Toggle Touch Probe" P"Touch Probe has not been configured. Please configure the touch probe using the Configuration Wizard first." S2
    M99

set global.mosFeatTouchProbe = { !global.mosFeatTouchProbe }

; Switch probe tool name and configuration when toggling touch probe
if { global.mosFeatTouchProbe }
    M4000 P{ global.mosPTID } S{ "Touch Probe" } R{ global.mosTPR }
else
    M4000 P{ global.mosPTID } S{ "Datum Tool" } R{ global.mosDTR }

echo { "Touch Probe " ^ (global.mosFeatTouchProbe ? "Enabled" : "Disabled") }