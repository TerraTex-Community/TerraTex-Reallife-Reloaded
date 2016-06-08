--,playHalteStellenSound

addEvent("playSignalHaltestelle",true)
function playBusStopSound()
	playSound("FILES/SOUNDS/bus/stop.wav")
end
addEventHandler("playSignalHaltestelle",getRootElement(),playBusStopSound)

addEvent("playHalteStellenSound",true)
function playHalteStellenSound_func(haltestellenname)
    --haltstellen Sonderzeichen killen
    haltestellenname=string.gsub(haltestellenname, "ä", "ae")
    haltestellenname=string.gsub(haltestellenname, "ü", "ue")
    haltestellenname=string.gsub(haltestellenname, "ö", "oe")
	playSound(string.format("http://translate.google.com/translate_tts?tl=de&q=Die naeschste Haltestelle ist: %s", haltestellenname))
end
addEventHandler("playHalteStellenSound",getRootElement(),playHalteStellenSound_func)








