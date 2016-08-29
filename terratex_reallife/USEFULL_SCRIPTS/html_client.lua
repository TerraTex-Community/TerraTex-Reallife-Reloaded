--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 29.08.2016
-- Time: 15:40
-- To change this template use File | Settings | File Templates.
--

local HTML = {};

--- Functions deletes and escapes symboles in html for using in javascript and replaces args
function HTML.prepare(html, varTable)
    if (varTable) then
        for theKey, theContent in pairs(varTable) do
            html = string.gsub(html, "%%" .. theKey .. "%%", theContent)
        end
    end

    html = string.gsub(html, '"', '\\"');
    html = string.gsub(html, '\n', '');
    html = string.gsub(html, '\r', '');

    return html
end

function HTML.getFile(path)
    local htmlFile = fileOpen(path, true);

    if htmlFile then
        local html = "";
        while not fileIsEOF(htmlFile) do
            html = html .. fileRead(htmlFile, 500);
        end
        fileClose(htmlFile)

        return html;
    else
        return false
    end
end