
function krankenhaus_gui()
	Krankenhaus_Label = {}
	Krankenhausgui = guiCreateWindow(335, 271, 383, 188, "Krankenhaus", false)
	Krankenhaus_Label[1] = guiCreateLabel(98, 65, 5, 5, "", false, Krankenhausgui)
	guiLabelSetColor(Krankenhaus_Label[1], 255, 255, 255)
	guiLabelSetVerticalAlign(Krankenhaus_Label[1], "top")
	guiLabelSetHorizontalAlign(Krankenhaus_Label[1], "left", false)
	Krankenhaus_Label[2] = guiCreateLabel(18, 39, 274, 19, "Du bist beinahe tod und wirst gerade wiederbelebt.", false, Krankenhausgui)
	guiLabelSetColor(Krankenhaus_Label[2],255, 255, 255)
	guiLabelSetVerticalAlign(Krankenhaus_Label[2], "top")
	guiLabelSetHorizontalAlign(Krankenhaus_Label[2], "left", false)
	Krankenhaus_Label[3] = guiCreateLabel(20, 68, 245, 25, "Zeit bis du das Krankenhaus verlassen darfst:", false, Krankenhausgui)
	guiLabelSetColor(Krankenhaus_Label[3], 255, 255, 255)
	guiLabelSetVerticalAlign(Krankenhaus_Label[3], "top")
	guiLabelSetHorizontalAlign(Krankenhaus_Label[3], "left", true)
	Krankenhaus_Label[4] = guiCreateLabel(283, 69, 79, 36, "time", false, Krankenhausgui)
	guiLabelSetColor(Krankenhaus_Label[4],255, 255, 255)
	guiLabelSetVerticalAlign(Krankenhaus_Label[4], "top")
	guiLabelSetHorizontalAlign(Krankenhaus_Label[4], "left", false)
	Krankenhaus_progress = guiCreateProgressBar(22, 110, 336, 47, false, Krankenhausgui)
	guiProgressBarSetProgress(Krankenhaus_progress, 5)
	guiSetVisible(Krankenhausgui, false)
end
addEventHandler("onClientResourceStart", getRootElement(), krankenhaus_gui)

local actTImer_krankkenhaus = false
addEvent("end_kill",true)
function end_kill_func()
	aktualkrank(1, 100)
end
addEventHandler("end_kill", getRootElement(), end_kill_func)


function beDeath_func(theTime)
	guiSetVisible(Krankenhausgui, true)
	toggleAllControls(false)
	guiSetText(Krankenhaus_Label[4], tostring(theTime))
	guiProgressBarSetProgress(Krankenhaus_progress, 0)
	actTImer_krankkenhaus = setTimer(aktualkrank, 1000, 1, theTime, theTime)
end
addEvent("beDeath", true)
addEventHandler("beDeath", getLocalPlayer(), beDeath_func)


function aktualkrank(theTime,fulltime)
	stopFoodTimerForSeconds(1)
	theTime=theTime-1
	if(theTime==11)then
		triggerServerEvent("killMyDeathIcon",getLocalPlayer())
	end
	
	local timeready=((fulltime-theTime)/fulltime)*100
	guiSetText(Krankenhaus_Label[4],string.format("%s Sekunden", tostring(theTime)))
	guiProgressBarSetProgress ( Krankenhaus_progress,timeready)
	
	if not(theTime==0) then
		actTImer_krankkenhaus=setTimer(aktualkrank,1000, 1 , theTime,fulltime)
	else	
		if(isTimer(actTImer_krankkenhaus))then
			killTimer(actTImer_krankkenhaus)
		end
		toggleAllControls(true)
		guiSetVisible(Krankenhausgui,false)
		triggerServerEvent("setTodeZeitEnd",getLocalPlayer())
	end

end

addEvent("admin_EndDeath", true)
function adminEndDeath_func()
	if (isTimer(actTImer_krankkenhaus)) then
		killTimer(actTImer_krankkenhaus)
	end
    adminEndDeath_timer()
end
addEventHandler("admin_EndDeath", getRootElement(), adminEndDeath_func)

function adminEndDeath_timer()
	if (isTimer(actTImer_krankkenhaus)) then
		killTimer(actTImer_krankkenhaus)
	end
	toggleAllControls(true)
	guiSetVisible(Krankenhausgui, false)
	triggerServerEvent("setTodeZeitEnd", getLocalPlayer())
end

addEvent("syncDeathPickupToGround",true)
function syncDeathPickupToGround_func()
    if(getElementInterior(source)==0)then
        local x,y,z=getElementPosition(source)
        if(isElementInWater ( getLocalPlayer() ))then --@fixme: Abfrage liefert falsche Werte
            triggerServerEvent("setDeathBlipPos",source,x,y,0.5)
        else

            local nz = getGroundPosition ( x,y,z )
            if(nz<z)then
                triggerServerEvent("setDeathBlipPos",source,x,y,nz+0.5)
            end
        end
    end

end
addEventHandler("syncDeathPickupToGround",getRootElement(),syncDeathPickupToGround_func)








