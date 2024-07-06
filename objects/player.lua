Player = Object:extend()

function Player:new(x, y)
    -- Player position and size
    self.x, self.y, self.width, self.height = x, y, playerWidth, playerHeight

    -- Player stats
    self.points = 0
    self.health = 100
    self.hasKey = false

    -- Set animations (use anim8)
    self.spritesheet = love.graphics.newImage(playerSpriteSheet)
    self.grid = anim8.newGrid(self.width, self.height, self.spritesheet:getWidth(), self.spritesheet:getHeight(), 0, 0, 1)
    self.animations = {}
    self.animations.idle = anim8.newAnimation(self.grid(1, "1-4"), 0.2)
    self.animations.sleeping = anim8.newAnimation(self.grid(7, "1-4"), 0.2)
    self.animations.right = anim8.newAnimation(self.grid("2-5", 1), 0.2)
    self.animations.left = self.animations.right:clone():flipH()
    
    -- Animation on start
    self.anim = self.animations.idle
    
    -- Get info from current animation frame
    local frame = self.anim:getFrameInfo()
    local _, _, w, h = frame:getViewport()

    -- Set collider
    self.collider = world:newBSGRectangleCollider(self.x, self.y, w, h, 2)
    self.collider:setCollisionClass("Player")
    self.collider:setObject(self)

    self.collider:setFixedRotation(true)
    self.collider:setMass(playerMass)
end

function Player:update(dt)
    -- Position and speed
    self:position()

    -- Player lose
    self:checkLose()

    -- Movement and animation
    self:input()

    -- Player points
    self:checkPoints()

    -- Player damage
    self:checkDamage()

    -- Go to next map
    self:checkAdvanceMap()

    -- Player takes key 
    self:checkKey()

    -- Open Door
    self:checkDoor()
    
    -- Anim8
    self.anim:update(dt)
end

function Player:draw()
    self.anim:draw(self.spritesheet, self.x, self.y, 0, playerResize, playerResize)
end

function Player:keyPressed(key)
    if key == "space" and self.vy == 0 then
        self.collider:applyLinearImpulse(0, - Fjump, self.x, self.y)
    end
end

function Player:position()
    self.vx, self.vy = self.collider:getLinearVelocity()
    self.x = self.collider:getX() - self.width * 0.5
    self.y = self.collider:getY() - self.height * 0.6
end

function Player:input()
    if love.keyboard.isDown("right") then
        self.anim = self.animations.right
        if self.vx < vxMax then
            self.collider:applyLinearImpulse(Frun, 0)
        end
    elseif love.keyboard.isDown("left") then
        self.anim = self.animations.left
        if - self.vx < vxMax then
            self.collider:applyLinearImpulse(-Frun, 0)
        end
    elseif self.vx > 0 then
        self.anim = self.animations.idle
        self.collider:applyLinearImpulse(-Ffriction, 0)
    elseif self.vx < 0 then
        self.anim = self.animations.idle
        self.collider:applyLinearImpulse(Ffriction, 0)
    elseif self.vx == 0 then
        self.anim = self.animations.idle
    end
end

function Player:checkKey()
    if self.collider:enter("Key") then
        local collision_data = self.collider:getEnterCollisionData("Key")
        local key = collision_data.collider:getObject()

        self.hasKey = true
        key:destroy()
    end
end

function Player:checkDoor()
    if self.collider:enter("Door") then
        local collision_data = self.collider:getEnterCollisionData("Door")
        local door = collision_data.collider:getObject()

        if self.hasKey then
            local score = player.points
            local health = player.health
            local endGameScreen = FullScreen("Thanks for playing!", "Coins collected: " .. score .. " of " .. session.gameCoins, "Player health: " .. health)
            table.insert(userInterface.elements, endGameScreen)
        else
            local newAlert = Alert("Key is missing.", 2)
            table.insert(userInterface.elements, newAlert)
        end
    end
end

function Player:checkAdvanceMap()
    if self:shouldAdvanceMap() then
        session.nextMap()
    end
end

function Player:shouldAdvanceMap()
    local bool = self.x > gameWidth
    return bool
end

function Player:checkLose()
    if self:shouldLose() then
        -- Destroy map and UI
        session:destroyMap()
        userInterface:destroy()

        -- Save player stats
        local score = player.points
        local health = player.health

        -- Show player stats in endGameScreen
        local endGameScreen = FullScreen("Game over", "Coins collected: " .. score .. " of " .. session.gameCoins, "")

        -- Restart game on left click
        if love.mouse.isDown(1) then
            love.load()
        end
    end
end

function Player:shouldLose()
    -- Lose by fall
    if self.y > gameHeight then
        return true
    -- Lose by health = 0
    elseif player.health <= 0 then
        return true
    else
        return false
    end
end

function Player:checkDamage()
    -- Enemy hit reduces health
    self:checkEnemy()

    -- Trap hit reduces health
    self:checkTrap()

end

function Player:checkPoints()
    if self.collider:enter("Collectible") then
        local collision_data = self.collider:getEnterCollisionData('Collectible')
        local coin = collision_data.collider:getObject()
        coin:collect()
    end
end

function Player:checkEnemy()
    if self.collider:enter("Enemy") then
        local collision_data = self.collider:getEnterCollisionData("Enemy")
        local enemy = collision_data.collider:getObject()

        self:takesDamage(enemy.level)
    end
end

function Player:checkTrap()
    if self.collider:enter("Trap") then
        local collision_data = self.collider:getEnterCollisionData("Trap")
        local trap = collision_data.collider:getObject()

        self:takesDamage(1)
    end
end

function Player:takesDamage(multiplier)
    self.health = self.health - 10 * multiplier

    local screenFlash = ScreenFlash(0.05)
    table.insert(userInterface.elements, screenFlash)
end