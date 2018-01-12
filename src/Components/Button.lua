-- Material design button.
-- RoactMaterial does not implement floating action buttons, so they are not shown here.

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Import configuration; gives access to Roact library.
local Configuration = require(script.Parent.Parent.Configuration)
local Roact = Configuration.Roact

local Shadow = require(script.Parent.Shadow)
local Ink = require(script.Parent.Ink)

local BUTTON_FONT = Enum.Font.SourceSansSemibold
local BUTTON_FONT_SIZE = 14
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
	-- only change if we altered the mouse over state
	if self._lastMouseOver == nextState._mouseOver then return end
	self._lastMouseOver = nextState._mouseOver

	-- What's the goal color?
	-- TODO: theme integration
	local goalColor = nextState._mouseOver and nextProps.HoverColor3 or (nextProps.BackgroundColor3 or Color3.new(1, 1, 1))

	if self._currentTween then
		self._currentTween:Cancel()
	end

	local tween = TweenService:Create(self._rbx, COLOR_TWEEN_INFO, { BackgroundColor3 = goalColor })
	tween:Play()

	self._currentTween = tween
	tween.Completed:Wait()
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
	}, {
		Roact.createElement("TextButton", {
			AutoButtonColor = false;
			BorderSizePixel = 0;
			BackgroundColor3 = self.props.BackgroundColor3 or Color3.new(1, 1, 1);
			Size = UDim2.new(1, 0, 1, 0);
			Position = (not self.props.Flat and self.state._mouseOver) and UDim2.new(0, 0, 0, -1) or UDim2.new(0, 0, 0, 0);
			Font = BUTTON_FONT;
			TextSize = BUTTON_FONT_SIZE;
			Text = self.props.Text and BUTTON_TEXT_SUBSTITUTION(self.props.Text) or "";
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
		});

		Shadow = Roact.createElement(Shadow, {
			Elevation = elevation;
			ZIndex = 1;
		});
	})
end

return Button
