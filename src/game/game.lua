-- hyo
local inspect = require 'lib/inspect'
require 'game/theme'
require 'game/flower'

DEBUG=true

function Game ()
    local self = {}

    -- initialization:
    self.init = function ()
        self.theme = Theme()
        -- flowers
        self.flower_canvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
        self.num_flowers = 20
        self.min_stems = 3
        self.max_stems = 7
        self.min_stem_length = 10
        self.max_stem_length = 40
        -- font
        love.graphics.setNewFont("resources/LiberationSans-Regular.ttf", 14)
        self.reset()
    end

    -- draw the game:
    self.draw = function ()
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setBackgroundColor(self.theme.background)
        love.graphics.setBlendMode("alpha", "premultiplied")
        -- draw each flower
        for i, flower in pairs(self.flowers) do
            flower.draw()
        end
        love.graphics.setBlendMode("alpha")
        -- show fps
        if DEBUG then
            local fps = love.timer.getFPS()
            love.graphics.print(fps, 10, 10)
        end
    end

    -- update the game logic:
    self.update = function (dt)
        -- update flowers
        for i, flower in pairs(self.flowers) do
            flower.update(dt)
        end
    end

    -- reset game:
    self.reset = function()
        self.flowers = self.make_flowers(self.num_flowers)
    end

    -- handle keyboard input:
    self.keypressed = function (key)
        if key == 'r' then
            self.reset()
        end
    end

    -- make n random flowers
    self.make_flowers = function(n)
        local flowers = {}
        local x_offset = (love.graphics.getWidth() / (n+1))
        for i=1, n do
            local x = x_offset * i
            local y = love.graphics.getHeight()
            local flower = Flower(self, x, y, self.theme.flower)
            table.insert(flowers, flower)
        end
        return flowers
    end

    self.init()
    return self
end
