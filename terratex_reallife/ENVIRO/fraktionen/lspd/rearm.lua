local rearmpickup=createPickup( 265.125,119.083984375,1004.6171875,3,1239,5000)
local rearmpickupb=createPickup( 223.501953125,186.6767578125,1003.03125,3,1239,5000)
local rearmpickupc=createPickup( 223.626953125,1861.013671875,13.14695930481,3,1239,5000)
local rearmpickupd=createPickup( 254.4853515625,77.443359375,1003.640625, 3,1239,5000)
setElementInterior(rearmpickup,10)
setElementInterior(rearmpickupb,3)
setElementInterior(rearmpickupd,6)

function pickupCoppickup(thePlayer)
	if(isBeamter(thePlayer))then
        showError(thePlayer,"Hier kannst du mit /rearm neue Waffenmunition aufnehmen!")
	end
end
addEventHandler("onPickupHit",rearmpickup,pickupCoppickup)
addEventHandler("onPickupHit",rearmpickupb,pickupCoppickup)
addEventHandler("onPickupHit",rearmpickupc,pickupCoppickup)
addEventHandler("onPickupHit",rearmpickupd,pickupCoppickup)

function rearm_func(thePlayer)
	if(isBeamter(thePlayer))then
		local x,y,z=getElementPosition(thePlayer)
		local dis=getDistanceBetweenPoints3D(x,y,z, 265.125,119.083984375,1004.6171875)
		local disb=getDistanceBetweenPoints3D(x,y,z, 223.501953125,186.6767578125,1003.03125)
		local disc=getDistanceBetweenPoints3D(x,y,z, 223.626953125,1861.013671875,13.14695930481)--254.4853515625,77.443359375,1003.640625
		local disd=getDistanceBetweenPoints3D(x,y,z,254.4853515625,77.443359375,1003.640625)
		if(dis<5)or(disb<5)or(disc<5)or(disd<5)then
			Fraktion=vioGetElementData(thePlayer,"fraktion")
			Rang=vioGetElementData(thePlayer,"fraktionsrang")
			if(vioGetElementData(thePlayer,"isCopSwat"))then
				setPlayerRearmWeapons(thePlayer,5,Rang)							
			else
				setPlayerRearmWeapons(thePlayer,Fraktion,Rang)		
			end
			triggerClientEvent(thePlayer,"addFood",thePlayer,500)
		end	
		if(isPedInVehicle ( thePlayer ))then
			if(getElementModel(getPedOccupiedVehicle ( thePlayer ))==433) and (vioGetElementData(getPedOccupiedVehicle ( thePlayer ),"Beamtenvehicle"))then
				Fraktion=vioGetElementData(thePlayer,"fraktion")
				Rang=vioGetElementData(thePlayer,"fraktionsrang")--Fraktion == 5 sek
				if(vioGetElementData(thePlayer,"isCopSwat"))then
					setPlayerRearmWeapons(thePlayer,5,Rang)							
				else
					setPlayerRearmWeapons(thePlayer,Fraktion,Rang)		
				end
				triggerClientEvent(thePlayer,"addFood",thePlayer,500)			
			end		
		end			
	end	
	if(isPedInVehicle ( thePlayer ))then
		if(getElementModel(getPedOccupiedVehicle ( thePlayer ))==433)then		
				triggerClientEvent(thePlayer,"addFood",thePlayer,500)			
		end
	end	
end
addCommandHandler("rearm",rearm_func,false,false)

function swat_func(thePlayer)
	if(isBeamter(thePlayer))then
		local x,y,z=getElementPosition(thePlayer)
		if(getDistanceBetweenPoints3D(x,y,z,254.4853515625,77.443359375,1003.640625)<10 or getDistanceBetweenPoints3D(x,y,z,246.5556640625,125.7724609375,1003.21875)<10 or getDistanceBetweenPoints3D(x,y,z,229.6025390625,167.876953125,1003.0234375)<10)then
			if(vioGetElementData(thePlayer,"isCopSwat"))then
				vioSetElementData(thePlayer,"isCopSwat",false)
				setElementModel(thePlayer,vioGetElementData(thePlayer,"FrakSkin"))	
				takeAllWeapons ( thePlayer )		
			else
				if(vioGetElementData(thePlayer,"isCopDuty"))then
					vioSetElementData(thePlayer,"isCopSwat",true)
					setElementModel(thePlayer,285)
					takeAllWeapons ( thePlayer )		
				else
					showError(thePlayer,"Du bist nicht im Dienst!")
				end
			end
		else
			showError(thePlayer,"Du bist weder beim Innendienst noch beim Dutypunkt!")
			--outputChatBox("Du bist weder beim Innendienst noch beim Dutypunkt!",thePlayer,255,0,0)
		end
	end
end
addCommandHandler("swat",swat_func,false,false)

--246.5556640625,125.7724609375,1003.21875
--229.6025390625,167.876953125,1003.0234375
function duty_cop_func(thePlayer)
	if(isBeamter(thePlayer))then
		local x,y,z=getElementPosition(thePlayer)
		if(getDistanceBetweenPoints3D(x,y,z,254.4853515625,77.443359375,1003.640625)<10 or getDistanceBetweenPoints3D(x,y,z,246.5556640625,125.7724609375,1003.21875)<10 or getDistanceBetweenPoints3D(x,y,z,229.6025390625,167.876953125,1003.0234375)<10)then
			if(vioGetElementData(thePlayer,"isCopDuty"))then
				vioSetElementData(thePlayer,"isCopDuty",false)
				vioSetElementData(thePlayer,"isCopSwat",false)				
				setElementModel(thePlayer,vioGetElementData(thePlayer,"skinid"))
				takeAllWeapons ( thePlayer )		
			else
				vioSetElementData(thePlayer,"isCopDuty",true)
				setElementModel(thePlayer,vioGetElementData(thePlayer,"FrakSkin"))
				takeAllWeapons ( thePlayer )		
			end
		else
			showError(thePlayer,"Du bist weder beim Innendienst noch beim Dutypunkt!")
		end
	end
end
addCommandHandler("duty",duty_cop_func,false,false)








