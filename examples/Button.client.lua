local Roact = require(game.ReplicatedStorage.Roact)
local RoactMaterial = require(game.ReplicatedStorage.RoactMaterial)

local test = Roact.createElement("ScreenGui", {
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, {
    Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0);
        BackgroundColor3 = Color3.new(1, 1, 1);
        BorderSizePixel = 0;
    }, {
        Button = Roact.createElement(RoactMaterial.Button, {
            Text = "Raised";
            Position = UDim2.new(0.5, 0, 0.5, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
        })
    })
})

Roact.reify(test, game.Players.LocalPlayer:WaitForChild("PlayerGui"), "ButtonExample")
