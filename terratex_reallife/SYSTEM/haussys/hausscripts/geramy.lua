local fahrstuhl=createObject(2633,1644.7,-1631.2,25.6,0,0,226)

createObject(974,1642.4,-1627.9,79.3,90,0,45)
createObject(3084,1730.9,-1594.1,4054.9,0,0,270)
createObject(3084,1730.9,-1594.1,4051.9,0,0,270)
createObject(7245,1757.2,-1597,4050)


local state_geramy=false

local movetime=20000

function moveFahrstuhl_geramy()
	if(state_geramy==false)then
		moveObject(fahrstuhl,movetime,1644.7,-1631.2,77.7)
		state_geramy=true
	else		
		moveObject(fahrstuhl,movetime,1644.7,-1631.2,25.6)
		state_geramy=false
	end
	setTimer(moveFahrstuhl_geramy,(movetime+5000),1)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),moveFahrstuhl_geramy)
local markerSchrankeA=false
local hasSchrankeGeramy=false
local markerSchrankeB=false

local hasPortedGeramy=false
function createGeramyGarage()
	local marker=createMarker(1741.2,-1595.1,4048.7, "cylinder", 3)
	addEventHandler("onMarkerHit",marker,setGeramyOutOfHisGerage)
	local marker=createMarker(1656.7,-1693.1,15.1, "cylinder", 3)
	addEventHandler("onMarkerHit",marker,setGeramyInOfHisGerage)
	
	markerSchrankeA=createMarker(1628.1103515625,-1672.2724609375,12.8, "cylinder", 2)	
	addEventHandler("onMarkerHit",markerSchrankeA,openSchranke_geramy)
	markerSchrankeB=createMarker(1628.3935546875,-1682.34375,12.8, "cylinder", 2)	
	addEventHandler("onMarkerHit",markerSchrankeB,openSchranke_geramy)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createGeramyGarage)

function setGeramyInOfHisGerage(thePlayer)
	if(getElementType(thePlayer)=="player")then
		if(vioGetElementData(thePlayer,"hkey")==1 or vioGetElementData(thePlayer,"hkey")==-1 or isBeamter(thePlayer))then
			if not(hasPortedGeramy)then
				if(isPedInVehicle(thePlayer))then
					thePlayer=getPedOccupiedVehicle(thePlayer)
				end
				setElementFrozen(thePlayer,true)
				setElementPosition(thePlayer,1741.2,-1595.1,4048.7)
				setElementRotation(thePlayer,345,0,270)
				setTimer(setElementFrozen,2000,1,thePlayer,false)			
				hasPortedGeramy=true
				setTimer(resetGeramyPortState,5000,1)
				outputChatBox("Du hast Geramys Garage betreten!",thePlayer,0,255,0)				
			end		
		else
			outputChatBox("Du bist nicht berechtigt diesen Teil der Garage zu betreten!",thePlayer,0,255,0)
		end		
	end
end
function setGeramyOutOfHisGerage(thePlayer)
	if(getElementType(thePlayer)=="player")then
			if not(hasPortedGeramy)then
				if(isPedInVehicle(thePlayer))then
					thePlayer=getPedOccupiedVehicle(thePlayer)
				end
				setElementFrozen(thePlayer,true)
				setElementPosition(thePlayer,1655.8,-1698.2,15.5)
				setElementRotation(thePlayer,0,0,176)
				setTimer(setElementFrozen,2000,1,thePlayer,false)			
				hasPortedGeramy=true
				setTimer(resetGeramyPortState,5000,1)				
			end		
	end
end

function resetGeramyPortState()
	hasPortedGeramy=false
end



local schranke= createObject(968,1631.8,-1677.8,13.01,0,270,0)
createObject(966,1631.8,-1677.8,12.4,0,0,0)
createObject(970,1631.9,-1714.6,13,0,0,0)
createObject(970,1626.7,-1714.6,13,0,0,0)

function openSchranke_geramy(thePlayer)
	if(getElementType(thePlayer)=="player")then
		if not(hasSchrankeGeramy)then
			if(isPedInVehicle(thePlayer))then
				if(vioGetElementData(thePlayer,"hkey")==1 or vioGetElementData(thePlayer,"hkey")==-1 or isBeamter(thePlayer))then
					moveObject(	schranke,1000,1631.8,-1677.8,13.01,0,90,0)					
					hasSchrankeGeramy=true
					setTimer(resetGeramySchrankeState,5000,1)						
				else
					outputChatBox("Du bist nicht berechtigt diesen Teil der Garage zu betreten!",thePlayer,0,255,0)
				end					
				
			end
		end		
	end
end

function resetGeramySchrankeState()
	moveObject(	schranke,1000,1631.8,-1677.8,13.01,0,-90,0)	
	setTimer(resetSchrankeStateVar,1000,1)
end

function resetSchrankeStateVar()
	hasSchrankeGeramy=false
end








