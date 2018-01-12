-- The root module of RoactMaterial; provides access to all the components.

local RoactMaterial = {}

for _, component in ipairs(script:WaitForChild("Components"):GetChildren()) do
	RoactMaterial[component.Name] = require(component)
end

RoactMaterial.Colors = require(script:WaitForChild("Colors"))
RoactMaterial.Themes = {}

for _, theme in ipairs(script:WaitForChild("Themes"):GetChildren()) do
	RoactMaterial.Themes[theme.Name] = require(theme)
end

return RoactMaterial
