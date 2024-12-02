fadeDuration = 1.5 -- Time for fade-in/out in seconds
displayDuration = 2 -- Time logos stay fully visible after fade-in
currentPhase = 1
startTime = love.timer.getTime()

function love.load()
    love.window.setMode(800, 600, {
        resizable = false, -- Prevent resizing by dragging the window
        fullscreen = false, -- Not fullscreen
        vsync = true -- Enable vertical sync to prevent screen tearing
    })

    logo = love.graphics.newImage('assets/images/logo.png')
    NGlogo = love.graphics.newImage('assets/images/newgrounds_logo.png')
    font = love.graphics.newFont(24)
    love.graphics.setFont(font)
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
    end
    
end

function love.draw()
    if currentPhase == 1 then
        -- Draw the logo only if elapsed time is greater than 5
        drawLogoWithFade(logo)
    elseif currentPhase == 2 then
        drawLogoWithFade(NGlogo)
    elseif currentPhase == 3 then
        love.graphics.setColor(1, 0, 0)
        love.graphics.print("Press ENTER to continue", 250, 300)
    end

    love.graphics.setFont(font)
    love.graphics.print(currentPhase, 0, 0)
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
