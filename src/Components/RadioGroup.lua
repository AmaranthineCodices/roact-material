-- Radio group!

local Configuration = require(script.Parent.Parent.Configuration)
local Roact = Configuration.Roact

local RadioButton = require(script.Parent.RadioButton)
local TextView = require(script.Parent.TextView)

local RadioGroup = Roact.PureComponent:extend("MaterialRadioGroup")

function RadioGroup:init(props)
    self.state = {
        CurrentId = props.CurrentId
    }
end

function RadioGroup:render()
    local children = {
        Layout = Roact.createElement("UIListLayout", {
            Padding = UDim.new(0, 8);
            SortOrder = "Name";
        })
    }

    for id, label in pairs(self.props.Options) do
        local element = Roact.createElement("TextButton", {
            BackgroundTransparency = 1;
            Text = "";
            Size = UDim2.new(1, 0, 0, 24);

            [Roact.Event.MouseButton1Click] = function()
                if self.props.currentIdChanged then
                    self.props.currentIdChanged(id)
                end

                self:setState({
                    CurrentId = id
                })
            end
        }, {
            Roact.createElement(RadioButton, {
                Checked = id == self.state.CurrentId;
                onClicked = function()
                    if self.props.currentIdChanged then
                        self.props.currentIdChanged(id)
                    end

                    self:setState({
                        CurrentId = id
                    })
                end
            });
            Roact.createElement(TextView, {
                Class = "Body1";
                Position = UDim2.new(0, 30, 0, 0);
                Size = UDim2.new(1, -30, 0, 24);
                Text = label;
                TextXAlignment = "Left";
            })
        })

        children["RadioButton__"..tostring(id)] = element
    end

    -- Automated size computation
    local size = self.props.Size

    if self.props.SizeFromContents then
        -- Compute maximum text width
        local maximumTextWidth = 0
        for _, label in pairs(self.props.Options) do
            local bounds = TextView.getTextBounds(tostring(label), "Body1")

            if bounds.X > maximumTextWidth then
                maximumTextWidth = bounds.X
            end
        end

        size = UDim2.new(
            -- x: 30px (RadioButton size is 24px + 6px padding) + max. label width + 8px padding
            0, 30 + maximumTextWidth + 8,
            -- y: 24px (RadioButton height) + 8px padding
            0, 24 + 8
        )
    end

    return Roact.createElement("Frame", {
        BackgroundTransparency = 1;
        Size = size;
        Position = self.props.Position;
    }, children)
end

return RadioGroup
