-- mix two RGB colors
function mix_colors(c1, c2, mix)
	local c = {0,0,0}
	for i=1,3 do
		c[i] = (c1[i] + (c2[i] - c1[i]) * mix)
	end
    if c1[4] ~= nil then c[4] = c1[4] end
	return c
end

-- generate a random color
function random_color(saturation, brightness)
    return hsv_to_rgb(love.math.random(), saturation, brightness)
end

function hsv_to_rgb(h, s, v)
    if s <= 0 then return v,v,v end
    h, s, v = h*6, s, v
    local c = v*s
    local x = (1-math.abs((h%2)-1))*c
    local m,r,g,b = (v-c), 0,0,0
    if h < 1     then r,g,b = c,x,0
    elseif h < 2 then r,g,b = x,c,0
    elseif h < 3 then r,g,b = 0,c,x
    elseif h < 4 then r,g,b = 0,x,c
    elseif h < 5 then r,g,b = x,0,c
    else              r,g,b = c,0,x
    end return {(r+m),(g+m),(b+m)}
end

-- return a random float from min to max
function randfloat(min, max)
    return min + (love.math.random() * (max - min))
end
