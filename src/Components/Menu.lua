-- Material design menu.

-- Import configuration; gives access to Roact library.
local Configuration = require(script.Parent.Parent.Configuration)
local Roact = Configuration.Roact
local e = Roact.createElement
local RoactAnimate = Configuration.RoactAnimate

local Button = require(script.Parent.Button)
local Card = require(script.Parent.Card)
local TextView = require(script.Parent.TextView)

local ThemeAccessor = require(script.Parent.Parent.Utility.ThemeAccessor)

local Menu = Roact.PureComponent:extend("MaterialMenu")
-- Signal value for a divider.
Menu.Divider = newproxy()

function Menu:init()
    self.state = {
        _size = RoactAnimate.Value.new(UDim2.new(0, 0, 0, 0)),
    }
end

function Menu:didUpdate()
    if self.props.Open then
        RoactAnimate(self.state._size, TweenInfo.new(0.2), self:_computeOpenSize()):Start()
    else
        RoactAnimate(self.state._size, TweenInfo.new(0.2), UDim2.new(0, 0, 0, 0)):Start()
    end
end

function Menu:_computeOpenSize()
    local width = self.props.Width
    local height = 0

    for _, option in ipairs(self.props.Options) do
        if option == Menu.Divider then
            height = height + 7
        else
            height = height + 32
        end
    end

    return UDim2.new(width.Scale, width.Offset, 0, height)
end

function Menu:render()
    local contents = {}

    contents["__Layout"] = e("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top,
    })

    for index, option in ipairs(self.props.Options) do
        if option == Menu.Divider then
            contents["Divider_"..index] = e("Frame", {
                Size = UDim2.new(1, 0, 0, 7),
                LayoutOrder = index,
                BackgroundTransparency = 1,
            }, {
                e("Frame", {
                    Size = UDim2.new(1, 0, 0, 1),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundTransparency = 0.85,
                    BackgroundColor3 = ThemeAccessor.Get(self, "InverseBackgroundColor"),
                    BorderSizePixel = 0,
                })
            })
        else
            local buttonContent, key

            if typeof(option) == "string" then
                key = option
                buttonContent = {
                e(TextView, {
                    Class = "Body1",
                    Text = option,
                    Size = UDim2.new(1, -24, 1, 0),
                    Position = UDim2.new(0, 24, 0, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                })
                }
        elseif typeof(option) == "table" then
                local optionContent = option.Content
                key = option.Key or tostring(optionContent)

                if typeof(optionContent) == "string" then
                    buttonContent = e(TextView, {
                    Class = "Body1",
                        Text = optionContent,
                    Size = UDim2.new(1, -24, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                })
                else
                    buttonContent = optionContent
                end
            end

            contents["Option_"..key] = e(Button, {
                Flat = true,
                Size = UDim2.new(1, 0, 0, 32),
                Text = "",
                LayoutOrder = index,
                InkColor3 = Color3.new(0.6, 0.6, 0.6),
                HoverColor3 = Color3.new(0.8, 0.8, 0.8),
                PressColor3 = Color3.new(0.7, 0.7, 0.7),

                onClicked = function()
                    self.props.onOptionSelected(option)
                end,
            }, buttonContent)
        end
    end

    return e(Card, {
        Elevation = self.props.Open and 2 or 0,
        ZIndex = self.props.ZIndex,
        Size = self.state._size,
        Position = self.props.Position,
    }, contents)
end

return Menu
