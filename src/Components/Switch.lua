-- Switch!

local Configuration = require(script.Parent.Parent.Configuration)
local Roact = Configuration.Roact
local RoactAnimate = Configuration.RoactAnimate

local ThemeAccessor = require(script.Parent.Parent.Utility.ThemeAccessor)

local CIRCLE_IMAGE = "rbxassetid://1318074921"
local TOGGLE_SHADOW_IMAGE = "rbxassetid://1332905573"

local Switch = Roact.PureComponent:extend("MaterialSwitch")

local c = Roact.createElement

function Switch:init(props)
    self.state = {
        _trackColor = RoactAnimate.Value.new(ThemeAccessor.Get(self, props.Checked and "SwitchTrackOnColor" or "SwitchTrackOffColor"));
        _toggleColor = RoactAnimate.Value.new(ThemeAccessor.Get(self, props.Checked and "SwitchToggleOnColor" or "SwitchToggleOffColor"));
        _togglePosition = RoactAnimate.Value.new(props.Checked and UDim2.new(1, -10, 0.5, 0) or UDim2.new(0, 10, 0.5, 0));
        _rippleSize = RoactAnimate.Value.new(UDim2.new(0, 0, 0, 0));
        _rippleTransparency = RoactAnimate.Value.new(0.6);
        _rippleColor = RoactAnimate.Value.new(Color3.new(0, 0, 0));
    }
end

function Switch:willUpdate(nextProps, nextState)
    print(self.props.Checked, nextProps.Checked)
    if self.props.Checked ~= nextProps.Checked then
        local newTogglePosition = nextProps.Checked and UDim2.new(1, -10, 0.5, 0) or UDim2.new(0, 10, 0.5, 0)
        local newToggleColor = ThemeAccessor.Get(self, nextProps.Checked and "SwitchToggleOnColor" or "SwitchToggleOffColor")
        local newTrackColor = ThemeAccessor.Get(self, nextProps.Checked and "SwitchTrackOnColor" or "SwitchTrackOffColor")
        local newRippleColor = ThemeAccessor.Get(self, nextProps.Checked and "SwitchRippleOnColor" or "SwitchRippleOffColor")

        RoactAnimate.Parallel({
            RoactAnimate(self.state._togglePosition, TweenInfo.new(0.225), newTogglePosition),
            RoactAnimate(self.state._toggleColor, TweenInfo.new(0.225), newToggleColor),
            RoactAnimate(self.state._trackColor, TweenInfo.new(0.225), newTrackColor),
            RoactAnimate.Sequence({
                RoactAnimate.Prepare(self.state._rippleSize, UDim2.new(0, 0, 0, 0)),
                RoactAnimate.Prepare(self.state._rippleTransparency, 0.6),
                RoactAnimate.Prepare(self.state._rippleColor, newRippleColor),
                RoactAnimate(self.state._rippleSize, TweenInfo.new(0.15), UDim2.new(1.75, 0, 1.75, 0)),
                RoactAnimate(self.state._rippleTransparency, TweenInfo.new(0.15), 1)
            })
        }):Start()
    end
end

function Switch:render()
    return c("TextButton", {
        BackgroundTransparency = 1;
        Text = "";
        Size = UDim2.new(0, 36, 0, 20);
        Position = self.props.Position;
        ZIndex = self.props.ZIndex;

        [Roact.Event.MouseButton1Click] = function(rbx)
            self.props.onChecked(not self.props.Checked)
        end;
    }, {
        Track = c(RoactAnimate.ImageLabel, {
            BackgroundTransparency = 1;
            Size = UDim2.new(1, 0, 0, 12);
            Position = UDim2.new(0, 0, 0.5, 0);
            AnchorPoint = Vector2.new(0, 0.5);
            Image = CIRCLE_IMAGE;
            ImageColor3 = self.state._trackColor;
            ScaleType = "Slice";
            SliceCenter = Rect.new(128, 128, 128, 128);
        });
        c(RoactAnimate.ImageLabel, {
            BackgroundTransparency = 1;
            Size = UDim2.new(0, 24, 0, 24);
            AnchorPoint = Vector2.new(0.5, 0.5);
            Position = self.state._togglePosition;
            Image = TOGGLE_SHADOW_IMAGE;
            ImageTransparency = 0.8;
            ZIndex = 2;
        }, {
            Toggle = c(RoactAnimate.ImageLabel, {
                BackgroundTransparency = 1;
                Size = UDim2.new(0, 20, 0, 20);
                Position = UDim2.new(0, 2, 0, 1);
                Image = CIRCLE_IMAGE;
                ImageColor3 = self.state._toggleColor;
                ZIndex = 2;
            });
            Ripple = c(RoactAnimate.ImageLabel, {
                AnchorPoint = Vector2.new(0.5, 0.5);
                Position = UDim2.new(0.5, 0, 0.5, 0);
                BackgroundTransparency = 1;
                Image = CIRCLE_IMAGE;
                ImageColor3 = self.state._rippleColor;
                ImageTransparency = self.state._rippleTransparency;
                Size = self.state._rippleSize;
                ZIndex = 1;
            })
        });
    })
end

return Switch
