Enemy = Object:extend()

require "objects.hangenemy"
require "objects.groundenemy"

function Enemy:new(x, y, width, height, level)
    self.x, self.y, self.width, self.height, self.level = x, y, width, height, level
    self.spritesheet = love.graphics.newImage(enemiesSpriteSheet)
    self.grid = anim8.newGrid(16, 16, self.spritesheet:getWidth(), self.spritesheet:getHeight())

    self.collider = world:newRectangleCollider(self.x, self.y, self.width, self.height)
    self.collider:setCollisionClass("Enemy")
    self.collider:setObject(self)
end

function Enemy:update(dt)
end

function Enemy:draw()
end