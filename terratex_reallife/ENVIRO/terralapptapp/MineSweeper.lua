local myRootElement = getResourceRootElement(getThisResource())
local myGameField = {}
local frmMain, btnStartNewGame, btnCloseGame, lblRestBombsDesc, lblRestBombsVal
local lblNeededTimeDesc, lblNeededTimeVal, frmPanelNewGame, frmGameField, frmSelectCustomSettings
local btnEasy, btnMiddle, btnHeavy, btnCutom, txbLines, btnOK, myTimer, txbColumns, txbBombs
local canCheck = false
local canGo = false
local checktxbLines = true
local checktxbColumns = true
local checktxbBombs = true
local myTicks = 0
local myFieldsX = 0
local myFieldsY = 0
local myBombs = 0

local function CenterWindow(center_window)
    local screenW,screenH=guiGetScreenSize()
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end

local function SetfrmMainStandardSize()
	if (frmMain) then
		guiSetSize(frmMain, 450, 70, false)
		CenterWindow(frmMain)
	end
	if (frmPanelNewGame) then
		guiSetVisible(frmPanelNewGame, false)
	end
	if (frmGameField) then
		guiSetVisible(frmGameField, false)
	end
	if (btnStartNewGame) then
		guiSetEnabled(btnStartNewGame, true)
	end
	if (frmSelectCustomSettings) then
		guiSetVisible(frmSelectCustomSettings, false)
	end
end

local function WinGame()
	killTimer(myTimer)
	myGameField = {}
end

local function CheckWinGame()
	if (tonumber(guiGetText(lblRestBombsVal)) == 0) then
		local dummyOpen = false
		for k, v in ipairs(myGameField) do
			if(not v.IsOpen and not v.IsBomb) then
				dummyOpen = true
			end
		end
		if (not dummyOpen) then
			outputChatBox("Herzlichen Glückwunsch, Sie haben Gewonnen")
			WinGame()
		end
	end
end

local function CheckNearEmptyFields(bID, recursive)
	-- Oben
	if((bID - myFieldsX) > 0) then
		dummyButton = myGameField[(bID - myFieldsX)]
		if (dummyButton) then
			if (not (dummyButton.IsBomb)) then
				if (not dummyButton.IsOpen) then
					dummyButton.IsOpen = true
					guiSetEnabled(dummyButton.Button, false)
					if (dummyButton.NearBombs == 0) then
						CheckNearEmptyFields(dummyButton.ID, true)
					else
						if (dummyButton.NearBombs > 0) then
							guiSetText(dummyButton.Button, dummyButton.NearBombs)
						else
							guiSetText(dummyButton.Button, " ")
						end
					end
				end
			end
		end
	end
	-- Links		
	if((bID - 1) > 0) then
		if (myGameField[(bID - 1)].X ~= myFieldsX) then
			dummyButton = myGameField[(bID - 1)]
			if (dummyButton) then
				if (not (dummyButton.IsBomb)) then
					if (not dummyButton.IsOpen) then
						dummyButton.IsOpen = true
						guiSetEnabled(dummyButton.Button, false)
						if (dummyButton.NearBombs == 0 and dummyButton.X > 1) then
							CheckNearEmptyFields(dummyButton.ID)
						else
							if (dummyButton.NearBombs > 0) then
								guiSetText(dummyButton.Button, dummyButton.NearBombs)
							else
								guiSetText(dummyButton.Button, " ")
							end
						end
					end
				end
			end
		end
	end
	-- Rechts
	if((bID + 1) <= (myFieldsX * myFieldsY)) then
		if (myGameField[(bID + 1)].X ~= 1) then
			dummyButton = myGameField[(bID + 1)]
			if (dummyButton) then
				if (not (dummyButton.IsBomb)) then
					if (not dummyButton.IsOpen) then
						dummyButton.IsOpen = true
						guiSetEnabled(dummyButton.Button, false)
						if (dummyButton.NearBombs == 0) then
							CheckNearEmptyFields(dummyButton.ID)
						else
							if (dummyButton.NearBombs > 0) then
								guiSetText(dummyButton.Button, dummyButton.NearBombs)
							else
								guiSetText(dummyButton.Button, " ")
							end
						end
					end
				end
			end
		end
	end
	-- Unten
	if((bID + myFieldsX) <= (myFieldsX * myFieldsY)) then
		dummyButton = myGameField[(bID + myFieldsX)]
		if (dummyButton) then
			if (not (dummyButton.IsBomb)) then
				if (not dummyButton.IsOpen) then
					dummyButton.IsOpen = true
					guiSetEnabled(dummyButton.Button, false)
					if (dummyButton.NearBombs == 0) then
						CheckNearEmptyFields(dummyButton.ID)
					else
						if (dummyButton.NearBombs > 0) then
							guiSetText(dummyButton.Button, dummyButton.NearBombs)
						else
							guiSetText(dummyButton.Button, " ")
						end
					end
				end
			end
		end
	end
end

local function CheckNearBombs(bID)
	local x = myGameField[bID].X
	local y = myGameField[bID].Y
	local dummyBomb = 0
	-- Links oberhalb
	if ((bID - (myFieldsX + 1) > 0) and (myGameField[bID].X > 1) and (myGameField[(bID - (myFieldsX + 1))].IsBomb)) then
		dummyBomb = dummyBomb + 1
	end
	-- oberhalb
	if ((bID - (myFieldsX + 0) > 0) and (myGameField[(bID - (myFieldsX + 0))].IsBomb)) then
		dummyBomb = dummyBomb + 1
	end
	-- rechts oberhalb
	if ((bID - (myFieldsX-1) > 0) and (myGameField[bID].X < myFieldsX) and (myGameField[(bID-(myFieldsX - 1))].IsBomb)) then
		dummyBomb = dummyBomb + 1
	end
	-- links
	if (((bID - 1) > 0) and ((bID - 1) <= (myFieldsX * myFieldsY)) and (myGameField[bID].X > 1) and myGameField[(bID - 1)].IsBomb) then
		dummyBomb = dummyBomb + 1
	end
	-- rechts
	if (((bID + 1) > 0) and ((bID + 1) <= (myFieldsX * myFieldsY)) and (myGameField[bID].X < myFieldsX) and myGameField[(bID + 1)].IsBomb) then
		dummyBomb = dummyBomb + 1
	end
	-- links unterhalb
	if (((bID +(myFieldsX - 1)) > 0) and ((bID+(myFieldsX - 1)) <= (myFieldsX * myFieldsY)) and (myGameField[bID].X > 1) and (myGameField[(bID+(myFieldsX - 1))].IsBomb)) then
		dummyBomb = dummyBomb + 1
	end
	-- unterhalb
	if (((bID + myFieldsX) > 0) and ((bID + myFieldsX) <= (myFieldsX * myFieldsY)) and (myGameField[(bID + myFieldsX)].IsBomb)) then
		dummyBomb = dummyBomb + 1
	end
	-- rechts unterhalb
	if (((bID + (myFieldsX + 1)) > 0) and ((bID + (myFieldsX + 1)) <= (myFieldsX * myFieldsY)) and (myGameField[bID].X < myFieldsX) and (myGameField[(bID + (myFieldsX + 1))].IsBomb)) then
		dummyBomb = dummyBomb + 1
	end
	if (dummyBomb > 0) then
		guiSetText(myGameField[bID].Button, tostring(dummyBomb))
	else
		CheckNearEmptyFields(bID)
	end
end

local function LooseGame(bID)
	outputChatBox("BOOOOOM!!!!\nSie haben das Spiel leider verloren...")
	----- FakeBomb
	-- triggerEvent("fakeBombs", getRootElement())
	----- FakeBomb
	-- killTimer(myTimer)
	for k, v in ipairs(myGameField) do
		local button = v.Button
		guiSetEnabled(button, true)
		removeEventHandler("onClientGUIClick", v.Button, FieldIsClicked, false)
		if(v.IsBomb) then
			guiSetText(button, "B")
		else
			guiSetText(button, "X")
		end
	end
end

local function FieldIsClicked(button)
	if (button == "right") then
		if (guiGetText(source) == " ") then
			if(tonumber(guiGetText(lblRestBombsVal)) > 0) then
				guiSetText(source, "B")
				guiSetText(lblRestBombsVal, tonumber(guiGetText(lblRestBombsVal)) - 1)
				CheckWinGame()
			end
		else
			guiSetText(source, " ")
			guiSetText(lblRestBombsVal, tonumber(guiGetText(lblRestBombsVal)) + 1)
		end
	end
	if (button == "left") then
		local myButton = source
		if (guiGetText(myButton) == " ") then
			guiSetEnabled(myButton, false)
			local bID = tonumber(getElementData(myButton, "ButtonID"))
			myGameField[bID].IsOpen = true
			if (myGameField[bID].IsBomb) then
				outputChatBox("BOOOOOM!!!!\nSie haben das Spiel leider verloren...")
				killTimer(myTimer)
				for k, v in ipairs(myGameField) do
					local button = v.Button
					guiSetEnabled(button, true)
					removeEventHandler("onClientGUIClick", v.Button, FieldIsClicked, false)
					if(v.IsBomb) then
						guiSetText(button, "B")
					else
						guiSetText(button, "X")
					end
				end
			else
				CheckNearBombs(bID)
				CheckWinGame()
			end
		end
	end
end

local function MineSweeper_CreateNewGameField(myFieldsX, myFieldsY)
	SetfrmMainStandardSize()
	local xMain, yMain
	if ((myFieldsX * 30) <= 450) then
		xMain = 450
	else
		xMain = myFieldsX * 30 + 10
	end
	if ((myFieldsY * 30) <= 70) then
		yMain = 70
	else
		yMain = myFieldsY * 30 + 80
	end
	guiSetSize(frmMain, xMain, yMain, false)
	CenterWindow(frmMain)
	frmGameField = guiCreateScrollPane(10, 80, 1, 1, false, frmMain)	
	guiSetSize(frmGameField, 1, 1, true)
	guiSetVisible(frmGameField, true)
	local counter = 1
	for i = 1, myFieldsY, 1 do
		for j = 1, myFieldsX, 1 do
			local x, y
			if (counter == 1) then
				x = 10
				y = 10
			else
				x , y = guiGetPosition(myGameField[counter - 1].Button, false)
				if (myGameField[counter - 1].X == myFieldsX) then
					if (i <= myFieldsY) then
						x = 10
						y = y + 30
					end
				else
					x = x + 30
				end
			end
			myGameField[counter] = {}
			myGameField[counter].ID = counter
			myGameField[counter].IsBomb = false
			myGameField[counter].IsOpen = false
			myGameField[counter].X = j
			myGameField[counter].Y = i
			myGameField[counter].Button = guiCreateButton(x, y, 20, 20, " ", false, frmGameField)
			setElementData(myGameField[counter].Button,"ButtonID",counter)
			guiSetVisible(myGameField[counter].Button, true)
			addEventHandler("onClientGUIClick", myGameField[counter].Button, FieldIsClicked, false)
			counter = counter + 1
		end
	end
	return true
end

local function CreateNewBombs()
	local setBombs = {}
	while (#setBombs < myBombs) do
		local dummyBomb = math.random(1, #myGameField)
		local dummyBool = false
		for k, v in ipairs(setBombs) do
			if (dummyBomb == v) then
				dummyBool = true
			end
		end
		if (dummyBool == false) then
			table.insert(setBombs, dummyBomb)
		end
	end
	for k, v in ipairs(setBombs) do
		myGameField[v].IsBomb = true
	end
	return true
end

local function TimerTick()
	myTicks = myTicks + 1
	local minuten, minText, sekunden, sekText
	if (myTicks >= 60) then		-- Wir haben eine Minutenanzeige
		minuten = math.floor(myTicks / 60)
		minText = minuten
		if (minuten < 10) then
			minText = "00" .. tostring(minuten)
		elseif (minuten < 100) then
			minText = "0" .. tostring(minuten)
		end
		sekunden = myTicks - (minuten * 60)
		sekText = sekunden
		if (sekunden < 10) then
			sekText = "0" .. tostring(sekunden)
		end
		guiSetText(lblNeededTimeVal, minText .. ":" .. sekText)
	else						-- Wir haben nur Sekundenanzeige
		sekText = myTicks
		if (myTicks < 10) then
			sekText = "0" .. tostring(myTicks)
		end
		guiSetText(lblNeededTimeVal, "000:" .. sekText)
	end
end

local function CheckAllFieldsNearBombs(bID)
	local dummyBomb = 0
	-- Links oberhalb
	if ((bID - (myFieldsX + 1) > 0) and (myGameField[bID].X > 1) and (myGameField[(bID - (myFieldsX + 1))].IsBomb)) then
		dummyBomb = dummyBomb + 1
	end
	-- oberhalb
	if ((bID - (myFieldsX + 0) > 0) and (myGameField[(bID - (myFieldsX + 0))].IsBomb)) then
		dummyBomb = dummyBomb + 1
	end
	-- rechts oberhalb
	if ((bID - (myFieldsX-1) > 0) and (myGameField[bID].X < myFieldsX) and (myGameField[(bID-(myFieldsX - 1))].IsBomb)) then
		dummyBomb = dummyBomb + 1
	end
	-- links
	if (((bID - 1) > 0) and ((bID - 1) <= (myFieldsX * myFieldsY)) and (myGameField[bID].X > 1) and myGameField[(bID - 1)].IsBomb) then
		dummyBomb = dummyBomb + 1
	end
	-- rechts
	if (((bID + 1) > 0) and ((bID + 1) <= (myFieldsX * myFieldsY)) and (myGameField[bID].X < myFieldsX) and myGameField[(bID + 1)].IsBomb) then
		dummyBomb = dummyBomb + 1
	end
	-- links unterhalb
	if (((bID +(myFieldsX - 1)) > 0) and ((bID+(myFieldsX - 1)) <= (myFieldsX * myFieldsY)) and (myGameField[bID].X > 1) and (myGameField[(bID+(myFieldsX - 1))].IsBomb)) then
		dummyBomb = dummyBomb + 1
	end
	-- unterhalb
	if (((bID + myFieldsX) > 0) and ((bID + myFieldsX) <= (myFieldsX * myFieldsY)) and (myGameField[(bID + myFieldsX)].IsBomb)) then
		dummyBomb = dummyBomb + 1
	end
	-- rechts unterhalb
	if (((bID + (myFieldsX + 1)) > 0) and ((bID + (myFieldsX + 1)) <= (myFieldsX * myFieldsY)) and (myGameField[bID].X < myFieldsX) and (myGameField[(bID + (myFieldsX + 1))].IsBomb)) then
		dummyBomb = dummyBomb + 1
	end
	return dummyBomb
end

local function CheckAllFields()
	-- Alle Felder durchgehen und die Bomben auslesen und in myGameField[ID].NearBombs schreiben
	for k, v in ipairs(myGameField) do
		v.NearBombs = CheckAllFieldsNearBombs(k) -- Funktion ist noch nicht richtig, da sie schriebt und nicht zuruecklifert
	end
	return true
end

local function CheckCustomSettings()
	if (guiGetText(txbLines) ~= "") then
		if (tonumber(guiGetText(txbLines)) <= 2 or (tonumber(guiGetText(txbLines)) > 50)) then
			outputChatBox("Fehler: Es muss mindestens 3 und maximal 50 Zeilen gewählt werden.")
			checktxbLines = false
		else
			checktxbLines = true
		end
	else
		checktxbLines = false
	end
	if (guiGetText(txbColumns) ~= "") then
		if (tonumber(guiGetText(txbColumns)) <= 2 or (tonumber(guiGetText(txbColumns)) > 50)) then
			outputChatBox("Fehler: Es muss mindestens 3 und maximal 50 Spalten gewählt werden.")
			checktxbColumns = false
		else
			checktxbColumns = true
		end
	else
		checktxbColumns = false
	end
	if (guiGetText(txbBombs) ~= "") then
		if ((tonumber(guiGetText(txbBombs)) <= 0) or (tonumber(guiGetText(txbBombs)) > (tonumber(guiGetText(txbColumns)) * tonumber(guiGetText(txbLines))))) then
			outputChatBox("Fehler: Es muss mindestens 1 Bombe gewählt werden.")
			checktxbBombs = false
		else
			checktxbBombs = true
		end
	else
		checktxbBombs = false
	end
	if (checktxbLines and checktxbColumns and checktxbBombs) then
		canCheck = true
		MineSweeper_CreateNewGame()
	else
		canCheck = false
	end
end

local function SelectCustomSettings()
	SetfrmMainStandardSize()
	guiSetEnabled(btnStartNewGame, false)
	guiSetSize(frmMain, 450, 320, false)
	CenterWindow(frmMain)
	frmSelectCustomSettings = guiCreateScrollPane(10, 80, 1, 1, false, frmMain)
	guiSetSize(frmSelectCustomSettings, 1, 1, true)
	guiSetVisible(frmSelectCustomSettings, true)
	guiSetText(btnCloseGame, "Abbrechen")
	guiCreateLabel(10, 0, 300, 40, "Bitte wählen Sie die gewünschten einstellungen:", false, frmSelectCustomSettings)
	guiCreateLabel(10, 30, 100, 20, "Zeilen (max. 50):", false, frmSelectCustomSettings)
	txbLines = guiCreateEdit(120, 30, 100, 20, "", false, frmSelectCustomSettings)
	guiCreateLabel(10, 60, 100, 20, "Spalten (max 50):", false, frmSelectCustomSettings)
	txbColumns = guiCreateEdit(120, 60, 100, 20, "", false, frmSelectCustomSettings)
	guiCreateLabel(10, 90, 100, 20, "Bomben:", false, frmSelectCustomSettings)
	txbBombs = guiCreateEdit(120, 90, 100, 20, "", false, frmSelectCustomSettings)
	guiCreateLabel(10, 120, 300, 40, "Es muss mindestens 1 Bombe mit 3 * 3 Felder sein.\n!! Achtung !! Viele Felder erzeugen Lags", false, frmSelectCustomSettings)
	btnOK = guiCreateButton(10, 170, 100, 50, "OK", false, frmSelectCustomSettings)
	addEventHandler("onClientGUIClick", btnOK, CheckCustomSettings, false)
end

function MineSweeper_CreateNewGame()
	local mySource = guiGetText(source)
	if (mySource) then
		if (canCheck) then
			myFieldsY = math.floor(tonumber(guiGetText(txbLines)))
			myFieldsX = math.floor(tonumber(guiGetText(txbColumns)))
			myBombs = math.floor(tonumber(guiGetText(txbBombs)))
			guiSetVisible(frmSelectCustomSettings, false)
			canGo = true
		elseif (mySource == "Leicht") then
			myFieldsX = 9
			myFieldsY = 9
			myBombs = 10
			canGo = true
		elseif (mySource == "Mittel") then
			myFieldsX = 16
			myFieldsY = 16
			myBombs = 40
			canGo = true
		elseif (mySource == "Schwer") then
			myFieldsX = 30
			myFieldsY = 16
			myBombs = 99
			canGo = true
		else
			SelectCustomSettings()
		end
		if (canGo) then
			if (tonumber(myFieldsX) > 0 and tonumber(myFieldsY) > 0) then
				if (MineSweeper_CreateNewGameField(myFieldsX, myFieldsY)) then
					if (CreateNewBombs()) then
						if (CheckAllFields()) then
							guiSetEnabled(btnStartNewGame, false)
							guiSetText(btnCloseGame, "Spiel beenden")
							guiSetText(lblRestBombsVal, tostring(myBombs))
							canCheck = false
							canGo = false
							myTimer = setTimer(TimerTick, 1000, 0)
						end
					end
				end
			end
		end
	end
end

local function btnStartNewGame_Clicked()
	if (frmMain) then
		guiSetEnabled(btnStartNewGame, false)
		guiSetSize(frmMain, 450, 360, false)
		CenterWindow(frmMain)
		frmPanelNewGame = guiCreateScrollPane(10, 80, 1, 1, false, frmMain)
		guiSetSize(frmPanelNewGame, 1, 1, true)
		guiSetVisible(frmPanelNewGame, true)
		guiSetText(btnCloseGame, "Abbrechen")
		guiCreateLabel(0, 0, 300, 40, "Bitte wählen Sie den gewünschten Schwierigkeitsgrad:", false, frmPanelNewGame)
		btnEasy = guiCreateButton(0, 30, 50, 50, "Leicht", false, frmPanelNewGame)
		guiCreateLabel(80, 30, 300, 40, "\nDie Stufe Leicht hat 9 mal 9 Felder mit 10 Bomben.", false, frmPanelNewGame)
		btnMiddle = guiCreateButton(0, 90, 50, 50, "Mittel", false, frmPanelNewGame)
		guiCreateLabel(80, 90, 300, 40, "\nDie Stufe Mittel hat 16 mal 16 Felder mit 40 Bomben.", false, frmPanelNewGame)
		btnHeavy = guiCreateButton(0, 150, 50, 50, "Schwer", false, frmPanelNewGame)
		guiCreateLabel(80, 150, 300, 40, "\nDie Stufe Schwer hat 30 mal 16 Felder mit 99 Bomben.", false, frmPanelNewGame)
		btnCutom = guiCreateButton(0, 210, 50, 50, "Custom", false, frmPanelNewGame)
		guiCreateLabel(80, 210, 300, 60, "Auf dieser Stufe können Sie die größe und anzahl\nder Bomben selbst bestimmen.", false, frmPanelNewGame)
		addEventHandler("onClientGUIClick", btnEasy, MineSweeper_CreateNewGame, false)
		addEventHandler("onClientGUIClick", btnMiddle, MineSweeper_CreateNewGame, false)
		addEventHandler("onClientGUIClick", btnHeavy, MineSweeper_CreateNewGame, false)
		addEventHandler("onClientGUIClick", btnCutom, MineSweeper_CreateNewGame, false)
	end
end

local function KillTimerAndOrTicks(killTicks)
	
	if (isTimer(myTimer)) then
		killTimer(myTimer)
	end
	
	if (killTicks) then
		myTicks = 0
	end
	
	myGameField = {}
end

local function btnCloseGame_Clicked()
	local myText=guiGetText(source)
	if (myText) then
		if (myText == "Abbrechen") then
			guiSetText(btnCloseGame, "Schließen")
			SetfrmMainStandardSize()
			
		elseif (myText == "Schließen") then
			guiSetText(btnCloseGame, "Schließen")
			SetfrmMainStandardSize()
			
			guiSetVisible(frmMain, false)
		elseif (myText == "Spiel beenden") then
			guiSetText(btnCloseGame, "Schließen")
			SetfrmMainStandardSize()
			KillTimerAndOrTicks(true)
		end
	end
	canCheck = false
end

local function CreateMineSweeperMainFrame()
	frmMain = guiCreateWindow(0, 0, 450, 70, "MineSweeper Version: 1.0", false)
	CenterWindow(frmMain)
	table.insert(allGuis,frmMain)
	btnStartNewGame = guiCreateButton(10, 30, 100, 30, "Neues Spiel", false, frmMain)
	btnCloseGame = guiCreateButton(120, 30, 100, 30, "Schließen", false, frmMain)
	lblRestBombsDesc = guiCreateLabel(230, 30, 100, 30, "Spiel beenden", false, frmMain)
	guiLabelSetHorizontalAlign(lblRestBombsDesc, "center")
	lblRestBombsVal = guiCreateLabel(230, 45, 100, 30, "0", false, frmMain)
	guiLabelSetHorizontalAlign(lblRestBombsVal, "center")
	lblNeededTimeDesc = guiCreateLabel(340, 30, 100, 30, "Verbrauchte Zeit:", false, frmMain)
	guiLabelSetHorizontalAlign(lblNeededTimeDesc, "center")
	lblNeededTimeVal = guiCreateLabel(340, 45, 100, 30, "000:00", false, frmMain)
	guiLabelSetHorizontalAlign(lblNeededTimeVal, "center")
	addEventHandler ( "onClientGUIClick", btnStartNewGame, btnStartNewGame_Clicked, false)
	addEventHandler ( "onClientGUIClick", btnCloseGame, btnCloseGame_Clicked, false)
	guiSetVisible(frmMain, false)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),CreateMineSweeperMainFrame)

function ToggleShowMineSweeper()
	if (guiGetVisible(frmMain)) then
		guiSetVisible(frmMain, false)
	else
		guiSetVisible(frmMain, true)
	end
end
addCommandHandler("MineSweeper", ToggleShowMineSweeper)








