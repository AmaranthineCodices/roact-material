-- Accesses theme values through the context API.
-- THIS CODE WILL BREAK: https://github.com/Roblox/roact/issues/4
-- Update this when the context API changes.

local ThemeAccessor = {}

function ThemeAccessor.Get(object, key, default)
    local materialTheme = object._context._materialTheme
    return materialTheme[key] or default
end

return ThemeAccessor
