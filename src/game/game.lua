-- hyo
local inspect = require 'lib/inspect'
require 'game/theme'
require 'game/flower'

function Game ()
    local self = {}

    -- initialization:
    self.init = function ()
        self.theme = Theme()
        self.flowers = self.make_flowers(20)
    end

    -- draw the game:
    self.draw = function ()
        love.graphics.setBackgroundColor(self.theme.background)
        -- draw each flower
        for i, flower in pairs(self.flowers) do
            flower.draw()
        end
    end

    -- update the game logic:
    self.update = function (dt)
        -- update flowers
        for i, flower in pairs(self.flowers) do
            flower.update()
        end
    end

    -- handle keyboard input:
    self.keypressed = function (key)
        if key == 'd' then
        end
    end

    -- make n random flowers
    self.make_flowers = function(n)
        local flowers = {}
        for i=0, n do
            local x = love.math.random(0, love.graphics.getWidth())
            local y = love.math.random(0, love.graphics.getHeight())
            local flower = Flower(x, y, self.theme.flower)
            table.insert(flowers, flower)
        end
        return flowers
    end

    self.init()
    return self
end
