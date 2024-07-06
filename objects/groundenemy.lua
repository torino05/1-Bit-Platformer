GroundEnemy = Enemy:extend()

function GroundEnemy:new(x, y, width, height, level)
    GroundEnemy.super.new(self, x, y, width, height, level)
    self.x, self.y, self.width, self.height = x, y, width, height

    self.animations = {}
    self.animations.idle = anim8.newAnimation(self.grid("2-3", 1), 0.4)
    self.anim = self.animations.idle

    self.speed = 0.5
    self.direction = 1
    self.vxMax = 10
end

function GroundEnemy:update(dt)
    -- Position
    self.vx, self.vy = self.collider:getLinearVelocity()
    self.x = self.collider:getX() - self.width
    self.y = self.collider:getY() - self.height
    -- Movement
    self:move()
    -- Animation
    self.anim:update(dt)
end

function GroundEnemy:draw()
    self.anim:draw(self.spritesheet, self.x, self.y)
end

function GroundEnemy:move()
    -- Enemy moves with a max speed
    if self.vx < vxMax or self.vx > -vxMax then
        self.collider:applyLinearImpulse(self.speed * self.direction, 0)
    end

    -- Enemy bounce back at walls
    if self.collider:enter("Platform") then
        self.direction = - self.direction
    end
end