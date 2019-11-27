local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Close = require(script.Parent.Close)
local Roact = require(ReplicatedStorage.Vendor.Roact)
local RoactRodux = require(ReplicatedStorage.Vendor.RoactRodux)

local e = Roact.createElement

local Codes = Roact.PureComponent:extend("Codes")

function Codes:init()
	self.textBoxRef = Roact.createRef()

	self.send = function()
		local textBoxValue = self.textBoxRef:getValue()
		local text = textBoxValue.Text

		if text:match("^%s*$") then
			self.props.close()
		else
			ReplicatedStorage.Remotes.SendCode:FireServer(text)
		end
	end

	self.connection = ReplicatedStorage.Remotes.SendCode.OnClientEvent:connect(function(response)
		if type(response) == "number" then
			self:setState({
				response = {
					type = "received",
					gold = response,
				},
			})
		elseif response == "c" then
			self:setState({
				response = {
					type = "claimed",
				},
			})
		elseif response == "i" then
			self:setState({
				response = {
					type = "invalid",
				}
			})
		else
			error("unknown code response: " .. response)
		end
	end)
end

function Codes:willUnmount()
	self.connection:Disconnect()
end

function Codes:render()
	local children = {}

	children.Close = e(Close, {
		onClose = self.props.close,
	})

	children.UIAspectRatioConstraint = e("UIAspectRatioConstraint", {
		AspectRatio = 2,
	})

	children.Label = e("TextLabel", {
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamSemibold,
		Position = UDim2.fromScale(0.5, 0.01),
		Size = UDim2.fromScale(0.95, 0.2),
		Text = "Enter codes from the group!",
		TextColor3 = Color3.new(1, 1, 1),
		TextScaled = true,
		ZIndex = 0,
	})

	children.Frame = e("Frame", {
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.5,
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0.5, 0.22),
		Size = UDim2.fromScale(0.95, 0.6),
	}, {
		Input = e("TextBox", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			ClearTextOnFocus = false,
			Font = Enum.Font.GothamBold,
			PlaceholderColor3 = Color3.new(0.88, 0.88, 0.88),
			PlaceholderText = "Enter Code",
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(0.98, 0.98),
			Text = "",
			TextColor3 = Color3.new(1, 1, 1),
			TextSize = 60,
			TextWrapped = true,
			[Roact.Ref] = self.textBoxRef,
		}),
	})

	children.Send = e("TextButton", {
		AnchorPoint = Vector2.new(0.5, 1),
		BackgroundColor3 = Color3.fromRGB(76, 209, 55),
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0.5, 0.99),
		Size = UDim2.fromScale(0.9, 0.15),
		Text = "",
		[Roact.Event.MouseButton1Click] = self.send,
	}, {
		Send = e("TextLabel", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(1, 1),
			Text = "SUBMIT",
			TextColor3 = Color3.new(1, 1, 1),
			TextScaled = true,
		})
	})

	return e("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(116, 185, 255),
		BackgroundTransparency = 0.5,
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 0.5),
		Visible = self.props.open,
	}, children)
end

return RoactRodux.connect(function(state)
	return {
		open = state.page.current == "Codes",
	}
end, function(dispatch)
	return {
		close = function()
			dispatch({
				type = "CloseCodes",
			})
		end,
	}
end)(Codes)
