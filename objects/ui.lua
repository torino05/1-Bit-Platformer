UI = Object:extend()

require "objects.alert"
require "objects.screenflash"
require "objects.fullscreen"
require "objects.screeninfo"

function UI:new()
    self.elements = {}
end

function UI:update(dt)
    for _, e in pairs(self.elements) do
        e:update(dt)
    end
end

function UI:draw()
    -- Print every UI element
    for _, e in pairs(self.elements) do
        e:draw()
    end
end

function UI:destroy()
    for i, obj in pairs(self.elements) do
        self.elements[i] = nil
    end
end