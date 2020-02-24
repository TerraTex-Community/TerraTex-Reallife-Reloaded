local barBot = {}
local stripperBot = {}
local stripperSkinID = {63,87,92,138,140,139,152,178,237,238,246,244,245,256}

function barBots()
	respawnBarBots()
    respawnStripperBots()
	
	setPedDancingQueen()
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),barBots)

function respawnBarBots()
	for _, theBot in pairs(barBot) do
        if (isElement(theBot)) then
            destroyElement(theBot)
        end
    end
    
	--Bar Frauen
	barBot[1]=createPed(11,501.8388671875,-19.0673828125,1000.671875,89.916229248047)--alhambra
	setElementInterior(barBot[1],17)
	addEventHandler("onPedWasted",barBot[1],respawnBarBots)
	
	barBot[2]=createPed(11,499.775390625,-77.802734375,998.7578125,354.44357299805)--green bottels
	setElementInterior(barBot[2],11)
	addEventHandler("onPedWasted",barBot[2],respawnBarBots)
	
	barBot[3]=createPed(11,1214.1318359375,-15.2646484375,1000.921875,353.83383178711)--gPigPen
	setElementInterior(barBot[3],2)
	addEventHandler("onPedWasted",barBot[3],respawnBarBots)
    
    barBot[4]=createPed(11,1761.8193359375,-1921.47265625,16.2,0)--Marktplatz am Rookiespawn
	addEventHandler("onPedWasted",barBot[4],respawnBarBots)
    
    for _, theBot in pairs(stripperBot) do
        setElementFrozen(theBot, true)
    end
end


function respawnStripperBots()
    for _, theBot in pairs(stripperBot) do
        if (isElement(theBot)) then
            destroyElement(theBot)
        end
    end

	--stripper
	randid=stripperSkinID[math.random(1,table.getn(stripperSkinID))]
	stripperBot[1]=createPed(randid,1208.376953125,-6.9892578125,1001.328125,6.6825256347656)--gPigPen stripper 1
	setElementInterior(stripperBot[1],2)
	addEventHandler("onPedWasted",stripperBot[1],respawnStripperBots)
	
	randid=stripperSkinID[math.random(1,table.getn(stripperSkinID))]
	stripperBot[2]=createPed(randid,1214.048828125,-4.3095703125,1001.328125,50.238494873047)--gPigPen stripper 2
	setElementInterior(stripperBot[2],2)
	addEventHandler("onPedWasted",stripperBot[2],respawnStripperBots)
	
	randid=stripperSkinID[math.random(1,table.getn(stripperSkinID))]
	stripperBot[3]=createPed(randid,1221.134765625,8.7587890625,1001.3356323242,127.63287353516)--gPigPen stripper 3
	setElementInterior(stripperBot[3],2)
	addEventHandler("onPedWasted",stripperBot[3],respawnStripperBots)
	
	randid=stripperSkinID[math.random(1,table.getn(stripperSkinID))]
	stripperBot[4]=createPed(randid,1223.09765625,-2.9375,1001.328125,23.942321777344)--gPigPen stripper 4
	setElementInterior(stripperBot[4],2)
	addEventHandler("onPedWasted",stripperBot[4],respawnStripperBots)
	
	randid=stripperSkinID[math.random(1,table.getn(stripperSkinID))]
	stripperBot[5]=createPed(randid,1223.09765625,-9.8310546875,1001.328125,164.00366210938)--gPigPen stripper 5
	setElementInterior(stripperBot[5],2)
	addEventHandler("onPedWasted",stripperBot[5],respawnStripperBots)
    
    for _, theBot in pairs(stripperBot) do
        setElementFrozen(theBot, true)
    end
end

local dances={"STR_Loop_A","STR_Loop_B","STR_Loop_C","strip_A","strip_B","strip_C","strip_D","strip_E","strip_F","strip_G" }
function setPedDancingQueen()
    for _, theBot in pairs(stripperBot) do
        setPedAnimation(theBot, "STRIP", dances[math.random(1, table.getn(dances))], -1, true, true, false, false)
    end
    
	setTimer(setPedDancingQueen, 5000, 1)
end

function onPlayerClickOnBarTusse(mouseButton, buttonState, clickedElement)
    if (mouseButton == "left" and buttonState == "down") then
        for _, theBot in pairs(barBot) do
            if (clickedElement == theBot) then
                outputChatBox("Hey Süßer! Kauf dir doch was zu trinken mit /drink", source, 135,237,225)
                break
            end
        end
    end
end
addEventHandler("onPlayerClick", getRootElement(), onPlayerClickOnBarTusse)

function drink_func(thePlayer, _, text)
	local px, py, pz = getElementPosition(thePlayer)
    local nextTo = false
    for _, theBot in pairs(barBot) do
        local bx, by, bz = getElementPosition(theBot)
        local dis = getDistanceBetweenPoints3D(bx, by, bz, px, py, pz)
        if (dis < 10) then
            nextTo = true
            break
        end
    end
    if (nextTo) then
        if (not text) then
            text = "lala"
        end
        if (string.lower(text) == "bier") then
            if (getPlayerMoney(thePlayer) > 0.49) then
                triggerClientEvent(thePlayer, "addFood", thePlayer, 20)
                changePlayerMoney(thePlayer, -0.5, "sonstiges", "Einkauf in einer Bar")
                changeBizKasse(9, 0.50, "Einkauf")
                triggerClientEvent(thePlayer, "addAlkohol", thePlayer, 0.4)
                outputChatBox("Du hast ein Bier getrunken!", thePlayer, 135,237,225)
            else
                outputChatBox("Du hast zu wenig Geld süßer!", thePlayer, 135,237,225)
            end	
        elseif (string.lower(text) == "martini") then
            if (getPlayerMoney(thePlayer) > 1.49) then
                triggerClientEvent(thePlayer, "addFood", thePlayer, 30)
                changePlayerMoney(thePlayer, -1.5, "sonstiges", "Einkauf in einer Bar")
                changeBizKasse(9, 1.50, "Einkauf")
                triggerClientEvent(thePlayer, "addAlkohol", thePlayer, 0.3)
                outputChatBox("Du hast ein Martini getrunken!", thePlayer, 135,237,225)
            else
                outputChatBox("Du hast zu wenig Geld süßer!", thePlayer, 135,237,225)
            end	
        
        elseif (string.lower(text) == "wodka") then
            if (getPlayerMoney(thePlayer) > 2.99) then
                triggerClientEvent(thePlayer, "addFood", thePlayer, 60)
                changePlayerMoney(thePlayer, -3, "sonstiges", "Einkauf in einer Bar")
                changeBizKasse(9, 3, "Einkauf")
                triggerClientEvent(thePlayer, "addAlkohol", thePlayer, 0.6)
                outputChatBox("Du hast ein Wodka getrunken!", thePlayer, 135,237,225)
            else
                outputChatBox("Du hast zu wenig Geld süßer!", thePlayer, 135,237,225)
            end	
        elseif (string.lower( text)=="mix") then
            if (getPlayerMoney(thePlayer) > 4.99) then
                triggerClientEvent(thePlayer, "addFood", thePlayer, 100)
                changePlayerMoney(thePlayer, -5, "sonstiges", "Einkauf in einer Bar")
                changeBizKasse(9, 5, "Einkauf")
                triggerClientEvent(thePlayer, "addAlkohol", thePlayer, 0.5)
                outputChatBox("Du hast ein Mixgetränk getrunken!", thePlayer, 135,237,225)
            else
                outputChatBox("Du hast zu wenig Geld süßer!", thePlayer, 135,237,225)
            end	
        else
            outputChatBox("Du kannst folgendes kaufen: Bier(0.50$), Martini(1.50$), Wodka(3.00$), Mix(5.00$)", thePlayer, 135,237,225)
            outputChatBox("Getränk kaufen mit: /drink [Getränkename]", thePlayer, 135,237,225)
        end
    else
        outputChatBox("Du bist bei keiner Bartusse!", thePlayer, 135,237,225)
    end
end
addCommandHandler("drink", drink_func, false, false)

addEvent("setAlkholAnimation_Event", true)
function setPlayerAlkholAnim()
    setPedAnimation(source, "ped", "WALK_drunk", 7000, true, true, false, false)
end
addEventHandler("setAlkholAnimation_Event", getRootElement(), setPlayerAlkholAnim)
