local game = require "Gscript/game"
local buttons = require "Gscript/menuButtons"
local drew = require "Gscript/drawStuff"
-- local json = require "lib/dkjson"
local makeGridQuads = require "Gscript/spriteGrid"
local newAnimation = require "Gscript/simpleAnim"
local animatedStorage = require "Gscript/animatedStorage"
local transition = require "Gscript/transition"
-- local chart = require "Gscript/chartLoader"

local fadeDuration = 1.5 -- Time for fade-in/out in seconds
local displayDuration = 2 -- Time logos stay fully visible after fade-in
local currentPhase = 3
local menuItem = 1
local logoStartTime = 0
local logoAnimDuration = 1.8
local startTime = love.timer.getTime()
local keyPressed = nil
local menuDebug = true
local logoIsPlaying = false
_G.targetHeight = 540
_G.targetWidth = 960
local scaleX, scaleY = 1, 1

local scrollMenu = love.audio.newSource("assets/sounds/scrollMenu.ogg", "static")



function love.load()
   
    love.window.setTitle("Red Curse")
    love.window.setMode(targetWidth, targetHeight, {resizable = true, vsync = true, fullscreen = false, minwidth = 480, minheight = 270})
    font = love.graphics.newFont(24)
    love.graphics.setFont(font)
    love.mouse.setVisible(false)
    
    love.graphics.setDefaultFilter("nearest", "nearest")
    
    

    animatedRlogo = animatedStorage.animatedLogoAnim

end

function love.update(dt)
    local elapsedTime = love.timer.getTime()

    if currentPhase == 1 then
        if elapsedTime < fadeDuration then
            alpha = elapsedTime / fadeDuration -- Fade in
        elseif elapsedTime < fadeDuration + displayDuration then
            alpha = 1 -- Fully visible
        elseif elapsedTime < fadeDuration * 2 + displayDuration then
            alpha = 1 - (elapsedTime - fadeDuration - displayDuration) / fadeDuration -- Fade out
        else
            currentPhase = 2 -- Move to next phase
            startTime = love.timer.getTime() -- Reset start time for next phase
        end
    elseif currentPhase == 2 then
        local phaseElapsedTime = love.timer.getTime() - startTime
        if phaseElapsedTime < fadeDuration then
            alpha = phaseElapsedTime / fadeDuration -- Fade in
        elseif phaseElapsedTime < fadeDuration + displayDuration then
            alpha = 1 -- Fully visible
        elseif phaseElapsedTime < fadeDuration * 2 + displayDuration then
            alpha = 1 - (phaseElapsedTime - fadeDuration - displayDuration) / fadeDuration -- Fade out
        else
            currentPhase = 3 -- Move to next phase
        end
    elseif currentPhase == 3 then
        animatedRlogo:update(dt)

        if animatedRlogo:isFinished() then
            
            currentPhase = 4
            game:switchGameState("menu")
                                
        end
    end

    if game.state.menu then

        love.mouse.setVisible(true)

        


        if keyPressed == "down" then
            scrollMenu:play()
            menuItem = menuItem + 1
            keyPressed = nil
        end

        if keyPressed == "up" then
            scrollMenu:play()
            menuItem = menuItem - 1
            keyPressed = nil
        end
        
        if menuItem == 1 then

            -- shader will activate on menuItem
            if keyPressed == "return" then
                game:switchGameState("story")
                keyPressed = nil
            end

        elseif menuItem == 2 then

             -- shader will activate on menuItem
            if keyPressed == "return" then
                game:switchGameState("freeplay")
                keyPressed = nil
            end

        elseif menuItem == 3 then

            -- shader will activate on menuItem
            if keyPressed == "return" then
                game:switchGameState("setting")
                keyPressed = nil
            end

        elseif menuItem == 4 then

            -- shader will activate on menuItem
            if keyPressed == "return" then
                game:switchGameState("credits")
                keyPressed = nil
            end

        elseif menuItem == 5 then

            -- shader will activate on menuItem
            if keyPressed == "return" then
                game:switchGameState("achievements")
                keyPressed = nil
            end

        end

    end

    if game.state.song1 then

        chart:loadChart("test.txt")

    for i, note in ipairs(chart.notes) do
        print("Note " .. i .. ": time=" .. note.time .. ", type=" .. note.type .. ", mustHit=" .. tostring(note.mustHit))
    end

        if keyPressed == "escape" then
            game:switchGameState("menu")
            keyPressed = nil
        end
    end

    if game.state.song2 then
        if keyPressed == "escape" then
            game:switchGameState("menu")
            keyPressed = nil
        end
    end

    if game.state.setting then
        if keyPressed == "escape" then
            game:switchGameState("menu")
            keyPressed = nil
        end
    end

    if game.state.song3 then
        if keyPressed == "escape" then
            game:switchGameState("menu")
            keyPressed = nil
        end
    end

    if game.state.achievements then
        if keyPressed == "escape" then
            game:switchGameState("menu")
            keyPressed = nil
        end
    end
    -- animated things here
    
    transition.update(dt) -- Update the transition if it's active
end

function love.resize(w, h)
    scaleX = w / targetWidth
    scaleY = h / targetHeight
end

function love.draw()
    
    love.graphics.push()
    love.graphics.scale(scaleX, scaleY) -- Apply scaling based on the window size


    if currentPhase == 1 then
        -- Draw the logo only if elapsed time is greater than 5
        drew:drawLogoWithFade(drew.logoNames.logo, alpha)
    elseif currentPhase == 2 then
        drew:drawLogoWithFade(drew.logoNames.NGlogo, alpha)
    elseif currentPhase == 3 then
        animatedRlogo:draw((targetWidth - 553) / 2, (targetHeight - 399) / 2)
        
        -- animatedRLogo:stop() 
        love.graphics.setColor(1, 0, 0)
        drew:drawLogoText("press ENTER to continue", drew.logoNames.Rlogo, textX, textY)
        love.graphics.setColor(1, 1, 1)
        -- drew:drawLogoText(#animatedStorage.animatedLogoGrid, drew.logoNames.Rlogo, textX, textY)

    end

    if game.state.menu then 
        love.graphics.clear(0, 0.2, 0.4) -- Clear the screen with a blue color
        
        --love.graphics.print("Current Menu Item: " .. menuItem, 10, 10) -- Debugging line
        

        local screenWidth, screenHeight = love.graphics.getDimensions() 


        for name, img in pairs(drew.menuImg) do
            --love.graphics.print("Current Image: " .. name, 10, 10) 
            drew:drawMenu(img) -- Draws the image
        end
    end

    transition.draw() -- Draw the transition effect if active
    
    if menuDebug then 
        love.graphics.setFont(font)
        love.graphics.print(currentPhase, 0, 0)
    end
    -- love.graphics.print("Menu State: " .. tostring(game.state.void), 10, 10) -- Debugging line
    
    love.graphics.printf("FPS: " ..love.timer.getFPS(), love.graphics.newFont(16), 10, love.graphics.getHeight() - 30, love.graphics.getWidth())
    love.graphics.pop() -- Pop the scaling transformation
end

function love.keypressed(key, scancode, isrepeat)

    keyPressed = key -- Store the key that was pressed

    if game.state.void then
       if currentPhase == 3 then
            if key == "escape" then
                love.event.quit()
            end 
       end
    end
    
    if game.state.menu then
        if keyPressed == "escape" then
            game:switchGameState("void")
            currentPhase = 3
            
        end
    end

    if currentPhase == 3 then
        if key == "return" and not logoIsPlaying then
            animatedRlogo:play()
            keyPressed = nil
            -- logoIsPlaying = true
            -- logoStartTime = love.timer.getTime()

        end
    end

    if game.state.menu then
        if key == "return" then
            transition:start(function()
                game:switchGameState("story")
            end)
            keyPressed = nil
        end
    end
end



easing = {}


