local Colors = require(script.Parent.Parent.Colors)

local BaseTheme = require(script.Parent.Base)

local LightTheme = {
    TextColor = Colors.Grey900;
    PrimaryColor = Colors.Blue400;
    ButtonHoverColor = Colors.Lighten("Blue400", 1);
    ButtonPressColor = Colors.Darken("Blue400", 1);
    FlatButtonHoverColor = Colors.Lighten("Blue400", 4);
    FlatButtonPressColor = Colors.Lighten("Blue400", 3);
    FlatButtonColor = Colors.White;
    ButtonColor = Colors.Blue400;
}

setmetatable(LightTheme, { __index = BaseTheme })

return LightTheme
