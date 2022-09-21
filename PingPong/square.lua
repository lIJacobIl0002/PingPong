local square = {  }
square.__index = square;
local maxWidth, maxHeight = 800, 600

function square.new(mode, x, y, height, width)
    return setmetatable({
        mode = mode;
        x = x;
        y = y;
        height = height;
        width = width;
        maxX = x + width;
        maxY = y + height;
        score = 0;
    }, square);
end

function square:draw()
   love.graphics.rectangle(self.mode, self.x, self.y, self.width, self.height)
end

function square:move(y)
    self.y = y;
    self.maxY = y + self.height;
end

return square