--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 09.02.14
-- Time: 00:57
-- To change this template use File | Settings | File Templates.
--

_setElementFrozen=setElementFrozen
function setElementFrozen(Element,Bool)
    if(Bool==false)then
        setElementVelocity(Element,0,0,0)
    end
    _setElementFrozen(Element,Bool)
end

_setElementPosition=setElementPosition
function setElementPosition(theElement, x , y , z , warp)
    if(warp==nil)then warp=true end
    local preFrozen=isElementFrozen(theElement)

    setElementFrozen(theElement,true)
    _setElementPosition (  theElement, x,y,z ,warp)
    setElementFrozen(theElement,preFrozen)

end









