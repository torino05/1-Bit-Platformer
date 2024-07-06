ScreenFlash = UI:extend()

function ScreenFlash:new(timeLimit)
    --self.message = message
    self.width = gameWidth
    self.height = gameHeight
    self.x = 0
    self.y = 0
    self.start = love.timer.getTime()
    self.timeLimit = timeLimit
end

function ScreenFlash:update(dt)
    -- Delete alert after timeLimit
    if love.timer.getTime() - self.start > self.timeLimit then
        for i, e in pairs(userInterface.elements) do
            if e == self then
                userInterface.elements[i] = nil
            end
        end
    end
end

function ScreenFlash:draw()
    -- Rectangle fill
    love.graphics.setColor(255, 0, 0, .3)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end