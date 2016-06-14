addEvent("SendeMirMeineEmailsZu", true)
function SendeMirMeineEmailsZu_func()
    local emails = MySql.helper.getSync("user_emails", "*", {Empfaenger = getPlayerName(source)});
    local emailTable = {};

    for theKey, dasatz in ipairs(emails) do
        local readbool = false;
        if (dasatz["neu"] == "1") then
            readbool = true;
        end
        table.insert(emailTable, { dasatz["Empfaenger"], dasatz["Sender"], dasatz["Datum"], dasatz["Betreff"], dasatz["Inhalt"], readbool, tonumber(dasatz["ID"]) });
    end

    triggerClientEvent(source, "hierdeineemails", source, emailTable);
end
addEventHandler("SendeMirMeineEmailsZu", getRootElement(), SendeMirMeineEmailsZu_func)


addEvent("setEMailReaded", true)
function setEMailReaded_func(id)
    MySql.helper.update("user_emails", {neu = 0}, {ID = id});
end
addEventHandler("setEMailReaded", getRootElement(), setEMailReaded_func)

addEvent("deleteEMail", true)
function deleteEMail_func(id)
    MySql.helper.delete("user_emails", {ID = id});
end
addEventHandler("deleteEMail", getRootElement(), deleteEMail_func)

addEvent("sendEMail", true)
function sendEMail_func(empfaenger, betreff, inhalt)
    local sender = getPlayerName(source)
    if (MySql.helper.existSync("user", { Nickname = empfaenger })) then

        if not (vioGetElementData(source, "sendEMailLastSec")) then

            MySql.helper.insert("user_emails", {
                Empfaenger = empfaenger,
                Sender = sender,
                Betreff = betreff,
                Inhalt = inhalt
            });

            outputChatBox("EMail wurde versendet!", source, 0, 255, 0)
            vioSetElementData(source, "sendEMailLastSec", true)
            setTimer(vioSetElementData, 5000, 1, source, "sendEMailLastSec", false)
        else
            outputChatBox("Du kannst nur alle 5 Sekunden eine EMail schreiben!", source, 255, 0, 0)
        end
    else
        outputChatBox("Dieser Empfänger existiert nicht!", source, 255, 0, 0)
    end
end
addEventHandler("sendEMail", getRootElement(), sendEMail_func)