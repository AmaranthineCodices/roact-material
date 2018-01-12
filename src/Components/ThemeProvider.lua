-- Provides a theme via the context API.
-- This is extremely unstable. Roact's context API *will* change.
-- See https://github.com/Roblox/roact/issues/4.
-- Accessing the theme should be done through Utility.ThemeAccessor.
-- Never access context values directly to avoid breaks when (not if) the context API changes.

-- Import configuration; gives access to Roact library.
local Configuration = require(script.Parent.Parent.Configuration)
local Roact = Configuration.Roact

local ThemeProvider = Roact.PureComponent:extend("MaterialThemeProvider")

function ThemeProvider:init(props)
    -- I have no idea what happens if you try to re-render this thing.
    -- This shouldn't be changed ideally. At best everything works okay.
    -- At worst it flat out refuses to apply without forcibly re-rendering
    -- the entire component tree.
    self._context._materialTheme = props.Theme
end

function ThemeProvider:render()
    -- TODO: fragment API?
    return Roact.createElement(self.props.Component, self.props.ComponentProperties, self.props[Roact.Children])
end

return ThemeProvider
