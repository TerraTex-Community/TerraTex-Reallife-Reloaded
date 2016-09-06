function createDialog(dialogTitle, dialogContinueText, dialogShowText, dialogContinueFunction)
	showCursor(true)
	local gui = {}
	gui._placeHolders = {}
	
	local screenWidth, screenHeight = guiGetScreenSize()
	local windowWidth, windowHeight = 393, 172
	local left = screenWidth/2 - windowWidth/2
	local top = screenHeight/2 - windowHeight/2
	gui["_root"] = guiCreateWindow(left, top, windowWidth, windowHeight, dialogTitle, false)
	guiWindowSetSizable(gui["_root"], false)
	table.insert(allGuis,gui["_root"])
	gui["buttonContinue"] = guiCreateButton(10, 115, 373, 31, dialogContinueText, false, gui["_root"])
	if dialogContinueFunction then
		addEventHandler("onClientGUIClick", gui["buttonContinue"], dialogContinueFunction, false)
	end
	addEventHandler("onClientGUIClick", gui["buttonContinue"], closeAskGUI, false)
	
	gui["dialogText"] = guiCreateLabel(10, 25, 371, 80, dialogShowText, false, gui["_root"])
	guiLabelSetHorizontalAlign(gui["dialogText"], "center", false)
	guiLabelSetVerticalAlign(gui["dialogText"], "center")
	
	return gui["buttonContinue"]
end

function closeDialogGUI()
	destroyElement(getElementParent(source))
	showCursor(false)
end
