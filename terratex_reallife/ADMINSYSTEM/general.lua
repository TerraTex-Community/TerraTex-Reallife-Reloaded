--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 13.07.2016
-- Time: 13:36
-- To change this template use File | Settings | File Templates.
--

function admins_func(theMaker, command)
    outputChatBox("Adminliste:", theMaker)
    local adminpre = " "
    local adminList = {}

    if(isAdminLevel(theMaker, 1)) then
        for k, v in ipairs(getPlayersByDataValue("adminlvl", 5)) do table.insert(adminList, v) end
    end

    for k, v in ipairs(getPlayersByDataValue("adminlvl", 1337)) do table.insert(adminList, v) end
    for k, v in ipairs(getPlayersByDataValue("adminlvl", 4)) do table.insert(adminList, v) end
    for k, v in ipairs(getPlayersByDataValue("adminlvl", 3)) do table.insert(adminList, v) end
    for k, v in ipairs(getPlayersByDataValue("adminlvl", 2)) do table.insert(adminList, v) end
    for k, v in ipairs(getPlayersByDataValue("adminlvl", 1)) do table.insert(adminList, v) end
    for k, v in ipairs(getPlayersByDataValue("SupportLVL", 1)) do table.insert(adminList, v) end

    for theKey, thePlayer in ipairs(adminList) do
        if (isPlayerLoggedIn(thePlayer)) then
            if (vioGetElementData(thePlayer, "adminlvl") == 1) then adminpre = "Moderator: " end
            if (vioGetElementData(thePlayer, "adminlvl") == 2) then adminpre = "SuperModerator: " end
            if (vioGetElementData(thePlayer, "adminlvl") == 3) then adminpre = "Administrator: " end
            if (vioGetElementData(thePlayer, "adminlvl") == 4) then adminpre = "Serverleiter: " end
            if (vioGetElementData(thePlayer, "adminlvl") == 5) then adminpre = "[Hidden]: " end
             if (vioGetElementData(thePlayer, "adminlvl") == 1337) then adminpre = "1337 Gott: " end
            if (vioGetElementData(thePlayer, "SupportLVL") > 0) then adminpre = "Supporter: " end
            outputChatBox(adminpre .. getPlayerName(thePlayer), theMaker)
        end
    end
end
addCommandHandler("admins", admins_func, false, false)
