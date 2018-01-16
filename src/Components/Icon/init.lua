local Configuration = require(script.Parent.Parent.Configuration)
local Roact = Configuration.Roact
local RoactAnimate = Configuration.RoactAnimate

local SHEET_ASSETS = {
    [1] = "rbxassetid://1330514658";
    [2] = "rbxassetid://1330515143";
    [3] = "rbxassetid://1330573324";
    [4] = "rbxassetid://1330573609";
    [5] = "rbxassetid://1330573880";
    [6] = "rbxassetid://1330574454";
    [7] = "rbxassetid://1330575498";
    [8] = "rbxassetid://1330575765";
    [9] = "rbxassetid://1330575939";
    [10] = "rbxassetid://1330582217";
    [11] = "rbxassetid://1330582416";
    [12] = "rbxassetid://1330582591";
    [13] = "rbxassetid://1330582964";
    [14] = "rbxassetid://1330583109";
    [15] = "rbxassetid://1330588230";
    [16] = "rbxassetid://1330588493";
    [17] = "rbxassetid://1330588679";
    [18] = "rbxassetid://1330588820";
    [19] = "rbxassetid://1330588932";
    [20] = "rbxassetid://1330592123";
}

local Spritesheet = require(script.Spritesheets)

local function ClosestResolution(icon, goalResolution)
    local closest = 0
    local closestDelta = nil

    for resolution in pairs(icon) do
        if goalResolution % resolution == 0 or resolution % goalResolution == 0 then
            return resolution
        elseif not closestDelta or math.abs(resolution - goalResolution) < closestDelta then
            closest = resolution
            closestDelta = math.abs(resolution - goalResolution)
        end
    end

    return closest
end

local Icon = {}

Icon.GetIconInformation = function(iconName, resolution)
    local icon = Spritesheet[iconName]
    local variant = icon[resolution]

    return Vector2.new(variant.X, variant.Y), Vector2.new(variant.Size, variant.Size), SHEET_ASSETS[variant.Sheet]
end

Icon.Icon = function(props)
    local iconName = props.Icon
    local icon = Spritesheet[iconName]

    -- Accept forced resolution
    local chosenResolution = props.Resolution

    if not chosenResolution then
        -- If we're using scale at all, use the highest possible resolution
        if props.Size.X.Scale ~= 0 or props.Size.Y.Scale ~= 0 then
            chosenResolution = ClosestResolution(icon, math.huge)
        -- Otherwise, best-guess it from the element's size
        else
            assert(props.Size.X.Offset == props.Size.Y.Offset, "If using offset Icon size must result in a square")
            chosenResolution = ClosestResolution(icon, props.Size.X.Offset)
        end
    end

    local variant = icon[chosenResolution]

    return Roact.createElement(RoactAnimate.ImageLabel, {
        Image = SHEET_ASSETS[variant.Sheet];
        BackgroundTransparency = 1;
        ImageRectSize = Vector2.new(variant.Size, variant.Size);
        ImageRectOffset = Vector2.new(variant.X, variant.Y);
        ImageColor3 = props.IconColor3;
        ImageTransparency = props.IconTransparency;
        Size = props.Size;
        Position = props.Position;
        AnchorPoint = props.AnchorPoint;
    })
end

return Icon
