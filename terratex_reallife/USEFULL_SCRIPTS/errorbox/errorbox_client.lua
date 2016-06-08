
local timer=-1

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),
    function()
	
		local screenW, screenH = guiGetScreenSize()
        errorbox = guiCreateWindow((screenW - 420) / 2, 0, 420, 140, "Info / Errorbox", false)
        guiWindowSetSizable(errorbox, false)

        errortext = guiCreateLabel(30, 30, 360, 80, "", false, errorbox)
        guiLabelSetHorizontalAlign(errortext, "center", true)
        guiLabelSetVerticalAlign(errortext, "center")    
		guiSetFont(errortext,"clear-normal")
		guiLabelSetColor(errortext,255,0,0)
		guiSetVisible (errorbox, false)
	
	
    end
)

function showError(theplayer,text)
	if not(timer==-1) then
		killTimer(timer)
	end
	guiSetText ( errortext, text )
	guiSetVisible (errorbox,true)
	guiBringToFront ( errorbox )
	timer=setTimer(seterrorboxinvisible,10000,1)
	if(client_settings["InfoSounds"]==nil or client_settings["InfoSounds"]==true)then	
		playSound ("FILES/SOUNDS/Windows_Exclamation.wav", false)
	end
end
addEvent("showErrorText",true)
addEventHandler("showErrorText",getRootElement(),showError)

function seterrorboxinvisible()
	guiSetVisible (errorbox,false)
	timer=-1
end












