function createGame()
    return {
        state = {
            menu = false,
            story = false,
            freeplay = false,
            setting = false,
            credits = false,
            achievements = false,
            void = true
        },

        switchGameState = function(self, state)
            self.state.menu = state == "menu"
            self.state.story = state == "story"
            self.state.freeplay = state == "freeplay"
            self.state.setting = state == "setting"
            self.state.credits = state == "credits"
            self.state.achievements = state == "achievements"
            self.state.void = state == "void"
        end
    }
end

local game = createGame()

return game 