
lastclickedcar=0
lastclickedcarele=0
lastvehname=""
lastvehprice=0

addEvent("closeAutohausFahrzeugGuiagain",true)
function closeAutohausFahrzeugGuiagain_func()
	closeFahrzeugGUI()
end
addEventHandler("closeAutohausFahrzeugGuiagain",getRootElement(),closeAutohausFahrzeugGuiagain_func)

function createautohausgui()
	autohausGUI_Window = {}
	autohausGUI_Button = {}
	autohausGUI_Label = {}

	autohausGUI_Window[1] = guiCreateWindow(622,289,309,291,"Autohaus 4 You - Filiale",false)
	table.insert(allGuis,autohausGUI_Window[1])
	autohausGUI_Label[1] = guiCreateLabel(27,51,104,16,"Gewähltes Auto:",false,autohausGUI_Window[1])
	guiLabelSetColor(autohausGUI_Label[1],255,255,255)
	guiLabelSetVerticalAlign(autohausGUI_Label[1],"top")
	guiLabelSetHorizontalAlign(autohausGUI_Label[1],"left",false)
	autohausGUI_Label[2] = guiCreateLabel(28,71,102,15,"Preis:",false,autohausGUI_Window[1])
	guiLabelSetColor(autohausGUI_Label[2],255,255,255)
	guiLabelSetVerticalAlign(autohausGUI_Label[2],"top")
	guiLabelSetHorizontalAlign(autohausGUI_Label[2],"left",false)
	autohausGUI_Label[3] = guiCreateLabel(29,89,149,26,"Freie Slots:",false,autohausGUI_Window[1])
	guiLabelSetColor(autohausGUI_Label[3],255,255,255)
	guiLabelSetVerticalAlign(autohausGUI_Label[3],"top")
	guiLabelSetHorizontalAlign(autohausGUI_Label[3],"left",false)
	autohausGUI_Label[4] = guiCreateLabel(28,109,135,22,"Maximale Slots:",false,autohausGUI_Window[1])
	guiLabelSetColor(autohausGUI_Label[4],255,255,255)
	guiLabelSetVerticalAlign(autohausGUI_Label[4],"top")
	guiLabelSetHorizontalAlign(autohausGUI_Label[4],"left",false)
	autohausGUI_Label[5] = guiCreateLabel(28,129,149,17,"Preis des nächsten Slots:",false,autohausGUI_Window[1])
	guiLabelSetColor(autohausGUI_Label[5],255,255,255)
	guiLabelSetVerticalAlign(autohausGUI_Label[5],"top")
	guiLabelSetHorizontalAlign(autohausGUI_Label[5],"left",false)
	autohausGUI_Button[2] = guiCreateButton(27,158,269,32,"Neuen Zusätzlichen Slot kaufen!",false,autohausGUI_Window[1])
	autohausGUI_Button[3] = guiCreateButton(30,198,268,31,"Auto kaufen!",false,autohausGUI_Window[1])
	autohausGUI_Button[4] = guiCreateButton(33,237,266,33,"Abbrechen!",false,autohausGUI_Window[1])
	autohausGUI_Label[6] = guiCreateLabel(178,128,116,16,"newslotprice",false,autohausGUI_Window[1])
	guiLabelSetColor(autohausGUI_Label[6],255,255,255)
	guiLabelSetVerticalAlign(autohausGUI_Label[6],"top")
	guiLabelSetHorizontalAlign(autohausGUI_Label[6],"left",false)
	autohausGUI_Label[7] = guiCreateLabel(178,109,116,16,"maxslots",false,autohausGUI_Window[1])
	guiLabelSetColor(autohausGUI_Label[7],255,255,255)
	guiLabelSetVerticalAlign(autohausGUI_Label[7],"top")
	guiLabelSetHorizontalAlign(autohausGUI_Label[7],"left",false)
	autohausGUI_Label[8] = guiCreateLabel(177,91,116,16,"slots",false,autohausGUI_Window[1])
	guiLabelSetColor(autohausGUI_Label[8],255,255,255)
	guiLabelSetVerticalAlign(autohausGUI_Label[8],"top")
	guiLabelSetHorizontalAlign(autohausGUI_Label[8],"left",false)
	autohausGUI_Label[9] = guiCreateLabel(175,72,116,16,"carprice",false,autohausGUI_Window[1])
	guiLabelSetColor(autohausGUI_Label[9],255,255,255)
	guiLabelSetVerticalAlign(autohausGUI_Label[9],"top")
	guiLabelSetHorizontalAlign(autohausGUI_Label[9],"left",false)
	autohausGUI_Label[10] = guiCreateLabel(174,51,116,16,"carname",false,autohausGUI_Window[1])
	guiLabelSetColor(autohausGUI_Label[10],255,255,255)
	guiLabelSetVerticalAlign(autohausGUI_Label[10],"top")
	guiLabelSetHorizontalAlign(autohausGUI_Label[10],"left",false)
	guiSetVisible(autohausGUI_Window[1] ,false)
	addEventHandler ( "onClientGUIClick", autohausGUI_Button[4] , closeAutohausGUI, false )
	addEventHandler ( "onClientGUIClick", autohausGUI_Button[2] , buyslotAutohausGUI, false )
	addEventHandler ( "onClientGUIClick", autohausGUI_Button[3] , buycarAutohausGUI, false )
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),createautohausgui)

function buyslotAutohausGUI()
	triggerServerEvent("buyCarSlot_Event",getLocalPlayer())
	closeAutohausGUI()
	showAutohausGUI(lastclickedcar,lastvehprice,lastvehname,lastclickedcarele)
end

function buycarAutohausGUI()
	triggerServerEvent("buyCar_Event",getLocalPlayer(),lastclickedcarele)
	showCursor(false)	
	guiSetVisible(autohausGUI_Window[1] ,false)
end

function closeAutohausGUI()
	guiSetVisible(autohausGUI_Window[1] ,false)
	showCursor(false)
end

function showAutohausGUI(vehmod,vehprice,vehname,vehele)
	closeFahrzeugGUI()
	local freeslots=0
	for zah=1,getElementData(getLocalPlayer(),"maxslots"),1 do
		if tonumber(getElementData(getLocalPlayer(),"slot"..zah))==-1 then
			freeslots=freeslots+1
		end	
	end
	lastclickedcar=vehmod
	lastclickedcarele=vehele
	lastvehname=vehname
	lastvehprice=vehprice
	guiSetText(autohausGUI_Label[8] ,freeslots)
	guiSetText(autohausGUI_Label[7],getElementData(getLocalPlayer(),"maxslots")) 
	slotprice=math.pow ( 2,(tonumber(getElementData(getLocalPlayer(),"maxslots"))-1))*1000
	if(tonumber(getElementData(getLocalPlayer(),"maxslots"))>9)then
		slotprice=math.pow(2,9)*1000+math.pow ( 2,(tonumber(getElementData(getLocalPlayer(),"maxslots"))-5))*300
	end
	if(tonumber(getElementData(getLocalPlayer(),"maxslots"))>14)then
		slotprice=math.pow(2,9)*1000+math.pow ( 2,9)*300+math.pow ( 2,(tonumber(getElementData(getLocalPlayer(),"maxslots"))-10))*300
	end	
	if(tonumber(getElementData(getLocalPlayer(),"maxslots"))>20)then
		slotprice=math.pow(2,9)*1000+math.pow ( 2,9)*300+math.pow ( 2,10)*300+math.pow ( 1.3,(tonumber(getElementData(getLocalPlayer(),"maxslots"))-1))*300
	end	
	guiSetText(autohausGUI_Label[6],toprice(slotprice))
	guiSetText(autohausGUI_Label[9],toprice(vehprice))
	guiSetText(autohausGUI_Label[10],vehname) 	
	guiSetVisible(autohausGUI_Window[1] ,true)
	showCursor(true)
end
addEvent("showAutohausGui_Event",true)
addEventHandler("showAutohausGui_Event",getRootElement(),showAutohausGUI)








