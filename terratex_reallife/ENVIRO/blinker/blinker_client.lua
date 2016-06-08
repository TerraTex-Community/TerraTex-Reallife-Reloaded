blinkercar_table={}
carSendBlinker=true
carSendStableStation=false

--0 = normal  -- 1=broken
function setblinked()
	--outputChatBox("function setblinked")
	for theKey,thetyper in pairs(blinkercar_table) do
		--outputChatBox(tostring(theKey).." "..thetyper)
        setVehicleBlinkerState(theKey,thetyper)
	end
	carSendStableStation=not(carSendStableStation)
	setTimer(setblinked,375,1)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),setblinked)

function setVehicleBlinkerState(theKey,thetyper)
    if(isElement(theKey))then
        --outputChatBox(tostring(theKey).." "..thetyper.." step 2")
        if(thetyper)then

            --outputChatBox(tostring(theKey).." "..thetyper.." step 3")
            setVehicleOverrideLights ( theKey, 2)
            if(carSendStableStation)then
                if(thetyper==1)then

                    --outputChatBox(tostring(theKey).." "..thetyper.." step 4")
                    setVehicleLightState ( theKey, 0, 0 )
                    setVehicleLightState ( theKey, 1, 1 )
                    setVehicleLightState ( theKey, 2, 1 )
                    setVehicleLightState ( theKey, 3, 0 )
                elseif(thetyper==2)then
                    setVehicleLightState ( theKey, 0, 1 )
                    setVehicleLightState ( theKey, 1, 0 )
                    setVehicleLightState ( theKey, 2, 0 )
                    setVehicleLightState ( theKey, 3, 1 )
                elseif(thetyper==3)then
                    setVehicleLightState ( theKey, 0, 0 )
                    setVehicleLightState ( theKey, 1, 0 )
                    setVehicleLightState ( theKey, 2, 0 )
                    setVehicleLightState ( theKey, 3, 0 )
                end
            else
                setVehicleLightState ( theKey, 0, 1 )
                setVehicleLightState ( theKey, 1, 1 )
                setVehicleLightState ( theKey, 2, 1 )
                setVehicleLightState ( theKey, 3, 1 )
            end
        else
            --setVehicleOverrideLights ( theKey, tonumber(getElementData(theKey,"lightstate")))
            setVehicleLightState ( theKey, 0, 0 )
            setVehicleLightState ( theKey, 1, 0 )
            setVehicleLightState ( theKey, 2, 0)
            setVehicleLightState ( theKey, 3, 0 )
        end

        if(getVehicleTowedByVehicle (theKey))then
            setVehicleBlinkerState(getVehicleTowedByVehicle (theKey),thetyper)
        end
    end
end



addEvent("addBlinkerCarType",true)
function addBlinkerCarType_func(typer)
	blinkercar_table[source]=typer	
end
addEventHandler("addBlinkerCarType",getRootElement(),addBlinkerCarType_func)

function resetCarSendBlinker()
	carSendBlinker=true
end

function blinker_left_cmd()
	if(isPedInVehicle(getLocalPlayer()) and carSendBlinker)then
		local veh=getPedOccupiedVehicle ( getLocalPlayer() )
		if(getVehicleOccupant ( veh,0)==getLocalPlayer())then
			if(not(blinkercar_table[veh]))then
				
				triggerServerEvent("send_blinker",veh,1)
				carSendBlinker=false
				setTimer(resetCarSendBlinker,1000,1)
				--outputChatBox(tostring(veh).." 1 sended")
			else
				triggerServerEvent("send_blinker",veh,false)
				carSendBlinker=false
				setTimer(resetCarSendBlinker,1000,1)
			end
		end		
	end
end
addCommandHandler("blinker_left",blinker_left_cmd,false,false)

function blinker_right_cmd()
	if(isPedInVehicle(getLocalPlayer())and carSendBlinker)then
		local veh=getPedOccupiedVehicle ( getLocalPlayer() )
		if(getVehicleOccupant ( veh,0)==getLocalPlayer())then
			if(not(blinkercar_table[veh]))then
				triggerServerEvent("send_blinker",veh,2)
				carSendBlinker=false
				setTimer(resetCarSendBlinker,1000,1)
			else
				triggerServerEvent("send_blinker",veh,false)
				carSendBlinker=false
				setTimer(resetCarSendBlinker,1000,1)
			end
		end
		
	end

end
addCommandHandler("blinker_right",blinker_right_cmd,false,false)

function blinker_warn_cmd()

	if(isPedInVehicle(getLocalPlayer())and carSendBlinker)then
		local veh=getPedOccupiedVehicle ( getLocalPlayer() )
		if(getVehicleOccupant ( veh,0)==getLocalPlayer())then
			if(not(blinkercar_table[veh]))then
				triggerServerEvent("send_blinker",veh,3)
				carSendBlinker=false
				setTimer(resetCarSendBlinker,1000,1)
			else
				triggerServerEvent("send_blinker",veh,false)
				carSendBlinker=false
				setTimer(resetCarSendBlinker,1000,1)
			end
		end
		
	end
end
addCommandHandler("blinker_warn",blinker_warn_cmd,false,false)










