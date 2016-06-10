-- adminspeedhack
local speedHackStatus=false
local speedHackType=1
function switchSpeedMode(cmd,id)
	if(isAdminLevel(getLocalPlayer(),3))then
		if(speedHackStatus)then
			speedHackStatus=false
			 unbindKey ( "lctrl", "down", setNewSpeed_hack  )
			 outputChatBox("disabled")
		else
			speedHackStatus=true
			bindKey (  "lctrl", "down", setNewSpeed_hack )
			outputChatBox("enabled")
			if(tonumber(id))then
				if(tonumber(id)~=1)then
					speedHackType=id
					outputChatBox("Beschleunigung wurde auf "..speedHackType.." gesetzt!")
				end
			else
				speedHackType=1
			end
		end
	end	
end
addCommandHandler("speedhack",switchSpeedMode,false,false)

function setNewSpeed_hack()
	if(isPedInVehicle(getLocalPlayer()))then
		local veh=getPedOccupiedVehicle(getLocalPlayer())
		local vx,vy,vz=getElementVelocity(veh)
		if(speedHackType==1)then
			setElementVelocity(veh,(vx*1.025),(vy*1.025),(vz*1.025))
		else
			setElementVelocity(veh,(vx*speedHackType),(vy*speedHackType),(vz*speedHackType))
		end
		setTimer(checkPressedHackKey,75,1)	
	end
end

function checkPressedHackKey()
	if(getKeyState( "lctrl" ) == true)then
		--outputChatBox("yes")
		setNewSpeed_hack()
	end

end

function devMode()
	if(isAdminLevel(getLocalPlayer(),4))then
		if(getDevelopmentMode())then
			setDevelopmentMode ( false )
		else
			setDevelopmentMode ( true )
		end
	end
end
addCommandHandler( "devmode", devMode, false, false)














