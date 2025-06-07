local function chartLoader()
    -- Function to parse a chart file and return a table with the data
    return {

        local chart = {
            bpm = 120,
            song = "",
            notes = {}
        },

        loadChart = function(fileName)
            local path = "assests/charts/".. fileName
            local inNotes = false
    
            for line in love.filesystem.lines(path) do
                if line == "[NOTES]" then
                    inNotes = true
                elseif inNotes then
                    local time, noteType, mustHit = line:match("(%d+),(%d+),(%a+)")
                    if time and noteType and mustHit then
                        table.insert(chart.notes, {time = tonumber(time), type = tonumber(noteType), mustHit = mustHit == "true"})
                    end
                else
                    local key, value = line:match("^(.-)=(.+)$")
                    if key and value then
                        chart[key:lower()] = tonumber(value) or value
                    end
                end
            end
        end
    
        
    }
end

local chart = chartLoader()
return chart
    


