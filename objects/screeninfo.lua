ScreenInfo = UI:extend()

function ScreenInfo:new()
    table.insert(userInterface.elements, self)
end

function ScreenInfo:update()
end

function ScreenInfo:draw()
    -- UI
    love.graphics.print("Coins: " .. player.points, 10, 10)
    --love.graphics.print("Has key: " .. tostring(player.hasKey), gameWidth - 100, 10)
    love.graphics.print("Health: " .. player.health, 10, 30)
end