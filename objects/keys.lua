Key = Object:extend()

function Key:new(x, y, width, height)
    self.x, self.y, self.width, self.height = x, y, width, height

    self.collider = world:newRectangleCollider(self.x, self.y, self.width, self.height)
    self.collider:setCollisionClass("Key")
    self.collider:setType("static")
    self.collider:setObject(self)

    self.image = love.graphics.newImage("assets/objects/key.png")
end

function Key:update(dt)
    self.x = self.collider:getX() - self.width / 2
    self.y = self.collider:getY() - self.height
end

function Key:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

function Key:destroy()
    for i, o in pairs(session.keys) do
        if o == self then
            session.keys[i] = nil
            o.collider:destroy()
        end
    end
end