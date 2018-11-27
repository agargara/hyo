-- flower object
require 'game/util'

SPF = (1/60) -- seconds per frame

function Flower (game, x, y, color)
    local self = {}

    -- initialization:
    self.init = function (game, x, y, color)
        self.game = game
        self.x = x
        self.y = y
        local rand_color = random_color(self.game.theme.saturation, self.game.theme.brightness)
        self.color = mix_colors(color, rand_color, 0.5)
        self.init_stems()
        self.growing = true
        self.grow_timer = 0
        -- grow speed: seconds per pixel (e.g. 1/10 = 10 pixels per second)
        self.grow_speed = 1 / (randfloat(30, 180))
        self.canvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
    end

    -- initialize flower stems
    self.init_stems = function()
        self.stems = {}
        for i=1, love.math.random(self.game.min_stems,self.game.max_stems) do
            self.stems[i] = {{0,0}}
        end
        -- draw initial point on canvas
        love.graphics.setCanvas(self.canvas)
        love.graphics.setColor(self.color)
        love.graphics.points({{0,0}})
        love.graphics.setCanvas()
    end

    -- grow: lengthen each stem by n points
    self.grow = function(n)
        love.graphics.setCanvas(self.canvas)
        love.graphics.setColor(self.color)
        for j=1, n do
            for i, stem in pairs(self.stems) do
                -- start with last point in stem
                local x = stem[#stem][1]
                local y = stem[#stem][2]
                -- move to new point and add to stem
                local r = love.math.random()
                if r > 0.8 then
                    x = x + 1  -- 20% chance to grow right
                elseif r > 0.6 then
                    x = x - 1  -- 20% chance to grow left
                end
                if love.math.random() > 0.95 then
                    y = y + 1  --  5% chance to grow down
                else
                    y = y - 1  -- 95% change to grow up
                end
                -- if y is OOB, stop growing
                if y < -love.graphics.getHeight() then
                    self.growing = false
                end
                table.insert(self.stems[i], {x, y})
                -- draw new point on canvas
                love.graphics.points({{self.x + x, self.y + y}})
            end
        end
        love.graphics.setCanvas()
    end

    self.update = function (dt)
        if not self.growing then return end
        self.grow_timer = self.grow_timer + dt
        if self.grow_timer > self.grow_speed then
            local i = math.floor(self.grow_timer / self.grow_speed)
            self.grow(i)
            -- decrease grow timer for each pixel drawn
            self.grow_timer = self.grow_timer - (i * self.grow_speed)
        end
    end

    self.draw = function ()
        -- draw canvas
        love.graphics.draw(self.canvas)
    end

    self.init(game, x, y, color)
    return self
end
