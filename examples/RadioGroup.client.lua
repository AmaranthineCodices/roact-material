local Roact = require(game.ReplicatedStorage.Roact)
local RoactMaterial = require(game.ReplicatedStorage.RoactMaterial)

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
        Roact.createElement(RoactMaterial.RadioGroup, {
            SizeFromContents = true,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            CurrentId = "test1",
            Options = {
                test1 = "Test 1",
                test2 = "Test 2",
                test3 = "Test 3"
            },

            currentIdChanged = function(newId)
                print(newId)
            end
        });
    })
})

Roact.reify(test, game.Players.LocalPlayer:WaitForChild("PlayerGui"), "CheckboxExample")
