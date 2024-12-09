local startScreen = {}

function startScreen:load()
    startScreen.options = {
        {text = "New Game", action = "game"},
        -- {text = "Continue", action = "continue"},
        -- {text = "Player Stats", action = "stats"},
        -- {text = "Settings", action = "settings"},
        -- {text = "Credits", action = "credits"},
        {text = "Quit Game", action = "quit"}
    }
    startScreen.selected = 1 -- Keep track of the current menu option
    startScreen.buttonWidth = 200
    startScreen.buttonHeight = 50

    -- Validate options
    for i, option in ipairs(self.options) do
        print("Option", i, "Text:", option.text, "Action:", option.action)
    end
    
end


function startScreen.update(dt)
    -- No need for updates in a static menu for now
end

function startScreen.draw()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local menuX = (screenWidth - startScreen.buttonWidth) / 2 -- Center buttons horizontally
    local menuY = screenHeight / 2 - (#startScreen.options * startScreen.buttonHeight) / 2 -- Center vertically

    for i, option in ipairs(startScreen.options) do
        if i == startScreen.selected then
            love.graphics.setColor(0.3, 0.8, 0.3) -- Highlight selected option
        else
            love.graphics.setColor(0.5, 0.5, 0.5) -- Normal color for unselected
        end
        love.graphics.rectangle("fill", menuX, menuY + (i - 1) * startScreen.buttonHeight, startScreen.buttonWidth, startScreen.buttonHeight)
        love.graphics.setColor(1, 1, 1) -- White text
        love.graphics.printf(option.text, menuX, menuY + (i - 1) * startScreen.buttonHeight + 15, startScreen.buttonWidth, "center")
    end
end

function startScreen:keypressed(key)
    print("Key pressed in startScreen:", key, "Selected option before:", self.selected)

    if not self.options then
        print("Error: Options not initialized in keypressed")
        return
    end

    if key == "down" then
        startScreen.selected = startScreen.selected + 1
        if startScreen.selected > #startScreen.options then
            startScreen.selected = 1 -- Loop back to the first option
        end
    elseif key == "up" then
        startScreen.selected = startScreen.selected - 1
        if startScreen.selected < 1 then
            startScreen.selected = #startScreen.options -- Loop to the last option
        end
    elseif key == "return" then
        return startScreen.options[startScreen.selected].action -- Return the selected action
    end
end

function startScreen:mousepressed(x, y, button)
    print("Mouse pressed in startScreen:", x, y, button)

    if not self.options then
        print("Error: Options not initialized in mousepressed")
        return
    end

    print("click")
    if button == 1 then -- Left mouse button
        local screenWidth = love.graphics.getWidth()
        local menuX = (screenWidth - startScreen.buttonWidth) / 2
        local menuY = love.graphics.getHeight() / 2 - (#startScreen.options * startScreen.buttonHeight) / 2

        print("Mouse click:", x, y)
        print("Menu X:", menuX, "Menu Y:", menuY)

        for i, option in ipairs(startScreen.options) do
            local buttonX = menuX
            local buttonY = menuY + (i - 1) * startScreen.buttonHeight
            print("Button", i, "Bounds:", buttonX, buttonY, buttonX + startScreen.buttonWidth, buttonY + startScreen.buttonHeight)

            if x >= buttonX and x <= buttonX + startScreen.buttonWidth and
               y >= buttonY and y <= buttonY + startScreen.buttonHeight then
                print("Button clicked:", option.action)
                return option.action
            end
        end
    end
end

return startScreen
