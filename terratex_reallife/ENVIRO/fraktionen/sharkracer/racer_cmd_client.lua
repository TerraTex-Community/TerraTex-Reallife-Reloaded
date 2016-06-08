local RacerZielPosX=false
local RacerZielPosY=false
local RacerZielPosZ=false
local Player = false
local Price = false

addEventHandler("onClientResourceStart",resourceRoot,
    function()
        RacerShowGUI_Window = {}
        RacerShowGUI_Button = {}
        RacerShowGUI_Label = {}
        RacerShowGUI_Image = {}

        RacerShowGUI_Window[1] = guiCreateWindow(576,280,681,543,"RacerShow",false)
        RacerShowGUI_Image[1] = guiCreateStaticImage(13,27,500,500,"FILES/IMAGES/radar.jpg",false,RacerShowGUI_Window[1])
        RacerShowGUI_Button[1] = guiCreateButton(529,149,136,28,"Ziel festlegen!",false,RacerShowGUI_Window[1])
        RacerShowGUI_Label[1] = guiCreateLabel(528,36,140,100,"Um eine Zielposition zu übermitteln, einfach einen Punkt auf der Karte anklicken und auf 'Ziel festlegen' klicken!",false,RacerShowGUI_Window[1])
        guiLabelSetHorizontalAlign(RacerShowGUI_Label[1],"left",true)
        RacerShowGUI_Button[2] = guiCreateButton(529,184,136,28,"GUI schließen!",false,RacerShowGUI_Window[1])
        RacerShowGUI_Image[2] = guiCreateStaticImage(532,258,16,16,"FILES/IMAGES/ziel.png",false,RacerShowGUI_Window[1])
        RacerShowGUI_Label[2] = guiCreateLabel(563,258,104,26,"gesetzter Zielpunkt",false,RacerShowGUI_Window[1])
        guiSetVisible(RacerShowGUI_Window[1],false)

        addEventHandler ( "onClientGUIClick", RacerShowGUI_Button[2], closeRacerShowGUITapp,false)
        addEventHandler ( "onClientGUIClick", RacerShowGUI_Button[1], sendenRacerShow,false)

        addEventHandler ( "onClientGUIClick", RacerShowGUI_Image[1], startRacerShowGUI,false)
    end
)
local wasShowRacerSendetInLastTime=false

function sendenRacerShow()
    outputChatBox("Anfrage beim Spieler wird gestellt....")
    triggerServerEvent("startRace",getLocalPlayer(), Player, Price, {RacerZielPosX,RacerZielPosY,RacerZielPosZ} )
    closeRacerShowGUITapp()
end


function startRacerShowGUI(button, state, absoluteX, absoluteY)

    if(button=="left")then
        local absx,absy=guiGetPosition(RacerShowGUI_Window[1],false)
        local absxb,absyb=guiGetPosition(RacerShowGUI_Image[1],false)

        absoluteX=absoluteX-(absxb+absx)
        absoluteY=absoluteY-(absyb+absy)
        --outputChatBox((absxb+absx).." "..(absyb+absy))
        if isElement(lastRacerZiel)then
            destroyElement(lastRacerZiel)
        end
        local x=absoluteX/500*6000-3000
        local y=absoluteY/500*6000-3000
        local copyx,copyy=x,-y
        y=-y
        x,y,z=findNodeClosestToPoint_client(vehicleNodes_client, x,y,0)

        lastRacerZiel=guiCreateStaticImage((absoluteX-8)+absxb,(absoluteY-8)+absyb,16,16,"FILES/IMAGES/ziel.png",false,RacerShowGUI_Window[1])
        RacerZielPosX=x
        RacerZielPosY=y
        RacerZielPosZ=z
    end
end
function closeRacerShowGUITapp()
    guiSetVisible(RacerShowGUI_Window[1],false)
end

function showRacershowGUI(cmd, name, preis)
    if(getElementData(getLocalPlayer(),"fraktion") == 13)then
        if(name and preis)then
            if(tonumber(preis)>0)then
                local thePlayer = getPlayerFromIncompleteName(name)
                if(thePlayer)then
                    local x,y,z = getElementPosition(getLocalPlayer())
                    local sx,sy,sz = getElementPosition(thePlayer)
                    if(getDistanceBetweenPoints3D(x,y,z,sx,sy,z)<15)then
                        if(tonumber(preis)<250000)then
                            if(getElementData(thePlayer,"money")>=tonumber(preis))then
                                if(isPedInVehicle(thePlayer) and isPedInVehicle(getLocalPlayer()))then
                                    Player = thePlayer
                                    Price = tonumber(preis)
                                    guiSetVisible(RacerShowGUI_Window[1],true)
                                    showCursor(true)
                                else
                                    showError(getLocalPlayer(),"Ihr müsst beide in einem Fahrzeug sitzen.")
                                end
                            else
                                showError(getLocalPlayer(),"Dein Gegner hat nicht genug Geld!")
                            end
                    else
                        showError(getLocalPlayer(),"Der Maximale Renneinsatz darf nur maximal 250000 betragen!")
                        end
                    else
                        showError(getLocalPlayer(), "Der Spieler ist nicht in deiner Nähe")
                    end
                else
                    showError(getLocalPlayer(), "Der Spieler existiert nicht!")
                end
            else
                showError(getLocalPlayer(), "Nutzung: /qr Name Preisgeld")
            end

        else
            showError(getLocalPlayer(), "Nutzung: /qr Name Preisgeld")
        end
    end
end
addCommandHandler("qr",showRacershowGUI,false,false)
addCommandHandler("quickrace",showRacershowGUI,false,false)








