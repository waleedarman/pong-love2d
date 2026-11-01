-- Set up the window and paddles once when the game starts.
function love.load()
    love.window.setMode(800, 600)
    love.window.setTitle("Pong - Task 1")
    love.graphics.setBackgroundColor(0.08, 0.08, 0.1)

    player1 = { x = 30, y = 250, width = 15, height = 100, speed = 300 }
    player2 = { x = 755, y = 250, width = 15, height = 100, speed = 300 }
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
end

-- Draw both paddles each frame.
function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", player1.x, player1.y, player1.width, player1.height)
    love.graphics.rectangle("fill", player2.x, player2.y, player2.width, player2.height)
end
