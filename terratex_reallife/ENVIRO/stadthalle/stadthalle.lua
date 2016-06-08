function createStMark()
Stadtscheinemarker=createMarker(362.9921875,173.8134765625,1007.3828125,"cylinder",2.0)
setElementInterior(Stadtscheinemarker,3)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createStMark)

function enterScheineMarker(hitElement)
	if(source==Stadtscheinemarker)then
		triggerClientEvent(hitElement,"openStadthalleGui",hitElement,hitElement)
	end
end
addEventHandler( "onMarkerHit", getRootElement(), enterScheineMarker )

scheinePreis={{"autoLic",150},{"truckLic",300},{"planeLic",20000},{"bikeLic",500},{"heliLic",10000},{"boatLic",3000},{"quadLic",100},{"sonstigeLic",150},{"waffenLic",5000},{"angelLic",25},{"persoLic",350},{"reiseLic",1500}}

function controlMrLicenses(thePlayer)
	local hasLicenses=0
	for theKey,theLic in ipairs(scheinePreis) do
		if(vioGetElementData(thePlayer,theLic[1])==1)then
			hasLicenses=hasLicenses+1		
		end	
	end
	if(hasLicenses==table.getn(scheinePreis))then
		if(vioGetElementData(thePlayer,"Erfolg_MrLicenses")~=1)then
			vioSetElementData(thePlayer,"Erfolg_MrLicenses",1)
			triggerClientEvent(thePlayer,"onClientCreatePokalGUI",thePlayer,"Mr.Licenses","Besitze alle Lizensen")
		end
	
	end


end
addEvent("canHaveFuerherLic",true)
function canHaveFuerherLic_func(boolean)
	if(boolean)then
		showError(source,"Du hast die ausgewaehlte Lizens erfolgreich erworben! Bedenke die 5 PayDay-Probezeit!")
		vioSetElementData(source,scheinePreis[1][1],1)
		vioSetElementData(source,"last"..scheinePreis[1][1],5)
	end
	destroyElement(vioGetElementData(source,"fahrmark"))
	setTimer(setPlayerAfterCarPos,2000,1,source)
	setElementDimension(source,0)
	setElementInterior(source,3,362.9921875,173.8134765625,1007.3828125)
	setElementPosition(source,362.9921875,173.8134765625,1007.3828125)	
end
addEventHandler("canHaveFuerherLic",getRootElement(),canHaveFuerherLic_func)

function setPlayerAfterCarPos(player)
	setElementDimension(player,0)
	setElementPosition(player,362.9921875,173.8134765625,1007.3828125)
	setElementInterior(player,3,362.9921875,173.8134765625,1007.3828125)
end

function buyLicSec(theLicNumber)
	if(getPlayerMoney(source)>=scheinePreis[theLicNumber][2])then
		if(vioGetElementData(source,scheinePreis[theLicNumber][1])==0)then
            changePlayerMoney(source,-scheinePreis[theLicNumber][2],"sonstiges","Lizenzkauf")
			if(theLicNumber==1 and vioGetElementData(source,"fuehrerscheinlooser")>0) then
				triggerClientEvent(source,"testfahrschulmarker",source)
				outputChatBox("Bevor du einen Schein erhalten kannst, musst du einen kleinen Praktischen Test absolvieren! (Fahre die Marker ab!)",source,255,0,0)				
			elseif(theLicNumber==11)or(theLicNumber==12)then
				showError(source,"Du hast die ausgewaehlte Lizens erfolgreich erworben! Den Pass kannst du mir /pass [Name] zeigen!")
				vioSetElementData(source,scheinePreis[theLicNumber][1],1)
			else				
				showError(source,"Du hast die ausgewaehlte Lizens erfolgreich erworben! Bedenke die 5 PayDay-Probezeit!")
				vioSetElementData(source,"last"..scheinePreis[theLicNumber][1],5)
				vioSetElementData(source,scheinePreis[theLicNumber][1],1)
			end
			
		else
			if(vioGetElementData(source,scheinePreis[theLicNumber][1])==1)then
				showError(source,"Du besitzt diese Lizens bereits!")
			
			else
				local hour=-vioGetElementData(source,scheinePreis[theLicNumber][1])
				showError(source,string.format("Du kannst diese Lizens erst in %s Stunden erwerben, da sie dir vor kurzen abgenommen wurde!", hour))
			end
		end
	else
		showError(source,"Du hast Fuer diese Lizense nicht genuegend Geld auf deiner Hand!")	
	end
	controlMrLicenses(source)
end
addEvent("buyLic",true)
addEventHandler("buyLic",getRootElement(),buyLicSec)


local stadthallenbot=false
local stadthallenbotb=false
function stadthallenbots()
	stadthallenbot=createPed ( 11, 359.70703125,173.814453125,1008.3893432617,256.49896240234 )
	setElementInterior(stadthallenbot,3)
		addEventHandler("onPedWasted",stadthallenbot,respawn_stadthallen_bots)
	stadthallenbotb=createPed(11,356.2802734375,168.689453125,1008.3762817383,275.95056152344 )
	setElementInterior(stadthallenbotb,3)
		addEventHandler("onPedWasted",stadthallenbotb,respawn_stadthallen_bots)
	
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),stadthallenbots)

function respawn_stadthallen_bots()
	destroyElement(stadthallenbot)
	destroyElement(stadthallenbotb)
		stadthallenbot=createPed ( 11, 359.70703125,173.814453125,1008.3893432617,256.49896240234 )
	setElementInterior(stadthallenbot,3)
		addEventHandler("onPedWasted",stadthallenbot,respawn_stadthallen_bots)
	stadthallenbotb=createPed(11,356.2802734375,168.689453125,1008.3762817383,275.95056152344 )
	setElementInterior(stadthallenbotb,3)
		addEventHandler("onPedWasted",stadthallenbotb,respawn_stadthallen_bots)
	

end











