local ball, square, player1, player2, isDown, speed, velocity_x, velocity_y, gameOver, lines;
local maxWidth, maxHeight = love.window.getMode() --800, 600
-- image = io.open("images/pingpong.jpg")
-- print(image:read())
local image = love.image.newImageData("images/pingpong.jpg");
love.window.setIcon(image)
function love.load()
    --[[ player/ball creation ]] --
    square = require("square")
    player1 = square.new("fill", 10, 200, 150, 10)
    player2 = square.new("fill", maxWidth - 20, 200, 150, 10)
    ball = require("ball").new("fill", maxWidth / 2 - 10, maxHeight / 2 - 10, 10);
    lines = {  }
    for i = 1, 5 do
        lines[i] = square.new("fill", maxWidth / 2 - 10, 0, 100, 10)
        if i ~= 1 then
            lines[i].y = (lines[i - 1].y + 100) + 25
        end
    end
    love.window.setTitle("Ping Pong")
    isDown = love.keyboard.isDown;

    --[[ player speed ]]--
    speed = 4;

    --[[ ball velocity ]] --
    velocity_x = -200
    velocity_y = 0;

    --[[ variable that decides the game ]]
    gameOver = false;
end

function love.update(delta)
    if not love.window.hasFocus() then
        return;
    end

    --[[ player movement ]]--
    if isDown("down") and not ai then
        player2:move(player2.y + speed)
    elseif isDown("up") and not ai then
        player2:move(player2.y - speed)
    end;
    if isDown("w") then
        player1:move(player1.y - speed)
    elseif isDown("s") then
        player1:move(player1.y + speed);
    end;

    --[[ ball movement ]] --
    ball.x = ball.x + (velocity_x * delta);
    ball.y = ball.y + (velocity_y * delta);

    --[[ collision detection ]]--
    if (player1.y < 0 or player1.maxY > maxHeight) then
        player1:move(player1.y - (player1.y < 0 and player1.y or (player1.maxY - maxHeight)))
    end
    if (player2.y < 0 or player2.maxY > maxHeight) then
        player2:move(player2.y - (player2.y < 0 and player2.y or (player2.maxY- maxHeight)))
    end

    if (player1.y <= ball.y and player1.maxY >= ball.y) and (player1.x + 18 >= ball.x) then
        velocity_x = velocity_x * -1;
        if velocity_y < 180 and velocity_y > -180 then
            local add = 1;
            if velocity_y < 0 then
                add = -1
            end;
            velocity_y = velocity_y + 20 * add
        end
    end

    if (player2.y <= ball.y and player2.maxY >= ball.y) and (player2.x - 5 <= ball.x) then
        velocity_x = velocity_x * -1;
        if velocity_y < 180 and velocity_y > -180 then
            local add = 1;
            if velocity_y < 0 then
                add = -1
            end;
            velocity_y = velocity_y + 20 * add
        end
    end

    if (ball.x > maxWidth) then
        player1.score = player1.score + 1;
        velocity_x = -200
        gameOver = true;
    end
    if (ball.x < 0) then
        player2.score = player2.score + 1;
        velocity_x = 200
        gameOver = true;
    end
    if (ball.y <= 1 or ball.y > maxHeight) then
        velocity_y = velocity_y * -1; -- makes sure ball doesn't go off the top and bottom
    end

    -- [[ game over detection ]]--
    if gameOver then
        ball.x = maxWidth / 2 - 10
        ball.y = maxHeight / 2
        velocity_y = 0;
        gameOver = false;
    end

end

function love.draw()
    player1:draw();
    player2:draw();
    ball:draw()
    for i = 1, 5 do
        lines[i]:draw()
    end
    love.graphics.print(player1.score .. "  :  ".. player2.score, maxWidth / 2 - 24, maxHeight / 2 - 20)
end
