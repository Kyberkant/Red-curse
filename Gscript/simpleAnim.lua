local function newAnimation(image, frames, duration)
    return {
        image = image,
        frames = frames,
        duration = duration,
        currentFrame = 1,
        timer = 0,
        playing = false,

        update = function(self, dt)
            if not self.playing then 
                return 
            end
            self.timer = self.timer + dt
            if self.timer >= self.duration then
                self.timer = self.timer - self.duration
                self.currentFrame = self.currentFrame + 1
                if self.currentFrame > #self.frames then
                    self.playing = false
                    self.finished = true
                end
            end
        end,

        isFinished = function(self)
            return self.finished or false
        end,

        draw = function(self, x, y, r, sx, sy, ox, oy)
            love.graphics.draw(self.image, self.frames[self.currentFrame], x, y, r or 0, sx or 1, sy or 1, ox or 0, oy or 0)
        end,

        reset = function(self)
            self.currentFrame = 1
            self.timer = 0
        end,

        play = function(self)
            self.playing = true
        end,
        pause = function(self)
            self.playing = false
        end,

        stop = function(self)
            self.playing = false
            self:reset()
        end,

        setFrame = function(self, frame)
            if frame >= 1 and frame <= #self.frames then
                self.currentFrame = frame
            end
        end,

        getWidth = function(self)
            return self.image:getWidth()
        end,

        getHeight = function(self)
            return self.image:getHeight()
        end,

        getFrameWidth = function(self)
            local _, _, w = self.frame[1]:getViewport()
            return w
        end,
        
        getFrameHeight = function(self)
            local _, _, _, h = self.frame[1]:getViewport()
            return h
        end,
        
    }

end

return newAnimation