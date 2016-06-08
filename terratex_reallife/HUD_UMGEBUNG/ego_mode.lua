
local ego_enabled=false
local view_ego_x=0
local view_ego_y=0
local view_ego_z=0
local view_ego_object=false

local view_ego_oldx=0
local view_ego_oldy=0
local view_ego_oldz=0
local showing=true

local oldAX=0
local oldAY=0

function enable_ego_mode()
	if(not(getElementHealth(getLocalPlayer())<1))then
		if(ego_enabled)then
			ego_enabled=false
			view_ego_x=0
			setCameraTarget(getLocalPlayer(),getLocalPlayer())
		else
			ego_enabled=true
			
		end
	end
end
addCommandHandler("ego",enable_ego_mode,false,false)



function setEgoCam()
	if(ego_enabled) and (showing) then
		local cx,cy,cz,sx,sy,sz,sov,pov=getCameraMatrix ( getLocalPlayer() )
		local bx,by,bz=getPedBonePosition(getLocalPlayer(),6)
		--sov=0
		if(isPedInVehicle(getLocalPlayer()))then
			if isElement(view_ego_object)then
				view_ego_x,view_ego_y,view_ego_z=getElementPosition(view_ego_object)
				local veh=getPedOccupiedVehicle(getLocalPlayer())
				--local vx,vy,vz=getElementPosition(getLocalPlayer())
				local vr,vry,vyz=getElementRotation(view_ego_object)
				--vry=-vry
				--[[if(vry<-180)then
					vry=180+(vry+180)
				end]]
				sov=vry
				--outputChatBox("3."..view_ego_x.." "..view_ego_y.." "..view_ego_z)
			else
				
				view_ego_x=sx
				view_ego_y=sy
				view_ego_z=sz
			end
			

		else
            if isElement(view_ego_object)then
                destroyElement(view_ego_object)
            end
			sov=0
		end
		if(view_ego_x==0)then
			view_ego_x=sx
			view_ego_y=sy
			view_ego_z=sz
		end
		--outputChatBox("rot: "..sov)
		setCameraMatrix(bx,by,bz,view_ego_x,view_ego_y,view_ego_z,sov)
		--outputChatBox("2."..view_ego_x.." "..view_ego_y.." "..view_ego_z.." "..cx.." "..cy.." "..cz)
		
    else
        if isElement(view_ego_object)then
            destroyElement(view_ego_object)
        end
    end
	
end
addEventHandler("onClientPreRender",getRootElement(),setEgoCam)
local delay=0

function set_Camera_view_Point(cursorX, cursorY, aX, aY,worldX,worldY,worldZ)

	


	showing=false
	if(isPedInVehicle(getLocalPlayer()))then
			
			local veh=getPedOccupiedVehicle(getLocalPlayer())
			local vx,vy,vz=getElementPosition(veh)
			local vrx,vry,vrz=getElementRotation(veh,"ZXY")
			--outputChatBox(tostring(vrz))
			if not(isElement(view_ego_object))then
				local sinus=math.sin(math.rad(vrz-270))
				local cosinus=math.cos(math.rad(vrz-270))
				--outputChatBox(tostring(cosinus).." "..tostring(sinus))
				view_ego_object=createObject(1336,vx+50*cosinus,vy+50*sinus,vz)				
				attachElements(view_ego_object, veh,(50*cosinus),(50*sinus),vz)
			else			
				--detachElements(view_ego_object)
			end
			
			--local oldAX=0
			--local oldAY=0
			
			local width, height = guiGetScreenSize()
			naX = (aX - width / 2)*0.147		
			
			oldAX=naX+oldAX
			
			aY = (aY - height / 2)*0.017
			vrz=vrz-oldAX
			oldAY=oldAY-aY
			local sinus=math.sin(math.rad(vrz-270))
			local cosinus=math.cos(math.rad(vrz-270))
			setElementPosition(view_ego_object,vx+50*cosinus,vy+50*sinus,vz)
			
			
			--local veh=getPedOccupiedVehicle(getLocalPlayer())
			--local vx,vy,vz=getElementPosition(veh)
			
			--local einheit=math.sqrt((worldX-vx)*(worldX-vx)+(worldY-vy)*(worldY-vy)+(worldZ-vz)*(worldZ-vz))
			--outputChatBox("Einheit: "..einheit)
			--local einheitx=10*((vx-worldX)/einheit)
			--local einheity=10*((vy-worldY)/einheit)
			--local einheitz=10*((vz-worldZ)/einheit)
			--local einheitx=10*((worldX-vx)/einheit)
			--local einheity=10*((worldY-vy)/einheit)
			--local einheitz=10*((worldZ-vz)/einheit)
			
			
			--view_ego_object=createObject(1336,(vx+einheitx),(vy+einheity),(vz+einheitz))
			setElementCollisionsEnabled ( view_ego_object, false)
			setElementAttachedOffsets ( view_ego_object, (50*cosinus),(50*sinus),oldAY)
			--attachElements(view_ego_object, veh,(5*cosinus),(5*sinus),oldAY)
			--outputChatBox(tostring(atached))
			setElementAlpha(view_ego_object,0)
			--outputChatBox("1."..worldX.." "..worldY.." "..worldZ.." "..einheitx.." "..einheity.." "..einheitz)
		else
			if isElement(view_ego_object)then
				destroyElement(view_ego_object)
			end
			view_ego_x=worldX
			view_ego_y=worldY
			view_ego_z=worldZ
			oldAY=0
			oldAX=0
		end
	--view_ego_x=worldX
	--view_ego_y=worldY
	--view_ego_z=worldZ
	showing=true
end
addEventHandler("onClientCursorMove",getRootElement(),set_Camera_view_Point)

function setEgoDisabled()

	if ego_enabled then
		ego_enabled = false
	end
end
addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), setEgoDisabled )

local wxold,wyold,wzold=0,0,0
--[[
function show_mouse_test(cx,cy,ax,ay,wx,wy,wz)
	local px,py,pz=getElementPosition(getLocalPlayer())
	local a=math.sqrt((wxold-px)*(wxold-px)+(wyold-py)*(wyold-py))
	local b=math.sqrt((wx-px)*(wx-px)+(wy-py)+(wy-py))
	local c=math.sqrt((wx-wxold)*(wx-wxold)+(wy-wyold)*(wy-wyold))
	local winkel=math.acos((c*c-a*a-b*b)/(-2*a*b))
	outputChatBox(a.." "..b.." "..winkel.." "..ax.." "..ay)

end
addEventHandler("onClientCursorMove",getRootElement(),show_mouse_test)
]]











