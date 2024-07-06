Map = Object:extend()

require "objects.platforms"
require "objects.collectibles"
require "objects.keys"
require "objects.door"

function Map:new(luaMap)
    -- Load map (sti library)
    local sti = require "libraries.sti"
    self.sti = sti(luaMap)
end

function Map:update(dt)
    -- Update coins
    for _, coin in pairs(session.coins) do
        coin:update(dt)
    end

    -- Update Enemies
    for _, enemy in pairs(session.enemies) do
        enemy:update(dt)
    end

    -- Update Keys
    for _, obj in pairs(session.keys) do
        obj:update(dt)
    end
end

function Map:draw()
    -- Draw map
    self.sti:draw()

    -- Draw all the map elements
    -- Draw coins
    for _, coin in pairs(session.coins) do
        coin:draw()
    end

    -- Draw Enemies
    for _, enemy in pairs(session.enemies) do
        enemy:draw()
    end

    -- Draw keys
    for _, obj in pairs(session.keys) do
        obj:draw()
    end
end