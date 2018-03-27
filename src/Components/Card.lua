local Configuration = require(script.Parent.Parent.Configuration)
local Roact = Configuration.Roact
local RoactAnimate = Configuration.RoactAnimate

local ThemeAccessor = require(script.Parent.Parent.Utility.ThemeAccessor)
local Shadow = require(script.Parent.Shadow)

local e = Roact.createElement

-- Another stateful component that could be functional but for context.
local Card = Roact.Component:extend("MaterialCard")

function Card:render()
    -- Root frame is for proper ZIndex nesting.
    return e(RoactAnimate.Frame, {
        BackgroundTransparency = 1;
        ZIndex = self.props.ZIndex,
        Size = self.props.Size,
        AnchorPoint = self.props.AnchorPoint,
        Position = self.props.Position,
    }, {
        e(RoactAnimate.Frame, {
            BackgroundColor3 = ThemeAccessor.Get(self, "BackgroundColor"),
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 2,
            ClipsDescendants = true,
        }, self.props[Roact.Children]),
        e(Shadow, {
            Elevation = self.props.Elevation,
            ZIndex = 1,
        })
    })
end

return Card
