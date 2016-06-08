
f1_stvo = {
    window = {},
    scrollpane = {},
    staticimage = {},
    label = {}
}

local rules={
    [1]={
        ["titles"]="§1 Grundsatz",
        ["rules"]={
            {
                ["text"]="Alle Verkehrsteilnehmer, ob Fußgänger oder Autofahrer, haben aufeinander Rücksicht zu nehmen.",
                ["underpoints"]=false
            },
            {
                ["text"]="Jeder Verkehrsteilnehmer ist dazu aufgrufen, defensiv zu fahren, um Unfälle zu vermeiden.",
                ["underpoints"]=false
            },
            {
                ["text"]="Die Bestrafung erfolgt nach den Wanted- und StVO-Regeln.",
                ["underpoints"]=false
            },

        },
    },
    [2]={
        ["titles"]="§2 Grundsätzliche Regelungen",
        ["rules"]={
            {
                ["text"]="Der Fahrer eines KFZ-Fahrzeugs muss die erforderliche Lizenz besitzen.",
                ["underpoints"]=false
            },
            {
                ["text"]="Geschwindigkeitsbeschränkungen gelten wie folgt:",
                ["underpoints"]={
                    "innerorts: 80 km/h",
                    "Ruhezonen: 30 km/h",
                    "außerorts: keine Beschränkung",
                    "Autobahn: keine Beschränkung",
                    "Die Geschwindigkeit sollte den gegebenen Straßensituationen angepasst werden. (Viel befahrene Orte = geringere Geschwindigkeit)",
                },
            },
            {
                ["text"]="Vorfahrtsregeln gelten wie folgt:",
                ["underpoints"]={
                    "mit Ampelanlagen: grün hat Vorfahrt",
                    "ohne Ampelanlagen: rechts vor links",
                },
            },
            {
                ["text"]="Es besteht Rechtsfahrgebot.",
                ["underpoints"]=false
            },
            {
                ["text"]="Es ist nur auf ausgewiesenen Straßen oder markierten Schotterpisten zu fahren.",
                ["underpoints"]=false
            },
            {
                ["text"]="Die Verwendung des Blinkers erfolgt auf freiwilliger Basis.",
                ["underpoints"]=false
            },
            {
                ["text"]="Bei Dämmerung, Nacht und sofern es Witterungsverhältnisse erfordern, ist das Abblendlicht einzuschalten.",
                ["underpoints"]=false
            },
        },
    },
    [3]={
        ["titles"]="§3 Tuningteile",
        ["rules"]={
            {
                ["text"]="Alle im Tuningshop angebotenen Zubehörteile sind für die Straße zugelassen.",
                ["underpoints"]=false
            },
            {
                ["text"]="Der bloße Einbau von Nitro ist erlaubt, die Verwendung ist jedoch untersagt.",
                ["underpoints"]=false
            },
        },
    },
    [4]={
        ["titles"]="§4 Luftfahrtverkehrsregeln",
        ["rules"]={
            {
                ["text"]="Es gelten Mindestflughöhen während des Reiseflugs wie folgt:",
                ["underpoints"]={
                    "Helikopter: 150 Meter",
                    "Flugzeuge: 300 Meter",
                },
            },
            {
                ["text"]="Flugzeuge",
                ["underpoints"]={
                    "Flugzeuge dürfen ausschließlich auf ausgewiesenen Landebahnen starten und landen.",
                    "Der Pilot hat sich zu vergewissern, dass die Landebahn frei ist, bevor ein Startvorgang oder eine Landung durchgeführt wird.",
                },
            },
            {
                ["text"]="Helikopter",
                ["underpoints"]={
                    "Helikopter dürfen ausschließlich auf weiträumigen Grasflächen, Flughäfen oder ausgewiesenen Helipads landen.",
                    "Der Pilot hat sich zu vergewissern, dass der Start- oder Landepunkt frei ist und keine Personen durch die Rotorblätter gefährdet werden.",
                    "Töten von Personen durch Rotorblätter ist ein Verstoss gegen die Serverregeln!",
                },
            },
        },
    },
    [5]={
        ["titles"]="§4.1 Luftfahrtverkehrsregeln - Regelungen zum Landen auf Flughäfen mit Flugzeug und Helikopter",
        ["rules"]={
            {
                ["text"]="Flugzeuge besitzen bei Landungen ein Vorfahrtsrecht.",
                ["underpoints"]=false
            },
            {
                ["text"]="Bei der Landung ist auf eine reduzierte Geschwindigkeit, die verbleibende Landebahnlänge sowie die Höhe zu achten.",
                ["underpoints"]=false
            },
            {
                ["text"]="Sollte ein Flugzeug",
                ["underpoints"]={
                    "a) schräg zur Landebahn anfliegen,",
                    "b) zu schnell sein,",
                    "c) zu hoch anfliegen oder ",
                    "d) eine belegte Landebahn anfliegen,",
                    "ist der Pilot dazu aufgefordert, unverzüglich durchzustarten und eine Platzrunde um den Flughafen zu drehen."
                }
            },
            {
                ["text"]="Es ist auf eine realistische Landung (Hinterräder setzen zuerst auf, gleichmäßiger Sinkflug) zu achten.",
                ["underpoints"]=false
            },
        },
    },
    [6]={
        ["titles"]="§4.2 Anflugsregeln auf Flughäfen",
        ["rules"]={
            {
                ["text"]="Landung auf dem Old Airport erfolgt nach Sichtflugregeln",
                ["underpoints"]=false
            },
        },
    },
    [7]={
        ["titles"]="§5 Parkregeln",
        ["rules"]={
            {
                ["text"]="Fahrzeuge sind stets realitätsgetreu zu parken.",
                ["underpoints"]=false
            },
            {
                ["text"]="Es gilt die 50:50-Regel (50% Straße zu 50% Bürgersteig). Ausnahme: Motorräder - sie sind unmittelbar neben Boardsteinen auf der Straße zu parken.",
                ["underpoints"]=false
            },
            {
                ["text"]="Parkverbot (/park): Stadthalle, LSPD, Rookiespawn, Geschäfte (24/7, Burger Shot etc.), Jobparkplätze, Parken auf unbefestigtem Grund",
                ["underpoints"]=false
            },
            {
                ["text"]="Es darf ausschließlich auf befestigtem Grund geparkt werden.",
                ["underpoints"]=false
            },
            {
                ["text"]="Halteverbot (Abstellen des Fahrzeugs): LSPD (inkl. Abholbereich für abgeschleppte Wagen)",
                ["underpoints"]=false
            },
            {
                ["text"]="Am Bahnhof ist absolutes Parkverbot mit der Ausnahme §5.1",
                ["underpoints"]=false
            },
        },
    },
    [8]={
        ["titles"]="§5.1 Besondere Parkregelungen für den Bahnhof",
        ["rules"]={
            {
                ["text"]="nur Spieler mit dem [ROOKIE]-Tag (< 25h) sind dazu berechtigt, ihr Fahrzeug an folgenden Orten abzustellen:",
                ["underpoints"]={
                    "Bahnhofparkplatz (innerhalb der Mauern), 8Ball, Parkplatz unter der Brücke westlich vom Bahnhof",
                },
            },
        },
    },
    [9]={
        ["titles"]="§5.2 Parkregelungen für Helikopter und Flugzeuge",
        ["rules"]={
            {
                ["text"]="Helikopter und Flugzeuge dürfen ausschließlich auf Flughäfen, Helikopter auch auf Helipads geparkt werden.",
                ["underpoints"]=false
            },
        },
    },
}




addEventHandler("onClientResourceStart", getRootElement(),
    function()
        f1_stvo.window[1] = guiCreateWindow(253, 183, 600, 535, "StVO-Regeln", false)
        guiWindowSetSizable(f1_stvo.window[1], false)

        f1_stvo.scrollpane[1] = guiCreateScrollPane(11, 27, 579, 498, false, f1_stvo.window[1])

        local calcHeight=0
        for theKeyName,theKategorie in ipairs(rules)do
            f1_stvo.label[1] = guiCreateLabel(0, calcHeight, 350, 15, theKategorie["titles"], false, f1_stvo.scrollpane[1])
            guiSetFont(f1_stvo.label[1], "default-bold-small")
            calcHeight=calcHeight+16

            for theKey, theRule in ipairs(theKategorie["rules"])do
                f1_stvo.label[2] = guiCreateLabel(0, calcHeight, 15, 15, "->", false, f1_stvo.scrollpane[1])
                guiSetFont(f1_stvo.label[2], "default-bold-small")


                f1_stvo.label[4] = guiCreateLabel(15, calcHeight, 530, 14, theRule["text"], false, f1_stvo.scrollpane[1])
                calcHeight=calcHeight+resizeHeight(f1_stvo.label[4])
                guiLabelSetHorizontalAlign(f1_stvo.label[4], "left", true)

                if(theRule["underpoints"])then
                    for theUnderKey, theUnderRule in ipairs(theRule["underpoints"])do
                        f1_stvo.label[5] = guiCreateLabel(0, calcHeight, 30, 15, "--->", false, f1_stvo.scrollpane[1])
                        guiSetFont(f1_stvo.label[5], "default-bold-small")


                        f1_stvo.label[6] = guiCreateLabel(30, calcHeight, 515, 14, theUnderRule, false, f1_stvo.scrollpane[1])
                        calcHeight=calcHeight+resizeHeight(f1_stvo.label[6])
                        guiLabelSetHorizontalAlign(f1_stvo.label[6], "left", true)
                    end
                end
            end

            calcHeight=calcHeight+5
            f1_stvo.staticimage[1] = guiCreateStaticImage(9, calcHeight, 546, 2, "FILES/IMAGES/f1/dot_white.png", false, f1_stvo.scrollpane[1])
            calcHeight=calcHeight+5
        end

        guiSetVisible(f1_stvo.window[1],false)
        f1_menu.functions.addButton("StVO-Katalog",f1_stvo.window[1])
    end
)










