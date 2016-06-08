
-- Created: 26/05/2012 12:12
addEventHandler("onClientResourceStart",resourceRoot,
    function()
        GPS_Window = {}
        GPS_Button = {}
        GPS_Label = {}
        GPS_Image = {}

        GPS_Window[1] = guiCreateWindow(576,280,681,543,"GPS-Travel Tapp",false)
        GPS_Image[1] = guiCreateStaticImage(13,27,500,500,"FILES/IMAGES/radar.jpg",false,GPS_Window[1])
        GPS_Button[1] = guiCreateButton(529,149,136,28,"Navigation beenden!",false,GPS_Window[1])
        GPS_Label[1] = guiCreateLabel(528,36,140,100,"Um eine GPS-Navigation zu starten, einfach einen Punkt auf der Karte anklicken!",false,GPS_Window[1])
        guiLabelSetHorizontalAlign(GPS_Label[1],"left",true)
        GPS_Button[2] = guiCreateButton(529,184,136,28,"Tapp schließen!",false,GPS_Window[1])
        GPS_Image[2] = guiCreateStaticImage(532,258,16,16,"FILES/IMAGES/ziel.png",false,GPS_Window[1])
        GPS_Label[2] = guiCreateLabel(563,258,104,26,"gesetzter Zielpunkt",false,GPS_Window[1])
		guiSetVisible(GPS_Window[1],false)
		
		addEventHandler ( "onClientGUIClick", GPS_Button[2], closeGPSTapp,false)	
		addEventHandler ( "onClientGUIClick", GPS_Button[1], endNavigation,false)	
		addEventHandler ( "onClientGUIClick", GPS_Image[1], startGPS,false)		
    end
)
local lastGPSZiel=false
local lastGPSBlip=false
local lastGPSZielCoord={false,false,false}
local lastGPSMarker=false

function showGPSDisplay()
	guiSetVisible(GPS_Window[1],true)
end

function closeGPSTapp()
	guiSetVisible(GPS_Window[1],false)
end

local function getAreaID(x, y)
	--outputChatBox(x.." "..y)
	return math.floor((y + 3000)/750)*8 + math.floor((x + 3000)/750)
end

function findNodeClosestToPoint_client(db, x, y, z)
	local areaID = getAreaID(x, y)
	local minDist, minNode
	local nodeX, nodeY, dist
	for id,node in pairs(db[areaID]) do
		nodeX, nodeY = node.x, node.y
		dist = (x - nodeX)*(x - nodeX) + (y - nodeY)*(y - nodeY)
		if not minDist or dist < minDist then
			minDist = dist
			minNode = node
		end
	end
	return minNode.x,minNode.y,minNode.z
end

local lastTimer=false
function startGPS(button, state, absoluteX, absoluteY)
	
	if(button=="left")then
	
		local absx,absy=guiGetPosition(GPS_Image[1],false)
		local absxb,absyb=guiGetPosition(GPS_Window[1],false)
		
		absoluteX=absoluteX-(absxb+absx)
		absoluteY=absoluteY-(absyb+absy)
		--outputChatBox((absxb+absx).." "..(absyb+absy))
		if isElement(lastGPSZiel)then
			destroyElement(lastGPSZiel)
		end
		if isElement(lastGPSBlip)then
			destroyElement(lastGPSBlip)
		end
		if isElement(lastGPSMarker)then
			destroyElement(lastGPSMarker)
		end
		local x=absoluteX/500*6000-3000
		local y=absoluteY/500*6000-3000	
		local copyx,copyy=x,-y
		x,y,z=findNodeClosestToPoint_client(vehicleNodes_client, x,y,0)
		y=-y	
		lastGPSZiel=guiCreateStaticImage((absoluteX-8+absx),(absoluteY-8+absy),16,16,"FILES/IMAGES/ziel.png",false,GPS_Window[1])
		lastGPSBlip=createBlip ( copyx, copyy, z, 41, 2, 255, 0, 0, 255, 0, 99999.0, getRootElement())
		lastGPSMarker=createMarker ( copyx, copyy, z,"checkpoint")
		addEventHandler("onClientMarkerHit",lastGPSMarker,endNavigation_marker)
		lastGPSZielCoord={x,y,z}
		if(isTimer(lastTimer))then
			killTimer(lastTimer)
		end
		--outputChatBox("Die Markierung wird auf der Karte angezeigt. Eine Navigation selbst ist aufgrund von erheblichen Fehlern derzeit nicht möglich!",255,0,0)
		gpsTimer()
	end
end
local hadRoute=false
local routeMarkers={}

function gpsTimer()
	lastTimer=setTimer(gpsTimer,10000,1)
	clientSetGPSRoute()
end

function clientSetGPSRoute()
	--outputChatBox(tostring(lastGPSZielCoord[1]).." "..tostring(lastGPSZielCoord[2]).." "..tostring(lastGPSZielCoord[3]))
	
	if(lastGPSZielCoord[1])then
		--outputChatBox("lol")
		--local px,py,pz = getElementPosition(getLocalPlayer())
		--local nearestx,nearesty,nearestz=findNodeClosestToPoint_client(vehicleNodes_client, px,py,pz)
		
		executeCommandHandler ( "path2",lastGPSZielCoord[1].." "..lastGPSZielCoord[2].." "..lastGPSZielCoord[3])
		--littletest("path2", lastGPSZielCoord[1],lastGPSZielCoord[2] , lastGPSZielCoord[3])
	--	outputChatBox(tostring(server.calculatePathByCoords(px, py, pz, lastGPSZielCoord[1],lastGPSZielCoord[2] , lastGPSZielCoord[3])))
	--[[
		local path = server.calculatePathByCoords(nearestx,nearesty,nearestz, lastGPSZielCoord[1],lastGPSZielCoord[2] , lastGPSZielCoord[3])
		if not path then
			outputChatBox('Error')
			
		else
			--server.spawnPlayer(getLocalPlayer(), path[1].x, path[1].y, path[1].z)
			--fadeCamera(true)
			--setCameraTarget(getLocalPlayer())		
			removeLinePoints ( )
			table.each(routeMarkers, destroyElement)		
			routeMarkers={}
			for i,node in ipairs(path) do
				marker=createMarker(node.x, node.y, node.z, 'corona', 5, 50, 0, 255, 200)
				table.insert(routeMarkers,marker)
				addLinePoint ( node.x, node.y )
			end
		end
		hadRoute=true]]
	else		
		--outputChatBox("lol2")
		--[[
		if(hadRoute)then
		--outputChatBox("lol3")
			hadRoute=false		]]	
			removeLinePoints ( )
			table.each(GPSMarker, destroyElement)
			if(isTimer(lastTimer))then
				killTimer(lastTimer)
			end
	end
	--setTimer(clientSetGPSRoute,12000,1)
end
--addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),clientSetGPSRoute)

function endNavigation()
	outputChatBox("Die Navigation wurde beendet")
	if isElement(lastGPSZiel)then
		destroyElement(lastGPSZiel)
	end
	if isElement(lastGPSBlip)then
		destroyElement(lastGPSBlip)
	end
	if isElement(lastGPSMarker)then
		destroyElement(lastGPSMarker)
	end
	lastGPSZiel=false
	lastGPSBlip=false
	lastGPSZielCoord={false,false,false}
	lastGPSMarker=false
	removeLinePoints ( )
	table.each(GPSMarker, destroyElement)
	if(isTimer(lastTimer))then
		killTimer(lastTimer)
	end
	lastTimer=false
	
end

function endNavigation_marker(hitElement)
	if(hitElement==getLocalPlayer())then
		endNavigation()
	end
end












