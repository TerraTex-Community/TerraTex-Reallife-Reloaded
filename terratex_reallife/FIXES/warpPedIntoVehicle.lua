_warpPedIntoVehicle=warpPedIntoVehicle
function warpPedIntoVehicle(thePlayer,theVehicle,theSeat)
    local cc=0
    if(not(theSeat))then
        theSeat=0
    end
    if(isElement(theVehicle) and isElement(thePlayer))then
        if(not(isPedDead(thePlayer)))then
            while(not(isPedInVehicle(thePlayer))) do
                cc=cc+1
                if cc==10 then
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

