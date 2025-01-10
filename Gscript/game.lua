function createGame()
    return {
        state = {
            menu = false,
            story = false,
            setting = false,
            void = true
        },

        switchGameState = function(self, state)
            self.state.menu = state == "menu"
            self.state.story = state == "story"
            self.state.setting = state == "setting"
            self.state.void = state == "void"
        end
    }
end

local game = createGame()

return game 