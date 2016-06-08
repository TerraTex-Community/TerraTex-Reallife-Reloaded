--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 09.02.14
-- Time: 00:52
-- To change this template use File | Settings | File Templates.
--

_setPlayerWantedLevel=setPlayerWantedLevel
function setPlayerWantedLevel(thePlayer, Wanteds)
    if(Wanteds<0)then
        Wanteds=0
    end
    if(Wanteds>6)then
        Wanteds=6
    end
    _setPlayerWantedLevel(thePlayer,Wanteds)

end








