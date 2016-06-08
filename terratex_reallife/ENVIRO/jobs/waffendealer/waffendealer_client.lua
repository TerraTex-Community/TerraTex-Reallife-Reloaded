local lastpreis = 1200
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GuiWaffenDealer_Window = {}
        GuiWaffenDealer_Button = {}
        GuiWaffenDealer_Label = {}
        GuiWaffenDealer_Edit = {}
		local sx, sy = guiGetScreenSize ()
		local x = (633 / 1600) * sx
		local y = (246 / 900) * sy
        GuiWaffenDealer_Window[1] = guiCreateWindow(x,y,369,182,"Waffendealer",false)
        GuiWaffenDealer_Label[1] = guiCreateLabel(0.0461,0.1923,0.9214,0.1923,"Um Kleinwaffen bauen zu können brauchst du Materials.\nMaterials kannst du hier kaufen!",true,GuiWaffenDealer_Window[1])
        GuiWaffenDealer_Label[2] = guiCreateLabel(0.0407,0.4121,0.3062,0.1209,"Aktueller Preis:",true,GuiWaffenDealer_Window[1])
        GuiWaffenDealer_Label[3] = guiCreateLabel(0.2954,0.4121,0.168,0.1264,"Preis",true,GuiWaffenDealer_Window[1])
        GuiWaffenDealer_Label[4] = guiCreateLabel(0.0407,0.533,0.477,0.1429,"Wie viel möchtest du kaufen?",true,GuiWaffenDealer_Window[1])
        GuiWaffenDealer_Edit[1] = guiCreateEdit(0.5068,0.533,0.4499,0.1374,"",true,GuiWaffenDealer_Window[1])
        GuiWaffenDealer_Button[1] = guiCreateButton(0.0623,0.7418,0.4553,0.1429,"Abbrechen",true,GuiWaffenDealer_Window[1])
        GuiWaffenDealer_Button[2] = guiCreateButton(0.5447,0.7418,0.4119,0.1429,"Kaufen",true,GuiWaffenDealer_Window[1])
		guiSetVisible(GuiWaffenDealer_Window[1],false)	
		addEventHandler ( "onClientGUIClick", GuiWaffenDealer_Button[1], closeWaffenDealerGUI, false )
		addEventHandler ( "onClientGUIClick", GuiWaffenDealer_Button[2], buyWaffenDealerGUI, false )	
    end
)

function closeWaffenDealerGUI()
	guiSetVisible(GuiWaffenDealer_Window[1],false)
	showCursor(false)
end

function buyWaffenDealerGUI()
	local anzahl=tonumber(guiGetText(GuiWaffenDealer_Edit[1]))
	if(anzahl)then
		triggerServerEvent("buyWaffenDealer_Event",getLocalPlayer(),anzahl)
	else
		showError(getLocalPlayer(),"Anzahl eingeben!")
	end
end

addEvent("openWeaponGui",true)
function openWeaponGui_func(preis)
	lastpreis=preis
	guiSetVisible(GuiWaffenDealer_Window[1],true)
	guiSetText(GuiWaffenDealer_Label[3],tostring(preis))
	showCursor(true)
end
addEventHandler("openWeaponGui",getRootElement(),openWeaponGui_func)









