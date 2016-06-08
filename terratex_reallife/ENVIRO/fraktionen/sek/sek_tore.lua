
fbi_tore={}
fbi_tore[1]=createObject(3055,1405.599609375,-1648.7998046875,14.5,0,0,90)
fbi_tore[2]=createObject(2930,245.55000305176,72.610000610352,1005.0300292969,0,0,90)
setElementInterior(fbi_tore[2],6)
fbi_torstatus={false,false} 


 function open_fbi_tor_A(thePlayer)
	vioGetElementData(thePlayer, "fraktion")
     if(isBeamter(thePlayer))then
		local px,py,pz=getElementPosition(thePlayer)
		if(getDistanceBetweenPoints3D ( px,py,pz,1405.599609375,-1648.7998046875,14.5) < 10)then
			if not(fbi_torstatus[1])then
				moveObject(fbi_tore[1],2000,1405.599609375,-1648.7998046875,8.5)
				fbi_torstatus[1]=true
			else
				moveObject(fbi_tore[1],2000,1405.599609375,-1648.7998046875,14.5)
				fbi_torstatus[1]=false
			end
		
		elseif(getDistanceBetweenPoints3D ( px,py,pz,245.55000305176,72.610000610352,1005.0300292969) < 10)then
			if not(fbi_torstatus[2])then
				moveObject(fbi_tore[2],2000,243.825000305176,72.610000610352,1005.0300292969)
				fbi_torstatus[2]=true
			else
				moveObject(fbi_tore[2],2000,245.55000305176,72.610000610352,1005.0300292969)
				fbi_torstatus[2]=false
			end
		end
	end
 end
 addCommandHandler("mv",open_fbi_tor_A)
 

 local SEKMARKER={
	{1379.7800292969,-1634.7700195313,13.050000190735,246.36999511719,87.660003662109,1003.6400146484,0},
	{246.36999511719,87.660003662109,1003.1400146484,1379.7800292969,-1634.7700195313,13.550000190735,6},
	
	{1392.9499511719,-1607.4200439453,37.810001373291,258.36999511719,90.76000213623,1002.450012207,0},
	{258.36999511719,90.76000213623,1001.950012207,1392.9499511719,-1607.4200439453,38.310001373291,6},
	
	{1419.5200195313,-1623.8100585938,13.050000190735,246.78999328613,62.639999389648,1003.6400146484,0},
	{246.78999328613,62.639999389648,1003.1400146484,1419.5200195313,-1623.8100585938,13.550000190735,6}
 }
 
    
function onResourceCreateMarkers_SEK()

	for theKey,theMarker in ipairs(SEKMARKER)do
		local marker=createMarker(theMarker[1],theMarker[2],theMarker[3],"cylinder",2)
		setElementInterior(marker,theMarker[7])
		local int=0
		if(theMarker[7]==0)then
			int=6
		else
			int=0
		end
		-- outputDebugString(int)
		vioSetElementData(marker,"porttable",{theMarker[4],theMarker[5],theMarker[6],int})
		addEventHandler("onMarkerHit",marker,portPlayerSEK)
	end

end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),onResourceCreateMarkers_SEK)
local noSEKPort=false
function portPlayerSEK(thePlayer)
	if(getElementType(thePlayer)=="player")then
        if(not(isPedInVehicle(thePlayer)))then
            if not noSEKPort then
                noSEKPort=true
                local portTable=vioGetElementData(source,"porttable")
                -- outputDebugString(portTable[4])
                setElementInterior(thePlayer,portTable[4],portTable[1],portTable[2],portTable[3])
                setElementPosition(thePlayer,portTable[1],portTable[2],portTable[3])

                setTimer(noSEKPort_reset,750,1)

            end
        end
	end
end
function noSEKPort_reset()
	noSEKPort=false
end
























