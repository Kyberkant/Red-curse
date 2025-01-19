function drewThings()
    -- Load images
    local logo = love.graphics.newImage('assets/images/logo.png')
    local NGlogo = love.graphics.newImage('assets/images/newgrounds_logo.png')
    local Rlogo = love.graphics.newImage('assets/images/logoBumpin.png')

    return {
        logoNames = {
            logo = logo,
            NGlogo = NGlogo,
            Rlogo = Rlogo
        },

        drawLogoWithFade = function(self, logoImage, alpha)
            
            local screenWidth = love.graphics.getWidth()
            local screenHeight = love.graphics.getHeight()
            local logoX = (screenWidth - logoImage:getWidth()) / 2
            local logoY = (screenHeight - logoImage:getHeight()) / 2
            love.graphics.setColor(1, 1, 1, alpha or 1)
            love.graphics.draw(logoImage, logoX, logoY)
            love.graphics.setColor(1, 1, 1, 1)
        end,

        drawLogo = function(self, logoImage)
            if not logoImage then
                print("Error: logoImage is nil in drawLogo")
                return
            end
            local screenWidth = love.graphics.getWidth()
            local screenHeight = love.graphics.getHeight()
            local logoX = (screenWidth - logoImage:getWidth()) / 2
            local logoY = (screenHeight - logoImage:getHeight()) / 2
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(logoImage, logoX, logoY)
            love.graphics.setColor(1, 1, 1, 1)
        end,

        drawLogoText = function(self, text, logoName)
            -- Screen dimensions
            local screenWidth = love.graphics.getWidth()
            local screenHeight = love.graphics.getHeight()

            --
            local text = text or "random text"

            -- Logo dimensions
            local logoX = (screenWidth - logoName:getWidth()) / 2
            local logoY = (screenHeight - logoName:getHeight()) / 2

            -- Text dimensions
            local font = love.graphics.getFont()
            local textWidth = font:getWidth(text)
            local textHeight = font:getHeight()

            -- Calculate text position
            local textX = (screenWidth - textWidth) / 2 -- Center horizontally
            local textY = logoY + logoName:getHeight() + 10 -- Place below the logo with padding

            love.graphics.print(text, textX, textY)
        end
    }
end

local drew = drewThings()

return drew