--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 2016-09-04
-- Time: 17:48
-- To change this template use File | Settings | File Templates.
--

function replaceModel()
    local txd = engineLoadTXD("FILES/MODS/blitzer.txd", 1250 )
    engineImportTXD(txd, 1250)
    local dff = engineLoadDFF("FILES/MODS/blitzer.dff", 1250 )
    engineReplaceModel(dff, 1250)
    local col = engineLoadCOL( "FILES/MODS/blitzer.col" )
    engineReplaceCOL( col, 1250 )
    engineSetModelLODDistance(1250, 2020)
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)