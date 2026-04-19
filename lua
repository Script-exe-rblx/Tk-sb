-- G's Coming Popup
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GsComing"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 150)
frame.Position = UDim2.new(0.5, -200, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0
frame.Parent = screenGui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(255, 50, 255)
stroke.Thickness = 3

local textLabel = Instance.new("TextLabel", frame)
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "G's COMING"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextSize = 32
textLabel.Font = Enum.Font.GothamBlack

-- Glow effect
local glow = Instance.new("Frame", frame)
glow.Size = UDim2.new(1, 20, 1, 20)
glow.Position = UDim2.new(0.5, -10, 0.5, -10)
glow.AnchorPoint = Vector2.new(0.5, 0.5)
glow.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
glow.BackgroundTransparency = 0.8
glow.BorderSizePixel = 0
glow.ZIndex = 0
Instance.new("UICorner", glow).CornerRadius = UDim.new(1, 0)

-- Auto remove after 5 seconds
task.delay(5, function()
    screenGui:Destroy()
end)

-- Pulsing animation
task.spawn(function()
    while screenGui and screenGui.Parent do
        for i = 1, 2 do
            glow.BackgroundTransparency = 0.7
            textLabel.TextColor3 = Color3.fromRGB(255, 100, 255)
            task.wait(0.2)
            glow.BackgroundTransparency = 0.85
            textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            task.wait(0.2)
        end
        task.wait(0.5)
    end
end)
