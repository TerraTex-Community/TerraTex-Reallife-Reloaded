local taxiZielPosX=false
local taxiZielPosY=false
local taxiZielPosZ=false

addEventHandler("onClientResourceStart",resourceRoot,
    function()
        taxiShowGUI_Window = {}
        taxiShowGUI_Button = {}
        taxiShowGUI_Label = {}
        taxiShowGUI_Image = {}

        taxiShowGUI_Window[1] = guiCreateWindow(576,280,681,543,"taxiShow",false)
        taxiShowGUI_Image[1] = guiCreateStaticImage(13,27,500,500,"FILES/IMAGES/radar.jpg",false,taxiShowGUI_Window[1])
        taxiShowGUI_Button[1] = guiCreateButton(529,149,136,28,"Dem Taxifahrer übermitteln!",false,taxiShowGUI_Window[1])
        taxiShowGUI_Label[1] = guiCreateLabel(528,36,140,100,"Um eine Zielposition zu übermitteln, einfach einen Punkt auf der Karte anklicken und auf 'Dem Taxifahrer übermitteln' klicken!",false,taxiShowGUI_Window[1])
        guiLabelSetHorizontalAlign(taxiShowGUI_Label[1],"left",true)
        taxiShowGUI_Button[2] = guiCreateButton(529,184,136,28,"GUI schließen!",false,taxiShowGUI_Window[1])
        taxiShowGUI_Image[2] = guiCreateStaticImage(532,258,16,16,"FILES/IMAGES/ziel.png",false,taxiShowGUI_Window[1])
        taxiShowGUI_Label[2] = guiCreateLabel(563,258,104,26,"gesetzter Zielpunkt",false,taxiShowGUI_Window[1])
		guiSetVisible(taxiShowGUI_Window[1],false)
		
		addEventHandler ( "onClientGUIClick", taxiShowGUI_Button[2], closetaxiShowGUITapp,false)	
		addEventHandler ( "onClientGUIClick", taxiShowGUI_Button[1], sendentaxiShow,false)	
		
		addEventHandler ( "onClientGUIClick", taxiShowGUI_Image[1], starttaxiShowGUI,false)		
    end
)
local wasShowTaxiSendetInLastTime=false

function sendentaxiShow()
	if(not(wasShowTaxiSendetInLastTime))then
		triggerServerEvent("showTaxiZiel_Event",getLocalPlayer(),taxiZielPosX,taxiZielPosY,taxiZielPosZ)
		wasShowTaxiSendetInLastTime=true
		setTimer(wasShowTaxiSendetInLastTime_reset,10000,1)
	else
		outputChatBox("Du hast in den letzten 10 Sekunden deinen Zielort bereits gezeigt!")
	end
end

function wasShowTaxiSendetInLastTime_reset()
	wasShowTaxiSendetInLastTime=false
end
local lastTaxiZiel=false

function starttaxiShowGUI(button, state, absoluteX, absoluteY)
	
	if(button=="left")then
	local absx,absy=guiGetPosition(taxiShowGUI_Window[1],false)
	local absxb,absyb=guiGetPosition(taxiShowGUI_Image[1],false)
		
	absoluteX=absoluteX-(absxb+absx)
	absoluteY=absoluteY-(absyb+absy)
	--outputChatBox((absxb+absx).." "..(absyb+absy))
	if isElement(lastTaxiZiel)then
		destroyElement(lastTaxiZiel)
	end
	local x=absoluteX/500*6000-3000
		local y=absoluteY/500*6000-3000	
		local copyx,copyy=x,-y
    y=-y
    x,y,z=findNodeClosestToPoint_client(vehicleNodes_client, x,y,0)
	lastTaxiZiel=guiCreateStaticImage((absoluteX-8)+absxb,(absoluteY-8)+absyb,16,16,"FILES/IMAGES/ziel.png",false,taxiShowGUI_Window[1])
		taxiZielPosX=x
		taxiZielPosY=y
		taxiZielPosZ=z
	end
end
function closetaxiShowGUITapp()
guiSetVisible(taxiShowGUI_Window[1],false)
end

function showtaxishowGUI()
	guiSetVisible(taxiShowGUI_Window[1],true)
	showCursor(true)
end
addCommandHandler("showtaxi",showtaxishowGUI,false,false)
addCommandHandler("staxi",showtaxishowGUI,false,false)








