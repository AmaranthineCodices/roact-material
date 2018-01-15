local lfs = require("lfs")
local JSON = require("JSON")

local output = { "return {\n" }
local icons = {}

for file in lfs.dir("./") do
    if file:match("%.json$") then
        local handle = io.open(file, "r")
        local content = handle:read("*all")
        handle:close()

        local sheet = file:match("sheet%-(%d+)")
        print(sheet, file)

        local decoded = JSON:decode(content)
        local frames = decoded.frames

        for _, frame in ipairs(frames) do
            local frameName, rawFrameSize = frame.filename:match("^ic_([_%w]-)_white_?(%d*)p?t?%_2x.png")
            print(frame.filename, frameName, rawFrameSize)
            icons[frameName] = icons[frameName] or {}
            local icon = icons[frameName]
            local frameSize = (tonumber(rawFrameSize) or 24) * 2

            icon[frameSize] = {
                X = frame.frame.x;
                Y = frame.frame.y;
                Width = frame.frame.w;
                Height = frame.frame.h;
                Sheet = tonumber(sheet);
            }
        end
    end
end

for key, icon in pairs(icons) do
    table.insert(output, "\t[")
    table.insert(output, ("%q"):format(key))
    table.insert(output, "] = {\n")

    for size, variant in pairs(icon) do
        table.insert(output, "\t\t[")
        table.insert(output, size)
        table.insert(output, "] = {\n")
        table.insert(output, "\t\t\tX = ")
        table.insert(output, variant.X)
        table.insert(output, ";\n")
        table.insert(output, "\t\t\tY = ")
        table.insert(output, variant.Y)
        table.insert(output, ";\n")
        table.insert(output, "\t\t\tWidth = ")
        table.insert(output, variant.Width)
        table.insert(output, ";\n")
        table.insert(output, "\t\t\tHeight = ")
        table.insert(output, variant.Height)
        table.insert(output, ";\n")
        table.insert(output, "\t\t\tSheet = ")
        table.insert(output, variant.Sheet)
        table.insert(output, ";\n")
        table.insert(output, "\t\t};\n")
    end

    table.insert(output, "\t};\n")
end

table.insert(output, "}")
local outputString = table.concat(output, "")
local h = io.open("spritesheet.lua", "w")
h:write(outputString)
h:close()
