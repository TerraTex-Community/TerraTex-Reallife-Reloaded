function agw_func(thePlayer,Command,player,Weapon)
	if(isAdminLevel(thePlayer,3))then
		if(player)then
			local playern=getPlayerFromIncompleteName(player)
			if(playern)and(Weapon)then
				if(tonumber(Weapon))then
					giveWeapon ( playern, tonumber(Weapon) ,200, true)
					outputChatBox("waffe erhalten!",playern)
				end
			end
		end
	end
end
addCommandHandler("agw",agw_func,false,false)

function checkHP_func(thePlayer,command,vonPlayer)
	if(isAdminLevel(thePlayer,1))then
		local player=getPlayerFromIncompleteName(vonPlayer)
		if(player)then
			outputChatBox("CHECK HEALTH && ARMOR OF "..getPlayerName(player),thePlayer,255,0,0)
			outputChatBox("Health: "..getElementHealth(player),thePlayer,255,0,0)
			outputChatBox("Armor: "..getPedArmor ( player ),thePlayer,255,0,0)		
		else
			showError(thePlayer,"Der Spieler Existiert nicht!")
		end	
	end
end
addCommandHandler("checkhp",checkHP_func,false,false)

function weaponPacket(thePlayer)
    if (isAdminLevel(thePlayer, 3)) then
        setPedArmor(thePlayer, 100)
        giveWeapon(thePlayer, 24, 1000)
        giveWeapon(thePlayer, 25, 1000)
        giveWeapon(thePlayer, 34, 1000)
        giveWeapon(thePlayer, 29, 1000)
        giveWeapon(thePlayer, 31, 1000)
        giveWeapon(thePlayer, 38, 5000)
        triggerClientEvent(thePlayer, "addFood", thePlayer, 1000)
        outputChatBox("Du hast ein Waffenpacket erhalten.", thePlayer)
    end
end
addCommandHandler("waffenpacket", weaponPacket, false, false)










