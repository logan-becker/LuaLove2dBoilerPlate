local PopupMenu = require("screens.popup_menu")
local gameScreen = {}

function gameScreen:load()
    -- Initialize PopupMenu
    self.popupMenu = PopupMenu:new()
    self.popupMenu:setButtons({
        {text = "Save and Continue", action = "save"},
        {text = "Quit Game", action = "quit"}
    })

    -- Define main screen buttons
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local buttonWidth = 400
    local buttonHeight = 50
    local buttonSpacing = 20
    local totalHeight = (3 * buttonHeight) + (2 * buttonSpacing)
    local startY = (screenHeight - totalHeight) / 2 -- Center vertically

    self.buttons = {
        {
            text = "Random Encounter",
            action = "random_encounter",
            x = (screenWidth - buttonWidth) / 2,
            y = startY,
            width = buttonWidth,
            height = buttonHeight
        },
        {
            text = "Enemy Encounter",
            action = "enemy_encounter",
            x = (screenWidth - buttonWidth) / 2,
            y = startY + buttonHeight + buttonSpacing,
            width = buttonWidth,
            height = buttonHeight
        },
        {
            text = "Boss Encounter",
            action = "boss_encounter",
            x = (screenWidth - buttonWidth) / 2,
            y = startY + 2 * (buttonHeight + buttonSpacing),
            width = buttonWidth,
            height = buttonHeight
        }
    }
end

function gameScreen:update(dt)
    -- Update popup menu logic if active
    if self.popupMenu.active then
        -- Handle any update logic for the popup menu here if needed
    else
        -- Update main game logic
    end
end

function gameScreen:draw()
    -- Draw game screen elements
    love.graphics.printf("Game Screen", 0, 20, love.graphics.getWidth(), "center")

    -- Draw buttons
    for _, button in ipairs(self.buttons) do
        love.graphics.setColor(0.5, 0.5, 0.8) -- Button color
        love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
        love.graphics.setColor(1, 1, 1) -- Text color
        love.graphics.printf(button.text, button.x, button.y + 15, button.width, "center")
    end

    -- Draw popup menu if active
    self.popupMenu:draw()
end

function gameScreen:keypressed(key)
    if key == "escape" then
        self.popupMenu:toggle() -- Toggle popup menu state
        print("Popup menu state:", self.popupMenu.active)
    end
end

function gameScreen:mousepressed(x, y, button)
    -- Check popup menu interaction first
    local popupAction = self.popupMenu:mousepressed(x, y, button)
    if popupAction then
        print("Popup menu action:", popupAction)
        return popupAction
    end

    -- Handle main screen button interactions
    print("Mouse pressed in gameScreen:", x, y, button)
    if button == 1 and not self.popupMenu.active then -- Left mouse button
        for _, btn in ipairs(self.buttons) do
            if x >= btn.x and x <= btn.x + btn.width and
               y >= btn.y and y <= btn.y + btn.height then
                print("Selected:", btn.text)
                return btn.action -- Return the action for the selected button
            end
        end
    end
end

return gameScreen
