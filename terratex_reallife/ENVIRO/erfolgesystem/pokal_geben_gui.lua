
local pokalGuis=0
local pokalPosGuis=0
addEvent("onClientCreatePokalGUI",true)

function createPokalGUI_func(PokalName,PokalBeschreibung) 
        PokalGUI_Window = {}
        PokalGUI_Label = {}
        PokalGUI_Image = {}
		local faktor=0
		if(pokalPosGuis<4)then
			faktor=pokalPosGuis*0.1311
		else
			pokalPosGuis=0
		end
        PokalGUI_Window[1] = guiCreateWindow(0.3625,0.8656-faktor,0.2331,0.1311,"Pokal freigeschaltet!",true)
		
        PokalGUI_Image[1] = guiCreateStaticImage(0.0241,0.2288,0.319,0.6949,"FILES/IMAGES/pokal.png",true,PokalGUI_Window[1])
        PokalGUI_Label[1] = guiCreateLabel(0.3861,0.2203,0.1957,0.1356,"Was?:",true,PokalGUI_Window[1])
        PokalGUI_Label[2] = guiCreateLabel(0.3834,0.5,0.1046,0.1356,"Fuer?:",true,PokalGUI_Window[1])
        PokalGUI_Label[3] = guiCreateLabel(0.5013,0.2288,0.4665,0.2881,PokalName,true,PokalGUI_Window[1])
        guiLabelSetHorizontalAlign(PokalGUI_Label[3],"left",true)
        PokalGUI_Label[4] = guiCreateLabel(0.4906,0.5254,0.4826,0.3983,PokalBeschreibung,true,PokalGUI_Window[1])
        guiLabelSetHorizontalAlign(PokalGUI_Label[4],"left",true)
		
		pokalGuis=pokalGuis+1
		pokalPosGuis=pokalPosGuis+1
		playSound( "FILES/SOUNDS/tada.wav")
		triggerServerEvent("give_Pokal_Money",getLocalPlayer())
		setTimer(destroyPokalGui,10000,1,PokalGUI_Window[1])
    end

addEventHandler("onClientCreatePokalGUI",getRootElement(),createPokalGUI_func)



function destroyPokalGui(gui)
	destroyElement(gui)
	pokalGuis=pokalGuis-1
	if(pokalGuis==0)then
		pokalPosGuis=0
	end
end








