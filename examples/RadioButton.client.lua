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
                CellSize = UDim2.new(0, 24, 0, 24);
                CellPadding = UDim2.new(0, 10, 0, 10);
                HorizontalAlignment = Enum.HorizontalAlignment.Center;
                VerticalAlignment = Enum.VerticalAlignment.Center;
            });
            Roact.createElement(RoactMaterial.RadioButton, {
                Checked = true;
            });
            Roact.createElement(RoactMaterial.RadioButton, {
            });
        })
    })
})

Roact.reify(test, game.Players.LocalPlayer:WaitForChild("PlayerGui"), "CheckboxExample")
