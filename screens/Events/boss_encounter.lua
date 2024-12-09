local EventScreen = require("screens.Events.event_screen")
local PopupMenu = require("screens.popup_menu")
local boss = EventScreen:new()

-- override functions from event screen 
function boss:load()
    EventScreen.load(self)
    self.popupMenu = PopupMenu:new()
    self.popupMenu:setButtons({
        {text = "Save and Continue", action = "save"},
        {text = "Return to Start Screen", action = "start"}
    })

    self.title = "Boss Encounter"
end

function boss:draw()
    -- Draw popup menu if active
    self.popupMenu:draw()
end


function boss:keypressed(key)

    if key == "space" then
        print("Attack the boss!")
    elseif key == "return" then 
        print("Avoid the boss!")
    end

    if key == "escape" then
        self.popupMenu:toggle() -- Toggle popup menu state
        print("Popup menu state:", self.popupMenu.active)
    end
end

function boss:mousepressed(x, y, button)
    local popupAction = self.popupMenu:mousepressed(x, y, button)
    if popupAction then
        print("Popup menu action:", popupAction)
        return popupAction
    end

    -- Handle main screen button interactions
    -- print("Mouse pressed in gameScreen:", x, y, button)
    -- if button == 1 and not self.popupMenu.active then -- Left mouse button
    --     for _, btn in ipairs(self.buttons) do
    --         if x >= btn.x and x <= btn.x + btn.width and
    --            y >= btn.y and y <= btn.y + btn.height then
    --             print("Selected:", btn.text)
    --             return btn.action -- Return the action for the selected button
    --         end
    --     end
    -- end
    

end

return boss