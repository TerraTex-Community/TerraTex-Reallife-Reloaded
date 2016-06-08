local OnlineSchutz
local width, height = guiGetScreenSize()
local fontSize = (17 / 100) * ((width * height) / ((1920 * 1080) / 100))
local lblFont = guiCreateFont("FILES/FONTS/taho.ttf", fontSize)
local preis = 5000

function OnlineSchutz_BuyOnlineSchutz()
	OnlineSchutz_CalculateStats()
end
addEvent("osBuyOnlineSchutzClient", true)
addEventHandler("osBuyOnlineSchutzClient", getRootElement(), OnlineSchutz_BuyOnlineSchutz)

function OnlineSchutz_ButtonClick(btn, state, cursorX, cursorY)
	if (btn == "left" and state == "up") then
		if (guiSetVisible(OnlineSchutz.frmMain, true)) then
			if (source == OnlineSchutz.btnClose) then
				OnlineSchutz_ToggleShow()
			elseif (source == OnlineSchutz.btnOK) then
				-- 30 Tage Schutz kaufen
--				if (preis <= tonumber(getPlayerBank(getLocalPlayer()))) then
					triggerServerEvent("osBuyOnlineSchutzServer", getLocalPlayer())
--				end
			end
		end
	end
end

function OnlineSchutz_CalculateStats()
	local time = getRealTime()
	guiSetText(OnlineSchutz.lblPreisStand, toprice(preis))
	local tage = tonumber(getElementData(getLocalPlayer(), "onlineschutzuntil")) - time.timestamp
	if (tage < 0) then
		tage = 0
	end
	guiSetText(OnlineSchutz.lblVerbleibendTage, math.round(((tage / 60) / 60) / 24) .. " Tag(e)")
end

function OnlineSchutz_Initialize()
	OnlineSchutz = {}
	OnlineSchutz.frmMain = guiCreateWindow(0.40, 0.19, 0.30, 0.56, "", true)
	guiWindowSetSizable(OnlineSchutz.frmMain, false)
	guiSetAlpha(OnlineSchutz.frmMain, 1.00)
	table.insert(allGuis, OnlineSchutz.frmMain)

	OnlineSchutz.imgMain = guiCreateStaticImage(0.02, 0.00, 0.96, 0.97, "FILES/IMAGES/lapptapp/obSchutzMain.png", true, OnlineSchutz.frmMain)

	OnlineSchutz.btnClose = guiCreateButton(0.89, 0.91, 0.09, 0.07, "", true, OnlineSchutz.imgMain)
	guiSetAlpha(OnlineSchutz.btnClose, 0.00)
	guiSetProperty(OnlineSchutz.btnClose, "NormalTextColour", "FF000000")
	addEventHandler("onClientGUIClick", OnlineSchutz.btnClose, OnlineSchutz_ButtonClick, true, "normal")
	
	OnlineSchutz.btnOK = guiCreateButton(0.24, 0.65, 0.54, 0.13, "", true, OnlineSchutz.imgMain)
	guiSetAlpha(OnlineSchutz.btnOK, 0.00)
	guiSetProperty(OnlineSchutz.btnOK, "NormalTextColour", "FF00FF00")
	addEventHandler("onClientGUIClick", OnlineSchutz.btnOK, OnlineSchutz_ButtonClick, true, "normal")
	
	OnlineSchutz.lblPreisText = guiCreateLabel(0.03, 0.90, 0.53, 0.07, "Preis für 30 Tage:", true, OnlineSchutz.imgMain)
	guiLabelSetColor(OnlineSchutz.lblPreisText, 0, 0, 0)
	guiLabelSetVerticalAlign(OnlineSchutz.lblPreisText, "center")
	guiSetFont(OnlineSchutz.lblPreisText, lblFont)
	
	OnlineSchutz.lblPreisStand = guiCreateLabel(0.56, 0.90, 0.26, 0.07, "0", true, OnlineSchutz.imgMain)
	guiLabelSetColor(OnlineSchutz.lblPreisStand, 0, 0, 0)
	guiLabelSetHorizontalAlign(OnlineSchutz.lblPreisStand, "center", false)
	guiLabelSetVerticalAlign(OnlineSchutz.lblPreisStand, "center")
	guiSetFont(OnlineSchutz.lblPreisStand, lblFont)
	
	OnlineSchutz.lblVerbleibendTage = guiCreateLabel(0.56, 0.83, 0.26, 0.07, "0 Tag(e)", true, OnlineSchutz.imgMain)
	guiLabelSetColor(OnlineSchutz.lblVerbleibendTage, 0, 0, 0)
	guiLabelSetHorizontalAlign(OnlineSchutz.lblVerbleibendTage, "center", false)
	guiLabelSetVerticalAlign(OnlineSchutz.lblVerbleibendTage, "center")
	guiSetFont(OnlineSchutz.lblVerbleibendTage, lblFont)
	
	OnlineSchutz_CalculateStats()
end

function OnlineSchutz_ToggleShow()
	if (OnlineSchutz == nil) then
		OnlineSchutz_Initialize()
		guiSetVisible(OnlineSchutz.frmMain, true)
		showCursor(true)
	else
		if (guiGetVisible(OnlineSchutz.frmMain)) then
			guiSetVisible(OnlineSchutz.frmMain, false)
--			showCursor(false)
		else
			guiSetVisible(OnlineSchutz.frmMain, true)
			OnlineSchutz_CalculateStats()
			showCursor(true)
		end
	end
end
addCommandHandler("os", OnlineSchutz_ToggleShow)









