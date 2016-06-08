--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 09.02.14
-- Time: 01:11
-- To change this template use File | Settings | File Templates.
--


_outputChatBox=outputChatBox
function outputChatBox(text, visibleTo, r,g,b, colorCoded )

    if not(type(text)=="string" or type(text)=="nil") then
        outputDebugString("Error in outputChatBox Parameter[1]: "..debug.traceback())
    end
    if not(type(visibleTo)=="userdata" or type(visibleTo)=="nil") then
        outputDebugString("Error in outputChatBox Parameter[2]: "..debug.traceback())
    end
    if (not(type(r)=="number" or type(r)=="nil")) then
        outputDebugString("Error in outputChatBox Parameter[3]: "..debug.traceback())
    end
    if (not(type(g)=="number" or type(g)=="nil")) then
        outputDebugString("Error in outputChatBox Parameter[4]: "..debug.traceback())
    end
    if (not(type(b)=="number" or type(b)=="nil")) then
        outputDebugString("Error in outputChatBox Parameter[5]: "..debug.traceback())
    end
    if not(type(colorCoded)=="boolean" or type(colorCoded)=="nil") then
        outputDebugString("Error in outputChatBox Parameter[5]: "..debug.traceback())
    end


    if(not(visibleTo))then
        visibleTo=getRootElement()
    end
    if(isElement(visibleTo))then
        if(r and g and b)then
            if(string.len(text)>120)then
                local bla=string.reverse(text)
                local foundstring=string.find(bla," ",-128)
                local is=string.len(text)-foundstring+2
                local part=string.sub(text,0,is-2)
                local rest=string.sub(text,is)
                if not(colorCoded) then
                    colorCoded=false
                end
                _outputChatBox(part, visibleTo, r,g,b, colorCoded )
                outputChatBox(rest, visibleTo, r,g,b, colorCoded )

            else
                _outputChatBox(text, visibleTo, r,g,b, colorCoded )
            end
        else
            outputChatBox(text, visibleTo, 231, 217, 176, colorCoded )
        end
    end
end














