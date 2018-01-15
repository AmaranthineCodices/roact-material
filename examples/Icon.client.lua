local Roact = require(game.ReplicatedStorage.Roact)
local RoactMaterial = require(game.ReplicatedStorage.RoactMaterial)

local icons = {
    Roact.createElement("UIGridLayout", {
        CellSize = UDim2.new(0, 18, 0, 18);
        CellPadding = UDim2.new(0, 10, 0, 10);
        SortOrder = Enum.SortOrder.Name;
    });
}

local count = 0
for icon in pairs(require(game.ReplicatedStorage.RoactMaterial.Components.Icon.Spritesheets)) do
    icons[icon] = Roact.createElement(RoactMaterial.Icon, {
        Icon = icon;
        Size = UDim2.new(0, 18, 0, 18);
        IconColor3 = Color3.new(0, 0, 0);
    })

    count = count + 1
end

print(count)

local test = Roact.createElement(RoactMaterial.ThemeProvider, {
    Theme = RoactMaterial.Themes.Light;
    ComponentProperties = {
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    Component = "ScreenGui";
}, {
    Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0);
        BackgroundColor3 = Color3.new(1, 1, 1);
        BorderSizePixel = 0;
    }, {
        Roact.createElement("ScrollingFrame", {
            Size = UDim2.new(0.7, 0, 0.9, 0);
            Position = UDim2.new(0.15, 0, 0.05, 0);
            BackgroundTransparency = 1;
            CanvasSize = UDim2.new(0, 0, 100, 0);
            VerticalScrollBarInset = "Always";
        }, icons);
    })
})

Roact.reify(test, game.Players.LocalPlayer:WaitForChild("PlayerGui"), "IconExample")
