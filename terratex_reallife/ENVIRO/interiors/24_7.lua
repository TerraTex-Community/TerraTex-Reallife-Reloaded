


--{markele,mx,my,mz,portx,porty,portz}
shop247marker={
{false,999.8369140625,-920.1591796875,42.328125,997.8505859375,-920.826171875,42.1796875},
{false,1352.0341796875,-1758.7646484375,13.5078125,1350.095703125,-1757.255859375,13.5078125},
{false,1833.2900390625,-1842.6884765625,13.578125,1829.7646484375,-1842.822265625,13.578125},
{false,1928.96875,-1776.318359375,13.546875,1931.55078125,-1776.041015625,13.546875},
{false,2118.0537109375,896.775390625,11.1796875,2117.78515625,899.5888671875,11.1796875},
{false,2637.0126953125,1129.67578125,11.1796875,2637.3017578125,1126.7822265625,11.183449745178},
{false,2546.4013671875,1972.6279296875,10.8203125,2546.53125,1969.1064453125,10.8203125},
{false,2452.5341796875,2065.013671875,10.8203125,2453.345703125,2061.294921875,10.8203125},
{false,2884.3408203125,2453.8310546875,11.068956375122,2887.2548828125,2452.1826171875,11.068956375122},
{false,2247.84375,2397.041015625,10.8203125,2247.462890625,2400.0712890625,11.25},
{false,2097.5810546875,2224.2666015625,11.0234375,2098.2880859375,2221.0498046875,10.8203125},
{false,1599.326171875,2222.0673828125,11.0625,1601.99609375,2219.8076171875,11.0625},
{false,-2231.7626953125,-2557.892578125,31.921875,-2234.234375,-2555.009765625,31.92187},
{false,661.3515625,-573.2998046875,16.3359375,657.9296875,-573.5263671875,16.3359375},
{false,2318.4404296875,-88.8095703125,26.484375,2318.68359375,-91.609375,26.484375},
{false,-181.0771484375,1035.16796875,19.7421875,-183.787109375,1035.4609375,19.7421875},
{false,-1320.3251953125,2697.87109375,50.26628112793,-1318.6953125,2695.2353515625,50.0625},
{false,639.1005859375,1684.083984375,7.1875,637.166015625,1687.546875,6.9921875},
{false,-2492.052734375,2363.0693359375,10.2767162323,-2489.3251953125,2363.55078125,10.271138191223},
{false,-1675.908203125,432.3076171875,7.179687,-1671.9150390625,429.8876953125,7.1796875},
{false,-2420.1533203125,969.5029296875,45.296875,-2418.236328125,968.2109375,45.296875},
{false,1315.51171875,-897.6806640625,39.578125,1315.052734375,-900.818359375,39.578125},
{false,1635.2368164063, 68.942741394043, 37.120658874512,1630.3771972656,66.57781677246,36.980122973633},
}

	
shop247innenport={-31.224609375,-88.9921875,1004.46875}
function on247Create()
	local mark=createMarker(-31.05859375,-92.0107421875,1003.546875,"corona",2.0)
	setElementInterior(mark,18)--ID 98
	addEventHandler("onMarkerHit",mark,portPlayerOutof247)
	
	for i=1,20,1 do
		local marker= createMarker(-31.05859375,-92.0107421875,1003.546875,"corona",1)
		setElementInterior(marker,18)
		setElementDimension(marker,i)
	end
	
	for theKey,theTable in ipairs(shop247marker)do
		theTable[1]=createMarker(theTable[2],theTable[3],theTable[4],"corona",2.0)
	end	
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),on247Create)

function onPlayerJOin_shopblip()
	setTimer(loadEinkaufBlips,10000,1,source)
end
addEventHandler("onPlayerJoin",getRootElement(),onPlayerJOin_shopblip)

function loadEinkaufBlips(source)
	if(isElement(source))then
		for theKey,theTable in ipairs(shop247marker)do
			local x,y,z=getElementPosition(theTable[1])
			triggerClientEvent(source,"createCustomBlip_event",source,x,y, 16,16, "FILES/IMAGES/blips/kauf.png", 255 )
		end
	end
end

function portPlayerIn247(thePlayer)

	if(isElement(thePlayer))then
		if(getElementType(thePlayer)=="player")then
			if not(isPedInVehicle(thePlayer))then
				for theKey,theTable in ipairs(shop247marker)do
					if(theTable[1]==source)then
						setElementPosition(thePlayer,shop247innenport[1],shop247innenport[2],shop247innenport[3])
						setElementDimension(thePlayer,theKey)
						setElementInterior(thePlayer,18)
						vioSetElementData(thePlayer,"in247bell",theKey)
					end
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",getRootElement(),portPlayerIn247)

function portPlayerOutof247(thePlayer)
	local infastfood=vioGetElementData(thePlayer,"in247bell")
	setElementPosition(thePlayer,shop247marker[infastfood][5],shop247marker[infastfood][6],shop247marker[infastfood][7])
	setElementInterior(thePlayer,0)
	setElementDimension(thePlayer,0)
	triggerClientEvent(thePlayer,"closeShopGUIS",thePlayer)
end








