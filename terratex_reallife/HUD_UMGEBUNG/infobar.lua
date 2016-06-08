
local texts={
    "Besuche unser Forum: "..config["maindomain"],
    "Du kannst deine "..config["communityname"].."-Erfahrung inviduell mit F3 einstellen.",
    "Antworten viele auf deine Fragen und weitere Informationen erhälst du mit F1",
    "Wusstest du schon, dass du deine Radiostreams mit F2 in MTA hören kannst?",
    "Besuche unseren Teamspeak3-Server: "..config["teamspeak"],
    "Du hast ein Bug gefunden? Melde ihn im Bugtracker: "..config["bugdomain"],
    "Dieses Script wird entwickelt von "..config["scriptername"],
    "Die Maps werden erstellt von "..config["mappername"]
}
local lastTextID=0

function changeInfoTextBar()
    lastTextID=lastTextID+1
    if(lastTextID>table.getSize(texts))then
        lastTextID=1
    end
    setTimer(changeInfoTextBar,20000,1)
end

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        changeInfoTextBar()
    end
)

addEventHandler("onClientPreRender", root,
    function()
        if(client_settings["infotext"])then
            local screenW, screenH = guiGetScreenSize()
            dxDrawRectangle(0, (screenH - 27) , screenW, 27, tocolor(17, 0, 0, 195), false)
            dxDrawText(texts[lastTextID], 10, screenH-27, screenW-20, ( screenH-27) + 27, tocolor(139, 0, 0, 224), 1.00, "bankgothic", "left", "center", false, false, false, false, false)
        end
    end
)










