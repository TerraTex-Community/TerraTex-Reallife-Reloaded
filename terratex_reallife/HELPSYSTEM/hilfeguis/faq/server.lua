local faq = {}

function loadFAQ()
    local query = "SELECT * FROM data_faq LEFT JOIN data_faq_category ON data_faq_category.ID = data_faq.katID ORDER BY data_faq_category.Order";
    local runQuery = dbQuery(MySql._connection, query);
    local result = dbPoll(runQuery, -1);

        local rules = {}
    local katCounter = 0
    local katIDs = {}

    for theKey, daSatz in ipairs(result) do
        -- Antwort Frage kat
        local tmpTable = {}
        local tmpID = katCounter + 1
        if (katIDs[daSatz["kat"]]) then
            tmpID = katIDs[daSatz["kat"]]
        else
            katIDs[daSatz["kat"]] = tmpID
            faq[tmpID] = {
                ["title"] = daSatz["kat"],
                ["rules"] = {},
            }
            katCounter = katCounter + 1
        end

        tmpTable = {
            ["text"] = daSatz["Frage"],
            ["answer"] = daSatz["Antwort"]
        }

        table.insert(faq[tmpID]["rules"], tmpTable)
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadFAQ)

addEvent("sendMeFAQ", true)
function sendMeFAQ_func()
    triggerClientEvent(source, "addFAQ", source, faq)
end
addEventHandler("sendMeFAQ", getRootElement(), sendMeFAQ_func)
