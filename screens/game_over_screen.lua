local gameOverScreen = {}

function gameOverScreen.load()
    gameOverScreen.options = {"New Game", "End Game"}
    gameOverScreen.selected = 1
end

function gameOverScreen.update(dt)
    -- Handle input to navigate menu
end

function gameOverScreen.draw()
    love.graphics.printf("Game Over", 0, 100, love.graphics.getWidth(), "center")
    for i, option in ipairs(gameOverScreen.options) do
        if i == gameOverScreen.selected then
            love.graphics.setColor(0, 1, 0)
        else
            love.graphics.setColor(1, 1, 1)
        end
        love.graphics.printf(option, 0, 200 + i * 30, love.graphics.getWidth(), "center")
    end
end

function gameOverScreen.keypressed(key)
    if key == "return" then
        if gameOverScreen.selected == 1 then
            return "game" -- New Game
        elseif gameOverScreen.selected == 2 then
            return "start" -- End Game
        end
    end
end

return gameOverScreen
