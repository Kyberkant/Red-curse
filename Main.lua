local game = require "Gscript/game"
local buttons = require "Gscript/menuButtons"

local fadeDuration = 1.5 -- Time for fade-in/out in seconds
local displayDuration = 2 -- Time logos stay fully visible after fade-in
local currentPhase = 3
local menuItem = 1
local startTime = love.timer.getTime()
local keyPressed = nil
local menuDebug = true

function love.load()

    logo = love.graphics.newImage('assets/images/logo.png')
    NGlogo = love.graphics.newImage('assets/images/newgrounds_logo.png')
    Rlogo = love.graphics.newImage('assets/images/logoBumpin.png')
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
        drawLogoWithFade(logo)
    elseif currentPhase == 2 then
        drawLogoWithFade(NGlogo)
    elseif currentPhase == 3 then
        drawLogo(Rlogo)
        love.graphics.setColor(1, 0, 0)
        love.graphics.print("Press ENTER to continue", 250, 500)
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

function drawLogoWithFade(logoImage)
    -- 
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local logoX = (screenWidth - logoImage:getWidth()) / 2 
    local logoY = (screenHeight - logoImage:getHeight()) / 2
    love.graphics.setColor(1, 1, 1, alpha)
    love.graphics.draw(logoImage, logoX, logoY)
    love.graphics.setColor(1, 1, 1, 1)
end

function drawLogo(logoImage)
    -- 
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local logoX = (screenWidth - logoImage:getWidth()) / 2 
    local logoY = (screenHeight - logoImage:getHeight()) / 2
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(logoImage, logoX, logoY)
    love.graphics.setColor(1, 1, 1, 1)
end
