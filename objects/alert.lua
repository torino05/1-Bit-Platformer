Alert = UI:extend()

function Alert:new(message, timeLimit)
    self.message = message
    self.width = 200
    self.height = 100
    self.x = gameWidth/2 - self.width / 2
    self.y = gameHeight/2 - self.height / 2
    self.start = love.timer.getTime()
    self.timeLimit = timeLimit
end

function Alert:update(dt)
    -- Delete alert after timeLimit
    if love.timer.getTime() - self.start > self.timeLimit then
        for i, e in pairs(userInterface.elements) do
            if e == self then
                userInterface.elements[i] = nil
            end
        end
    end
end

function Alert:draw()
    -- Rectangle border
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)

    -- Rectangle background
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    -- Message
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.printf(self.message, self.x, self.y + self.height * 0.4, self.width, "center")
end

