--
-- Created by IntelliJ IDEA.
-- User: accow
-- Date: 08.05.2014
-- Time: 11:36
-- To change this template use File | Settings | File Templates.
--

IRaum = {}
IRaum.__index = IRaum


function IRaum:constructor(ID,ix,iy,iz,int,preis,qm,stockwerke,wert)
    self.ID=tonumber(ID)
    self.coord={tonumber(ix),tonumber(iy),tonumber(iz) }
    self.int=tonumber(int)
    self.preis=tonumber(preis)
    self.qm=tonumber(qm)
    self.stockwerke=tonumber(stockwerke)
    self.wert=tonumber(wert)
end

function IRaum:getStockwerke()
    return self.stockwerke
end

function IRaum:getWert()
    return self.wert
end

function IRaum:getPreis()
    return self.preis
end

function IRaum:getQM()
    return self.qm
end

function IRaum:getID()
    return self.ID
end

function IRaum:getSpawnCoords()
    return self.coord[1],self.coord[2],self.coord[3],self.int
end








