local Roact = require(game.ReplicatedStorage.Roact)
local RoactMaterial = require(game.ReplicatedStorage.RoactMaterial)

local elevations = { 1, 2, 3, 4, 6, 8, 9, 12, 16 }

local cards = {}

for _, elevation in ipairs(elevations) do
    table.insert(cards, Roact.createElement(RoactMaterial.Card, {
        Elevation = elevation,
        }, {
            Roact.createElement("TextLabel", {
                BackgroundColor3 = Color3.new(1, 1, 1);
                BorderSizePixel = 0;
                Text = elevation;
                Font = Enum.Font.SourceSans;
                TextSize = 24;
                Size = UDim2.new(1, 0, 1, 0);
                ZIndex = 2;
            })
        })
    )
end

table.insert(cards, Roact.createElement("UIGridLayout", {
    CellSize = UDim2.new(0, 150, 0, 150);
    CellPadding = UDim2.new(0, 25, 0, 25);
    HorizontalAlignment = Enum.HorizontalAlignment.Center;
    VerticalAlignment = Enum.VerticalAlignment.Center;
    SortOrder = "LayoutOrder";
}))

local test = Roact.createElement(RoactMaterial.ThemeProvider, {
    Theme = RoactMaterial.Themes.Light,
}, {
    Roact.createElement("ScreenGui", {
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    }, {
        Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0);
            BackgroundColor3 = Color3.new(1, 1, 1);
            BorderSizePixel = 0;
        }, cards)
    })
})

Roact.reify(test, game.Players.LocalPlayer:WaitForChild("PlayerGui"), "CardExample")
