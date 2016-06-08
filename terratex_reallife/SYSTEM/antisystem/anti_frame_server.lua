addEvent("onKickUserFrameRate",true)

function onKickUserFrameRate_func()
	outputChatBox(string.format("ANTI-LOW-FRAME: %s wurde aufgrund zuvieler Frameeinbrüche [<10 FPS] in einer Minute gekickt!", getPlayerName(source)),getRootElement(),255,0,0)
	kickPlayer(source,"Deine Framerate ist derzeit zu instabil! (Zuviele Frameeinbrüche [<10 FPS] in einer Minute)")
end
addEventHandler("onKickUserFrameRate",getRootElement(),onKickUserFrameRate_func)








