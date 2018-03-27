-- Material design button.
-- RoactMaterial does not implement floating action buttons, so they are not shown here.

local UserInputService = game:GetService("UserInputService")

-- Import configuration; gives access to Roact library.
local Configuration = require(script.Parent.Parent.Configuration)
local Roact = Configuration.Roact
local RoactAnimate = Configuration.RoactAnimate

local Shadow = require(script.Parent.Shadow)
local Ink = require(script.Parent.Ink)
local TextView = require(script.Parent.TextView)
local ThemeAccessor = require(script.Parent.Parent.Utility.ThemeAccessor)

local BUTTON_TEXT_SUBSTITUTION = string.upper

local RIPPLE_TRIGGER_INPUT_TYPES = {
	Enum.UserInputType.MouseButton1,
	Enum.UserInputType.MouseButton2,
	Enum.UserInputType.MouseButton3,
	Enum.UserInputType.Touch
}

local COLOR_TWEEN_INFO = TweenInfo.new(
	0.15,
	Enum.EasingStyle.Linear
)

local Button = Roact.PureComponent:extend("MaterialButton")

function Button:init(props)
	self.state = {
		_pressed = false;
		_pressPoint = UDim2.new(0, 0, 0, 0);
		Elevation = 2;
		_mouseOver = false;
		_bgColor = RoactAnimate.Value.new(self.props.BackgroundColor3 or (self.props.Flat and ThemeAccessor.Get(self, "FlatButtonColor", Color3.new(1, 1, 1)) or ThemeAccessor.Get(self, "ButtonColor", Color3.new(1, 1, 1))));
	}

	self._lastInputEvent = tick()
end

function Button:didMount()
	self._uisConnection = UserInputService.InputEnded:Connect(function(input, gameProcessed)
		for _, allowed in ipairs(RIPPLE_TRIGGER_INPUT_TYPES) do
			if input.UserInputType == allowed then
				self:setState({
					_pressed = false;
				})

				break
			end
		end
	end)
end

function Button:willUnmount()
	if self._uisConnection then
		self._uisConnection:Disconnect()
	end
end

function Button:willUpdate(nextProps, nextState)
	local goalColor

	if nextState._pressed then
		goalColor = self.props.BackgroundColor3 or ThemeAccessor.Get(self, self.props.Flat and "FlatButtonPressColor" or "ButtonPressColor", Color3.new(0.9, 0.9, 0.9))
	elseif nextState._mouseOver then
		goalColor = self.props.BackgroundColor3 or ThemeAccessor.Get(self, self.props.Flat and "FlatButtonHoverColor" or "ButtonHoverColor", Color3.new(1, 1, 1))
	else
		goalColor = self.props.BackgroundColor3 or ThemeAccessor.Get(self, self.props.Flat and "FlatButtonColor" or "ButtonColor", Color3.new(1, 1, 1))
	end

	RoactAnimate(self.state._bgColor, COLOR_TWEEN_INFO, goalColor):Start()
end

function Button:render()
	local flat = self.props.Flat
	local elevation = (flat and 0) or self.state.Elevation

	-- root is a dummy frame
	return Roact.createElement("Frame", {
		BackgroundTransparency = 1;
		Position = self.props.Position or UDim2.new(0, 0, 0, 0);
		AnchorPoint = self.props.AnchorPoint or Vector2.new(0, 0);
		Size = self.props.Size or UDim2.new(0, 100, 0, 40);
		ZIndex = self.props.ZIndex or 1;
		LayoutOrder = self.props.LayoutOrder,
	}, {
		Roact.createElement(RoactAnimate.TextButton, {
			AutoButtonColor = false;
			BorderSizePixel = 0;
			BackgroundColor3 = self.state._bgColor;
			Size = UDim2.new(1, 0, 1, 0);
			Text = "";
			ZIndex = 2;

			[Roact.Ref] = function(rbx)
				self._rbx = rbx
			end;

			[Roact.Event.InputBegan] = function(rbx, input)
				for _, allowed in ipairs(RIPPLE_TRIGGER_INPUT_TYPES) do
					if input.UserInputType == allowed then
						local relativeX = (input.Position.X - rbx.AbsolutePosition.X) / rbx.AbsoluteSize.X
						local relativeY = (input.Position.Y - rbx.AbsolutePosition.Y) / rbx.AbsoluteSize.Y

						self:setState({
							_pressPoint = UDim2.new(relativeX, 0, relativeY, 0);
							_pressed = true;
						})

						break
					end
				end
			end;

			[Roact.Event.MouseEnter] = function()
				self:setState({
					Elevation = 4;
					_mouseOver = true;
				})
			end;

			[Roact.Event.MouseLeave] = function()
				self:setState({
					Elevation = 2;
					_mouseOver = false;
				})
			end
		}, self.props[Roact.Children]);

		Ink = Roact.createElement(Ink, {
			ZIndex = 3;
			Rippling = self.state._pressed;
			Origin = self.state._pressPoint;
			InkColor3 = self.props.Flat and ThemeAccessor.Get(self, "PrimaryColor") or Color3.new(1, 1, 1);
			InkTransparency = 0.5;
		});

		Shadow = Roact.createElement(Shadow, {
			Elevation = elevation;
			ZIndex = 1;
		});

		TextLabel = Roact.createElement(TextView, {
			Class = "Button";
			Size = UDim2.new(1, 0, 1, 0);
			Text = self.props.Text and BUTTON_TEXT_SUBSTITUTION(self.props.Text) or "";
			ZIndex = 4;
		})
	})
end

return Button
