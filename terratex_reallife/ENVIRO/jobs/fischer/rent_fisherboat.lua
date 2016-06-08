--define This Points
local _price=50
local pickUpCoordinates={0321.12127685547,-1935.4284667969,2.2537822723389}

function createFisherMietPickUp()
	fishInfoPickup=createPickup(pickUpCoordinates[1],pickUpCoordinates[2],pickUpCoordinates[3],3,1239,5000)--koordinaten eintragen
	addEventHandler("onPickupHit",fishInfoPickup,hitBoatRentMarker)

end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createFisherMietPickUp)

function hitBoatRentMarker(player)
	if(vioGetElementData(player,"job")==1)then
		outputChatBox("Wenn Sie kein Boot besitzen können Sie hier ein Fischerboot mieten. (mit '/rentfishboat' )",player,0,255,0)
		outputChatBox("Konditionen: ", player,0,255,0)
		outputChatBox("(1) Das Boot wird für exakt eine Stunde gemietet und Despawned dann automatisch",player,0,255,0)
		outputChatBox("(2) Wenn man das Boot für länger als fünf Minuten verlässt despawned es automatisch",player,0,255,0)
		outputChatBox("(3) Das Boot darf nicht für andere Aktivitäten außer dem Fischen benutzt werden",player,0,255,0)
		outputChatBox("(4) Die Miete des Bootes für eine Stunde kostet: "..toprice(_price),player,0,255,0)
		outputChatBox("!!! Wir haften nicht für Schäden aufgrund von Wanted/Disconnects/Kicks/Bans/Highping/... !!!",player,0,255,0)
	end
end

function rentFisherBoatd_cmd(thePlayer)
	if(vioGetElementData(thePlayer,"job")==1)then
		local x,y,z=getElementPosition(thePlayer)
		if(getDistanceBetweenPoints3D(x,y,z,pickUpCoordinates[1],pickUpCoordinates[2],pickUpCoordinates[3])<10)then
			if(getPlayerMoney(thePlayer)<_price)then
				outputChatBox("Du hast nicht genug Geld auf deiner Hand!",thePlayer,255,0,0)
            else
                if(hasTheLicenseFor(thePlayer,453))then
                    changePlayerMoney(thePlayer,-_price,"job","Fischerjob","Bootsmiete")
                    local fisherBoot=createVehicle(453,316.63000488281,-1940.0699462891,0,0,0,179)
                    setElementPosition(thePlayer,316.63000488281,-1940.0699462891,0)
                    vioSetElementData(fisherBoot,"driver",thePlayer)
                    vioSetElementData(thePlayer,"youDriveABoat",fisherBoot)
                    addEventHandler("onVehicleStartEnter",fisherBoot,nichtDeinFischerboot)
                    addEventHandler("onVehicleEnter",fisherBoot,enterFischerBoot)
                    addEventHandler("onVehicleExit",fisherBoot,exitFischerBoot)

                    warpPedIntoVehicle(thePlayer,fisherBoot)

                    setTimer(killFishBoat_Message,3000000,1,thePlayer,fisherBoot,1)
                    setTimer(killFishBoat_Message,3300000,1,thePlayer,fisherBoot,2)
                    setTimer(destroyBoat,3600000,1,fisherBoot)
                else
                    showError(thePlayer,"Du hast nicht die nötige Lizenz zum führen eines Bootes.")
                end
			end	
		else
			outputChatBox("Du bist nicht am Fischersteg!",thePlayer,255,0,0)
		end
	end
end
addCommandHandler("rentfishboat",rentFisherBoatd_cmd,false,false)

function nichtDeinFischerboot(thePlayer)
	if not(vioGetElementData(source,"driver")==thePlayer) then
		outputChatBox("Dies ist nicht dein Fischerboot!",thePlayer,255,0,0)
		cancelEvent()
	end
end

function killFishBoat_Message(thePlayer,theBoat,typer)
	if(isElement(theBoat) and isElement(thePlayer))then
		if(typer==1)then
			outputChatBox("Dein Fischerboot respawned in 10 Minuten!",thePlayer,255,0,255)
		else
			outputChatBox("Dein Fischerboot respawned in 5 Minuten!",thePlayer,255,0,255)		
		end	
	end
end


function enterFischerBoot(thePlayer)
	if (vioGetElementData(source,"driver")==thePlayer) then
		if(isTimer(vioGetElementData(source,"_destroyTimer")))then
			killTimer(vioGetElementData(source,"_destroyTimer"))
		end
	end
end

function exitFischerBoot(thePlayer)
	if (vioGetElementData(source,"driver")==thePlayer) then
		_destroyTimer=setTimer(destroyBoat,300000,1,source)
		vioSetElementData(source,"_destroyTimer",_destroyTimer)
		outputChatBox("Das Boot wird in 5 min despawnen!",thePlayer)
	end
end

function onDisconnectWithFisherboot()
	if isElement(vioGetElementData(source,"youDriveABoat")) then
		destroyElement(vioGetElementData(source,"youDriveABoat"))
	end	
end
addEventHandler("onPlayerQuit",getRootElement(),onDisconnectWithFisherboot)

function destroyBoat(boot)
	if(isElement(boot))then
		destroyElement(boot)
	end
end








