-- Material design shadow component.
-- Uses square blurs, not rounded ones. RoactMaterial does not use rounded corners.

local TweenService = game:GetService("TweenService")

-- Import configuration; gives access to Roact library.
local Configuration = require(script.Parent.Parent.Configuration)
local Roact = Configuration.Roact

-- The shadow image used in the shadows.
local SHADOW_IMAGE = "rbxassetid://1316045217"

-- Material design specifies 10 different shadow settings. These are those settings.
-- Note: elevation 24 is *not* supported. It has some weird issues with the images.
-- TODO: sort those out; support elevation 24.
local SHADOW_SETTINGS = {
	[0] = {
		Umbra = {
			Transparency = 1;
			Blur = 0;
		};
		Penumbra = {
			Transparency = 1;
			Blur = 0;
		};
		Ambient = {
			Transparency = 1;
			Blur = 0;
		};
	},
	[1] = {
		Umbra = {
			Transparency = 1 - 0.14;
			Blur = 2;
		},
		Penumbra = {
			Transparency = 1 - 0.12;
			Blur = 2;
			Offset = UDim2.new(0, 0, 0, 2);
		},
		Ambient = {
			Transparency = 1 - 0.2;
			Blur = 3;
			Offset = UDim2.new(0, 0, 0, 1);
		}
	},
	[2] = {
		Umbra = {
			Transparency = 1 - 0.14;
			Blur = 4;
		},
		Penumbra = {
			Transparency = 1 - 0.12;
			Blur = 4;
			Offset = UDim2.new(0, 0, 0, 3);
		},
		Ambient = {
			Transparency = 1 - 0.2;
			Blur = 5;
			Offset = UDim2.new(0, 0, 0, 1);
		}
	},
	[3] = {
		Umbra = {
			Transparency = 1 - 0.14;
			Blur = 3;
			Offset = UDim2.new(0, 0, 0, 3);
		},
		Penumbra = {
			Transparency = 1 - 0.12;
			Blur = 4;
			Offset = UDim2.new(0, 0, 0, 3);
		},
		Ambient = {
			Transparency = 1 - 0.2;
			Blur = 8;
			Offset = UDim2.new(0, 0, 0, 1);
		}
	},
	[4] = {
		Umbra = {
			Transparency = 1 - 0.14;
			Blur = 4;
			Offset = UDim2.new(0, 0, 0, 2);
		},
		Penumbra = {
			Transparency = 1 - 0.12;
			Blur = 5;
			Offset = UDim2.new(0, 0, 0, 4);
		},
		Ambient = {
			Transparency = 1 - 0.2;
			Blur = 10;
			Offset = UDim2.new(0, 0, 0, 1);
		}
	},
	[6] = {
		Umbra = {
			Transparency = 1 - 0.14;
			Blur = 10;
			Offset = UDim2.new(0, 0, 0, 6);
		},
		Penumbra = {
			Transparency = 1 - 0.12;
			Blur = 18;
			Offset = UDim2.new(0, 0, 0, 1);
		},
		Ambient = {
			Transparency = 1 - 0.2;
			Blur = 5;
			Offset = UDim2.new(0, 0, 0, 3);
		}
	},
	[8] = {
		Umbra = {
			Transparency = 1 - 0.14;
			Blur = 10;
			Offset = UDim2.new(0, 0, 0, 8);
		},
		Penumbra = {
			Transparency = 1 - 0.12;
			Blur = 14;
			Offset = UDim2.new(0, 0, 0, 3);
		},
		Ambient = {
			Transparency = 1 - 0.2;
			Blur = 15;
			Offset = UDim2.new(0, 0, 0, 4);
		}
	},
	[9] = {
		Umbra = {
			Transparency = 1 - 0.14;
			Blur = 12;
			Offset = UDim2.new(0, 0, 0, 9);
		},
		Penumbra = {
			Transparency = 1 - 0.12;
			Blur = 16;
			Offset = UDim2.new(0, 0, 0, 3);
		},
		Ambient = {
			Transparency = 1 - 0.2;
			Blur = 6;
			Offset = UDim2.new(0, 0, 0, 5);
		}
	},
	[12] = {
		Umbra = {
			Transparency = 1 - 0.14;
			Blur = 17;
			Offset = UDim2.new(0, 0, 0, 12);
		},
		Penumbra = {
			Transparency = 1 - 0.12;
			Blur = 22;
			Offset = UDim2.new(0, 0, 0, 5);
		},
		Ambient = {
			Transparency = 1 - 0.2;
			Blur = 8;
			Offset = UDim2.new(0, 0, 0, 7);
		}
	},
	[16] = {
		Umbra = {
			Transparency = 1 - 0.14;
			Blur = 24;
			Offset = UDim2.new(0, 0, 0, 16);
		},
		Penumbra = {
			Transparency = 1 - 0.12;
			Blur = 30;
			Offset = UDim2.new(0, 0, 0, 6);
		},
		Ambient = {
			Transparency = 1 - 0.2;
			Blur = 10;
			Offset = UDim2.new(0, 0, 0, 8);
		}
	}
}

-- The tween info for the shadows' changes.
local SHADOW_TWEEN_INFO = TweenInfo.new(
	0.1,
	Enum.EasingStyle.Linear
)

local function CreateShadowsForElevation(elevation, zIndex)
	local elevationSettings = SHADOW_SETTINGS[elevation]
	local shadows = {}

	for key, settings in pairs(elevationSettings) do
		local image = Roact.createElement("ImageLabel", {
			Name = key;
			BackgroundTransparency = 1;
			Image = SHADOW_IMAGE;
			ImageColor3 = Color3.new(0, 0, 0);
			ImageTransparency = settings.Transparency;
			Size = UDim2.new(1, settings.Blur, 1, settings.Blur);
			AnchorPoint = Vector2.new(0.5, 0.5);
			Position = UDim2.new(0.5, 0, 0.5, 0) + (settings.Offset or UDim2.new(0, 0, 0, 0));
			ScaleType = Enum.ScaleType.Slice;
			SliceCenter = Rect.new(10, 10, 118, 118);
			ZIndex = zIndex;
		})

		shadows[key] = image
	end

	return shadows
end

local Shadow = Roact.PureComponent:extend("MaterialShadow")

function Shadow:init(props)
	assert(props.Elevation and SHADOW_SETTINGS[props.Elevation], "props.Elevation is invalid")
	self._currentTweens = {}
end

function Shadow:render()
	return Roact.createElement("Frame", {
		Name = "ShadowRoot";
		BackgroundTransparency = 1;
		Size = UDim2.new(1, 0, 1, 0);
		[Roact.Ref] = function(rbx)
			self._rbx = rbx
		end;
	}, CreateShadowsForElevation(self.props.Elevation, self.props.ZIndex or 1))
end

function Shadow:willUpdate(nextProps, nextState)
	-- Cancel the currently playing tweens.
	local currentTweens = self._currentTweens
	for _, tween in ipairs(currentTweens) do
		tween:Cancel()
	end

	-- New currentTweens table; will replace self._currentTweens
	local newTweens = {}

	-- Animate the umbra, penumbra, and ambient to their new values
	local newShadowProps = SHADOW_SETTINGS[nextProps.Elevation]

	table.insert(newTweens, TweenService:Create(self._rbx.Umbra, SHADOW_TWEEN_INFO, {
		ImageTransparency = newShadowProps.Umbra.Transparency;
		Size = UDim2.new(1, newShadowProps.Umbra.Blur, 1, newShadowProps.Umbra.Blur);
		Position = UDim2.new(0.5, 0, 0.5, 0) + (newShadowProps.Umbra.Offset or UDim2.new(0, 0, 0, 0));
	}))

	table.insert(newTweens, TweenService:Create(self._rbx.Penumbra, SHADOW_TWEEN_INFO, {
		ImageTransparency = newShadowProps.Penumbra.Transparency;
		Size = UDim2.new(1, newShadowProps.Penumbra.Blur, 1, newShadowProps.Penumbra.Blur);
		Position = UDim2.new(0.5, 0, 0.5, 0) + (newShadowProps.Penumbra.Offset or UDim2.new(0, 0, 0, 0));
	}))

	table.insert(newTweens, TweenService:Create(self._rbx.Ambient, SHADOW_TWEEN_INFO, {
		ImageTransparency = newShadowProps.Ambient.Transparency;
		Size = UDim2.new(1, newShadowProps.Ambient.Blur, 1, newShadowProps.Ambient.Blur);
		Position = UDim2.new(0.5, 0, 0.5, 0) + (newShadowProps.Ambient.Offset or UDim2.new(0, 0, 0, 0));
	}))

	-- Play all the tweens at once!
	for _, tween in ipairs(newTweens) do
		tween:Play()
	end

	-- Bookkeeping!
	self._currentTweens = newTweens

	-- Yield until all the tweens are done; stops component from instantly updating.
	-- Since the tween duration is the same for all the tweens we can just yield on one.
	newTweens[1].Completed:Wait()
end

return Shadow
