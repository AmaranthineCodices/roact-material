local Roact = require(game.ReplicatedStorage.Roact)
local RoactMaterial = require(game.ReplicatedStorage.RoactMaterial)

local elevations = { 1, 2, 3, 4, 6, 8, 9, 12, 16}

local elevationFrames = {}

for _, elevation in ipairs(elevations) do
    table.insert(elevationFrames, Roact.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5);
        BackgroundColor3 = Color3.new(1, 1, 1);
        BorderSizePixel = 0;
        Position = UDim2.new(0.5, 0, 0.5, 0);
        Size = UDim2.new(0, 75, 0, 75);
        ZIndex = 2;
        }, {
            Roact.createElement(RoactMaterial.Shadow, {
                Elevation = elevation;
            });
            Roact.createElement("TextLabel", {
                Text = elevation;
                Font = Enum.Font.SourceSans;
                TextSize = 24;
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 1, 0);
                ZIndex = 2;
            })
        })
    )
end

table.insert(elevationFrames, Roact.createElement("UIGridLayout", {
    CellSize = UDim2.new(0, 150, 0, 150);
    CellPadding = UDim2.new(0, 25, 0, 25);
    HorizontalAlignment = Enum.HorizontalAlignment.Center;
    VerticalAlignment = Enum.VerticalAlignment.Center;
}))

local test = Roact.createElement("ScreenGui", {
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
}, {
    Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0);
        BackgroundColor3 = Color3.new(1, 1, 1);
        BorderSizePixel = 0;
    }, elevationFrames)
})

Roact.reify(test, game.Players.LocalPlayer:WaitForChild("PlayerGui"), "ShadowExample")