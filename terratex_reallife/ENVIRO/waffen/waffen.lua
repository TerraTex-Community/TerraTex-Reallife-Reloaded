

function resetWeaponsFromClient()
	takeAllWeapons(source)
end
addEvent("resetPlayerWeapons",true)
addEventHandler("resetPlayerWeapons",getRootElement(),resetWeaponsFromClient)

addEvent("reloadPedWeapon_Event",true)
addEventHandler("reloadPedWeapon_Event",getRootElement(),reloadPedWeapon) 

addEvent("setPlayerWantedLevel_Event",true)
addEventHandler("setPlayerWantedLevel_Event",getRootElement(),setPlayerWantedLevel)








