
f1_menu = {
    scrollpane = {},
    button = {},
    window = {},
    label = {},
	functions ={},
	lastOpenGUI=false,
	boundedGuis=0,
	bindedGUIS={}
}

addEventHandler("onClientResourceStart", getRootElement(),
    function()
		local screenW, screenH = guiGetScreenSize()
        f1_menu.window[1] = guiCreateWindow(10, (screenH - 535) / 2, 241, 535, "F1 - Hilfen", false)
		table.insert(allGuis, f1_menu.window[1])
		
        guiWindowSetSizable(f1_menu.window[1], false)

        f1_menu.label[1] = guiCreateLabel(11, 27, 220, 38, "Klicke auf einen der Buttons um die entsprechende Hilfe aufzurufen.", false, f1_menu.window[1])
        guiLabelSetHorizontalAlign(f1_menu.label[1], "left", true)
        f1_menu.scrollpane[1] = guiCreateScrollPane(11, 75, 220, 417, false, f1_menu.window[1])

        --f1_menu.button[1] = guiCreateButton(0, 0, 220, 23, "Example APP", false, f1_menu.scrollpane[1])

        f1_menu.button[2] = guiCreateButton(117, 496, 114, 29, "close", false, f1_menu.window[1])    
		guiSetVisible(f1_menu.window[1],false)
		
		bindKey ( "F1", "down", f1_menu.functions.showF1_menu)
		addEventHandler ( "onClientGUIClick", f1_menu.button[2], f1_menu.functions.closeF1_menu, false )
		
    end
)

function f1_menu.functions.showF1_menu()
	guiSetVisible(f1_menu.window[1],true)
	showCursor(true)
end

function f1_menu.functions.closeF1_menu()	
	if(f1_menu.lastOpenGUI)then
		guiSetVisible(f1_menu.lastOpenGUI,false)
		f1_menu.lastOpenGUI=false
	end
	
	guiSetVisible(f1_menu.window[1],false)
	showCursor(false)
end

function f1_menu.functions.addButton(buttonName,windowElement)	
	local startPoint=24*f1_menu.boundedGuis
	f1_menu.bindedGUIS[f1_menu.boundedGuis+1]=windowElement
	
	f1_menu.button[f1_menu.boundedGuis+1] = guiCreateButton(0, startPoint, 220, 23, buttonName, false, f1_menu.scrollpane[1])
	
	addEventHandler ( "onClientGUIClick", f1_menu.button[f1_menu.boundedGuis+1], 
		function ()     
			
				local foundKey=0
				for theKey, theButton in ipairs (f1_menu.button)do
					if(theButton==source)then
						foundKey=theKey
					end	
				end
				
				if(not(guiGetVisible(f1_menu.bindedGUIS[foundKey])))then
				
					if(f1_menu.lastOpenGUI)then
						guiSetVisible(f1_menu.lastOpenGUI,false)				
					end
					f1_menu.lastOpenGUI=f1_menu.bindedGUIS[foundKey]
					guiSetVisible(f1_menu.bindedGUIS[foundKey],true)	
				else
					guiSetVisible(f1_menu.bindedGUIS[foundKey],false)	
					f1_menu.lastOpenGUI=false
				end
		end, 
	false )
	f1_menu.boundedGuis=f1_menu.boundedGuis+1
end

addEvent("showTutGui_first",true)
function showTutGui_first_func()
	f1_menu.lastOpenGUI=f1_welcome.window[1]
	guiSetVisible(f1_welcome.window[1],true)
	guiSetVisible(f1_menu.window[1],true)
	showCursor(true)
end
addEventHandler("showTutGui_first",getRootElement(),showTutGui_first_func)








