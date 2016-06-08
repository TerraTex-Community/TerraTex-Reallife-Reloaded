 --   
local waffenmarker=false
frakselfcars[8]={}
function createBlackAliens()

 local vehicle= createVehicle(402,-394.20001220703,-1436,25.5,0,0,178.75,"MIB")
 table.insert(frakselfcars[8],vehicle)  
  vehicle= createVehicle(507,-398,-1436,25.5,0,0,175.48461914063,"MIB")   
 table.insert(frakselfcars[8],vehicle)  
  vehicle= createVehicle(581,-407.79998779297,-1430.9000244141,25.299999237061,0,0,179.5,"MIB")   
 table.insert(frakselfcars[8],vehicle)  
  vehicle= createVehicle(521,1411.9000244141,-1298.5999755859,13.10000038147,0,0,266.25,"MIB")   
 table.insert(frakselfcars[8],vehicle) 
  vehicle= createVehicle(587,2791.6999511719,-1429.9000244141,20,0,0,178,"MIB")   
 table.insert(frakselfcars[8],vehicle) 
  vehicle= createVehicle(507,2486.099609375,2356.8994140625,4.1999998092651,0,0,270,"  MIB")   
 table.insert(frakselfcars[8],vehicle)
  vehicle= createVehicle(593,-1437.8000488281,-951.5,201.60000610352,0,0,269.5,"MIB")   
 table.insert(frakselfcars[8],vehicle)
  vehicle= createVehicle(463,-1431.9000244141,-964.20001220703,200.60000610352,0,0,268,"MIB")   
 table.insert(frakselfcars[8],vehicle)

	for key, theVehicle in pairs(frakselfcars[8]) do
		prepare(theVehicle,6)
		setVehicleColor (theVehicle,0,0,0,0)
		vioSetElementData(theVehicle,"tank",100)
		table.insert(frakcars,theVehicle)
	end
		


	waffenmarker=createMarker(1404.0999755859,-1299.5,12.5,"corona",2.0)--innen

	addEventHandler( "onMarkerHit", waffenmarker, hitWMarker)
			
		
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createBlackAliens)

function hitWMarker(thePlayer)
	if(vioGetElementData(thePlayer,"fraktion")==8)then
		outputChatBox("Kaufen der Waffenpakete mit /buypacket [ID]",thePlayer,255,0,0)
		outputChatBox("Waffenpacket 1(5$):  200-Deagle | 150-Shotgun | 5-Sniper | 100-Schutzweste",thePlayer,255,0,0)
		outputChatBox("Waffenpacket 2(15$): 200-Deagle | 150-Shotgun | 400-MP5 | 10-Sniper | 100-Schutzweste",thePlayer,255,0,0)
		outputChatBox("Waffenpacket 3(25$): 200-Deagle | 150-Shotgun | 400-MP5 | 350-M4 | 20-Sniper | 100-Schutzweste",thePlayer,255,0,0)
		outputChatBox("Waffenpacket 4(35$): 200-Deagle | 150-Shotgun | 400-MP5 | 550-M4 | 40-Sniper | 100-Schutzweste",thePlayer,255,0,0)
	
	else
		outputChatBox("Hier wurden schon Menschen verschleppt... Geht lieber wieder!",thePlayer,255,125,255)
	end

end


function buypacket(thePlayer,cmd,id)
	if(vioGetElementData(thePlayer,"fraktion")==8)then
		local px,py,pz=getElementPosition(thePlayer)
		if(getDistanceBetweenPoints3D(px,py,pz,1404.0999755859,-1299.5,12.5))then
			if(tonumber(id))then
				local ids=tonumber(id)
				if(ids==1)then
					if(getPlayerMoney(thePlayer)<50)then
						outputChatBox("Du hast nicht genug Geld!",255,0,0)
					else
						setPedArmor(thePlayer,100)
						giveWeapon(thePlayer,24,200)
						giveWeapon(thePlayer,25,150)
						giveWeapon(thePlayer,34,5)
                        changePlayerMoney(thePlayer,-50,"frakion","Waffenkauf")
						outputChatBox("Packet gekauft!",thePlayer,255,0,0)
					end
				elseif(ids==2)then
					if(getPlayerMoney(thePlayer)<150)then
						outputChatBox("Du hast nicht genug Geld!",255,0,0)
					else
						setPedArmor(thePlayer,100)
						giveWeapon(thePlayer,24,200)
						giveWeapon(thePlayer,25,150)
						giveWeapon(thePlayer,34,10)
						giveWeapon(thePlayer,29,400)
                        changePlayerMoney(thePlayer,-150,"frakion","Waffenkauf")
						outputChatBox("Packet gekauft!",thePlayer,255,0,0)
					end
				elseif(ids==3)then
					if(getPlayerMoney(thePlayer)<250)then
						outputChatBox("Du hast nicht genug Geld!",255,0,0)
					else
						setPedArmor(thePlayer,100)
						giveWeapon(thePlayer,24,200)
						giveWeapon(thePlayer,25,150)
						giveWeapon(thePlayer,34,20)
						giveWeapon(thePlayer,29,400)
						giveWeapon(thePlayer,31,350)
                        changePlayerMoney(thePlayer,-250,"frakion","Waffenkauf")
						outputChatBox("Packet gekauft!",thePlayer,255,0,0)
					end
				elseif(ids==4)then
					if(getPlayerMoney(thePlayer)<350)then
						outputChatBox("Du hast nicht genug Geld!",255,0,0)
					else
						setPedArmor(thePlayer,100)
						giveWeapon(thePlayer,24,200)
						giveWeapon(thePlayer,25,150)
						giveWeapon(thePlayer,34,40)
						giveWeapon(thePlayer,29,400)
						giveWeapon(thePlayer,31,550)
                        changePlayerMoney(thePlayer,-350,"frakion","Waffenkauf")
						outputChatBox("Packet gekauft!",thePlayer,255,0,0)
					end	
				else
					outputChatBox("ungültiges Waffenpacket!",thePlayer,255,0,0)
				end				
			else
				outputChatBox("Nutzung: /buypacket ID",thePlayer,255,0,0)
			end		
		else
			outputChatBox("Du bist nicht am Waffenpunkt!",thePlayer,255,0,0)
		end
	end
end
addCommandHandler("buypacket",buypacket,false,false)



 function notinbbaCarEnter(thePlayer, seat, jacked ,door)
	if(seat==0)then
		for theKey, theVehicle in pairs(frakselfcars[8]) do
			if(source==theVehicle)then
				if not(vioGetElementData(thePlayer,"fraktion")==8)then
                    showError(thePlayer,"Dieses Fahrzeug ist irrgendwie anders... Es lässt sich nicht so leicht fahren!")
					cancelEvent()
				end
			end
		end
	
	end 
 end
 addEventHandler ( "onVehicleStartEnter", getRootElement(), notinbbaCarEnter )
 
 
 addEvent("onDeactivateTarn",true)
 function deativateTarn()
	if(vioGetElementData(source,"tarnung"))then
 		vioSetElementData(source,"tarnung",0)
		setPlayerNametagShowing ( source, true)
		setElementAlpha ( source, 255 )
	end
 end
 addEventHandler("onDeactivateTarn",getRootElement(),deativateTarn)
 addEventHandler("onPlayerStealthKill",getRootElement(),deativateTarn)
 
 
 function activateTarnung(thePlayer)
	if (vioGetElementData(thePlayer,"fraktion")==8)or(vioGetElementData(thePlayer,"job")==7)then
        if(not vioGetElementData(thePlayer,"tarnung"))then
            vioSetElementData(thePlayer,"tarnung",true)
            setPlayerNametagShowing ( thePlayer, false)
            setElementAlpha ( thePlayer, 0 )
            triggerClientEvent(thePlayer,"onShowPlayerTarnung",thePlayer)
        else
            vioSetElementData(thePlayer,"tarnung",false)
            setPlayerNametagShowing ( thePlayer, true)
            setElementAlpha ( thePlayer, 255 )
        end
	end
 end
 addCommandHandler("tarn",activateTarnung,false,false)








