-- The root module of RoactMaterial; provides access to all the components.

local RoactMaterial = {}

for _, component in ipairs(script:WaitForChild("Components"):GetChildren()) do
	RoactMaterial[component.Name] = require(component)
end

return RoactMaterial
