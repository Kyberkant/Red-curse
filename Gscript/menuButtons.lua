function createButtons()
    --x 1/4
    local x = love.graphics.getWidth() / 4
    --y
    local y = y or 100
    local sx = sx or 1
    local sy = sy or 1
    --name
    local storyButton = love.graphics.newImage("assets/images/menu/story.png")
    local freeplayButton = love.graphics.newImage("assets/images/menu/freeplay.png")
    local settingsButton = love.graphics.newImage("assets/images/menu/settings.png")
    
    local creditsButton = nil
    local achievementsButton = love.graphics.newImage("assets/images/menu/achievements.png")

    return {
        makeButton = function(self,image,x,y,sx,sy)
            love.graphics.draw(image,x,y,0,sx,sy)
        end,

    names = {
       storyButton = storyButton,
            freeplayButton = freeplayButton,
            settingsButton = settingsButton,
            creditsButton = creditsButton,
            achievementsButton = achievementsButton
      }
    }
end

local buttons = createButtons()

return buttons