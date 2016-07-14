-- vioGetElementData(thePlayer,"lastHouse")
local childNames = {"Tennille","Gabrielle","Deidra","Billye","Marisol","Dina","Les","Shakira","Alene","Virginia","Tiffiny","Mechelle","Karla","Kanesha","Lorena","Libbie","Kenton","Emmaline","Shayla","Lala","Berniece","Devin","Della","Samatha","Inez","Karrie","Regenia","Ricardo","Maritza","Markita","Neda","Johna","Hermelinda","Cristine","Kristyn","Maranda","Simonne","Katlyn","Aracelis","Ruthann","Aliza","Desire","Michael","Louisa","Isaiah","Julie","Phoebe","Adaline","Jeff","Forest","Una","Exie","Kimiko","Marlys","Dell","Oralee","Trisha","Kamala","Yun","Camille","Linda","Luvenia","Fidelia","Kathy","Cortney","Tuyet","Demetrice","Bunny","Cyril","Bethany","Kylee","Leo","Ella","Sau","Sherika","Graham","Hazel","Sanda","Tianna","Vito","Kathaleen","Elouise","Lili","Allegra","Pierre","Elli","Jeanie","Celena","Tamela","Karyn","Marybeth","Hee","Rosie","Cleora","Aron","Galen","Billi","Dacia","Eva","Carolin","Lanie","Garland","Lucy","Priscila","Monserrate","Marsha","Rhoda","Walton","Zulma","Aubrey","Sulema","Bessie","Merry","Jae","Vincent","Kyoko","Brain","Rosetta","Arnette","Drusilla","Machelle","Doria","Rosann","Yung","Georgann","Haley","Tonda","Bo","Graciela","Keely","Yajaira","My","Tam","Rosaline","Mariko","Adella","Jacquelyn","Aurelio","Heath","Kellye","Sofia","Sheryll","Melany","Lou","Shantell","Nakisha","Clementina","Pearly","Keira","Rana","Hilma","Corrin","Magdalene","Many","Guillermina","Lorita","Maira","Nelida","Suzanna","Gia","Natalie","Laurette","Luci","Vance","Lavelle","Jamey","Ariane","Larraine","Nathanael","Amberly","Elijah","Yuko","Jenette","Lilli","Francoise","Odelia","Dick","Alisia","Rachell","Loralee","Roland","Odessa","Coleen","Penni","Ida","Roman","Jared","Leroy","Klara","Marilou","Chante","Madalyn","Ute","Titus","Van","Jessenia","Deb","Lorri","Eunice","Evie","Loise","Gaylene","Oliva","Johnette","Fredia","Tobie","Sandie","Sol","Melida","Harvey","Arielle","Emma","Kendra","Lorrine","Liliana","Jolie","Edda","Eleonor","Ngoc","Wes","Ariana","Dante","Shelley","Antonette","Pasquale","Emmett","Keven","Julieta","Hertha","Bertram","Marcy","Darla","Jesusa","Numbers","Malik","Kasie","Arline","Kellee","Debbra","Joselyn","Katie","Maurice","Willis","Marylyn","Adriane","Mabelle","Dulcie","Lorenzo","Lewis","Nery"}

function sex_func(thePlayer, cmd, toPlayerName)
    if (toPlayerName) then
        local toPlayer = getPlayerFromIncompleteName(toPlayerName)
        if (toPlayer) then
            if (thePlayer ~= toPlayer) then
                if (vioGetElementData(thePlayer, "job") == 16) then
                    if (isPlayerInAnyHouse(thePlayer) or arePlayersInSameVehicle(thePlayer, toPlayer)) then
                        local p1x, p1y, p1z = getElementPosition(thePlayer)
                        local p2x, p2y, p2z = getElementPosition(toPlayer)
                        if (getDistanceBetweenPoints3D(p1x, p1y, p1z, p2x, p2y, p2z) < 5) then
                            vioSetElementData(toPlayer, "sexAngebotVon", thePlayer)
                            outputChatBox(string.format("Die Nutte %s hat dir Sex angeboten! (annehmen mit '/accept sex')", getPlayerName(thePlayer)), toPlayer)
                            outputChatBox(string.format("Du hast dem Spieler %s Sex angeboten!", getPlayerName(toPlayer)), thePlayer)
                        else
                            showError(thePlayer, "Ihr beide seit nicht beeinander!")
                        end
                    else
                        showError(thePlayer, "Sie müssen in einen Fahrzeug sein oder in einem Haus um Sex zu haben!")
                    end
                elseif (vioGetElementData(toPlayer, "DBID") == vioGetElementData(thePlayer, "verheiratet")) then
                    if (isPlayerInAnyHouse(thePlayer) or arePlayersInSameVehicle(thePlayer, toPlayer)) then
                        local p1x, p1y, p1z = getElementPosition(thePlayer)
                        local p2x, p2y, p2z = getElementPosition(toPlayer)
                        if (getDistanceBetweenPoints3D(p1x, p1y, p1z, p2x, p2y, p2z) < 5) then
                            vioSetElementData(toPlayer, "sexAngebotVon", thePlayer)
                            outputChatBox(string.format("Dein Ehepartner %s hat dir Sex angeboten! (annehmen mit '/accept sex')", getPlayerName(thePlayer)), toPlayer)
                            outputChatBox(string.format("Du hast deinem Ehepartner %s Sex angeboten!", getPlayerName(toPlayer)), thePlayer)
                        else
                            showError(thePlayer, "Ihr beide seit nicht beeinander!")
                        end
                    else
                        showError(thePlayer, "Sie müssen in einen Fahrzeug sein oder in einem Haus um Sex zu haben!")
                    end
                else
                    showError(thePlayer, "Du kannst kein Sex mit dieser Person haben!")
                end
            else
                showError(thePlayer, "Selbstbefriedigung ist zwar schön, befriedigt aber nicht so toll wie Sex mit einem Partner.\nSuch dir einen Partner.")
            end
        else
            showError(thePlayer, "Dieser Spieler existiert nicht!")
        end
    else
        showError(thePlayer, "Usage: /sex [Spielername]")
    end
end

addCommandHandler("sex", sex_func, false, false)

function arePlayersInSameVehicle(thePlayer, toPlayer)
    if (isPedInVehicle(thePlayer) and isPedInVehicle(toPlayer)) then
        if (getPedOccupiedVehicle(thePlayer) == getPedOccupiedVehicle(toPlayer)) then
            return true
        else
            return false
        end
    else
        return false
    end
end

function accept_sex(thePlayer)
    if (vioGetElementData(thePlayer, "sexAngebotVon")) then
        local toPlayer = vioGetElementData(thePlayer, "sexAngebotVon")
        if (toPlayer) then
            local p1x, p1y, p1z = getElementPosition(thePlayer)
            local p2x, p2y, p2z = getElementPosition(toPlayer)
            if (vioGetElementData(toPlayer, "job") == 16) then
                if (isPlayerInAnyHouse(thePlayer) or arePlayersInSameVehicle(thePlayer, toPlayer)) then
                    local p1x, p1y, p1z = getElementPosition(thePlayer)
                    local p2x, p2y, p2z = getElementPosition(toPlayer)
                    if (getDistanceBetweenPoints3D(p1x, p1y, p1z, p2x, p2y, p2z) < 5) then
                        vioSetElementData(thePlayer, "sexAngebotVon", false)
                        local usedKondom = false
                        if (vioGetElementData(thePlayer, "Kondome") > 0) then
                            vioSetElementData(thePlayer, "Kondome", vioGetElementData(thePlayer, "Kondome") - 1)
                            usedKondom = true
                        elseif (vioGetElementData(toPlayer, "Kondome") > 0) then
                            vioSetElementData(toPlayer, "Kondome", vioGetElementData(toPlayer, "Kondome") - 1)
                            usedKondom = true
                        end
                        if (usedKondom or math.random(1, 2) ~= 2) then
                            triggerClientEvent(thePlayer, "stopFoodTimerForSeconds", thePlayer, 300)
                            triggerClientEvent(toPlayer, "stopFoodTimerForSeconds", toPlayer, 300)

                            triggerClientEvent(thePlayer, "addFood", thePlayer, 25)
                            triggerClientEvent(toPlayer, "addFood", toPlayer, 25)


                            outputChatBox("Ihr hattet gerade Sex und seid so gut drauf, dass ihr nun 5 Minuten nichts essen müsst!", thePlayer, 0, 255, 0)
                            outputChatBox("Ihr hattet gerade Sex und seid so gut drauf, dass ihr nun 5 Minuten nichts essen müsst!", toPlayer, 0, 255, 0)
                        else
                            triggerClientEvent(thePlayer, "krankheitsreduce", thePlayer)
                            triggerClientEvent(toPlayer, "krankheitsreduce", toPlayer)
                            if (getElementHealth(thePlayer) > 25) then setElementHealth(thePlayer, 25) end
                            if (getElementHealth(toPlayer) > 25) then setElementHealth(toPlayer, 25) end
                            outputChatBox("Da ihr keine Kondome hattet, habt ihr eine Geschlechtskrankheit bekommen!", thePlayer, 0, 255, 0)
                            outputChatBox("Da ihr keine Kondome hattet, habt ihr eine Geschlechtskrankheit bekommen!", toPlayer, 0, 255, 0)
                        end
                        if not (arePlayersInSameVehicle(thePlayer, toPlayer)) then
                            local x, y, z = getElementPosition(toPlayer)
                            setElementPosition(thePlayer, x, y, z)
                            local rx, ry, rz = getElementRotation(toPlayer)
                            setElementRotation(thePlayer, rx, ry, rz)
                            setPedAnimation(thePlayer, "sex", "sex_1_cum_w", 1, true, false)
                            setPedAnimation(toPlayer, "sex", "sex_1_cum_p", 1, true, false)
                            vioSetElementData(toPlayer, "anim", 1)
                            bindKey(toPlayer, "space", "down", stopanima)
                            showanimtext(toPlayer)

                            vioSetElementData(thePlayer, "anim", 1)
                            bindKey(thePlayer, "space", "down", stopanima)
                            showanimtext(thePlayer)
                        end
                    else
                        showError(thePlayer, "Ihr beide seit nicht beeinander!")
                    end
                else
                    showError(thePlayer, "Sie müssen in einen Fahrzeug sein oder in einem Haus um Sex zu haben!")
                end
            elseif (vioGetElementData(toPlayer, "DBID") == vioGetElementData(thePlayer, "verheiratet")) then
                if (isPlayerInAnyHouse(thePlayer) or arePlayersInSameVehicle(thePlayer, toPlayer)) then

                    if (getDistanceBetweenPoints3D(p1x, p1y, p1z, p2x, p2y, p2z) < 5) then
                        setElementData(thePlayer, "sexAngebotVon", false)
                        local usedKondom = false
                        if (vioGetElementData(thePlayer, "Kondome") > 0) then
                            vioSetElementData(thePlayer, "Kondome", vioGetElementData(thePlayer, "Kondome") - 1)
                            usedKondom = true
                        elseif (vioGetElementData(toPlayer, "Kondome") > 0) then
                            vioSetElementData(toPlayer, "Kondome", vioGetElementData(toPlayer, "Kondome") - 1)
                            usedKondom = true
                        end
                        if (usedKondom or math.random(1, 4) ~= 2) then
                            triggerClientEvent(thePlayer, "stopFoodTimerForSeconds", thePlayer, 300)
                            triggerClientEvent(toPlayer, "stopFoodTimerForSeconds", toPlayer, 300)

                            triggerClientEvent(thePlayer, "addFood", thePlayer, 50)
                            triggerClientEvent(toPlayer, "addFood", toPlayer, 50)

                            outputChatBox("Ihr hattet gerade Sex und seid so gut drauf, dass ihr nun 5 Minuten nichts essen müsst!", thePlayer, 0, 255, 0)
                            outputChatBox("Ihr hattet gerade Sex und seid so gut drauf, dass ihr nun 5 Minuten nichts essen müsst!", toPlayer, 0, 255, 0)
                        else
                            local childs = vioGetElementData(thePlayer, "children")
                            local child = {name = childNames[math.random(1, table.getSize(childNames))], years = math.random(18,30)};
                            table.insert(childs, child)
                            vioSetElementData(thePlayer, "children", childs)

                            childs = vioGetElementData(toPlayer, "children")
                            table.insert(childs, child)
                            vioSetElementData(toPlayer, "children", childs)

                            local message = "Ihr habt ein Kind gezeugt. Ihr/Sein Name ist ".. child ..". Es wird die nächsten " .. child.years .." Jahre auf eurer Tasche liegen!";
                            outputChatBox(message, thePlayer)
                            outputChatBox(message, toPlayer)
                        end
                        if not (arePlayersInSameVehicle(thePlayer, toPlayer)) then
                            local x, y, z = getElementPosition(toPlayer)
                            setElementPosition(thePlayer, x, y, z)
                            local rx, ry, rz = getElementRotation(toPlayer)
                            setElementRotation(thePlayer, rx, ry, (180 - rz))
                            setPedAnimation(thePlayer, "sex", "sex_1_cum_w", 1, true, false)
                            setPedAnimation(toPlayer, "sex", "sex_1_cum_p", 1, true, false)
                            vioSetElementData(toPlayer, "anim", 1)
                            bindKey(toPlayer, "space", "down", stopanima)
                            showtext(toPlayer)

                            vioSetElementData(thePlayer, "anim", 1)
                            bindKey(thePlayer, "space", "down", stopanima)
                            showtext(thePlayer)
                        end
                    else
                        showError(thePlayer, "Ihr beide seit nicht beeinander!")
                    end
                else
                    showError(thePlayer, "Sie müssen in einen Fahrzeug sein oder in einem Haus um Sex zu haben!")
                end
            else
                showError(thePlayer, "Du kannst kein Sex mit dieser Person haben!")
            end
        else
            showError(thePlayer, "Dir wurde kein Sex angeboten!")
        end
    else
        showError(thePlayer, "Dir wurde kein Sex angeboten!")
    end
end
registerAcceptHandler("sex", accept_sex, {
    requestedDataValues = {"sexAngebotVon"}
});






