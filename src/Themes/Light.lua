local Colors = require(script.Parent.Parent.Colors)

local BaseTheme = require(script.Parent.Base)

local LightTheme = {
    TextColor = Colors.Grey900;
    PrimaryColor = Colors.Blue500;
    ButtonHoverColor = Colors.Lighten("Blue500", 1);
    ButtonPressColor = Colors.Darken("Blue500", 1);
    FlatButtonHoverColor = Colors.Lighten("Blue500", 4);
    FlatButtonPressColor = Colors.Lighten("Blue500", 3);
    FlatButtonColor = Colors.White;
    ButtonColor = Colors.Blue500;

    SwitchTrackOnColor = Colors.Blue100;
    SwitchTrackOffColor = Colors.Grey400;
    SwitchToggleOnColor = Colors.Blue500;
    SwitchToggleOffColor = Colors.Grey100;
    SwitchRippleOnColor = Colors.Blue500;
    SwitchRippleOffColor = Colors.Grey400;

    CheckOutlineColor = {
        Color = Colors.Black;
        Transparency = 0.46;
    };
}

setmetatable(LightTheme, { __index = BaseTheme })

return LightTheme
