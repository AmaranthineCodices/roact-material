-- Shows text in a specific style.
-- Should be a functional component, but isn't, to access context (for themes).
-- Ref https://github.com/Roblox/roact/issues/13

local TEXT_CLASSES = {
    -- Display styles
    Display4Font = "SourceSansLight";
    Display4Size = 96;
    Display3Font = "SourceSans";
    Display3Size = 72;
    Display2Font = "SourceSans";
    Display2Size = 56;
    Display1Font = "SourceSans";
    Display1Size = 48;
    -- Body styles
    Body2Font = "SourceSansSemibold";
    Body2Size = 18;
    Body1Font = "SourceSans";
    Body1Size = 18;
    -- Header styles
    TitleFont = "SourceSansSemibold";
    TitleSize = 24;
    HeadlineFont = "SourceSans";
    HeadlineSize = 32;
    SubheadingFont = "SourceSans";
    SubheadingSize = 20;
    -- Misc. styles
    ButtonFont = "SourceSansSemibold";
    ButtonSize = 18;
    CaptionFont = "SourceSans";
    CaptionSize = 14;
}

local TextService = game:GetService("TextService")

-- Import configuration; gives access to Roact library.
local Configuration = require(script.Parent.Parent.Configuration)
local Roact = Configuration.Roact

local c = Roact.createElement

local ThemeAccessor = require(script.Parent.Parent.Utility.ThemeAccessor)

local TextView = Roact.PureComponent:extend("MaterialTextView")

function TextView.getTextBounds(text, textClass, boundingRect)
    boundingRect = boundingRect or Vector2.new(10000, 10000)
    local font = TEXT_CLASSES[textClass.."Font"]
    local size = TEXT_CLASSES[textClass.."Size"]

    return TextService:GetTextSize(text, size, font, boundingRect)
end

function TextView:render()
    local textClass = self.props.Class
    local font = TEXT_CLASSES[textClass.."Font"]
    local size = TEXT_CLASSES[textClass.."Size"]

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
