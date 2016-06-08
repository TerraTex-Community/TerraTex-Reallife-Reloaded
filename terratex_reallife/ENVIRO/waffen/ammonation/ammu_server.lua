local ammoPed=false
function createAmmoBots_Server()
	ammoPed=createPed(166, 316.111328125,-133.859375,999.6015625,95  )
	setElementInterior(ammoPed,7)	
	setElementPosition(ammoPed,316.111328125,-133.859375,999.6015625)
	setPedRotation(ammoPed,95 )
	addEventHandler("onPedWasted",ammoPed,respawnAmmoBot_Server)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createAmmoBots_Server)

function respawnAmmoBot_Server()
	destroyElement(ammoPed)
	ammoPed=createPed(166,316.111328125,-133.859375,999.6015625,95 )	
	setElementInterior(ammoPed,7)	
	setElementPosition(ammoPed,316.111328125,-133.859375,999.6015625)
	setPedRotation(ammoPed,95 )
	for theKey,thePlayer in ipairs(getElementsByType("player"))do
	triggerBotToClient_new(thePlayer)
	end
	
	addEventHandler("onPedWasted",ammoPed,respawnAmmoBot_Server)
end

function playerChangedDim_ammo(int,dim)
	if(dim~=-1)then
		setTimer(playerChangedDim_ammo_now,2000,1,source)
	end
end
addEventHandler("onIntDimChange",getRootElement(),playerChangedDim_ammo)

function playerChangedDim_ammo_now(thePlayer)
	if(isElement(thePlayer))then
		triggerClientEvent(thePlayer,"onAmmoChangeDim",thePlayer,getElementDimension(thePlayer),ammoPed)
	end
end

function triggerBotToClient_new(thePlayer)
	triggerClientEvent(thePlayer,"setTriggeredBotAmmonation_Event",ammoPed)

end
function triggerBotToClient()
	triggerClientEvent(source,"setTriggeredBotAmmonation_Event",ammoPed)

end
addEventHandler("onPlayerSpawn",getRootElement(),triggerBotToClient)



addEvent("ammoBuyWeste_Event",true)

function ammoBuyWeste_server_func(theType)
	if(theType=="leicht")then
		if(getPlayerMoney(source)<15)then
			showError(source,"Sie haben nicht genug Geld!")
        else
            changePlayerMoney(source,-15,"sonstiges","Einkauf im Ammonation")
			setPedArmor(source,50)
			frakkasse[attackerLadenInfos[1][1]]=frakkasse[attackerLadenInfos[1][1]]+1.50
			frakkasse[attackerLadenInfos[2][1]]=frakkasse[attackerLadenInfos[2][1]]+1.50
			showError(source,"Sie haben erfolgreich eine leichte Schutzweste gekauft!")
		end
	else
		if(getPlayerMoney(source)<25)then
			showError(source,"Sie haben nicht genug Geld!")		
		else
            changePlayerMoney(source,-25,"sonstiges","Einkauf im Ammonation")
			setPedArmor(source,100)
			frakkasse[attackerLadenInfos[1][1]]=frakkasse[attackerLadenInfos[1][1]]+1.50
			frakkasse[attackerLadenInfos[2][1]]=frakkasse[attackerLadenInfos[2][1]]+1.50
			showError(source,"Sie haben erfolgreich eine schwere Schutzweste gekauft!")
		end	
	end
end
addEventHandler("ammoBuyWeste_Event",getRootElement(),ammoBuyWeste_server_func)


local ammoWeaponID=   {  2,   4,   5,   8,   22,   23,   24,   25,    29,    30,    31,     33}
local ammoWeaponPrice={ 15,  30,  30, 225,  450,  750, 1050, 1500,  4500, 12000, 15000,  30000}
local ammoMuniPrice=  { -1,  -1,  -1,  -1,   15,   15,   30,   45,    15,   120,   150,    600} 

addEvent("ammoBuyWeapon_Event",true)
function ammoBuyWeapon_Event_func(ID)
	local weaponPrice=ammoWeaponPrice[ID]
	local weaponID=ammoWeaponID[ID]
	if(getPlayerMoney(source)<weaponPrice)then
		showError(source,"Sie haben nicht genug Geld bei sich!")
	else
		local wSlotID=getSlotFromWeapon(weaponID)
		if(getPedWeapon ( source, wSlotID )==weaponID)then
			showError(source,"Sie haben diese Waffe bereits!")
		else
            changePlayerMoney(source,-weaponPrice,"sonstiges","Einkauf im Ammonation")
			giveWeapon (source,weaponID,5,false)
			
			--frakkasse[6]=frakkasse[6]+weaponPrice/10
			frakkasse[attackerLadenInfos[1][1]]=frakkasse[attackerLadenInfos[1][1]]+weaponPrice/10
			frakkasse[attackerLadenInfos[2][1]]=frakkasse[attackerLadenInfos[2][1]]+weaponPrice/10
			showError(source,"Du hast erfolgreich diese Waffe gekauft!")	
			
		end
	end
end
addEventHandler("ammoBuyWeapon_Event",getRootElement(),ammoBuyWeapon_Event_func)


addEvent("ammoBuyMuni_Event",true)
function ammoBuyMuni_Event_func(ID,howmany)
	local weaponPrice=ammoMuniPrice[ID]*howmany
	if(weaponPrice>0 and ammoMuniPrice[ID]~=-1)then
		local weaponID=ammoWeaponID[ID]
		if(getPlayerMoney(source)<weaponPrice)then
			showError(source,"Sie haben nicht genug Geld bei sich!")
		else
			local wSlotID=getSlotFromWeapon(weaponID)
			if(getPedWeapon ( source, wSlotID )~=weaponID)then
				showError(source,"Sie besitzen diese Waffe nicht!")
			else
                changePlayerMoney(source,-weaponPrice,"sonstiges","Einkauf im Ammonation")
				showError(source,"Du hast erfolgreich die Munition zu dieser Waffe gekauft!")	
				giveWeapon ( source, weaponID, howmany)				
				frakkasse[attackerLadenInfos[1][1]]=frakkasse[attackerLadenInfos[1][1]]+weaponPrice/10
				frakkasse[attackerLadenInfos[2][1]]=frakkasse[attackerLadenInfos[2][1]]+weaponPrice/10
			end
		end
	else
		showError(source,"Für diese Waffe benötigst du keine Munition!")	
	end
end
addEventHandler("ammoBuyMuni_Event",getRootElement(),ammoBuyMuni_Event_func)











