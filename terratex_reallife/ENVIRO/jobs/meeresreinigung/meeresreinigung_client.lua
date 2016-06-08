
addEvent("startMeeresBoot",true)
meeresMarker=false
meeresBlip=false
meeresClean=0
meeresCleanLastTen=0
isMeeresJobActiv=false
meeresX=0
meeresY=0
meeresZ=0

function startMeeresBoot_func()
	meeresMarker=createMarker(2499.8017578125,-2268.44140625,-0.16085433959961)
	addEventHandler("onClientMarkerHit",meeresMarker,hitMeeresmarker)
	meeresBlip=createBlip(2499.8017578125,-2268.44140625,-0.16085433959961)	
	meeresX,meeresY,meeresZ=getElementPosition(getLocalPlayer())
	meeresClean=0
	meeresCleanLastTen=0
	outputChatBox("Fahr aufs Meer um es zu reinigen! Wenn du denkst du hast genug Dreck gesammelt, bring es zum Marker")
	isMeeresJobActiv=true
end
addEventHandler("startMeeresBoot",getRootElement(),startMeeresBoot_func)

function hitMeeresmarker(thePlayer)
	if(thePlayer==getLocalPlayer())then
		triggerServerEvent("payForCleanMeer",getLocalPlayer(),meeresClean)
		meeresClean=0
		meeresCleanLastTen=0
	end
end

addEvent("stopboot_event",true)
function stopboot_func()
	
		if(isElement(meeresBlip))then	destroyElement(meeresBlip)      end
		if(isElement(meeresMarker))then   destroyElement(meeresMarker)  end
		isMeeresJobActiv=false
end
addEventHandler("stopboot_event",getRootElement(),stopboot_func)

function PlayerDied_meer()
	if(getLocalPlayer()==source)then
		meeresClean=0
		if(isElement(meeresBlip))then	destroyElement(meeresBlip)      end
		if(isElement(meeresMarker))then   destroyElement(meeresMarker)  end
		isMeeresJobActiv=false
	end
end
addEventHandler("onClientPlayerWasted",getRootElement(),PlayerDied_meer)

function startTimer_Meer()
	setTimer(startTimer_Meer,1000,1)
	if(isMeeresJobActiv and not(tonumber(getElementData(getLocalPlayer(),"afk_status"))==1))then
        if(isPedInVehicle(getLocalPlayer()))then
            if(getElementModel(getPedOccupiedVehicle(getLocalPlayer()))==453)then
                meeresXNew,meeresYNew,meeresZNew=getElementPosition(getLocalPlayer())
                dis=getDistanceBetweenPoints3D(meeresXNew,meeresYNew,meeresZNew,meeresX,meeresY,meeresZ)
                meeresClean=meeresClean+(dis/2)
                meeresX,meeresY,meeresZ=meeresXNew,meeresYNew,meeresZNew
            end
        end
	end
end

function startResourceBoot()
	startTimer_Meer()
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),startResourceBoot)

addEventHandler("onClientRender", root,
    function()
		if(isMeeresJobActiv)then
			local screenW, screenH = guiGetScreenSize()    
			dxDrawRectangle(screenW - 220 - 10, (screenH - 46) / 2, 220, 46, tocolor(0, 13, 71, 220), false)
			dxDrawText(string.format("%s Meter", math.Tausend(math.round(meeresClean,2))), screenW - 221 - 10, (screenH - 46) / 2, (screenW - 221 - 10) + 221, ( (screenH - 46) / 2) + 46, tocolor(255, 255, 255, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
		end
	end
)










