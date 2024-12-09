local PopupMenu = {}

function PopupMenu:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    o.buttons = {}
    o.active = false
    return o
end

function PopupMenu:setButtons(buttons)
    self.buttons = buttons
    local popupWidth = 500
    local popupHeight = 300
    local popupX = (love.graphics.getWidth() - popupWidth) / 2
    local popupY = (love.graphics.getHeight() - popupHeight) / 2
    local buttonHeight = 50
    local buttonSpacing = 20
    local totalHeight = (#buttons * buttonHeight) + ((#buttons - 1) * buttonSpacing)
    local startY = popupY + (popupHeight - totalHeight) / 2

    for i, button in ipairs(buttons) do
        button.width = popupWidth - 100
        button.height = buttonHeight
        button.x = popupX + 50
        button.y = startY + (i - 1) * (buttonHeight + buttonSpacing)
    end
end

function PopupMenu:toggle()
    self.active = not self.active
end

function PopupMenu:draw()
    if self.active then
        local popupWidth = 500
        local popupHeight = 300
        local popupX = (love.graphics.getWidth() - popupWidth) / 2
        local popupY = (love.graphics.getHeight() - popupHeight) / 2

        love.graphics.setColor(0.2, 0.2, 0.2, 0.9) -- Semi-transparent background
        love.graphics.rectangle("fill", popupX, popupY, popupWidth, popupHeight)
        love.graphics.setColor(1, 1, 1) -- Text color

        for _, button in ipairs(self.buttons) do
            love.graphics.setColor(0.5, 0.5, 0.8)
            love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
            love.graphics.setColor(1, 1, 1)
            love.graphics.printf(button.text, button.x, button.y + 15, button.width, "center")
        end
    end
end

function PopupMenu:mousepressed(x, y, button)
    if self.active and button == 1 then
        for _, btn in ipairs(self.buttons) do
            if x >= btn.x and x <= btn.x + btn.width and
               y >= btn.y and y <= btn.y + btn.height then
                print("Popup button clicked:", btn.text)
                return btn.action
            end
        end
    end
end

return PopupMenu
