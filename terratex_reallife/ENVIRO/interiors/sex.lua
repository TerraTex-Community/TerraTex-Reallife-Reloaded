


--{markele,mx,my,mz,portx,porty,portz}
shopsexmarker={
{false,1137.990234375,-1365.6513671875,13.984375,1140.099609375,-1365.708984375,13.754500389099},
{false,1087.794921875,-922.9716796875,43.390625,1088.0947265625,-925.40625,43.390625},
{false,2085.4716796875,2074.015625,11.0546875,2087.955078125,2074.2314453125,10.8203125},
{false,2408.4130859375,2015.875,10.8203125,2411.994140625,2015.728515625,10.8203125},
{false,1940.7587890625,-2116.275390625,13.6953125,1942.7587890625,-2116.275390625,13.6953125},
}

	
shopsexinnenport={-100.35546875,-22.3095703125,1000.71875}
function onsexCreate()
	local mark=createMarker(-100.3408203125,-25.0380859375,1000.71875,"corona",2.0)
	setElementInterior(mark,3)--ID 98
	addEventHandler("onMarkerHit",mark,portPlayerOutofsex)
	
	for i=1,20,1 do
		local marker= createMarker(-100.3408203125,-25.0380859375,1000.71875,"corona",1)
		setElementInterior(marker,3)
		setElementDimension(marker,i)
	end
	
	for theKey,theTable in ipairs(shopsexmarker)do
		shopsexmarker[theKey][1]=createMarker(theTable[2],theTable[3],theTable[4],"corona",2.0)
	end	
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),onsexCreate)

-- function onPlayerJOin_shopblip()
	-- setTimer(loadEinkaufBlips,10000,1,source)
-- end
-- addEventHandler("onPlayerJoin",getRootElement(),onPlayerJOin_shopblip)

-- function loadEinkaufBlips(source)
	-- if(isElement(source))then
		-- for theKey,theTable in ipairs(shopsexmarker)do
			-- local x,y,z=getElementPosition(theTable[1])
			-- triggerClientEvent(source,"createCustomBlip_event",source,x,y, 16,16, "images/blips/kauf.png", 255 )
		-- end
	-- end
-- end

function portPlayerInsex(thePlayer)

	if(isElement(thePlayer))then
		if(getElementType(thePlayer)=="player")then
			if not(isPedInVehicle(thePlayer))then
				for theKey,theTable in ipairs(shopsexmarker)do
					if(theTable[1]==source)then
						setElementPosition(thePlayer,shopsexinnenport[1],shopsexinnenport[2],shopsexinnenport[3])
						setElementDimension(thePlayer,theKey)
						setElementInterior(thePlayer,3)
						vioSetElementData(thePlayer,"insexbell",theKey)
					end
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",getRootElement(),portPlayerInsex)

function portPlayerOutofsex(thePlayer)
	local infastfood=vioGetElementData(thePlayer,"insexbell")
	setElementPosition(thePlayer,shopsexmarker[infastfood][5],shopsexmarker[infastfood][6],shopsexmarker[infastfood][7])
	setElementInterior(thePlayer,0)
	setElementDimension(thePlayer,0)
	triggerClientEvent(thePlayer,"closeShopGUIS",thePlayer)
end








