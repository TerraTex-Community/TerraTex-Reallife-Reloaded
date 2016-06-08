local OnlineBanking
local width, height = guiGetScreenSize()
local fontSize = (17 / 100) * ((width * height) / ((1920 * 1080) / 100))
local fontSizeTwo = (18 / 100) * ((width * height) / ((1920 * 1080) / 100))

function OnlineBanking_DeleteTAN()
	guiSetText(OnlineBanking.lblTanCode, "")
end

function OnlineBanking_GetTanCodes(haveTAN)
	if (haveTAN) then
		showError(getLocalPlayer(), "Achtung\nDer Code ist nur 3 Minuten gültig.")
		guiSetText(OnlineBanking.lblTanCode, RandomStringWithoutSpecial(10))
		if (isTimer(OnlineBanking.timerTAN)) then
			killTimer(OnlineBanking.timerTAN)
		end
		OnlineBanking.timerTAN = setTimer(OnlineBanking_DeleteTAN, 180000, 1)
	end
end
addEvent("obGetTANCodesClient", true)
addEventHandler("obGetTANCodesClient", getRootElement(), OnlineBanking_GetTanCodes)

function OnlineBanking_ButtonTasteF()
	if (guiGetText(OnlineBanking.editEmpfaengerName) == "Doodys vereinigten Kinderhilfswerke") then
		triggerServerEvent("obGetTanCodeServer", getLocalPlayer(), true)
	else
		triggerServerEvent("obGetTanCodeServer", getLocalPlayer(), false)
	end
end

function OnlineBanking_ButtonTasteC()
	guiSetVisible(OnlineBanking.frmMain, true)
	guiSetVisible(OnlineBanking.frmUeberweisung, false)
	removeEventHandler("onClientPreRender", getRootElement(), OnlineBanking_OnClientPreRender)
	guiSetVisible(OnlineBanking.frmTAN, false)
	guiSetText(OnlineBanking.lblTanCode, "")
	guiSetText(OnlineBanking.editEmpfaengerName, "")
	guiSetText(OnlineBanking.editVerwendungszweck, "")
	guiSetEnabled(OnlineBanking.editEmpfaengerName, true)
	guiSetEnabled(OnlineBanking.editVerwendungszweck, true)
end

function OnlineBanking_UeberweisungClient(fehlgeschlagen)
	if (fehlgeschlagen) then
		if (isTimer(OnlineBanking.timerTAN)) then
			killTimer(OnlineBanking.timerTAN)
		end
		guiSetText(OnlineBanking.lblTanCode, "")
	else
		guiSetText(OnlineBanking.editEmpfaengerName, "")
		guiSetText(OnlineBanking.editSumme, "")
		guiSetText(OnlineBanking.editVerwendungszweck, "")
		if (isTimer(OnlineBanking.timerTAN)) then
			killTimer(OnlineBanking.timerTAN)
		end
		guiSetText(OnlineBanking.lblTanCode, "")
		removeEventHandler("onClientPreRender", getRootElement(), OnlineBanking_OnClientPreRender)
		guiSetEnabled(OnlineBanking.editEmpfaengerName, true)
		guiSetEnabled(OnlineBanking.editVerwendungszweck, true)
		guiSetVisible(OnlineBanking.frmMain, true)
		guiSetVisible(OnlineBanking.frmUeberweisung, false)
		removeEventHandler("onClientPreRender", getRootElement(), OnlineBanking_OnClientPreRender)
		guiSetVisible(OnlineBanking.frmTAN, false)
	end
end
addEvent("obUeberweisungClient", true)
addEventHandler("obUeberweisungClient", getRootElement(), OnlineBanking_UeberweisungClient)

function OnlineBanking_ButtonTasteOK()
	local empfaenger = guiGetText(OnlineBanking.editEmpfaengerName)
	local grund = guiGetText(OnlineBanking.editVerwendungszweck)
	local summe = guiGetText(OnlineBanking.editSumme)
	local tanString = guiGetText(OnlineBanking.lblTanCode)
	if (tanString ~= "") then
		if (empfaenger ~= "") then
			if (grund ~= "") then
				summe = tonumber(summe)
                if(summe)then
                    if (summe > 0) then
                        if (summe <= tonumber(getPlayerBank(getLocalPlayer()))) then
                            showError(getLocalPlayer(), "Soweit alles OK, Daten werden nun an den Server übermittelt. Bitte hab ein wenig gedult.")
                            triggerServerEvent("obUberweisenServer", getLocalPlayer(), empfaenger, grund, summe)
                            if (isTimer(OnlineBanking.timerTAN)) then
                                killTimer(OnlineBanking.timerTAN)
                            end
                            guiSetText(OnlineBanking.lblTanCode, "")
                        else
                            showError(getLocalPlayer(), "Keine Kontodeckung vorhanden.\nDu hast nicht genug Geld auf dem Konto zum durchführen dieser Überweisung.")
                        end
                    else
                        showError(getLocalPlayer(), "Negative Überweisungssumme angegeben.\nEs muss eine Positive Summe angegeben werden.")
                    end
                else
                    showError(getLocalPlayer(), "Negative Überweisungssumme angegeben.\nEs muss eine Positive Summe angegeben werden.")
                end
			else
				showError(getLocalPlayer(), "Kein Verwendungszweck angegeben.\nDu mußt einen Verwendungszweck angeben.")
			end
		else
			showError(getLocalPlayer(), "Kein Empfänger angegeben.\nDu musst einen Empfänger angeben.")
		end
	else
		showError(getLocalPlayer(), "Kein TAN Code vorhanden.\nDu musst zuvor einen TAN Code anfordern.")
	end
end

function OnlineBanking_OnClientPreRender()
	if (OnlineBanking) then
		local curTime = getRealTime()
		guiSetText(OnlineBanking.lblDatum, curTime.monthday .. "." .. (curTime.month + 1) .. "." .. (curTime.year + 1900))
		guiSetText(OnlineBanking.lblEmpfaengerName, guiGetText(OnlineBanking.editEmpfaengerName))
		guiSetText(OnlineBanking.lblSumme, guiGetText(OnlineBanking.editSumme))
		guiSetText(OnlineBanking.lblVerwendungszweck, guiGetText(OnlineBanking.editVerwendungszweck))
	end
end

function OnlineBanking_ButtonClick(btn, state, cursorX, cursorY) -- Klicken eines Buttons
	if (btn == "left" and state == "up") then
		if (guiSetVisible(OnlineBanking.frmMain, true)) then
			if (source == OnlineBanking.btnUeberweisung) then
				guiSetVisible(OnlineBanking.frmMain, false)
				guiSetVisible(OnlineBanking.frmUeberweisung, true)
				addEventHandler("onClientPreRender", getRootElement(), OnlineBanking_OnClientPreRender)
				guiSetVisible(OnlineBanking.frmTAN, true)
			elseif (source == OnlineBanking.btnSpenden) then
				guiSetVisible(OnlineBanking.frmMain, false)
				guiSetVisible(OnlineBanking.frmUeberweisung, true)
				addEventHandler("onClientPreRender", getRootElement(), OnlineBanking_OnClientPreRender)
				guiSetVisible(OnlineBanking.frmTAN, true)
				guiSetText(OnlineBanking.editEmpfaengerName, "Doodys vereinigten Kinderhilfswerke")
				guiSetEnabled(OnlineBanking.editEmpfaengerName, false)
				guiSetText(OnlineBanking.editVerwendungszweck, "Spende an die vereinigte Kinderhilfswerke")
				guiSetEnabled(OnlineBanking.editVerwendungszweck, false)
			elseif (source == OnlineBanking.btnSchliessen) then
				removeEventHandler("onClientPreRender", getRootElement(), OnlineBanking_OnClientPreRender)
				guiSetEnabled(OnlineBanking.editEmpfaengerName, true)
				guiSetEnabled(OnlineBanking.editVerwendungszweck, true)
				OnlineBanking_ToggleShow()
			end
		end
	end
end

function OnlineBanking_GetColor(element, text) -- Setzen und einfärben des Textes
	local money = 0
	if (text == "money") then
		money = tonumber(getPlayerMoney(getLocalPlayer()))
	elseif (text == "bank") then
		money = tonumber(getPlayerBank(getLocalPlayer()))
	elseif (text == "ingamespenden") then
		money = tonumber(getPlayerSpenden(getLocalPlayer()))
	end
	guiSetText(element, toprice(money))
	if (money >= 0) then
		guiLabelSetColor(element, 0, 255, 0)
	elseif (money < 0) then
		guiLabelSetColor(element, 255, 0, 0)
	else
		guiLabelSetColor(element, 255, 255, 255)
	end
end

function OnlineBanking_CalculateStats() -- Setzen und einfärben des Textes
	OnlineBanking_GetColor(OnlineBanking.lblBargeldStand, "money")
	OnlineBanking_GetColor(OnlineBanking.lblKontostandStand, "bank")
	OnlineBanking_GetColor(OnlineBanking.lblSpendenStand, "ingamespenden")
end

function OnlineBanking_TAN()
	-- frmTAN
	OnlineBanking.frmTAN = guiCreateWindow(0.69, 0.25, 0.17, 0.35, "", true)
	guiWindowSetSizable(OnlineBanking.frmTAN, false)
	guiSetAlpha(OnlineBanking.frmTAN, 1.00)
	guiSetVisible(OnlineBanking.frmTAN, false)
	table.insert(allGuis, OnlineBanking.frmTAN)
	-- imgTAN
	OnlineBanking.imgTAN = guiCreateStaticImage(0.03, 0.03, 0.94, 0.95, "FILES/IMAGES/lapptapp/obTAN.png", true, OnlineBanking.frmTAN)
	-- lblTANCode
	OnlineBanking.lblTanCode = guiCreateLabel(0.20, 0.16, 0.55, 0.14, "", true, OnlineBanking.imgTAN)
	guiLabelSetColor(OnlineBanking.lblTanCode, 0, 0, 0)
	guiLabelSetHorizontalAlign(OnlineBanking.lblTanCode, "center", false)
	guiLabelSetVerticalAlign(OnlineBanking.lblTanCode, "center")
	-- btnF
	OnlineBanking.btnF = guiCreateButton(0.65, 0.40, 0.15, 0.08, "", true, OnlineBanking.imgTAN)
	guiSetAlpha(OnlineBanking.btnF, 0.00)
	addEventHandler("onClientGUIClick", OnlineBanking.btnF, OnlineBanking_ButtonTasteF, false, "normal")
	-- btnC
	OnlineBanking.btnC = guiCreateButton(0.65, 0.48, 0.15, 0.08, "", true, OnlineBanking.imgTAN)
	guiSetAlpha(OnlineBanking.btnC, 0.00)
	addEventHandler("onClientGUIClick", OnlineBanking.btnC, OnlineBanking_ButtonTasteC, false, "normal")
	--- btnOK
	OnlineBanking.btnOK = guiCreateButton(0.65, 0.66, 0.15, 0.08, "", true, OnlineBanking.imgTAN)
	guiSetAlpha(OnlineBanking.btnOK, 0.00)
	addEventHandler("onClientGUIClick", OnlineBanking.btnOK, OnlineBanking_ButtonTasteOK, false, "normal")
end

function OnlineBanking_Ueberweisung()
	-- frmUeberweisung
	OnlineBanking.frmUeberweisung = guiCreateWindow(0.33, 0.25, 0.36, 0.47, "", true)
	guiWindowSetSizable(OnlineBanking.frmUeberweisung, false)
	guiSetAlpha(OnlineBanking.frmUeberweisung, 1.00)
	guiSetVisible(OnlineBanking.frmUeberweisung, false)
	table.insert(allGuis, OnlineBanking.frmUeberweisung)
	-- imgUeberweisung
	OnlineBanking.imgMain = guiCreateStaticImage(0.01, 0.02, 0.97, 0.96, "FILES/IMAGES/lapptapp/obSEPARoh.png", true, OnlineBanking.frmUeberweisung)
	-- editEmpfaengerName
	OnlineBanking.lblEmpfaengerName = guiCreateLabel(0.08, 0.20, 0.87, 0.05, "", true, OnlineBanking.imgMain)
	guiLabelSetColor(OnlineBanking.lblEmpfaengerName, 0, 0, 0)
	guiLabelSetVerticalAlign(OnlineBanking.lblEmpfaengerName, "center")
	OnlineBanking.editEmpfaengerName = guiCreateEdit(0.07, 0.20, 0.87, 0.05, "", true, OnlineBanking.imgMain)
	guiSetAlpha(OnlineBanking.editEmpfaengerName, 0)
	-- lblAbsenderBIC
	OnlineBanking.lblAbsenderBIC = guiCreateLabel(0.49, 0.06, 0.29, 0.08, "RZSTAT2G377", true, OnlineBanking.imgMain)
	guiLabelSetColor(OnlineBanking.lblAbsenderBIC, 0, 0, 0)
	guiLabelSetVerticalAlign(OnlineBanking.lblAbsenderBIC, "center")
	local lblFontTwo = guiCreateFont("FILES/FONTS/taho.ttf", fontSizeTwo)
	guiSetFont(OnlineBanking.lblAbsenderBIC, lblFontTwo)
	-- lblEmpfaengerIBAN
	OnlineBanking.lblEmpfaengerIBAN = guiCreateLabel(0.08, 0.27, 0.87, 0.05, "SA47 3837 7000 0008 5498", true, OnlineBanking.imgMain)
	guiLabelSetColor(OnlineBanking.lblEmpfaengerIBAN, 0, 0, 0)
	guiLabelSetVerticalAlign(OnlineBanking.lblEmpfaengerIBAN, "center")
	local lblFontTwo = guiCreateFont("FILES/FONTS/taho.ttf", fontSizeTwo)
	guiSetFont(OnlineBanking.lblEmpfaengerIBAN, lblFontTwo)
	-- lblEmpfaengerBIC
	OnlineBanking.lblEmpfaengerBIC = guiCreateLabel(0.08, 0.35, 0.35, 0.05, "RZSTAT2G377", true, OnlineBanking.imgMain)
	guiLabelSetColor(OnlineBanking.lblEmpfaengerBIC, 0, 0, 0)
	guiLabelSetVerticalAlign(OnlineBanking.lblEmpfaengerBIC, "center")
	local lblFontTwo = guiCreateFont("FILES/FONTS/taho.ttf", fontSizeTwo)
	guiSetFont(OnlineBanking.lblEmpfaengerBIC, lblFontTwo)
	-- editSumme
	OnlineBanking.lblSumme = guiCreateLabel(0.58, 0.43, 0.38, 0.06, "", true, OnlineBanking.imgMain)
	guiLabelSetColor(OnlineBanking.lblSumme, 0, 0, 0)
	guiLabelSetVerticalAlign(OnlineBanking.lblSumme, "center")
	OnlineBanking.editSumme = guiCreateEdit(0.57, 0.43, 0.38, 0.06, "", true, OnlineBanking.imgMain)
	guiSetAlpha(OnlineBanking.editSumme, 0.00)
	-- lblAbsenderName
	OnlineBanking.lblAbsenderName = guiCreateLabel(0.08, 0.67, 0.87, 0.05, getPlayerName(getLocalPlayer()), true, OnlineBanking.imgMain)
	guiLabelSetColor(OnlineBanking.lblAbsenderName, 0, 0, 0)
	guiLabelSetVerticalAlign(OnlineBanking.lblAbsenderName, "center")
	-- lblEditVerwendungszweck
	OnlineBanking.lblVerwendungszweck = guiCreateLabel(0.08, 0.51, 0.87, 0.06, "", true, OnlineBanking.imgMain)
	guiLabelSetColor(OnlineBanking.lblVerwendungszweck, 0, 0, 0)
	guiLabelSetVerticalAlign(OnlineBanking.lblVerwendungszweck, "center")
	OnlineBanking.editVerwendungszweck = guiCreateEdit(0.07, 0.51, 0.87, 0.06, "", true, OnlineBanking.imgMain)
	guiSetAlpha(OnlineBanking.editVerwendungszweck, 0.00)
	-- lblAbsenderIBAN
	OnlineBanking.lblAbsenderIBAN = guiCreateLabel(0.08, 0.73, 0.71, 0.05, "SA11    9137    1195     9117    5007", true, OnlineBanking.imgMain)
	guiLabelSetColor(OnlineBanking.lblAbsenderIBAN, 0, 0, 0)
	guiLabelSetVerticalAlign(OnlineBanking.lblAbsenderIBAN, "center")
	local lblFontTwo = guiCreateFont("FILES/FONTS/taho.ttf", fontSizeTwo)
	guiSetFont(OnlineBanking.lblAbsenderIBAN, lblFontTwo)
	-- lblDatum
	OnlineBanking.lblDatum = guiCreateLabel(0.08, 0.84, 0.22, 0.10, "01.01.1900", true, OnlineBanking.imgMain)
	guiLabelSetColor(OnlineBanking.lblDatum, 0, 0, 0)
	guiLabelSetHorizontalAlign(OnlineBanking.lblDatum, "center", false)
	guiLabelSetVerticalAlign(OnlineBanking.lblDatum, "center")
	local lblFontTwo = guiCreateFont("FILES/FONTS/taho.ttf", fontSizeTwo)
	guiSetFont(OnlineBanking.lblDatum, lblFontTwo)
end

function OnlineBanking_Hauptmenue()
	-- frmMain
	OnlineBanking.frmMain = guiCreateWindow(0.35, 0.16, 0.30, 0.70, "", true)
	guiWindowSetSizable(OnlineBanking.frmMain, false)
	guiSetAlpha(OnlineBanking.frmMain, 1.00)
	guiSetVisible(OnlineBanking.frmMain, false)
	table.insert(allGuis, OnlineBanking.frmMain)
	-- imgMain
	OnlineBanking.imgMain = guiCreateStaticImage(0.02, 0.03, 0.97, 0.96, "FILES/IMAGES/lapptapp/obFrmMain.png", true, OnlineBanking.frmMain)
	-- btnUeberweisung
	OnlineBanking.btnUeberweisung = guiCreateButton(0.08, 0.21, 0.55, 0.10, "", true, OnlineBanking.imgMain)
	guiSetAlpha(OnlineBanking.btnUeberweisung, 0.00)
	addEventHandler("onClientGUIClick", OnlineBanking.btnUeberweisung, OnlineBanking_ButtonClick, true, "normal")
	-- btnSpenden
	OnlineBanking.btnSpenden = guiCreateButton(0.08, 0.37, 0.54, 0.11, "", true, OnlineBanking.imgMain)
	guiSetAlpha(OnlineBanking.btnSpenden, 0.00)
	addEventHandler("onClientGUIClick", OnlineBanking.btnSpenden, OnlineBanking_ButtonClick, true, "normal")
	-- btnSchliessen
	OnlineBanking.btnSchliessen = guiCreateButton(0.90, 0.01, 0.09, 0.06, "", true, OnlineBanking.imgMain)
	guiSetAlpha(OnlineBanking.btnSchliessen, 0.00)
	addEventHandler("onClientGUIClick", OnlineBanking.btnSchliessen, OnlineBanking_ButtonClick, true, "normal")
	-- lblBargeldText
	OnlineBanking.lblBargeldText = guiCreateLabel(0.03, 0.63, 0.35, 0.06, "Bargeld:", true, OnlineBanking.imgMain)
	local lblFont = guiCreateFont("FILES/FONTS/taho.ttf", fontSize)
	guiSetFont(OnlineBanking.lblBargeldText, lblFont)
	guiSetProperty(OnlineBanking.lblBargeldText, "Size", "w:0.353357 h:0.055325")
	guiLabelSetVerticalAlign(OnlineBanking.lblBargeldText, "center")
	-- lblKontostandText
	OnlineBanking.lblKontostandText = guiCreateLabel(0.03, 0.69, 0.25, 0.06, "Kontostand:", true, OnlineBanking.imgMain)
	guiSetFont(OnlineBanking.lblKontostandText, lblFont)
	guiLabelSetVerticalAlign(OnlineBanking.lblKontostandText, "center")
	-- lblSpendenText
	OnlineBanking.lblSpendenText = guiCreateLabel(0.03, 0.75, 0.30, 0.06, "Spenden:", true, OnlineBanking.imgMain)
	guiSetFont(OnlineBanking.lblSpendenText, lblFont)
	guiLabelSetVerticalAlign(OnlineBanking.lblSpendenText, "center")
	-- lblBargeldStand
	OnlineBanking.lblBargeldStand = guiCreateLabel(0.33, 0.63, 0.40, 0.06, "$ 000.000.000,00", true, OnlineBanking.imgMain)
	guiSetFont(OnlineBanking.lblBargeldStand, lblFont)
	guiLabelSetHorizontalAlign(OnlineBanking.lblBargeldStand, "right", false)
	guiLabelSetVerticalAlign(OnlineBanking.lblBargeldStand, "center")
	-- lblKontostandStand
	OnlineBanking.lblKontostandStand = guiCreateLabel(0.33, 0.69, 0.40, 0.06, "$ 000.000.000,00", true, OnlineBanking.imgMain)
	guiSetFont(OnlineBanking.lblKontostandStand, lblFont)
	guiLabelSetHorizontalAlign(OnlineBanking.lblKontostandStand, "right", false)
	guiLabelSetVerticalAlign(OnlineBanking.lblKontostandStand, "center")
	-- lblSpendenStand
	OnlineBanking.lblSpendenStand = guiCreateLabel(0.33, 0.75, 0.40, 0.06, "$ 000.000.000,00", true, OnlineBanking.imgMain)
	guiSetFont(OnlineBanking.lblSpendenStand, lblFont)
	guiLabelSetHorizontalAlign(OnlineBanking.lblSpendenStand, "right", false)
	guiLabelSetVerticalAlign(OnlineBanking.lblSpendenStand, "center")
	-- Erstmaliges Initialisieren der Stände
	OnlineBanking_CalculateStats()
end

function OnlineBanking_Initialize() -- frmMain Initialisieren
	OnlineBanking = {}
	OnlineBanking_Hauptmenue()
	OnlineBanking_Ueberweisung()
	OnlineBanking_TAN()
end

function OnlineBanking_ToggleShow() -- Anzeige Wechseln
	if (OnlineBanking == nil) then
		OnlineBanking_Initialize()
		OnlineBanking.timerCalculate = setTimer(OnlineBanking_CalculateStats, 1000, 0)
		guiSetVisible(OnlineBanking.frmMain, true)
		showCursor(true)
	else
		if (guiGetVisible(OnlineBanking.frmMain) or guiGetVisible(OnlineBanking.frmUeberweisung) or guiGetVisible(OnlineBanking.frmTAN)) then -- or Spenden
			guiSetVisible(OnlineBanking.frmMain, false)
			guiSetVisible(OnlineBanking.frmUeberweisung, false)
			guiSetVisible(OnlineBanking.frmTAN, false)
			-- guiSetText(lblTanCode, "")
			killTimer(OnlineBanking.timerCalculate)
--			showCursor(false)
		else
			guiSetVisible(OnlineBanking.frmMain, true)
			OnlineBanking.timerCalculate = setTimer(OnlineBanking_CalculateStats, 1000, 0)
			showCursor(true)
		end
	end
end
-- addCommandHandler("ob", OnlineBanking_ToggleShow)








