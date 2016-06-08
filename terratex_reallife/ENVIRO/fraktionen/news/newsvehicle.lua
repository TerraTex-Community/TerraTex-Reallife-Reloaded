frakselfcars[3]={}


function createNewsVans()
	local vehi=createVehicle(488,1004.450012207,1018.650024414,50.939998626709,0,0,37,"NEWS")
	table.insert(frakselfcars[3],vehi)		
	vehi= createVehicle(582,1001.5800170898,1077.9699707031,10.979999542236,0,0,91.99951171875,"NEWS")     
	table.insert(frakselfcars[3],vehi)
	vehi= createVehicle(582,981.71002197266,1072.1999511719,10.979999542230,0,0,270,"NEWS")    
	table.insert(frakselfcars[3],vehi)
	vehi= createVehicle(582,981.78997802734,1077.25,10.979999542236,0,0,270,"NEWS")     
	table.insert(frakselfcars[3],vehi)
	vehi= createVehicle(582,981.65997314453,1082.5200195313,10.979999542236,0,0,270,"NEWS")     
	table.insert(frakselfcars[3],vehi)
	vehi= createVehicle(582,1001.7899780273,1073.0400390625,10.979999542236,0,0,90,"NEWS")    
	table.insert(frakselfcars[3],vehi)
	
		
	for key, theVehicle in ipairs(frakselfcars[3]) do
		prepare(theVehicle,3)
		setVehicleColor(theVehicle,2,1,126,126)	
		vioSetElementData(theVehicle,"tank",100)		
			table.insert(frakcars,theVehicle)
		addEventHandler("onVehicleStartEnter",theVehicle,kickFromNewsVan)
	end
	
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createNewsVans)

function kickFromNewsVan(thePlayer,seat)
	if(seat==0)then
		if(vioGetElementData(thePlayer,"fraktion")~=3)then
            showError(thePlayer,"Du bist kein Newsreporter!")
			cancelEvent()
		
		end
	end
end




function isInNewsVehicle(thePlayer)
	if(isPedInVehicle ( thePlayer))then
		local re=false
		local veh=getPedOccupiedVehicle (thePlayer)
		for key, theVehicle in pairs(frakselfcars[3]) do
			if(theVehicle==veh)then
				re=true
			end
		end
		return re
	else
		return false
	end
end


function isNearNewsVehicle(thePlayer)
	local isnews=false
	for key, theVehicle in pairs(frakselfcars[3]) do
		local vx,vy,vz=getElementPosition(theVehicle)
		local px,py,pz=getElementPosition(thePlayer)
		local dis=getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz)
		if(dis<11)then
			isnews=true
		end
	end
	return isnews
end








