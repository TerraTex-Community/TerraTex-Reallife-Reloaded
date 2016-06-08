
f1_cmds = {
    scrollpane = {},
    window = {},
    staticimage = {},
    label = {}
}

local showbinds={
    [1]={
        ["title"]="Generell",
        ["rules"]={
            {"spawnchange", "wechselt den Spawn"},
            {"service", "zeigt alle wichtigen kostenlosen Telefonnummern"},
            {"ad", "sendet Werbung (Achtung Kosten pro Zeichen und Zeile)"},
            {"call", "jemand anrufen"},
            {"hangup", "auflegen"},
            {"pickup", "Anruf annehmen"},
            {"togglephone", "schaltet das Telefon an/aus"},
            {"report", "Ingamesupportanfrage stellen"},
            {"kopfgeld", "setzt Kopfgeld auf einen Spieler aus"},
            {"s,f,c,me", "verschiedene Chatformen"},
            {"animlist", "zeigt eine Liste aller Animationen"},
            {"frames", "zeigt die aktuellen Framedaten an (Framerates,Framecrash)"},
            {"rebind", "Bindet wichtige Servergebundene Tasten neu."},
            {"pokal", "Zeigt eine Liste aller Pokale"}
        }
    },
    [2]={
        ["title"]="Job",
        ["rules"]={
            {"quitjob", "kündigt den alten Job"},
            {"getjob", "nimmt den neuen Job an"},
            {"jobhelp", "zeigt Informationen über den aktuellen Job"},
            {"skill", "zeigt deine aktuellen Skilllevel der Jobs"},
        }
    },
    [3]={
        ["title"]="Fahrzeuge",
        ["rules"]={
            {"vehhelp", "Ruft die Hilfe für Fahrzeuge auf"},
            {"setlimit", "setzt den Limiter auf die eingegebene Geschwindigkeit"},
            {"settempo", "setzt den Tempomat auf die eingegebene Geschwindigkeit"}
        }
    },
    [4]={
        ["title"]="Häuser",
        ["rules"]={
            {"in,out", "betritt / verlässt das Haus"},
            {"hlock", "schließt das Haus ab / auf"},
            {"rent", "mietet sich in das Haus ein"},
            {"unrent", "mietet sich aus dem Haus aus"},
            {"",""},
            {"Hausbesitzer: ",""},
            {"buyhouse", "kauft das Haus"},
            {"sellhouse", "verkauft das Haus ans System"},
            {"givehouse", "Haus an einen Spieler übergeben"},
            {"setrent", "Miete festlegen"},
            {"hkasse", "Geld aus der Hauskasse entnehmen" },
            {"hausgleich", "Zahlt genug Geld von der Hand ein, um die Hauskasse auszugleichen" }
        }

    },
    [5]={
        ["title"]="Business",
        ["rules"]={
            {"bizhelp ", "Ruft die Hilfe für Biz auf"},
        }
    },
    [6]={
        ["title"]="Prestigeobjecte",
        ["rules"]={
            {"buyprestige ", "Kauft das Prestige"},
            {"sellprestige ", "Verkauft das Prestige an das System"},
            {"giveprestige ", "Verkauft das Prestige an einen Spieler"},
            {"upgradeprestige ", "Upgraded das Prestige"},
            {"upgradeprestigeInfo ", "Zeigt Upgradekosten für das Prestige"},
            {"upi ", "Zeigt Upgradekosten für das Prestige"},
        }
    },
    [7]={
        ["title"]="Fraktionen",
        ["rules"]={
            {"frakkasse", "Bearbeitung der Frakkasse"},
            {"frakdrug", "Bearbeitung des Drogendepots"},
            {"frakmats", "Bearbeitung des Materialiendepots"},
            {"blacklist", "zeigt Blacklist"},
            {"setblacklist", "setzt jemand auf die Blacklist"},
            {"unsetblacklist", "löscht jemand von der Blacklist"},
            {"sladen", "zeigt alle Läden im Besitz"}
        }
    },

}

addEventHandler("onClientResourceStart", getRootElement(),
    function()
        f1_cmds.window[1] = guiCreateWindow(253, 183, 600, 535, "Wichtige Befehle", false)
        guiWindowSetSizable(f1_cmds.window[1], false)

        f1_cmds.label[1] = guiCreateLabel(22, 32, 113, 20, "Kategorie", false, f1_cmds.window[1])
        f1_cmds.label[2] = guiCreateLabel(147, 32, 84, 19, "Befehl", false, f1_cmds.window[1])
        f1_cmds.label[3] = guiCreateLabel(242, 32, 349, 19, "Beschreibung", false, f1_cmds.window[1])
        f1_cmds.staticimage[1] = guiCreateStaticImage(12, 48, 578, 3, "FILES/IMAGES/f1/dot_white.png", false, f1_cmds.window[1])
        f1_cmds.scrollpane[1] = guiCreateScrollPane(14, 54, 577, 471, false, f1_cmds.window[1])

        local aktualY=0
        for theKategorie, theEintraege in ipairs(showbinds)do
            guiCreateLabel(0, aktualY, 116, 15, theEintraege["title"], false, f1_cmds.scrollpane[1])
            guiCreateLabel(125, aktualY, 83, 15, " ", false, f1_cmds.scrollpane[1])
            guiCreateLabel(218, aktualY, 340, 15, " ", false, f1_cmds.scrollpane[1])
            aktualY=aktualY+16

            for theKey, theEintrag in ipairs(theEintraege["rules"])do
                guiCreateLabel(0,aktualY, 116, 15, " ", false, f1_cmds.scrollpane[1])
                guiCreateLabel(125,aktualY, 93, 15, theEintrag[1], false, f1_cmds.scrollpane[1])
                guiCreateLabel(218, aktualY, 340, 15, theEintrag[2], false, f1_cmds.scrollpane[1])
                aktualY=aktualY+16
            end
            f1_cmds.staticimage[2] = guiCreateStaticImage(2, aktualY, 575, 2, "FILES/IMAGES/f1/dot_white.png", false, f1_cmds.scrollpane[1])
            aktualY=aktualY+3
        end

        guiSetVisible(f1_cmds.window[1],false)
        f1_menu.functions.addButton("wichtige Befehle",f1_cmds.window[1])

    end
)










