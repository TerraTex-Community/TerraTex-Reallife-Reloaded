
function handleRhinoDamage(attacker, weapon, loss, x, y, z, tyre)
    if(attacker == getLocalPlayer())then
        triggerServerEvent("onVehicleDamageFromClient", source, attacker, weapon, loss, x, y, z, tyre)
    end
end
addEventHandler("onClientVehicleDamage", root, handleRhinoDamage)