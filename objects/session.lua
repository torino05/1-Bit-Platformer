-- This object keeps track of the game session,
-- which includes world, maps, player

Session = Object:extend()

require "objects.player"
require "objects.enemies"
require "objects.maps"

function Session:new()
    -- Create world and collider classes (winfield library)
    world = wf.newWorld(0, 0, true)
    world:setGravity(0, 512)
    world:addCollisionClass("Platform")
    world:addCollisionClass("Collectible")
    world:addCollisionClass("Enemy", {ignores = {"Enemy"}})
    world:addCollisionClass("Trap")
    world:addCollisionClass("Door")
    world:addCollisionClass("Key")
    world:addCollisionClass("Player", {ignores = {"Collectible", "Enemy", "Door", "Key"}})

    -- Set player and stats
    player = Player(playerX0, playerY0, playerWidth, playerHeight)
    self.gameCoins = 0

    -- Set map (includes platforms, coins)
    self.mapIndex = 1
    self:loadMap(self.mapIndex)
end

function Session:update(dt)
    world:update(dt)
    self.currentMap:update(dt)
    player:update(dt)
end

function Session:draw()
    self.currentMap:draw()
    player:draw()
end

function Session:nextMap()
        -- Destroy old map
        session:destroyMap()

        -- Load new map
        session.mapIndex = session.mapIndex + 1
        session:loadMap(session.mapIndex)

        -- Reposition player
        player.collider:setX(0)
        player.collider:setY(player.y)
end

function Session:loadMap(i)
    self.currentMap = Map("assets/maps/map-" .. i .. ".lua")
    self:loadPlatforms()
    self:loadCoins()
    self:loadEnemies()
    self:loadKeys()
    self:loadDoors()
end

function Session:destroyMap()
    self:destroyPlatforms()
    self:destroyCoins()
    self:destroyEnemies()
    self:destroyKeys()
    self:destroyDoors()
end

function Session:loadPlatforms()
    self.platforms = {}
    if self.currentMap.sti.layers["Platforms"] then
        for _, obj in pairs(self.currentMap.sti.layers["Platforms"].objects) do
            table.insert(self.platforms, Platform(obj.x, obj.y, obj.width, obj.height))
        end
    end
end

function Session:loadCoins()
    self.coins = {}
    if self.currentMap.sti.layers["Coins"] then
        for i, obj in pairs(self.currentMap.sti.layers["Coins"].objects) do
            local coin = Coin(obj.x, obj.y, obj.width, obj.height, i)
            self.coins[i] = coin
            self.gameCoins = self.gameCoins + 1
        end
    end
end

function Session:loadEnemies()
    self.enemies = {}
    -- Load small enemies
    if self.currentMap.sti.layers["hangEnemy"] then
        for _, obj in pairs (self.currentMap.sti.layers["hangEnemy"].objects) do
            local enemy = HangEnemy(obj.x, obj.y, obj.width, obj.height, obj.properties["level"])
            table.insert(self.enemies, enemy)
        end
    end

    -- Load big enemies
    if self.currentMap.sti.layers["groundEnemy"] then
        for _, obj in pairs (self.currentMap.sti.layers["groundEnemy"].objects) do
            local enemy = GroundEnemy(obj.x, obj.y, obj.width, obj.height, obj.properties["level"])
            table.insert(self.enemies, enemy)
        end
    end
end

function Session:loadKeys()
    self.keys = {}
    if self.currentMap.sti.layers["Keys"] then
        for _, obj in pairs (self.currentMap.sti.layers["Keys"].objects) do
            table.insert(self.keys, Key(obj.x, obj.y, obj.width, obj.height))
        end
    end
end

function Session:loadDoors()
    self.doors = {}
    if self.currentMap.sti.layers["Doors"] then
        for _, obj in pairs (self.currentMap.sti.layers["Doors"].objects) do
            table.insert(self.doors, Door(obj.x, obj.y, obj.width, obj.height))
        end
    end
end

function Session:destroyPlatforms()
    for i, platform in pairs(self.platforms) do
        platform.collider:destroy()
        self.platforms[i] = nil
    end
end

function Session:destroyCoins()
    for i, coin in pairs(self.coins) do
        coin.collider:destroy()
        self.coins[i] = nil
    end
end

function Session:destroyEnemies()
    for i, enemy in pairs(self.enemies) do
        enemy.collider:destroy()
        self.enemies[i] = nil
    end
end

function Session:destroyKeys()
    for i, obj in pairs(self.keys) do
        obj.collider:destroy()
        self.keys[i] = nil
    end
end

function Session:destroyDoors()
    for i, obj in pairs(self.doors) do
        obj.collider:destroy()
        self.doors[i] = nil
    end
end