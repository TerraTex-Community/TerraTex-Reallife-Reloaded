
supershopMarkers={}
function createSuperShopMarkers()

	local marker=createMarker(-27.3447265625,-89.7255859375,1003.546875,"corona",1)
	table.insert(supershopMarkers,{marker,-27.3447265625,-89.7255859375,1003.546875})
	setElementInterior(marker,18)
	
	for i=1,20,1 do
		local marker= createMarker(-27.3447265625,-89.7255859375,1003.546875,"corona",1)
		setElementInterior(marker,18)
		setElementDimension(marker,i)
	end
	
	
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createSuperShopMarkers)


SuperShopWaren={2.99,24.89,89.75,15,1.95,4.85,9.99,49.75,53.45,485.75,10000,10000,2.50,2.50,85.29}
addEvent("buySuperShopGUI_Event",true)
function buySuperShopGUI(id)
	--outputChatBox(tostring(id))
	if(getPlayerMoney(source)<SuperShopWaren[id])then
		showError(source,"Du hast nicht genug Geld!")	
    else
        local playerbetrag=0


		if(id==6 or id==7 or id==8 or id==9)then
			local faktor=1
			if(isWetterEventID==1)then
				faktor=3
			elseif(isWetterEventID==2)then
				faktor=1.5
			elseif(isWetterEventID==3)then
				faktor=3.5
			elseif(isWetterEventID==5)then
				faktor=0.7
			elseif(isWetterEventID==6)then
				faktor=0.9
            end
            playerbetrag= SuperShopWaren[id]*faktor
		else
            playerbetrag= SuperShopWaren[id]
		end
		if(id==1)then
			giveWeapon ( source,14  )
			showError(source,"Du hast erfolgreich Blumen gekauft!")
		elseif(id==2)then
			if(getPedWeapon (source, 9 )==43)then
				giveWeapon ( source,43, 30 )
			else
				giveWeapon ( source,43 , 30)
			end
			showError(source,"Du hast erfolgreich einen Einwegfotoapperat gekauft!")
		elseif(id==3)then
				vioSetElementData(source,"kanister",vioGetElementData(source,"kanister")+1)
		elseif(id==4)then
			vioSetElementData(source,"lottoschein",vioGetElementData(source,"lottoschein")+1)
			showError(source,"Du hast erfolgreich einen Lottoschein gekauft!")
			serversettings["lottojackpot"]=serversettings["lottojackpot"]+10.00
		elseif(id==5)then
			vioSetElementData(source,"rubbellos",vioGetElementData(source,"rubbellos")+1)
			showError(source,"Du hast erfolgreich ein Rubbellos gekauft!")
			serversettings["lottojackpot"]=serversettings["lottojackpot"]+0.10
		elseif(id==6)then
			vioSetElementData(source,"snack",vioGetElementData(source,"snack")+1)
			showError(source,"Du hast erfolgreich ein Snack gekauft!")
		elseif(id==7)then
			vioSetElementData(source,"hamburger",vioGetElementData(source,"hamburger")+1)
			showError(source,"Du hast erfolgreich ein Hamburger gekauft!")
		elseif(id==8)then
			vioSetElementData(source,"fertigessen",vioGetElementData(source,"fertigessen")+1)
			showError(source,"Du hast erfolgreich ein Fertigessen gekauft!")
		elseif(id==9)then
			vioSetElementData(source,"schnellhilfe",vioGetElementData(source,"schnellhilfe")+1)
			showError(source,"Du hast erfolgreich ein Schnellhilfe gekauft!")
		elseif(id==10)then
			vioSetElementData(source,"carfinder",vioGetElementData(source,"carfinder")+1)
			showError(source,"Du hast erfolgreich ein CarFinder gekauft!")
		elseif(id==11)then
			vioSetElementData(source,"Hufeisenhelfer",vioGetElementData(source,"Hufeisenhelfer")+1)
			showError(source,"Du hast erfolgreich ein Hufeisenhelfer gekauft!")
		
		elseif(id==12)then
			if(vioGetElementData(source,"terralapptapp")>0)then
				showError(source,"Du hast bereits einen TerraLappTapp!")
                playerbetrag=0
			else
				vioSetElementData(source,"terralapptapp",1)
				showError(source,"Du hast erfolgreich ein TerraLappTapp gekauft!")
			end
		elseif(id==13)then
			if(vioGetElementData(source,"tachodig_addon")>0)then
				showError(source,"Du hast bereits eine digitale Tachoerweiterung!")
                playerbetrag=0
			else
				vioSetElementData(source,"tachodig_addon",1)
				showError(source,"Du hast erfolgreich eine digitale Tachoerweiterung gekauft!")
			end
		elseif(id==14)then
			if(vioGetElementData(source,"dice")<10)then
				vioSetElementData(source,"dice",vioGetElementData(source,"dice")+1)
				showError(source,"Du hast erfolgreich einen Würfel gekauft!")
			else
                playerbetrag=0
				showError(source,"Du kannst höchstens 10 Würfel besitzen!")
			end
        elseif(id==15)then
            vioSetElementData(source,"Kondome",vioGetElementData(source,"Kondome")+5)
            showError(source,"Du hast erfolgreich eine 5er Packung Kondome gekauft!")
        elseif(id==16)then
            vioSetElementData(source,"blutmesser",vioGetElementData(source,"blutmesser")+5)
            showError(source,"Du hast 5 Blutteststreifen gekauft.")
        end


        if(playerbetrag>0)then
            changeBizKasse(8, playerbetrag/10, "Einkauf")   --> id 8
            changePlayerMoney(source,-playerbetrag,"sonstiges","Einkauf im 24/7")
        end
	end
end
addEventHandler("buySuperShopGUI_Event",getRootElement(),buySuperShopGUI)



function loadSuperShop_func(hitElement)
	for theKey,theMarker in ipairs (supershopMarkers)do
		if(theMarker[1]==source)then
			vioSetElementData(hitElement,"lastSuperShop",theKey)			
			triggerClientEvent(hitElement,"showSuperGUI_Event",hitElement)
			break
		end
	
	end
end
addEventHandler("onMarkerHit",getRootElement(),loadSuperShop_func)

addEvent("closeSuperShopGUI_Event",true)
function closeSuperShopGUI()
	local id=vioGetElementData(source,"lastSuperShop")
	setElementPosition(source,supershopMarkers[id][2],supershopMarkers[id][3],supershopMarkers[id][4])
end
addEventHandler("closeSuperShopGUI_Event",getRootElement(),closeSuperShopGUI)








