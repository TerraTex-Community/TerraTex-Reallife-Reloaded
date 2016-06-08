
			
addEvent("defend_rocket_to",true)	
function createDefendRocket()
	createProjectile ( getLocalPlayer(), 20 , 15.44140625,1718.90625,26.109243392944, 0.25, source )
	createProjectile ( getLocalPlayer(), 20 , 237.568359375,1696.107421875,25.91944694519, 0.25, source )
	createProjectile ( getLocalPlayer(), 20 , 354.345703125,2028.5986328125,26.135400772095,0.25, source )
	createProjectile ( getLocalPlayer(), 20 , 188.1630859375,2081.0068359375,26.025737762451, 0.25, source )
	setTimer(moreRockets,1000,1,source)
	setTimer(moreRockets,2000,1,source)
	setTimer(moreRockets,3000,1,source)



end
addEventHandler("defend_rocket_to",getRootElement(),createDefendRocket)

function moreRockets(source)
	if isElement(source)then
		createProjectile ( getLocalPlayer(), 20 , 15.44140625,1718.90625,26.109243392944, 0.25, source )
		createProjectile ( getLocalPlayer(), 20 , 237.568359375,1696.107421875,25.91944694519, 0.25, source )
		createProjectile ( getLocalPlayer(), 20 , 354.345703125,2028.5986328125,26.135400772095, 0.25, source )
		createProjectile ( getLocalPlayer(), 20 , 188.1630859375,2081.0068359375,26.025737762451, 0.25, source )
	end
end

local auswurf=0
addEvent("startNevadaRockets",true)
function startBombingNevadaRockets(creator,nearbyPlayers)
	if(creator==getLocalPlayer())then
		outputChatBox("Abschuss gestartet")
	end
	local x,y,z=getElementPosition(source)
	--outputChatBox(x.." "..y.." "..z)
	local chatSphere = createColCircle( x,y,50)
	local nearbyPlayers = getElementsWithinColShape( chatSphere , "vehicle")
	--outputChatBox(tostring(nearbyPlayers).." "..table.getn(nearbyPlayers))
	if(nearbyPlayers)then
		for theKey,theVehicle in ipairs(nearbyPlayers) do
			if not(theVehicle==source)then			
				local x,y,z=getElementPosition(theVehicle)
				createProjectile ( creator, 20 , x,y,(z+20), 3.25,theVehicle)
			end
		end
	end
	destroyElement(chatSphere)
end
addEventHandler("startNevadaRockets",getRootElement(),startBombingNevadaRockets)

function setDevelopmentMode_mode()
	setDevelopmentMode(true)
end
addCommandHandler("devmode",setDevelopmentMode_mode)

function attackedAPed(attacker,  weapon,  bodypart ,  loss )
	cancelEvent()
	if(attacker==getLocalPlayer())then
		triggerServerEvent("onPedDamageCustom",source,attacker,  weapon,  bodypart ,  loss)
	end
end
addEventHandler("onClientPedDamage",getRootElement(),attackedAPed)


local namebots={}
local shootAt=false
addEvent("setPedShootingAt",true)
function setPedShootingAt_func(bot)
	table.insert(namebots,bot)
	--setPedLookAt ( bot,0,0,0 , -1, source )
	--setPedControlState ( bot, "fire", true )
	setPedControlState ( bot, "aim_weapon", true )
	shootAt=source
end
addEventHandler("setPedShootingAt",getRootElement(),setPedShootingAt_func)
addEvent("resetPedShootingAt",true)
function resetPedShootingAt_func()
	namebots={}
	shootAt=false
end
addEventHandler("resetPedShootingAt",getRootElement(),resetPedShootingAt_func)

local boneTable={1,6,7,4,31,21,33,23,2,51,41,22,5}

function setPedShooting()
	
	setTimer(setPedShooting,250,1)
	if(isElement(shootAt))then
	--getPedTarget ( ped thePed )
		local x,y,z=getElementPosition(shootAt)
		if not(namebots==nil) then
			for theKey,theBot in ipairs(namebots)do
				if(isElement(theBot))then
					--setPedControlState ( theBot, "aim_weapon", false )
					setPedControlState ( theBot, "aim_weapon", true )
					--setPedAimTarget ( theBot, x, y, z )
					
						--setPedControlState ( theBot, "fire", false )
						local x1, y1, z1 = getElementPosition ( theBot )
						local x2, y2, z2 = getPedBonePosition (shootAt, boneTable[math.random(1,table.getn(boneTable))])
						--setPedRotation ( theBot, findRotation(x1,y1,x2,y2) )
						setPedAimTarget ( theBot, x2, y2, z2 )
						local boxx,boty,botz=getPedBonePosition (theBot,6) 
						local plx,ply,plz=getPedBonePosition (shootAt,6) 
					--	if(getPedTarget ( theBot )==shootAt)then
					--outputChatBox(tostring(boxx).." "..tostring(plx))
					if(boxx and plx)then
						if(isLineOfSightClear ( boxx,boty,botz,plx,ply,plz,true,false,false,true,false,false,false))then          
							setPedControlState ( theBot, "fire", true )
						else
							setPedControlState ( theBot, "fire", false )
						end
					else
							setPedControlState ( theBot, "fire", false )
					
					end
				end
			end
		end
	end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),setPedShooting)

function findRotation(x1,y1,x2,y2)
 
	local t = -math.deg(math.atan2(x2-x1,y2-y1))
	if t < 0 then t = t + 360 end;
	return t;
end









