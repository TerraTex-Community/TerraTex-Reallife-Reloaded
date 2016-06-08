--
-- Created by IntelliJ IDEA.
-- User: accow
-- Date: 13.02.14
-- Time: 14:55
-- To change this template use File | Settings | File Templates.
--

--[[
-- 0 = Supporter
-- 1 = Moderator
-- 2 = Supper Moderator
-- 3 = Administrator
-- 4 = Serverleitung
-- 5 = Hidden
-- ]]

function isAdminLevel(thePlayer, lvl)
    local console=getElementsByType("console")
    if(thePlayer==console[1])then
        return true
    end

    if(not isElement(thePlayer))then
        outputDebugString("ErrorHelp isAdminLevel: "..debug.traceback())
    end

    if(not(isPlayerLoggedIn(thePlayer)))then
       return false
    end

    local adminlvl=tonumber(getElementData(thePlayer,"adminlvl"))
    local supportlvl=tonumber(getElementData(thePlayer,"SupportLVL"))
    local isDeveloper=tonumber(getElementData(thePlayer,"isDeveloper"))



    if(isDevServer())then
       if(isDeveloper==1)then
          return true
       end
    end

    if(lvl==0 and (supportlvl>0 or adminlvl>0))then
        return true
    end

    if(adminlvl>=lvl and adminlvl>0)then
        return true
    end

    return false
end










