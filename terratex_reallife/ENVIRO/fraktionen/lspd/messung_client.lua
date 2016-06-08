

local nearestCar=false

addEventHandler("onClientRender",root,
    function()
			if(isPedInVehicle(getLocalPlayer()))then
				local veh=getPedOccupiedVehicle ( getLocalPlayer())
				if(veh)then
					if(getElementData(veh,"Beamtenvehicle"))then
						local px,py,pz=getElementPosition(getLocalPlayer())
						if isElement(nearestCar)then
							local nx,ny,nz=getElementPosition(nearestCar)
							if(getDistanceBetweenPoints3D(nx,ny,nz,px,py,pz)>50)then
								nearestCar=false						
							end			
						end
						textstring="Geschwindigkeitsmesstation:\nFahrzeugkennzeichen:-\ngemessenes Tempo:-"
						if isElement(nearestCar)then
							local tx,ty,tz=getElementVelocity ( nearestCar )
							local speed=180*math.sqrt(tx*tx+ty*ty+tz*tz)
							speed=math.round(speed-(speed/10),2)
							local nummernschild=getVehiclePlateText(nearestCar)
							if(nummernschild==false)then
								nummernschild="unlesbar"
							end
							textstring=string.format("Geschwindigkeitsmesstation:\nFahrzeugkennzeichen: %s\ngemessenes Tempo: %s", nummernschild, speed)
						end				
						dxDrawText(textstring,7.0,351.0,304.0,726.0,tocolor(255,0,255,255),1.0,"pricedown","left","top",false,false,false)
					end	
				end
			end
	end
)
local showBlitzerScreen=0
local wasBlitzed=false

addEvent("CheckClearLine_Blitzer",true)
function checkMyClearBlitzerLine(blitzermark,blitzerele)
	if(source==getLocalPlayer())then
		if(isPedInVehicle(getLocalPlayer()))then
			local bx,by,bz=getElementPosition(blitzerele)
			local px,py,pz=getElementPosition(getLocalPlayer())
			local veh=getPedOccupiedVehicle(getLocalPlayer())
			--[[local difx=px-bx
			local dify=py-by
			if(difx==0)then
				difx=0.01
			end
			local winkel=math.atan(dify/difx)-math.rad(90)
			outputChatBox(tostring(winkel).." "..tostring(math.sin(winkel)).." "..tostring(math.cos(winkel)))
			bx=bx+math.sin(winkel)*2
			by=by+math.cos(winkel)*2
			--createVehicle(441,bx,by,bz)]]
			if(isLineOfSightClear ( bx,by,bz,px,py,pz,true,false,false,true,false,false,false,blitzerele) and not(wasBlitzed))then
				local test=triggerServerEvent("blitzme_event",blitzermark,veh)
				wasBlitzed=true
				setTimer(resetCheckedBlitzer,2000,1)
			end
		end
	end
end
addEventHandler("CheckClearLine_Blitzer",getRootElement(),checkMyClearBlitzerLine)

function resetCheckedBlitzer()
wasBlitzed=false
end

addEvent("setBlitzerEnabled",true)
function setBlitzerEnabled_func()
	showBlitzerScreen=5
end
addEventHandler("setBlitzerEnabled",getRootElement(),setBlitzerEnabled_func)

function showBlitzerPic()
	if(showBlitzerScreen>0)then
		local x,y=guiGetScreenSize ()
		dxDrawRectangle ( 0,0, x,y, tocolor(255,0,0,150), true )
		showBlitzerScreen=showBlitzerScreen-1
	end
end
addEventHandler("onClientRender",getRootElement(),showBlitzerPic)

function getTheNeartestCar_func()
	local posX, posY, posZ = getElementPosition( getLocalPlayer() )
	local chatSphere = createColSphere( posX, posY, posZ, 70 )
	local nearbyPlayers = getElementsWithinColShape( chatSphere, "vehicle" )
	destroyElement( chatSphere )
	nearestDistance=70
	nearestCar=false
	for index, nearbyPlayer in ipairs( nearbyPlayers ) do
		cx,cy,cz=getElementPosition(nearbyPlayer)
		if(getDistanceBetweenPoints3D(posX, posY, posZ,cx,cy,cz)<nearestDistance) and nearbyPlayer~= getPedOccupiedVehicle(getLocalPlayer()) then
			nearestCar=nearbyPlayer
		end
	end
	if(nearestCar)then
		clickoncheckvehicle("left","down", 0,0,0,0,0, nearestCar)
	end
end
addCommandHandler("smc",getTheNeartestCar_func,false,false)

function clickoncheckvehicle(button,state, absoluteX, absoluteY, worldX, worldY,worldZ, clickedWorld)
	if(isElement(clickedWorld))then
		if(getElementType(clickedWorld)=="vehicle")then
				if(isPedInVehicle(getLocalPlayer()))then
					local veh=getPedOccupiedVehicle ( getLocalPlayer())
					if(getElementData(veh,"Beamtenvehicle"))then	
						nearestCar=clickedWorld
					end
				end
		end	
	end
end
addEventHandler("onClientClick",getRootElement(),clickoncheckvehicle)








