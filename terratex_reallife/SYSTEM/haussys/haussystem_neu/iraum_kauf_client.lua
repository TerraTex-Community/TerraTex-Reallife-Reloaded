--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 15.05.14
-- Time: 19:20
-- To change this template use File | Settings | File Templates.
--

local validIraum={}
local lastIR=1
local showText="Daten Innenraum\nInnenraum ID: 12 / 32\nPreis: 1.000.000 $\nQM: 1.000 qm\nStockwerke: 2\nAusstattung: heruntergekommen";
local isInMoebel=false

local Iraumkauf = {
    button = {},
    window = {},
    edit = {},
    label = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        local screenW, screenH = guiGetScreenSize()
        Iraumkauf.window[1] = guiCreateWindow(10, (screenH - 199) / 2 + 160, 407, 199, "Möbelshop", false)
        guiWindowSetSizable(Iraumkauf.window[1], false)

        table.insert(allGuis,Iraumkauf.window[1])

        Iraumkauf.label[1] = guiCreateLabel(18, 24, 181, 48, "Werte alter Innenraum:\nQM: 600\nPreis: 1.000.000$", false, Iraumkauf.window[1])
        Iraumkauf.button[1] = guiCreateButton(18, 72, 181, 25, "Alten Innenraum verkaufen", false, Iraumkauf.window[1])
        guiSetProperty(Iraumkauf.button[1], "NormalTextColour", "FFAAAAAA")
        Iraumkauf.button[2] = guiCreateButton(18, 97, 181, 25, "vorherigen IRaum anzeigen", false, Iraumkauf.window[1])
        guiSetProperty(Iraumkauf.button[2], "NormalTextColour", "FFAAAAAA")
        Iraumkauf.button[3] = guiCreateButton(209, 97, 181, 25, "nächsten IRaum anzeigen", false, Iraumkauf.window[1])
        guiSetProperty(Iraumkauf.button[3], "NormalTextColour", "FFAAAAAA")
        Iraumkauf.button[4] = guiCreateButton(209, 72, 181, 25, "neuen IRaum kaufen", false, Iraumkauf.window[1])
        guiSetProperty(Iraumkauf.button[4], "NormalTextColour", "FFAAAAAA")
        Iraumkauf.button[5] = guiCreateButton(18, 162, 372, 25, "Möbelhaus verlassen", false, Iraumkauf.window[1])
        guiSetProperty(Iraumkauf.button[5], "NormalTextColour", "FFAAAAAA")
        Iraumkauf.label[2] = guiCreateLabel(209, 24, 181, 48, "Werte neuer Innenraum:\nQM: 600\nPreis: 1.000.000$", false, Iraumkauf.window[1])
        Iraumkauf.label[3] = guiCreateLabel(18, 132, 110, 20, "Innenraum mit ID", false, Iraumkauf.window[1])
        Iraumkauf.edit[1] = guiCreateEdit(126, 127, 63, 25, "", false, Iraumkauf.window[1])
        Iraumkauf.button[6] = guiCreateButton(196, 127, 163, 25, "Anzeigen", false, Iraumkauf.window[1])
        guiSetProperty(Iraumkauf.button[6], "NormalTextColour", "FFAAAAAA")

        addEventHandler ( "onClientGUIClick", Iraumkauf.button[5], quitMoebel, false )
        addEventHandler ( "onClientGUIClick", Iraumkauf.button[6], gotoIR, false )

        addEventHandler ( "onClientGUIClick", Iraumkauf.button[2], showPreviousIR, false )
        addEventHandler ( "onClientGUIClick", Iraumkauf.button[3], showNextIR, false )

        addEventHandler ( "onClientGUIClick", Iraumkauf.button[1], sellOldIR, false )
        addEventHandler ( "onClientGUIClick", Iraumkauf.button[4], buyNewIR, false )

        guiSetVisible(Iraumkauf.window[1],false)
        isInMoebel=false
    end
)
function sellOldIR()
    triggerServerEvent("sellOldIR_event",getLocalPlayer())
    local textOldIR="Werte alter Innenraum:\nQM: \nPreis: "
    guiSetText(Iraumkauf.label[1],textOldIR)
end

function buyNewIR()
    triggerServerEvent("buyNewIR_event",getLocalPlayer(),validIraum[lastIR]["ID"])
    local textOldIR="Werte alter Innenraum:\nQM: \nPreis: "
    guiSetText(Iraumkauf.label[1],textOldIR)
end

addEvent("syncNewIR_event",true)
function syncNewIR(newID)
    local textOldIR=string.format("Werte alter Innenraum:\nQM: %s\nVerkaufspreis: %s",validIraum[newID]["qm"],toprice(validIraum[newID]["preis"]*0.65))
    guiSetText(Iraumkauf.label[1],textOldIR)
end
addEventHandler("syncNewIR_event",getRootElement(),syncNewIR)

addEventHandler("onClientRender", root,
    function()
        if(isInMoebel)then
            local screenW, screenH = guiGetScreenSize()
            dxDrawRectangle(30, (screenH - 130) / 2, 332, 130, tocolor(9, 9, 9, 241), false)
            dxDrawText(showText, 50, (screenH - 110) / 2, (50) + 312, ( (screenH - 110) / 2) + 110, tocolor(255, 255, 255, 255), 1.00, "arial", "left", "center", false, true, false, false, false)
        end
    end
)

addEvent("recieveValidIraum",true)
function recieveValidIraum_func(iraeume,aktualIRID)

    --Leider kein Zugriff via Classe möglich -> Klasse wird wie table behandelt

    validIraum=iraeume
    local indexOfAktualIR=1
    if(aktualIRID>0)then
       for theKey, theIR in ipairs(validIraum)do
          if(theIR["ID"]==aktualIRID)then
             indexOfAktualIR=theKey
          end
       end
    end

    lastIR=indexOfAktualIR
    local textOldIR="Werte alter Innenraum:\nQM: \nPreis: "
    if(aktualIRID>0)then
        textOldIR=string.format("Werte alter Innenraum:\nQM: %s\nVerkaufspreis: %s",validIraum[indexOfAktualIR]["qm"],toprice(validIraum[indexOfAktualIR]["preis"]*0.65))
    end
    guiSetText(Iraumkauf.label[1],textOldIR)

    if(lastIR==0)then lastIR=1 end


    showIR(lastIR)


    guiSetVisible(Iraumkauf.window[1],true)
    isInMoebel=true



end
addEventHandler("recieveValidIraum",getRootElement(),recieveValidIraum_func)

function gotoIR()
    local txt=guiGetText(Iraumkauf.edit[1])
    if(tonumber(txt))then
        txt=tonumber(txt)
        local isID=false
        local newKey=1
        for theKey, theIR in ipairs(validIraum)do
            if(theIR["ID"]==txt)then
                isID=true
                newKey=theKey
            end
        end

        if(isID)then
            showIR(newKey)
        else
            showError(getLocalPlayer(),"Die von dir angegebene ID ist nicht für dein Haus geeignet!")
        end
    else
        showError(getLocalPlayer(),"ungültige InnenraumID")
    end
end

function showPreviousIR()
    lastIR=lastIR-1
    if(lastIR==0)then
        lastIR=table.getSize(validIraum)-1
    end
    showIR(lastIR)
end
function showNextIR()
    lastIR=lastIR+1
    if(lastIR>=table.getSize(validIraum))then
        lastIR=1
    end
    showIR(lastIR)
end

function showIR(id)

    local textNewIR=string.format("Werte neuer Innenraum:\nQM: %s\nKaufpreis: %s",validIraum[id]["qm"],toprice(validIraum[id]["preis"]))
    guiSetText(Iraumkauf.label[2],textNewIR )

    showText="Daten Innenraum\nInnenraum ID: %s \nPreis: %s\nQM: %s qm\nStockwerke: %s\nAusstattung: %s";
    local ausstattung="heruntergekommenden"
    if( validIraum[id]["wert"] == 1)then
        ausstattung="guten"
    elseif(validIraum[id]["wert"] == 2)then
        ausstattung="luxuriösen"
    end

    showText=string.format(showText,validIraum[id]["ID"],toprice(validIraum[id]["preis"]),validIraum[id]["qm"],validIraum[id]["stockwerke"],ausstattung)

    lastIR=id
    setElementInterior(getLocalPlayer(),validIraum[id]["int"])
    setElementDimension(getLocalPlayer(),-1)
    setElementPosition(getLocalPlayer(),validIraum[id]["coord"][1],validIraum[id]["coord"][2],validIraum[id]["coord"][3])
end


function quitMoebel()
    setElementInterior(getLocalPlayer(),0)
    setElementDimension(getLocalPlayer(),0)
    setElementPosition(getLocalPlayer(),967.048828125,2153.7392578125,10.8203125)
    guiSetVisible(Iraumkauf.window[1],false)
    isInMoebel=false
    triggerServerEvent("leaveMoebel_event",getLocalPlayer())
end








