_setElementHealth = setElementHealth
_setPedArmor = setPedArmor

function setPedArmor(element, health)
    if (getElementType(element) == "player") then
        local oldHealth = getElementHealth(element);
        if (oldHealth < health) then
            vioSetElementData(element, "armorControl",health)
        end
        _setPedArmor(element, health);
    else
        _setPedArmor(element, health);
    end
end

function setElementHealth(element, health)
    if (getElementType(element) == "player") then
        local oldHealth = getElementHealth(element);
        if (oldHealth < health) then
            vioSetElementData(element, "healthControl",health)
        end
        _setElementHealth(element, health);
    else
        _setElementHealth(element, health);
    end
end
