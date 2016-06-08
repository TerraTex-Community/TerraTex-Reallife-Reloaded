
function startboot_func(thePlayer)
	if (not vioGetElementData(thePlayer, "hasClickedMeeresBoot")) then
        if(vioGetElementData(thePlayer,"job")==17)then
            if(not(isPedInVehicle(thePlayer)))then
                if(not(isPedDead(thePlayer)))then
                    if(hasTheLicenseFor(thePlayer,453))then
                        local x,y,z=getElementPosition(thePlayer)
                        if(getDistanceBetweenPoints3D(x,y,z,2500.166015625,-2259.4609375,3)<10)then
                            local vehicle=createVehicle(453,2499.8017578125,-2268.44140625,-0.16085433959961,3.4661865234375,355.9130859375,272.99377441406)
                            vioSetElementData(vehicle,"hasTank",true)
                            vioSetElementData(vehicle,"hasTankFactor",0.5)
                            vioSetElementData(vehicle,"tank",100)
                            vioSetElementData(thePlayer, "meeresBoot", vehicle)
                            warpPedIntoVehicle(thePlayer,vehicle)
                            addEventHandler("onVehicleStartExit",vehicle,donotexit_meer)
                            triggerClientEvent(thePlayer,"startMeeresBoot",thePlayer)
                            vioSetElementData(thePlayer, "hasClickedMeeresBoot", true)
                        else
                            outputChatBox("Du bist nicht an der Anlegestelle der Reinigungsboote!", thePlayer, 255, 0, 0)
                        end
                    else
                        showError(thePlayer,"Zum Starten dieses Jobs, fehlt dir die Bootslizenz.")
                    end
				end
			end
		end
	end
end
addCommandHandler("startboot",startboot_func,false,false)

function stopboot_func(thePlayer)

	local x,y,z=getElementPosition(thePlayer)
	local dis=getDistanceBetweenPoints3D(2499.8017578125,-2268.44140625,-0.16085433959961,x,y,z)
	if(dis<20)then
        if(isPedInVehicle(thePlayer))then
            if(getElementModel(getPedOccupiedVehicle(thePlayer))==453)then
                triggerClientEvent(thePlayer,"stopboot_event",thePlayer)
            end
        end


		destroyElement(getPedOccupiedVehicle(thePlayer))
		removePedFromVehicle(thePlayer)
		vioSetElementData(thePlayer,"meeresBoot",false)
		setTimer(setElementPosition,1000,1,thePlayer,2500.166015625,-2259.4609375,3)
	else
		showError(thePlayer,"Du kannst /stopboot nur am Hafen benutzen!!!!")
	end
	vioSetElementData(thePlayer, "hasClickedMeeresBoot", false)
end
addCommandHandler("stopboot",stopboot_func,false,false)

function onPlayerWasted_boot()
	if(vioGetElementData(source,"meeresBoot"))then
		destroyElement(vioGetElementData(source,"meeresBoot"))
		vioSetElementData(source,"meeresBoot",false)
	end
	vioSetElementData(source, "hasClickedMeeresBoot", false)
end
addEventHandler("onPlayerWasted",getRootElement(),onPlayerWasted_boot)
addEventHandler("onPlayerQuit",getRootElement(),onPlayerWasted_boot)

function donotexit_meer(thePlayer)
	cancelEvent()
	outputChatBox("Du kannst nicht aussteigen! Um den Job zu beenden gebe an der Anlegestelle /stopboot ein!",thePlayer,255,0,0)
end

addEvent("payForCleanMeer",true)
function payForCleanMeer_func(menge)

	menge=math.round(menge,2)

    local _,betragPayDay=giveJobGehalt(source,17,menge)

	outputChatBox(string.format("Für die %s Meter gereinigtes Meer, hast du ein Gehalt von %s erhalten!", menge, toprice(betragPayDay)),source,255,0,0)


    vioSetElementData(source,"Punkte_Meeresreiniger",vioGetElementData(source,"Punkte_Meeresreiniger")+menge)
    if(vioGetElementData(source,"Punkte_Meeresreiniger")>100000)then
        if(vioGetElementData(source,"Erfolg_Meeresreiniger")~=1)then
            vioSetElementData(source,"Erfolg_Meeresreiniger",1)
            triggerClientEvent(source,"onClientCreatePokalGUI",source,"Meeresreiniger","100km Meer gereinigt.")
        end
    end


end
addEventHandler("payForCleanMeer",getRootElement(),payForCleanMeer_func)








