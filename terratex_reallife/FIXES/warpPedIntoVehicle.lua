--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 09.02.14
-- Time: 01:17
-- To change this template use File | Settings | File Templates.
--

_warpPedIntoVehicle=warpPedIntoVehicle
function warpPedIntoVehicle(thePlayer,theVehicle,theSeat)
    --outputDebugString("startet Warp Ped")

    local cc=0
    if(not(theSeat))then
        theSeat=0
    end
    if(isElement(theVehicle) and isElement(thePlayer))then
        if(not(isPedDead(thePlayer)))then
            while(not(isPedInVehicle(thePlayer))) do
                --outputDebugString(tostring(cc))
                cc=cc+1
                if cc==10 then
                    --	outputDebugString("stoped Warp Ped")
                    break
                end
                if not theSeat then
                    _warpPedIntoVehicle(thePlayer,theVehicle)
                else
                    _warpPedIntoVehicle(thePlayer,theVehicle,theSeat)
                end
            end
        end
    end
end











