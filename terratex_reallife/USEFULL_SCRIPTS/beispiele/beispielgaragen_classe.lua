--
-- Created by IntelliJ IDEA.
-- User: accow
-- Date: 24.04.2014
-- Time: 15:14
-- To change this template use File | Settings | File Templates.
--

Garage = {}
Garage.__index = Garage

function Garage:constructor( members, px, py, pz, rx, ry, rz )

    -- Check whether the data are valid
    assert((type(members) == 'table'), 'Bad argument @ \'Garage.constructor\' [Expected table at argument 2, got '..type(members)..']')
    assert((type(px) == 'number'), 'Bad argument @ \'Garage.constructor\' [Expected table at argument 3, got '..type(px)..']')
    assert((type(py) == 'number'), 'Bad argument @ \'Garage.constructor\' [Expected table at argument 4, got '..type(py)..']')
    assert((type(pz) == 'number'), 'Bad argument @ \'Garage.constructor\' [Expected table at argument 5, got '..type(pz)..']')
    assert((type(rx) == 'number'), 'Bad argument @ \'Garage.constructor\' [Expected table at argument 6, got '..type(rx)..']')
    assert((type(ry) == 'number'), 'Bad argument @ \'Garage.constructor\' [Expected table at argument 7, got '..type(ry)..']')
    assert((type(rz) == 'number'), 'Bad argument @ \'Garage.constructor\' [Expected table at argument 8, got '..type(rz)..']')

    -- Calculation of the coordinates
    local gx = px+4.3*math.cos(math.rad(rz+90))
    local gy = py+4.3*math.sin(math.rad(rz+90))

    -- Creation of the Instance
    self.owner = owner
    self.members = members
    self.state = false
    self.positions = { garage = { px, py, pz }, gate = { gx, gy, pz-0.4 } }
    self.rotations = { garage = { rx, ry, rz }, gate = { rx, ry, rz+90 } }
    self.garage = createObject( 17950, px, py, pz, rx, ry, rz )
    self.gate = createObject( 17951, gx, gy, pz-0.4, rx, ry, rz+90 )
    setObjectScale( self.gate, 1.02 )

end

function Garage:destructor()
    destroyElement( self.garage )
    destroyElement( self.gate )
    self = nil
end

function Garage:isOpen( )
    return ( self.state )
end

function Garage:setOpen( member )
    if ( not table.find( self.members, member ) ) then return end
    local x, y, z = unpack( self.positions.gate )
    local state = self.state
    local rz = self.rotations.gate[3]
    self.state = not state

    if state then
        moveObject( self.gate, 2500, x, y, z, 0, 90, 0 )
    else
        local x = x - 1 * math.cos( math.rad( rz ) )
        local y = y - 1 * math.sin( math.rad( rz ) )
        moveObject( self.gate, 2500, x, y, z+1.8, 0, -90, 0 )
    end
end


function Garage:addMember( member )
    assert((type(member) == 'string'), 'Bad argument \'Garage.addMember\' [Expected string at argument 1, got '..type(member)..']')
    if ( not table.find( self.members, member ) ) then
        table.insert( self.members, member )
        return true
    else
        return false
    end
end

function Garage:removeMember( member )
    assert((type(member) == 'string'), 'Bad argument \'Garage.removeMember\' [Expected string at argument 1, got '..type(member)..']')
    local key = table.find( self.members, member )
    if ( key ) then
        table.remove( self.members, key )
        return true
    else
        return false
    end
end

function Garage:getMembers( )
    return ( self.members )
end








