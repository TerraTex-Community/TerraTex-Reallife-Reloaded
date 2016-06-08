
f1_rules = {
    window = {},
    scrollpane = {},
    staticimage = {},
    label = {}
}

local rules={
    [1]={
        ["titel"]="§1 Allgemeines Verhalten auf dem Server",
        ["rules"]={
            {
                ["text"]="Jeder User auf dem Server ist respektvoll und freundlich zu behandeln.",
                ["underpoints"]=false
            },
            {
                ["text"]="Niemand wird aufgrund seiner Herkunft, möglichen Behinderungen oder sonstigen Merkmalen diskriminiert.",
                ["underpoints"]=false
            },
            {
                ["text"]="Mobbing ist strengstens untersagt.",
                ["underpoints"]=false
            },
            {
                ["text"]="Deathmatch ist zu vermeiden und kann bei häufigem, sinnlosem Deathmatch zum Ausschluss vom Server führen.",
                ["underpoints"]=false
            },
            {
                ["text"]="Jeder Waffengebrauch in einer Zivilen Fraktion (oder als Fraktionsloser User) ist Deathmatch.",
                ["underpoints"]=false
            },
            {
                ["text"]="Waffen für Zivis, sind nur für Selbstverteidigung geeignet!",
                ["underpoints"]=false
            },
            {
                ["text"]="Jedem User soll die bestmöglichste Spielerfahrung geboten werden.",
                ["underpoints"]=false
            },
            {
                ["text"]="Rookies ist hilfsbereit und freundlich gegenüberzutreten.",
                ["underpoints"]=false
            },
            {
                ["text"]="Jeder User hat das Recht ungestört auf "..config["communityname"].." zu spielen!",
                ["underpoints"]=false
            },
        },
    },
    [2]={
        ["titel"]="§2 Beleidigungen",
        ["rules"]={
            {
                ["text"]="Beleidigungen, ob zensiert oder nicht, sind in jedem Fall zu unterlassen.",
                ["underpoints"]=false
            },
            {
                ["text"]="Beleidigungen jeder Sprache sind unerwünscht.",
                ["underpoints"]=false
            },
            {
                ["text"]="Für Beleidigungen gibt es keine Ausreden.",
                ["underpoints"]=false
            },
            {
                ["text"]="Auch nicht ernstgemeinte Beleidigungen können missverstanden werden und zum Bann führen.",
                ["underpoints"]=false
            },
            {
                ["text"]="Jede Art von unangebrachten Ausdrücken ist verboten!",
                ["underpoints"]=false
            },
        }
    },
    [3]={
        ["titel"]="§3 Werbung für andere Angebote",
        ["rules"]={
            {
                ["text"]="Jegliche Werbung für andere Angebote ist zu unterlassen.",
                ["underpoints"]=false
            },
            {
                ["text"]="Werbung für andere Angebote muss durch die Serverleitung genehmigt werden.",
                ["underpoints"]=false
            },
        }
    },
    [4]={
        ["titel"]="§4 Bugusing",
        ["rules"]={
            {
                ["text"]="Sobald ein Bug gefunden wird, ist dieser umgehend im Bugtracker oder bei kritischen Bugs (z.B. Geldbug) einem Admin per PN zu melden.",
                ["underpoints"]=false
            },
            {
                ["text"]="Das wissentliche Ausnutzen oder das Verschweigen von Bugs ist strafbar und führt zum dauerhaften Ban.",
                ["underpoints"]=false
            },
            {
                ["text"]="Seit 01.01.2013 werden Bans, die durch Bugusing gegeben werden, NICHT MEHR entbannt!",
                ["underpoints"]=false
            },
        }
    },
    [5]={
        ["titel"]="§5 Betrug",
        ["rules"]={
            {
                ["text"]="Das Betrügen anderer User ist zu unterlassen.",
                ["underpoints"]=false
            },
            {
                ["text"]="Sollte einem User dadurch ein Geld- oder Sachschaden entstanden sein, so ist dieser zu ersetzen.",
                ["underpoints"]=false
            },
            {
                ["text"]="Betrug können mit Pfändung, Verwarnungen oder einem Bann bestraft werden.",
                ["underpoints"]=false
            },
            {
                ["text"]="Dennoch ist jeder User für sein Eigentum selbstverantwortlich. D.h. Die Serverleitung behält sich vor nur in Ausnahmefällen einzuschreiten.",
                ["underpoints"]=false
            },
        }
    },
    [6]={
        ["titel"]="§6 Multiaccounts",
        ["rules"]={
            {
                ["text"]="Jede real existierende Person darf genau einen InGame-, sowie einen Forenaccount besitzen.",
                ["underpoints"]=false
            },
            {
                ["text"]="Bei allen sonstigen Angeboten von "..config["communityname"].." gilt selbiges!",
                ["underpoints"]=false
            },
            {
                ["text"]="Multiaccountanträge sind im ControlPanel zu stellen! Dazu zählen nur Anträge die mehrere Accounts auf EINEM PC oder von einem User betreffen.",
                ["underpoints"]=false
            },
            {
                ["text"]="Weiterführende Regelungen",
                ["underpoints"]=false
            },
        }
    },-----------------------------------------------------------
    [7]={
        ["titel"]="§7 Modifikationen am Spiel",
        ["rules"]={
            {
                ["text"]="Jegliche Modifikationen (Skin-, Carmods, etc.) am Spiel sind verboten.",
                ["underpoints"]=false
            },
            {
                ["text"]="Als Modifikation werden alle Veränderungen am Spiel bezeichnet, die nicht von der Serverleitung oder dem Originalen Spiel vorgesehen sind.",
                ["underpoints"]=false
            },
        }
    },
    [8]={
        ["titel"]="§8 Drive-By",
        ["rules"]={
            {
                ["text"]="Definition: Spieler A attackiert Spieler B aus einem Fahrzeug mit einer Waffe, während Spieler B in keinem Fahrzeug sitzt.",
                ["underpoints"]=false
            },
            {
                ["text"]="Drive-By ist verboten und führt zum direkten Ban bzw. TimeBan.",
                ["underpoints"]=false
            },
        }
    },
    [9]={
        ["titel"]="§9 Reports",
        ["rules"]={
            {
                ["text"]="Reports dienen dem User als Kontaktmöglichkeit mit Admins.",
                ["underpoints"]=false
            },
            {
                ["text"]="Reports dienen nur der Fragestellung, einer Hinweismöglichkeit oder als Mittel Serverregelverstösse direkt zu melden.",
                ["underpoints"]=false
            },
            {
                ["text"]="Reports sollen alle nötigen Informationen zur schnellen Bearbeitung enthalten (nicht: HILFE!).",
                ["underpoints"]=false
            },
            {
                ["text"]="Reports werden nicht immer sofort beantwortet - Geduld haben.",
                ["underpoints"]=false
            },
            {
                ["text"]="Der Missbrauch der Reportfunktion ist strafbar!",
                ["underpoints"]=false
            },
        }
    },
    [10]={
        ["titel"]="§10 ADs (Werbungen)",
        ["rules"]={
            {
                ["text"]="Werbungen entsprechen folgendem Format: Suche, Biete, Verkaufe",
                ["underpoints"]=false
            },
            {
                ["text"]="Erlaubt sind: Veranstaltungshinweise (Treffen), Fraktionswerbung (Membersuche), Dienstleistungsangebote (Sex, Drogen), Suchen und Bieten von auf "..config["communityname"].."-existierenden Gegenständen, Werbung für Unternehmen",
                ["underpoints"]=false
            },
            {
                ["text"]="Verboten sind: Dienstaufforderungen, Fragestellungen, Aufforderung zur Handyanschaltung, Suche nach Usern o. Fahrzeugen, Anstiftung zum DM (Kopfgeld), Rufen von Usern, Bettelanfragen (z.B. Kredite oder Gibt mir jemand Geld)",
                ["underpoints"]=false
            },
            {
                ["text"]="Ingame-Werbungen per /ad, können mit Werbungen in einer Zeitung verglichen werden. Darunter zählen somit auch die Form, wie sie von Anzeigen in einer Zeitung gewohnt ist.? Illegale AD's sind zwar von den Serverregeln nicht verboten, werden aber durch die Polizei bestraft. Darunter zählen Drogen, Materialien und Waffen.",
                ["underpoints"]=false
            },
            {
                ["text"]="Werbungen haben auch wie Werbungen auszusehen, bzw. Formuliert zu werden. /ad ist kein Chat!",
                ["underpoints"]=false
            },
        }
    },
    [11]={
        ["titel"]="§11 Offline- und Selbstmordflucht",
        ["rules"]={
            {
                ["text"]="Offlineflucht und Selbstmordflucht sind verboten und zu unterlassen.",
                ["underpoints"]=false
            },
            {
                ["text"]="Offlineflucht wird durch das System automatisch mit einem längeren Gefängnisaufenthalt bestraft.",
                ["underpoints"]=false
            },
            {
                ["text"]="Bei Selbstmordflucht ist das PD berechtigt, einen zusätzlichen Wanted zu vergeben.",
                ["underpoints"]=false
            },
            {
                ["text"]="Bei 'Härtefällen' behält sich die Serverleitung vor, weitergehende moderative Strafen auszusprechen.",
                ["underpoints"]=false
            },
        }
    },
    [12]={
        ["titel"]="§12 Mutwillige Zerstörung von Fahrzeugen",
        ["rules"]={
            {
                ["text"]="Sollte ein Fahrzeug durch das Verschulden anderer User zerstört werden, haben die Beteiligten Schadensersatz zu leisten.",
                ["underpoints"]=false
            },
            {
                ["text"]="Sollte der Besitzer etwa bei einem Diebstahl maßgeblich zur Zerstörung beitragen (Beschuss des Fahrzeugs), hat der Besitzer kein Anrecht auf Entschädigung.",
                ["underpoints"]=false
            },
            {
                ["text"]="Bei Verfolgungen durch die Polizei oder die Mafia: die Verfolger sind angewiesen, mittels Schussabgabe auf die Reifen oder Blockieren das Fahrzeug stillzulegen. Sollte das Fahrzeug durch die Schussabgabe oder sonstige Rammmanöver zerstört werden, tragen beide Seiten die Hälfte des Schadens. Das Moderationsteam behält sich vor hier ausnahmen zu machen. (Bsp: Der zu Verfolgende fährt während einer Flucht mit seinem Fahrzeug und will nicht anhalten und reizt es somit wissentlich aus, ist auch nur dieser selbst Schuld!)",
                ["underpoints"]=false
            },
            {
                ["text"]="Der derzeitige Einkaufspreis dient als Wert des Fahrzeugs. Alter oder KM-Stand können nicht berücksichtigt werden.",
                ["underpoints"]=false
            },
        }
    },
    [13]={
        ["titel"]="§13 Echtgeldfahrzeugobjekte und Handel mit Echtgeld",
        ["rules"]={
            {
                ["text"]="Echtgeldfahrzeugobjekte dürfen innerhalb der Userschaft nicht getauscht oder verkauft werden.",
                ["underpoints"]=false
            },
            {
                ["text"]="Bei Zuwiderhandlungen droht die Löschung des Fahrzeugs.",
                ["underpoints"]=false
            },
            {
                ["text"]="Der Handel von inGame-Objekten mit Echtgeld ist strengstens untersagt. Es droht der sofortige permanente Ausschluss vom Server.",
                ["underpoints"]=false
            },
        }
    },
    [14]={
        ["titel"]="§14 Ruhezonen",
        ["rules"]={
            {
                ["text"]="Die Ruhezonen-Zone stellt einen beruhigten Bereich dar. Sie ist im Gebiet des Stadtzentrums (LSPD, Stadthalle) sowie am Rookiespawn vorzufinden.",
                ["underpoints"]=false
            },
            {
                ["text"]="Ruhezonen sind auf der F11- Karte grün markiert.",
                ["underpoints"]=false
            },
            {
                ["text"]="Deathmatch (Beschuss, Schlägereien, mehrfaches Überfahren) ist in diesem Bereich strengstens verboten.",
                ["underpoints"]=false
            },
            {
                ["text"]="Die Regel wird bei Events (WT und AT) für die Teilnehmer und die Zeit des Events vorübergehend aufgehoben.",
                ["underpoints"]=false
            },
            {
                ["text"]="Dem PD ist es in Notfällen (Flucht, Ausübung von DM) erlaubt, von der Dienstwaffe Gebrauch zu machen.",
                ["underpoints"]=false
            },
            {
                ["text"]="Blacklistjagd ist nur in Ausnahmefällen (mehrmalige Flucht in die Zone) gestattet.",
                ["underpoints"]=false
            },
        }
    },
    [15]={
        ["titel"]="§15 DM-Gangs und Erpressung",
        ["rules"]={
            {
                ["text"]="Gruppierungen, die das Ziel verfolgen, Deathmatch zu betreiben, sind verboten.",
                ["underpoints"]=false
            },
            {
                ["text"]="Außer den offiziellen Fraktionen darf niemand Schutzgelderpressung betreiben. Dazu gehören auch Überfälle.",
                ["underpoints"]=false
            },
            {
                ["text"]="Für Gruppierungen gelten alle im Forum für Unternehmen aufgezählten Regeln!",
                ["underpoints"]=false
            },
        }
    },
    [16]={
        ["titel"]="§16 Sonstige Bestimmungen",
        ["rules"]={
            {
                ["text"]="Kautionen, die etwa durch Wetterbedingungen oder sonstige Umstände (z.B. Verbindungsabbruch) verloren werden, werden nicht ersetzt.",
                ["underpoints"]=false
            },
            {
                ["text"]="Die Ausnutzung von Premiumvorteilen des nicht-eigenen Accounts sind verboten (Beispiel: Verschrottung eines Fahrzeuges durch einen Freund mit einem Premiumaccount).",
                ["underpoints"]=false
            },
            {
                ["text"]="Serverausfälle gehören zum Leben auf der Community dazu. Bei kleineren Abstürzen und Serverneustarts, wird kein Verlust ersetzt. (Ausnahme sind nur sehr teure Gegenstände bzw. sonstige Ausnahmefälle)",
                ["underpoints"]=false
            },
            {
                ["text"]="Das Drohen mit Administrativen Strafen als Nicht-"..config["clantag"].."-Mitglied ist verboten.",
                ["underpoints"]=false
            },
            {
                ["text"]="Das Belügen und Betrügen des "..config["clantag"].."s kann folgen haben!",
                ["underpoints"]=false
            },
            {
                ["text"]="Die Serverleitung behält sich das Recht vor, jederzeit eine Mitgliedschaft zu verwehren oder zu kündigen. Es besteht kein Anrecht auf eine Mitgliedschaft.",
                ["underpoints"]=false
            },
        }
    },
    [17]={
        ["titel"]="§17 Cheats, Makros und andere Externe Programme",
        ["rules"]={
            {
                ["text"]="Alle Programme, die einen unfairen Vorteil bieten, sind verboten.",
                ["underpoints"]=false
            },
            {
                ["text"]="Alle Programme, die in das Spielgeschehen eingreifen, sind verboten.",
                ["underpoints"]=false
            },
            {
                ["text"]="Cheats sind auf dem Server verboten.",
                ["underpoints"]=false
            },
            {
                ["text"]="Makros bieten einen Vorteil anderen gegenüber und ist somit verboten.",
                ["underpoints"]=false
            },
            {
                ["text"]="Alle unter diesem Abschnitt genannten Regeln werden mit einem permanenten Ban bestraft!",
                ["underpoints"]=false
            },
        }
    },
}




addEventHandler("onClientResourceStart", getRootElement(),
    function()
        f1_rules.window[1] = guiCreateWindow(253, 183, 600, 535, "Regelwerk", false)
        guiWindowSetSizable(f1_rules.window[1], false)

        f1_rules.scrollpane[1] = guiCreateScrollPane(11, 27, 579, 498, false, f1_rules.window[1])

        local calcHeight=0
        for theKeyName,theKategorie in ipairs(rules)do
            f1_rules.label[1] = guiCreateLabel(0, calcHeight, 350, 15, theKategorie["titel"], false, f1_rules.scrollpane[1])
            guiSetFont(f1_rules.label[1], "default-bold-small")
            calcHeight=calcHeight+16

            for theKey, theRule in ipairs(theKategorie["rules"])do
                f1_rules.label[2] = guiCreateLabel(0, calcHeight, 15, 15, "->", false, f1_rules.scrollpane[1])
                guiSetFont(f1_rules.label[2], "default-bold-small")


                f1_rules.label[4] = guiCreateLabel(15, calcHeight, 530, 14, theRule["text"], false, f1_rules.scrollpane[1])
                calcHeight=calcHeight+resizeHeight(f1_rules.label[4])
                guiLabelSetHorizontalAlign(f1_rules.label[4], "left", true)

                if(theRule["underpoints"])then

                    for theUnderKey, theUnderRule in ipairs(theRule["underpoints"])do
                        f1_rules.label[5] = guiCreateLabel(0, calcHeight, 30, 15, "--->", false, f1_rules.scrollpane[1])
                        guiSetFont(f1_rules.label[5], "default-bold-small")


                        f1_rules.label[6] = guiCreateLabel(30, calcHeight, 515, 14, theUnderRule, false, f1_rules.scrollpane[1])
                        calcHeight=calcHeight+resizeHeight(f1_rules.label[6])
                        guiLabelSetHorizontalAlign(f1_rules.label[6], "left", true)
                    end
                end
            end

            f1_rules.staticimage[1] = guiCreateStaticImage(9, calcHeight, 546, 2, "FILES/IMAGES/f1/dot_white.png", false, f1_rules.scrollpane[1])
            calcHeight=calcHeight+5
        end

        guiSetVisible(f1_rules.window[1],false)
        f1_menu.functions.addButton("Regelwerk",f1_rules.window[1])
    end
)










