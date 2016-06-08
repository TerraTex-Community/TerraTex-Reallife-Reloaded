


--createBlip(x,y,z,14,0.5,255,0,0,255,0,255,getRootElement())--Clucking


--{markele,mx,my,mz,portx,porty,portz}
pizzastackmarker={
{false,2104.91796875,-1806.5517578125,13.5546875,2102.580078125,-1806.73828125,13.5546875},
{false,202.3623046875,-201.953125,1.578125,203.224609375,-205.849609375,1.57812 },
{false,1367.529296875,248.302734375,19.566932678223,1363.1416015625,250.248046875,19.56693267822},
{false,2332.4228515625,75.3701171875,26.620975494385,2336.6650390625,75.4677734375,26.48086357116},
{false, -1721.1337890625,1360.0986328125,7.1853160858154,-1726.2529296875,1359.7548828125,7.1875},
{false,-1808.47265625,946.05859375,24.890625,-1806.94140625,942.796875,24.891105651855},
{false,2083.4091796875,2224.5380859375,11.0234375,2083.748046875,2220.1015625,10.8203125},
{false,2756.830078125,2476.7646484375,11.0625,2755.66796875,2473.671875,11.0625},
{false,2352.00390625,2533.404296875,10.8203125,2351.740234375,2529.2626953125,10.8203125},
{false,2638.7880859375,1850.0068359375,11.0234375,2636.060546875,1849.6796875,11.0234375} 
}
pizzastackinnenport={371.9254455,-130.6144866,1001.49218}
function onpizzastackCreate()
	local mark=createMarker(372.32858,-133.33177,1001.09218,"corona",2.0)
	setElementInterior(mark,5)
	addEventHandler("onMarkerHit",mark,portPlayerOutOfpizzastack)
	
	for theKey,theTable in ipairs(pizzastackmarker)do
		theTable[1]=createMarker(theTable[2],theTable[3],theTable[4],"corona",2.0)
		createBlip(theTable[2],theTable[3],theTable[4],29,0.5,255,0,0,255,0,255,getRootElement())
	end	
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),onpizzastackCreate)

function portPlayerInpizzastack(thePlayer)

	if(isElement(thePlayer))then
		if(getElementType(thePlayer)=="player")then
			if not(isPedInVehicle(thePlayer))then
				for theKey,theTable in ipairs(pizzastackmarker)do
					if(theTable[1]==source)then
						setElementPosition(thePlayer,pizzastackinnenport[1],pizzastackinnenport[2],pizzastackinnenport[3])
						setElementDimension(thePlayer,theKey)
						setElementInterior(thePlayer,5)
						vioSetElementData(thePlayer,"inpizzastack",theKey)
					end
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",getRootElement(),portPlayerInpizzastack)

function portPlayerOutOfpizzastack(thePlayer)
	local infastfood=vioGetElementData(thePlayer,"inpizzastack")
	if not(infastfood)then
		infastfood=1
	end
	setElementPosition(thePlayer,pizzastackmarker[infastfood][5],pizzastackmarker[infastfood][6],pizzastackmarker[infastfood][7])
	setElementInterior(thePlayer,0)
	setElementDimension(thePlayer,0)
end








