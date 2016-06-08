    
    

	
local cf_tore={
	{1969.5999755859,1764.5999755859,14.199999809265,0,0,0,6.5,false,false},
	{1917,1968.59997558,9.1000003814697,0,0,0,-1.899999976,false,false}
}

function create_tore_cf()
	for theKey,theTable in ipairs(cf_tore)do
		cf_tore[theKey][9]=createObject(10184,theTable[1],theTable[2],theTable[3],theTable[4],theTable[5],theTable[6])
	end
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),create_tore_cf)

function open_tore_cf(thePlayer)
	if(vioGetElementData(thePlayer,"fraktion")==11)then
		local x,y,z=getElementPosition(thePlayer)
		for theKey,theTable in ipairs(cf_tore)do
			if(getDistanceBetweenPoints3D(x,y,z,theTable[1],theTable[2],theTable[3])<10)then
				if(theTable[8])then
					moveObject (cf_tore[theKey][9], 2000, theTable[1],theTable[2],theTable[3])
					cf_tore[theKey][8]=false
				else
					moveObject (cf_tore[theKey][9], 2000, theTable[1],theTable[2],theTable[7])				
					cf_tore[theKey][8]=true
				end			
			end
		end
	end
end
addCommandHandler("mv",open_tore_cf,false,false)








