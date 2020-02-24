-- Spielertransaktionen zB Übergeben sind mit spieler abgedeckt
local validKategorien = { ["job"] = true, ["fahrzeug"] = true, ["spieler"] = true, ["sonstiges"] = true, ["fraktion"] = true }
--Optionale Parameter ab Kategorie
function changePlayerMoney(thePlayer, theBetrag, Kategorie, theReason, theReasonAdd, AdditionalData)
    vioSetElementData(thePlayer, "money", vioGetElementData(thePlayer, "money") + theBetrag)
    setPlayerMoney(thePlayer, vioGetElementData(thePlayer, "money"))
    if (not validKategorien[Kategorie]) then
        Kategorie = "sonstiges"
    end
    saveMoneyLog(thePlayer, "Money", Kategorie, theBetrag, theReason, theReasonAdd)
end

--Optionale Parameter ab Kategorie
function changePlayerBank(thePlayer, theBetrag, Kategorie, theReason, theReasonAdd, AdditionalData)
    vioSetElementData(thePlayer, "bank", vioGetElementData(thePlayer, "bank") + theBetrag)
    changePlayerUeberweisung(thePlayer, theBetrag)
    -- setPlayerMoney(thePlayer, vioGetElementData(thePlayer, "bank"))
    if (not validKategorien[Kategorie]) then
        Kategorie = "sonstiges"
    end
    saveMoneyLog(thePlayer, "Bank", Kategorie, theBetrag, theReason, theReasonAdd, AdditionalData)
end

function changePlayerSpenden(thePlayer, theBetrag)
    vioSetElementData(thePlayer, "ingamespenden", vioGetElementData(thePlayer, "ingamespenden") + theBetrag)
end

function changePlayerUeberweisung(thePlayer, theBetrag)
    vioSetElementData(thePlayer, "ueberweisungssumme", vioGetElementData(thePlayer, "ueberweisungssumme") + theBetrag)
end

function saveMoneyLog(thePlayer, Typ, Kategorie, Betrag, Grund, GrundAdd, AdditionalData)
    local playerName = getPlayerName(thePlayer)
    local playerUUID = vioGetElementData(thePlayer, "UniqueID")
    local timer = getRealTime()
    local Stand = 0
    if (Typ == "Bank") then
        Stand = vioGetElementData(thePlayer, "bank")
    else
        Stand = vioGetElementData(thePlayer, "money")
    end

    if not Grund then
        Grund = ""
    end
    if not GrundAdd then
        GrundAdd = ""
    end
    if not Kategorie then
        Kategorie = ""
    end

    MySql.helper.insert("log_playermoney", {
        Nickname = playerName,
        UniqueID = playerUUID,
        Typ = Typ,
        Kategorie = Kategorie,
        Betrag = Betrag,
        Stand = Stand,
        Grund = Grund,
        GrundZusatz = GrundAdd,
        AdditionalData = AdditionalData,
        DateStamp = timer.timestamp
    });
end

function saveMoneyLog_withNickname(thePlayer, Typ, Kategorie, Betrag, Grund, GrundAdd)
    local playerName = thePlayer
    local playerUUID = MySql.helper.getValueSync("user", "UUID", { Nickname = thePlayer });

    local timer = getRealTime()
    local Stand = 0
    if (Typ == "Bank") then
        Stand = MySql.helper.getValueSync("user_data", "Bank", { Nickname = thePlayer });

    else
        Stand = MySql.helper.getValueSync("user_data", "Geld", { Nickname = thePlayer });
    end

    if not Grund then
        Grund = ""
    end
    if not GrundAdd then
        GrundAdd = ""
    end
    if not Kategorie then
        Kategorie = ""
    end

    MySql.helper.insert("log_playermoney", {
        Nickname = playerName,
        UniqueID = playerUUID,
        Typ = Typ,
        Kategorie = Kategorie,
        Betrag = Betrag,
        Stand = Stand,
        Grund = Grund,
        GrundZusatz = GrundAdd,
        DateStamp = timer.timestamp
    });
end
