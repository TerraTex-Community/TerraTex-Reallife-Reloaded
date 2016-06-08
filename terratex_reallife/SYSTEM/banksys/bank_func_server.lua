--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 03.05.14
-- Time: 12:11
-- To change this template use File | Settings | File Templates.
--

--- NUR SERVER

-- Spielertransaktionen zB Übergeben sind mit spieler abgedeckt
local validKategorien = {["job"] = true, ["fahrzeug"] = true, ["spieler"] = true, ["sonstiges"] = true,["fraktion"] = true}

function changePlayerMoney(thePlayer, theBetrag, Kategorie, theReason, theReasonAdd)--Optionale Parameter ab Kategorie
    vioSetElementData(thePlayer, "money", vioGetElementData(thePlayer, "money") + theBetrag)
    setPlayerMoney(thePlayer, vioGetElementData(thePlayer, "money"))
    if (not validKategorien[Kategorie]) then
        Kategorie = "sonstiges"
    end
    saveMoneyLog(thePlayer, "Money", Kategorie, theBetrag, theReason, theReasonAdd)
end

function changePlayerBank(thePlayer, theBetrag, Kategorie, theReason, theReasonAdd)--Optionale Parameter ab Kategorie
    vioSetElementData(thePlayer, "bank", vioGetElementData(thePlayer, "bank") + theBetrag)
    changePlayerUeberweisung(thePlayer, theBetrag)
	-- setPlayerMoney(thePlayer, vioGetElementData(thePlayer, "bank"))
    if (not validKategorien[Kategorie]) then
        Kategorie = "sonstiges"
    end
	saveMoneyLog(thePlayer, "Bank", Kategorie, theBetrag, theReason, theReasonAdd)
end

function changePlayerSpenden(thePlayer, theBetrag)
	vioSetElementData(thePlayer, "ingamespenden", vioGetElementData(thePlayer, "ingamespenden") + theBetrag)
end

function changePlayerUeberweisung(thePlayer, theBetrag)
	vioSetElementData(thePlayer, "ueberweisungssumme", vioGetElementData(thePlayer, "ueberweisungssumme") + theBetrag)
end

function saveMoneyLog(thePlayer, Typ, Kategorie, Betrag, Grund, GrundAdd)
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
	
	
	
    local query = "INSERT INTO playermoney_log (Nickname, UniqueID, Typ, Kategorie, Betrag, Stand, Grund, GrundZusatz, DateStamp) VALUES('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')"
    local query = string.format(query, playerName, playerUUID, Typ, Kategorie, Betrag, Stand, Grund, GrundAdd, timer.timestamp )
    mysql_query(logs_handler, query)
end

function saveMoneyLog_withNickname(thePlayer, Typ, Kategorie, Betrag, Grund, GrundAdd)
    local playerName = thePlayer
    local playerUUID = MySQL_GetString("players","UUID","Nickname='"..thePlayer.."'")
    local timer = getRealTime()
    local Stand = 0
    if (Typ == "Bank") then
        Stand = MySQL_GetVar("userdata","Bank","Nickname='"..thePlayer.."'")
    else
        Stand = MySQL_GetVar("userdata","Geld","Nickname='"..thePlayer.."'")
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



    local query = "INSERT INTO playermoney_log (Nickname, UniqueID, Typ, Kategorie, Betrag, Stand, Grund, GrundZusatz, DateStamp) VALUES('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')"
    local query = string.format(query, playerName, playerUUID, Typ, Kategorie, Betrag, Stand, Grund, GrundAdd, timer.timestamp )
    mysql_query(logs_handler, query)
end








