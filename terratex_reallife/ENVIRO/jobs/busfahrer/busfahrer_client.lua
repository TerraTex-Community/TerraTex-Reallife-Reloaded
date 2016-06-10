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
	playSound(string.format("http://www.voicerss.org/controls/speech.ashx?hl=de-de&src=Die nächste Haltestelle ist: %s&c=mp3", haltestellenname))

end
addEventHandler("playHalteStellenSound",getRootElement(),playHalteStellenSound_func)








