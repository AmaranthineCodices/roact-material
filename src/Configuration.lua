-- RoactMaterial global configuration.
-- Changing these settings affects the functioning of the entire library.

local Configuration = {
	-- The Roact library. Change this if you did not install Roact in ReplicatedStorage.
	Roact = require(game:GetService("ReplicatedStorage"):WaitForChild("Roact"));

	-- The RoactAnimate library. Change this if you did not install RoactAnimate in ReplicatedStorage.
	RoactAnimate = require(game:GetService("ReplicatedStorage"):WaitForChild("RoactAnimate"));

	-- Various warnings in the components.
	Warnings = {};
}

return Configuration
