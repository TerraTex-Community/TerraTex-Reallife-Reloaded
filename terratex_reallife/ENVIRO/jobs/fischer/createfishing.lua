local fishingPerson={}
local fishingPickup=false

function createFishingObjects()
    createObject(18233,364.40338134766,-2060.6716308594,8.8381404876709,0,0,38)
    fishingPerson[1]=createObject(1571,395.90484619141,-2073.7414550781,8.1667537689209,0,0,0)
	fishingPerson[2]=createPed (128,396.42242431641,-2073.1818847656,8.8359375,108)
	fishingPerson[3]=createPed (128,303.29000854492,-1884.3599853516,2.2799999713898,290.00231933594)
	setElementFrozen(fishingPerson[3],true)
	setElementFrozen(fishingPerson[2],true)	
	setElementPosition(fishingPerson[2],396.42242431641,-2073.1818847656,8.8359375)
	setPedRotation(fishingPerson[2],180)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createFishingObjects)

function isInFishArea(thePlayer)
	local sx,sy,sz=getElementPosition(thePlayer)
	if(sz<10)and(sz>5)then
		if(sx<409)and(sx>349)and(sy<-2084)and(sy>-2090)then
			return true
		elseif(sx<355)and(sx>349)and(sy<-2047)and(sy>-2080)then
			return true
		else
			return false
		end
	else
		return false
	end
end

function transferFish_func(Fishes,Money,Fishpoints)
	vioSetElementData(source,"fisheslasthour",vioGetElementData(source,"fisheslasthour")+Fishes)
	vioSetElementData(source,"last_fishes",Fishes)
	vioSetElementData(source,"Punkte_Fischermeister",vioGetElementData(source,"Punkte_Fischermeister")+1)
	if(vioGetElementData(source,"Punkte_Fischermeister")>999)then
		if(vioGetElementData(source,"Erfolg_Fischermeister")~=1)then
			vioSetElementData(source,"Erfolg_Fischermeister",1)
			triggerClientEvent(source,"onClientCreatePokalGUI",source,"Fischermeister","1000 gefangene Fische")
		end	
    end
    changePlayerMoney(source,Money,"job","Fischerjob","gefundenes Geld")
	vioSetElementData(source,"fishpoints",vioGetElementData(source,"fishpoints")+Fishpoints)
end
addEvent("transferFish",true)
addEventHandler("transferFish",getRootElement(),transferFish_func)

local canFishVehicle={[484]=true,[453]=true,[454]=true}
function isOnFisherBoat(player)
	local veh=getPedContactElement ( player)
	if(isPedInVehicle(player))then
		veh=getPedOccupiedVehicle(player)
	end
	
	
	-- outputDebugString(tostring(veh).." "..getElementModel(veh))
	if(veh)then
		if(getVehicleType(veh)=="Boat")then
			--outputChatBox(tostring(vioGetElementData(veh,"locked")))
			
			
			if not(vioGetElementData(veh,"locked"))then			
				if(canFishVehicle[getElementModel(veh)] or vioGetElementData(player,"premium")>0)then				
					return true
				else
					outputChatBox("Dies ist kein Fischerboot Marquis oder Tropico!",player,255,0,0)
					return false
				end
			else
				outputChatBox("Zum Angeln muss das Boot aufgeschlossen sein!",player,255,0,0)
				return false
			end
		else
			return false
		end
	else
		return false
	end	
end

function fish_func(thePlayer)
	if(vioGetElementData(thePlayer,"job")==1)then
		if(vioGetElementData(thePlayer,"angelLic")==1)then
			local faktor=1
			if(isWetterEventID==1)then
				faktor=0.8
				outputChatBox("Aufgrund eines Ereignisses dass die Umwelt beeinflusst könnten die Fische weniger Wert sein!",thePlayer,255,0,0)
			elseif(isWetterEventID==2)then
				faktor=0.9
				outputChatBox("Aufgrund eines Ereignisses dass die Umwelt beeinflusst könnten die Fische weniger Wert sein!",thePlayer,255,0,0)
			elseif(isWetterEventID==3)then
				faktor=0.7
				outputChatBox("Aufgrund eines Ereignisses dass die Umwelt beeinflusst könnten die Fische weniger Wert sein!",thePlayer,255,0,0)
			elseif(isWetterEventID==4)then
				faktor=0.8
				outputChatBox("Aufgrund eines Ereignisses dass die Umwelt beeinflusst könnten die Fische weniger Wert sein!",thePlayer,255,0,0)
			elseif(isWetterEventID==5)then
				faktor=1.2
				outputChatBox("Aufgrund eines Ereignisses dass die Umwelt beeinflusst könnten die Fische mehr Wert sein!",thePlayer,255,0,0)
			elseif(isWetterEventID==6)then
				faktor=1.5
				outputChatBox("Aufgrund eines Ereignisses dass die Umwelt beeinflusst könnten die Fische mehr Wert sein!",thePlayer,255,0,0)
			elseif(isWetterEventID==8)then
				faktor=0.75
				outputChatBox("Aufgrund eines Ereignisses dass die Umwelt beeinflusst könnten die Fische weniger Wert sein!",thePlayer,255,0,0)
			end			
		
			if(isInFishArea(thePlayer))then
				if(vioGetElementData(thePlayer,"fisheslasthour")<80)then
					triggerClientEvent(thePlayer,"showFishing",thePlayer,false,faktor)	
				else
					showError(thePlayer,"Du kannst nur 80 Fische pro Stunde fangen!")	
				end
			elseif(isOnFisherBoat(thePlayer))then
				if(vioGetElementData(thePlayer,"fisheslasthour")<80)then
					triggerClientEvent(thePlayer,"showFishing",thePlayer,true,faktor)	
				else
					showError(thePlayer,"Du kannst nur 80 Fische pro Stunde fangen!")	
				end
			else
				showError(thePlayer,"Du bist nicht an einer Angel!")
			end
		else
			showError(thePlayer,"Du hast keine Angellizenz!")
		end
	end
end
addCommandHandler("fish",fish_func,false,false)

function cklickOnFishingHouse(mouseButton,buttonState,clickedElement)
local needFishSkillPoints={100,450,1000,2200,6250}
local fischGehaltperLevel={[0]=0.21,0.35,0.49,0.75,0.99,1.76}
	if(mouseButton=="left") and (buttonState=="down")then
		if(clickedElement==fishingPerson[1])or(clickedElement==fishingPerson[2])or(clickedElement==fishingPerson[3])then
			if(vioGetElementData(source,"job")==1)then
				if(getElementsDistance(source,fishingPerson[1])<10 or getElementsDistance(source,fishingPerson[2])<10 or getElementsDistance(source,fishingPerson[3])<10)then			

                    local betragDirekt,betragPayDay=giveJobGehalt(source,1,math.round(vioGetElementData(source,"fishpoints")))
					outputChatBox(string.format("Du hast deine Fische abgegeben und bekommst %s  !", toprice(betragDirekt)),source,255,0,0)

					vioSetElementData(source,"fishpoints",0)
					vioSetElementData(source,"last_fishes",0)
				end
			end
		end
	end
end
addEventHandler("onPlayerClick",getRootElement(),cklickOnFishingHouse)












