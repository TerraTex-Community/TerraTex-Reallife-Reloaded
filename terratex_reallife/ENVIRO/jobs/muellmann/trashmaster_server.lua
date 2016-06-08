trashCars={}

function createTrashMaster()
	local trashvehicle=createVehicle(408,2138.4970703125,-1972.1416015625,14.09748840332,1.2249755859375,359.99450683594,221.19323730469)     
	table.insert(trashCars,trashvehicle)
	trashvehicle=createVehicle(408,2143.017578125,-1971.3974609375,14.14849281311,0.8953857421875,0,224.05517578125)     
	table.insert(trashCars,trashvehicle)
	trashvehicle=createVehicle(408,2148.1083984375,-1971.4658203125,14.126048088074,1.0601806640625,0.10986328125,222.83569335938)     
	table.insert(trashCars,trashvehicle)
	trashvehicle=createVehicle(408,2152.6806640625,-1970.58203125,14.200224876404,0.1263427734375,1.5545654296875,223.99475097656)     
	table.insert(trashCars,trashvehicle)
	trashvehicle=createVehicle(408,2158.58984375,-1971.3798828125,14.10032081604,1.2908935546875,0.010986328125,226.96655273438)    
	table.insert(trashCars,trashvehicle)
		for key, theVehicle in pairs(trashCars) do
			prepare(theVehicle,0)
            vioSetElementData(theVehicle,"hasTank",true)
		end
	setTimer(respawnTrashCars,300000,1)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createTrashMaster)

function respawnTrashCars()
	for key, theVehicle in pairs(trashCars) do
		if not(isAnyOneInVehicle(theVehicle))then
			setVehicleOverrideLights (theVehicle,1)
			setVehicleEngineState (theVehicle,false)				
			respawnVehicle (theVehicle)

            vioSetElementData(theVehicle,"tank",100)
		end
	end
	setTimer(respawnTrashCars,300000,1)		
end

function enter_trashmaster(thePlayer, seat, jacked)
	if(seat==0)then
			for theKey,theVehicleele in ipairs(trashCars) do
				if(theVehicleele==source)then
					if(vioGetElementData(thePlayer,"job")==3)then
						triggerClientEvent(thePlayer,"onPlayerEnterTrashMaster",thePlayer)
					else
						removePedFromVehicle (thePlayer)
						showError(thePlayer, "Du bist kein Müllmann!")
					end
				end	
			end
	end
end
addEventHandler("onVehicleEnter",getRootElement(),enter_trashmaster)

function giveTrashUp_func(trashPoints)

	if(trashPoints>0)then
        local betragDirekt,betragPayDay=giveJobGehalt(source,3,trashPoints)
        showError(source,string.format("Du erhälst ein Gehalt von %s.", toprice(betragPayDay)))


        vioSetElementData(source,"Punkte_Muellsammler",vioGetElementData(source,"Punkte_Muellsammler")+trashPoints)
        if(vioGetElementData(source,"Punkte_Muellsammler")>1000)then
            if(vioGetElementData(source,"Erfolg_Muellsammler")~=1)then
                vioSetElementData(source,"Erfolg_Muellsammler",1)
                triggerClientEvent(source,"onClientCreatePokalGUI",source,"Meeresreiniger","1000 Müllsäcke gesammelt.")
            end
        end

    end
end
addEvent("giveTrashUp",true)
addEventHandler("giveTrashUp",getRootElement(),giveTrashUp_func)








