addEvent("spawnHufeisen",true)
local hufeisen={}
local hufeisenOnMap=40
colshapedata={}
pickuocolshapedata={}




function spawnHufeisen_func()
	for theKey,theHufeisen in ipairs(hufeisen)do
		if(isElement(theHufeisen))then
			destroyElement(theHufeisen)
		end
	end
	for theKey,thecolshape in pairs(colshapedata)do
		if(isElement(theKey))then
			destroyElement(theKey)
		end		
	end
	hufeisen={}
	pickuocolshapedata={}
	local pickup=false
	if(isPlayerLoggedIn(getLocalPlayer()))then
		if(tonumber(getElementData(getLocalPlayer(),"premium"))>0)then
			hufeisenOnMap=math.round(hufeisenOnMap*1.25)
		end
			for n=0,hufeisenOnMap,1 do
				local x=math.random(0,5600)-2800
				local y=math.random(0,5600)-2800
				local z=0
				
				hit,nx,ny,z=processLineOfSight ( x,y,700, x,y,-10)
											   
				
				if(hit)then
					pickup=createPickup(x,y,z,3,954)
				else
					pickup=createPickup(x,y,0,3,954)
					--outputDebugString("nö")
				end
				local colshaper=createColCircle ( x,y, 70 )
				colshapedata[colshaper]=pickup
				addEventHandler("onClientColShapeHit",colshaper,setpickuphigher_hufeisen)
				table.insert(hufeisen,pickup)
				pickuocolshapedata[pickup]=colshape
				addEventHandler("onClientPickupHit",pickup,findHufeisen)
				--outputDebugString(tostring(n))
			end
	else
		setTimer(spawnHufeisen_func,5000,1)
	end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),spawnHufeisen_func)

function setpickuphigher_hufeisen()
	--outputChatBox("hit")
	local pickup=colshapedata[source]
	if(isElement(pickup))then
		local x,y,z=getElementPosition(pickup)
		local mx,my,mz=getElementPosition(getLocalPlayer())
		hit,nx,ny,z=processLineOfSight ( x,y,700, x,y,-10, true,  false, false)
		if(hit)then
				setElementPosition(pickup,x,y,z+1)
		else
				setElementPosition(pickup,x,y,0)
				--outputChatBox("nö")
		end
			if(isElementWithinColShape ( getLocalPlayer(), source ))then
				colsahpe=true
				syncHufeisen(source)
	--			outputChatBox("wasCheckedisany yes")
			end
	end
--[[	if(tonumber(getElementData(getLocalPlayer(),"Hufeisenhelfer"))>0)then
		playSound("FILES/SOUNDS/Windows_Battery_Critical.wav")
		setTimer(isInHufCol,500,1,pickup)
		setTimer(isInHufCol,750,1,pickup)
	end]]
	--destroyElement(source)
end

local muteHufeisen=false
function muteHufeisen_func()
	muteHufeisen=not(muteHufeisen)
	if(muteHufeisen)then
		outputChatBox("Hufeisenton ausgeschaltet")
	else
		outputChatBox("Hufeisenton angeschaltet")
	end

end
addCommandHandler("mutehufeisen",muteHufeisen_func,false,false)

function startCheckHufeisenTimer()
	if(getElementData(getLocalPlayer(),"Hufeisenhelfer"))then
		if((tonumber(getElementData(getLocalPlayer(),"Hufeisenhelfer"))>0))then
			if(isInAnyHufeisenCol())then
				if(not(muteHufeisen))then
					playSound("FILES/SOUNDS/Windows_Battery_Critical.wav")
				end
			end
		end
	end
	setTimer(startCheckHufeisenTimer,500,1)
	
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),startCheckHufeisenTimer)

function syncHufeisen(thecolshape)
	if(isElement(thecolshape) and isElement(colshapedata[thecolshape]))then
		local pickup=colshapedata[thecolshape]
		local x,y,z=getElementPosition(pickup)
		local mx,my,mz=getElementPosition(getLocalPlayer())
		hit,nx,ny,z=processLineOfSight ( x,y,700, x,y,-10, true,  false, false)
		if(hit)then
				setElementPosition(pickup,x,y,z+1)
				--outputChatBox("isSynced")
		else
				setElementPosition(pickup,x,y,0)
				--outputChatBox("nö")
		end
	end

end

function isInAnyHufeisenCol()

	local colsahpe=false
	for theKey,theColShape in pairs( colshapedata ) do
		--outputChatBox("wasCheckedisany")
		if(isElement(theKey) and isElement(theColShape))then
			if(isElementWithinColShape ( getLocalPlayer(), theKey ))then
				colsahpe=true
				syncHufeisen(theKey)
				--outputChatBox("wasCheckedisany yes")
			end
		end
	end


	return colsahpe
end




--[[
function isInHufCol(pickup)
	local px,py,pz=getElementPosition(pickup)
	local zx,zy,zz=getElementPosition(getLocalPlayer())
	if(getDistanceBetweenPoints2D(px,py,zx,zy)<75)then
		playSound("FILES/SOUNDS/Windows_Battery_Critical.wav")
		setTimer(isInHufCol,500,1,col)
	end
end]]




function findHufeisen(thePlayer)
    if(thePlayer==getLocalPlayer())then
        triggerServerEvent("foundHufeisen_func",getLocalPlayer())
        if(isElement(source))then
            destroyElement(source)
        end
        if(isElement(pickuocolshapedata[source]))then
            destroyElement(pickuocolshapedata[source])
        end
        if(pickuocolshapedata[source])then
        colshapedata[pickuocolshapedata[source]]=false
        end
    end
end
--[[
function testhufeisen_func()
	for theKey,theHufeisen in ipairs(hufeisen)do
		if(isElement(theHufeisen))then
			local x,y,z=getElementPosition(theHufeisen)
			createBlip(x,y,z)
		end
		outputChatBox(tostring(theKey))
	end
	outputChatBox("ende")

end
addCommandHandler("testhuf",testhufeisen_func,false,false)
]]









