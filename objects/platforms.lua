Platform = Object:extend()

function Platform:new(x, y, width, height)
    self.collider = world:newRectangleCollider(x, y, width, height)
    self.collider:setCollisionClass("Platform")
    self.collider:setType("static")
    self.collider:setObject(self)
end