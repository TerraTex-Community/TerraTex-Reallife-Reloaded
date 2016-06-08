--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 09.02.14
-- Time: 01:50
-- To change this template use File | Settings | File Templates.
--

function respawnFrakVehicle(id, admin, thePlayer)
    local pricePerLiter=serversettings["tankpreis"]*2
    local summe=500
    if(admin)then
        pricePerLiter=serversettings["tankpreis"]*6
        frakkasse[id]=frakkasse[id]-3500
        summe=3500
    end
    if(frakselfcars[id])then
        for key, theVehicle in pairs(frakselfcars[id]) do
            if not(isAnyOneInVehicle(theVehicle))then
                setVehicleOverrideLights (theVehicle,1)
                setVehicleEngineState (theVehicle,false)
                respawnVehicle (theVehicle)
                if(vioGetElementData(theVehicle,"frakid")~=0)then
                    if(frakkasse[vioGetElementData(theVehicle,"frakid")]>=(100-vioGetElementData(theVehicle,"tank"))*pricePerLiter)then
                        frakkasse[vioGetElementData(theVehicle,"frakid")]=frakkasse[vioGetElementData(theVehicle,"frakid")]-(100-vioGetElementData(theVehicle,"tank"))*pricePerLiter

                        changeBizKasse(7, (100-vioGetElementData(theVehicle,"tank"))*pricePerLiter, "Bezinkauf")
                        summe=summe+(100-vioGetElementData(theVehicle,"tank"))*pricePerLiter
                        vioSetElementData(theVehicle,"tank",100)
                    end
                else
                    vioSetElementData(theVehicle,"tank",100)
                end
            end
        end
    end
    if(admin)then
        frakdepot_log(id,1,-summe,string.format("Fahrzeugrespawn by Admin-%s", getPlayerName(thePlayer)))
    else
        frakdepot_log(id,1,-summe,string.format("Fahrzeugrespawn by %s", getPlayerName(thePlayer)))
    end
end


function frakrespawn_cmd(thePlayer)
    if(vioGetElementData(thePlayer,"fraktion")>0 and vioGetElementData(thePlayer,"fraktionsrang")>4)then
        local frakID=vioGetElementData(thePlayer,"fraktion")
        if(frakselfcars[frakID] and frakkasse[frakID])then
            if(frakkasse[frakID]<500)then
                showError(thePlayer, "In der Fraktionskasse befindet sich nicht genügend Geld! (Kosten pro Respawn: 500$)")
            else
                frakkasse[frakID]=frakkasse[frakID]-500
                respawnFrakVehicle(frakID, false, thePlayer)
                if(frakID==1)then
                    respawnFrakVehicle(9,false, thePlayer)
                end
                showError(thePlayer, "Die Fahrzeuge wurden erfolgreich respawned.")

            end
        end
    end
end
addCommandHandler("frakrespawn", frakrespawn_cmd,false,false)


function respawnNoobCars(thePlayer,command,vehiclestring,frak)
    local console=getElementsByType("console")
    if(vehiclestring=="mechaniker")then
        if(isAdminLevel(thePlayer,1)) or (console[1]==thePlayer) then

            for key, theVehicle in pairs(mechVehicles) do
                if not(isAnyOneInVehicle(theVehicle))then
                    setVehicleOverrideLights (theVehicle,1)
                    setVehicleEngineState (theVehicle,false)
                    respawnVehicle (theVehicle)
                    if(vioGetElementData(theVehicle,"frakid")~=0)then
                        if(frakkasse[vioGetElementData(theVehicle,"frakid")]>=(100-vioGetElementData(theVehicle,"tank"))*0.06)then
                            frakkasse[vioGetElementData(theVehicle,"frakid")]=frakkasse[vioGetElementData(theVehicle,"frakid")]-(100-vioGetElementData(theVehicle,"tank"))*0.06

                            changeBizKasse(7, (100-vioGetElementData(theVehicle,"tank"))*0.06, "Bezinkauf")
                            vioSetElementData(theVehicle,"tank",100)
                        end
                    else
                        vioSetElementData(theVehicle,"tank",100)
                    end
                end

            end
        end

    elseif(vehiclestring=="noob")then
        if(isAdminLevel(thePlayer,1)) or (console[1]==thePlayer) then

            for key, theVehicle in pairs(noobCars) do
                if not(isAnyOneInVehicle(theVehicle))then
                    setVehicleOverrideLights (theVehicle,1)
                    setVehicleEngineState (theVehicle,false)
                    respawnVehicle (theVehicle)
                    if(vioGetElementData(theVehicle,"frakid")~=0)then
                        if(frakkasse[vioGetElementData(theVehicle,"frakid")]>=(100-vioGetElementData(theVehicle,"tank"))*0.06)then
                            frakkasse[vioGetElementData(theVehicle,"frakid")]=frakkasse[vioGetElementData(theVehicle,"frakid")]-(100-vioGetElementData(theVehicle,"tank"))*0.06

                            changeBizKasse(7, (100-vioGetElementData(theVehicle,"tank"))*0.06, "Bezinkauf")
                            vioSetElementData(theVehicle,"tank",100)
                        end
                    else
                        vioSetElementData(theVehicle,"tank",100)
                    end
                end

            end
        end
    elseif(vehiclestring=="muell")then
        if(isAdminLevel(thePlayer,1)) or (console[1]==thePlayer) then

            for key, theVehicle in pairs(trashCars) do
                if not(isAnyOneInVehicle(theVehicle))then
                    setVehicleOverrideLights (theVehicle,1)
                    setVehicleEngineState (theVehicle,false)
                    respawnVehicle (theVehicle)
                    if(vioGetElementData(theVehicle,"frakid")~=0)then
                        if(frakkasse[vioGetElementData(theVehicle,"frakid")]>=(100-vioGetElementData(theVehicle,"tank"))*0.06)then
                            frakkasse[vioGetElementData(theVehicle,"frakid")]=frakkasse[vioGetElementData(theVehicle,"frakid")]-(100-vioGetElementData(theVehicle,"tank"))*0.06

                            changeBizKasse(7, (100-vioGetElementData(theVehicle,"tank"))*0.06, "Bezinkauf")
                            vioSetElementData(theVehicle,"tank",100)
                        end
                    else
                        vioSetElementData(theVehicle,"tank",100)
                    end
                end

            end
        end
    elseif(vehiclestring=="pizza")then
        if(isAdminLevel(thePlayer,1)) or (console[1]==thePlayer) then

            for key, theVehicle in pairs(pizzaRoller) do
                if not(isAnyOneInVehicle(theVehicle))then
                    setVehicleOverrideLights (theVehicle,1)
                    setVehicleEngineState (theVehicle,false)
                    respawnVehicle (theVehicle)
                    if(vioGetElementData(theVehicle,"frakid")~=0)then
                        if(frakkasse[vioGetElementData(theVehicle,"frakid")]>=(100-vioGetElementData(theVehicle,"tank"))*0.06)then
                            frakkasse[vioGetElementData(theVehicle,"frakid")]=frakkasse[vioGetElementData(theVehicle,"frakid")]-(100-vioGetElementData(theVehicle,"tank"))*0.06
                            changeBizKasse(7, (100-vioGetElementData(theVehicle,"tank"))*0.06, "Bezinkauf")
                            vioSetElementData(theVehicle,"tank",100)
                        end
                    else
                        vioSetElementData(theVehicle,"tank",100)
                    end
                end

            end
        end
    elseif(vehiclestring=="fraktion")then
        if(isAdminLevel(thePlayer,1)) or (console[1]==thePlayer) then
            if(frak)then
                if(tonumber(frak))then
                    if(frakselfcars[tonumber(frak)])then
                        respawnFrakVehicle(tonumber(frak), true, thePlayer)
                        if(frak==1)then
                            respawnFrakVehicle(9, true, thePlayer)
                        end
                    else
                        outputChatBox("ungültige FraktionsID",thePlayer,255,0,0)
                    end
                else
                    outputChatBox("ungültige FraktionsID",thePlayer,255,0,0)
                end
            else
                outputChatBox("ungültige FraktionsID",thePlayer,255,0,0)
            end
        end
    else
        outputChatBox("Respawnables: bus,noob,mechaniker,noob,pizza  oder /respawn fraktion [frakid]",thePlayer,255,0,0)
    end

end
addCommandHandler("respawn",respawnNoobCars,false,false)











