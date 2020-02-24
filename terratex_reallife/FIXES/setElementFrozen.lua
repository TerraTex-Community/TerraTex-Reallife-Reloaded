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









