--createBlip(x,y,z,29,0.5,255,0,0,255,0,255,getRootElement())--Pizza
--createBlip(x,y,z,14,0.5,255,0,0,255,0,255,getRootElement())--Clucking


--{markele,mx,my,mz,portx,porty,portz}
burgershotmarker={
{false,810.8212890625,-1616.0302734375,13.546875,815.162109375,-1616.884765625,13.691217422485},
{false,1199.49609375,-918.5458984375,43.118556976318,1200.3916015625,-921.6962890625,43.098236083984},
{false,-2336.4384765625,-166.8642578125,35.5546875,-2332.41015625,-166.763671875,35.5546875},
{false,-2356.5810546875,1008.1005859375,50.8984375,-2356.5947265625,1003.0546875,50.8984375},
{false,2169.4697265625,2795.7568359375,10.8203125,2172.408203125,2796.111328125,10.8203125},
{false,1158.36328125,2071.9931640625,11.0625,1161.87109375,2072.373046875,11.0625},
{false,1872.294921875,2071.8916015625,11.0625,1875.6015625,2072.1298828125,11.0625},
{false,2366.4521484375,2071.505859375,10.8203125,2363.5126953125,2070.791015625,10.8203125},
{false,2472.8515625,2034.8681640625,11.0625,2468.58203125,2034.703125,11.0625}
}
burgershotinnenport={365.14309,-72.673080,1002.581909}
function onBurgerShotCreate()
	local mark=createMarker(363.037597,-74.99757385,1001.081909,"corona",2.0)
	setElementInterior(mark,10)
	addEventHandler("onMarkerHit",mark,portPlayerOutOfBurgershot)
	
	for theKey,theTable in ipairs(burgershotmarker)do
		theTable[1]=createMarker(theTable[2],theTable[3],theTable[4],"corona",2.0)
		createBlip(theTable[2],theTable[3],theTable[4],10,0.5,255,0,0,255,0,255,getRootElement())
	end	
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),onBurgerShotCreate)

function portPlayerInBurgershot(thePlayer)
	if(isElement(thePlayer))then
		if(getElementType(thePlayer)=="player")then
			if not(isPedInVehicle(thePlayer))then
				for theKey,theTable in ipairs(burgershotmarker)do
					if(theTable[1]==source)then
						setElementPosition(thePlayer,burgershotinnenport[1],burgershotinnenport[2],burgershotinnenport[3])
						setElementDimension(thePlayer,theKey)
						setElementInterior(thePlayer,10)
						vioSetElementData(thePlayer,"inBurgerShot",theKey)
					end
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",getRootElement(),portPlayerInBurgershot)

function portPlayerOutOfBurgershot(thePlayer)
	local infastfood=vioGetElementData(thePlayer,"inBurgerShot")
	if not(infastfood)then
		infastfood=1
	end
		setElementPosition(thePlayer,burgershotmarker[infastfood][5],burgershotmarker[infastfood][6],burgershotmarker[infastfood][7])
		setElementInterior(thePlayer,0)
		setElementDimension(thePlayer,0)
end








