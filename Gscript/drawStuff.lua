
function drewThings()
    local makeGridQuads = require("Gscript.spriteGrid")
    local newAnimation = require("Gscript.simpleAnim")
    -- Load images
    local logo = love.graphics.newImage('assets/images/logo.png')
    local NGlogo = love.graphics.newImage('assets/images/newgrounds_logo.png')
    local Rlogo = love.graphics.newImage('assets/images/logoBumpin.png')

    -- load menu static images
    local menu_bg = love.graphics.newImage('assets/images/menu/mn_mn_test.png')

    -- load animated images
    
    
    

    return {
        logoNames = {
            logo = logo,
            NGlogo = NGlogo,
            Rlogo = Rlogo
        },

        menuImg = {
            
            menu_bg = menu_bg
        },


        drawLogoWithFade = function(self, logoImage, alpha)
            
            
            local logoX = (targetWidth - logoImage:getWidth()) / 2
            local logoY = (targetHeight - logoImage:getHeight()) / 2
            love.graphics.setColor(1, 1, 1, alpha or 1)
            love.graphics.draw(logoImage, logoX, logoY)
            love.graphics.setColor(1, 1, 1, 1)
        end,

        drawLogo = function(self, logoImage)
            if not logoImage then
                print("Error: logoImage is nil in drawLogo")
                return
            end
            
            local logoX = (targetWidth - logoImage:getWidth()) / 2
            local logoY = (targetHeight - logoImage:getHeight()) / 2
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(logoImage, logoX, logoY)
            love.graphics.setColor(1, 1, 1, 1)
        end,

        drawLogoText = function(self, text, logoName)
            
            

            --
            local text = text or "random text"

            -- Logo dimensions
            local logoX = (targetWidth - logoName:getWidth()) / 2
            local logoY = (targetHeight - logoName:getHeight()) / 2

            -- Text dimensions
            local font = love.graphics.getFont()
            local textWidth = font:getWidth(text)
            local textHeight = font:getHeight()

            -- Calculate text position
            local textX = (targetWidth - textWidth) / 2 -- Center horizontally
            local textY = logoY + logoName:getHeight() + 10 -- Place below the logo with padding

            love.graphics.print(text, textX, textY)
        end,

        drawMenu = function(self, menuImage)
           
            
            local menuX = (targetWidth - menuImage:getWidth()) / 2
            local menuY = (targetHeight - menuImage:getHeight()) / 2
            
            love.graphics.draw(menuImage, menuX, menuY)
            
        end,

        spawnNote = function(self, note)
        end,

        -- logoAnimation = function(self, animObj, dt)
        --     animObj:update(dt)
        --     animObj:draw(animatedLogoAnim, (targetWidth - animatedLogo:getWidth()) / 2, (targetHeight - animatedLogo:getHeight()) / 2)
        -- end

    }
end

local drew = drewThings()

return drew
