function fixVeh_Admin_func(thePlayer)
    if (isAdminLevel(thePlayer, 3)) then
        if (isPedInVehicle(thePlayer)) then
            fixVehicle(getPedOccupiedVehicle(thePlayer))
        end
    end
end
addCommandHandler("fixveh", fixVeh_Admin_func, false, false)

function veh_func(player, command, vehid, useTank)
    if (not useTank) then useTank = 1 end
    if (isAdminLevel(player, 3)) then
        local vehmod = tonumber(vehid)
        local x, y, z = getElementPosition(player)
        local int = getElementInterior(player)
        local dim = getElementDimension(player)
        local veh = createVehicle(vehmod, x + 3, y + 3, z + 10)
        setElementInterior(veh, int, x + 3, y + 3, z + 10)
        setElementDimension(veh, dim)
        if (useTank == 1) then
            vioSetElementData(veh, "hasTank", true)
        end
    end
end
addCommandHandler("veh", veh_func, false, false)

function rveh_func(player, command, useTank, vehtype)
    if (not useTank) then useTank = 1 end
    if (not vehtype) then vehtype = "automobile" end
    if (vehtype == "monster") then
        vehtype = "monster truck"
    end
    if (isAdminLevel(player, 3)) then
        if (vehtype == "?") then
            outputChatBox("Types: Automobile, Plane, Bike, Helicopter, Boat, Train, Trailer, BMX, Monster, Quad", player)
        else
            local vehmod = math.random(400, 612)
            while (string.lower(getVehicleType(vehmod)) ~= string.lower(vehtype)) do
                vehmod = math.random(400, 612)
            end

            local x, y, z = getElementPosition(player)
            local int = getElementInterior(player)
            local dim = getElementDimension(player)
            local veh = createVehicle(vehmod, x + 3, y + 3, z + 10)
            setElementInterior(veh, int, x + 3, y + 3, z + 10)
            setElementDimension(veh, dim)
            if (useTank == 1) then
                vioSetElementData(veh, "hasTank", true)
            end
        end
    end
end
addCommandHandler("rveh", rveh_func, false, false)

function flip(thePlayer)
    if (isAdminLevel(thePlayer, 3)) then
        if (isPedInVehicle(thePlayer)) then
            local veh = getPedOccupiedVehicle(thePlayer)
            local rx, ry, rz = getElementRotation(veh)
            setElementRotation(veh, (rx - 180), ry, rz)
        end
    end
end
addCommandHandler("flip", flip, false, false)

function tune_perkm(thePlayer, cmd, kmh)
    if (isAdminLevel(thePlayer, 3)) then
        local kmold = kmh
        local kmh = tonumber(kmh) * 2.5

        local model = getElementModel(getPedOccupiedVehicle(thePlayer))
        local vehicle = getPedOccupiedVehicle(thePlayer)
        local originalTABEL = getOriginalHandling(model)
        local Handler = (originalTABEL["maxVelocity"] + tonumber(kmh)) / originalTABEL["maxVelocity"]
        local HandlerB = (originalTABEL["maxVelocity"] + tonumber(kmold)) / originalTABEL["maxVelocity"]
        setVehicleHandling(vehicle, "maxVelocity", originalTABEL["maxVelocity"] * Handler)
        setVehicleHandling(vehicle, "engineAcceleration", originalTABEL["engineAcceleration"] * Handler)
        setVehicleHandling(vehicle, "engineInertia", originalTABEL["engineInertia"] * Handler)

        setVehicleHandling(vehicle, "tractionLoss", originalTABEL["tractionLoss"] * HandlerB)
        setVehicleHandling(vehicle, "tractionMultiplier", originalTABEL["tractionMultiplier"] * HandlerB)

        if (originalTABEL["tractionLoss"] * HandlerB > 100) then
            setVehicleHandling(vehicle, "tractionLoss", 100)
        end
        if (originalTABEL["tractionMultiplier"] * HandlerB > 100) then
            setVehicleHandling(vehicle, "tractionMultiplier", 100)
        end
        outputChatBox("done", thePlayer)
    end
end
addCommandHandler("tunekmh", tune_perkm, false, false)

function setColor_func(thePlayer, cmd, colorA, colorB, colorC, colorA2, colorB2, colorC2)
    if not colorA2 or not colorB2 or not colorC2 then
        colorA2, colorB2, colorC2 = colorA, colorB, colorC
    end


    if (isAdminLevel(thePlayer, 3)) then
        local vehicle = getPedOccupiedVehicle(thePlayer)
        setVehicleHeadLightColor(vehicle, colorA, colorB, colorC)
        setVehicleColor(vehicle, colorA, colorB, colorC, colorA2, colorB2, colorC2)
    end
end
addCommandHandler("setcolor", setColor_func, false, false)

function skydive_func(thePlayer, cmd, toPlayerNamePart)
    if (isAdminLevel(thePlayer, 1)) then
        if (toPlayerNamePart) then
            local toPlayer = getPlayerFromIncompleteName(toPlayerNamePart)
            if (toPlayer) then
                local x, y, z = getElementPosition(toPlayer)
                setElementPosition(toPlayer, x, y, z + 1500)
                outputChatBox("Du hast den Spieler " .. getPlayerName(toPlayer) .. " erfolgreich in die Luft geschleudert!", thePlayer, 255, 0, 0)
                outputChatBox(getPlayerName(thePlayer) .. " hat dich in die Luft geschleudert!", toPlayer, 255, 0, 0)
                giveWeapon(toPlayer, 46)
            end
        end
    end
end
addCommandHandler("sky", skydive_func, false, false)

function slap_func(theMaker,Command,thePlayerName)
    if(isAdminLevel(theMaker,3))then
        local thePlayer=getPlayerFromIncompleteName(thePlayerName)
        if(thePlayer)then
            local px,py,pz=getElementPosition(thePlayer)
            setElementPosition(thePlayer,px,py,pz+1)
            setPedOnFire(thePlayer,true)
            local aname=getPlayerName(theMaker)
        else
            outputChatBox("Falscher Spielername",theMaker,255,0,0)
        end
    end

end
addCommandHandler("slap",slap_func,false,false)

addCommandHandler("explode", function (thePlayer, cmd, toPlayerPart)
    if(isAdminLevel(thePlayer,3))then
        if(toPlayerPart)then
            local toPlayer=getPlayerFromIncompleteName(toPlayerPart)
            if(toPlayer)then
                local x,y,z=getElementPosition(toPlayer)
                createExplosion ( x, y, z, 0 ,thePlayer )
                createExplosion ( x+0.5, y, z, 0 ,thePlayer )
                createExplosion ( x, y+0.5, z, 0 ,thePlayer )
                createExplosion ( x+0.5, y+0.5, z, 0 ,thePlayer )
                createExplosion ( x-0.5, y, z, 0 ,thePlayer )
                createExplosion ( x, y-0.5, z, 0 ,thePlayer )
                createExplosion ( x-0.5, y-0.5, z, 0 ,thePlayer )
                createExplosion ( x-0.5, y+0.5, z, 0 ,thePlayer )
                createExplosion ( x+0.5, y-0.5, z, 0 ,thePlayer )
            else
                showError(thePlayer,"Dieser Spieler existiert nicht.")
            end
        else
            showError(thePlayer,"Dieser Spieler existiert nicht.")
        end
    end
end)
