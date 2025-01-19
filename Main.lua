local game = require "Gscript/game"
local buttons = require "Gscript/menuButtons"
local drew = require "Gscript/drawStuff"

local fadeDuration = 1.5 -- Time for fade-in/out in seconds
local displayDuration = 2 -- Time logos stay fully visible after fade-in
local currentPhase = 1
local menuItem = 1
local startTime = love.timer.getTime()
local keyPressed = nil
local menuDebug = true

--love.window.setMode(1920,1080)

function love.load()

    font = love.graphics.newFont(24)
    love.graphics.setFont(font)
    love.mouse.setVisible(false)
    
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
        if keyPressed == "return" then
            currentPhase = 4
            keyPressed = nil
            game:switchGameState("menu")
        end
           
    end

    if game.state.menu then
        if menuItem == 1 then

            -- shader will activate on menuItem
            if keyPressed == "return" then
                game:switchGameState("story")
            end

        elseif menuItem == 2 then

             -- shader will activate on menuItem
            if keyPressed == "return" then
                game:switchGameState("freeplay")
            end

        elseif menuItem == 3 then

            -- shader will activate on menuItem
            if keyPressed == "return" then
                game:switchGameState("setting")
            end

        elseif menuItem == 4 then

            -- shader will activate on menuItem
            if keyPressed == "return" then
                game:switchGameState("credits")
            end

        elseif menuItem == 5 then

            -- shader will activate on menuItem
            if keyPressed == "return" then
                game:switchGameState("achievements")
            end

        end

    end
    
end

function love.draw()
    
    if currentPhase == 1 then
        -- Draw the logo only if elapsed time is greater than 5
        drew:drawLogoWithFade(drew.logoNames.logo, alpha)
    elseif currentPhase == 2 then
        drew:drawLogoWithFade(drew.logoNames.NGlogo, alpha)
    elseif currentPhase == 3 then
        drew:drawLogo(drew.logoNames.Rlogo)
        love.graphics.setColor(1, 0, 0)
        drew:drawLogoText("press ENTER to continue", drew.logoNames.Rlogo, textX, textY)

    end

    if game.state.menu then 
        -- menu function here
        buttons:makeButton(buttons.names.storyButton, -410, -250)
        buttons:makeButton(buttons.names.freeplayButton, -350, -100)
        buttons:makeButton(buttons.names.settingsButton, -340, 50)
        buttons:makeButton(buttons.names.achievementsButton, -150, 375, 0.5, 0.5)
        --love.graphics.rectangle('line',x,y,100,50)
    end

    if menuDebug then 
        love.graphics.setFont(font)
        love.graphics.print(currentPhase, 0, 0)
    end

    love.graphics.printf("FPS: " ..love.timer.getFPS(), love.graphics.newFont(16), 10, love.graphics.getHeight() - 30, love.graphics.getWidth())
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
    
end

