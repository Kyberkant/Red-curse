function createGame()
    return {
        state = {
            menu = false,
            song1 = false,
            song2 = false,
            song3 = false,
           
            setting = false,
            
            achievements = false,
            void = true
        },

        switchGameState = function(self, state)
            for k in pairs(self.state) do
                self.state[k] = false
            end
            self.state[state] = true
        end
    }
end

local game = createGame()

return game 