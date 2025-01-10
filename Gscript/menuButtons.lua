function createButtons()
    --x 1/4
    local x = love.graphics.getWidth() / 4
    --y
    local y = y or 100
    --name
    local storyButton = love.graphics.newImage("assets/images/menu/story.png")
    local freeplayButton = nil
    local settingButton = nil
    
    local creditsButton = nil
    local achievementsButton = nil

    return {
        makeButton = function(self,name,x,y)
            love.graphics.draw(name,x,y)
        end
    }
end

local buttons = createButtons()

return buttons