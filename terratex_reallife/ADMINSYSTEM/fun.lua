function fixVeh_Admin_func(thePlayer)
    if(isAdminLevel(thePlayer,3))then
        if(isPedInVehicle(thePlayer))then
            fixVehicle(getPedOccupiedVehicle(thePlayer))
        end
    end
end
addCommandHandler("fixveh",fixVeh_Admin_func,false,false)

function veh_func(player,command,vehid,useTank)
    if(not useTank)then useTank=1 end
    if(isAdminLevel(player,3))then
        local vehmod=tonumber(vehid)
        local x,y,z=getElementPosition(player)
        local int=getElementInterior(player)
        local dim=getElementDimension(player)
        local veh=createVehicle(vehmod,x+3,y+3,z+10)
        setElementInterior(veh,int,x+3,y+3,z+10)
        setElementDimension(veh,dim)
        if(useTank==1)then
            vioSetElementData(veh,"hasTank",true)
        end
    end

end
addCommandHandler("veh",veh_func,false,false)

function rveh_func(player,command,useTank, vehtype)
    if(not useTank)then useTank=1 end
    if(not vehtype)then vehtype="automobile" end
    if(vehtype == "monster")then
        vehtype = "monster truck"
    end
    if(isAdminLevel(player,3))then
        if(vehtype == "?") then
            outputChatBox("Types: Automobile, Plane, Bike, Helicopter, Boat, Train, Trailer, BMX, Monster, Quad", player)
        else
            local vehmod=math.random(400,612)
            while(string.lower(getVehicleType ( vehmod )) ~= string.lower(vehtype) ) do
                vehmod = math.random(400,612)
            end

            local x,y,z=getElementPosition(player)
            local int=getElementInterior(player)
            local dim=getElementDimension(player)
            local veh=createVehicle(vehmod,x+3,y+3,z+10)
            setElementInterior(veh,int,x+3,y+3,z+10)
            setElementDimension(veh,dim)
            if(useTank==1)then
                vioSetElementData(veh,"hasTank",true)
            end
        end
    end

end
addCommandHandler("rveh",rveh_func,false,false)

function flip(thePlayer)
    if(isAdminLevel(thePlayer,3))then
        if(isPedInVehicle(thePlayer))then
            local veh=getPedOccupiedVehicle(thePlayer)
            local rx,ry,rz=getElementRotation ( veh )
            setElementRotation(veh, (rx-180),ry,rz)
        end
    end
end
addCommandHandler( "flip", flip, false, false)
