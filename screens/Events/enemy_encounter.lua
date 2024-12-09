local EventScreen = require("screens.Events.event_screen")
local PopupMenu = require("screens.popup_menu")

-- inherits from EventScreen
local enemy_encounter = EventScreen:new()


-- Overrides EventScreen Functions
function enemy_encounter:load()

    -- load the event screen from which we inherit behavior
    EventScreen.load(self)
    
    -- init the popup menu with buttons set to table key val pairs
    self.popupMenu = PopupMenu:new()
    self.popupMenu:setButtons({
        {text = "Save", action = "save"},
        {text = "Return to Home Screen", action = "start"}
    })
    
    self.title = "Enemy encounter"
end

function enemy_encounter:draw()
    self.popupMenu:draw()
end

function enemy_encounter:keypressed(key)
    -- Dummy logic that logs to console
    if key == "space" then
        print("Attacking the enemy!")
    elseif key == "escape" then 
        print("escaping!")
    end

    -- Popup menu logic that makes the screen navigable
    if key == "escape" then
        self.popupMenu:toggle()
    end
end


function enemy_encounter:mousepressed(x, y, button)
    -- gets the action and returns the action if it exists
    local popupAction = self.popupMenu:mousepressed(x, y, button)
    if popupAction then
        print("Popup menu action:", popupAction)
        return popupAction
    end    
end

return enemy_encounter