






--{markele,mx,my,mz,portx,porty,portz}
clucknbellmarker={
{false,928.62109375,-1353.0205078125,13.34375,923.9013671875,-1353.0283203125,13.376795768738},
{false,2419.7607421875,-1509.009765625,2423.2880859375,-1508.552734375,23.992208480835},
{false,2397.6796875,-1899.017578125,13.546875,2399.8779296875,-1896.7978515625,13.3828125},
{false,-2154.9765625,-2460.40625,30.8515625, -2152.41015625,-2462.2431640625,30.84375},
{false,172.4765625,1177.296875,14.7578125,171.673828125,1174.796875,14.7578125},
{false,-1213.62109375,1830.3662109375,41.9296875,-1210.775390625,1833.95703125,41.9296875},
{false,-2671.662109375,258.6689453125,4.6328125,-2671.291015625,262.966796875,4.6328125},
{false,-1816.3583984375,618.484375,35.171875,-1816.1318359375,615.388671875,35.171875},
{false,2101.98828125,2228.533203125,11.0234375,2105.638671875,2229.115234375,11.0234375},
{false,2838.2958984375,2407.6357421875,11.068956375122,2839.9658203125,2404.6337890625,11.068956375122},
{false,2393.009765625,2041.8251953125,10.8203125,2393.1064453125,2044.8134765625,10.8203125},
{false,2638.3515625,1671.9736328125,11.0234375,2635.1171875,1671.728515625,11.0234375}
}
clucknbellinnenport={364.64279,-9.169377,1001.8515625}
function onclucknbellCreate()
	local mark=createMarker(364.9482,-11.38955,1000.8515625,"corona",2.0)
	setElementInterior(mark,9)
	addEventHandler("onMarkerHit",mark,portPlayerOutOfclucknbell)
	
	for theKey,theTable in ipairs(clucknbellmarker)do
		theTable[1]=createMarker(theTable[2],theTable[3],theTable[4],"corona",2.0)
		createBlip(theTable[2],theTable[3],theTable[4],14,0.5,255,0,0,255,0,255,getRootElement())
	end	
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),onclucknbellCreate)

function portPlayerInclucknbell(thePlayer)
	if(isElement(thePlayer))then
		if(getElementType(thePlayer)=="player")then
			if not(isPedInVehicle(thePlayer))then
				for theKey,theTable in ipairs(clucknbellmarker)do
					if(theTable[1]==source)then
						setElementPosition(thePlayer,clucknbellinnenport[1],clucknbellinnenport[2],clucknbellinnenport[3])
						setElementDimension(thePlayer,theKey)
						setElementInterior(thePlayer,9)
						vioSetElementData(thePlayer,"inclucknbell",theKey)
					end
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",getRootElement(),portPlayerInclucknbell)

function portPlayerOutOfclucknbell(thePlayer)
	local infastfood=vioGetElementData(thePlayer,"inclucknbell")
	setElementPosition(thePlayer,clucknbellmarker[infastfood][5],clucknbellmarker[infastfood][6],clucknbellmarker[infastfood][7])
	setElementInterior(thePlayer,0)
	setElementDimension(thePlayer,0)
end








