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
        if typeof(option) == "string" then
            contents["Option_"..option] = e(Button, {
                Flat = true,
                Size = UDim2.new(1, 0, 0, 32),
                Text = "",
                LayoutOrder = index,
            }, {
                e(TextView, {
                    Class = "Body1",
                    Text = option,
                    Size = UDim2.new(1, -24, 1, 0),
                    Position = UDim2.new(0, 24, 0, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                })
            })
        elseif typeof(option) == "table" then
            local content = option.Content
            local key = option.Key or tostring(content)

            if typeof(content) == "string" then
                content = e(TextView, {
                    Class = "Body1",
                    Text = content,
                    Size = UDim2.new(1, -24, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                })
            end

            contents["Option_"..key] = e(Button, {
                Flat = true,
                Size = UDim2.new(1, 0, 0, 32),
                Text = "",
                LayoutOrder = index,
            }, { content })
        elseif option == Menu.Divider then
            table.insert(contents, e("Frame", {
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
            }))
        end
    end

    return e(Card, {
        Elevation = 2,
        ZIndex = self.props.ZIndex,
        Size = self.state._size,
        Position = self.props.Position,
    }, contents)
end

return Menu
