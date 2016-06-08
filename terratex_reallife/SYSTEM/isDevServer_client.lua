--
-- Created by IntelliJ IDEA.
-- User: accow
-- Date: 13.02.14
-- Time: 16:11
-- To change this template use File | Settings | File Templates.
--

local isDevServerV=false
addEvent("recieveNewDevState",true)
function setDevServer()
    isDevServerV=true
end
addEventHandler("recieveNewDevState",getRootElement(),setDevServer)

function isDevServer() return isDevServerV end








