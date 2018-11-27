local theme1 = {
    background = 0x300030,   -- dark purple
    flower     = 0xffffff,   -- white
}

local theme2 = {
    background = 0xf4f4f8,   -- white
    flower     = 0x000000,   -- black
}

local themes = { theme1, theme2 }

function Theme (game)
    local self = {}

    -- initialization:
    self.init = function (game)
        self.theme_index = 1
        self.load_theme(self.theme_index)
    end

    -- load a given theme:
    self.load_theme = function (index)
        local theme = themes[index]

        self.background = self.hex_to_rgb(theme.background)
        self.flower = self.hex_to_rgb(theme.flower)
        self.saturation = 0.5
        self.brightness = 0.7
        self.theme_index = index
    end

    -- load the next theme to the current one:
    self.load_next_theme = function ()
        local index = self.theme_index + 1

        if index > #themes then
            index = 1
        end

        self.load_theme(index)
    end

    self.hex_to_rgb = function(hex)
        if (type(hex) == "table") then
            rgb_table = {}
            for key, value in pairs(hex) do
                rgb_table[key] = self.hex_to_rgb(value)
            end
            return rgb_table
        else
            local r = bit.rshift(bit.band(hex, 0xFF0000), 16)
            local g = bit.rshift(bit.band(hex, 0x00FF00), 8)
            local b = bit.band(hex, 0x0000FF)
            return {r / 256, g / 256, b / 256}
        end
    end

    self.init()
    return self
end
