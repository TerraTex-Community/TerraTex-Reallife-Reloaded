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









