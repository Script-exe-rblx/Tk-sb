--========================================================
-- 67 HUB XoSh — Script Launcher V7
-- 19 Scripts | 30s Loading Screen
--========================================================

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local player           = Players.LocalPlayer

local openLauncher -- forward declaration

local SCRIPTS = {}

table.insert(SCRIPTS, {
    name  = "Freeze Trade Legit",
    icon  = "❄️",
    desc  = "FREEZE • TRADE • LEGIT",
    isNew = true,
    kind  = "embed",
    code  = [[
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NexioHub"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local parentSuccess = pcall(function()
	screenGui.Parent = PlayerGui
end)
if not parentSuccess then
	screenGui.Parent = game:GetService("CoreGui")
end

local baseSize = isMobile and UDim2.new(0, 300, 0, 370) or UDim2.new(0, 340, 0, 400)
local basePos = UDim2.new(0.5, isMobile and -150 or -170, 0.5, isMobile and -185 or -200)

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame.Position = basePos
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 5, 20)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 18)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(180, 60, 255)
mainStroke.Transparency = 0.3
mainStroke.Thickness = 1.5
mainStroke.Parent = mainFrame

local bgGradient = Instance.new("UIGradient")
bgGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 5, 50)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 5, 35)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 8, 65))
})
bgGradient.Rotation = 135
bgGradient.Parent = mainFrame

local glowFrame = Instance.new("Frame")
glowFrame.Size = UDim2.new(1, 0, 0, 3)
glowFrame.Position = UDim2.new(0, 0, 0, 0)
glowFrame.BackgroundColor3 = Color3.fromRGB(180, 60, 255)
glowFrame.BorderSizePixel = 0
glowFrame.ZIndex = 5
glowFrame.Parent = mainFrame

local glowGrad = Instance.new("UIGradient")
glowGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 0, 255)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 80, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 0, 255))
})
glowGrad.Parent = glowFrame

local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 55)
topBar.Position = UDim2.new(0, 0, 0, 3)
topBar.BackgroundTransparency = 1
topBar.ZIndex = 3
topBar.Parent = mainFrame

local logoContainer = Instance.new("Frame")
logoContainer.Size = UDim2.new(0, 36, 0, 36)
logoContainer.Position = UDim2.new(0, 14, 0.5, -18)
logoContainer.BackgroundColor3 = Color3.fromRGB(140, 40, 220)
logoContainer.BorderSizePixel = 0
logoContainer.ZIndex = 4
logoContainer.Parent = topBar

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0, 8)
logoCorner.Parent = logoContainer

local logoGrad = Instance.new("UIGradient")
logoGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 60, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 0, 180))
})
logoGrad.Rotation = 135
logoGrad.Parent = logoContainer

local logoLabel = Instance.new("TextLabel")
logoLabel.Size = UDim2.new(1, 0, 1, 0)
logoLabel.BackgroundTransparency = 1
logoLabel.Text = "N"
logoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
logoLabel.TextScaled = true
logoLabel.Font = Enum.Font.GothamBold
logoLabel.ZIndex = 5
logoLabel.Parent = logoContainer

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 120, 0, 22)
titleLabel.Position = UDim2.new(0, 58, 0, 8)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "NEXIO HUB"
titleLabel.TextColor3 = Color3.fromRGB(220, 150, 255)
titleLabel.TextScaled = false
titleLabel.TextSize = isMobile and 14 or 15
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.ZIndex = 4
titleLabel.Parent = topBar

local titleGrad = Instance.new("UIGradient")
titleGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 180, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 60, 255))
})
titleGrad.Parent = titleLabel

local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Size = UDim2.new(0, 170, 0, 16)
subtitleLabel.Position = UDim2.new(0, 58, 0, 30)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "Trade Controller"
subtitleLabel.TextColor3 = Color3.fromRGB(150, 100, 200)
subtitleLabel.TextScaled = false
subtitleLabel.TextSize = isMobile and 10 or 11
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
subtitleLabel.ZIndex = 4
subtitleLabel.Parent = topBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 28, 0, 28)
minimizeBtn.Position = UDim2.new(1, -42, 0.5, -14)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 90)
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = Color3.fromRGB(200, 150, 255)
minimizeBtn.TextSize = 16
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.BorderSizePixel = 0
minimizeBtn.ZIndex = 6
minimizeBtn.Parent = topBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 7)
minCorner.Parent = minimizeBtn

local divider = Instance.new("Frame")
divider.Size = UDim2.new(1, -28, 0, 1)
divider.Position = UDim2.new(0, 14, 0, 58)
divider.BackgroundColor3 = Color3.fromRGB(120, 40, 200)
divider.BackgroundTransparency = 0.5
divider.BorderSizePixel = 0
divider.Parent = mainFrame

local divGrad = Instance.new("UIGradient")
divGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)),
	ColorSequenceKeypoint.new(0.3, Color3.fromRGB(180,60,255)),
	ColorSequenceKeypoint.new(0.7, Color3.fromRGB(180,60,255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0))
})
divGrad.Parent = divider

local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, 0, 1, -60)
contentFrame.Position = UDim2.new(0, 0, 0, 60)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 10)
contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
contentLayout.VerticalAlignment = Enum.VerticalAlignment.Top
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = contentFrame

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingTop = UDim.new(0, 14)
contentPadding.PaddingLeft = UDim.new(0, 14)
contentPadding.PaddingRight = UDim.new(0, 14)
contentPadding.Parent = contentFrame

local function createToggleButton(name, icon, order)
	local btnHeight = isMobile and 52 or 58

	local container = Instance.new("Frame")
	container.Name = name .. "Container"
	container.Size = UDim2.new(1, 0, 0, btnHeight)
	container.BackgroundColor3 = Color3.fromRGB(20, 8, 40)
	container.BackgroundTransparency = 0.2
	container.BorderSizePixel = 0
	container.LayoutOrder = order
	container.Parent = contentFrame

	local containerCorner = Instance.new("UICorner")
	containerCorner.CornerRadius = UDim.new(0, 12)
	containerCorner.Parent = container

	local containerStroke = Instance.new("UIStroke")
	containerStroke.Color = Color3.fromRGB(120, 40, 200)
	containerStroke.Transparency = 0.6
	containerStroke.Thickness = 1
	containerStroke.Parent = container

	local containerGrad = Instance.new("UIGradient")
	containerGrad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 10, 65)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 5, 38))
	})
	containerGrad.Rotation = 135
	containerGrad.Parent = container

	local iconLabel = Instance.new("TextLabel")
	iconLabel.Size = UDim2.new(0, 32, 0, 32)
	iconLabel.Position = UDim2.new(0, 12, 0.5, -16)
	iconLabel.BackgroundColor3 = Color3.fromRGB(100, 30, 170)
	iconLabel.Text = icon
	iconLabel.TextColor3 = Color3.fromRGB(220, 150, 255)
	iconLabel.TextScaled = true
	iconLabel.Font = Enum.Font.GothamBold
	iconLabel.BorderSizePixel = 0
	iconLabel.ZIndex = 2
	iconLabel.Parent = container

	local iconCorner = Instance.new("UICorner")
	iconCorner.CornerRadius = UDim.new(0, 8)
	iconCorner.Parent = iconLabel

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Name = "ButtonName"
	nameLabel.Size = UDim2.new(1, -110, 0, 20)
	nameLabel.Position = UDim2.new(0, 54, 0.5, -14)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = name
	nameLabel.TextColor3 = Color3.fromRGB(230, 200, 255)
	nameLabel.TextScaled = false
	nameLabel.TextSize = isMobile and 12 or 13
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.ZIndex = 2
	nameLabel.Parent = container

	local statusLabel = Instance.new("TextLabel")
	statusLabel.Name = "StatusLabel"
	statusLabel.Size = UDim2.new(1, -110, 0, 14)
	statusLabel.Position = UDim2.new(0, 54, 0.5, 2)
	statusLabel.BackgroundTransparency = 1
	statusLabel.Text = "Inactive"
	statusLabel.TextColor3 = Color3.fromRGB(120, 80, 160)
	statusLabel.TextScaled = false
	statusLabel.TextSize = isMobile and 9 or 10
	statusLabel.Font = Enum.Font.Gotham
	statusLabel.TextXAlignment = Enum.TextXAlignment.Left
	statusLabel.ZIndex = 2
	statusLabel.Parent = container

	local toggleTrack = Instance.new("Frame")
	toggleTrack.Size = UDim2.new(0, 44, 0, 24)
	toggleTrack.Position = UDim2.new(1, -56, 0.5, -12)
	toggleTrack.BackgroundColor3 = Color3.fromRGB(40, 15, 70)
	toggleTrack.BorderSizePixel = 0
	toggleTrack.ZIndex = 2
	toggleTrack.Parent = container

	local trackCorner = Instance.new("UICorner")
	trackCorner.CornerRadius = UDim.new(1, 0)
	trackCorner.Parent = toggleTrack

	local trackStroke = Instance.new("UIStroke")
	trackStroke.Color = Color3.fromRGB(100, 30, 160)
	trackStroke.Transparency = 0.3
	trackStroke.Thickness = 1
	trackStroke.Parent = toggleTrack

	local toggleKnob = Instance.new("Frame")
	toggleKnob.Size = UDim2.new(0, 18, 0, 18)
	toggleKnob.Position = UDim2.new(0, 3, 0.5, -9)
	toggleKnob.BackgroundColor3 = Color3.fromRGB(160, 100, 220)
	toggleKnob.BorderSizePixel = 0
	toggleKnob.ZIndex = 3
	toggleKnob.Parent = toggleTrack

	local knobCorner = Instance.new("UICorner")
	knobCorner.CornerRadius = UDim.new(1, 0)
	knobCorner.Parent = toggleKnob

	local clickBtn = Instance.new("TextButton")
	clickBtn.Size = UDim2.new(1, 0, 1, 0)
	clickBtn.BackgroundTransparency = 1
	clickBtn.Text = ""
	clickBtn.ZIndex = 4
	clickBtn.Parent = container

	local isOn = false

	local function animateToggle(state)
		isOn = state
		local knobPos = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
		local trackColor = state and Color3.fromRGB(120, 40, 200) or Color3.fromRGB(40, 15, 70)
		local knobColor = state and Color3.fromRGB(220, 150, 255) or Color3.fromRGB(160, 100, 220)
		local strokeColor = state and Color3.fromRGB(180, 60, 255) or Color3.fromRGB(100, 30, 160)
		local containerStrokeColor = state and Color3.fromRGB(180, 60, 255) or Color3.fromRGB(120, 40, 200)
		local containerStrokeTransp = state and 0.2 or 0.6
		local statusText = state and "Active" or "Inactive"
		local statusColor = state and Color3.fromRGB(200, 130, 255) or Color3.fromRGB(120, 80, 160)
		local iconBg = state and Color3.fromRGB(140, 50, 210) or Color3.fromRGB(100, 30, 170)

		TweenService:Create(toggleKnob, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = knobPos, BackgroundColor3 = knobColor}):Play()
		TweenService:Create(toggleTrack, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = trackColor}):Play()
		TweenService:Create(trackStroke, TweenInfo.new(0.2), {Color = strokeColor}):Play()
		TweenService:Create(containerStroke, TweenInfo.new(0.2), {Color = containerStrokeColor, Transparency = containerStrokeTransp}):Play()
		TweenService:Create(iconLabel, TweenInfo.new(0.2), {BackgroundColor3 = iconBg}):Play()

		statusLabel.Text = statusText
		TweenService:Create(statusLabel, TweenInfo.new(0.2), {TextColor3 = statusColor}):Play()

		local punchTween = TweenService:Create(container, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0})
		punchTween:Play()
		punchTween.Completed:Connect(function()
			TweenService:Create(container, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.2}):Play()
		end)

		if state then
			local ripple = Instance.new("Frame")
			ripple.Size = UDim2.new(0, 0, 0, 0)
			ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
			ripple.BackgroundColor3 = Color3.fromRGB(180, 60, 255)
			ripple.BackgroundTransparency = 0.5
			ripple.BorderSizePixel = 0
			ripple.ZIndex = 5
			ripple.ClipsDescendants = false
			ripple.Parent = container
			local rippleCorner = Instance.new("UICorner")
			rippleCorner.CornerRadius = UDim.new(1, 0)
			rippleCorner.Parent = ripple
			TweenService:Create(ripple, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, 300, 0, 300),
				Position = UDim2.new(0.5, -150, 0.5, -150),
				BackgroundTransparency = 1
			}):Play()
			task.delay(0.5, function() ripple:Destroy() end)
		end

		print("[Nexio] " .. name .. " -> " .. (state and "ON" or "OFF"))
	end

	clickBtn.MouseButton1Click:Connect(function() animateToggle(not isOn) end)
	clickBtn.MouseEnter:Connect(function() TweenService:Create(container, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play() end)
	clickBtn.MouseLeave:Connect(function() TweenService:Create(container, TweenInfo.new(0.15), {BackgroundTransparency = 0.2}):Play() end)
end

createToggleButton("Freeze Trade", "❄", 1)
createToggleButton("Auto Accept", "✓", 2)
createToggleButton("Cancel Trade", "✕", 3)

local footerFrame = Instance.new("Frame")
footerFrame.Size = UDim2.new(1, 0, 0, 50)
footerFrame.BackgroundTransparency = 1
footerFrame.LayoutOrder = 4
footerFrame.Parent = contentFrame

local madeByLabel = Instance.new("TextLabel")
madeByLabel.Size = UDim2.new(1, 0, 0, 16)
madeByLabel.Position = UDim2.new(0, 0, 0, 4)
madeByLabel.BackgroundTransparency = 1
madeByLabel.Text = "Made By Nexio"
madeByLabel.TextColor3 = Color3.fromRGB(160, 100, 220)
madeByLabel.TextScaled = false
madeByLabel.TextSize = isMobile and 10 or 11
madeByLabel.Font = Enum.Font.GothamBold
madeByLabel.TextXAlignment = Enum.TextXAlignment.Center
madeByLabel.Parent = footerFrame

local socLabel = Instance.new("TextLabel")
socLabel.Size = UDim2.new(1, 0, 0, 14)
socLabel.Position = UDim2.new(0, 0, 0, 22)
socLabel.BackgroundTransparency = 1
socLabel.Text = "YT: ZeroScriptsOnTop • TT: nexioontopyt"
socLabel.TextColor3 = Color3.fromRGB(100, 60, 150)
socLabel.TextScaled = false
socLabel.TextSize = isMobile and 9 or 10
socLabel.Font = Enum.Font.Gotham
socLabel.TextXAlignment = Enum.TextXAlignment.Center
socLabel.Parent = footerFrame

local minimized = false
local fullSize = baseSize
local miniSize = UDim2.new(0, fullSize.X.Offset, 0, 58)

minimizeBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		minimizeBtn.Text = "+"
		TweenService:Create(mainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {Size = miniSize}):Play()
	else
		minimizeBtn.Text = "−"
		TweenService:Create(mainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = fullSize}):Play()
	end
end)

local dragging = false
local dragStart = nil
local startPos = nil

local function onDragBegan(input)
	dragging = true
	dragStart = input.Position
	startPos = mainFrame.Position
end

local function onDragChanged(input)
	if dragging then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end

local function onDragEnded()
	dragging = false
end

topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		onDragBegan(input)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		onDragChanged(input)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		onDragEnded()
	end
end)

TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = fullSize}):Play()

local shimmerFrame = Instance.new("Frame")
shimmerFrame.Size = UDim2.new(0, 60, 1, 0)
shimmerFrame.Position = UDim2.new(-0.3, 0, 0, 0)
shimmerFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
shimmerFrame.BackgroundTransparency = 0.92
shimmerFrame.BorderSizePixel = 0
shimmerFrame.ZIndex = 6
shimmerFrame.ClipsDescendants = false
shimmerFrame.Parent = mainFrame

local shimCorner = Instance.new("UICorner")
shimCorner.CornerRadius = UDim.new(0, 18)
shimCorner.Parent = shimmerFrame

local shimGrad = Instance.new("UIGradient")
shimGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,255,255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0))
})
shimGrad.Rotation = 15
shimGrad.Parent = shimmerFrame

local function playShimmer()
	shimmerFrame.Position = UDim2.new(-0.3, 0, 0, 0)
	local t = TweenService:Create(shimmerFrame, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(1.3, 0, 0, 0)})
	t:Play()
	t.Completed:Connect(function() task.delay(4, playShimmer) end)
end

task.delay(1, playShimmer)

RunService.Heartbeat:Connect(function()
	local t = tick()
	local alpha = (math.sin(t * 1.5) + 1) / 2
	mainStroke.Transparency = 0.2 + alpha * 0.4
end)
]],
})

table.insert(SCRIPTS, {
    name  = "Steal a Brainrot",
    icon  = "🧠",
    desc  = "AUTO STEAL • TELEPORT • NOCLIP",
    isNew = false,
    kind  = "embed",
    code  = [[
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local isTeleporting = false
local noclipEnabled = false
local noclipConn = nil

local fastStealOn = false
local fastStealLoop = nil
local fastStealConn = nil

local function getCharacter()
local char = LocalPlayer.Character
if not char or not char.Parent then
char = LocalPlayer.CharacterAdded:Wait()
end
return char
end

local function getMyPlot()
local plots = workspace:FindFirstChild("Plots")
if not plots then return nil end
for _, plot in ipairs(plots:GetChildren()) do
local label = plot:FindFirstChild("PlotSign")
and plot.PlotSign:FindFirstChild("SurfaceGui")
and plot.PlotSign.SurfaceGui:FindFirstChild("Frame")
and plot.PlotSign.SurfaceGui.Frame:FindFirstChild("TextLabel")
if label then
local t = (label.ContentText or label.Text or "")
if t:find(LocalPlayer.DisplayName) and t:find("Base") then
return plot
end
end
end
return nil
end

local function getDeliveryHitbox()
local myPlot = getMyPlot()
if not myPlot then return nil end
local delivery = myPlot:FindFirstChild("DeliveryHitbox") or myPlot:FindFirstChild("DeliveryHitbox", true)
if delivery and delivery:IsA("BasePart") then
return delivery
end
return nil
end

local function setNoclip(on)
noclipEnabled = on
if on then
if noclipConn then noclipConn:Disconnect() end
noclipConn = RunService.Stepped:Connect(function()
local char = LocalPlayer.Character
if not char then return end
for _, part in ipairs(char:GetDescendants()) do
if part:IsA("BasePart") then
part.CanCollide = false
end
end
end)
else
if noclipConn then
noclipConn:Disconnect()
noclipConn = nil
end
local char = LocalPlayer.Character
if char then
for _, part in ipairs(char:GetDescendants()) do
if part:IsA("BasePart") then
part.CanCollide = true
end
end
end
end
end

local function shortTeleportFreezeCamera(targetCF, duration)
if isTeleporting then return end
isTeleporting = true
duration = duration or 0.2
if duration < 0.1 then duration = 0.1 end
if duration > 0.5 then duration = 0.5 end
local character = getCharacter()
local hrp = character:FindFirstChild("HumanoidRootPart")
if not hrp then
isTeleporting = false
return
end
local camera = workspace.CurrentCamera
if not camera then
isTeleporting = false
return
end
local originalCF = hrp.CFrame
local originalCamType = camera.CameraType
local originalCamSub = camera.CameraSubject
local originalCamCFrame = camera.CFrame
local function restoreCamera()
local char = LocalPlayer.Character
local hum = char and char:FindFirstChildOfClass("Humanoid")
if hum then
camera.CameraSubject = hum
camera.CameraType = Enum.CameraType.Custom
else
camera.CameraType = originalCamType or Enum.CameraType.Custom
camera.CameraSubject = originalCamSub
end
camera.CFrame = originalCamCFrame
end
local ok = pcall(function()
camera.CameraType = Enum.CameraType.Scriptable
camera.CFrame = originalCamCFrame
hrp.CFrame = targetCF
task.wait(duration)
hrp.CFrame = originalCF
end)
restoreCamera()
isTeleporting = false
if not ok then
warn("[SAB UTILS] shortTeleport error")
end
end

local function doInstantSteal()
local character = getCharacter()
local hrp = character:FindFirstChild("HumanoidRootPart")
if not hrp then return end
local delivery = getDeliveryHitbox()
if not delivery then return end
local targetCF = delivery.CFrame + delivery.CFrame.LookVector * 3 + Vector3.new(0, 3, 0)
shortTeleportFreezeCamera(targetCF, 0.25)
end

local function doForwardTP()
local character = getCharacter()
local hrp = character:FindFirstChild("HumanoidRootPart")
if not hrp then return end
hrp.CFrame = hrp.CFrame + hrp.CFrame.LookVector * 8
end

local function patchPrompt(prompt)
if not prompt:IsA("ProximityPrompt") then return end
local ok = pcall(function()
if prompt.HoldDuration > 0.01 then
prompt.HoldDuration = 0.01
end
end)
if not ok then
end
end

local function setFastSteal(on)
fastStealOn = on
if on then
task.spawn(function()
for _, obj in ipairs(workspace:GetDescendants()) do
if obj:IsA("ProximityPrompt") then
patchPrompt(obj)
end
end
end)
if not fastStealLoop then
fastStealLoop = task.spawn(function()
while fastStealOn do
local ok, err = pcall(function()
for _, obj in ipairs(workspace:GetDescendants()) do
if obj:IsA("ProximityPrompt") then
patchPrompt(obj)
end
end
end)
if not ok then
warn("[SAB UTILS] FastSteal loop error:", err)
end
task.wait(0.08)
end
fastStealLoop = nil
end)
end
if fastStealConn then fastStealConn:Disconnect() end
fastStealConn = workspace.DescendantAdded:Connect(function(obj)
if fastStealOn and obj:IsA("ProximityPrompt") then
patchPrompt(obj)
end
end)
else
if fastStealConn then
fastStealConn:Disconnect()
fastStealConn = nil
end
end
end

local function createUI()
local guiParent = game:GetService("CoreGui")
pcall(function()
if gethui then
local h = gethui()
if h then guiParent = h end
end
end)
local old = guiParent:FindFirstChild("SAB_Utils_UI")
if old then old:Destroy() end
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SAB_Utils_UI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
screenGui.Parent = guiParent
screenGui.AncestryChanged:Connect(function(_, parent)
if not parent then
setNoclip(false)
setFastSteal(false)
end
end)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 230, 0, 225)
mainFrame.Position = UDim2.new(0.68, -115, 0.55, -112)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 16, 24)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true
mainFrame.Parent = screenGui
local cardCorner = Instance.new("UICorner")
cardCorner.CornerRadius = UDim.new(0, 18)
cardCorner.Parent = mainFrame
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
ColorSequenceKeypoint.new(0.0, Color3.fromRGB(40, 45, 90)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 28, 55)),
ColorSequenceKeypoint.new(1.0, Color3.fromRGB(15, 16, 24))
}
gradient.Rotation = 90
gradient.Parent = mainFrame
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(25, 26, 38)
header.BorderSizePixel = 0
header.Parent = mainFrame
local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 18)
headerCorner.Parent = header
local headerMask = Instance.new("Frame")
headerMask.Size = UDim2.new(1, 0, 0, 14)
headerMask.Position = UDim2.new(0, 0, 1, -14)
headerMask.BackgroundColor3 = header.BackgroundColor3
headerMask.BorderSizePixel = 0
headerMask.Parent = header
local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.Font = Enum.Font.GothamBold
title.Text = "Steal a Brainrot"
title.TextSize = 15
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header
local subtitle = Instance.new("TextLabel")
subtitle.BackgroundTransparency = 1
subtitle.Size = UDim2.new(1, -40, 1, 0)
subtitle.Position = UDim2.new(0, 12, 0, 18)
subtitle.Font = Enum.Font.Gotham
subtitle.Text = "67OnTop"
subtitle.TextSize = 11
subtitle.TextColor3 = Color3.fromRGB(180, 190, 240)
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -30, 0.5, -11)
closeBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 80)
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(235, 235, 245)
closeBtn.Parent = header
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
do
local dragging = false
local dragInput, dragStart, startPos
local function update(input)
local delta = input.Position - dragStart
mainFrame.Position = UDim2.new(
startPos.X.Scale, startPos.X.Offset + delta.X,
startPos.Y.Scale, startPos.Y.Offset + delta.Y
)
end
header.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1
or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
dragStart = input.Position
startPos = mainFrame.Position
dragInput = input
input.Changed:Connect(function(i)
if i.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)
end
end)
header.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement
or input.UserInputType == Enum.UserInputType.Touch then
dragInput = input
end
end)
UserInputService.InputChanged:Connect(function(input)
if dragging and input == dragInput then
update(input)
end
end)
end
local body = Instance.new("Frame")
body.Size = UDim2.new(1, -20, 1, -58)
body.Position = UDim2.new(0, 10, 0, 46)
body.BackgroundTransparency = 1
body.Parent = mainFrame
local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 6)
padding.PaddingBottom = UDim.new(0, 6)
padding.PaddingLeft = UDim.new(0, 0)
padding.PaddingRight = UDim.new(0, 0)
padding.Parent = body
local list = Instance.new("UIListLayout")
list.FillDirection = Enum.FillDirection.Vertical
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Padding = UDim.new(0, 6)
list.Parent = body
local function makeButton(text, color, textColor)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, 0, 0, 34)
btn.BackgroundColor3 = color
btn.AutoButtonColor = true
btn.Font = Enum.Font.GothamBold
btn.Text = text
btn.TextSize = 14
btn.TextColor3 = textColor or Color3.fromRGB(255, 255, 255)
btn.Parent = body
local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(0, 10)
c.Parent = btn
return btn
end
local instantBtn = makeButton("INSTANT STEAL", Color3.fromRGB(90, 155, 255))
local forwardBtn = makeButton("TP FORWARD", Color3.fromRGB(135, 215, 170), Color3.fromRGB(20, 25, 25))
local noclipBtn = makeButton("NOCLIP: OFF", Color3.fromRGB(110, 95, 170), Color3.fromRGB(235, 235, 245))
local fastBtn = makeButton("FAST STEAL: OFF", Color3.fromRGB(140, 130, 150), Color3.fromRGB(240, 240, 245))
local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleButton"
toggleBtn.Size = UDim2.new(0, 34, 0, 34)
toggleBtn.Position = UDim2.new(0.02, 0, 0.5, -17)
toggleBtn.BackgroundColor3 = Color3.fromRGB(35, 36, 50)
toggleBtn.Text = "≡"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 16
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Parent = screenGui
local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(1, 0)
toggleCorner.Parent = toggleBtn
toggleBtn.MouseButton1Click:Connect(function()
mainFrame.Visible = not mainFrame.Visible
toggleBtn.Text = mainFrame.Visible and "≡" or "▶"
end)
local uiScale = Instance.new("UIScale")
uiScale.Scale = 1
uiScale.Parent = mainFrame
local function updateScale()
local cam = workspace.CurrentCamera
if not cam then return end
local vp = cam.ViewportSize
local minSide = math.min(vp.X, vp.Y)
uiScale.Scale = (minSide <= 720) and 0.9 or 1
end
updateScale()
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(updateScale)
instantBtn.MouseButton1Click:Connect(doInstantSteal)
forwardBtn.MouseButton1Click:Connect(doForwardTP)
noclipBtn.MouseButton1Click:Connect(function()
setNoclip(not noclipEnabled)
if noclipEnabled then
noclipBtn.BackgroundColor3 = Color3.fromRGB(210, 135, 255)
noclipBtn.Text = "NOCLIP: ON"
else
noclipBtn.BackgroundColor3 = Color3.fromRGB(110, 95, 170)
noclipBtn.Text = "NOCLIP: OFF"
end
end)
fastBtn.MouseButton1Click:Connect(function()
setFastSteal(not fastStealOn)
if fastStealOn then
fastBtn.BackgroundColor3 = Color3.fromRGB(245, 175, 100)
fastBtn.TextColor3 = Color3.fromRGB(35, 25, 15)
fastBtn.Text = "FAST STEAL: ON"
else
fastBtn.BackgroundColor3 = Color3.fromRGB(140, 130, 150)
fastBtn.TextColor3 = Color3.fromRGB(240, 240, 245)
fastBtn.Text = "FAST STEAL: OFF"
end
end)
end

createUI()
]],
})

table.insert(SCRIPTS, {
    name  = "22S Duels",
    icon  = "⚔️",
    desc  = "AIMBOT • AUTO BAT • COMBAT",
    isNew = true,
    kind  = "embed",
    code  = [[
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Player = Players.LocalPlayer

-- Safe character wait - don't force anything
local function waitForCharacter()
    local char = Player.Character
    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChildOfClass("Humanoid") then
        return char
    end
    return Player.CharacterAdded:Wait()
end

-- Wait for character without forcing reset
task.spawn(function()
    waitForCharacter()
end)

if not getgenv then
    getgenv = function() return _G end
end

local ConfigFileName = "22s_DUELS_Config.json"

local Enabled = {
    SpeedBoost = false,
    AntiRagdoll = false,
    SpinBot = false,
    SpeedWhileStealing = false,
    AutoSteal = false,
    Unwalk = false,
    Optimizer = false,
    Galaxy = false,
    SpamBat = false,
    BatAimbot = false,
    AutoDisableSpeed = true,
    GalaxySkyBright = false,
    AutoWalkEnabled = false,
    AutoRightEnabled = false,
    ScriptUserESP = true
}

local Values = {
    BoostSpeed = 30,
    SpinSpeed = 30,
    StealingSpeedValue = 29,
    STEAL_RADIUS = 20,
    STEAL_DURATION = 1.3,
    DEFAULT_GRAVITY = 196.2,
    GalaxyGravityPercent = 70,
    HOP_POWER = 35,
    HOP_COOLDOWN = 0.08
}

local KEYBINDS = {
    SPEED = Enum.KeyCode.V,
    SPIN = Enum.KeyCode.N,
    GALAXY = Enum.KeyCode.M,
    BATAIMBOT = Enum.KeyCode.X,
    NUKE = Enum.KeyCode.Q,
    AUTOLEFT = Enum.KeyCode.Z,
    AUTORIGHT = Enum.KeyCode.C
}

-- Load Config FIRST before anything else
local configLoaded = false
pcall(function()
    if readfile and isfile and isfile(ConfigFileName) then
        local data = HttpService:JSONDecode(readfile(ConfigFileName))
        if data then
            for k, v in pairs(data) do
                if Enabled[k] ~= nil then
                    Enabled[k] = v
                end
            end
            for k, v in pairs(data) do
                if Values[k] ~= nil then
                    Values[k] = v
                end
            end
            if data.KEY_SPEED then KEYBINDS.SPEED = Enum.KeyCode[data.KEY_SPEED] end
            if data.KEY_SPIN then KEYBINDS.SPIN = Enum.KeyCode[data.KEY_SPIN] end
            if data.KEY_GALAXY then KEYBINDS.GALAXY = Enum.KeyCode[data.KEY_GALAXY] end
            if data.KEY_BATAIMBOT then KEYBINDS.BATAIMBOT = Enum.KeyCode[data.KEY_BATAIMBOT] end
            if data.KEY_AUTOLEFT then KEYBINDS.AUTOLEFT = Enum.KeyCode[data.KEY_AUTOLEFT] end
            if data.KEY_AUTORIGHT then KEYBINDS.AUTORIGHT = Enum.KeyCode[data.KEY_AUTORIGHT] end
            configLoaded = true
        end
    end
end)

-- Save Config
local function SaveConfig()
    local data = {}
    for k, v in pairs(Enabled) do
        data[k] = v
    end
    for k, v in pairs(Values) do
        data[k] = v
    end
    data.KEY_SPEED = KEYBINDS.SPEED.Name
    data.KEY_SPIN = KEYBINDS.SPIN.Name
    data.KEY_GALAXY = KEYBINDS.GALAXY.Name
    data.KEY_BATAIMBOT = KEYBINDS.BATAIMBOT.Name
    data.KEY_AUTOLEFT = KEYBINDS.AUTOLEFT.Name
    data.KEY_AUTORIGHT = KEYBINDS.AUTORIGHT.Name
    
    local success = false
    if writefile then
        pcall(function()
            writefile(ConfigFileName, HttpService:JSONEncode(data))
            success = true
        end)
    end
    return success
end

local Connections = {}
local isStealing = false
local lastBatSwing = 0
local BAT_SWING_COOLDOWN = 0.12

local SlapList = {
    {1, "Bat"}, {2, "Slap"}, {3, "Iron Slap"}, {4, "Gold Slap"},
    {5, "Diamond Slap"}, {6, "Emerald Slap"}, {7, "Ruby Slap"},
    {8, "Dark Matter Slap"}, {9, "Flame Slap"}, {10, "Nuclear Slap"},
    {11, "Galaxy Slap"}, {12, "Glitched Slap"}
}

local ADMIN_KEY = "78a772b6-9e1c-4827-ab8b-04a07838f298"
local REMOTE_EVENT_ID = "352aad58-c786-4998-886b-3e4fa390721e"
local BALLOON_REMOTE = ReplicatedStorage:FindFirstChild(REMOTE_EVENT_ID, true)

local function INSTANT_NUKE(target)
    if not BALLOON_REMOTE or not target then return end
    for _, p in ipairs({"balloon", "ragdoll", "jumpscare", "morph", "tiny", "rocket", "inverse", "jail"}) do
        BALLOON_REMOTE:FireServer(ADMIN_KEY, target, p)
    end
end

local function getNearestPlayer()
    local c = Player.Character
    if not c then return nil end
    local h = c:FindFirstChild("HumanoidRootPart")
    if not h then return nil end
    local pos = h.Position
    local nearest = nil
    local dist = math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Player and p.Character then
            local oh = p.Character:FindFirstChild("HumanoidRootPart")
            if oh then
                local d = (pos - oh.Position).Magnitude
                if d < dist then
                    dist = d
                    nearest = p
                end
            end
        end
    end
    return nearest
end

local function findBat()
    local c = Player.Character
    if not c then return nil end
    local bp = Player:FindFirstChildOfClass("Backpack")
    for _, ch in ipairs(c:GetChildren()) do
        if ch:IsA("Tool") and ch.Name:lower():find("bat") then
            return ch
        end
    end
    if bp then
        for _, ch in ipairs(bp:GetChildren()) do
            if ch:IsA("Tool") and ch.Name:lower():find("bat") then
                return ch
            end
        end
    end
    for _, i in ipairs(SlapList) do
        local t = c:FindFirstChild(i[2]) or (bp and bp:FindFirstChild(i[2]))
        if t then return t end
    end
    return nil
end

local function startSpamBat()
    if Connections.spamBat then return end
    Connections.spamBat = RunService.Heartbeat:Connect(function()
        if not Enabled.SpamBat then return end
        local c = Player.Character
        if not c then return end
        local bat = findBat()
        if not bat then return end
        if bat.Parent ~= c then
            bat.Parent = c
        end
        local now = tick()
        if now - lastBatSwing < BAT_SWING_COOLDOWN then return end
        lastBatSwing = now
        pcall(function() bat:Activate() end)
    end)
end

local function stopSpamBat()
    if Connections.spamBat then
        Connections.spamBat:Disconnect()
        Connections.spamBat = nil
    end
end

local spinBAV = nil

local function startSpinBot()
    local c = Player.Character
    if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if spinBAV then spinBAV:Destroy() spinBAV = nil end
    for _, v in pairs(hrp:GetChildren()) do
        if v.Name == "SpinBAV" then v:Destroy() end
    end
    spinBAV = Instance.new("BodyAngularVelocity")
    spinBAV.Name = "SpinBAV"
    spinBAV.MaxTorque = Vector3.new(0, math.huge, 0)
    spinBAV.AngularVelocity = Vector3.new(0, Values.SpinSpeed, 0)
    spinBAV.Parent = hrp
end

local function stopSpinBot()
    if spinBAV then spinBAV:Destroy() spinBAV = nil end
    local c = Player.Character
    if c then
        local hrp = c:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, v in pairs(hrp:GetChildren()) do
                if v.Name == "SpinBAV" then v:Destroy() end
            end
        end
    end
end

-- ================================================================
-- ================================================================
local AutoWalkEnabled = false
local AutoRightEnabled = false

RunService.Heartbeat:Connect(function()
    if Enabled.SpinBot and spinBAV then
        if Player:GetAttribute("Stealing") then
            spinBAV.AngularVelocity = Vector3.new(0, 0, 0)
        else
            spinBAV.AngularVelocity = Vector3.new(0, Values.SpinSpeed, 0)
        end
    end
end)

-- Bat Aimbot (no radius limit, NO auto swing, purple line, smooth movement)
local aimbotTarget = nil

local function findNearestEnemy(myHRP)
    local nearest = nil
    local nearestDist = math.huge
    local nearestTorso = nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Player and p.Character then
            local eh = p.Character:FindFirstChild("HumanoidRootPart")
            local torso = p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("Torso")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if eh and hum and hum.Health > 0 then
                local d = (eh.Position - myHRP.Position).Magnitude
                if d < nearestDist then
                    nearestDist = d
                    nearest = eh
                    nearestTorso = torso or eh
                end
            end
        end
    end
    return nearest, nearestDist, nearestTorso
end

local function startBatAimbot()
    if Connections.batAimbot then return end
    
    Connections.batAimbot = RunService.Heartbeat:Connect(function(dt)
        if not Enabled.BatAimbot then return end
        local c = Player.Character
        if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart")
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not h or not hum then return end
        
        -- Equip bat if not equipped (no swinging)
        local bat = findBat()
        if bat and bat.Parent ~= c then
            hum:EquipTool(bat)
        end
        
        -- Find target
        local target, dist, torso = findNearestEnemy(h)
        aimbotTarget = torso or target
        
        if target and torso then
            local dir = (torso.Position - h.Position)
            local flatDir = Vector3.new(dir.X, 0, dir.Z)
            local flatDist = flatDir.Magnitude
            local spd = 55 -- Fixed aimbot speed
            
            if flatDist > 1.5 then
                local moveDir = flatDir.Unit
                h.AssemblyLinearVelocity = Vector3.new(moveDir.X * spd, h.AssemblyLinearVelocity.Y, moveDir.Z * spd)
            else
                local tv = target.AssemblyLinearVelocity
                h.AssemblyLinearVelocity = Vector3.new(tv.X, h.AssemblyLinearVelocity.Y, tv.Z)
            end
        end
    end)
end

local function stopBatAimbot()
    if Connections.batAimbot then
        Connections.batAimbot:Disconnect()
        Connections.batAimbot = nil
    end
    aimbotTarget = nil
end



-- Galaxy Mode
local galaxyVectorForce = nil
local galaxyAttachment = nil
local galaxyEnabled = false
local hopsEnabled = false
local lastHopTime = 0
local spaceHeld = false
local originalJumpPower = 50

-- Capture original jump power safely when character is ready
local function captureJumpPower()
    local c = Player.Character
    if c then
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum and hum.JumpPower > 0 then
            originalJumpPower = hum.JumpPower
        end
    end
end

-- Capture on current character
task.spawn(function()
    task.wait(1)
    captureJumpPower()
end)

-- Recapture when character respawns
Player.CharacterAdded:Connect(function(char)
    task.wait(1)
    captureJumpPower()
end)

local function setupGalaxyForce()
    pcall(function()
        local c = Player.Character
        if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart")
        if not h then return end
        if galaxyVectorForce then galaxyVectorForce:Destroy() end
        if galaxyAttachment then galaxyAttachment:Destroy() end
        galaxyAttachment = Instance.new("Attachment")
        galaxyAttachment.Parent = h
        galaxyVectorForce = Instance.new("VectorForce")
        galaxyVectorForce.Attachment0 = galaxyAttachment
        galaxyVectorForce.ApplyAtCenterOfMass = true
        galaxyVectorForce.RelativeTo = Enum.ActuatorRelativeTo.World
        galaxyVectorForce.Force = Vector3.new(0, 0, 0)
        galaxyVectorForce.Parent = h
    end)
end

local function updateGalaxyForce()
    if not galaxyEnabled or not galaxyVectorForce then return end
    local c = Player.Character
    if not c then return end
    local mass = 0
    for _, p in ipairs(c:GetDescendants()) do
        if p:IsA("BasePart") then
            mass = mass + p:GetMass()
        end
    end
    local tg = Values.DEFAULT_GRAVITY * (Values.GalaxyGravityPercent / 100)
    galaxyVectorForce.Force = Vector3.new(0, mass * (Values.DEFAULT_GRAVITY - tg) * 0.95, 0)
end

local function adjustGalaxyJump()
    pcall(function()
        local c = Player.Character
        if not c then return end
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        if not galaxyEnabled then
            hum.JumpPower = originalJumpPower
            return
        end
        local ratio = math.sqrt((Values.DEFAULT_GRAVITY * (Values.GalaxyGravityPercent / 100)) / Values.DEFAULT_GRAVITY)
        hum.JumpPower = originalJumpPower * ratio
    end)
end

local function doMiniHop()
    if not hopsEnabled then return end
    pcall(function()
        local c = Player.Character
        if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart")
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not h or not hum then return end
        if tick() - lastHopTime < Values.HOP_COOLDOWN then return end
        lastHopTime = tick()
        if hum.FloorMaterial == Enum.Material.Air then
            h.AssemblyLinearVelocity = Vector3.new(h.AssemblyLinearVelocity.X, Values.HOP_POWER, h.AssemblyLinearVelocity.Z)
        end
    end)
end

local function startGalaxy()
    galaxyEnabled = true
    hopsEnabled = true
    setupGalaxyForce()
    adjustGalaxyJump()
end

local function stopGalaxy()
    galaxyEnabled = false
    hopsEnabled = false
    if galaxyVectorForce then
        galaxyVectorForce:Destroy()
        galaxyVectorForce = nil
    end
    if galaxyAttachment then
        galaxyAttachment:Destroy()
        galaxyAttachment = nil
    end
    adjustGalaxyJump()
end

RunService.Heartbeat:Connect(function()
    if hopsEnabled and spaceHeld then
        doMiniHop()
    end
    if galaxyEnabled then
        updateGalaxyForce()
    end
end)

local function getMovementDirection()
    local c = Player.Character
    if not c then return Vector3.zero end
    local hum = c:FindFirstChildOfClass("Humanoid")
    return hum and hum.MoveDirection or Vector3.zero
end

local function isOnEnemyPlot()
    local character = Player.Character
    if not character then return false end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    local playerPos = hrp.Position
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return false end
    
    for _, plot in ipairs(plots:GetChildren()) do
        local isMyPlot = false
        local sign = plot:FindFirstChild("PlotSign")
        if sign then
            local yourBase = sign:FindFirstChild("YourBase")
            if yourBase and yourBase:IsA("BillboardGui") then 
                isMyPlot = yourBase.Enabled == true 
            end
        end
        
        if not isMyPlot then
            local plotPart = plot:FindFirstChild("Plot") or plot:FindFirstChildWhichIsA("BasePart")
            if plotPart and plotPart:IsA("BasePart") then
                local plotPos, plotSize = plotPart.Position, plotPart.Size
                if math.abs(playerPos.X - plotPos.X) <= plotSize.X/2 + 5 and 
                   math.abs(playerPos.Z - plotPos.Z) <= plotSize.Z/2 + 5 then 
                    return true 
                end
            end
            
            local podiums = plot:FindFirstChild("AnimalPodiums")
            if podiums then
                for _, podium in ipairs(podiums:GetChildren()) do
                    local base = podium:FindFirstChild("Base")
                    if base then
                        local spawn = base:FindFirstChild("Spawn")
                        if spawn and (spawn.Position - playerPos).Magnitude <= 25 then 
                            return true 
                        end
                    end
                end
            end
        end
    end
    return false
end

-- Auto walk/right destination coordinates (forward declared for speed boost check)
local POSITION_2 = Vector3.new(-483.12, -4.95, 94.80)
local POSITION_R2 = Vector3.new(-483.04, -5.09, 23.14)
local autoWalkPhase = 1
local autoRightPhase = 1

local function startSpeedBoost()
    if Connections.speed then return end
    Connections.speed = RunService.Heartbeat:Connect(function()
        if not Enabled.SpeedBoost then return end
        pcall(function()
            local c = Player.Character
            if not c then return end
            local h = c:FindFirstChild("HumanoidRootPart")
            if not h then return end
            local md = getMovementDirection()
            if md.Magnitude > 0.1 then
                h.AssemblyLinearVelocity = Vector3.new(md.X * Values.BoostSpeed, h.AssemblyLinearVelocity.Y, md.Z * Values.BoostSpeed)
            end
        end)
    end)
end

local function stopSpeedBoost()
    if Connections.speed then
        Connections.speed:Disconnect()
        Connections.speed = nil
    end
end

-- ============================================
-- AUTO LEFT / AUTO RIGHT COORDINATE ESP
-- Small precise markers at exact positions
-- ============================================
local coordESPFolder = Instance.new("Folder", workspace)
coordESPFolder.Name = "22s_CoordESP"

local function createCoordMarker(position, labelText, color)
    -- Small dot at exact position
    local dot = Instance.new("Part", coordESPFolder)
    dot.Name = "CoordMarker_" .. labelText
    dot.Anchored = true
    dot.CanCollide = false
    dot.CastShadow = false
    dot.Material = Enum.Material.Neon
    dot.Color = color
    dot.Shape = Enum.PartType.Ball
    dot.Size = Vector3.new(1, 1, 1)
    dot.Position = position
    dot.Transparency = 0.2

    -- Small billboard label
    local bb = Instance.new("BillboardGui", dot)
    bb.AlwaysOnTop = true
    bb.Size = UDim2.new(0, 100, 0, 20)
    bb.StudsOffset = Vector3.new(0, 2, 0)
    bb.MaxDistance = 300

    local text = Instance.new("TextLabel", bb)
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = labelText
    text.TextColor3 = color
    text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    text.TextStrokeTransparency = 0
    text.Font = Enum.Font.GothamBold
    text.TextSize = 12
    text.TextScaled = false

    return dot
end

-- Create markers at exact coordinates
createCoordMarker(Vector3.new(-476.48, -6.28, 92.73), "L1", Color3.fromRGB(100, 150, 255))
createCoordMarker(Vector3.new(-483.12, -4.95, 94.80), "L END", Color3.fromRGB(60, 130, 255))
createCoordMarker(Vector3.new(-476.16, -6.52, 25.62), "R1", Color3.fromRGB(100, 220, 180))
createCoordMarker(Vector3.new(-483.04, -5.09, 23.14), "R END", Color3.fromRGB(50, 200, 150))

-- Auto Walk
local autoWalkConnection = nil
local POSITION_1 = Vector3.new(-476.48, -6.28, 92.73)

local autoRightConnection = nil
local POSITION_R1 = Vector3.new(-476.16, -6.52, 25.62)

local function faceSouth()
    local c = Player.Character
    if not c then return end
    local h = c:FindFirstChild("HumanoidRootPart")
    if not h then return end
    h.CFrame = CFrame.new(h.Position) * CFrame.Angles(0, 0, 0)
    local camera = workspace.CurrentCamera
    if camera then
        local camDistance = 12
        local camHeight = 5
        local charPos = h.Position
        camera.CFrame = CFrame.new(charPos.X, charPos.Y + camHeight, charPos.Z - camDistance) * CFrame.Angles(math.rad(-15), 0, 0)
    end
end

local function faceNorth()
    local c = Player.Character
    if not c then return end
    local h = c:FindFirstChild("HumanoidRootPart")
    if not h then return end
    h.CFrame = CFrame.new(h.Position) * CFrame.Angles(0, math.rad(180), 0)
    local camera = workspace.CurrentCamera
    if camera then
        local camDistance = 12
        local charPos = h.Position
        camera.CFrame = CFrame.new(charPos.X, charPos.Y + 2, charPos.Z + camDistance) * CFrame.Angles(0, math.rad(180), 0)
    end
end

local function startAutoWalk()
    if autoWalkConnection then autoWalkConnection:Disconnect() end
    autoWalkPhase = 1
    
    autoWalkConnection = RunService.Heartbeat:Connect(function()
        if not AutoWalkEnabled then return end
        local c = Player.Character
        if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart")
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not h or not hum then return end
        
        if autoWalkPhase == 1 then
            local targetPos = Vector3.new(POSITION_1.X, h.Position.Y, POSITION_1.Z)
            local dist = (targetPos - h.Position).Magnitude
            if dist < 1 then
                autoWalkPhase = 2
                -- Immediately start moving to coord 2 this same frame
                local dir = (POSITION_2 - h.Position)
                local moveDir = Vector3.new(dir.X, 0, dir.Z).Unit
                hum:Move(moveDir, false)
                h.AssemblyLinearVelocity = Vector3.new(moveDir.X * Values.BoostSpeed, h.AssemblyLinearVelocity.Y, moveDir.Z * Values.BoostSpeed)
                return
            end
            local dir = (POSITION_1 - h.Position)
            local moveDir = Vector3.new(dir.X, 0, dir.Z).Unit
            hum:Move(moveDir, false)
            h.AssemblyLinearVelocity = Vector3.new(moveDir.X * Values.BoostSpeed, h.AssemblyLinearVelocity.Y, moveDir.Z * Values.BoostSpeed)
            
        elseif autoWalkPhase == 2 then
            local targetPos = Vector3.new(POSITION_2.X, h.Position.Y, POSITION_2.Z)
            local dist = (targetPos - h.Position).Magnitude
            if dist < 1 then
                hum:Move(Vector3.zero, false)
                h.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                AutoWalkEnabled = false
                Enabled.AutoWalkEnabled = false

                if _G.setAutoLeftVisual then _G.setAutoLeftVisual(false) end
                if VisualSetters and VisualSetters.AutoWalkEnabled then VisualSetters.AutoWalkEnabled(false, true) end
                if autoWalkConnection then autoWalkConnection:Disconnect() autoWalkConnection = nil end
                faceSouth()
                return
            end
            local dir = (POSITION_2 - h.Position)
            local moveDir = Vector3.new(dir.X, 0, dir.Z).Unit
            hum:Move(moveDir, false)
            h.AssemblyLinearVelocity = Vector3.new(moveDir.X * Values.BoostSpeed, h.AssemblyLinearVelocity.Y, moveDir.Z * Values.BoostSpeed)
        end
    end)
end

local function stopAutoWalk()
    if autoWalkConnection then autoWalkConnection:Disconnect() autoWalkConnection = nil end
    autoWalkPhase = 1
    local c = Player.Character
    if c then
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum then hum:Move(Vector3.zero, false) end
    end
end

local function startAutoRight()
    if autoRightConnection then autoRightConnection:Disconnect() end
    autoRightPhase = 1
    
    autoRightConnection = RunService.Heartbeat:Connect(function()
        if not AutoRightEnabled then return end
        local c = Player.Character
        if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart")
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not h or not hum then return end
        
        if autoRightPhase == 1 then
            local targetPos = Vector3.new(POSITION_R1.X, h.Position.Y, POSITION_R1.Z)
            local dist = (targetPos - h.Position).Magnitude
            if dist < 1 then
                autoRightPhase = 2
                local dir = (POSITION_R2 - h.Position)
                local moveDir = Vector3.new(dir.X, 0, dir.Z).Unit
                hum:Move(moveDir, false)
                h.AssemblyLinearVelocity = Vector3.new(moveDir.X * Values.BoostSpeed, h.AssemblyLinearVelocity.Y, moveDir.Z * Values.BoostSpeed)
                return
            end
            local dir = (POSITION_R1 - h.Position)
            local moveDir = Vector3.new(dir.X, 0, dir.Z).Unit
            hum:Move(moveDir, false)
            h.AssemblyLinearVelocity = Vector3.new(moveDir.X * Values.BoostSpeed, h.AssemblyLinearVelocity.Y, moveDir.Z * Values.BoostSpeed)
            
        elseif autoRightPhase == 2 then
            local targetPos = Vector3.new(POSITION_R2.X, h.Position.Y, POSITION_R2.Z)
            local dist = (targetPos - h.Position).Magnitude
            if dist < 1 then
                hum:Move(Vector3.zero, false)
                h.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                AutoRightEnabled = false
                Enabled.AutoRightEnabled = false

                if _G.setAutoRightVisual then _G.setAutoRightVisual(false) end
                if VisualSetters and VisualSetters.AutoRightEnabled then VisualSetters.AutoRightEnabled(false, true) end
                if autoRightConnection then autoRightConnection:Disconnect() autoRightConnection = nil end
                faceNorth()
                return
            end
            local dir = (POSITION_R2 - h.Position)
            local moveDir = Vector3.new(dir.X, 0, dir.Z).Unit
            hum:Move(moveDir, false)
            h.AssemblyLinearVelocity = Vector3.new(moveDir.X * Values.BoostSpeed, h.AssemblyLinearVelocity.Y, moveDir.Z * Values.BoostSpeed)
        end
    end)
end

local function stopAutoRight()
    if autoRightConnection then autoRightConnection:Disconnect() autoRightConnection = nil end
    autoRightPhase = 1
    local c = Player.Character
    if c then
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum then hum:Move(Vector3.zero, false) end
    end
end

local function startAntiRagdoll()
    if Connections.antiRagdoll then return end
    Connections.antiRagdoll = RunService.Heartbeat:Connect(function()
        if not Enabled.AntiRagdoll then return end
        local char = Player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            local humState = hum:GetState()
            if humState == Enum.HumanoidStateType.Physics or humState == Enum.HumanoidStateType.Ragdoll or humState == Enum.HumanoidStateType.FallingDown then
                hum:ChangeState(Enum.HumanoidStateType.Running)
                workspace.CurrentCamera.CameraSubject = hum
                pcall(function()
                    if Player.Character then
                        local PlayerModule = Player.PlayerScripts:FindFirstChild("PlayerModule")
                        if PlayerModule then
                            local Controls = require(PlayerModule:FindFirstChild("ControlModule"))
                            Controls:Enable()
                        end
                    end
                end)
                if root then
                    root.Velocity = Vector3.new(0, 0, 0)
                    root.RotVelocity = Vector3.new(0, 0, 0)
                end
            end
        end
        for _, obj in ipairs(char:GetDescendants()) do
            if obj:IsA("Motor6D") and obj.Enabled == false then obj.Enabled = true end
        end
    end)
end

local function stopAntiRagdoll()
    if Connections.antiRagdoll then
        Connections.antiRagdoll:Disconnect()
        Connections.antiRagdoll = nil
    end
end

local function startSpeedWhileStealing()
    if Connections.speedWhileStealing then return end
    Connections.speedWhileStealing = RunService.Heartbeat:Connect(function()
        if not Enabled.SpeedWhileStealing or not Player:GetAttribute("Stealing") then return end
        local c = Player.Character
        if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart")
        if not h then return end
        local md = getMovementDirection()
        if md.Magnitude > 0.1 then
            h.AssemblyLinearVelocity = Vector3.new(md.X * Values.StealingSpeedValue, h.AssemblyLinearVelocity.Y, md.Z * Values.StealingSpeedValue)
        end
    end)
end

local function stopSpeedWhileStealing()
    if Connections.speedWhileStealing then
        Connections.speedWhileStealing:Disconnect()
        Connections.speedWhileStealing = nil
    end
end

-- Auto Steal
local ProgressBarFill, ProgressLabel, ProgressPercentLabel, RadiusInput
local stealStartTime = nil
local progressConnection = nil
local StealData = {}

-- Discord text for progress bar
local DISCORD_TEXT = "discord.gg/22s"

local function getDiscordProgress(percent)
    local totalChars = #DISCORD_TEXT
    -- Speed up the text reveal - complete by 70% progress so it's visible longer
    local adjustedPercent = math.min(percent * 1.5, 100)
    local charsToShow = math.floor((adjustedPercent / 100) * totalChars)
    return string.sub(DISCORD_TEXT, 1, charsToShow)
end

local function isMyPlotByName(pn)
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return false end
    local plot = plots:FindFirstChild(pn)
    if not plot then return false end
    local sign = plot:FindFirstChild("PlotSign")
    if sign then
        local yb = sign:FindFirstChild("YourBase")
        if yb and yb:IsA("BillboardGui") then
            return yb.Enabled == true
        end
    end
    return false
end

local function findNearestPrompt()
    local h = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if not h then return nil end
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil end
    local np, nd, nn = nil, math.huge, nil
    for _, plot in ipairs(plots:GetChildren()) do
        if isMyPlotByName(plot.Name) then continue end
        local podiums = plot:FindFirstChild("AnimalPodiums")
        if not podiums then continue end
        for _, pod in ipairs(podiums:GetChildren()) do
            pcall(function()
                local base = pod:FindFirstChild("Base")
                local spawn = base and base:FindFirstChild("Spawn")
                if spawn then
                    local dist = (spawn.Position - h.Position).Magnitude
                    if dist < nd and dist <= Values.STEAL_RADIUS then
                        local att = spawn:FindFirstChild("PromptAttachment")
                        if att then
                            for _, ch in ipairs(att:GetChildren()) do
                                if ch:IsA("ProximityPrompt") then
                                    np, nd, nn = ch, dist, pod.Name
                                    break
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
    return np, nd, nn
end

local function ResetProgressBar()
    if ProgressLabel then ProgressLabel.Text = "READY" end
    if ProgressPercentLabel then ProgressPercentLabel.Text = "" end
    if ProgressBarFill then ProgressBarFill.Size = UDim2.new(0, 0, 1, 0) end
end

local function executeSteal(prompt, name)
    if isStealing then return end
    if not StealData[prompt] then
        StealData[prompt] = {hold = {}, trigger = {}, ready = true}
        pcall(function()
            if getconnections then
                for _, c in ipairs(getconnections(prompt.PromptButtonHoldBegan)) do
                    if c.Function then table.insert(StealData[prompt].hold, c.Function) end
                end
                for _, c in ipairs(getconnections(prompt.Triggered)) do
                    if c.Function then table.insert(StealData[prompt].trigger, c.Function) end
                end
            end
        end)
    end
    local data = StealData[prompt]
    if not data.ready then return end
    data.ready = false
    isStealing = true
    stealStartTime = tick()
    if ProgressLabel then ProgressLabel.Text = name or "STEALING..." end
    if progressConnection then progressConnection:Disconnect() end
    progressConnection = RunService.Heartbeat:Connect(function()
        if not isStealing then progressConnection:Disconnect() return end
        local prog = math.clamp((tick() - stealStartTime) / Values.STEAL_DURATION, 0, 1)
        if ProgressBarFill then ProgressBarFill.Size = UDim2.new(prog, 0, 1, 0) end
        if ProgressPercentLabel then 
            local percent = math.floor(prog * 100)
            ProgressPercentLabel.Text = getDiscordProgress(percent)
        end
    end)
    task.spawn(function()
        for _, f in ipairs(data.hold) do task.spawn(f) end
        task.wait(Values.STEAL_DURATION)
        for _, f in ipairs(data.trigger) do task.spawn(f) end
        if progressConnection then progressConnection:Disconnect() end
        ResetProgressBar()
        data.ready = true
        isStealing = false
    end)
end

local function startAutoSteal()
    if Connections.autoSteal then return end
    Connections.autoSteal = RunService.Heartbeat:Connect(function()
        if not Enabled.AutoSteal or isStealing then return end
        local p, _, n = findNearestPrompt()
        if p then executeSteal(p, n) end
    end)
end

local function stopAutoSteal()
    if Connections.autoSteal then
        Connections.autoSteal:Disconnect()
        Connections.autoSteal = nil
    end
    isStealing = false
    ResetProgressBar()
end

-- Unwalk
local savedAnimations = {}

local function startUnwalk()
    local c = Player.Character
    if not c then return end
    local hum = c:FindFirstChildOfClass("Humanoid")
    if hum then
        for _, t in ipairs(hum:GetPlayingAnimationTracks()) do
            t:Stop()
        end
    end
    local anim = c:FindFirstChild("Animate")
    if anim then
        savedAnimations.Animate = anim:Clone()
        anim:Destroy()
    end
end

local function stopUnwalk()
    local c = Player.Character
    if c and savedAnimations.Animate then
        savedAnimations.Animate:Clone().Parent = c
        savedAnimations.Animate = nil
    end
end

-- Optimizer
local originalTransparency = {}
local xrayEnabled = false

local function enableOptimizer()
    if getgenv and getgenv().OPTIMIZER_ACTIVE then return end
    if getgenv then getgenv().OPTIMIZER_ACTIVE = true end
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        Lighting.GlobalShadows = false
        Lighting.Brightness = 3
        Lighting.FogEnd = 9e9
    end)
    pcall(function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            pcall(function()
                if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
                    obj:Destroy()
                elseif obj:IsA("BasePart") then
                    obj.CastShadow = false
                    obj.Material = Enum.Material.Plastic
                end
            end)
        end
    end)
    xrayEnabled = true
    pcall(function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Anchored and (obj.Name:lower():find("base") or (obj.Parent and obj.Parent.Name:lower():find("base"))) then
                originalTransparency[obj] = obj.LocalTransparencyModifier
                obj.LocalTransparencyModifier = 0.85
            end
        end
    end)
end

local function disableOptimizer()
    if getgenv then getgenv().OPTIMIZER_ACTIVE = false end
    if xrayEnabled then
        for part, value in pairs(originalTransparency) do
            if part then part.LocalTransparencyModifier = value end
        end
        originalTransparency = {}
        xrayEnabled = false
    end
end

-- Galaxy Sky Bright
local originalSkybox = nil
local galaxySkyBright = nil
local galaxySkyBrightConn = nil
local galaxyPlanets = {}
local galaxyBloom = nil
local galaxyCC = nil

local function enableGalaxySkyBright()
    if galaxySkyBright then return end
    
    originalSkybox = Lighting:FindFirstChildOfClass("Sky")
    if originalSkybox then originalSkybox.Parent = nil end
    
    galaxySkyBright = Instance.new("Sky")
    galaxySkyBright.SkyboxBk = "rbxassetid://1534951537"
    galaxySkyBright.SkyboxDn = "rbxassetid://1534951537"
    galaxySkyBright.SkyboxFt = "rbxassetid://1534951537"
    galaxySkyBright.SkyboxLf = "rbxassetid://1534951537"
    galaxySkyBright.SkyboxRt = "rbxassetid://1534951537"
    galaxySkyBright.SkyboxUp = "rbxassetid://1534951537"
    galaxySkyBright.StarCount = 10000
    galaxySkyBright.CelestialBodiesShown = false
    galaxySkyBright.Parent = Lighting
    
    galaxyBloom = Instance.new("BloomEffect")
    galaxyBloom.Intensity = 1.5
    galaxyBloom.Size = 40
    galaxyBloom.Threshold = 0.8
    galaxyBloom.Parent = Lighting
    
    galaxyCC = Instance.new("ColorCorrectionEffect")
    galaxyCC.Saturation = 0.8
    galaxyCC.Contrast = 0.3
    galaxyCC.TintColor = Color3.fromRGB(200, 150, 255)
    galaxyCC.Parent = Lighting
    
    Lighting.Ambient = Color3.fromRGB(120, 60, 180)
    Lighting.Brightness = 3
    Lighting.ClockTime = 0
    
    for i = 1, 2 do
        local p = Instance.new("Part")
        p.Shape = Enum.PartType.Ball
        p.Size = Vector3.new(800 + i * 200, 800 + i * 200, 800 + i * 200)
        p.Anchored = true
        p.CanCollide = false
        p.CastShadow = false
        p.Material = Enum.Material.Neon
        p.Color = Color3.fromRGB(140 + i * 20, 60 + i * 10, 200 + i * 15)
        p.Transparency = 0.3
        p.Position = Vector3.new(math.cos(i * 2) * (3000 + i * 500), 1500 + i * 300, math.sin(i * 2) * (3000 + i * 500))
        p.Parent = workspace
        table.insert(galaxyPlanets, p)
    end
    
    galaxySkyBrightConn = RunService.Heartbeat:Connect(function()
        if not Enabled.GalaxySkyBright then return end
        local t = tick() * 0.5
        Lighting.Ambient = Color3.fromRGB(120 + math.sin(t) * 60, 50 + math.sin(t * 0.8) * 40, 180 + math.sin(t * 1.2) * 50)
        if galaxyBloom then
            galaxyBloom.Intensity = 1.2 + math.sin(t * 2) * 0.4
        end
    end)
end

local function disableGalaxySkyBright()
    if galaxySkyBrightConn then galaxySkyBrightConn:Disconnect() galaxySkyBrightConn = nil end
    if galaxySkyBright then galaxySkyBright:Destroy() galaxySkyBright = nil end
    if originalSkybox then originalSkybox.Parent = Lighting end
    if galaxyBloom then galaxyBloom:Destroy() galaxyBloom = nil end
    if galaxyCC then galaxyCC:Destroy() galaxyCC = nil end
    for _, obj in ipairs(galaxyPlanets) do
        if obj then obj:Destroy() end
    end
    galaxyPlanets = {}
    Lighting.Ambient = Color3.fromRGB(127, 127, 127)
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
end

-- ============================================
-- GUI - CLEAN NO BOXES - MORE BLACK
-- ============================================
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local guiScale = isMobile and 0.4 or 1

local C = {
    bg = Color3.fromRGB(2, 2, 4),
    purple = Color3.fromRGB(60, 130, 255),
    purpleLight = Color3.fromRGB(100, 170, 255),
    purpleDark = Color3.fromRGB(30, 80, 200),
    purpleGlow = Color3.fromRGB(80, 150, 255),
    accent = Color3.fromRGB(60, 130, 255),
    text = Color3.fromRGB(255, 255, 255),
    textDim = Color3.fromRGB(100, 170, 255),
    success = Color3.fromRGB(34, 197, 94),
    danger = Color3.fromRGB(239, 68, 68),
    border = Color3.fromRGB(30, 60, 120)
}

local sg = Instance.new("ScreenGui")
sg.Name = "22S_BLUE"
sg.ResetOnSpawn = false
sg.Parent = Player.PlayerGui

local function playSound(id, vol, spd)
    pcall(function()
        local s = Instance.new("Sound", SoundService)
        s.SoundId = id
        s.Volume = vol or 0.3
        s.PlaybackSpeed = spd or 1
        s:Play()
        game:GetService("Debris"):AddItem(s, 1)
    end)
end

-- Progress Bar
local progressBar = Instance.new("Frame", sg)
progressBar.Size = UDim2.new(0, 420 * guiScale, 0, 56 * guiScale)
progressBar.Position = UDim2.new(0.5, -210 * guiScale, 1, -168 * guiScale)
progressBar.BackgroundColor3 = Color3.fromRGB(2, 2, 4)
progressBar.BorderSizePixel = 0
progressBar.ClipsDescendants = true
Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 14 * guiScale)

local pStroke = Instance.new("UIStroke", progressBar)
pStroke.Thickness = 2
local pGrad = Instance.new("UIGradient", pStroke)
pGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 170, 255)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(60, 130, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})

task.spawn(function()
    local r = 0
    while progressBar.Parent do
        r = (r + 3) % 360
        pGrad.Rotation = r
        task.wait(0.02)
    end
end)

for i = 1, 12 do
    local ball = Instance.new("Frame", progressBar)
    ball.Size = UDim2.new(0, math.random(2, 3), 0, math.random(2, 3))
    ball.Position = UDim2.new(math.random(3, 97) / 100, 0, math.random(15, 85) / 100, 0)
    ball.BackgroundColor3 = Color3.fromRGB(100, 170, 255)
    ball.BackgroundTransparency = math.random(20, 50) / 100
    ball.BorderSizePixel = 0
    ball.ZIndex = 1
    Instance.new("UICorner", ball).CornerRadius = UDim.new(1, 0)
    
    task.spawn(function()
        local startX = ball.Position.X.Scale
        local startY = ball.Position.Y.Scale
        local phase = math.random() * math.pi * 2
        while ball.Parent do
            local t = tick() + phase
            local newX = startX + math.sin(t * (0.5 + i * 0.1)) * 0.03
            local newY = startY + math.cos(t * (0.4 + i * 0.08)) * 0.05
            ball.Position = UDim2.new(math.clamp(newX, 0.02, 0.98), 0, math.clamp(newY, 0.1, 0.9), 0)
            ball.BackgroundTransparency = 0.3 + math.sin(t * 2) * 0.2
            task.wait(0.03)
        end
    end)
end

ProgressLabel = Instance.new("TextLabel", progressBar)
ProgressLabel.Size = UDim2.new(0.35, 0, 0.5, 0)
ProgressLabel.Position = UDim2.new(0, 10 * guiScale, 0, 0)
ProgressLabel.BackgroundTransparency = 1
ProgressLabel.Text = "READY"
ProgressLabel.TextColor3 = C.text
ProgressLabel.Font = Enum.Font.GothamBold
ProgressLabel.TextSize = 14 * guiScale
ProgressLabel.TextXAlignment = Enum.TextXAlignment.Left
ProgressLabel.ZIndex = 3

ProgressPercentLabel = Instance.new("TextLabel", progressBar)
ProgressPercentLabel.Size = UDim2.new(1, 0, 0.5, 0)
ProgressPercentLabel.BackgroundTransparency = 1
ProgressPercentLabel.Text = ""
ProgressPercentLabel.TextColor3 = C.purpleLight
ProgressPercentLabel.Font = Enum.Font.GothamBlack
ProgressPercentLabel.TextSize = 18 * guiScale
ProgressPercentLabel.TextXAlignment = Enum.TextXAlignment.Center
ProgressPercentLabel.ZIndex = 3

RadiusInput = Instance.new("TextBox", progressBar)
RadiusInput.Size = UDim2.new(0, 40 * guiScale, 0, 22 * guiScale)
RadiusInput.Position = UDim2.new(1, -50 * guiScale, 0, 2 * guiScale)
RadiusInput.BackgroundColor3 = Color3.fromRGB(5, 5, 8)
RadiusInput.Text = tostring(Values.STEAL_RADIUS)
RadiusInput.TextColor3 = C.purpleLight
RadiusInput.Font = Enum.Font.GothamBold
RadiusInput.TextSize = 12 * guiScale
RadiusInput.ZIndex = 3
Instance.new("UICorner", RadiusInput).CornerRadius = UDim.new(0, 6 * guiScale)

RadiusInput.FocusLost:Connect(function()
    local n = tonumber(RadiusInput.Text)
    if n then
        Values.STEAL_RADIUS = math.clamp(math.floor(n), 5, 100)
        RadiusInput.Text = tostring(Values.STEAL_RADIUS)
    end
end)

local pTrack = Instance.new("Frame", progressBar)
pTrack.Size = UDim2.new(0.94, 0, 0, 8 * guiScale)
pTrack.Position = UDim2.new(0.03, 0, 1, -15 * guiScale)
pTrack.BackgroundColor3 = Color3.fromRGB(5, 5, 8)
pTrack.ZIndex = 2
Instance.new("UICorner", pTrack).CornerRadius = UDim.new(1, 0)

ProgressBarFill = Instance.new("Frame", pTrack)
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
ProgressBarFill.BackgroundColor3 = C.purple
ProgressBarFill.ZIndex = 2
Instance.new("UICorner", ProgressBarFill).CornerRadius = UDim.new(1, 0)

-- Main Window
local main = Instance.new("Frame", sg)
main.Name = "Main"
main.Size = UDim2.new(0, 560 * guiScale, 0, 740 * guiScale)
main.Position = isMobile and UDim2.new(0.5, -280 * guiScale, 0.5, -370 * guiScale) or UDim2.new(1, -580, 0, 20)
main.BackgroundColor3 = Color3.fromRGB(2, 2, 4)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.ClipsDescendants = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 18 * guiScale)

local mainStroke = Instance.new("UIStroke", main)
mainStroke.Thickness = 2
local strokeGrad = Instance.new("UIGradient", mainStroke)
strokeGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 170, 255)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(60, 130, 255)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 170, 255))
})

task.spawn(function()
    local r = 0
    while main.Parent do
        r = (r + 3) % 360
        strokeGrad.Rotation = r
        task.wait(0.02)
    end
end)

for i = 1, 60 do
    local ball = Instance.new("Frame", main)
    ball.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
    ball.Position = UDim2.new(math.random(2, 98) / 100, 0, math.random(2, 98) / 100, 0)
    ball.BackgroundColor3 = Color3.fromRGB(100, 170, 255)
    ball.BackgroundTransparency = math.random(10, 40) / 100
    ball.BorderSizePixel = 0
    ball.ZIndex = 2
    Instance.new("UICorner", ball).CornerRadius = UDim.new(1, 0)
    
    task.spawn(function()
        local startX = ball.Position.X.Scale
        local startY = ball.Position.Y.Scale
        local phase = math.random() * math.pi * 2
        local speedMult = 0.3 + math.random() * 0.4
        while ball.Parent do
            local t = tick() + phase
            local newX = startX + math.sin(t * speedMult) * 0.02
            local newY = startY + math.cos(t * speedMult * 0.8) * 0.015
            ball.Position = UDim2.new(math.clamp(newX, 0.01, 0.99), 0, math.clamp(newY, 0.01, 0.99), 0)
            ball.BackgroundTransparency = 0.2 + math.sin(t * 1.5 + phase) * 0.25
            task.wait(0.03)
        end
    end)
end

-- Header
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 70 * guiScale)
header.BackgroundTransparency = 1
header.BorderSizePixel = 0
header.ZIndex = 0

local titleLabel = Instance.new("TextLabel", header)
titleLabel.Size = UDim2.new(1, 0, 0, 32 * guiScale)
titleLabel.Position = UDim2.new(0, 0, 0, 10 * guiScale)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "22S DUELS"
titleLabel.TextColor3 = C.text
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 28 * guiScale
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.ZIndex = 5

local subtitleLabel = Instance.new("TextLabel", header)
subtitleLabel.Size = UDim2.new(1, 0, 0, 24 * guiScale)
subtitleLabel.Position = UDim2.new(0, 0, 0, 40 * guiScale)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "discord.gg/22s"
subtitleLabel.TextColor3 = C.purpleLight
subtitleLabel.Font = Enum.Font.GothamBold
subtitleLabel.TextSize = 16 * guiScale
subtitleLabel.TextXAlignment = Enum.TextXAlignment.Center
subtitleLabel.ZIndex = 5

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 36 * guiScale, 0, 36 * guiScale)
closeBtn.Position = UDim2.new(1, -46 * guiScale, 0.5, -18 * guiScale)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "×"
closeBtn.TextColor3 = C.textDim
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 24 * guiScale
closeBtn.ZIndex = 5

closeBtn.MouseButton1Click:Connect(function() sg:Destroy() end)
closeBtn.MouseEnter:Connect(function() closeBtn.TextColor3 = C.danger end)
closeBtn.MouseLeave:Connect(function() closeBtn.TextColor3 = C.textDim end)

local leftSide = Instance.new("Frame", main)
leftSide.Size = UDim2.new(0.48, 0, 0, 650 * guiScale)
leftSide.Position = UDim2.new(0.01, 0, 0, 75 * guiScale)
leftSide.BackgroundTransparency = 1
leftSide.BorderSizePixel = 0
leftSide.ClipsDescendants = true
leftSide.ZIndex = 2

local rightSide = Instance.new("Frame", main)
rightSide.Size = UDim2.new(0.48, 0, 0, 650 * guiScale)
rightSide.Position = UDim2.new(0.51, 0, 0, 75 * guiScale)
rightSide.BackgroundTransparency = 1
rightSide.BorderSizePixel = 0
rightSide.ClipsDescendants = true
rightSide.ZIndex = 2

VisualSetters = {}
local SliderSetters = {}
local KeyButtons = {}
local waitingForKeybind = nil

-- CLEAN TOGGLE WITH KEYBIND - No box, just text, key button and switch - SPACED OUT
local function createToggleWithKey(parent, yPos, labelText, keybindKey, enabledKey, callback, specialColor)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, -10 * guiScale, 0, 48 * guiScale)
    row.Position = UDim2.new(0, 5 * guiScale, 0, yPos * guiScale)
    row.BackgroundTransparency = 1
    row.BorderSizePixel = 0
    row.ZIndex = 3
    
    local keyBtn = Instance.new("TextButton", row)
    keyBtn.Size = UDim2.new(0, 36 * guiScale, 0, 28 * guiScale)
    keyBtn.Position = UDim2.new(0, 3 * guiScale, 0.5, -14 * guiScale)
    keyBtn.BackgroundColor3 = C.purple
    keyBtn.Text = KEYBINDS[keybindKey].Name
    keyBtn.TextColor3 = Color3.new(1, 1, 1)
    keyBtn.Font = Enum.Font.GothamBold
    keyBtn.TextSize = 11 * guiScale
    keyBtn.ZIndex = 4
    Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0, 8 * guiScale)
    
    KeyButtons[keybindKey] = keyBtn
    
    local label = Instance.new("TextLabel", row)
    label.Size = UDim2.new(0.55, 0, 1, 0)
    label.Position = UDim2.new(0, 45 * guiScale, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = C.text
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 14 * guiScale
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 4
    
    local onColor = specialColor or C.purple
    local defaultOn = Enabled[enabledKey]
    
    local toggleBg = Instance.new("Frame", row)
    toggleBg.Size = UDim2.new(0, 50 * guiScale, 0, 26 * guiScale)
    toggleBg.Position = UDim2.new(1, -58 * guiScale, 0.5, -13 * guiScale)
    toggleBg.BackgroundColor3 = defaultOn and onColor or Color3.fromRGB(25, 20, 35)
    toggleBg.ZIndex = 4
    Instance.new("UICorner", toggleBg).CornerRadius = UDim.new(1, 0)
    
    local toggleCircle = Instance.new("Frame", toggleBg)
    toggleCircle.Size = UDim2.new(0, 20 * guiScale, 0, 20 * guiScale)
    toggleCircle.Position = defaultOn and UDim2.new(1, -23 * guiScale, 0.5, -10 * guiScale) or UDim2.new(0, 3 * guiScale, 0.5, -10 * guiScale)
    toggleCircle.BackgroundColor3 = Color3.new(1, 1, 1)
    toggleCircle.ZIndex = 5
    Instance.new("UICorner", toggleCircle).CornerRadius = UDim.new(1, 0)
    
    local clickBtn = Instance.new("TextButton", row)
    clickBtn.Size = UDim2.new(0.6, 0, 1, 0)
    clickBtn.Position = UDim2.new(0.4, 0, 0, 0)
    clickBtn.BackgroundTransparency = 1
    clickBtn.Text = ""
    clickBtn.ZIndex = 6
    
    local isOn = defaultOn
    
    local function setVisual(state, skipCallback)
        isOn = state
        TweenService:Create(toggleBg, TweenInfo.new(0.3), {BackgroundColor3 = isOn and onColor or Color3.fromRGB(25, 20, 35)}):Play()
        TweenService:Create(toggleCircle, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Position = isOn and UDim2.new(1, -23 * guiScale, 0.5, -10 * guiScale) or UDim2.new(0, 3 * guiScale, 0.5, -10 * guiScale)}):Play()
        if not skipCallback then
            callback(isOn)
        end
    end
    
    VisualSetters[enabledKey] = setVisual
    
    clickBtn.MouseButton1Click:Connect(function()
        isOn = not isOn
        Enabled[enabledKey] = isOn
        setVisual(isOn)
        playSound("rbxassetid://6895079813", 0.4, 1)
    end)
    
    keyBtn.MouseButton1Click:Connect(function()
        waitingForKeybind = keybindKey
        keyBtn.Text = "..."
        playSound("rbxassetid://6895079813", 0.3, 1.5)
    end)
    
    return row, enabledKey, function() return isOn end, setVisual, keyBtn
end

-- CLEAN TOGGLE - No box, just text and switch - SPACED OUT
local function createToggle(parent, yPos, labelText, enabledKey, callback, specialColor)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, -10 * guiScale, 0, 48 * guiScale)
    row.Position = UDim2.new(0, 5 * guiScale, 0, yPos * guiScale)
    row.BackgroundTransparency = 1
    row.BorderSizePixel = 0
    row.ZIndex = 3
    
    local label = Instance.new("TextLabel", row)
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 10 * guiScale, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = C.text
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 14 * guiScale
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 4
    
    local onColor = specialColor or C.purple
    local defaultOn = Enabled[enabledKey]
    
    local toggleBg = Instance.new("Frame", row)
    toggleBg.Size = UDim2.new(0, 50 * guiScale, 0, 26 * guiScale)
    toggleBg.Position = UDim2.new(1, -58 * guiScale, 0.5, -13 * guiScale)
    toggleBg.BackgroundColor3 = defaultOn and onColor or Color3.fromRGB(25, 20, 35)
    toggleBg.ZIndex = 4
    Instance.new("UICorner", toggleBg).CornerRadius = UDim.new(1, 0)
    
    local toggleCircle = Instance.new("Frame", toggleBg)
    toggleCircle.Size = UDim2.new(0, 20 * guiScale, 0, 20 * guiScale)
    toggleCircle.Position = defaultOn and UDim2.new(1, -23 * guiScale, 0.5, -10 * guiScale) or UDim2.new(0, 3 * guiScale, 0.5, -10 * guiScale)
    toggleCircle.BackgroundColor3 = Color3.new(1, 1, 1)
    toggleCircle.ZIndex = 5
    Instance.new("UICorner", toggleCircle).CornerRadius = UDim.new(1, 0)
    
    local clickBtn = Instance.new("TextButton", row)
    clickBtn.Size = UDim2.new(1, 0, 1, 0)
    clickBtn.BackgroundTransparency = 1
    clickBtn.Text = ""
    clickBtn.ZIndex = 6
    
    local isOn = defaultOn
    
    local function setVisual(state, skipCallback)
        isOn = state
        TweenService:Create(toggleBg, TweenInfo.new(0.3), {BackgroundColor3 = isOn and onColor or Color3.fromRGB(25, 20, 35)}):Play()
        TweenService:Create(toggleCircle, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Position = isOn and UDim2.new(1, -23 * guiScale, 0.5, -10 * guiScale) or UDim2.new(0, 3 * guiScale, 0.5, -10 * guiScale)}):Play()
        if not skipCallback then
            callback(isOn)
        end
    end
    
    VisualSetters[enabledKey] = setVisual
    
    clickBtn.MouseButton1Click:Connect(function()
        isOn = not isOn
        Enabled[enabledKey] = isOn
        setVisual(isOn)
        playSound("rbxassetid://6895079813", 0.4, 1)
    end)
    
    return row, enabledKey, function() return isOn end, setVisual
end

-- CLEAN SLIDER - No box - SPACED OUT
local function createSlider(parent, yPos, labelText, minVal, maxVal, valueKey, callback)
    local container = Instance.new("Frame", parent)
    container.Size = UDim2.new(1, -10 * guiScale, 0, 56 * guiScale)
    container.Position = UDim2.new(0, 5 * guiScale, 0, yPos * guiScale)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.ZIndex = 3
    
    local label = Instance.new("TextLabel", container)
    label.Size = UDim2.new(0.6, 0, 0, 20 * guiScale)
    label.Position = UDim2.new(0, 10 * guiScale, 0, 4 * guiScale)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = C.textDim
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 12 * guiScale
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 4
    
    local defaultVal = Values[valueKey]
    
    local valueInput = Instance.new("TextBox", container)
    valueInput.Size = UDim2.new(0, 50 * guiScale, 0, 22 * guiScale)
    valueInput.Position = UDim2.new(1, -58 * guiScale, 0, 2 * guiScale)
    valueInput.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
    valueInput.Text = tostring(defaultVal)
    valueInput.TextColor3 = C.purpleLight
    valueInput.Font = Enum.Font.GothamBold
    valueInput.TextSize = 12 * guiScale
    valueInput.ClearTextOnFocus = false
    valueInput.ZIndex = 4
    Instance.new("UICorner", valueInput).CornerRadius = UDim.new(0, 6 * guiScale)
    
    local sliderBg = Instance.new("Frame", container)
    sliderBg.Size = UDim2.new(0.92, 0, 0, 10 * guiScale)
    sliderBg.Position = UDim2.new(0.04, 0, 0, 32 * guiScale)
    sliderBg.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
    sliderBg.ZIndex = 4
    Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)
    
    local pct = (defaultVal - minVal) / (maxVal - minVal)
    
    local sliderFill = Instance.new("Frame", sliderBg)
    sliderFill.Size = UDim2.new(pct, 0, 1, 0)
    sliderFill.BackgroundColor3 = C.purple
    sliderFill.ZIndex = 5
    Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)
    
    local thumb = Instance.new("Frame", sliderBg)
    thumb.Size = UDim2.new(0, 16 * guiScale, 0, 16 * guiScale)
    thumb.Position = UDim2.new(pct, -8 * guiScale, 0.5, -8 * guiScale)
    thumb.BackgroundColor3 = Color3.new(1, 1, 1)
    thumb.ZIndex = 6
    Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)
    
    local sliderBtn = Instance.new("TextButton", sliderBg)
    sliderBtn.Size = UDim2.new(1, 0, 3, 0)
    sliderBtn.Position = UDim2.new(0, 0, -1, 0)
    sliderBtn.BackgroundTransparency = 1
    sliderBtn.Text = ""
    sliderBtn.ZIndex = 7
    
    local dragging = false
    
    local function updateSlider(rel, skipCallback)
        rel = math.clamp(rel, 0, 1)
        sliderFill.Size = UDim2.new(rel, 0, 1, 0)
        thumb.Position = UDim2.new(rel, -8 * guiScale, 0.5, -8 * guiScale)
        local val = math.floor(minVal + (maxVal - minVal) * rel)
        valueInput.Text = tostring(val)
        Values[valueKey] = val
        if not skipCallback then
            callback(val)
        end
    end
    
    local function setSliderValue(val)
        val = math.clamp(val, minVal, maxVal)
        local rel = (val - minVal) / (maxVal - minVal)
        sliderFill.Size = UDim2.new(rel, 0, 1, 0)
        thumb.Position = UDim2.new(rel, -8 * guiScale, 0.5, -8 * guiScale)
        valueInput.Text = tostring(val)
        Values[valueKey] = val
    end
    
    SliderSetters[valueKey] = setSliderValue
    
    sliderBtn.MouseButton1Down:Connect(function() dragging = true end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X)
        end
    end)
    
    valueInput.FocusLost:Connect(function()
        local n = tonumber(valueInput.Text)
        if n then
            n = math.clamp(math.floor(n), minVal, maxVal)
            valueInput.Text = tostring(n)
            local r = (n - minVal) / (maxVal - minVal)
            sliderFill.Size = UDim2.new(r, 0, 1, 0)
            thumb.Position = UDim2.new(r, -8 * guiScale, 0.5, -8 * guiScale)
            Values[valueKey] = n
            callback(n)
        end
    end)
    
    return container, setSliderValue
end

-- Left side toggles - SPACED OUT LIKE BEFORE
createToggleWithKey(leftSide, 0, "Speed Boost", "SPEED", "SpeedBoost", function(s)
    Enabled.SpeedBoost = s
    if s then startSpeedBoost() else stopSpeedBoost() end
end)
_G.setSpeedVisual = VisualSetters.SpeedBoost

createSlider(leftSide, 52, "Boost Speed", 1, 70, "BoostSpeed", function(v) Values.BoostSpeed = v end)

createToggle(leftSide, 112, "Anti Ragdoll", "AntiRagdoll", function(s)
    Enabled.AntiRagdoll = s
    if s then startAntiRagdoll() else stopAntiRagdoll() end
end)

createToggleWithKey(leftSide, 216, "Spin Bot", "SPIN", "SpinBot", function(s)
    Enabled.SpinBot = s
    if s then startSpinBot() else stopSpinBot() end
end)

createSlider(leftSide, 268, "Spin Speed", 5, 50, "SpinSpeed", function(v) Values.SpinSpeed = v end)

createToggle(leftSide, 328, "Spam Bat", "SpamBat", function(s)
    Enabled.SpamBat = s
    if s then startSpamBat() else stopSpamBat() end
end)

createToggle(leftSide, 380, "Auto Steal", "AutoSteal", function(s)
    Enabled.AutoSteal = s
    if s then startAutoSteal() else stopAutoSteal() end
end)

createToggleWithKey(leftSide, 432, "Bat Aimbot", "BATAIMBOT", "BatAimbot", function(s)
    Enabled.BatAimbot = s
    if s then startBatAimbot() else stopBatAimbot() end
end, C.danger)

createToggle(leftSide, 484, "Galaxy Sky Bright", "GalaxySkyBright", function(s)
    Enabled.GalaxySkyBright = s
    if s then enableGalaxySkyBright() else disableGalaxySkyBright() end
end, Color3.fromRGB(180, 80, 255))

-- Right side toggles - SPACED OUT LIKE BEFORE
createToggleWithKey(rightSide, 0, "Galaxy Mode", "GALAXY", "Galaxy", function(s)
    Enabled.Galaxy = s
    if s then startGalaxy() else stopGalaxy() end
end, Color3.fromRGB(60, 130, 255))
_G.setGalaxyVisual = VisualSetters.Galaxy

createSlider(rightSide, 52, "Gravity %", 25, 130, "GalaxyGravityPercent", function(v)
    Values.GalaxyGravityPercent = v
    if galaxyEnabled then adjustGalaxyJump() end
end)

createSlider(rightSide, 112, "Hop Power", 10, 80, "HOP_POWER", function(v) Values.HOP_POWER = v end)

createToggle(rightSide, 172, "Speed While Stealing", "SpeedWhileStealing", function(s)
    Enabled.SpeedWhileStealing = s
    if s then startSpeedWhileStealing() else stopSpeedWhileStealing() end
end)

createSlider(rightSide, 224, "Steal Speed", 10, 35, "StealingSpeedValue", function(v) Values.StealingSpeedValue = v end)

createToggle(rightSide, 284, "Unwalk", "Unwalk", function(s)
    Enabled.Unwalk = s
    if s then startUnwalk() else stopUnwalk() end
end)

createToggle(rightSide, 336, "Optimizer + XRay", "Optimizer", function(s)
    Enabled.Optimizer = s
    if s then enableOptimizer() else disableOptimizer() end
end)

createToggleWithKey(rightSide, 388, "Auto Left", "AUTOLEFT", "AutoWalkEnabled", function(s)
    AutoWalkEnabled = s
    Enabled.AutoWalkEnabled = s
    if s then startAutoWalk() else stopAutoWalk() end
end, Color3.fromRGB(100, 150, 255))
_G.setAutoLeftVisual = VisualSetters.AutoWalkEnabled

createToggleWithKey(rightSide, 440, "Auto Right", "AUTORIGHT", "AutoRightEnabled", function(s)
    AutoRightEnabled = s
    Enabled.AutoRightEnabled = s
    if s then startAutoRight() else stopAutoRight() end
end, Color3.fromRGB(100, 220, 180))
_G.setAutoRightVisual = VisualSetters.AutoRightEnabled

-- Save Button
local SaveBtn = Instance.new("TextButton", rightSide)
SaveBtn.Size = UDim2.new(1, -10 * guiScale, 0, 50 * guiScale)
SaveBtn.Position = UDim2.new(0, 5 * guiScale, 0, 503 * guiScale)
SaveBtn.BackgroundColor3 = C.purple
SaveBtn.Text = "SAVE CONFIG"
SaveBtn.TextColor3 = Color3.new(1, 1, 1)
SaveBtn.Font = Enum.Font.GothamBold
SaveBtn.TextSize = 15 * guiScale
SaveBtn.ZIndex = 3
Instance.new("UICorner", SaveBtn).CornerRadius = UDim.new(0, 12 * guiScale)

SaveBtn.MouseButton1Click:Connect(function()
    local success = SaveConfig()
    if success then
        SaveBtn.Text = "SAVED!"
        SaveBtn.BackgroundColor3 = C.success
    else
        SaveBtn.Text = "FAILED"
        SaveBtn.BackgroundColor3 = C.danger
    end
    task.delay(1.5, function()
        SaveBtn.Text = "SAVE CONFIG"
        SaveBtn.BackgroundColor3 = C.purple
    end)
end)

local infoLabel = Instance.new("TextLabel", leftSide)
infoLabel.Size = UDim2.new(1, 0, 0, 40 * guiScale)
infoLabel.Position = UDim2.new(0, 0, 0, 600 * guiScale)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "V=Speed | N=Spin | M=Galaxy | X=Aimbot\nZ=AutoLeft | C=AutoRight | Q=Nuke | U=GUI"
infoLabel.TextColor3 = C.textDim
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextSize = 9 * guiScale
infoLabel.ZIndex = 3

local guiVisible = true

-- Apply loaded config (delayed to prevent character reset)
task.spawn(function()
    task.wait(3) -- Wait longer to ensure character is fully loaded and physics settled
    
    -- Make sure character exists
    local c = Player.Character
    if not c or not c:FindFirstChild("HumanoidRootPart") then
        c = Player.CharacterAdded:Wait()
        task.wait(1)
    end
    
    -- Update keybind buttons
    for key, btn in pairs(KeyButtons) do
        if btn and KEYBINDS[key] then
            btn.Text = KEYBINDS[key].Name
        end
    end
    
    for key, setter in pairs(VisualSetters) do
        if Enabled[key] then
            setter(true, true)
        end
    end
    
    for key, setter in pairs(SliderSetters) do
        if Values[key] then
            setter(Values[key])
        end
    end
    
    -- Start features that don't affect physics first
    if Enabled.AntiRagdoll then startAntiRagdoll() end
    if Enabled.AutoSteal then startAutoSteal() end
    if Enabled.Optimizer then enableOptimizer() end
    if Enabled.GalaxySkyBright then enableGalaxySkyBright() end
    
    task.wait(0.5)
    
    -- Then start physics features
    if Enabled.SpeedBoost then startSpeedBoost() end
    if Enabled.SpinBot then startSpinBot() end
    if Enabled.SpamBat then startSpamBat() end
    if Enabled.BatAimbot then startBatAimbot() end
    if Enabled.Galaxy then startGalaxy() end
    if Enabled.SpeedWhileStealing then startSpeedWhileStealing() end
    if Enabled.Unwalk then startUnwalk() end
    if Enabled.AutoWalkEnabled then AutoWalkEnabled = true startAutoWalk() end
    if Enabled.AutoRightEnabled then AutoRightEnabled = true startAutoRight() end
    
    if configLoaded then
        -- Config loaded silently
    end
end)

-- Input handling
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    
    -- Handle keybind changes
    if waitingForKeybind and input.KeyCode ~= Enum.KeyCode.Unknown then
        local k = input.KeyCode
        KEYBINDS[waitingForKeybind] = k
        if KeyButtons[waitingForKeybind] then
            KeyButtons[waitingForKeybind].Text = k.Name
        end
        waitingForKeybind = nil
        return
    end
    
    if input.KeyCode == Enum.KeyCode.U then
        guiVisible = not guiVisible
        main.Visible = guiVisible
        return
    end
    
    if input.KeyCode == Enum.KeyCode.Space then
        spaceHeld = true
        return
    end
    
    if input.KeyCode == KEYBINDS.SPEED then
        Enabled.SpeedBoost = not Enabled.SpeedBoost
        if VisualSetters.SpeedBoost then VisualSetters.SpeedBoost(Enabled.SpeedBoost) end
        if Enabled.SpeedBoost then startSpeedBoost() else stopSpeedBoost() end
    end
    
    if input.KeyCode == KEYBINDS.SPIN then
        Enabled.SpinBot = not Enabled.SpinBot
        if VisualSetters.SpinBot then VisualSetters.SpinBot(Enabled.SpinBot) end
        if Enabled.SpinBot then startSpinBot() else stopSpinBot() end
    end
    
    if input.KeyCode == KEYBINDS.GALAXY then
        Enabled.Galaxy = not Enabled.Galaxy
        if VisualSetters.Galaxy then VisualSetters.Galaxy(Enabled.Galaxy) end
        if Enabled.Galaxy then startGalaxy() else stopGalaxy() end
    end
    
    if input.KeyCode == KEYBINDS.BATAIMBOT then
        Enabled.BatAimbot = not Enabled.BatAimbot
        if VisualSetters.BatAimbot then VisualSetters.BatAimbot(Enabled.BatAimbot) end
        if Enabled.BatAimbot then startBatAimbot() else stopBatAimbot() end
    end
    
    if input.KeyCode == KEYBINDS.NUKE then
        local n = getNearestPlayer()
        if n then INSTANT_NUKE(n) end
    end
    
    if input.KeyCode == KEYBINDS.AUTOLEFT then
        AutoWalkEnabled = not AutoWalkEnabled
        Enabled.AutoWalkEnabled = AutoWalkEnabled
        if VisualSetters.AutoWalkEnabled then VisualSetters.AutoWalkEnabled(AutoWalkEnabled) end
        if AutoWalkEnabled then startAutoWalk() else stopAutoWalk() end
    end
    
    if input.KeyCode == KEYBINDS.AUTORIGHT then
        AutoRightEnabled = not AutoRightEnabled
        Enabled.AutoRightEnabled = AutoRightEnabled
        if VisualSetters.AutoRightEnabled then VisualSetters.AutoRightEnabled(AutoRightEnabled) end
        if AutoRightEnabled then startAutoRight() else stopAutoRight() end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then
        spaceHeld = false
    end
end)

Player.CharacterAdded:Connect(function()
    task.wait(1)
    if Enabled.SpinBot then stopSpinBot() task.wait(0.1) startSpinBot() end
    if Enabled.Galaxy then setupGalaxyForce() adjustGalaxyJump() end
    if Enabled.SpamBat then stopSpamBat() task.wait(0.1) startSpamBat() end
    if Enabled.BatAimbot then stopBatAimbot() task.wait(0.1) startBatAimbot() end
    if Enabled.Unwalk then startUnwalk() end
end)
]],
})

table.insert(SCRIPTS, {
    name  = "Kawatan Hub",
    icon  = "🔱",
    desc  = "ALL-IN-ONE • HUB",
    isNew = true,
    kind  = "http",
    code  = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/Chiron-ux/Kawatan/27919507c04a426f982eccf82e32b49bae400ebf/Kawatan\"))()",
})

table.insert(SCRIPTS, {
    name  = "OG Lucky Block",
    icon  = "⭐",
    desc  = "OG BLOCK • INJECT",
    isNew = true,
    kind  = "http",
    code  = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/platinww/CrustyMain/refs/heads/main/Steal-A-Brainrot/OGBlock.lua\"))()",
})

table.insert(SCRIPTS, {
    name  = "AP Spammer",
    icon  = "📢",
    desc  = "ADMIN • SPAM • TOOLS",
    isNew = false,
    kind  = "http",
    code  = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/Tokinu/Admin-Spammer/refs/heads/main/Tokinu\"))()",
})

table.insert(SCRIPTS, {
    name  = "ZZZZ Hub V2.3",
    icon  = "💤",
    desc  = "MULTI-TOOL • V2.3",
    isNew = false,
    kind  = "http",
    code  = "loadstring(game:HttpGet(\"https://api.luarmor.net/files/v4/loaders/51903b9ad68922379ca7ea76841e0a68.lua\"))()",
})

table.insert(SCRIPTS, {
    name  = "FPS Booster",
    icon  = "⚡",
    desc  = "FPS • OPTIMIZE • BOOST",
    isNew = false,
    kind  = "http",
    code  = "loadstring(game:HttpGet(\"https://pastefy.app/dWahW7sK/raw\"))()",
})

table.insert(SCRIPTS, {
    name  = "SK Auto Joiner",
    icon  = "🔗",
    desc  = "10M-1B • AUTO JOIN",
    isNew = false,
    kind  = "http",
    code  = "loadstring(game:HttpGet(\"https://api.jnkie.com/api/v1/luascripts/public/4412bf5b03484439b54771aa1b89e7bf8dd52b12759ac2f76d92f6e759c3e333/download\"))()",
})

table.insert(SCRIPTS, {
    name  = "Anti Lag",
    icon  = "🛡️",
    desc  = "LAG • REDUCE • SMOOTH",
    isNew = false,
    kind  = "http",
    code  = "loadstring(game:HttpGet(\"https://pastefy.app/yT46OCAj/raw\"))()",
})

table.insert(SCRIPTS, {
    name  = "OP Auto Dual",
    icon  = "🔥",
    desc  = "OP • AUTO • DUAL",
    isNew = true,
    kind  = "http",
    code  = "loadstring(game:HttpGet(\"https://pastebin.com/raw/E05dV3da\", true))()",
})

table.insert(SCRIPTS, {
    name  = "Kurd Hub",
    icon  = "🌙",
    desc  = "MULTI • TOOL • HUB",
    isNew = false,
    kind  = "http",
    code  = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/Ninja10908/S4/refs/heads/main/Kurdhub\"))()",
})

table.insert(SCRIPTS, {
    name  = "Bk's Hub",
    icon  = "👑",
    desc  = "BK • HUB • TOOLS",
    isNew = false,
    kind  = "http",
    code  = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/xenji0hub/XENJI-BKS-HUB/refs/heads/main/XENJI%20BKS%20HUB\"))()",
})

table.insert(SCRIPTS, {
    name  = "Ajjan Hub",
    icon  = "🎯",
    desc  = "MULTI • TOOL • HUB",
    isNew = false,
    kind  = "http",
    code  = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/onliengamerop/Steal-a-brainrot/refs/heads/main/Protected_3771863424757750.lua.txt\"))()",
})

table.insert(SCRIPTS, {
    name  = "Lagger",
    icon  = "📡",
    desc  = "35% SPEED • 15% INTENSITY",
    isNew = false,
    kind  = "http",
    code  = "loadstring(game:HttpGet(\"https://api.luarmor.net/files/v4/loaders/8a38a001b620d73c352fbd5ddb5cdf23.lua\"))()",
})

table.insert(SCRIPTS, {
    name  = "Kuni Hub",
    icon  = "⚔️",
    desc  = "KUNI • HUB • TOOLS",
    isNew = true,
    kind  = "http",
    code  = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/Script-exe-rblx/KuniHub/refs/heads/main/lua\"))()",
})

table.insert(SCRIPTS, {
    name  = "Nameless Hub",
    icon  = "🌐",
    desc  = "ALL-IN-ONE • HUB • TOOLS",
    isNew = false,
    kind  = "http",
    code  = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr\"))()",
})

table.insert(SCRIPTS, {
    name  = "Mango Hub",
    icon  = "🥭",
    desc  = "AUTO • COMBAT • TOOLS",
    isNew = false,
    kind  = "http",
    code  = "loadstring(game:HttpGet(\"https://api.luarmor.net/files/v4/loaders/36b1e8d301d50234eede4210e85cb57e.lua\"))()",
})

table.insert(SCRIPTS, {
    name  = "Brainrot Spawner",
    icon  = "🧬",
    desc  = "SPAWN • BRAINROT • ADMIN",
    isNew = true,
    kind  = "http",
    code  = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/platinww/CrustyMain/refs/heads/main/Steal-A-Brainrot/Spawner/Spawner.lua\"))()",
})


--========================================================
-- GUI — Sidebar Split Launcher
--========================================================

local ScreenGui=Instance.new("ScreenGui")
ScreenGui.Name="XoShLauncher"; ScreenGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn=false; ScreenGui.IgnoreGuiInset=true
ScreenGui.Parent=player:WaitForChild("PlayerGui")

local Overlay=Instance.new("Frame",ScreenGui)
Overlay.Size=UDim2.new(1,0,1,0); Overlay.BackgroundColor3=Color3.fromRGB(0,0,0)
Overlay.BackgroundTransparency=0.5; Overlay.BorderSizePixel=0; Overlay.ZIndex=1

local Panel=Instance.new("Frame",ScreenGui)
Panel.Name="Panel"; Panel.Size=UDim2.new(0.88,0,0.62,0); Panel.Position=UDim2.new(0.06,0,0.19,0)
Panel.BackgroundColor3=Color3.fromRGB(8,11,20); Panel.BackgroundTransparency=0.06
Panel.BorderSizePixel=0; Panel.Active=true; Panel.Draggable=true; Panel.ZIndex=2
Instance.new("UICorner",Panel).CornerRadius=UDim.new(0,14)

local panelStroke=Instance.new("UIStroke",Panel)
panelStroke.Thickness=1.8; panelStroke.Color=Color3.fromRGB(0,180,255)
task.spawn(function()
    while Panel.Parent do
        TweenService:Create(panelStroke,TweenInfo.new(0.7,Enum.EasingStyle.Sine),{Color=Color3.fromRGB(80,220,255)}):Play(); task.wait(0.7)
        TweenService:Create(panelStroke,TweenInfo.new(0.7,Enum.EasingStyle.Sine),{Color=Color3.fromRGB(0,110,210)}):Play(); task.wait(0.7)
    end
end)

local Sidebar=Instance.new("Frame",Panel)
Sidebar.Size=UDim2.new(0.32,0,1,0); Sidebar.BackgroundColor3=Color3.fromRGB(0,100,200)
Sidebar.BackgroundTransparency=0.88; Sidebar.BorderSizePixel=0
Instance.new("UICorner",Sidebar).CornerRadius=UDim.new(0,14)

local sideDiv=Instance.new("Frame",Sidebar); sideDiv.Size=UDim2.new(0,1,1,0); sideDiv.Position=UDim2.new(1,-1,0,0)
sideDiv.BackgroundColor3=Color3.fromRGB(0,160,255); sideDiv.BackgroundTransparency=0.7; sideDiv.BorderSizePixel=0

local SideHeader=Instance.new("Frame",Sidebar); SideHeader.Size=UDim2.new(1,0,0,56)
SideHeader.BackgroundColor3=Color3.fromRGB(0,120,220); SideHeader.BackgroundTransparency=0.82; SideHeader.BorderSizePixel=0
Instance.new("UICorner",SideHeader).CornerRadius=UDim.new(0,14)

local SHDiv=Instance.new("Frame",SideHeader); SHDiv.Size=UDim2.new(0.85,0,0,1); SHDiv.Position=UDim2.new(0.075,0,1,-1)
SHDiv.BackgroundColor3=Color3.fromRGB(0,160,255); SHDiv.BackgroundTransparency=0.65; SHDiv.BorderSizePixel=0

local LogoBg=Instance.new("Frame",SideHeader); LogoBg.Size=UDim2.new(0,30,0,30); LogoBg.Position=UDim2.new(0,10,0.5,-15)
LogoBg.BackgroundColor3=Color3.fromRGB(0,150,255); LogoBg.BorderSizePixel=0
Instance.new("UICorner",LogoBg).CornerRadius=UDim.new(0,8)
local LogoLbl=Instance.new("TextLabel",LogoBg); LogoLbl.Size=UDim2.new(1,0,1,0); LogoLbl.BackgroundTransparency=1
LogoLbl.Text="67"; LogoLbl.Font=Enum.Font.GothamBold; LogoLbl.TextSize=13; LogoLbl.TextColor3=Color3.fromRGB(255,255,255)
task.spawn(function()
    while LogoBg.Parent do
        TweenService:Create(LogoBg,TweenInfo.new(0.9,Enum.EasingStyle.Sine),{BackgroundColor3=Color3.fromRGB(0,80,200)}):Play(); task.wait(0.9)
        TweenService:Create(LogoBg,TweenInfo.new(0.9,Enum.EasingStyle.Sine),{BackgroundColor3=Color3.fromRGB(0,190,255)}):Play(); task.wait(0.9)
    end
end)

local HubTitle=Instance.new("TextLabel",SideHeader); HubTitle.Size=UDim2.new(1,-50,0,18); HubTitle.Position=UDim2.new(0,48,0,9)
HubTitle.BackgroundTransparency=1; HubTitle.Text="67 HUB XoSh"; HubTitle.Font=Enum.Font.GothamBold; HubTitle.TextSize=13
HubTitle.TextColor3=Color3.fromRGB(190,235,255); HubTitle.TextXAlignment=Enum.TextXAlignment.Left

local HubSub=Instance.new("TextLabel",SideHeader); HubSub.Size=UDim2.new(1,-50,0,14); HubSub.Position=UDim2.new(0,48,0,29)
HubSub.BackgroundTransparency=1; HubSub.Text="SCRIPT LAUNCHER"; HubSub.Font=Enum.Font.GothamBold; HubSub.TextSize=9
HubSub.TextColor3=Color3.fromRGB(0,190,255); HubSub.TextTransparency=0.25; HubSub.TextXAlignment=Enum.TextXAlignment.Left

local NavScroll=Instance.new("ScrollingFrame",Sidebar)
NavScroll.Size=UDim2.new(1,0,1,-62); NavScroll.Position=UDim2.new(0,0,0,60)
NavScroll.BackgroundTransparency=1; NavScroll.BorderSizePixel=0
NavScroll.ScrollBarThickness=2; NavScroll.ScrollBarImageColor3=Color3.fromRGB(0,160,255)
NavScroll.CanvasSize=UDim2.new(0,0,0,0); NavScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
local NavList=Instance.new("UIListLayout",NavScroll); NavList.Padding=UDim.new(0,4)
local NavPad=Instance.new("UIPadding",NavScroll)
NavPad.PaddingTop=UDim.new(0,6); NavPad.PaddingBottom=UDim.new(0,6)
NavPad.PaddingLeft=UDim.new(0,7); NavPad.PaddingRight=UDim.new(0,7)

local Content=Instance.new("Frame",Panel); Content.Size=UDim2.new(0.68,-2,1,0); Content.Position=UDim2.new(0.32,2,0,0)
Content.BackgroundTransparency=1; Content.BorderSizePixel=0

local CloseBtn=Instance.new("TextButton",Content); CloseBtn.Size=UDim2.new(0,36,0,36); CloseBtn.Position=UDim2.new(1,-44,0,8)
CloseBtn.BackgroundColor3=Color3.fromRGB(40,20,20); CloseBtn.BackgroundTransparency=0.3; CloseBtn.BorderSizePixel=0
CloseBtn.Text="✕"; CloseBtn.Font=Enum.Font.GothamBold; CloseBtn.TextSize=16
CloseBtn.TextColor3=Color3.fromRGB(255,160,160); CloseBtn.ZIndex=5
Instance.new("UICorner",CloseBtn).CornerRadius=UDim.new(1,0)

local CP=Instance.new("Frame",Content); CP.Size=UDim2.new(1,-24,1,-24); CP.Position=UDim2.new(0,12,0,12)
CP.BackgroundTransparency=1; CP.BorderSizePixel=0

local IconBox=Instance.new("Frame",CP); IconBox.Size=UDim2.new(0,52,0,52); IconBox.Position=UDim2.new(0,0,0,8)
IconBox.BackgroundColor3=Color3.fromRGB(0,100,200); IconBox.BackgroundTransparency=0.6; IconBox.BorderSizePixel=0
Instance.new("UICorner",IconBox).CornerRadius=UDim.new(0,13)
local IconStroke=Instance.new("UIStroke",IconBox); IconStroke.Thickness=1; IconStroke.Color=Color3.fromRGB(0,180,255); IconStroke.Transparency=0.4
local IconLbl=Instance.new("TextLabel",IconBox); IconLbl.Size=UDim2.new(1,0,1,0); IconLbl.BackgroundTransparency=1
IconLbl.TextSize=26; IconLbl.Font=Enum.Font.GothamBold

local CName=Instance.new("TextLabel",CP); CName.Size=UDim2.new(1,-70,0,28); CName.Position=UDim2.new(0,64,0,10)
CName.BackgroundTransparency=1; CName.Font=Enum.Font.GothamBold; CName.TextSize=18
CName.TextColor3=Color3.fromRGB(210,240,255); CName.TextXAlignment=Enum.TextXAlignment.Left; CName.TextTruncate=Enum.TextTruncate.AtEnd

local CDesc=Instance.new("TextLabel",CP); CDesc.Size=UDim2.new(1,-70,0,18); CDesc.Position=UDim2.new(0,64,0,38)
CDesc.BackgroundTransparency=1; CDesc.Font=Enum.Font.GothamBold; CDesc.TextSize=10
CDesc.TextColor3=Color3.fromRGB(0,190,255); CDesc.TextTransparency=0.2; CDesc.TextXAlignment=Enum.TextXAlignment.Left

local HttpBadge=Instance.new("TextLabel",CP); HttpBadge.Size=UDim2.new(0,80,0,16); HttpBadge.Position=UDim2.new(0,64,0,58)
HttpBadge.BackgroundColor3=Color3.fromRGB(0,160,100); HttpBadge.BackgroundTransparency=0.3; HttpBadge.BorderSizePixel=0
HttpBadge.Text="🌐  ONLINE"; HttpBadge.Font=Enum.Font.GothamBold; HttpBadge.TextSize=9
HttpBadge.TextColor3=Color3.fromRGB(200,255,230); HttpBadge.Visible=false
Instance.new("UICorner",HttpBadge).CornerRadius=UDim.new(0,5)

local Div=Instance.new("Frame",CP); Div.Size=UDim2.new(1,0,0,1); Div.Position=UDim2.new(0,0,0,72)
Div.BackgroundColor3=Color3.fromRGB(0,150,255); Div.BackgroundTransparency=0.7; Div.BorderSizePixel=0

local SRow=Instance.new("Frame",CP); SRow.Size=UDim2.new(1,0,0,20); SRow.Position=UDim2.new(0,0,0,80)
SRow.BackgroundTransparency=1; SRow.BorderSizePixel=0

local SDot=Instance.new("Frame",SRow); SDot.Size=UDim2.new(0,7,0,7); SDot.Position=UDim2.new(0,0,0.5,-3.5)
SDot.BackgroundColor3=Color3.fromRGB(0,255,140); SDot.BorderSizePixel=0
Instance.new("UICorner",SDot).CornerRadius=UDim.new(1,0)
task.spawn(function()
    while SDot.Parent do
        TweenService:Create(SDot,TweenInfo.new(0.8,Enum.EasingStyle.Sine),{BackgroundTransparency=0.5}):Play(); task.wait(0.8)
        TweenService:Create(SDot,TweenInfo.new(0.8,Enum.EasingStyle.Sine),{BackgroundTransparency=0}):Play(); task.wait(0.8)
    end
end)

local STxt=Instance.new("TextLabel",SRow); STxt.Size=UDim2.new(0.5,0,1,0); STxt.Position=UDim2.new(0,13,0,0)
STxt.BackgroundTransparency=1; STxt.Text="READY TO LOAD"; STxt.Font=Enum.Font.GothamBold; STxt.TextSize=9
STxt.TextColor3=Color3.fromRGB(0,220,140); STxt.TextXAlignment=Enum.TextXAlignment.Left

local CTxt=Instance.new("TextLabel",SRow); CTxt.Size=UDim2.new(0.5,0,1,0); CTxt.Position=UDim2.new(0.5,0,0,0)
CTxt.BackgroundTransparency=1; CTxt.Text=#SCRIPTS.." SCRIPTS LOADED"; CTxt.Font=Enum.Font.GothamBold; CTxt.TextSize=9
CTxt.TextColor3=Color3.fromRGB(0,160,220); CTxt.TextTransparency=0.3; CTxt.TextXAlignment=Enum.TextXAlignment.Right

local ExecBtn=Instance.new("TextButton",CP); ExecBtn.Size=UDim2.new(0.55,0,0,36); ExecBtn.Position=UDim2.new(0,0,1,-44)
ExecBtn.BackgroundColor3=Color3.fromRGB(0,130,255); ExecBtn.BackgroundTransparency=0.25; ExecBtn.BorderSizePixel=0
ExecBtn.Text="▶   EXECUTE SCRIPT"; ExecBtn.Font=Enum.Font.GothamBold; ExecBtn.TextSize=13
ExecBtn.TextColor3=Color3.fromRGB(220,245,255); ExecBtn.AutoButtonColor=false
Instance.new("UICorner",ExecBtn).CornerRadius=UDim.new(0,10)
local ExecStroke=Instance.new("UIStroke",ExecBtn); ExecStroke.Thickness=1.2; ExecStroke.Color=Color3.fromRGB(0,200,255); ExecStroke.Transparency=0.3
ExecBtn.MouseEnter:Connect(function() TweenService:Create(ExecBtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(0,160,255),BackgroundTransparency=0.1}):Play() end)
ExecBtn.MouseLeave:Connect(function() TweenService:Create(ExecBtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(0,130,255),BackgroundTransparency=0.25}):Play() end)

local ReopenBtn=Instance.new("TextButton",ScreenGui); ReopenBtn.Name="ReopenBtn"
ReopenBtn.Size=UDim2.new(0,54,0,54); ReopenBtn.Position=UDim2.new(1,-66,0,12)
ReopenBtn.BackgroundColor3=Color3.fromRGB(0,140,255); ReopenBtn.BackgroundTransparency=0.1; ReopenBtn.BorderSizePixel=0
ReopenBtn.Text="67"; ReopenBtn.Font=Enum.Font.GothamBold; ReopenBtn.TextSize=17
ReopenBtn.TextColor3=Color3.fromRGB(255,255,255); ReopenBtn.ZIndex=20; ReopenBtn.Visible=false
Instance.new("UICorner",ReopenBtn).CornerRadius=UDim.new(1,0)
local orbStroke=Instance.new("UIStroke",ReopenBtn); orbStroke.Thickness=2; orbStroke.Color=Color3.fromRGB(100,230,255)
task.spawn(function()
    while ReopenBtn.Parent do
        TweenService:Create(ReopenBtn,TweenInfo.new(0.8,Enum.EasingStyle.Sine),{BackgroundColor3=Color3.fromRGB(0,80,200)}):Play(); task.wait(0.8)
        TweenService:Create(ReopenBtn,TweenInfo.new(0.8,Enum.EasingStyle.Sine),{BackgroundColor3=Color3.fromRGB(0,200,255)}):Play(); task.wait(0.8)
    end
end)

do
    local dragging,dragStart,startPos=false,nil,nil
    ReopenBtn.InputBegan:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
            dragging=true; dragStart=inp.Position; startPos=ReopenBtn.Position
        end
    end)
    ReopenBtn.InputEnded:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then dragging=false end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) then
            local d=inp.Position-dragStart
            ReopenBtn.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
        end
    end)
end

local panelOpen=true
local selectedIndex=1
local selectedScript=SCRIPTS[1]

local function closePanel()
    panelOpen=false
    TweenService:Create(Panel,TweenInfo.new(0.28,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{
        Size=UDim2.new(0.88,0,0,0),Position=UDim2.new(0.06,0,0.5,0),BackgroundTransparency=1
    }):Play()
    TweenService:Create(Overlay,TweenInfo.new(0.22),{BackgroundTransparency=1}):Play()
    task.delay(0.3,function()
        Panel.Visible=false; Overlay.Visible=false
        ReopenBtn.Visible=true
        ReopenBtn.Size=UDim2.new(0,0,0,0); ReopenBtn.Position=UDim2.new(1,-33,0,39)
        TweenService:Create(ReopenBtn,TweenInfo.new(0.3,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
            Size=UDim2.new(0,54,0,54),Position=UDim2.new(1,-66,0,12)
        }):Play()
    end)
end

local navBtns={}

local function updateContent(idx)
    local s=SCRIPTS[idx]
    IconLbl.Text=s.icon; CName.Text=s.name; CDesc.Text=s.desc
    HttpBadge.Visible=(s.kind=="http"); selectedScript=s; selectedIndex=idx
    for i,btn in ipairs(navBtns) do
        if i==idx then
            TweenService:Create(btn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(0,130,220),BackgroundTransparency=0.22}):Play()
            btn:FindFirstChild("NavStroke").Transparency=0
        else
            TweenService:Create(btn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(0,80,160),BackgroundTransparency=0.88}):Play()
            btn:FindFirstChild("NavStroke").Transparency=0.7
        end
    end
end

for i,s in ipairs(SCRIPTS) do
    local NavBtn=Instance.new("TextButton",NavScroll); NavBtn.Name="Nav_"..i
    NavBtn.Size=UDim2.new(1,0,0,38); NavBtn.BackgroundColor3=Color3.fromRGB(0,80,160)
    NavBtn.BackgroundTransparency=0.88; NavBtn.BorderSizePixel=0; NavBtn.Text=""; NavBtn.AutoButtonColor=false
    Instance.new("UICorner",NavBtn).CornerRadius=UDim.new(0,9)
    local ns=Instance.new("UIStroke",NavBtn); ns.Name="NavStroke"; ns.Thickness=1
    ns.Color=Color3.fromRGB(0,180,255); ns.Transparency=0.7
    if s.isNew then
        local nb=Instance.new("TextLabel",NavBtn); nb.Size=UDim2.new(0,28,0,14); nb.Position=UDim2.new(1,-32,0,4)
        nb.BackgroundColor3=Color3.fromRGB(0,200,120); nb.BackgroundTransparency=0.2; nb.BorderSizePixel=0
        nb.Text="NEW"; nb.Font=Enum.Font.GothamBold; nb.TextSize=7; nb.TextColor3=Color3.fromRGB(255,255,255); nb.ZIndex=3
        Instance.new("UICorner",nb).CornerRadius=UDim.new(0,4)
    end
    if s.kind=="http" then
        local wb=Instance.new("TextLabel",NavBtn); wb.Size=UDim2.new(0,16,0,16); wb.Position=UDim2.new(1,-20,0.5,-8)
        wb.BackgroundTransparency=1; wb.Text="🌐"; wb.Font=Enum.Font.GothamBold; wb.TextSize=12; wb.ZIndex=3
    end
    local NIcon=Instance.new("TextLabel",NavBtn); NIcon.Size=UDim2.new(0,28,1,0); NIcon.Position=UDim2.new(0,5,0,0)
    NIcon.BackgroundTransparency=1; NIcon.Text=s.icon; NIcon.TextSize=16; NIcon.Font=Enum.Font.GothamBold
    local NName=Instance.new("TextLabel",NavBtn); NName.Size=UDim2.new(1,-46,1,0); NName.Position=UDim2.new(0,36,0,0)
    NName.BackgroundTransparency=1; NName.Text=s.name; NName.Font=Enum.Font.GothamBold; NName.TextSize=12
    NName.TextColor3=Color3.fromRGB(180,225,255); NName.TextXAlignment=Enum.TextXAlignment.Left; NName.TextTruncate=Enum.TextTruncate.AtEnd
    NavBtn.MouseEnter:Connect(function()
        if i~=selectedIndex then TweenService:Create(NavBtn,TweenInfo.new(0.13),{BackgroundTransparency=0.7}):Play() end
    end)
    NavBtn.MouseLeave:Connect(function()
        if i~=selectedIndex then TweenService:Create(NavBtn,TweenInfo.new(0.13),{BackgroundTransparency=0.88}):Play() end
    end)
    NavBtn.MouseButton1Click:Connect(function() updateContent(i) end)
    table.insert(navBtns,NavBtn)
end

ExecBtn.MouseButton1Click:Connect(function()
    TweenService:Create(ExecBtn,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(0,200,80),BackgroundTransparency=0.1}):Play()
    ExecBtn.Text="⏳   LOADING..."
    task.wait(0.2); closePanel(); task.wait(0.1)
    local fn,err=loadstring(selectedScript.code)
    if fn then task.spawn(fn) else warn("[67HUB] Load error: "..tostring(err)) end
    task.delay(0.5,function()
        ExecBtn.Text="▶   EXECUTE SCRIPT"
        TweenService:Create(ExecBtn,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(0,130,255),BackgroundTransparency=0.25}):Play()
    end)
end)

CloseBtn.MouseButton1Click:Connect(closePanel)
ReopenBtn.MouseButton1Click:Connect(function()
    panelOpen=true; Panel.Visible=true; Overlay.Visible=true
    Panel.Size=UDim2.new(0.88,0,0,0); Panel.Position=UDim2.new(0.06,0,0.5,0)
    Panel.BackgroundTransparency=1; Overlay.BackgroundTransparency=1
    TweenService:Create(Panel,TweenInfo.new(0.32,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
        Size=UDim2.new(0.88,0,0.62,0),Position=UDim2.new(0.06,0,0.19,0),BackgroundTransparency=0.06
    }):Play()
    TweenService:Create(Overlay,TweenInfo.new(0.22),{BackgroundTransparency=0.5}):Play()
    TweenService:Create(ReopenBtn,TweenInfo.new(0.15),{Size=UDim2.new(0,0,0,0)}):Play()
    task.delay(0.16,function() ReopenBtn.Visible=false end)
end)

Panel.Visible=false; Overlay.Visible=false

function openLauncher()
    Panel.Visible=true; Overlay.Visible=true
    Panel.Size=UDim2.new(0.88,0,0,0); Panel.Position=UDim2.new(0.06,0,0.5,0)
    Panel.BackgroundTransparency=1; Overlay.BackgroundTransparency=1
    TweenService:Create(Overlay,TweenInfo.new(0.3),{BackgroundTransparency=0.5}):Play()
    TweenService:Create(Panel,TweenInfo.new(0.38,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
        Size=UDim2.new(0.88,0,0.62,0),Position=UDim2.new(0.06,0,0.19,0),BackgroundTransparency=0.06
    }):Play()
    task.delay(0.05,function() updateContent(1) end)
end

-- Launch immediately
task.defer(openLauncher)
