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

local flycar=false
function FlyCar()
	if(isAdminLevel(getLocalPlayer(),3))then
		if not flycar then
			setWorldSpecialPropertyEnabled ( "aircars", true)
			flycar=true
		else
			setWorldSpecialPropertyEnabled ( "aircars", false)
			flycar=false
		end
	end
end
addCommandHandler("flycar",FlyCar)

local hovercar=false
function hovercar_func()
	if(isAdminLevel(getLocalPlayer(),3))then
		if not hovercar then
			setWorldSpecialPropertyEnabled ( "hovercars", true)
			hovercar=true
		else
			setWorldSpecialPropertyEnabled ( "hovercars", false)
			hovercar=false

		end
	end
end
addCommandHandler("hovercar", hovercar_func)

local godcar=false
function godcar_func()
	if( isAdminLevel(getLocalPlayer(),3))then
		if not hovercar then
			godcar=true
		else
			godcar=false
		end
	end
end
addCommandHandler("godcar", godcar_func)


function handleVehicleGod(attacker, weapon, loss, x, y, z, tire)
    if (godcar and isPedInVehicle(getLocalPlayer()) and getPedOccupiedVehicle ( getLocalPlayer() ) == source) then
        -- A weapon was used and the vehicle model ID is that of the SWAT tank so cancel the damage.
        cancelEvent()
    end
end
addEventHandler("onClientVehicleDamage", getRootElement(), handleVehicleGod)


function onClientPlayerWeaponFireFunc(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)

    triggerServerEvent("onCustomPedFire", getLocalPlayer(), hitX, hitY, hitZ)
end
-- Add this as a handler so that the function will be triggered every time a player fires.
addEventHandler("onClientPlayerWeaponFire", getRootElement(), onClientPlayerWeaponFireFunc)
