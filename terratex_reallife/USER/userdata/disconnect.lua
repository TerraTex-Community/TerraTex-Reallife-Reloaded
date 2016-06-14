function onSavePlayerQuit(quitType,reson,responsibleElement)
	if(not(vioGetElementData(source,"inArena")==1))then
		if(quitType~="Kicked" and quitType~="Banned")then
			
			local hp=getElementHealth(source)
			local armor=getPedArmor(source)
			local weapons="|"
			local ammos="|"
			for n=0,12,1 do
				local weap=getPedWeapon(source,n)
				local ammo=getPedTotalAmmo ( source, n )	
				weapons=weapons..weap.."|"
				ammos=ammos..ammo.."|"
				
			end	
			
			local nickname=getPlayerName(source)

			MySql.helper.update("user_inventory", { Offline_HP = hp }, { Nickname = nickname});
			MySql.helper.update("user_inventory", { Offline_Armor = armor }, { Nickname = nickname});
			MySql.helper.update("user_inventory", { Offline_Weapons = weapons }, { Nickname = nickname});
			MySql.helper.update("user_inventory", { Offline_Ammo = ammos }, { Nickname = nickname});

		
		else
			local nickname=getPlayerName(source)
			MySql.helper.update("user_inventory", { Offline_HP = 0 }, { Nickname = nickname});
			MySql.helper.update("user_inventory", { Offline_Armor = 0 }, { Nickname = nickname});
			MySql.helper.update("user_inventory", { Offline_Weapons = 0 }, { Nickname = nickname});
			MySql.helper.update("user_inventory", { Offline_Ammo = 0 }, { Nickname = nickname});
		
		end
	end
end
addEventHandler("onPlayerQuit",getRootElement(),onSavePlayerQuit)








