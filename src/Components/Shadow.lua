-- Material design shadow component.
-- Uses square blurs, not rounded ones. RoactMaterial does not use rounded corners.

-- Import configuration; gives access to Roact library.
local Configuration = require(script.Parent.Parent.Configuration)
local Roact = Configuration.Roact
local RoactAnimate = Configuration.RoactAnimate

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

local Shadow = Roact.PureComponent:extend("MaterialShadow")

function Shadow:init(props)
	assert(props.Elevation and SHADOW_SETTINGS[props.Elevation], "props.Elevation is invalid")

	local shadowProps = SHADOW_SETTINGS[props.Elevation]

	self.state = {
		_umbraTransparency = RoactAnimate.Value.new(shadowProps.Umbra.Transparency),
		_umbraSize = RoactAnimate.Value.new(UDim2.new(1, shadowProps.Umbra.Blur, 1, shadowProps.Umbra.Blur)),
		_umbraPosition = RoactAnimate.Value.new(UDim2.new(0.5, 0, 0.5, 0) + (shadowProps.Umbra.Offset or UDim2.new(0, 0, 0, 0))),
		_penumbraTransparency = RoactAnimate.Value.new(shadowProps.Penumbra.Transparency),
		_penumbraSize = RoactAnimate.Value.new(UDim2.new(1, shadowProps.Penumbra.Blur, 1, shadowProps.Penumbra.Blur)),
		_penumbraPosition = RoactAnimate.Value.new(UDim2.new(0.5, 0, 0.5, 0) + (shadowProps.Penumbra.Offset or UDim2.new(0, 0, 0, 0))),
		_ambientTransparency = RoactAnimate.Value.new(shadowProps.Ambient.Transparency),
		_ambientSize = RoactAnimate.Value.new(UDim2.new(1, shadowProps.Ambient.Blur, 1, shadowProps.Ambient.Blur)),
		_ambientPosition = RoactAnimate.Value.new(UDim2.new(0.5, 0, 0.5, 0) + (shadowProps.Ambient.Offset or UDim2.new(0, 0, 0, 0))),
	}
end

function Shadow:render()
	return Roact.createElement("Frame", {
		Name = "ShadowRoot";
		BackgroundTransparency = 1;
		Size = UDim2.new(1, 0, 1, 0);
		[Roact.Ref] = function(rbx)
			self._rbx = rbx
		end;
		ZIndex = self.props.ZIndex or 1;
	}, {
		Umbra = Roact.createElement(RoactAnimate.ImageLabel, {
			BackgroundTransparency = 1;
			Image = SHADOW_IMAGE;
			ImageColor3 = Color3.new(0, 0, 0);
			ImageTransparency = self.state._umbraTransparency;
			Size = self.state._umbraSize;
			AnchorPoint = Vector2.new(0.5, 0.5);
			Position = self.state._umbraPosition;
			ScaleType = Enum.ScaleType.Slice;
			SliceCenter = Rect.new(10, 10, 118, 118);
		}),
		Penumbra = Roact.createElement(RoactAnimate.ImageLabel, {
			BackgroundTransparency = 1;
			Image = SHADOW_IMAGE;
			ImageColor3 = Color3.new(0, 0, 0);
			ImageTransparency = self.state._penumbraTransparency;
			Size = self.state._penumbraSize;
			AnchorPoint = Vector2.new(0.5, 0.5);
			Position = self.state._penumbraPosition;
			ScaleType = Enum.ScaleType.Slice;
			SliceCenter = Rect.new(10, 10, 118, 118);
		}),
		Ambient = Roact.createElement(RoactAnimate.ImageLabel, {
			BackgroundTransparency = 1;
			Image = SHADOW_IMAGE;
			ImageColor3 = Color3.new(0, 0, 0);
			ImageTransparency = self.state._ambientTransparency;
			Size = self.state._ambientSize;
			AnchorPoint = Vector2.new(0.5, 0.5);
			Position = self.state._ambientPosition;
			ScaleType = Enum.ScaleType.Slice;
			SliceCenter = Rect.new(10, 10, 118, 118);
		}),
	})
end

function Shadow:willUpdate(nextProps, nextState)
	local shadowProps = SHADOW_SETTINGS[nextProps.Elevation]

	RoactAnimate.Parallel({
		RoactAnimate(self.state._umbraTransparency, SHADOW_TWEEN_INFO, shadowProps.Umbra.Transparency),
		RoactAnimate(self.state._umbraSize, SHADOW_TWEEN_INFO, UDim2.new(1, shadowProps.Umbra.Blur, 1, shadowProps.Umbra.Blur)),
		RoactAnimate(self.state._umbraPosition, SHADOW_TWEEN_INFO, UDim2.new(0.5, 0, 0.5, 0) + (shadowProps.Umbra.Offset or UDim2.new(0, 0, 0, 0))),
		RoactAnimate(self.state._penumbraTransparency, SHADOW_TWEEN_INFO, shadowProps.Penumbra.Transparency),
		RoactAnimate(self.state._penumbraSize, SHADOW_TWEEN_INFO, UDim2.new(1, shadowProps.Penumbra.Blur, 1, shadowProps.Penumbra.Blur)),
		RoactAnimate(self.state._penumbraPosition, SHADOW_TWEEN_INFO, UDim2.new(0.5, 0, 0.5, 0) + (shadowProps.Penumbra.Offset or UDim2.new(0, 0, 0, 0))),
		RoactAnimate(self.state._ambientTransparency, SHADOW_TWEEN_INFO, shadowProps.Ambient.Transparency),
		RoactAnimate(self.state._ambientSize, SHADOW_TWEEN_INFO, UDim2.new(1, shadowProps.Ambient.Blur, 1, shadowProps.Ambient.Blur)),
		RoactAnimate(self.state._ambientPosition, SHADOW_TWEEN_INFO, UDim2.new(0.5, 0, 0.5, 0) + (shadowProps.Ambient.Offset or UDim2.new(0, 0, 0, 0))),
	}):Start()
end

return Shadow
