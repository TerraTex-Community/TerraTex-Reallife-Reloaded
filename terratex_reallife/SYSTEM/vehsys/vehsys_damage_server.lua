addEvent("onVehicleDamageFromClient",true)
function onVehicleDamageFromClient_func(attacker, weapon, loss, x, y, z, tyre)
    if(getElementModel(source)==432)then
        setElementHealth(source,getElementHealth(source)-(loss/3))
    end
    if(vioGetElementData(attacker,"spezWeapon"))then
        setElementHealth(source,getElementHealth(source)-(loss*3))
    end
end
addEventHandler("onVehicleDamageFromClient", getRootElement(),onVehicleDamageFromClient_func)