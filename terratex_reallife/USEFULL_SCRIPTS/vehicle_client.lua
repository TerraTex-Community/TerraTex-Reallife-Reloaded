--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 09.02.14
-- Time: 01:48
-- To change this template use File | Settings | File Templates.
--



addEvent("ejectFromVehicle",true)
function ejectFromVehicle_func()
    if(isPedInVehicle(getLocalPlayer()))then
        setControlState ("enter_exit", true )
    end
end
addEventHandler("ejectFromVehicle",getRootElement(),ejectFromVehicle_func)










