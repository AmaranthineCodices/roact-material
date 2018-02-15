local Roact = require(game.ReplicatedStorage.Roact)
local RoactMaterial = require(game.ReplicatedStorage.RoactMaterial)

local test = Roact.createElement(RoactMaterial.ThemeProvider, {
    Theme = RoactMaterial.Themes.Light;
}, {
    Roact.createElement("ScreenGui", {
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, {
        Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0);
            BackgroundColor3 = Color3.new(1, 1, 1);
            BorderSizePixel = 0;
        }, {
            Roact.createElement("UIGridLayout", {
                CellSize = UDim2.new(0, 36, 0, 20);
                CellPadding = UDim2.new(0, 25, 0, 25);
                HorizontalAlignment = Enum.HorizontalAlignment.Center;
                VerticalAlignment = Enum.VerticalAlignment.Center;
            });
            Roact.createElement(RoactMaterial.Switch, {
                Checked = true;
            });
            Roact.createElement(RoactMaterial.Switch, {
            });
        })
    })
})

Roact.reify(test, game.Players.LocalPlayer:WaitForChild("PlayerGui"), "SwitchExample")
