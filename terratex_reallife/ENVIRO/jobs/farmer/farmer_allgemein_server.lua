local maxmissions=9

--[id]="Titel"
missionlist={
	[1]="Erdbeersammler",
	[2]="Heuregen",
	[3]="Düngen",
	[4]="Pflügen",
	[5]="Ernten",
	[6]="Dünger holen",
	[7]="Benzin holen",
	[8]="Apfelkuchen",
	[9]="Holzabholen"
}
--var... call ( resource theResource, string theFunction, [ arguments... ] )

function startfarm_func(thePlayer,cmd,nr)
	if not(vioGetElementData(thePlayer,"isFarmingActiv"))then
		if(vioGetElementData(thePlayer,"job")==14)then
            if(getPlayerLoggedInTime(thePlayer,"minutes")>4)then
                local x,y,z=getElementPosition(thePlayer)
                if(getDistanceBetweenPoints3D(x,y,z,-1058.248046875,-1195.4794921875,129.17562866211)<10)then
                    local randommission=math.random(1,maxmissions)
                    if(nr)then
                        if(isAdminLevel(thePlayer,3))then
                            if(tonumber(nr)<=maxmissions)and(tonumber(nr)>0)then
                                randommission=tonumber(nr)
                            end
                        end
                    end
                    outputChatBox(string.format("Farmermission %s : %s ", randommission, missionlist[randommission]),thePlayer,0,255,0)
                    triggerEvent("farmerjob_mission_start_"..randommission,thePlayer)

                else
                    outputChatBox("Dazu musst du am Jobannahmepunkt des Farmerjobs sein!",thePlayer,255,0,0)
                end
            else
                showError(thePlayer,"Du musst mindestens 5 Minuten eingeloggt sein um eine Mission zu starten.")
            end
		end
	else
		outputChatBox("Es ist bereits eine Mission für dich aktiv!",thePlayer,255,0,0)
	end
end
addCommandHandler("startfarm",startfarm_func,false,false)

function farmer_mission_cancel(thePlayer)


    local betragDirekt,betragPayDay=giveJobGehalt(thePlayer,14,1)


	outputChatBox("Dir wurden "..toprice(betragDirekt).." Belohnung gezahlt!",thePlayer,0,255,0)


    vioSetElementData(thePlayer,"Punkte_Farmerjunge",vioGetElementData(thePlayer,"Punkte_Farmerjunge")+1)
    if(vioGetElementData(thePlayer,"Punkte_Farmerjunge")>100)then
        if(vioGetElementData(thePlayer,"Erfolg_Farmerjunge")~=1)then
            vioSetElementData(thePlayer,"Erfolg_Farmerjunge",1)
            triggerClientEvent(thePlayer,"onClientCreatePokalGUI",thePlayer,"Farmerjunge","100 Farmermissionen erledigt.")
        end
    end

	outputChatBox("Du kannst nun am Farmerspawn einen weitere Mission annehmen!",thePlayer,255,0,0)
end

--[[ form:
addEvent("farmerjob_mission_start_1",false)
function farmerjob_mission_start_1()
	outputChatBox("succesfull")
end
addEventHandler("farmerjob_mission_start_1",getRootElement(),farmerjob_mission_start_1)]]








