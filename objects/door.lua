Door = Object:extend()

function Door:new(x, y, width, height)
    self.x, self.y, self.width, self.height = x, y, width, height

    self.collider = world:newRectangleCollider(self.x, self.y, self.width, self.height)
    self.collider:setType("static")
    self.collider:setCollisionClass("Door")
    self.collider:setObject(self)
end

function Door:update(dt)
end

function Door:draw()
end