--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 16.02.14
-- Time: 16:18
-- To change this template use File | Settings | File Templates.
--

function setAllSchrankenBreakAble()
    --setTimer(setAllSchrankenBreakAble,300000,1)
    local objects=getElementsByType("object")
    local schrankenID=968

    for theKey, theObject in ipairs(objects)do
       if(getElementModel(theObject)==schrankenID)then
           setObjectBreakable(theObject,true)
       end
    end
    outputChatBox("kaputtbar")
end
addEventHandler("onClientRender",getRootElement(),setAllSchrankenBreakAble)









