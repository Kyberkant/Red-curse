function transition()
    local transTimer = 0
    local transDur = 5
    local transActive = false
    local onTransEnd = function() end
    local panelSize = love.graphics.getHeight() / 2
    local noiseImage = love.graphics.newImage("assets/images/noise.png")
    local vignetteImage = love.graphics.newImage("assets/images/vignette.png")

    return {
        start = function(callback) -- function for start
            transActive = true
            transTimer = 0
            onTransEnd = callback

            --protection
            if type(callback) == "function" then
                onTransEnd = callback
            else
                onTransEnd = function() end
            end
        end,

        update = function(dt) -- function for update
            if transActive then
                transTimer = transTimer + dt
                if transTimer >= transDur then
                    transActive = false
                    if type(onTransEnd) == "function" then
                        onTransEnd()
                    end
                end
            end
        end,
        
        draw = function()
            if transActive then
                -- red transition effect
                --local t = transTimer / transDur
                -- local easedT = math.sin(t * math.pi) -- smooooooooth

                -- love.graphics.push()
                -- love.graphics.origin()

                -- love.graphics.setColor(1, 0, 0, 1)

                -- -- left up
                -- love.graphics.polygon("fill", {
                -- -panelSize + easedT * love.graphics.getWidth(), 0,
                -- 0, 0,
                -- love.graphics.getWidth(), love.graphics.getHeight(),
                -- love.graphics.getWidth() - easedT * love.graphics.getWidth(), love.graphics.getHeight()
                -- })

                -- -- right down
                -- love.graphics.polygon("fill", {
                -- love.graphics.getWidth(), love.graphics.getHeight(),
                -- love.graphics.getWidth(), love.graphics.getHeight() - easedT * love.graphics.getHeight(),
                -- 0, 0,
                -- 0, easedT * love.graphics.getHeight()
                -- })

                -- love.graphics.pop()
                -- love.graphics.setColor(1, 1, 1, 1)

                --  if transActive then
        
                local t = transTimer / transDur
                local easedT = math.sin(t * math.pi)

                love.graphics.push()
                love.graphics.origin()

                local noiseAlpha = 0.15 + math.random() * 0.05
                love.graphics.setColor(1,1,1, noiseAlpha)
                love.graphics.draw(noiseImage, 0, 0, 0, love.graphics.getWidth() / noiseImage:getWidth(), love.graphics.getHeight() / noiseImage:getHeight())


                
                love.graphics.setColor(0, 0, 0, easedT) 
                love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

                
                love.graphics.setColor(0.3, 0, 0, easedT * 0.4)
                love.graphics.rectangle("line", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

                love.graphics.setColor(0, 0, 0, easedT * 0.8) -- tmavší směrem ke konci přechodu
                love.graphics.draw(vignetteImage, 0, 0, 0,
                love.graphics.getWidth() / vignetteImage:getWidth(),
                love.graphics.getHeight() / vignetteImage:getHeight())

                love.graphics.pop()
                love.graphics.setColor(1, 1, 1, 1)
            end
        end
    }
end

local transition = transition()
return transition