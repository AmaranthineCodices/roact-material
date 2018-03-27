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

function Checkbox:init(props)
    self.state = {
        _fillTransparency = RoactAnimate.Value.new(props.Checked and 0 or 1);
        _rippleSize = RoactAnimate.Value.new(UDim2.new(0, 0, 0, 0));
        _rippleTransparency = RoactAnimate.Value.new(0.6);
    }
end

function Checkbox:willUpdate(nextProps, nextState)
    local newTransparency = 1
    local animations = {}

    if nextProps.Checked then
        newTransparency = 0

        if not self.props.Checked then
            table.insert(animations, RoactAnimate.Sequence({
                RoactAnimate.Prepare(self.state._rippleSize, UDim2.new(0, 0, 0, 0)),
                RoactAnimate.Prepare(self.state._rippleTransparency, 0.6),
                RoactAnimate(self.state._rippleSize, TweenInfo.new(0.25, Enum.EasingStyle.Sine), UDim2.new(1.75, 0, 1.75, 0)),
                RoactAnimate(self.state._rippleTransparency, TweenInfo.new(.08, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), 1)
            }))
        end
    end

    table.insert(animations, RoactAnimate(self.state._fillTransparency, TweenInfo.new(0.225), newTransparency))
    RoactAnimate.Parallel(animations):Start()
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
                if self.props.onChecked then
                    self.props.onChecked(not self.props.Checked)
                end;
            end;
        }, {
            c(Icon, {
                Size = UDim2.new(1, 0, 1, 0);
                Resolution = 48;
                Icon = UNCHECKED_ICON;
                IconColor3 = outlineColor.Color;
                IconTransparency = outlineColor.Transparency;
            });
            c(Icon, {
                Icon = CHECKED_ICON;
                IconColor3 = ThemeAccessor.Get(self, "PrimaryColor");
                IconTransparency = self.state._fillTransparency;
                Resolution = 48;
                Size = UDim2.new(1, 0, 1, 0);
                ZIndex = 2;
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
