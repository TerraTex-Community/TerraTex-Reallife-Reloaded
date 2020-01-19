--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 29.08.2016
-- Time: 16:20
-- To change this template use File | Settings | File Templates.
--

function pack(...)
    return {...};
end

function readFile(path)
    local hFile = fileOpen(path)
    if hFile then
        local buffer = ""
        while not fileIsEOF(hFile) do
            buffer = buffer .. fileRead(hFile, 500)
        end
        fileClose(hFile)
        return buffer;
    end
    return false
end
