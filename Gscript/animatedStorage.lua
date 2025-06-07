local function animatedStorage()
    local makeGridQuads = require("Gscript.spriteGrid")
    local newAnimation = require("Gscript.simpleAnim")


    local animatedLogo = love.graphics.newImage("assets/spritesheets/logo_spritesheet.png")
    local animatedLogoGrid = makeGridQuads(animatedLogo, 553, 399)
    local animatedLogoAnim = newAnimation(animatedLogo, animatedLogoGrid, 0.1)

    return {
        animatedLogoGrid = animatedLogoGrid,
        animatedLogoAnim = animatedLogoAnim
    }

end

local animatedStorage = animatedStorage()
return animatedStorage