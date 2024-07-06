Coin = Object:extend()

function Coin:new(x, y, width, height, tPos)
    self.x, self.y, self.width, self.height = x, y, width, height
    self.tPos = tPos

    self.collider = world:newCircleCollider(x + 8, y + 8, 8)
    self.collider:setCollisionClass("Collectible")
    self.collider:setType("static")
    self.collider:setObject(self)

    -- Set animations (use anim8)
    self.spritesheet = love.graphics.newImage(spriteSheet)
    self.grid = anim8.newGrid(16, 16, self.spritesheet:getWidth(), self.spritesheet:getHeight())
    self.animations = {}
    self.animations.idle = anim8.newAnimation(self.grid(3, 1), 0.8)
    self.anim = self.animations.idle
end

function Coin:update(dt)
    self.anim:update(dt)
end

function Coin:draw()
    self.anim:draw(self.spritesheet, self.x, self.y)
end

function Coin:collect()
    -- Add a point to the player stats
    player.points = player.points + 1
    -- Delete collider
    self.collider:destroy()
    -- Delete object coin in table 
    session.coins[self.tPos] = nil
end