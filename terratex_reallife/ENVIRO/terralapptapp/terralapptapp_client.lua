tapps = {
	["Tapp-Marketplace"] = "FILES/IMAGES/lapptapp/marketplace.png",
	["Friendlist"] = "FILES/IMAGES/lapptapp/friendlist.png",
	["GPS"] = "FILES/IMAGES/lapptapp/radar_symbol.jpg",
	["Stopuhr"] = "FILES/IMAGES/lapptapp/stop.png",
	["Blitzermelder"] = "FILES/IMAGES/lapptapp/Blitzermelder.png",
	["Kompass"] = "FILES/IMAGES/lapptapp/Kompass.png",
	["EMail"] = "FILES/IMAGES/lapptapp/EMail.png",
	["Notizblock"] = "FILES/IMAGES/lapptapp/Notizblock.png",
	["Colorpicker"] = "FILES/IMAGES/lapptapp/colorpicker.png",
	["TicTacToe"] = "FILES/IMAGES/lapptapp/tictactoe.png",
	["MineSweeper"] = "FILES/IMAGES/lapptapp/MineSweeper.png",
	["OnlineBanking"] = "FILES/IMAGES/lapptapp/OnlineBanking.jpg",
	["OnlineSchutz"] = "FILES/IMAGES/lapptapp/obSchutzLogo.png",
	}

--(0.0222,0.102,0.9284,0.0804
TerralappAppWindow = {}
TerralappAppButton = {}
TerraspezAppButton={}
TerralappAppLabel = {}
TerralappAppImage = {}
TerralappAppScrollpane = {}
addEventHandler("onClientResourceStart", resourceRoot, 
    function()
		TerralappAppWindow[1] = guiCreateWindow(0.0025, 0.1744, 0.2706, 0.8178, "TerraLabbTapp", true)
		table.insert(allGuis, TerralappAppWindow[1])
        guiWindowSetSizable ( TerralappAppWindow[1],false)
		TerralappAppLabel[1] = guiCreateLabel(0.0393, 0.0394, 0.45, 0.0693, "Dein LappTapp!\nNutze deine TAPPs!", true, TerralappAppWindow[1])
		TerralappAppScrollpane[1] = guiCreateScrollPane(0.0208, 0.0965, 0.9353, 0.8791, true, TerralappAppWindow[1])
		TerraspezAppButton[1] = guiCreateButton(0.5797, 0.0476, 0.3649, 0.0367, "Beenden", true, TerralappAppWindow[1])
		--TerralappAppButton[1] = guiCreateButton(0.0222,0.0155,0.9284,0.0804,"Tapp-Marketplace",true,GUIEditor_Scrollpane[1])
		--TerralappAppImage[1] = guiCreateStaticImage(0.7872,0.1923,0.1835,0.6346,"images/mtalogo.png",true,GUIEditor_Button[1])
		addEventHandler ( "onClientGUIClick", TerraspezAppButton[1], closeterraapplapp, false)		
		guiSetVisible(TerralappAppWindow[1], false)
	end
)

function closeterraapplapp()
	guiSetVisible(TerralappAppWindow[1], false)
	showCursor(false)
end

local connectedAppFunc = {}
addEvent("open_terralappapps", true)
function terralapptapp_open(apptable, text)
	guiSetVisible(TerralappAppWindow[1], true)
	showCursor(true)
	for theKey, theElement in ipairs(TerralappAppImage) do
		destroyElement(theElement)
	end
	for theKey, theElement in ipairs(TerralappAppButton) do
		destroyElement(theElement)
	end
	TerralappAppImage = {}
	TerralappAppButton = {}
	local appnumbers = 0
	for theKey, theAppStatus in pairs(apptable) do
		if (theAppStatus == 1) then
            if(text)then
               if(theKey==text)then
                   openApp(text)
               end
            end
			local apppos = appnumbers * 0.0865 + 0.0155
			appnumbers = appnumbers + 1
			TerralappAppButton[appnumbers] = guiCreateButton(0.0222, apppos, 0.9284, 0.0804, theKey, true, TerralappAppScrollpane[1])	
			connectedAppFunc[TerralappAppButton[appnumbers]] = theKey
			--outputChatBox(tostring(TerralappAppButton[appnumbers]))
			TerralappAppImage[appnumbers] = guiCreateStaticImage(0.7872, 0.1923, 0.1835,0.6346, tapps[theKey], true, TerralappAppButton[appnumbers])			
			addEventHandler("onClientGUIClick", TerralappAppButton[appnumbers], clickAppStartButton,false)
		end	
	end
end
addEventHandler("open_terralappapps", getRootElement(), terralapptapp_open)

function clickAppStartButton()
	-- outputChatBox("started "..connectedAppFunc[source])
	openApp(connectedAppFunc[source])
end

function openApp(name)
	name = string.lower(name)
	if (name == "tapp-marketplace") then
		guiSetVisible(MarketTapp_Window[1], true)
	elseif (name == "friendlist") then
		showFriendlistGui()
	elseif (name == "gps") then
		 showGPSDisplay() 
	elseif (name == "stopuhr") then
		showStoppUhrTapp()
	elseif (name == "blitzermelder") then
		showBlitzerTapp()
	elseif (name == "kompass") then
		showKompass()
	elseif (name == "email") then
		showEMail()
	elseif (name == "notizblock") then
		showNotiz()		
	elseif (name == "colorpicker") then
		openPicker(1, false, "Colorpicker")
	elseif (name == "tictactoe") then
		openTicTacToe()
	elseif (name == "minesweeper") then
		ToggleShowMineSweeper()
	elseif (name == "onlinebanking") then
		OnlineBanking_ToggleShow()
	elseif (name == "onlineschutz") then
		OnlineSchutz_ToggleShow()
	end
end









