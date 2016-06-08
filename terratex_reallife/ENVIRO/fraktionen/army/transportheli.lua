function onTransportHeliEnter(thePlayer)
	if(transportHeliArmy==source)then
		if(getVehicleOccupant ( transportHeliArmy, 1)==thePlayer)then
			setElementAlpha(thePlayer,0)
			removePedFromVehicle(thePlayer)
			setElementAlpha(thePlayer,0)
			setElementCollisionsEnabled(thePlayer,false)
			local px,py,pz=getElementPosition(transportHeliArmy)
			setElementPosition(thePlayer,px,py,pz)
			setElementFrozen(thePlayer,true)
			attachElements(thePlayer,source)
			setCameraTarget ( thePlayer, transportHeliArmy)
			vioSetElementData(thePlayer,"isInTransportHeli",true)
			bindKey ( thePlayer, "enter", "down", exitTransportHeli,thePlayer)
		end
	end
end
addEventHandler("onVehicleEnter",getRootElement(),onTransportHeliEnter)


function exitTransportHeli(thePlayer)
	if(vioGetElementData(thePlayer,"isInTransportHeli"))then
		local px,py,pz=getElementPosition(thePlayer)
		local tx,ty,tz=getElementPosition(transportHeliArmy)
		local dis=getDistanceBetweenPoints3D(px,py,pz,tx,ty,tz)
		if(dis<5)then
			if not(getVehicleOccupant ( transportHeliArmy, 1))then
				
				detachElements(thePlayer)
				setElementFrozen(thePlayer,false)
				--warpPedIntoVehicle(thePlayer,transportHeliArmy,1)
				setElementAlpha(thePlayer,255)
				local vrx,vry,vrz=getElementRotation ( transportHeliArmy )
				local vrz=(360-vrz)
				local vx,vy,vz=getElementPosition(transportHeliArmy)
				local sinus=math.sin(vrz)
				local cosinus=math.cos(vrz)
				--outputChatBox(vx.." "..vy.." "..vz)
				--outputChatBox(cosinus.." "..sinus)
				setElementPosition(thePlayer,vx-4*cosinus,vy-4*sinus,vz-0.5)
				setCameraTarget ( thePlayer, thePlayer)
				
				setTimer(setRealCollishionForTransportPlayer,300,1,thePlayer)
				
	
			end
		else
			vioSetElementData(thePlayer,"isInTransportHeli",false)
		end
	end
	
end

function onStartTransportHeliExit(thePlayer)
	if(vioGetElementData(thePlayer,"isInTransportHeli"))then
		cancelEvent()
	end

end
addEventHandler("onVehicleStartEnter",getRootElement(),onStartTransportHeliExit)

function setRealCollishionForTransportPlayer(thePlayer)
	vioSetElementData(thePlayer,"isInTransportHeli",false)
	setElementCollisionsEnabled(thePlayer,true)

end








