--,playHalteStellenSound

addEvent("playSignalHaltestelle", true)
function playBusStopSound()
    playSound("FILES/SOUNDS/bus/stop.wav")
end
addEventHandler("playSignalHaltestelle", getRootElement(), playBusStopSound)

addEvent("playHalteStellenSound", true)
function playHalteStellenSound_func(haltestellenname)
    --haltstellen Sonderzeichen killen
    haltestellenname = string.gsub(haltestellenname, "ä", "ae")
    haltestellenname = string.gsub(haltestellenname, "ü", "ue")
    haltestellenname = string.gsub(haltestellenname, "ö", "oe")
    playSound(string.format("https://code.responsivevoice.org/getvoice.php?tl=de&t=Die nächste Haltestelle ist: %s", haltestellenname))

end
addEventHandler("playHalteStellenSound", getRootElement(), playHalteStellenSound_func)








