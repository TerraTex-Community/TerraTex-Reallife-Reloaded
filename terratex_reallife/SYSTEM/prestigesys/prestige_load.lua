prestigeObjects = {}

--- Berechnung Stufengeld: =(6*POTENZ(10;-11))*POTENZ(A1;2)+0,0002*A1+69,444*0,5
function loadPrestigeFromDB()

    local query = "Select * From prestige"
    local result = mysql_query(handler, query)
    local zahler = 0
    if (not result) then
        outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
    else
        zahler = 0
        while (mysql_num_rows(result) > zahler) do
            local dasatz = mysql_fetch_assoc(result)
            -- ID 	x y	z stufe	name preis stufengeld
            prestigeObjects[tonumber(dasatz["ID"])] = {}
            prestigeObjects[tonumber(dasatz["ID"])]["x"] = dasatz["x"]
            prestigeObjects[tonumber(dasatz["ID"])]["y"] = dasatz["y"]
            prestigeObjects[tonumber(dasatz["ID"])]["z"] = dasatz["z"]
            prestigeObjects[tonumber(dasatz["ID"])]["stufe"] = tonumber(dasatz["stufe"])
            prestigeObjects[tonumber(dasatz["ID"])]["name"] = dasatz["name"]
            prestigeObjects[tonumber(dasatz["ID"])]["preis"] = tonumber(dasatz["preis"])
            prestigeObjects[tonumber(dasatz["ID"])]["grundpreis"] = tonumber(dasatz["grundpreis"])
            prestigeObjects[tonumber(dasatz["ID"])]["stufengeld"] = tonumber(dasatz["stufengeld"])


            prestigeObjects[tonumber(dasatz["ID"])]["besitzer"] = MySql.helper.getValueSync("userdata", "Nickname", { prestigeKey = dasatz["ID"] });
            prestigeObjects[tonumber(dasatz["ID"])]["pickup"] = createPickup(dasatz["x"], dasatz["y"], dasatz["z"], 3, 1247, 5000)
            vioSetElementData(prestigeObjects[tonumber(dasatz["ID"])]["pickup"], "prestigeID", tonumber(dasatz["ID"]))
            addEventHandler("onPickupHit", prestigeObjects[tonumber(dasatz["ID"])]["pickup"], showPrestigeInfos)

            local Text = dasatz["name"]
            Text = string.format("%s\nWert: %s", Text, prestigeObjects[tonumber(dasatz["ID"])]["preis"])
            Text = string.format("%s\nStufe: %s", Text, prestigeObjects[tonumber(dasatz["ID"])]["stufe"])
            if (prestigeObjects[tonumber(dasatz["ID"])]["besitzer"]) then
                Text = string.format("%s\nBesitzer: %s", Text, prestigeObjects[tonumber(dasatz["ID"])]["besitzer"])
            end
            setElementShowText(prestigeObjects[tonumber(dasatz["ID"])]["pickup"], { 0, 0, 255, 255 }, Text, false, 15, 1.3, 0.2)
            --outputDebugString(Text)

            if (not (prestigeObjects[tonumber(dasatz["ID"])]["besitzer"]) and prestigeObjects[tonumber(dasatz["ID"])]["stufe"] > 1) then
                prestigeObjects[tonumber(dasatz["ID"])]["preis"] = prestigeObjects[tonumber(dasatz["ID"])]["grundpreis"]
                prestigeObjects[tonumber(dasatz["ID"])]["stufe"] = 1
                local query = "UPDATE prestige SET preis='" .. prestigeObjects[tonumber(dasatz["ID"])]["preis"] .. "',stufe='1' WHERE ID='" .. dasatz["ID"] .. "'"
                mysql_query(handler, query)
            end

            if (tonumber(dasatz["stufe"]) == 1) then
                prestigeObjects[tonumber(dasatz["ID"])]["stufengeld"] = tonumber(dasatz["grundpreis"])
            end

            zahler = zahler + 1
        end

        outputDebugString("# " .. zahler .. " Prestigeobjects loaded!")
        mysql_free_result(result)
    end
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadPrestigeFromDB)

function showPrestigeInfos(thePlayer)
    local id = vioGetElementData(source, "prestigeID")
    local besitzer = prestigeObjects[id]["besitzer"]
    if not (prestigeObjects[id]["besitzer"]) then
        besitzer = "niemanden (Kaufen mit /buyprestige)"
    end
    local wert = math.round(prestigeObjects[id]["preis"])
    local boni = math.round(getPayDayBonus(id), 2)
    showError(thePlayer, string.format("Dieses Prestigeobject gehört %s\nPrestige-Stufe: %s\nWert: %s\nPrestigebonus: %s", besitzer, prestigeObjects[id]["stufe"], wert, boni))
end


function upgradePrestige_func(thePlayer)
    if (vioGetElementData(thePlayer, "prestigeKey") == 0) then
        outputChatBox("Du besitzt kein PrestigeObject!", thePlayer, 255, 0, 0)
    else
        local id = vioGetElementData(thePlayer, "prestigeKey")
        if (getElementsDistance(prestigeObjects[id]["pickup"], thePlayer) < 20) then
            local preis = getUpgradePreis(id)
            if (getPlayerBank(thePlayer) < preis) then
                outputChatBox(string.format("Du hast nicht genügend Geld um das Prestigeobject aufzuwerten!(%s)", toprice(preis)), thePlayer, 255, 0, 0)
            else
                changePlayerBank(thePlayer, -preis, "sonstiges", "Prestigeupgrade")
                prestigeObjects[id]["preis"] = prestigeObjects[id]["preis"] + preis
                prestigeObjects[id]["stufe"] = prestigeObjects[id]["stufe"] + 1
                local query = "UPDATE prestige SET stufengeld='" .. preis .. "',stufe='" .. prestigeObjects[id]["stufe"] .. "',preis='" .. prestigeObjects[id]["preis"] .. "' WHERE ID='" .. id .. "'"
                mysql_query(handler, query)
                outputChatBox(string.format("Du hast dein Prestige auf Stufe %s aufgewertet!", prestigeObjects[id]["stufe"]), thePlayer, 255, 0, 0)
                local Text = prestigeObjects[id]["name"]
                Text = string.format("%s\nWert: %s", Text, toprice(prestigeObjects[id]["preis"]))
                Text = string.format("%s\nStufe: %s", Text, prestigeObjects[id]["stufe"])
                if (prestigeObjects[id]["besitzer"]) then
                    Text = string.format("%s\nBesitzer: %s", Text, prestigeObjects[id]["besitzer"])
                end
                changeElementShowText(prestigeObjects[id]["pickup"], { 0, 0, 255, 255 }, Text)
            end
        else
            showError(thePlayer, "Du bist nicht in der Nähe deines Prestigobjektes")
        end
    end
end

addCommandHandler("upgradeprestige", upgradePrestige_func, false, false)
-- PrestigeUpdate bis zum Release auskommentiert

function infoPrestige_func(thePlayer)
    if (vioGetElementData(thePlayer, "prestigeKey") == 0) then
        outputChatBox("Du besitzt kein PrestigeObject!", thePlayer, 255, 0, 0)
    else
        local id = vioGetElementData(thePlayer, "prestigeKey")
        if (getElementsDistance(prestigeObjects[id]["pickup"], thePlayer) < 20) then
            local preis = getUpgradePreis(id)
            outputChatBox("Dein Nächstes Upgrade kostet: " .. toprice(preis) .. " ", thePlayer, 150, 230, 45)

        else
            showError(thePlayer, "Du bist nicht in der Nähe deines Prestigobjektes")
        end
    end
end

addCommandHandler("upgradeprestigeInfo", infoPrestige_func, false, false)
addCommandHandler("upi", infoPrestige_func, false, false)


function sellprestige_func(thePlayer)
    if (vioGetElementData(thePlayer, "prestigeKey") == 0) then
        outputChatBox("Du besitzt kein PrestigeObject!", thePlayer, 255, 0, 0)
    else
        local id = vioGetElementData(thePlayer, "prestigeKey")
        if (getElementsDistance(prestigeObjects[id]["pickup"], thePlayer) < 20) then
            changePlayerMoney(thePlayer, math.round(prestigeObjects[id]["grundpreis"] / 2, 2), "sonstiges", "Prestigeverkauf")
            vioSetElementData(thePlayer, "prestigeKey", 0)
            prestigeObjects[id]["besitzer"] = false
            outputChatBox("Du hast das Prestigeobject erfolgreich verkauft!", thePlayer, 255, 0, 0)


            local Text = prestigeObjects[id]["name"]
            Text = string.format("%s\nWert: %s", Text, prestigeObjects[id]["preis"])
            Text = string.format("%s\nStufe: %s", Text, prestigeObjects[id]["stufe"])
            if (prestigeObjects[id]["besitzer"]) then
                Text = string.format("%s\nBesitzer: %s", Text, prestigeObjects[id]["besitzer"])
            end
            changeElementShowText(prestigeObjects[id]["pickup"], { 0, 0, 255, 255 }, Text)
        else
            showError(thePlayer, "Du bist nicht in der Nähe deines Prestigobjektes")
        end
    end
end

addCommandHandler("sellprestige", sellprestige_func, false, false)


function sellprestigeto_func(thePlayer, cmd, toPlayerName)
    if (vioGetElementData(thePlayer, "prestigeKey") == 0) then
        outputChatBox("Du besitzt kein PrestigeObject!", thePlayer, 255, 0, 0)
    else
        if (toPlayerName) then
            local toPlayer = getPlayerFromIncompleteName(toPlayerName)
            if (toPlayer) then
                if not (vioGetElementData(toPlayer, "prestigeKey") == 0) then
                    outputChatBox("Der Spieler besitzt bereits ein PrestigeObject!", thePlayer, 255, 0, 0)
                else
                    local id = vioGetElementData(thePlayer, "prestigeKey")
                    if (getElementsDistance(prestigeObjects[id]["pickup"], thePlayer) < 20) then
                        vioSetElementData(thePlayer, "prestigeKey", 0)
                        vioSetElementData(toPlayer, "prestigeKey", id)
                        prestigeObjects[id]["besitzer"] = getPlayerName(toPlayer)
                        outputChatBox(string.format("Du hast das Prestigeobject %s an %s übergeben!", prestigeObjects[id]["name"], getPlayerName(toPlayer)), thePlayer, 255, 0, 0)
                        outputChatBox(string.format("Du hast das Prestigeobject %s von %s erhalten!", prestigeObjects[id]["name"], getPlayerName(thePlayer)), toPlayer, 255, 0, 0)


                        local Text = prestigeObjects[id]["name"]
                        Text = string.format("%s\nWert: %s", Text, prestigeObjects[id]["preis"])
                        Text = string.format("%s\nStufe: %s", Text, prestigeObjects[id]["stufe"])
                        if (prestigeObjects[id]["besitzer"]) then
                            Text = string.format("%s\nBesitzer: %s", Text, prestigeObjects[id]["besitzer"])
                        end
                        changeElementShowText(prestigeObjects[id]["pickup"], { 0, 0, 255, 255 }, Text)
                    else
                        showError(thePlayer, "Du bist nicht in der Nähe deines Prestigobjektes")
                    end
                end
            else
                outputChatBox("Der Spieler existiert nicht!", thePlayer, 255, 0, 0)
            end
        else
            outputChatBox("Usage: /giveprestige [toName]", thePlayer, 255, 0, 0)
        end
    end
end

addCommandHandler("giveprestige", sellprestigeto_func, false, false)

function buyprestige_func(thePlayer)
    local x, y, z = getElementPosition(thePlayer)
    local id = false
    for theKey, theprestige in pairs(prestigeObjects) do
        local dis = getDistanceBetweenPoints3D(x, y, z, theprestige["x"], theprestige["y"], theprestige["z"])
        if (dis < 5) then
            id = theKey
        end
    end
    if (id) then
        if not (vioGetElementData(thePlayer, "prestigeKey") == 0) then
            outputChatBox("Du besitzt bereits ein PrestigeObject! (Verkaufen mit /sellprestige)", thePlayer, 255, 0, 0)
        else
            local preis = prestigeObjects[id]["preis"]
            if (not (prestigeObjects[id]["besitzer"])) then
                if (getPlayerMoney(thePlayer) < preis) then
                    outputChatBox("Du hast nicht genug Geld bei dir um dieses Prestigeobject zu kaufen!", thePlayer, 255, 0, 0)
                else
                    changePlayerMoney(thePlayer, -preis, "sonstiges", "Prestigekauf")
                    vioSetElementData(thePlayer, "prestigeKey", id)
                    prestigeObjects[id]["besitzer"] = getPlayerName(thePlayer)
                    outputChatBox(string.format("Du hast erfolgreich das Prestigeobject %s gekauft!", prestigeObjects[id]["name"]), thePlayer, 255, 0, 0)



                    local Text = prestigeObjects[id]["name"]
                    Text = string.format("%s\nWert: %s", Text, prestigeObjects[id]["preis"])
                    Text = string.format("%s\nStufe: %s", Text, prestigeObjects[id]["stufe"])
                    if (prestigeObjects[id]["besitzer"]) then
                        Text = string.format("%s\nBesitzer: %s", Text, prestigeObjects[id]["besitzer"])
                    end
                    changeElementShowText(prestigeObjects[id]["pickup"], { 0, 0, 255, 255 }, Text)
                end
            end
        end
    else
        outputChatBox("Du bist nicht in der Nähe eines Prestigeobjectes!", thePlayer, 255, 0, 0)
    end
end

addCommandHandler("buyprestige", buyprestige_func, false, false)

function addPrestige_func(thePlayer, cmd, preis, stufengeld, name, ...)
    if (isAdminLevel(thePlayer, 4)) then
        if (preis) and (stufengeld) and (name) then
            local name = name .. " " .. table.concat({ ... }, " ")
            local preis = tonumber(preis)
            local stufengeld = tonumber(stufengeld)
            if (preis) and (stufengeld) then
                local x, y, z = getElementPosition(thePlayer)
                local query = "INSERT INTO prestige (x,y,z,stufe,name,preis,stufengeld,grundpreis) VALUES ('" .. x .. "','" .. y .. "','" .. z .. "','1','" .. name .. "','" .. preis .. "','" .. stufengeld .. "','" .. preis .. "')"
                local queryhandler = mysql_query(handler, query)
                local newid = mysql_insert_id(handler)
                prestigeObjects[newid] = {}
                prestigeObjects[newid]["x"] = x
                prestigeObjects[newid]["y"] = y
                prestigeObjects[newid]["z"] = z
                prestigeObjects[newid]["stufe"] = 1
                prestigeObjects[newid]["name"] = name
                prestigeObjects[newid]["preis"] = preis
                prestigeObjects[newid]["grundpreis"] = preis
                prestigeObjects[newid]["besitzer"] = false
                prestigeObjects[newid]["pickup"] = createPickup(x, y, z, 3, 1247, 5000)
                vioSetElementData(prestigeObjects[newid]["pickup"], "prestigeID", newid)
                addEventHandler("onPickupHit", prestigeObjects[newid]["pickup"], showPrestigeInfos)

                local Text = prestigeObjects[newid]["name"]
                Text = string.format("%s\nWert: %s", Text, prestigeObjects[newid]["preis"])
                Text = string.format("%s\nStufe: %s", Text, prestigeObjects[newid]["stufe"])
                if (prestigeObjects[newid]["besitzer"]) then
                    Text = string.format("%s\nBesitzer: %s", Text, prestigeObjects[newid]["besitzer"])
                end
                setElementShowText(prestigeObjects[newid]["pickup"], { 0, 0, 255, 255 }, Text, true, 15, 1.3, 0.2)

            else
                outputChatBox("Usage: /addprestige preis stufengeld name", thePlayer, 255, 0, 0)
            end
        else
            outputChatBox("Usage: /addprestige preis stufengeld name", thePlayer, 255, 0, 0)
        end
    end
end

addCommandHandler("addprestige", addPrestige_func, false, false)

function getPayDayBonus(id)

    local payday = 0.000000002 * prestigeObjects[id]["grundpreis"] * prestigeObjects[id]["grundpreis"] + 0.0025 * prestigeObjects[id]["grundpreis"] - 220
    if (prestigeObjects[id]["stufe"] > 1) then
        for i = 2, prestigeObjects[id]["stufe"], 1 do
            payday = payday * math.pow(i, 0.07)
        end
    end
    payday = math.round(payday, 2)
    return payday
end



function getUpgradePreis(id)

    --local payday=0.000000002*prestigeObjects[id]["grundpreis"]*prestigeObjects[id]["grundpreis"]+0.0025*prestigeObjects[id]["grundpreis"]-220
    local start = prestigeObjects[id]["grundpreis"]

    for i = 2, prestigeObjects[id]["stufe"] + 1, 1 do
        start = start * math.pow(i, 0.055)
    end

    start = math.round(start, 2)
    return start
end

-- function prestigeTest(thePlayer,cmd,id)
-- id=tonumber(id)
-- outputChatBox(getPayDayBonus(id))
-- end
-- addCommandHandler("pt",prestigeTest)














