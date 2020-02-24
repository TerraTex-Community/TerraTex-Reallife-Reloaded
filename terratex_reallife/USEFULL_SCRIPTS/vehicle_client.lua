addEvent("ejectFromVehicle",true)
function ejectFromVehicle_func()
    if(isPedInVehicle(getLocalPlayer()))then
        setPedControlState (getLocalPlayer(), "enter_exit", true )
    end
end
addEventHandler("ejectFromVehicle",getRootElement(),ejectFromVehicle_func)
