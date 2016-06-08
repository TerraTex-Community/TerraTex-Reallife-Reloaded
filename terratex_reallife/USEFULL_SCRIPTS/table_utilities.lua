
function table.removeKey(theTable, index, newkeys)
	if not newkeys then newkeys = false end
	
	local newTable={}
	for theKey,theValue in pairs(theTable) do
		if(not(theKey==index))then
			if(newkeys)then
				table.insert(newTable,theValue)
			else
				newTable[theKey]=theValue
			end
		end		
	end
	
	return newTable

end

function table.deletevalue(thetable,value,newkeys)
    for theKey,theTableValue in ipairs(thetable) do
        if(theTableValue==value)then
            thetable=table.removeKey(thetable,theKey,newkeys)
        end
    end
    return thetable
end

function table.getSize(table)
    local i=0
    for theKey, theContent in pairs(table) do
        i=i+1
    end
    return i
end



function table.getMax(table)
    local i=0
    for theKey, theContent in pairs(table) do
        if(theKey>i)then
            i=theKey
        end
    end
    return i
end

function table.find(tbl, item)
    for key, value in pairs(tbl) do
        if value == item then return key end
    end
    return false
end

function table.hasValue(tbl, item)
    for key, value in pairs(tbl) do
        if value == item then return true end
    end
    return false
end

function table.copy(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
    return res
end



