
function resetWeaponsFromClient()
	takeAllWeapons(source)
end
addEvent("resetPlayerWeapons",true)
addEventHandler("resetPlayerWeapons",getRootElement(),resetWeaponsFromClient)

addEvent("reloadPedWeapon_Event",true)
addEventHandler("reloadPedWeapon_Event",getRootElement(),reloadPedWeapon) 

