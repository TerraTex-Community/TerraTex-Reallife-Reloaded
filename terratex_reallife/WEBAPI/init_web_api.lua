--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 24.11.2016
-- Time: 14:08
-- To change this template use File | Settings | File Templates.
--

function initWebApi()
    local apiAccount;
    if (getAccount ( config["api.user"] )) then
        apiAccount = getAccount ( config["api.user"] );
        setAccountPassword ( apiAccount, config["api.password"] );
    else
        apiAccount = addAccount(config["api.user"], config["api.password"]);
    end

    local aclGroup = aclGetGroup ( "Admin" );
    if (not isObjectInACLGroup ( "user." .. config["api.user"] , aclGroup ))then
        aclGroupAddObject ( aclGroup, "user." .. config["api.user"] );
        aclSave();
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), initWebApi)