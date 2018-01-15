-- Checkbox!

local Configuration = require(script.Parent.Parent.Configuration)
local Roact = Configuration.Roact
local RoactAnimate = Configuration.RoactAnimate

local ThemeAccessor = require(script.Parent.Parent.Utility.ThemeAccessor)
local Icon = require(script.Parent.Icon)

local RIPPLE_IMAGE = "rbxassetid://1318074921"
local UNCHECKED_ICON = "check_box_outline_blank"
local CHECKED_ICON = "check_box"

local Checkbox = Roact.PureComponent:extend("MaterialCheckbox")

local c = Roact.createElement

local CHECK_OFFSET, CHECK_SIZE, CHECK_SHEET = Icon.GetIconInformation(CHECKED_ICON, 48)

function Checkbox:init(props)
    self.state = {
        Checked = props.Checked;
        _fillTransparency = RoactAnimate.Value.new(props.Checked and 0 or 1);
        _rippleSize = RoactAnimate.Value.new(UDim2.new(0, 0, 0, 0));
        _rippleTransparency = RoactAnimate.Value.new(0.6);
    }
end

function Checkbox:willUpdate(nextProps, nextState)
    local newTransparency = 1

    if nextState.Checked then
        newTransparency = 0
    end

    RoactAnimate.Parallel({
        RoactAnimate(self.state._fillTransparency, TweenInfo.new(0.225), newTransparency),
        RoactAnimate.Sequence({
            RoactAnimate.Prepare(self.state._rippleSize, UDim2.new(0, 0, 0, 0)),
            RoactAnimate.Prepare(self.state._rippleTransparency, 0.6),
            RoactAnimate(self.state._rippleSize, TweenInfo.new(0.15), UDim2.new(1.75, 0, 1.75, 0)),
            RoactAnimate(self.state._rippleTransparency, TweenInfo.new(0.15), 1)
        })
    }):Start()
end

function Checkbox:render()
    local outlineColor = ThemeAccessor.Get(self, "CheckOutlineColor")

    return c("Frame", {
        BackgroundTransparency = 1;
        Size = UDim2.new(0, 24, 0, 24);
        Position = self.props.Position;
        ZIndex = self.props.ZIndex;
    }, {
        InputHandler = c("TextButton", {
            BackgroundTransparency = 1;
            ZIndex = 2;
            Size = UDim2.new(1, 0, 1, 0);
            Text = "";

            [Roact.Event.MouseButton1Click] = function(rbx)
                self:setState({
                    Checked = not self.state.Checked;
                })
            end;
        }, {
            c(Icon.Icon, {
                Size = UDim2.new(1, 0, 1, 0);
                Resolution = 48;
                Icon = UNCHECKED_ICON;
                IconColor3 = outlineColor.Color;
                IconTransparency = outlineColor.Transparency;
            });
            c(RoactAnimate.ImageLabel, {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                Image = CHECK_SHEET;
                ZIndex = 2;
                ImageTransparency = self.state._fillTransparency;
                ImageColor3 = ThemeAccessor.Get(self, "PrimaryColor");
                ImageRectOffset = CHECK_OFFSET;
                ImageRectSize = CHECK_SIZE;
            })
        });
        Ripple = c(RoactAnimate.ImageLabel, {
            AnchorPoint = Vector2.new(0.5, 0.5);
            Position = UDim2.new(0.5, 0, 0.5, 0);
            BackgroundTransparency = 1;
            Image = RIPPLE_IMAGE;
            ImageColor3 = ThemeAccessor.Get(self, "PrimaryColor");
            ImageTransparency = self.state._rippleTransparency;
            Size = self.state._rippleSize;
            ZIndex = 1;
        })
    })
end

return Checkbox
