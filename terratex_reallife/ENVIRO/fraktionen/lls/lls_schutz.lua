--lls mafia eingang ausgang

function onMafiaInteriorMarkerCreate()
	local marker=createMarker(725.51171875,-1450.6708984375,17.6953125,"corona",1)	
	addEventHandler("onMarkerHit",marker,setPlayerInMafiaVilla)
	marker=createMarker(2324.345703125,-1148.857421875,1050.7100830078,"corona",1)
	addEventHandler("onMarkerHit",marker,setPlayerOutMafiaVilla)
	setElementInterior(marker,12)
	setElementDimension(marker,9999)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),onMafiaInteriorMarkerCreate)

local mafiaMarkersAktivated=false
function resetmafiaMarkersAktivated()
	mafiaMarkersAktivated=false
end

function setPlayerInMafiaVilla(thePlayer)
	if(not(mafiaMarkersAktivated))then
		setElementInterior(thePlayer,12)
		setElementDimension(thePlayer,9999)
		setElementPosition(thePlayer,2324.345703125,-1148.857421875,1050.710083007)
		mafiaMarkersAktivated=true
		setTimer(resetmafiaMarkersAktivated,750,1)
		
		setElementInterior(thePlayer,12)
		setElementDimension(thePlayer,9999)
	end
end

function setPlayerOutMafiaVilla(thePlayer)
	if(not(mafiaMarkersAktivated) and getElementDimension(thePlayer)==9999 )then
		setElementInterior(thePlayer,0)
		setElementDimension(thePlayer,0)
		setElementPosition(thePlayer,725.51171875,-1450.6708984375,17.6953125)
		mafiaMarkersAktivated=true
		setTimer(resetmafiaMarkersAktivated,750,1)
		setElementInterior(thePlayer,0)
		setElementDimension(thePlayer,0)
	end
end











