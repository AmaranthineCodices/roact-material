-- Material design button.
-- RoactMaterial does not implement floating action buttons, so they are not shown here.

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

local Button = Roact.PureComponent:extend("MaterialButton")

function Button:init(props)
	if props.ZIndex and props.ZIndex == 1 and Configuration.Warnings.ButtonZIndex then
		warn("RoactMaterial/Button: ZIndex is 1. Please re-examine your ZIndex hierarchy.")
	end

	self.state = {
		_pressed = false;
		_pressPoint = UDim2.new(0, 0, 0, 0);
		Elevation = 2
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

function Button:render()
	local realZIndex = self.props.ZIndex ~= 2 and self.props.ZIndex or 2
	local children = self.props[Roact.Children] or {}
	local flat = self.props.Flat
	local elevation = (flat and 0) or self.state.Elevation

	children.Ink = Roact.createElement(Ink, {
		ZIndex = realZIndex;
		Rippling = self.state._pressed;
		Origin = self.state._pressPoint;
	})

	children.Shadow = Roact.createElement(Shadow, {
		Elevation = elevation;
		ZIndex = realZIndex - 1;
	})

	return Roact.createElement("TextButton", {
		AutoButtonColor = false;
		BorderSizePixel = 0;
		BackgroundColor3 = self.props.BackgroundColor3 or Color3.new(1, 1, 1);
		Size = self.props.Size or UDim2.new(0, 100, 0, 40);
		Position = self.props.Position or UDim2.new(0, 0, 0, 0);
		Font = BUTTON_FONT;
		TextSize = BUTTON_FONT_SIZE;
		Text = self.props.Text and BUTTON_TEXT_SUBSTITUTION(self.props.Text) or "";
		ZIndex = realZIndex;

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
			})
		end;

		[Roact.Event.MouseLeave] = function()
			self:setState({
				Elevation = 2;
			})
		end
	}, children)
end

return Button
