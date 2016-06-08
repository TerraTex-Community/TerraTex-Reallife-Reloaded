
        MuntGUI_Window = {}
        MuntGUI_Button = {}
        MuntGUI_Label = {}
        MuntGUI_Edit = {}

		
addEventHandler("onClientResourceStart",resourceRoot,
    function()

        MuntGUI_Window[1] = guiCreateWindow(0.3688,0.3489,0.2325,0.2156,"Munitionsbestellung",true)
        table.insert(allGuis,MuntGUI_Window[1])
		MuntGUI_Label[1] = guiCreateLabel(0.0296,0.1546,0.9301,0.2732,"Wie viel Munition moechtet ihr bestellen?\nAktuell in eurem Depot:0\nMunitionspreis: 0.10$/Kugel",true,MuntGUI_Window[1])
			guiLabelSetColor(MuntGUI_Label[1],255,255,255)
			guiLabelSetVerticalAlign(MuntGUI_Label[1],"top")
			guiLabelSetHorizontalAlign(MuntGUI_Label[1],"left",false)
        MuntGUI_Edit[1] = guiCreateEdit(0.4543,0.2938,0.4973,0.2113,"",true,MuntGUI_Window[1])
        MuntGUI_Button[1] = guiCreateButton(0.0565,0.5515,0.3978,0.2732,"Bestellen",true,MuntGUI_Window[1])
        MuntGUI_Button[2] = guiCreateButton(0.4866,0.5567,0.4301,0.268,"Abbrechen",true,MuntGUI_Window[1])
		guiSetVisible(MuntGUI_Window[1],false)
		
		addEventHandler("onClientGUIClick",MuntGUI_Button[1],bestellenMuntGUI)
		addEventHandler("onClientGUIClick",MuntGUI_Button[2],closeMuntGUI)
	end
)

function bestellenMuntGUI()
	local bestellwert=guiGetText(MuntGUI_Edit[1])
	if(bestellwert~="")then
		local bestellwertnum=tonumber(bestellwert)
		if(bestellwertnum>0 and bestellwertnum<250001)then
			triggerServerEvent("bestellMuntGui_Event",getLocalPlayer(),bestellwertnum)
		else
			outputChatBox("Alter in den Munitionstruck passn nur mehr als 0 und weniger als 250000 Schuss?!",255,0,0)
		end	
	else
		outputChatBox("Sie haben vergessen mir zusagen Wie viel Munition Sie wollen?!",255,0,0)
	end
end

addEvent("closeMuntGui_Event",true)
function closeMuntGUI()
	guiSetVisible(MuntGUI_Window[1],false)
	showCursor(false)
end
addEventHandler("closeMuntGui_Event",getRootElement(),closeMuntGUI)

addEvent("showMunTruckBestellGUI",true)
function showMuntGUI(frakdepot)
	guiSetText(MuntGUI_Label[1],string.format("Wie viel Munition moechtet ihr bestellen?\nAktuell in eurem Depot%s\nMunitionspreis: 0.10$/Kugel", frakdepot))
	guiSetVisible(MuntGUI_Window[1],true)
	showCursor(true)
end
addEventHandler("showMunTruckBestellGUI",getRootElement(),showMuntGUI)














