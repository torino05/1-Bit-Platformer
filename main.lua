function love.load()
    -- Load libraries
    Object = require "libraries.classic.classic"
    wf = require "libraries.windfield"
    push = require "libraries.push.push"
    anim8 = require "libraries.anim8.anim8"

    -- Load dependencies
    require "globals"
    require "objects.ui"
    require "objects.session"

    -- Set a pixelated look
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Set window and game size (push library)
    push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, resizable = false})

    -- Set UI
    userInterface = UI()
    screenInfo = ScreenInfo()

    -- Create new session
    session = Session()
end

function love.update(dt)
    userInterface:update(dt)
    session:update(dt)
end

function love.draw()
    push:start()
    session:draw()
    userInterface:draw()
    push:finish()
end

function love.keypressed(key)
    player:keyPressed(key)
end