local Colors = require(script.Parent.Parent.Colors)

local LightTheme = {
    TextColor = Colors.Grey900;
    PrimaryColor = Colors.Blue500;
    ButtonHoverColor = Colors.Lighten("Blue500", 1);
    ButtonPressColor = Colors.Darken("Blue500", 1);
    FlatButtonHoverColor = Colors.Lighten("Blue500", 4);
    FlatButtonPressColor = Colors.Lighten("Blue500", 3);
    FlatButtonColor = Colors.White;
    ButtonColor = Colors.Blue500;
}

return LightTheme
