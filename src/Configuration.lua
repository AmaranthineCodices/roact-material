-- RoactMaterial global configuration.
-- Changing these settings affects the functioning of the entire library.

local Configuration = {
	-- The Roact library. Change this if you did not install Roact in ReplicatedStorage.
	Roact = require(game:GetService("ReplicatedStorage"):WaitForChild("Roact"));

	-- Various warnings in the components.
	Warnings = {
		-- Warn if a button's ZIndex is 1. If this was actually used it would cause layering issues.
		-- Specifically, the shadows would render above the button itself, and content would overlap.
		-- Buttons with a ZIndex property of 1 behave the same as if they had a ZIndex property of 2.
		ButtonZIndex = true;
	};
}

return Configuration
