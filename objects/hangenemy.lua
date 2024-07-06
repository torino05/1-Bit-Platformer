HangEnemy = Enemy:extend()

function HangEnemy:new(x, y, width, height, level)
    HangEnemy.super.new(self, x, y, width, height, level)
    self.collider:setType("static")
end