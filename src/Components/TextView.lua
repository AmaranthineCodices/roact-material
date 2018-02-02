-- Shows text in a specific style.
-- Should be a functional component, but isn't, to access context (for themes).
-- Ref https://github.com/Roblox/roact/issues/13

-- Import configuration; gives access to Roact library.
local Configuration = require(script.Parent.Parent.Configuration)
local Roact = Configuration.Roact

local c = Roact.createElement

local ThemeAccessor = require(script.Parent.Parent.Utility.ThemeAccessor)

local TextView = Roact.PureComponent:extend("MaterialTextView")

function TextView:render()
    local textClass = self.props.Class
    local font = ThemeAccessor.Get(self, textClass.."Font")
    local size = ThemeAccessor.Get(self, textClass.."Size")

    return c("TextLabel", {
        AnchorPoint = self.props.AnchorPoint;
        BackgroundTransparency = 1;
        Font = font;
        LayoutOrder = self.props.LayoutOrder;
        LineHeight = self.props.LineHeight;
        Position = self.props.Position;
        Size = self.props.Size;
        Text = self.props.Text;
        TextColor3 = self.props.TextColor3 or ThemeAccessor.Get(self, "TextColor");
        TextSize = size;
        TextStrokeColor3 = self.props.TextStrokeColor3;
        TextStrokeTransparency = self.props.TextStrokeTransparency;
        TextTransparency = self.props.TextTransparency;
        TextXAlignment = self.props.TextXAlignment;
        TextYAlignment = self.props.TextYAlignment;
        ZIndex = self.props.ZIndex;
    }, self.props[Roact.Children])
end

return TextView
