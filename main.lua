-- AABB collision: rectangles overlap when their edges overlap on both axes.
function checkCollision(a, b)
    return a.x < b.x + b.width and
           a.x + a.width > b.x and
           a.y < b.y + b.height and
           a.y + a.height > b.y
end

-- Set up the window, paddles, and ball once when the game starts.
function love.load()
    love.window.setMode(800, 600)
    love.window.setTitle("Pong - Task 2")
    love.graphics.setBackgroundColor(0.08, 0.08, 0.1)

    player1 = { x = 30, y = 250, width = 15, height = 100, speed = 300 }
    player2 = { x = 755, y = 250, width = 15, height = 100, speed = 300 }
    ball = { x = 394, y = 294, width = 12, height = 12, dx = 250, dy = 150 }
end

-- Update movement each frame. dt is the time since the last frame in seconds.
function love.update(dt)
    -- Multiplying pixels per second by dt keeps movement consistent across frame rates.
    if love.keyboard.isDown("w") then
        player1.y = player1.y - player1.speed * dt
    end
    if love.keyboard.isDown("s") then
        player1.y = player1.y + player1.speed * dt
    end

    if love.keyboard.isDown("up") then
        player2.y = player2.y - player2.speed * dt
    end
    if love.keyboard.isDown("down") then
        player2.y = player2.y + player2.speed * dt
    end

    -- Keep each paddle between the top and bottom edges of the window.
    local windowHeight = love.graphics.getHeight()
    player1.y = math.max(0, math.min(player1.y, windowHeight - player1.height))
    player2.y = math.max(0, math.min(player2.y, windowHeight - player2.height))

    ball.x = ball.x + ball.dx * dt
    ball.y = ball.y + ball.dy * dt

    -- Reverse vertical movement and keep the ball inside the top and bottom edges.
    if ball.y <= 0 then
        ball.y = 0
        ball.dy = math.abs(ball.dy)
    elseif ball.y + ball.height >= windowHeight then
        ball.y = windowHeight - ball.height
        ball.dy = -math.abs(ball.dy)
    end

    -- Only bounce when moving toward a paddle, then move outside it to avoid sticking.
    if ball.dx < 0 and checkCollision(ball, player1) then
        ball.dx = -ball.dx
        ball.x = player1.x + player1.width
    elseif ball.dx > 0 and checkCollision(ball, player2) then
        ball.dx = -ball.dx
        ball.x = player2.x - ball.width
    end
end

-- Draw both paddles and the ball each frame.
function love.draw()
    love.graphics.setColor(0.2, 0.6, 1) -- Blue left paddle.
    love.graphics.rectangle("fill", player1.x, player1.y, player1.width, player1.height)
    love.graphics.setColor(1, 0.5, 0.2) -- Orange right paddle.
    love.graphics.rectangle("fill", player2.x, player2.y, player2.width, player2.height)
    love.graphics.setColor(1, 1, 1) -- Keep the ball white.
    love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
end
