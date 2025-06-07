local function makeGridQuads(image, gridWidth, gridHeight)
    local quads = {}
    local imageWidth = image:getWidth()
    local imageHeight = image:getHeight()

    local collumns = math.floor(imageWidth / gridWidth)
    local rows = math.floor(imageHeight / gridHeight)
    local index = 1

    for y = 0, rows - 1 do
        for x = 0, collumns -1 do
            quads[index] = love.graphics.newQuad(x * gridWidth, y * gridHeight, gridWidth, gridHeight, imageWidth, imageHeight)
            index = index + 1
        end
    end
    return quads
end

return makeGridQuads