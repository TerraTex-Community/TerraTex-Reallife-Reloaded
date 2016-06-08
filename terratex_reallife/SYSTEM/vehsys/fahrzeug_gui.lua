
local lastclicked=false
addEventHandler("onClientResourceStart",resourceRoot,
    function()
        FahrzeufUE_Window = {}
        FahrzeufUE_Button = {}
        FahrzeufUE_Label = {}
        FahrzeufUE_Edit = {}
		local dx,dy=guiGetScreenSize()
		dx=522/1600*dx
		dy=333/900*dy
        FahrzeufUE_Window[1] = guiCreateWindow(dx,dy,480,250,"FahrzeugInfos",false)
        FahrzeufUE_Button[1] = guiCreateButton(15,29,450,19,"Beenden",false,FahrzeufUE_Window[1])
        FahrzeufUE_Label[1] = guiCreateLabel(19,60,183,14,"Erstellerzahl:",false,FahrzeufUE_Window[1])
        FahrzeufUE_Label[2] = guiCreateLabel(19,78,183,14,"Kilometerstand:",false,FahrzeufUE_Window[1])
        FahrzeufUE_Label[3] = guiCreateLabel(19,96,183,14,"SlotID:",false,FahrzeufUE_Window[1])
        FahrzeufUE_Label[4] = guiCreateLabel(19,113,183,15,"Besitzer:",false,FahrzeufUE_Window[1])
        FahrzeufUE_Label[5] = guiCreateLabel(19,129,163,18,"Fahrzeugalter:",false,FahrzeufUE_Window[1])
        FahrzeufUE_Label[6] = guiCreateLabel(19,143,151,18,"Automarke:",false,FahrzeufUE_Window[1])
        FahrzeufUE_Label[7] = guiCreateLabel(19,159,213,20,"Entfernung zum Parkplatz:",false,FahrzeufUE_Window[1])
        FahrzeufUE_Edit[1] = guiCreateEdit(276,59,5,124,"",false,FahrzeufUE_Window[1])
        FahrzeufUE_Button[2] = guiCreateButton(300,61,163,24,"Respawnen",false,FahrzeufUE_Window[1])
        FahrzeufUE_Button[3] = guiCreateButton(300,90,163,24,"Abschliesen",false,FahrzeufUE_Window[1])
        FahrzeufUE_Button[4] = guiCreateButton(300,120,163,24,"Parken",false,FahrzeufUE_Window[1])
        FahrzeufUE_Button[5] = guiCreateButton(355,184,112,24,"Abschleppen",false,FahrzeufUE_Window[1])
        FahrzeufUE_Button[6] = guiCreateButton(236,184,112,24,"Löschen",false,FahrzeufUE_Window[1])
        FahrzeufUE_Edit[2] = guiCreateEdit(80,183,150,25,"Grund",false,FahrzeufUE_Window[1])
        FahrzeufUE_Label[8] = guiCreateLabel(32,188,62,22,"Grund:",false,FahrzeufUE_Window[1])
        FahrzeufUE_Label[9] = guiCreateLabel(51,215,58,18,"An",false,FahrzeufUE_Window[1])
        FahrzeufUE_Edit[3] = guiCreateEdit(80,211,150,25,"Name",false,FahrzeufUE_Window[1])
        FahrzeufUE_Button[7] = guiCreateButton(236,212,112,24,"Verkaufen",false,FahrzeufUE_Window[1])
		table.insert(allGuis,FahrzeufUE_Window[1])
		guiSetVisible(FahrzeufUE_Window[1],false)
		guiSetVisible(FahrzeufUE_Button[2],false)
		guiSetVisible(FahrzeufUE_Button[3],false)
		guiSetVisible(FahrzeufUE_Button[4],false)
		guiSetVisible(FahrzeufUE_Button[5],false)
		guiSetVisible(FahrzeufUE_Button[6],false)
		guiSetVisible(FahrzeufUE_Button[7],false)
		addEventHandler ( "onClientGUIClick", FahrzeufUE_Button[1] , closeFahrzeugGUI, false )
		addEventHandler ( "onClientGUIClick", FahrzeufUE_Button[2] , towvehFahrzeugGUI, false )
		addEventHandler ( "onClientGUIClick", FahrzeufUE_Button[3] , lockFahrzeugGUI, false )
		addEventHandler ( "onClientGUIClick", FahrzeufUE_Button[4] , parkFahrzeugGUI, false )		
		addEventHandler ( "onClientGUIClick", FahrzeufUE_Button[5] , abschleppenFahrzeugGUI, false )
		addEventHandler ( "onClientGUIClick", FahrzeufUE_Button[6] , deleteFahrzeugGUI, false )
		addEventHandler ( "onClientGUIClick", FahrzeufUE_Button[7] , sellFahrzeugGUI, false )
	end
)

function sellFahrzeugGUI()
	if(getElementData(lastclicked,"besitzer")==getPlayerName(getLocalPlayer()))then
		local grund=guiGetText(FahrzeufUE_Edit[3])
		if(grund)then
			if(grund~="")then				
				triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"sellcar",grund.." "..getElementData(lastclicked,"slotid"))
			else
				showError(getLocalPlayer(),"Du musst eine Zielperson angeben!")
			end
		else
			showError(getLocalPlayer(),"Du musst eine Zielperson angeben!")	
		end	
	end
end

function deleteFahrzeugGUI()
	if(getElementData(lastclicked,"besitzer"))then
		if(getElementData(lastclicked,"besitzer")==getPlayerName(getLocalPlayer()))then
			triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"deletecar",getElementData(lastclicked,"slotid"))
			closeFahrzeugGUI()
		else
			local grund=guiGetText(FahrzeufUE_Edit[2])
			if(grund)then
				if(grund~="")then
					triggerServerEvent("deleteVehicleByAdmin",getLocalPlayer(),lastclicked,grund)
					closeFahrzeugGUI()
				else
					showError(getLocalPlayer(),"Du musst einen Grund angeben!")
				end
			else
				showError(getLocalPlayer(),"Du musst einen Grund angeben!")	
			end		
		end
	end
end

function abschleppenFahrzeugGUI()
	local grund=guiGetText(FahrzeufUE_Edit[2])
	if(grund)then
		if(grund~="")then
			triggerServerEvent("abgeschleppt_Event",getLocalPlayer(),lastclicked,grund)
			closeFahrzeugGUI()
		else
			showError(getLocalPlayer(),"Du musst einen Grund angeben!")
		end
	else
		showError(getLocalPlayer(),"Du musst einen Grund angeben!")	
	end
end

function lockFahrzeugGUI()
	triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"lock",getElementData(lastclicked,"slotid"))
end

function parkFahrzeugGUI()
	triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"park")
end

function towvehFahrzeugGUI()
	if(getElementData(lastclicked,"besitzer")==getPlayerName(getLocalPlayer()))then
		triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"towveh",getElementData(lastclicked,"slotid"))
		closeFahrzeugGUI()
	else
		triggerServerEvent("respawnVehicleByAdmin",getLocalPlayer(),lastclicked)
		closeFahrzeugGUI()
	end
end

function closeFahrzeugGUI()
		guiSetVisible(FahrzeufUE_Button[2],false)
		guiSetVisible(FahrzeufUE_Button[3],false)
		guiSetVisible(FahrzeufUE_Button[4],false)
		guiSetVisible(FahrzeufUE_Button[5],false)
		guiSetVisible(FahrzeufUE_Button[6],false)
		guiSetVisible(FahrzeufUE_Button[7],false)
		guiSetVisible(FahrzeufUE_Window[1],false)	
		lastclicked=false
		showCursor(false)
end

--BEARBEITEN
function playerClickOnVehicleGUI(button,state,absoluteX,absoluteY,worldX,worldY,worldZ,clickedWorld)
	if (obWindowOpen) then return end
	if not isAnyGuiVisible() then
	if(clickedWorld)then
	if(getElementType(clickedWorld)=="vehicle")then
	local x,y,z=getElementPosition(getLocalPlayer())
	local vx,vy,vz=getElementPosition(clickedWorld)
	local dis=getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)
	if(dis<8)then
		if(getElementData(clickedWorld,"last_driver") and (isAdminLevel(getLocalPlayer(),0)))then
			outputChatBox(string.format("Letzter Fahrer: %s", getElementData(clickedWorld,"last_driver")),255,0,0)
		end
		guiSetText(FahrzeufUE_Label[6],string.format("Automarke: %s", getVehicleNameFromModel(getElementModel(clickedWorld))))
		guiSetVisible(FahrzeufUE_Button[2],false)
		guiSetVisible(FahrzeufUE_Button[3],false)
		guiSetVisible(FahrzeufUE_Button[4],false)
		guiSetVisible(FahrzeufUE_Button[5],false)
		guiSetVisible(FahrzeufUE_Button[6],false)
		guiSetVisible(FahrzeufUE_Button[7],false)
		guiSetVisible(FahrzeufUE_Window[1],true)
		lastclicked=clickedWorld
		if(getElementData(clickedWorld,"besitzer"))then
			guiSetText(FahrzeufUE_Label[4],string.format("Besitzer: %s", getElementData(clickedWorld,"besitzer")))
			if(getPlayerFromName(getElementData(clickedWorld,"besitzer")))then
				guiLabelSetColor ( FahrzeufUE_Label[4], 0,255,0)
			else
				guiLabelSetColor ( FahrzeufUE_Label[4], 255,255,255)
			end
			guiSetText(FahrzeufUE_Label[3],string.format("SlotID: %s", getElementData(clickedWorld,"slotid")))
			guiSetText(FahrzeufUE_Label[1],string.format("Erstellungszahl: %s", getElementData(clickedWorld,"dbid")))	
			guiSetText(FahrzeufUE_Label[2],string.format("Kilometerstand: %s", math.round(getElementData(clickedWorld,"kmstand"),2)))	
			guiSetText(FahrzeufUE_Label[5],string.format("Fahrzeugalter: %s", getElementData(clickedWorld,"falter")))	
			if(getElementData(clickedWorld,"spawnx"))then
				if(getElementData(clickedWorld,"spawnx")==0 and getElementData(clickedWorld,"spawny")==0 and getElementData(clickedWorld,"spawnz")==0)then
					guiSetText(FahrzeufUE_Label[7],"Enfernung zum Parkplatz: unbekannt")
				else
					local x,y,z=getElementPosition(clickedWorld)
					local dis=math.round(getDistanceBetweenPoints3D(getElementData(clickedWorld,"spawnx"),getElementData(clickedWorld,"spawny"),getElementData(clickedWorld,"spawnz"),x,y,z))
					guiSetText(FahrzeufUE_Label[7],string.format("Enfernung zum Parkplatz: %s", dis))				
				end
			else
				guiSetText(FahrzeufUE_Label[7],"Enfernung zum Parkplatz: unbekannt")
			end	
			if(getElementData(clickedWorld,"besitzer")==getPlayerName(getLocalPlayer()))then
				guiSetVisible(FahrzeufUE_Button[2],true)
				guiSetVisible(FahrzeufUE_Button[3],true)
				guiSetVisible(FahrzeufUE_Button[4],true)
				guiSetVisible(FahrzeufUE_Button[5],false)
				guiSetVisible(FahrzeufUE_Button[6],true)
				guiSetVisible(FahrzeufUE_Button[7],true)			
			end
			if(isAdminLevel(getLocalPlayer(),0)) then
				guiSetVisible(FahrzeufUE_Button[2],true)
				guiSetVisible(FahrzeufUE_Button[5],true)
				guiSetVisible(FahrzeufUE_Button[6],true)
				triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"tcheck",getElementData(clickedWorld,"besitzer"))
			end
			if(tonumber(getElementData(getLocalPlayer(),"fraktion"))==1 or tonumber(getElementData(getLocalPlayer(),"fraktion"))==5) or tonumber(getElementData(getLocalPlayer(),"fraktion"))==7 or tonumber(getElementData(getLocalPlayer(),"fraktion"))==9 then
				guiSetVisible(FahrzeufUE_Button[5],true)
			end
		else
			guiSetText(FahrzeufUE_Label[4],"Besitzer: unbekannt")
			guiSetText(FahrzeufUE_Label[3],"SlotID: unbekannt")
			guiSetText(FahrzeufUE_Label[1],"Erstellungszahl: unbekannt")	
			guiSetText(FahrzeufUE_Label[2],"Kilometerstand: unbekannt")	
			guiSetText(FahrzeufUE_Label[5],"Fahrzeugalter: unbekannt")		
			guiSetText(FahrzeufUE_Label[5],"Fahrzeugalter: unbekannt")	
		end
	end
	end
	end
	end
end
addEventHandler("onClientClick",getRootElement(),playerClickOnVehicleGUI)









