local EventScreen = require("screens.Events.event_screen")
local PopupMenu = require("screens.popup_menu")
local RandomEncounter = EventScreen:new()

function RandomEncounter:load()
    EventScreen.load(self) 

    -- load popup menu
    self.popupMenu = PopupMenu:new()
    self.popupMenu:setButtons({
        {text = "Save", action = "save"},
        {text = "Return to Home Screen", action = "start"}
    })

    self.title = "Random Encounter!"
end

function RandomEncounter:draw()
    -- draws the random encounter and popup menu
    EventScreen.draw(self)
    self.popupMenu:draw()
end

function RandomEncounter:keypressed(key)

    -- dummy game logic
    if key == "space" then
        print("You interacted with the random encounter!")
    end
    
    -- toggles popup menu if escape button is pressed
    if key == "escape" then
        self.popupMenu:toggle()
    end
end


function RandomEncounter:mousepressed(x, y, button)

    -- set popup action and return if exists
    local popupAction = self.popupMenu:mousepressed(x, y, button)

    if popupAction then
        return popupAction
    end 
end



return RandomEncounter
