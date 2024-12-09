local startScreen = require("screens.start_screen")
local gameScreen = require("screens.game_screen")
local gameOverScreen = require("screens.game_over_screen")
local randomEncounter = require("screens.Events.random_encounter")
local enemyEncounter = require("screens.Events.enemy_encounter")
local bossEncounter = require("screens.Events.boss_encounter")

local currentScreen = "start"


-- Map screens to their respective modules for easy management
local screens = {
    start = startScreen,
    game = gameScreen,
    gameover = gameOverScreen,
    random_encounter = randomEncounter,
    enemy_encounter = enemyEncounter,
    boss_encounter = bossEncounter
}

function love.load()
    love.window.setMode(0, 0, {fullscreen = true, resizable = true})

    -- Load the current screen (startScreen initially)
    if screens[currentScreen] and screens[currentScreen].load then
        screens[currentScreen]:load() -- Use colon to pass `self`
    end
end

function love.update(dt)
    if screens[currentScreen] and screens[currentScreen].update then
        screens[currentScreen]:update(dt)
    end
end

function love.draw()
    if screens[currentScreen] and screens[currentScreen].draw then
        screens[currentScreen]:draw()
    end
end

function love.keypressed(key)
    print("Key pressed in main.lua:", key, "Current screen:", currentScreen)

    if screens[currentScreen] and screens[currentScreen].keypressed then
        local action = screens[currentScreen]:keypressed(key)
        if action then
            if action == "quit" then
                love.event.quit() -- Quit the game
            else
                currentScreen = action -- Switch screen if an action is returned
                if screens[currentScreen].load then
                    screens[currentScreen]:load()
                end
            end
        end
    end

    if key == "f" then
        local isFullscreen = love.window.getFullscreen()
        love.window.setFullscreen(not isFullscreen)
    end
end

function love.mousepressed(x, y, button)
    print("Mouse pressed in main.lua:", x, y, button, "Current screen:", currentScreen)

    if screens[currentScreen] and screens[currentScreen].mousepressed then
        local action = screens[currentScreen]:mousepressed(x, y, button)
        if action then
            if action == "quit" then
                love.event.quit() -- Quit the game
            else
                currentScreen = action -- Switch screen if an action is returned
                if screens[currentScreen].load then
                    screens[currentScreen]:load()
                end
            end
        end
    end
end
