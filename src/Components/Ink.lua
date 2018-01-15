-- Material design ink ripple component.

-- Import configuration; gives access to Roact library.
local Configuration = require(script.Parent.Parent.Configuration)
local Roact = Configuration.Roact
local RoactAnimate = Configuration.RoactAnimate

local RIPPLE_IMAGE = "rbxassetid://1318074921"
local RIPPLE_TWEEN_INFO = TweenInfo.new(
	0.2,
	Enum.EasingStyle.Linear,
	Enum.EasingDirection.In
)

local RIPPLE_MAX_SIZE = UDim2.new(2, 0, 2, 0)

local Ink = Roact.PureComponent:extend("MaterialInk")

function Ink:init(props)
	self.state = {
		_transparency = RoactAnimate.Value.new(1);
		_size = RoactAnimate.Value.new(UDim2.new(0, 0, 0, 0));
	}
end

function Ink:render()
	return Roact.createElement("Frame", {
		BackgroundTransparency = 1;
		ClipsDescendants = true;
		Size = self.props.Size or UDim2.new(1, 0, 1, 0);
		AnchorPoint = self.props.AnchorPoint or Vector2.new(0.5, 0.5);
		Position = self.props.Position or UDim2.new(0.5, 0, 0.5, 0);
		ZIndex = self.props.ZIndex or 1;

		[Roact.Ref] = function(rbx)
			self._container = rbx
		end
	}, {
		Rippler = Roact.createElement(RoactAnimate.ImageLabel, {
			BackgroundTransparency = 1;
			Image = RIPPLE_IMAGE;
			ImageColor3 = self.props.InkColor3 or Color3.new(0.4, 0.4, 0.4);
			ImageTransparency = self.state._transparency;
			Size = self.state._size;
			Position = self.props.Origin or UDim2.new(0.5, 0, 0.5, 0);
			AnchorPoint = Vector2.new(0.5, 0.5);

			[Roact.Ref] = function(rbx)
				self._rbx = rbx
			end
		})
	})
end

function Ink:willUpdate(nextProps, nextState)
	local goalSize = RIPPLE_MAX_SIZE
	local goalTransparency = self.props.InkTransparency or 0.5

	-- Before we start messing with size, we need to calculate the correct SizeConstraint.
	-- If x size > y size, use SizeXX. Otherwise, use SizeYY.
	local containerSize = self._container.AbsoluteSize
	if containerSize.X > containerSize.Y then
		self._rbx.SizeConstraint = Enum.SizeConstraint.RelativeXX
	else
		self._rbx.SizeConstraint = Enum.SizeConstraint.RelativeYY
	end

	-- If we're rippling, we need to animate to a rectangular scale size of 2 * math.sqrt(2)
	-- on each axis. This ensures it takes up the entire button from anywhere while expanding at an
	-- equal rate on every axis, which looks better.
	if nextProps.Rippling then
		-- Reset the size and position.
		self._rbx.Size = UDim2.new(0, 0, 0, 0)
		self._rbx.Position = nextProps.Origin or UDim2.new(0.5, 0, 0.5, 0)

		-- If the ink ripple was faded out, we'll need to reset it.
		self._rbx.ImageTransparency = self.props.InkTransparency or 0.5
	-- Otherwise, we're exiting the animation and we need to fade the ink ripple out.
	else
		goalTransparency = 1
	end

	RoactAnimate.Parallel({
		RoactAnimate(self.state._transparency, RIPPLE_TWEEN_INFO, goalTransparency),
		RoactAnimate(self.state._size, RIPPLE_TWEEN_INFO, goalSize)
	}):Start()
end

return Ink
