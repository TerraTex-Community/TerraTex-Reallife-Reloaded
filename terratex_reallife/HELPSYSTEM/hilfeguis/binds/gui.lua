
f1_binds = {
    scrollpane = {},
    window = {},
    staticimage = {},
    label = {}
}

local showbinds={
    [1]={
        ["title"]="generell",
        ["rules"]={
            {"Alt Gr", "Klicksystem"},
            {"F1", "Hilfen"},
            {"F2", "Radiostreamer"},
            {"F3", "Einstellungen"},
            {"F11", "Karte"},
            {"F12", "Screenshot"},
            {"Tab", "Spielerliste"},
        }
    },
    [2]={
        ["title"]="im Fahrzeug",
        ["rules"]={
            {"X", "Motor an/aus schalten"},
            {"L", "Licht an/aus schalten"},
            {",", "Tempomat setzen auf aktueller Geschwindigkeit"},
            {".", "Limiter setzen auf aktueller Geschwindigkeit"},
            {"-", "Tempomat und Limiter abschalten"},
        }
    }

}

addEventHandler("onClientResourceStart", getRootElement(),
    function()
        f1_binds.window[1] = guiCreateWindow(253, 183, 600, 535, "Wichtige Binds", false)
        guiWindowSetSizable(f1_binds.window[1], false)

        f1_binds.label[1] = guiCreateLabel(22, 31, 113, 20, "Kategorie", false, f1_binds.window[1])
        f1_binds.label[2] = guiCreateLabel(147, 32, 74, 19, "Bind", false, f1_binds.window[1])
        f1_binds.label[3] = guiCreateLabel(232, 32, 349, 19, "Beschreibung", false, f1_binds.window[1])
        f1_binds.staticimage[1] = guiCreateStaticImage(12, 48, 578, 3, "FILES/IMAGES/f1/dot_white.png", false, f1_binds.window[1])
        f1_binds.scrollpane[1] = guiCreateScrollPane(14, 54, 577, 471, false, f1_binds.window[1])

        local aktualY=0
        for theKategorie, theEintraege in pairs(showbinds)do
            guiCreateLabel(0, aktualY, 116, 15, theEintraege["title"], false, f1_binds.scrollpane[1])
            guiCreateLabel(125, aktualY, 83, 15, " ", false, f1_binds.scrollpane[1])
            guiCreateLabel(218, aktualY, 340, 15, " ", false, f1_binds.scrollpane[1])
            aktualY=aktualY+16

            for theKey, theEintrag in ipairs(theEintraege["rules"])do
                guiCreateLabel(0,aktualY, 116, 15, " ", false, f1_binds.scrollpane[1])
                guiCreateLabel(125,aktualY, 83, 15, theEintrag[1], false, f1_binds.scrollpane[1])
                guiCreateLabel(218, aktualY, 340, 15, theEintrag[2], false, f1_binds.scrollpane[1])
                aktualY=aktualY+16
            end
            f1_binds.staticimage[2] = guiCreateStaticImage(2, aktualY, 575, 2, "FILES/IMAGES/f1/dot_white.png", false, f1_binds.scrollpane[1])
            aktualY=aktualY+3
        end

        guiSetVisible(f1_binds.window[1],false)
        f1_menu.functions.addButton("wichtige Binds",f1_binds.window[1])

    end
)










