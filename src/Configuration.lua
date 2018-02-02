-- RoactMaterial global configuration.
-- Changing these settings affects the functioning of the entire library.

local Configuration = {
	-- The Roact library.
	Roact = require(script.Parent.Parent.Roact);

	-- The RoactAnimate library.
	RoactAnimate = require(script.Parent.Parent.RoactAnimate);

	-- Various warnings in the components.
	Warnings = {};
}

return Configuration
