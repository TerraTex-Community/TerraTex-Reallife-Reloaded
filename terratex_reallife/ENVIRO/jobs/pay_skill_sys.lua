--
-- Created by IntelliJ IDEA.
-- User: geramylappto
-- Date: 23.03.14
-- Time: 22:24
-- To change this template use File | Settings | File Templates.
--
-- Aufbau JobSetupTable:
-- [jobID]={bezeichnung,{needSkillPunkte1-5},{gehälter0-5},{paydayMin,paydayMax},randFaktor or 1}   PayDayMin und PayDayMax sind Kommazahlen z.B. 0.5 für 50%
-- Bei Jobs mit Entfernungsgehältern oder Zusatzgehältern: Angabe der Gehälter in den Stufen keine Zahlen sondern Tables wie
-- {proAuftrag,entfernung}
-- randFaktor: proAuftrag-Gehalt berechnet auf folgende weise:
-- Zufall zwischen proAuftrag*randFaktor und proAuftrag
-- Wenn der Randfaktor vor Teilung fals ist bezieht sich dies nur auf den direkt ausgezahlten Wert und nicht auf den gesamtwert
-- Wettertable => Auswirkung des Wetters bei einem bestimmten Event auf den Job

--1 => Atom | 2=>Flut | 3=>Flut und Atom | 4=>ÖlPest | 5=>Sauberer Regen | 6=>Verbesserung der Umweltqualität | 7=>Streik | 8=> Hitzewelle

local jobSetupTable={
    [1]={--Fischerjob
        "fisch",
        {100,1000,2500,4000,6000},--SkillPunkte
        {[0]=1,3,8,14,18,35},--Gehalt
        {0,0},--PayDayFaktor
        1, -- Randfaktor
        true, -- Randfaktor vor Teilung
        {false,false,false,false,false,false,false,false},--Wettertable
        "Fischerjob"--Jobname
    },
    [3]={--Müllmann
        "muell",
        {50,150,300,600,1200},
        {[0]=4,19,48,80,100,200},
        {1,1},
        1, -- Randfaktor
        true, -- Randfaktor vor Teilung
        {false,false,false,false,false,false,1.5,0.5},
        "Müllmann"
    },
    [4]={--Busfahrer
        "bus",
        {50,150,300,600,1200},
        {[0]=15,37,92,154,192,320},
        {0.5,0.5},
        0.25, -- Randfaktor
        false, -- Randfaktor vor Teilung
        {false,false,false,false,false,false,1.5,0.5},
        "Busfahrer"
    },
    [8]={--Pizza
        "pizza",
        {15,30,75,150,300},
        {[0]={48,0.00192},{96,0.0096},{192,0.024},{320,0.04},{400,0.04},{800,0.1}},
        {0.3,0.7},
        0.5, -- Randfaktor
        true, -- Randfaktor vor Teilung
        {1.1,1.1,1.2,false,false,false,1.25,1.5},
        "Pizzalieferant"
    },
    [11]={--Truckerjob
        "truck",
        {20,45,100,450,1300},
        {},--Wird der Funktion direkt übergeben
        {1,1},
        1, -- Randfaktor
        true, -- Randfaktor vor Teilung
        {false,false,false,false,false,false,false,false},--Wird direkt im Job Clientseitig gemacht
        "Truckerjob"
    },
    [12]={--Pilotenjob
        "flyers",
        {25,50,120,500,1500},
        {},--Wird der Funktion direkt übergeben
        {1,1},
        1, -- Randfaktor
        true, -- Randfaktor vor Teilung
        {false,false,false,false,false,false,false,false},--Wird direkt im Job Clientseitig gemacht
        "Flugjob"
    },
    [13]={--Sweeperjob
        "sweeper",
        {50,150,400,900,1800},
        {[0]={2,0.0384},{10,0.096},{24,0.24},{40,0.4},{50,0.5},{100,1}},
        {1,1},
        1, -- Randfaktor
        true, -- Randfaktor vor Teilung
        {1.4,0.9,0.9,false,false,0.5,1.3,1.3 },
        "Straßenputzer"
    },
    [14]={ -- Farmerjob
        "farmer",
        {15,35,80,250,500},
        {[0]=46,115,288,480,600,1200},
        {0,0},
        1, -- Randfaktor
        true, -- Randfaktor vor Teilung
        {0.4,0.9,0.3,false,1.2,3,false,0.9 },
        "Farmerjob"
    },
    [15]={-- Bergwerksjob
        "bergWerk",
        {50,200,400,700,1500},
        {[0]=6.14,30.72,76.80,128,160,320},
        {1,1},
        1, -- Randfaktor
        true, -- Randfaktor vor Teilung
        {false,0.8,false,false,0.8,false,1.2,1.2 },
        "Bergwerksarbeiter"
    },
    [17]={--Meeresreiniger
        "meeres",
        {2500,4000,7500,15000,30000},
        {[0]=0.10,0.24,0.60,1,1.25,2.50},
        {1,1},
        1, -- Randfaktor
        true, -- Randfaktor vor Teilung
        {1.15,0.8,1.1,2.5,false,0.5,false,false },
        "Meeresreiniger"
    }
}

function giveJobGehalt(thePlayer, jobID, auftraege, entfernung, definedMoney) --return betragDirekt,betragPayDay
    if(jobSetupTable[jobID])then
        --Auslesen der Spielerdaten
        local skillString=jobSetupTable[jobID][1].."Skill"
        local skillPointsString=jobSetupTable[jobID][1].."SkillPoints"
        local skill=vioGetElementData(thePlayer,skillString)
        local skillPoints=vioGetElementData(thePlayer,skillPointsString)

        --Berechnung Gesamtgehalt
        local gesamtGehalt=0
        if(definedMoney~=nil)then
            gesamtGehalt=definedMoney
        else
            local geldProSkill=0
            if(type(jobSetupTable[jobID][3][vioGetElementData(thePlayer,skillString)])=="table")then
                geldProSkill=jobSetupTable[jobID][3][vioGetElementData(thePlayer,skillString)][1]
                gesamtGehalt=entfernung*jobSetupTable[jobID][3][vioGetElementData(thePlayer,skillString)][2]
            else
                geldProSkill=jobSetupTable[jobID][3][vioGetElementData(thePlayer,skillString)]
            end
            gesamtGehalt=gesamtGehalt+geldProSkill*auftraege
            if(jobSetupTable[jobID][5]~=1 and jobSetupTable[jobID][6])then
                gesamtGehalt=math.random(gesamtGehalt*jobSetupTable[jobID][5],gesamtGehalt)
            end
        end
        --Berechnung Wetterauswirkung
        if(isWetterEventID~=0)then
            if(jobSetupTable[jobID][7][isWetterEventID])then
                gesamtGehalt=gesamtGehalt*jobSetupTable[jobID][7][isWetterEventID]
                if(jobSetupTable[jobID][7][isWetterEventID]>1)then
                    outputChatBox(wetterSkillTexte["hoeher"][isWetterEventID],thePlayer,255,0,0)
                else
                    outputChatBox(wetterSkillTexte["geringer"][isWetterEventID],thePlayer,255,0,0)
                end
            end
        end
        --Berechnung aufteilung PayDay und direkte Auszahlung
        local PayDayFaktor=math.random(jobSetupTable[jobID][4][1]*100,jobSetupTable[jobID][4][2]*100)/100
        local betragPayDay=math.round(PayDayFaktor*gesamtGehalt,2)
        local betragDirekt=math.round(gesamtGehalt-betragPayDay,2)

        if(jobSetupTable[jobID][5]~=1 and not(jobSetupTable[jobID][6]))then
            betragDirekt=math.random(betragDirekt*jobSetupTable[jobID][5],betragDirekt)
        end

        vioSetElementData(thePlayer,"addPayDayGehalt",vioGetElementData(thePlayer,"addPayDayGehalt")+betragPayDay) -- Geld zum PayDay addieren
        --PayDay Gehalt in den Log anzeigen
        saveMoneyLog(thePlayer,"Bank","job",betragPayDay,jobSetupTable[jobID][8],"Gehalt zum PayDay")
        
        if (betragDirekt > 0) then -- Nur Geldeintrag, wenn auch Geld zum eintragen vorhanden ist
            changePlayerMoney(thePlayer,betragDirekt,"job",jobSetupTable[jobID][8],"direktes Gehalt")
        end

        --Ehöhung der Skillpunkte nach Anzahl auftraege
        vioSetElementData(thePlayer,skillPointsString,vioGetElementData(thePlayer,skillPointsString)+auftraege)
        if(vioGetElementData(thePlayer,skillString)<5)then
            if(vioGetElementData(thePlayer,skillPointsString)>=jobSetupTable[jobID][2][vioGetElementData(thePlayer,skillString)+1])then
                vioSetElementData(thePlayer,skillString,vioGetElementData(thePlayer,skillString)+1)
                vioSetElementData(thePlayer,skillPointsString,vioGetElementData(thePlayer,skillPointsString)-jobSetupTable[jobID][2][vioGetElementData(thePlayer,skillString)])
                outputChatBox(string.format("Du hast beim %s das nächste Skilllevel erreicht. Du erhälst jetzt mehr Gehalt!",jobSetupTable[jobID][8]),thePlayer,255,0,0)
            end
        end

        return betragDirekt,betragPayDay

    else
        return false
    end
end

function getSkill(thePlayer)
    outputChatBox("Deine Skilllevel: ",thePlayer, 0 ,255 ,0)
    for theKey, theJobTable in pairs(jobSetupTable) do
        local restausgabe=""
        if(vioGetElementData(thePlayer,jobSetupTable[theKey][1].."Skill")<5)then
            local need=theJobTable[2][vioGetElementData(thePlayer,jobSetupTable[theKey][1].."Skill")+1]
            local has=vioGetElementData(thePlayer,jobSetupTable[theKey][1].."SkillPoints")
            restausgabe=string.format("(%s Skillpunkte zum nächsten Level)",(need-has))
        end
        outputChatBox(string.format("%s: %s %s",jobSetupTable[theKey][8], vioGetElementData(thePlayer,jobSetupTable[theKey][1].."Skill"), restausgabe ),thePlayer,0,255,0)
    end
end
addCommandHandler("skill",getSkill,false,false)


wetterSkillTexte={
    ["hoeher"]={
        [1]="Durch eine Atomkatastrophe erhälst du ein höheres Gehalt",
        [2]="Durch eine Flut erhälst du ein höheres Gehalt",
        [3]="Durch die Flut und die Atomkatastrophe erhälst du ein höheres Gehalt",
        [4]="Durch eine Ölpest erhälst du ein höheres Gehalt",
        [5]="Durch einen anhaltenden sauberen Regen erhälst du ein höheres Gehalt",
        [6]="Durch die verbesserte Umweltqualität erhälst du ein höheres Gehalt",
        [7]="Durch Personalmangen wegen Streiks erhälst du ein höheres Gehalt",
        [8]="Durch eine Hitzewelle erhälst du ein höheres Gehalt",
    },
    ["geringer"]={
        [1]="Durch eine Atomkatastrophe erhälst du ein geringeres Gehalt",
        [2]="Durch eine Flut erhälst du ein geringeres Gehalt",
        [3]="Durch die Flut und die Atomkatastrophe erhälst du ein geringeres Gehalt",
        [4]="Durch eine Ölpest erhälst du ein geringeres Gehalt",
        [5]="Durch einen anhaltenden sauberen Regen erhälst du ein geringeres Gehalt",
        [6]="Durch die verbesserte Umweltqualität erhälst du ein geringeres Gehalt",
        [7]="Durch Personalmangen wegen Streiks erhälst du ein geringeres Gehalt",
        [8]="Durch eine Hitzewelle erhälst du ein geringeres Gehalt",
    }
}








