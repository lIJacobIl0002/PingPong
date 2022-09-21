local ball = {  };
ball.__index = ball;

function ball.new(mode, x, y, radius)
    return setmetatable({
        mode = mode;
        x = x;
        y = y;
        radius = radius;
    }, ball)
end

function ball:draw()
    love.graphics.circle(self.mode, self.x, self.y, self.radius);
end;

return ball