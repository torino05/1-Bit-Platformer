FullScreen = UI:extend()

function FullScreen:new(str1, str2, str3)
    self.str1, self.str2, self.str3 = str1, str2, str3
    self.width = gameWidth
    self.height = gameHeight
    self.x = 0
    self.y = 0

    table.insert(userInterface.elements, self)
end

function FullScreen:update(dt)
end

function FullScreen:draw()
    -- Rectangle border
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)

    -- Rectangle background
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    -- Message
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.printf(self.str1, self.x, self.y + self.height * 0.4, self.width, "center")
    love.graphics.printf(self.str2, self.x, self.y + self.height * 0.4 + 30, self.width, "center")
    love.graphics.printf(self.str3, self.x, self.y + self.height * 0.4 + 60, self.width, "center")
end

