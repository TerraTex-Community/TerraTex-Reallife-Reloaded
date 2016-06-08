--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 04.02.14
-- Time: 01:00
-- To change this template use File | Settings | File Templates.
--

function utf_check(String)
    if(utfLen(String)~=string.len(String))then
        return false;
    end
    return true;
end

str_tbl={"!","#","$","(",")","*","+",",","-",".","/","0","1","2","3","4","5","6","7","8","9",":",";","<","=",">","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","[","]","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","{","|","}"}

function randomstring(laenge)
    local n=0
    local zustring=""
    while (n<laenge) do

        newteil=str_tbl[math.random(1,table.getn(str_tbl))]
        zustring=zustring..newteil
        n=n+1
    end
    return zustring

end

str_tblwo={"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}

function RandomStringWithoutSpecial(laenge)
    local n = 0
    local zustring = ""
    while (n < laenge) do
        newteil = str_tblwo[math.random(1, table.getn(str_tblwo))]
        zustring = zustring .. newteil
        n = n + 1
    end
    return zustring
end

function getStringComponents(theString)
    if(theString)then
        local stringtab={}
        local counter=0
        local countera=0
        local countlast
        local zahler=1
        while countera==0 do

            countlast=counter
            counter=string.find(theString,"|",countlast)
            if(counter)then
                stringtab[zahler]=string.sub(theString,countlast,counter-1)
                counter=counter+1
            else
                stringtab[zahler]=string.sub(theString,countlast)
                countera=22
            end
            zahler=zahler+1

        end
        return stringtab
    else
        outputDebugString("ERROR IN GETSTRINGCOMPONENTS: No STRING: "..debug.traceback())
        return false
    end
end


function getStringComponentsDelimited(theString,delemiter)
    if(theString)then
        local stringtab={}
        local counter=0
        local countera=0
        local countlast
        local zahler=1
        while countera==0 do

            countlast=counter
            counter=string.find(theString,delemiter,countlast)
            if(counter)then
                stringtab[zahler]=string.sub(theString,countlast,counter-1)
                counter=counter+1
            else
                stringtab[zahler]=string.sub(theString,countlast)
                countera=22
            end
            zahler=zahler+1

        end
        return stringtab
    else
        outputDebugString("ERROR IN GETSTRINGCOMPONENTS: No STRING: "..debug.traceback())
        return false
    end
end

function string.UpperFirst(eingabeString)
    local firstLetter = string.sub (eingabeString, 1,1)
    local restString =  string.sub (eingabeString, 2)
    local newString= string.upper(firstLetter)..restString
    return newString
end








