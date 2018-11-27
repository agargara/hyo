-- flower object
function Flower (x, y, color)
    local self = {}

    -- initialization:
    self.init = function (x, y, color)
        self.x = x
        self.y = y
        self.color = color
        self.points = self.make_points()
    end

    -- make random flower points starting on x,y
    self.make_points = function()
        local points = {}
        local x = self.x
        local y = self.y
        for i=1, love.math.random(10,20) do
            points[i] = {x, y}
            y = y - 1 -- grow up
            local r = love.math.random()
            if r > 0.8 then
                x = x + 1 -- 20% chance to grow right
            elseif r > 0.6 then
                x = x - 1 -- 20% chance to grow left
            end
        end
        return points
    end

    self.update = function (dt)
    end

    self.draw = function ()
        love.graphics.setColor(self.color)
        love.graphics.points(self.points)
    end

    self.init(x, y, color)
    return self
end
