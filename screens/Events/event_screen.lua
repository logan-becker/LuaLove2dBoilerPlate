local EventScreen = {}
local PopupMenu = require("screens.popup_menu")

-- constructor to create a new event screen object
function EventScreen:new(o)
    o = o or {} --object does not exist? create it
    setmetatable(o, self)
    self.__index = self

    -- Initialize PopupMenu for all event screens
    o.popupMenu = PopupMenu:new()
    o.popupMenu:setButtons({
        {text = "Save and Continue", action = "save"},
        {text = "Return to Start Screen", action = "start"}
    })
    
    return o
end

function EventScreen:load()
    print("Event screen loaded")
    self.title = "Generic Event"
end

function EventScreen:update(dt)
    -- default update logic
end 

function EventScreen:draw()
    love.graphics.printf(self.title, 0, love.graphics.getHeight() /2, love.graphics.getWidth() / 2, "center")

    -- Draw popup menu if active
    self.popupMenu:draw()

end

function EventScreen:keypressed(key)
    if key == "space" then
        print("Default action triggered.")
    end

    -- toggle popup menu logic
    if key == "escape" then
        self.popupMenu:toggle()
        print("Popup menu state:", self.popupMenu.active)
    end
end

function EventScreen:mousepressed(x, y, button)
    local popupAction = self.popupMenu:mousepressed(x, y, button)
    if popupAction then
        print("Popup menu action:", popupAction)
        return popupAction
    end
end

return EventScreen