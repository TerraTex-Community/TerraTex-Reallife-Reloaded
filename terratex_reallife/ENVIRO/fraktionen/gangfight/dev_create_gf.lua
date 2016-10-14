--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 14.10.2016
-- Time: 13:34
-- To change this template use File | Settings | File Templates.
--

local Name = false;
local Type = false;
local X,Y,Z = false, false, false;
local ASpawnX,ASpawnY,ASpawnZ = false, false, false;
local RSmall = false;
local RLarge = false;

function admin_gf_cmd(thePlayer, cmd, cmdExtend, value, ...)
    if (isAdminLevel(thePlayer, 4)) then
        if (cmdExtend == 'help') then
            outputChatBox('Options: sname, stype, sspawn, spos, srsmall, srlarge, create, reset');
            local notSet = {};
            if (not Name) then
                table.insert(notSet, 'sname');
            end
            if (not Type) then
                table.insert(notSet, 'stype');
            end
            if (not X) then
                table.insert(notSet, 'spos');
            end
            if (not ASpawnX) then
                table.insert(notSet, 'sspawn');
            end
            if (not RSmall) then
                table.insert(notSet, 'srsmall');
            end
            if (not RLarge) then
                table.insert(notSet, 'srlarge');
            end
            outputChatBox('Not done yet: ' .. table.concat(notSet, ', '));

        elseif (cmdExtend == 'spos') then
            X,Y,Z = getElementPosition(thePlayer);
            outputChatBox("Position saved!");

        elseif (cmdExtend == 'sspawn') then
            ASpawnX,ASpawnY,ASpawnZ = getElementPosition(thePlayer);
            outputChatBox("Spawn Position saved!");

        elseif (cmdExtend == 'reset') then
            admin_gf_reset();
            outputChatBox("Data reseted!");

        elseif (cmdExtend == 'create') then
            local notSet = {};
            if (not Name) then
                table.insert(notSet, 'sname');
            end
            if (not Type) then
                table.insert(notSet, 'stype');
            end
            if (not X) then
                table.insert(notSet, 'spos');
            end
            if (not ASpawnX) then
                table.insert(notSet, 'sspawn');
            end
            if (not RSmall) then
                table.insert(notSet, 'srsmall');
            end
            if (not RLarge) then
                table.insert(notSet, 'srlarge');
            end

            if (table.getSize(notSet) > 0) then
                outputChatBox('Not done yet: ' .. table.concat(notSet, ', '));
            else
                MySql.helper.insert('faction_gangfights', {
                    Name = Name,
                    Type = Type,
                    X = X,
                    Y = Y,
                    Z = Z,
                    ASpawnX = ASpawnX,
                    ASpawnY = ASpawnY,
                    ASpawnZ = ASpawnZ,
                    RSmall = RSmall,
                    RLarge = RLarge
                });
                admin_gf_reset();
                outputChatBox("Gangfight created!");
            end

        else
            if not value then
                showError(thePlayer, 'Value missing!');
                return;
            end

            if (cmdExtend == 'sname') then
                Name = value .. ' ' .. table.concat({...}, ' ');
                outputChatBox("Name saved!");
            elseif (cmdExtend == 'stype') then
                Type = value;
                outputChatBox("Type saved!");
            elseif (cmdExtend == 'srsmall') then
                RSmall = value;
                outputChatBox("RSmall saved!");
            elseif (cmdExtend == 'srlarge') then
                RLarge = value;
                outputChatBox("RLarge saved!");
            end
        end
    end
end
addCommandHandler("agf", admin_gf_cmd, false,false)

function admin_gf_reset()
    Name = false;
    Type = false;
    X,Y,Z = false, false, false;
    ASpawnX,ASpawnY,ASpawnZ = false, false, false;
    RSmall = false;
    RLarge = false;
end
