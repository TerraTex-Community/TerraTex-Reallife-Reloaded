function clicksysbind()
    if not showCursor(not isCursorShowing()) then
       showCursor(true);
    end
end

function click_func()
    clicksysbind()
end

addEvent("bindclicksys_event", true)
function rebind_func()
    bindKey("ralt", "down", clicksysbind)
    bindKey("i", "down", openInventar)
end
addEventHandler("bindclicksys_event", getRootElement(), rebind_func)
addEventHandler("onClientResourceStart", getRootElement(), rebind_func)
addCommandHandler("rebind", rebind_func, false, false)
