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
    name="22S Duels", icon="⚔️", desc="AIMBOT • AUTO BAT • COMBAT", isNew=true, kind="embed",
    code=[[
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

-- No Player Collision Logic
local lastNoclipUpdate = 0
RunService.Stepped:Connect(function()
    local now = tick()
    if now - lastNoclipUpdate < 0.1 then return end
    lastNoclipUpdate = now
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Player and p.Character then
            for _, part in ipairs(p.Character:GetDescendants()) do
                if part:IsA("BasePart") then 
                    part.CanCollide = false 
                end
            end
        end
    end
end)

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
    NormalSpeed = false,
    AntiRagdoll = false,
    AutoSteal = false,
    Unwalk = false,
    Optimizer = false,
    InfiniteJump = false,
    BatAimbot = false,
    AutoDisableSpeed = true,
    AutoWalkEnabled = false,
    AutoRightEnabled = false,
    ScriptUserESP = true,
    Float = false,
    UltraNuke = false,
    AutoPlayCountdown = false,
    AutoPlayLeft = false,
    AutoPlayRight = false,
    ReturnL = false,
    ReturnR = false
}

local Values = {
    NormalSpeed = 60,
    CarrySpeed = 30,
    STEAL_RADIUS = 20,
    STEAL_DURATION = 0.25,
    HOP_POWER = 35,
    HOP_COOLDOWN = 0.08,
    FloatHeight = 9.5,
    FreezeTime = 0.5
}

local KEYBINDS = {
    SPEED = Enum.KeyCode.V,
    INFJUMP = Enum.KeyCode.M,
    BATAIMBOT = Enum.KeyCode.X,
    NUKE = Enum.KeyCode.Q,
    AUTOLEFT = Enum.KeyCode.Z,
    AUTORIGHT = Enum.KeyCode.C,
    AUTOPLAY = Enum.KeyCode.B,
    AUTOPLAYR = Enum.KeyCode.G,
    RETURNL = Enum.KeyCode.H,
    RETURNR = Enum.KeyCode.K,
    DROPBR = Enum.KeyCode.F,
    FLOAT = Enum.KeyCode.J,
    TPDOWN = Enum.KeyCode.T
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
            if data.KEY_INFJUMP then KEYBINDS.INFJUMP = Enum.KeyCode[data.KEY_INFJUMP] end
            if data.KEY_BATAIMBOT then KEYBINDS.BATAIMBOT = Enum.KeyCode[data.KEY_BATAIMBOT] end
            if data.KEY_AUTOLEFT then KEYBINDS.AUTOLEFT = Enum.KeyCode[data.KEY_AUTOLEFT] end
            if data.KEY_AUTORIGHT then KEYBINDS.AUTORIGHT = Enum.KeyCode[data.KEY_AUTORIGHT] end
            if data.KEY_AUTOPLAY then KEYBINDS.AUTOPLAY = Enum.KeyCode[data.KEY_AUTOPLAY] end
            if data.KEY_AUTOPLAYR then KEYBINDS.AUTOPLAYR = Enum.KeyCode[data.KEY_AUTOPLAYR] end
            if data.KEY_RETURNL then KEYBINDS.RETURNL = Enum.KeyCode[data.KEY_RETURNL] end
            if data.KEY_RETURNR then KEYBINDS.RETURNR = Enum.KeyCode[data.KEY_RETURNR] end
            if data.KEY_DROPBR then KEYBINDS.DROPBR = Enum.KeyCode[data.KEY_DROPBR] end
            if data.KEY_FLOAT then KEYBINDS.FLOAT = Enum.KeyCode[data.KEY_FLOAT] end
            if data.KEY_TPDOWN then KEYBINDS.TPDOWN = Enum.KeyCode[data.KEY_TPDOWN] end
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
    data.KEY_INFJUMP = KEYBINDS.INFJUMP.Name
    data.KEY_BATAIMBOT = KEYBINDS.BATAIMBOT.Name
    data.KEY_AUTOLEFT = KEYBINDS.AUTOLEFT.Name
    data.KEY_AUTORIGHT = KEYBINDS.AUTORIGHT.Name
    data.KEY_AUTOPLAY = KEYBINDS.AUTOPLAY.Name
    data.KEY_AUTOPLAYR = KEYBINDS.AUTOPLAYR.Name
    data.KEY_RETURNL = KEYBINDS.RETURNL.Name
    data.KEY_RETURNR = KEYBINDS.RETURNR.Name
    data.KEY_DROPBR = KEYBINDS.DROPBR.Name
    data.KEY_FLOAT = KEYBINDS.FLOAT.Name
    data.KEY_TPDOWN = KEYBINDS.TPDOWN.Name
    
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

local AutoWalkEnabled = false
local AutoRightEnabled = false

-- Bat Aimbot
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
    
    -- Use RenderStepped for less delay
    Connections.batAimbot = RunService.RenderStepped:Connect(function()
        if not Enabled.BatAimbot then return end
        local c = Player.Character
        if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart")
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not h or not hum then return end
        
        local bat = findBat()
        if bat and bat.Parent ~= c then
            hum:EquipTool(bat)
        end
        
        local target, dist, torso = findNearestEnemy(h)
        aimbotTarget = torso or target
        
        if target and torso then
            local tv = target.AssemblyLinearVelocity
            local tFlat = Vector3.new(tv.X, 0, tv.Z)
            local spd = 56.5
            
            -- Aim WELL in front to compensate for network lag
            -- On their screen we appear ~0.1-0.2s behind where we are on ours
            local enemyLook = target.CFrame.LookVector
            local frontOffset = Vector3.new(enemyLook.X, 0, enemyLook.Z)
            if frontOffset.Magnitude > 0.1 then frontOffset = frontOffset.Unit * 4.5 end
            local goalPos = torso.Position + frontOffset
            
            -- If running, predict further ahead based on their speed
            if tFlat.Magnitude > 3 then
                -- Predict 0.15s into the future + extra offset in front
                goalPos = torso.Position + tFlat * 0.15 + tFlat.Unit * 4
            end
            
            local toGoal = goalPos - h.Position
            local flatToGoal = Vector3.new(toGoal.X, 0, toGoal.Z)
            local flatDist = flatToGoal.Magnitude
            
            -- Y: directly match their height
            local yDiff = torso.Position.Y - h.Position.Y
            local yVel = h.AssemblyLinearVelocity.Y
            
            -- On ground: jump if they're above or jumping
            if hum.FloorMaterial ~= Enum.Material.Air then
                if yDiff > 0.5 or tv.Y > 5 then
                    -- Direct velocity jump instead of hum.Jump (no delay)
                    yVel = math.max(55, tv.Y + 10)
                end
            else
                -- In air: aggressively track their Y
                yVel = yDiff * 20
                -- Also add their Y velocity so we move with them
                yVel = yVel + tv.Y * 0.5
                yVel = math.clamp(yVel, -100, 100)
            end
            
            -- XZ movement: pure velocity, no hum:Move
            if flatDist > 1 then
                local moveDir = flatToGoal.Unit
                local chaseSpd = math.max(spd, tFlat.Magnitude + 8)
                chaseSpd = math.min(chaseSpd, 65)
                h.AssemblyLinearVelocity = Vector3.new(moveDir.X * chaseSpd, yVel, moveDir.Z * chaseSpd)
            else
                -- Stick: match velocity + slight push in their look direction
                local look = target.CFrame.LookVector
                local pushX = tv.X + look.X * 5
                local pushZ = tv.Z + look.Z * 5
                h.AssemblyLinearVelocity = Vector3.new(pushX, yVel, pushZ)
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
    local c = Player.Character
    if c then
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum then hum.AutoRotate = true end
    end
end

-- Infinite Jump (hold space to hop in air)
local infJumpEnabled = false
local lastHopTime = 0
local spaceHeld = false

local function doMiniHop()
    if not infJumpEnabled then return end
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

local function startInfiniteJump()
    infJumpEnabled = true
end

local function stopInfiniteJump()
    infJumpEnabled = false
end

RunService.Heartbeat:Connect(function()
    if infJumpEnabled and spaceHeld then
        doMiniHop()
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

local POSITION_2 = Vector3.new(-483.12, -4.95, 94.80)
local POSITION_R2 = Vector3.new(-483.04, -5.09, 23.14)
local POSITION_L3 = Vector3.new(-475.92, -6.99, 25.36)
local POSITION_R3 = Vector3.new(-475.99, -6.99, 96.00)
local autoWalkPhase = 1
local autoRightPhase = 1
local autoPlayLeftPhase = 1
local AutoPlayLeftEnabled = false
local autoPlayLeftConnection = nil
local autoPlayRightPhase = 1
local AutoPlayRightEnabled = false
local autoPlayRightConnection = nil
-- Speed system: carry speed is always base, normal speed when toggled on
local function getCurrentSpeed()
    return Enabled.NormalSpeed and Values.NormalSpeed or Values.CarrySpeed
end

local function enableNormalSpeed()
    Enabled.NormalSpeed = true
    if VisualSetters.NormalSpeed then VisualSetters.NormalSpeed(true) end
end

-- Speed system: carry speed is always base, normal speed when toggled on
RunService.RenderStepped:Connect(function()
    if AutoWalkEnabled or AutoRightEnabled or AutoPlayLeftEnabled or AutoPlayRightEnabled or Enabled.BatAimbot then return end
    local c = Player.Character; if not c then return end
    local h = c:FindFirstChild("HumanoidRootPart"); if not h then return end
    local hum = c:FindFirstChildOfClass("Humanoid"); if not hum then return end
    local spd = getCurrentSpeed()
    local md = hum.MoveDirection
    if md.Magnitude > 0.1 then
        h.AssemblyLinearVelocity = Vector3.new(md.X * spd, h.AssemblyLinearVelocity.Y, md.Z * spd)
    end
end)

-- Coord ESP markers (subtle grey)
local coordESPFolder = Instance.new("Folder", workspace)
coordESPFolder.Name = "22s_CoordESP"

local function createCoordMarker(position, labelText, color)
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

createCoordMarker(Vector3.new(-476.48, -6.28, 92.73), "L1", Color3.fromRGB(160, 160, 160))
createCoordMarker(Vector3.new(-483.12, -4.95, 94.80), "L END", Color3.fromRGB(120, 120, 120))
createCoordMarker(Vector3.new(-476.16, -6.52, 25.62), "R1", Color3.fromRGB(160, 160, 160))
createCoordMarker(Vector3.new(-483.04, -5.09, 23.14), "R END", Color3.fromRGB(120, 120, 120))

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
    
    autoWalkConnection = RunService.RenderStepped:Connect(function()
        if not AutoWalkEnabled then
            local c = Player.Character
            if c then
                local hum = c:FindFirstChildOfClass("Humanoid")
                if hum then hum:Move(Vector3.zero, false) end
                local h = c:FindFirstChild("HumanoidRootPart")
                if h then h.AssemblyLinearVelocity = Vector3.new(0, h.AssemblyLinearVelocity.Y, 0) end
            end
            return
        end
        local c = Player.Character
        if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart")
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not h or not hum then return end
        
        if hum.WalkSpeed <= 0 then
            h.AssemblyLinearVelocity = Vector3.new(0, h.AssemblyLinearVelocity.Y, 0)
            return
        end
        
        local spd = getCurrentSpeed()
        
        if autoWalkPhase == 1 then
            local dist1 = (Vector3.new(POSITION_1.X, h.Position.Y, POSITION_1.Z) - h.Position).Magnitude
            if dist1 < 1 then
                autoWalkPhase = 2
            end
            local dir = ((autoWalkPhase == 1 and POSITION_1 or POSITION_2) - h.Position)
            local moveDir = Vector3.new(dir.X, 0, dir.Z).Unit
            h.AssemblyLinearVelocity = Vector3.new(moveDir.X * spd, h.AssemblyLinearVelocity.Y, moveDir.Z * spd)
            
        elseif autoWalkPhase == 2 then
            local dist2 = (Vector3.new(POSITION_2.X, h.Position.Y, POSITION_2.Z) - h.Position).Magnitude
            if dist2 < 1 then
                h.AssemblyLinearVelocity = Vector3.new(0, h.AssemblyLinearVelocity.Y, 0)
                AutoWalkEnabled = false
                Enabled.AutoWalkEnabled = false
                Enabled.NormalSpeed = false
                if VisualSetters.NormalSpeed then VisualSetters.NormalSpeed(false) end
                if _G.setAutoLeftVisual then _G.setAutoLeftVisual(false) end
                if VisualSetters and VisualSetters.AutoWalkEnabled then VisualSetters.AutoWalkEnabled(false, true) end
                if autoWalkConnection then autoWalkConnection:Disconnect() autoWalkConnection = nil end
                faceSouth()
                return
            end
            local dir = (POSITION_2 - h.Position)
            local moveDir = Vector3.new(dir.X, 0, dir.Z).Unit
            h.AssemblyLinearVelocity = Vector3.new(moveDir.X * spd, h.AssemblyLinearVelocity.Y, moveDir.Z * spd)
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
        local h = c:FindFirstChild("HumanoidRootPart")
        if h then h.AssemblyLinearVelocity = Vector3.new(0, h.AssemblyLinearVelocity.Y, 0) end
    end
end

local function startAutoRight()
    if autoRightConnection then autoRightConnection:Disconnect() end
    autoRightPhase = 1
    
    autoRightConnection = RunService.RenderStepped:Connect(function()
        if not AutoRightEnabled then return end
        local c = Player.Character
        if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart")
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not h or not hum then return end
        
        if hum.WalkSpeed <= 0 then
            h.AssemblyLinearVelocity = Vector3.new(0, h.AssemblyLinearVelocity.Y, 0)
            return
        end
        
        local spd = getCurrentSpeed()
        
        if autoRightPhase == 1 then
            local distR1 = (Vector3.new(POSITION_R1.X, h.Position.Y, POSITION_R1.Z) - h.Position).Magnitude
            if distR1 < 1 then
                autoRightPhase = 2
            end
            local dir = ((autoRightPhase == 1 and POSITION_R1 or POSITION_R2) - h.Position)
            local moveDir = Vector3.new(dir.X, 0, dir.Z).Unit
            h.AssemblyLinearVelocity = Vector3.new(moveDir.X * spd, h.AssemblyLinearVelocity.Y, moveDir.Z * spd)
            
        elseif autoRightPhase == 2 then
            local distR2 = (Vector3.new(POSITION_R2.X, h.Position.Y, POSITION_R2.Z) - h.Position).Magnitude
            if distR2 < 1 then
                h.AssemblyLinearVelocity = Vector3.new(0, h.AssemblyLinearVelocity.Y, 0)
                AutoRightEnabled = false
                Enabled.AutoRightEnabled = false
                Enabled.NormalSpeed = false
                if VisualSetters.NormalSpeed then VisualSetters.NormalSpeed(false) end
                if _G.setAutoRightVisual then _G.setAutoRightVisual(false) end
                if VisualSetters and VisualSetters.AutoRightEnabled then VisualSetters.AutoRightEnabled(false, true) end
                if autoRightConnection then autoRightConnection:Disconnect() autoRightConnection = nil end
                faceNorth()
                return
            end
            local dir = (POSITION_R2 - h.Position)
            local moveDir = Vector3.new(dir.X, 0, dir.Z).Unit
            h.AssemblyLinearVelocity = Vector3.new(moveDir.X * spd, h.AssemblyLinearVelocity.Y, moveDir.Z * spd)
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
        local h = c:FindFirstChild("HumanoidRootPart")
        if h then h.AssemblyLinearVelocity = Vector3.new(0, h.AssemblyLinearVelocity.Y, 0) end
    end
end


-- Auto Play Left: POSITION_1 -> POSITION_2 -> freeze -> POSITION_1 -> L3 -> stop
local function startAutoPlayLeft()
    if autoPlayLeftConnection then autoPlayLeftConnection:Disconnect() end
    autoPlayLeftPhase = 1
    
    autoPlayLeftConnection = RunService.RenderStepped:Connect(function()
        if not AutoPlayLeftEnabled then return end
        local c = Player.Character
        if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart")
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not h or not hum then return end
        
        if hum.WalkSpeed <= 0 then
            hum:Move(Vector3.zero, false)
            h.AssemblyLinearVelocity = Vector3.new(0, h.AssemblyLinearVelocity.Y, 0)
            return
        end
        
        local spd = getCurrentSpeed()
        
        -- Phase 1: Go to POSITION_1
        if autoPlayLeftPhase == 1 then
            local targetPos = Vector3.new(POSITION_1.X, h.Position.Y, POSITION_1.Z)
            local dist = (targetPos - h.Position).Magnitude
            if dist < 1 then
                autoPlayLeftPhase = 2
                local dir = (POSITION_2 - h.Position)
                local moveDir = Vector3.new(dir.X, 0, dir.Z).Unit
                hum:Move(moveDir, false)
                h.AssemblyLinearVelocity = Vector3.new(moveDir.X * spd, h.AssemblyLinearVelocity.Y, moveDir.Z * spd)
                return
            end
            local dir = (POSITION_1 - h.Position)
            local moveDir = Vector3.new(dir.X, 0, dir.Z).Unit
            hum:Move(moveDir, false)
            h.AssemblyLinearVelocity = Vector3.new(moveDir.X * spd, h.AssemblyLinearVelocity.Y, moveDir.Z * spd)
        
        -- Phase 2: Go to POSITION_2
        elseif autoPlayLeftPhase == 2 then
            local targetPos = Vector3.new(POSITION_2.X, h.Position.Y, POSITION_2.Z)
            local dist = (targetPos - h.Position).Magnitude
            if dist < 1 then
                -- Arrived at POSITION_2 - freeze
                hum:Move(Vector3.zero, false)
                h.AssemblyLinearVelocity = Vector3.new(0, h.AssemblyLinearVelocity.Y, 0)
                Enabled.NormalSpeed = false
                if VisualSetters.NormalSpeed then VisualSetters.NormalSpeed(false) end
                autoPlayLeftPhase = 0
                if autoPlayLeftConnection then autoPlayLeftConnection:Disconnect() autoPlayLeftConnection = nil end
                task.spawn(function()
                    task.wait(Values.FreezeTime)
                    if not AutoPlayLeftEnabled then return end
                    autoPlayLeftPhase = 3
                    autoPlayLeftConnection = RunService.RenderStepped:Connect(function()
                        if not AutoPlayLeftEnabled then return end
                        local c2 = Player.Character
                        if not c2 then return end
                        local h2 = c2:FindFirstChild("HumanoidRootPart")
                        local hum2 = c2:FindFirstChildOfClass("Humanoid")
                        if not h2 or not hum2 then return end
                        
                        if hum2.WalkSpeed <= 0 then
                            hum2:Move(Vector3.zero, false)
                            h2.AssemblyLinearVelocity = Vector3.new(0, h2.AssemblyLinearVelocity.Y, 0)
                            return
                        end
                        
                        local spd2 = getCurrentSpeed()
                        
                        -- Phase 3: Go back to POSITION_1
                        if autoPlayLeftPhase == 3 then
                            local tp = Vector3.new(POSITION_1.X, h2.Position.Y, POSITION_1.Z)
                            local d = (tp - h2.Position).Magnitude
                            if d < 1 then
                                autoPlayLeftPhase = 4
                                local dir2 = (POSITION_L3 - h2.Position)
                                local md2 = Vector3.new(dir2.X, 0, dir2.Z).Unit
                                hum2:Move(md2, false)
                                h2.AssemblyLinearVelocity = Vector3.new(md2.X * spd2, h2.AssemblyLinearVelocity.Y, md2.Z * spd2)
                                return
                            end
                            local dir2 = (POSITION_1 - h2.Position)
                            local md2 = Vector3.new(dir2.X, 0, dir2.Z).Unit
                            hum2:Move(md2, false)
                            h2.AssemblyLinearVelocity = Vector3.new(md2.X * spd2, h2.AssemblyLinearVelocity.Y, md2.Z * spd2)
                        
                        -- Phase 4: Go to L3
                        elseif autoPlayLeftPhase == 4 then
                            local tp = Vector3.new(POSITION_L3.X, h2.Position.Y, POSITION_L3.Z)
                            local d = (tp - h2.Position).Magnitude
                            if d < 1 then
                                hum2:Move(Vector3.zero, false)
                                h2.AssemblyLinearVelocity = Vector3.new(0, h2.AssemblyLinearVelocity.Y, 0)
                                AutoPlayLeftEnabled = false
                                Enabled.AutoPlayLeft = false
                                Enabled.NormalSpeed = false
                                if VisualSetters.NormalSpeed then VisualSetters.NormalSpeed(false) end
                                if VisualSetters.AutoPlayLeft then VisualSetters.AutoPlayLeft(false) end
                                if autoPlayLeftConnection then autoPlayLeftConnection:Disconnect() autoPlayLeftConnection = nil end
                                faceSouth()
                                return
                            end
                            local dir2 = (POSITION_L3 - h2.Position)
                            local md2 = Vector3.new(dir2.X, 0, dir2.Z).Unit
                            hum2:Move(md2, false)
                            h2.AssemblyLinearVelocity = Vector3.new(md2.X * spd2, h2.AssemblyLinearVelocity.Y, md2.Z * spd2)
                        end
                    end)
                end)
                return
            end
            local dir = (POSITION_2 - h.Position)
            local moveDir = Vector3.new(dir.X, 0, dir.Z).Unit
            hum:Move(moveDir, false)
            h.AssemblyLinearVelocity = Vector3.new(moveDir.X * spd, h.AssemblyLinearVelocity.Y, moveDir.Z * spd)
        end
    end)
end

local function stopAutoPlayLeft()
    AutoPlayLeftEnabled = false
    Enabled.AutoPlayLeft = false
    autoPlayLeftPhase = 1
    if autoPlayLeftConnection then autoPlayLeftConnection:Disconnect() autoPlayLeftConnection = nil end
    local c = Player.Character
    if c then
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum then hum:Move(Vector3.zero, false) end
    end
end

-- Auto Play Right: POSITION_R1 -> POSITION_R2 -> freeze -> POSITION_R1 -> R3 -> stop
local function startAutoPlayRight()
    if autoPlayRightConnection then autoPlayRightConnection:Disconnect() end
    autoPlayRightPhase = 1
    
    autoPlayRightConnection = RunService.RenderStepped:Connect(function()
        if not AutoPlayRightEnabled then return end
        local c = Player.Character
        if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart")
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not h or not hum then return end
        
        if hum.WalkSpeed <= 0 then
            hum:Move(Vector3.zero, false)
            h.AssemblyLinearVelocity = Vector3.new(0, h.AssemblyLinearVelocity.Y, 0)
            return
        end
        
        local spd = getCurrentSpeed()
        
        -- Phase 1: Go to POSITION_R1
        if autoPlayRightPhase == 1 then
            local targetPos = Vector3.new(POSITION_R1.X, h.Position.Y, POSITION_R1.Z)
            local dist = (targetPos - h.Position).Magnitude
            if dist < 1 then
                autoPlayRightPhase = 2
                local dir = (POSITION_R2 - h.Position)
                local moveDir = Vector3.new(dir.X, 0, dir.Z).Unit
                hum:Move(moveDir, false)
                h.AssemblyLinearVelocity = Vector3.new(moveDir.X * spd, h.AssemblyLinearVelocity.Y, moveDir.Z * spd)
                return
            end
            local dir = (POSITION_R1 - h.Position)
            local moveDir = Vector3.new(dir.X, 0, dir.Z).Unit
            hum:Move(moveDir, false)
            h.AssemblyLinearVelocity = Vector3.new(moveDir.X * spd, h.AssemblyLinearVelocity.Y, moveDir.Z * spd)
        
        -- Phase 2: Go to POSITION_R2
        elseif autoPlayRightPhase == 2 then
            local targetPos = Vector3.new(POSITION_R2.X, h.Position.Y, POSITION_R2.Z)
            local dist = (targetPos - h.Position).Magnitude
            if dist < 1 then
                hum:Move(Vector3.zero, false)
                h.AssemblyLinearVelocity = Vector3.new(0, h.AssemblyLinearVelocity.Y, 0)
                Enabled.NormalSpeed = false
                if VisualSetters.NormalSpeed then VisualSetters.NormalSpeed(false) end
                autoPlayRightPhase = 0
                if autoPlayRightConnection then autoPlayRightConnection:Disconnect() autoPlayRightConnection = nil end
                task.spawn(function()
                    task.wait(Values.FreezeTime)
                    if not AutoPlayRightEnabled then return end
                    autoPlayRightPhase = 3
                    autoPlayRightConnection = RunService.RenderStepped:Connect(function()
                        if not AutoPlayRightEnabled then return end
                        local c2 = Player.Character
                        if not c2 then return end
                        local h2 = c2:FindFirstChild("HumanoidRootPart")
                        local hum2 = c2:FindFirstChildOfClass("Humanoid")
                        if not h2 or not hum2 then return end
                        
                        if hum2.WalkSpeed <= 0 then
                            hum2:Move(Vector3.zero, false)
                            h2.AssemblyLinearVelocity = Vector3.new(0, h2.AssemblyLinearVelocity.Y, 0)
                            return
                        end
                        
                        local spd2 = getCurrentSpeed()
                        
                        -- Phase 3: Go back to POSITION_R1
                        if autoPlayRightPhase == 3 then
                            local tp = Vector3.new(POSITION_R1.X, h2.Position.Y, POSITION_R1.Z)
                            local d = (tp - h2.Position).Magnitude
                            if d < 1 then
                                autoPlayRightPhase = 4
                                local dir2 = (POSITION_R3 - h2.Position)
                                local md2 = Vector3.new(dir2.X, 0, dir2.Z).Unit
                                hum2:Move(md2, false)
                                h2.AssemblyLinearVelocity = Vector3.new(md2.X * spd2, h2.AssemblyLinearVelocity.Y, md2.Z * spd2)
                                return
                            end
                            local dir2 = (POSITION_R1 - h2.Position)
                            local md2 = Vector3.new(dir2.X, 0, dir2.Z).Unit
                            hum2:Move(md2, false)
                            h2.AssemblyLinearVelocity = Vector3.new(md2.X * spd2, h2.AssemblyLinearVelocity.Y, md2.Z * spd2)
                        
                        -- Phase 4: Go to R3
                        elseif autoPlayRightPhase == 4 then
                            local tp = Vector3.new(POSITION_R3.X, h2.Position.Y, POSITION_R3.Z)
                            local d = (tp - h2.Position).Magnitude
                            if d < 1 then
                                hum2:Move(Vector3.zero, false)
                                h2.AssemblyLinearVelocity = Vector3.new(0, h2.AssemblyLinearVelocity.Y, 0)
                                AutoPlayRightEnabled = false
                                Enabled.AutoPlayRight = false
                                Enabled.NormalSpeed = false
                                if VisualSetters.NormalSpeed then VisualSetters.NormalSpeed(false) end
                                if VisualSetters.AutoPlayRight then VisualSetters.AutoPlayRight(false) end
                                if autoPlayRightConnection then autoPlayRightConnection:Disconnect() autoPlayRightConnection = nil end
                                faceNorth()
                                return
                            end
                            local dir2 = (POSITION_R3 - h2.Position)
                            local md2 = Vector3.new(dir2.X, 0, dir2.Z).Unit
                            hum2:Move(md2, false)
                            h2.AssemblyLinearVelocity = Vector3.new(md2.X * spd2, h2.AssemblyLinearVelocity.Y, md2.Z * spd2)
                        end
                    end)
                end)
                return
            end
            local dir = (POSITION_R2 - h.Position)
            local moveDir = Vector3.new(dir.X, 0, dir.Z).Unit
            hum:Move(moveDir, false)
            h.AssemblyLinearVelocity = Vector3.new(moveDir.X * spd, h.AssemblyLinearVelocity.Y, moveDir.Z * spd)
        end
    end)
end

local function stopAutoPlayRight()
    AutoPlayRightEnabled = false
    Enabled.AutoPlayRight = false
    autoPlayRightPhase = 1
    if autoPlayRightConnection then autoPlayRightConnection:Disconnect() autoPlayRightConnection = nil end
    local c = Player.Character
    if c then
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum then hum:Move(Vector3.zero, false) end
    end
end


-- ============================================
-- BRAINROT RETURN (teleport back when hit/ragdolled)
-- ============================================
local RETURN_LEFT_1  = Vector3.new(-474.9, -7.0, 94.9)
local RETURN_RIGHT_1 = Vector3.new(-474.9, -7.0, 24.1)
-- Step 2 reuses POSITION_2 and POSITION_R2

local ReturnState = {
    leftEnabled = false,
    rightEnabled = false,
    cooldown = false,
    lastKnownHealth = 100,
}


local function doReturnTeleport(step1, step2)
    if ReturnState.cooldown then return end
    ReturnState.cooldown = true
    task.spawn(function()
        pcall(function()
            local c = Player.Character
            if not c then return end
            local root = c:FindFirstChild("HumanoidRootPart")
            local hum = c:FindFirstChildOfClass("Humanoid")
            if not root then return end

            for _, obj in ipairs(c:GetDescendants()) do
                if obj:IsA("Motor6D") then obj.Enabled = true end
            end
            if hum then hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
            task.wait(0.20)

            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
            root.CFrame = CFrame.new(step1 + Vector3.new(0, 3, 0))
            task.wait(0.20)

            root.AssemblyLinearVelocity = Vector3.zero
            root.CFrame = CFrame.new(step2 + Vector3.new(0, 3, 0))

            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Running)
                hum:Move(Vector3.zero, false)
            end
            for _, obj in ipairs(c:GetDescendants()) do
                if obj:IsA("Motor6D") then obj.Enabled = true end
            end
        end)
        
        -- Reset health tracking after teleport
        local _c = Player.Character
        local _hum = _c and _c:FindFirstChildOfClass("Humanoid")
        if _hum then ReturnState.lastKnownHealth = _hum.Health end
        
        -- Show 3 second timer
        if ReturnState.timerLabel then
            ReturnState.timerLabel.Visible = true
            for i = 3, 1, -1 do
                if ReturnState.timerLabel then
                    ReturnState.timerLabel.Text = tostring(i)
                end
                task.wait(1)
            end
            if ReturnState.timerLabel then
                ReturnState.timerLabel.Visible = false
            end
        end
        
        ReturnState.cooldown = false
    end)
end

Connections.brainrotReturn = RunService.Heartbeat:Connect(function()
    if not (ReturnState.leftEnabled or ReturnState.rightEnabled) then return end
    if ReturnState.cooldown then return end

    local char = Player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local hrpR = char:FindFirstChild("HumanoidRootPart")
    if not hrpR then return end
    
    -- Skip if game has frozen us (anchored)
    if hrpR.Anchored then ReturnState.lastKnownHealth = hum.Health; return end

    local currentHealth = hum.Health
    
    -- Skip if dead
    if currentHealth <= 0 then ReturnState.lastKnownHealth = 0; return end
    
    -- Check for bat hit (health drop)
    local wasHit = currentHealth < ReturnState.lastKnownHealth - 1
    
    -- Check for ragdoll (game can ragdoll without health drop)
    local st = hum:GetState()
    local isRag = (st == Enum.HumanoidStateType.Physics or st == Enum.HumanoidStateType.Ragdoll or st == Enum.HumanoidStateType.FallingDown) and currentHealth > 0
    
    ReturnState.lastKnownHealth = currentHealth

    if not (wasHit or isRag) then return end

    if ReturnState.leftEnabled then
        doReturnTeleport(RETURN_LEFT_1, POSITION_2)
    elseif ReturnState.rightEnabled then
        doReturnTeleport(RETURN_RIGHT_1, POSITION_R2)
    end
end)

Player.CharacterAdded:Connect(function(char)
    task.wait(1)
    ReturnState.lastKnownHealth = 100
    ReturnState.cooldown = false
    local hum = char:WaitForChild("Humanoid", 5)
    if hum then ReturnState.lastKnownHealth = hum.Health end
end)

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

-- Auto Steal (cached, fast)
local ProgressBarFill, ProgressLabel, ProgressPercentLabel, RadiusInput
local stealStartTime = nil
local progressConnection = nil

local DISCORD_TEXT = "discord.gg/22s"

local function getDiscordProgress(percent)
    local totalChars = #DISCORD_TEXT
    local adjustedPercent = math.min(percent * 1.5, 100)
    local charsToShow = math.floor((adjustedPercent / 100) * totalChars)
    return string.sub(DISCORD_TEXT, 1, charsToShow)
end

local StealState = {
    isStealing = false,
    lastStealTick = 0,
    data = {},
    plotCache = {},
    plotCacheTime = {},
    cachedPrompts = {},
    promptCacheTime = 0,
}
isStealing = false

local PLOT_CACHE_DURATION = 2
local PROMPT_CACHE_REFRESH = 0.15
local STEAL_COOLDOWN = 0.1

local function isMyPlotByName(plotName)
    local ct = tick()
    if StealState.plotCache[plotName] and (ct - (StealState.plotCacheTime[plotName] or 0)) < PLOT_CACHE_DURATION then
        return StealState.plotCache[plotName]
    end
    local plots = workspace:FindFirstChild("Plots")
    if not plots then
        StealState.plotCache[plotName] = false
        StealState.plotCacheTime[plotName] = ct
        return false
    end
    local plot = plots:FindFirstChild(plotName)
    if not plot then
        StealState.plotCache[plotName] = false
        StealState.plotCacheTime[plotName] = ct
        return false
    end
    local sign = plot:FindFirstChild("PlotSign")
    if sign then
        local yb = sign:FindFirstChild("YourBase")
        if yb and yb:IsA("BillboardGui") then
            local r = yb.Enabled == true
            StealState.plotCache[plotName] = r
            StealState.plotCacheTime[plotName] = ct
            return r
        end
    end
    StealState.plotCache[plotName] = false
    StealState.plotCacheTime[plotName] = ct
    return false
end

local function findNearestPrompt()
    local char = Player.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    local ct = tick()
    if ct - StealState.promptCacheTime < PROMPT_CACHE_REFRESH and #StealState.cachedPrompts > 0 then
        local np, nd, nn = nil, math.huge, nil
        for _, d in ipairs(StealState.cachedPrompts) do
            if d.spawn then
                local dist = (d.spawn.Position - root.Position).Magnitude
                if dist <= Values.STEAL_RADIUS and dist < nd then
                    np = d.prompt
                    nd = dist
                    nn = d.name
                end
            end
        end
        if np then return np, nd, nn end
    end

    StealState.cachedPrompts = {}
    StealState.promptCacheTime = ct
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil end
    local np, nd, nn = nil, math.huge, nil

    for _, plot in ipairs(plots:GetChildren()) do
        if isMyPlotByName(plot.Name) then continue end
        local pods = plot:FindFirstChild("AnimalPodiums")
        if not pods then continue end
        for _, pod in ipairs(pods:GetChildren()) do
            pcall(function()
                local base = pod:FindFirstChild("Base")
                local sp = base and base:FindFirstChild("Spawn")
                if sp then
                    local att = sp:FindFirstChild("PromptAttachment")
                    if att then
                        for _, child in ipairs(att:GetChildren()) do
                            if child:IsA("ProximityPrompt") then
                                local dist = (sp.Position - root.Position).Magnitude
                                table.insert(StealState.cachedPrompts, { prompt = child, spawn = sp, name = pod.Name })
                                if dist <= Values.STEAL_RADIUS and dist < nd then
                                    np = child
                                    nd = dist
                                    nn = pod.Name
                                end
                                break
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
    local ct = tick()
    if ct - StealState.lastStealTick < STEAL_COOLDOWN then return end
    if StealState.isStealing then return end

    if not StealState.data[prompt] then
        StealState.data[prompt] = { hold = {}, trigger = {}, ready = true }
        pcall(function()
            if getconnections then
                for _, c in ipairs(getconnections(prompt.PromptButtonHoldBegan)) do
                    if c.Function then table.insert(StealState.data[prompt].hold, c.Function) end
                end
                for _, c in ipairs(getconnections(prompt.Triggered)) do
                    if c.Function then table.insert(StealState.data[prompt].trigger, c.Function) end
                end
            else
                StealState.data[prompt].noConnections = true
            end
        end)
    end

    local data = StealState.data[prompt]
    if not data.ready then return end
    data.ready = false
    StealState.isStealing = true
    isStealing = true
    StealState.lastStealTick = ct
    stealStartTime = tick()
    if ProgressLabel then ProgressLabel.Text = name or "STEALING..." end
    if progressConnection then progressConnection:Disconnect() end
    progressConnection = RunService.Heartbeat:Connect(function()
        if not StealState.isStealing then progressConnection:Disconnect() return end
        local prog = math.clamp((tick() - stealStartTime) / Values.STEAL_DURATION, 0, 1)
        if ProgressBarFill then ProgressBarFill.Size = UDim2.new(prog, 0, 1, 0) end
        if ProgressPercentLabel then
            local percent = math.floor(prog * 100)
            ProgressPercentLabel.Text = getDiscordProgress(percent)
        end
    end)

    task.spawn(function()
        pcall(function()
            for _, fn in ipairs(data.hold) do task.spawn(fn) end
            task.wait(Values.STEAL_DURATION)
            for _, fn in ipairs(data.trigger) do task.spawn(fn) end
        end)

        task.wait(Values.STEAL_DURATION * 0.3)
        if progressConnection then progressConnection:Disconnect() end
        ResetProgressBar()
        data.ready = true
        StealState.isStealing = false
        isStealing = false
    end)
end

local function startAutoSteal()
    if Connections.autoSteal then return end
    Connections.autoSteal = RunService.Heartbeat:Connect(function()
        if not Enabled.AutoSteal or StealState.isStealing then return end
        local p, _, n = findNearestPrompt()
        if p then executeSteal(p, n) end
    end)
end

local function stopAutoSteal()
    if Connections.autoSteal then
        Connections.autoSteal:Disconnect()
        Connections.autoSteal = nil
    end
    StealState.isStealing = false
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

-- ============================================
-- DROP BRAINROT (launch up briefly, snap back to ground)
-- ============================================
local dropBrainrotActive = false

local function runDropBrainrot()
    if dropBrainrotActive then return end
    local char = Player.Character; if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
    dropBrainrotActive = true
    local t0 = tick()
    local dc
    dc = RunService.Heartbeat:Connect(function()
        local r = char and char:FindFirstChild("HumanoidRootPart")
        if not r then dc:Disconnect(); dropBrainrotActive = false; return end
        if tick() - t0 >= 0.2 then
            dc:Disconnect()
            local rp = RaycastParams.new()
            rp.FilterDescendantsInstances = {char}
            rp.FilterType = Enum.RaycastFilterType.Exclude
            local rr = workspace:Raycast(r.Position, Vector3.new(0, -2000, 0), rp)
            if rr then
                local hum = char:FindFirstChildOfClass("Humanoid")
                local off = (hum and hum.HipHeight or 2) + (r.Size.Y / 2)
                r.CFrame = CFrame.new(r.Position.X, rr.Position.Y + off, r.Position.Z)
                r.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end
            dropBrainrotActive = false
            return
        end
        r.AssemblyLinearVelocity = Vector3.new(r.AssemblyLinearVelocity.X, 150, r.AssemblyLinearVelocity.Z)
    end)
end

-- ============================================
-- MEDUSA COUNTER (auto-use medusa when stoned)
-- ============================================
local MEDUSA_COOLDOWN = 25
local medusaLastUsed = 0
local medusaDebounce = false
local medusaCounterEnabled = false
local medusaAnchorConns = {}

local function findMedusa()
    local char = Player.Character; if not char then return nil end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            local tn = tool.Name:lower()
            if tn:find("medusa") or tn:find("head") or tn:find("stone") then return tool end
        end
    end
    local bp = Player:FindFirstChild("Backpack")
    if bp then
        for _, tool in ipairs(bp:GetChildren()) do
            if tool:IsA("Tool") then
                local tn = tool.Name:lower()
                if tn:find("medusa") or tn:find("head") or tn:find("stone") then return tool end
            end
        end
    end
    return nil
end

local function useMedusaCounter()
    if medusaDebounce then return end
    if tick() - medusaLastUsed < MEDUSA_COOLDOWN then return end
    local char = Player.Character; if not char then return end
    medusaDebounce = true
    local med = findMedusa()
    if not med then medusaDebounce = false; return end
    if med.Parent ~= char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum:EquipTool(med) end
    end
    pcall(function() med:Activate() end)
    medusaLastUsed = tick(); medusaDebounce = false
end

local function stopMedusaCounter()
    for _, c in pairs(medusaAnchorConns) do pcall(function() c:Disconnect() end) end
    medusaAnchorConns = {}
end

local function setupMedusaCounter(char)
    stopMedusaCounter(); if not char then return end
    local function onAnchorChanged(part)
        return part:GetPropertyChangedSignal("Anchored"):Connect(function()
            if medusaCounterEnabled and part.Anchored and part.Transparency == 1 then
                useMedusaCounter()
            end
        end)
    end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then table.insert(medusaAnchorConns, onAnchorChanged(part)) end
    end
    table.insert(medusaAnchorConns, char.DescendantAdded:Connect(function(part)
        if part:IsA("BasePart") then table.insert(medusaAnchorConns, onAnchorChanged(part)) end
    end))
end

-- ============================================
-- TP DOWN (raycast to ground and teleport)
-- ============================================
local function runTPDown()
    pcall(function()
        local c = Player.Character; if not c then return end
        local hrp = c:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        local hum = c:FindFirstChildOfClass("Humanoid"); if not hum then return end
        local rp = RaycastParams.new()
        rp.FilterDescendantsInstances = {c}
        rp.FilterType = Enum.RaycastFilterType.Exclude
        local hit = workspace:Raycast(hrp.Position, Vector3.new(0, -500, 0), rp)
        if hit then
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
            local hh = hum.HipHeight or 2
            local hy = hrp.Size.Y / 2
            hrp.CFrame = CFrame.new(hit.Position.X, hit.Position.Y + hh + hy + 0.1, hit.Position.Z)
            hrp.AssemblyLinearVelocity = Vector3.zero
        end
    end)
end

-- ============================================
-- FLOAT (hover at set height above ground)
-- ============================================
local function startFloat()
    if Connections.float then Connections.float:Disconnect() end
    Connections.float = RunService.Heartbeat:Connect(function()
        if not Enabled.Float then return end
        local char = Player.Character; if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
        local rp = RaycastParams.new()
        rp.FilterDescendantsInstances = {char}
        rp.FilterType = Enum.RaycastFilterType.Exclude
        local rr = workspace:Raycast(root.Position, Vector3.new(0, -200, 0), rp)
        if rr then
            local diff = (rr.Position.Y + Values.FloatHeight) - root.Position.Y
            if math.abs(diff) > 0.3 then
                root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, diff * 15, root.AssemblyLinearVelocity.Z)
            else
                root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, 0, root.AssemblyLinearVelocity.Z)
            end
        end
    end)
end

local function stopFloat()
    if Connections.float then Connections.float:Disconnect(); Connections.float = nil end
    local char = Player.Character
    if char then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, 0, root.AssemblyLinearVelocity.Z) end
    end
end

-- ============================================
-- ULTRA NUKE (anti lag + remove accessories + ultra rendering)
-- ============================================
local ultraNukeActive = false

local function enableUltraNuke()
    ultraNukeActive = true
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        Lighting.GlobalShadows = false
        Lighting.Brightness = 1
        Lighting.FogEnd = 9e9
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
    end)
    -- Disable lighting effects
    for _, e in pairs(Lighting:GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect")
            or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then e.Enabled = false end
    end
    -- Process all workspace objects
    for _, obj in ipairs(workspace:GetDescendants()) do
        pcall(function()
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Fire") then
                obj.Enabled = false
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj:Destroy()
            elseif obj:IsA("BasePart") then
                obj.Material = Enum.Material.Plastic
                obj.Reflectance = 0
                obj.CastShadow = false
            end
        end)
    end
    -- Remove accessories from all players
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            for _, obj in ipairs(p.Character:GetDescendants()) do
                if obj:IsA("Accessory") or obj:IsA("Hat") then pcall(function() obj:Destroy() end) end
            end
        end
    end
    -- Watch for new objects
    if Connections.ultraNuke then Connections.ultraNuke:Disconnect() end
    Connections.ultraNuke = workspace.DescendantAdded:Connect(function(obj)
        if not ultraNukeActive then return end
        pcall(function()
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Fire") then
                obj.Enabled = false
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj:Destroy()
            elseif obj:IsA("BasePart") then
                obj.Material = Enum.Material.Plastic; obj.Reflectance = 0; obj.CastShadow = false
            elseif obj:IsA("Accessory") or obj:IsA("Hat") then
                obj:Destroy()
            end
        end)
    end)
end

local function disableUltraNuke()
    ultraNukeActive = false
    if Connections.ultraNuke then Connections.ultraNuke:Disconnect(); Connections.ultraNuke = nil end
end

-- ============================================
-- AUTO PLAY AFTER COUNTDOWN
-- ============================================
local SPAWN_Z_RIGHT_THRESHOLD = 60
local G_myPlotSide = nil

local function detectMyPlotSide()
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil end
    local myName = Player.DisplayName or Player.Name
    for _, plot in ipairs(plots:GetChildren()) do
        local ok, result = pcall(function()
            local sign = plot:FindFirstChild("PlotSign"); if not sign then return nil end
            local sg = sign:FindFirstChild("SurfaceGui"); if not sg then return nil end
            local fr = sg:FindFirstChild("Frame"); if not fr then return nil end
            local tl = fr:FindFirstChild("TextLabel"); if not tl then return nil end
            if tl.Text:find(myName, 1, true) then
                local spawnObj = plot:FindFirstChild("Spawn")
                if spawnObj then
                    return spawnObj.CFrame.Position.Z < SPAWN_Z_RIGHT_THRESHOLD and "left" or "right"
                end
            end
            return nil
        end)
        if ok and result then return result end
    end
    return nil
end

local function refreshMyPlotSide()
    G_myPlotSide = detectMyPlotSide()
    return G_myPlotSide
end

-- Poll plot side every 2 seconds (always, so side is ready)
task.spawn(function()
    while true do
        refreshMyPlotSide()
        task.wait(2)
    end
end)

-- Watch plot signs for changes
task.spawn(function()
    local plots = workspace:WaitForChild("Plots", 30); if not plots then return end
    local myName = Player.DisplayName or Player.Name
    local function watchPlot(plot)
        pcall(function()
            local tl = plot:WaitForChild("PlotSign",5):WaitForChild("SurfaceGui",5):WaitForChild("Frame",5):WaitForChild("TextLabel",5)
            if not tl then return end
            tl:GetPropertyChangedSignal("Text"):Connect(function() refreshMyPlotSide() end)
            if tl.Text:find(myName, 1, true) then refreshMyPlotSide() end
        end)
    end
    for _, plot in ipairs(plots:GetChildren()) do task.spawn(watchPlot, plot) end
    plots.ChildAdded:Connect(function(plot) task.spawn(watchPlot, plot) end)
end)

local _lastCountdownSnd = nil
local _lastCountdownTrigger = 0

local function monitorCountdown(snd)
    if not snd or not snd:IsA("Sound") or snd.Name ~= "Countdown" then return end
    if not Enabled.AutoPlayCountdown then return end
    if _lastCountdownSnd == snd then return end
    
    -- Only monitor if the sound is near us (within 40 studs)
    local char = Player.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp and snd.Parent and snd.Parent:IsA("BasePart") then
            if (snd.Parent.Position - hrp.Position).Magnitude > 40 then return end
        end
    end
    
    _lastCountdownSnd = snd
    
    local triggered, conn = false, nil
    conn = RunService.Heartbeat:Connect(function()
        if not Enabled.AutoPlayCountdown then
            if conn then conn:Disconnect(); conn = nil end; return
        end
        if not snd or not snd.Parent or not snd.Playing then
            _lastCountdownSnd = nil
            if conn then conn:Disconnect(); conn = nil end; return
        end
        local ct = snd.TimePosition
        if ct >= 4.5 and not triggered then
            triggered = true
            _lastCountdownSnd = nil
            if conn then conn:Disconnect(); conn = nil end
            -- Cooldown: don't trigger again within 15 seconds
            if tick() - _lastCountdownTrigger < 15 then return end
            _lastCountdownTrigger = tick()
            -- Don't override if any auto is already running
            if AutoWalkEnabled or AutoRightEnabled or AutoPlayLeftEnabled or AutoPlayRightEnabled or Enabled.BatAimbot then return end
            -- Fresh side detection at trigger time (not cached)
            local side = refreshMyPlotSide()
            if not side then return end
            -- Only trigger if near MY plot
            local char = Player.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local plots = workspace:FindFirstChild("Plots")
            if not plots then return end
            local myName = Player.DisplayName or Player.Name
            local nearMyPlot = false
            for _, plot in ipairs(plots:GetChildren()) do
                local ok, ismine = pcall(function()
                    local sign = plot:FindFirstChild("PlotSign")
                    if not sign then return false end
                    local sg = sign:FindFirstChild("SurfaceGui")
                    if not sg then return false end
                    local fr = sg:FindFirstChild("Frame")
                    if not fr then return false end
                    local tl = fr:FindFirstChild("TextLabel")
                    if not tl then return false end
                    if not tl.Text:find(myName, 1, true) then return false end
                    local spawn = plot:FindFirstChild("Spawn")
                    if spawn and (spawn.Position - hrp.Position).Magnitude < 25 then
                        return true
                    end
                    return false
                end)
                if ok and ismine then nearMyPlot = true; break end
            end
            if not nearMyPlot then return end
            -- Start opposite side auto play
            if side == "left" then
                AutoPlayRightEnabled = true; Enabled.AutoPlayRight = true
                if VisualSetters.AutoPlayRight then VisualSetters.AutoPlayRight(true) end
                enableNormalSpeed()
                startAutoPlayRight()
            elseif side == "right" then
                AutoPlayLeftEnabled = true; Enabled.AutoPlayLeft = true
                if VisualSetters.AutoPlayLeft then VisualSetters.AutoPlayLeft(true) end
                enableNormalSpeed()
                startAutoPlayLeft()
            end
        end
        if ct > 6.5 then _lastCountdownSnd = nil; if conn then conn:Disconnect(); conn = nil end end
    end)
end

workspace.ChildAdded:Connect(function(child)
    if Enabled.AutoPlayCountdown and child.Name == "Countdown" and child:IsA("Sound") then monitorCountdown(child) end
end)
do local ex = workspace:FindFirstChild("Countdown"); if ex and ex:IsA("Sound") then monitorCountdown(ex) end end

-- ============================================
-- RACE PREDICTOR GUI
-- ============================================
local RACE_MY_TARGET = Vector3.new(-476.37, -6.65, 29.13)
local RACE_ENEMY_TARGET = Vector3.new(-476.19, -6.51, 92.35)

local raceGui = Instance.new("ScreenGui")
raceGui.Name = "RacePredictor"
raceGui.ResetOnSpawn = false
raceGui.Parent = Player:WaitForChild("PlayerGui")

local raceFrame = Instance.new("Frame", raceGui)
raceFrame.Size = UDim2.new(0, 70, 0, 70)
raceFrame.Position = UDim2.new(0, 12, 0.5, -35)
raceFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
raceFrame.BorderSizePixel = 0
Instance.new("UICorner", raceFrame).CornerRadius = UDim.new(0, 12)
local raceStroke = Instance.new("UIStroke", raceFrame)
raceStroke.Thickness = 3
raceStroke.Color = Color3.fromRGB(40, 40, 40)

local raceDot = Instance.new("Frame", raceFrame)
raceDot.Size = UDim2.new(0, 40, 0, 40)
raceDot.Position = UDim2.new(0.5, -20, 0, 5)
raceDot.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
raceDot.BorderSizePixel = 0
Instance.new("UICorner", raceDot).CornerRadius = UDim.new(1, 0)

local raceText = Instance.new("TextLabel", raceFrame)
raceText.Size = UDim2.new(1, 0, 0, 16)
raceText.Position = UDim2.new(0, 0, 1, -18)
raceText.BackgroundTransparency = 1
raceText.Text = "---"
raceText.TextColor3 = Color3.fromRGB(120, 120, 120)
raceText.Font = Enum.Font.GothamBold
raceText.TextSize = 10
raceText.ZIndex = 5

local function isCarryingBrainrot(plr)
    if not plr then return false end
    -- Check attribute "Stealing" on Player
    local ok1, val1 = pcall(function() return plr:GetAttribute("Stealing") end)
    if ok1 and val1 then return true end
    -- Check lowercase too
    local ok1b, val1b = pcall(function() return plr:GetAttribute("stealing") end)
    if ok1b and val1b then return true end
    if plr.Character then
        -- Check on Character
        local ok2, val2 = pcall(function() return plr.Character:GetAttribute("Stealing") end)
        if ok2 and val2 then return true end
        -- Check on Humanoid
        local hum = plr.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            local ok3, val3 = pcall(function() return hum:GetAttribute("Stealing") end)
            if ok3 and val3 then return true end
        end
        -- Fallback: check if they have a tool equipped (not bat/medusa)
        for _, child in ipairs(plr.Character:GetChildren()) do
            if child:IsA("Tool") then
                local n = child.Name:lower()
                if not n:find("bat") and not n:find("medusa") and not n:find("head") and not n:find("stone") then
                    return true
                end
            end
        end
    end
    return false
end

local _raceTick = tick()
local _raceState = 0

RunService.Heartbeat:Connect(function()
    local now = tick()
    if now - _raceTick < 0.2 then return end
    _raceTick = now
    
    local c = Player.Character
    if not c then return end
    local h = c:FindFirstChild("HumanoidRootPart")
    if not h then return end
    
    local iAmStealing = isCarryingBrainrot(Player)
    
    local enemyHRP = nil
    local enemyPlr = nil
    local nearestDist = math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Player and p.Character then
            local eh = p.Character:FindFirstChild("HumanoidRootPart")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if eh and hum and hum.Health > 0 then
                local d = (eh.Position - h.Position).Magnitude
                if d < nearestDist then
                    nearestDist = d
                    enemyHRP = eh
                    enemyPlr = p
                end
            end
        end
    end
    
    local enemyStealing = enemyPlr and isCarryingBrainrot(enemyPlr) or false
    
    if not enemyHRP or not iAmStealing or not enemyStealing then
        raceDot.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        raceStroke.Color = Color3.fromRGB(40, 40, 40)
        raceText.Text = "---"
        raceText.TextColor3 = Color3.fromRGB(120, 120, 120)
        _raceState = 0
        return
    end
    
    -- Simple: who is closer to their target as a percentage of the total race?
    local myDist = (Vector3.new(RACE_MY_TARGET.X, 0, RACE_MY_TARGET.Z) - Vector3.new(h.Position.X, 0, h.Position.Z)).Magnitude
    local enemyDist = (Vector3.new(RACE_ENEMY_TARGET.X, 0, RACE_ENEMY_TARGET.Z) - Vector3.new(enemyHRP.Position.X, 0, enemyHRP.Position.Z)).Magnitude
    
    -- Both targets are roughly the same total distance apart (~67 studs)
    -- So whoever has less distance remaining wins
    -- Add hysteresis: need 2 stud advantage to switch
    local newState = _raceState
    if myDist < enemyDist - 2 then
        newState = 1 -- win
    elseif enemyDist < myDist - 2 then
        newState = 2 -- lose
    end
    -- First time, just pick based on distance
    if _raceState == 0 then newState = myDist <= enemyDist and 1 or 2 end
    _raceState = newState
    
    if _raceState == 1 then
        raceDot.BackgroundColor3 = Color3.fromRGB(0, 220, 0)
        raceStroke.Color = Color3.fromRGB(0, 180, 0)
        raceText.Text = "WIN"
        raceText.TextColor3 = Color3.fromRGB(0, 220, 0)
    else
        raceDot.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
        raceStroke.Color = Color3.fromRGB(180, 0, 0)
        raceText.Text = "LOSE"
        raceText.TextColor3 = Color3.fromRGB(220, 0, 0)
    end
end)

-- ============================================
-- GUI - FULL BLACK MINIMAL CLEAN
-- ============================================
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local guiScale = isMobile and 0.4 or 1

-- FULL BLACK PALETTE - minimal, no color noise
local C = {
    bg = Color3.fromRGB(0, 0, 0),
    surface = Color3.fromRGB(12, 12, 12),
    elevated = Color3.fromRGB(20, 20, 20),
    border = Color3.fromRGB(35, 35, 35),
    text = Color3.fromRGB(220, 220, 220),
    textDim = Color3.fromRGB(90, 90, 90),
    textMuted = Color3.fromRGB(60, 60, 60),
    accent = Color3.fromRGB(255, 255, 255),
    toggleOn = Color3.fromRGB(255, 255, 255),
    toggleOff = Color3.fromRGB(30, 30, 30),
    success = Color3.fromRGB(80, 200, 80),
    danger = Color3.fromRGB(200, 60, 60),
    slider = Color3.fromRGB(255, 255, 255),
    progressFill = Color3.fromRGB(255, 255, 255)
}

local sg = Instance.new("ScreenGui")
sg.Name = "22S_BLACK"
sg.ResetOnSpawn = false
sg.Parent = Player.PlayerGui

-- Return timer popup (big centered countdown)
local returnTimerLabel = Instance.new("TextLabel", sg)
returnTimerLabel.Size = UDim2.new(0, 120, 0, 120)
returnTimerLabel.Position = UDim2.new(0.5, -60, 0.35, -60)
returnTimerLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
returnTimerLabel.BackgroundTransparency = 0.3
returnTimerLabel.Text = "3"
returnTimerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
returnTimerLabel.Font = Enum.Font.GothamBlack
returnTimerLabel.TextSize = 60
returnTimerLabel.ZIndex = 100
returnTimerLabel.Visible = false
returnTimerLabel.BorderSizePixel = 0
Instance.new("UICorner", returnTimerLabel).CornerRadius = UDim.new(0, 16)
local returnTimerStroke = Instance.new("UIStroke", returnTimerLabel)
returnTimerStroke.Thickness = 2
returnTimerStroke.Color = Color3.fromRGB(255, 255, 255)
ReturnState.timerLabel = returnTimerLabel

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

-- ============================================
-- PROGRESS BAR - clean black, no particles
-- ============================================
local progressBar = Instance.new("Frame", sg)
progressBar.Size = UDim2.new(0, 400 * guiScale, 0, 50 * guiScale)
progressBar.Position = UDim2.new(0.5, -200 * guiScale, 1, -160 * guiScale)
progressBar.BackgroundColor3 = C.bg
progressBar.BorderSizePixel = 0
progressBar.ClipsDescendants = true
Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 10 * guiScale)

local pStroke = Instance.new("UIStroke", progressBar)
pStroke.Thickness = 1.5
local pStrokeGrad = Instance.new("UIGradient", pStroke)
pStrokeGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.04, Color3.fromRGB(200, 200, 200)),
    ColorSequenceKeypoint.new(0.08, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.92, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.96, Color3.fromRGB(200, 200, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})

task.spawn(function()
    local r = 0
    while progressBar.Parent do
        r = (r + 2) % 360
        pStrokeGrad.Rotation = r
        task.wait(0.015)
    end
end)

ProgressLabel = Instance.new("TextLabel", progressBar)
ProgressLabel.Size = UDim2.new(0.35, 0, 0.5, 0)
ProgressLabel.Position = UDim2.new(0, 12 * guiScale, 0, 0)
ProgressLabel.BackgroundTransparency = 1
ProgressLabel.Text = "READY"
ProgressLabel.TextColor3 = C.textDim
ProgressLabel.Font = Enum.Font.GothamMedium
ProgressLabel.TextSize = 13 * guiScale
ProgressLabel.TextXAlignment = Enum.TextXAlignment.Left
ProgressLabel.ZIndex = 3

ProgressPercentLabel = Instance.new("TextLabel", progressBar)
ProgressPercentLabel.Size = UDim2.new(1, 0, 0.5, 0)
ProgressPercentLabel.BackgroundTransparency = 1
ProgressPercentLabel.Text = ""
ProgressPercentLabel.TextColor3 = C.text
ProgressPercentLabel.Font = Enum.Font.GothamBold
ProgressPercentLabel.TextSize = 16 * guiScale
ProgressPercentLabel.TextXAlignment = Enum.TextXAlignment.Center
ProgressPercentLabel.ZIndex = 3

RadiusInput = Instance.new("TextBox", progressBar)
RadiusInput.Size = UDim2.new(0, 38 * guiScale, 0, 20 * guiScale)
RadiusInput.Position = UDim2.new(1, -48 * guiScale, 0, 3 * guiScale)
RadiusInput.BackgroundColor3 = C.elevated
RadiusInput.Text = tostring(Values.STEAL_RADIUS)
RadiusInput.TextColor3 = C.text
RadiusInput.Font = Enum.Font.GothamMedium
RadiusInput.TextSize = 11 * guiScale
RadiusInput.ZIndex = 3
RadiusInput.BorderSizePixel = 0
Instance.new("UICorner", RadiusInput).CornerRadius = UDim.new(0, 5 * guiScale)

RadiusInput.FocusLost:Connect(function()
    local n = tonumber(RadiusInput.Text)
    if n then
        Values.STEAL_RADIUS = math.clamp(math.floor(n), 5, 100)
        RadiusInput.Text = tostring(Values.STEAL_RADIUS)
    end
end)

local pTrack = Instance.new("Frame", progressBar)
pTrack.Size = UDim2.new(0.92, 0, 0, 4 * guiScale)
pTrack.Position = UDim2.new(0.04, 0, 1, -12 * guiScale)
pTrack.BackgroundColor3 = C.elevated
pTrack.ZIndex = 2
pTrack.BorderSizePixel = 0
Instance.new("UICorner", pTrack).CornerRadius = UDim.new(1, 0)

ProgressBarFill = Instance.new("Frame", pTrack)
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
ProgressBarFill.BackgroundColor3 = C.progressFill
ProgressBarFill.ZIndex = 2
ProgressBarFill.BorderSizePixel = 0
Instance.new("UICorner", ProgressBarFill).CornerRadius = UDim.new(1, 0)

-- ============================================
-- MAIN WINDOW - clean black, no particles, no animated stroke
-- ============================================
local main = Instance.new("Frame", sg)
main.Name = "Main"
main.Size = UDim2.new(0, 620 * guiScale, 0, 720 * guiScale)
main.Position = isMobile and UDim2.new(0.5, -310 * guiScale, 0.5, -360 * guiScale) or UDim2.new(1, -640, 0, 20)
main.BackgroundColor3 = C.bg
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.ClipsDescendants = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12 * guiScale)

local mainStroke = Instance.new("UIStroke", main)
mainStroke.Thickness = 1.5
local mainStrokeGrad = Instance.new("UIGradient", mainStroke)
mainStrokeGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.04, Color3.fromRGB(200, 200, 200)),
    ColorSequenceKeypoint.new(0.08, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.92, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.96, Color3.fromRGB(200, 200, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})

task.spawn(function()
    local r = 0
    while main.Parent do
        r = (r + 2) % 360
        mainStrokeGrad.Rotation = r
        task.wait(0.015)
    end
end)

-- Header - minimal
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 60 * guiScale)
header.BackgroundTransparency = 1
header.BorderSizePixel = 0

-- Thin separator line under header
local headerLine = Instance.new("Frame", main)
headerLine.Size = UDim2.new(0.92, 0, 0, 1)
headerLine.Position = UDim2.new(0.04, 0, 0, 60 * guiScale)
headerLine.BackgroundColor3 = C.border
headerLine.BorderSizePixel = 0

local titleLabel = Instance.new("TextLabel", header)
titleLabel.Size = UDim2.new(1, 0, 0, 28 * guiScale)
titleLabel.Position = UDim2.new(0, 0, 0, 8 * guiScale)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "22S DUELS"
titleLabel.TextColor3 = C.text
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 22 * guiScale
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.ZIndex = 5

local subtitleLabel = Instance.new("TextLabel", header)
subtitleLabel.Size = UDim2.new(1, 0, 0, 18 * guiScale)
subtitleLabel.Position = UDim2.new(0, 0, 0, 36 * guiScale)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "discord.gg/22s"
subtitleLabel.TextColor3 = C.textDim
subtitleLabel.Font = Enum.Font.GothamMedium
subtitleLabel.TextSize = 12 * guiScale
subtitleLabel.TextXAlignment = Enum.TextXAlignment.Center
subtitleLabel.ZIndex = 5

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 30 * guiScale, 0, 30 * guiScale)
closeBtn.Position = UDim2.new(1, -40 * guiScale, 0.5, -15 * guiScale)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "×"
closeBtn.TextColor3 = C.textDim
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20 * guiScale
closeBtn.ZIndex = 5

closeBtn.MouseButton1Click:Connect(function() sg:Destroy() end)
closeBtn.MouseEnter:Connect(function() closeBtn.TextColor3 = C.danger end)
closeBtn.MouseLeave:Connect(function() closeBtn.TextColor3 = C.textDim end)

-- Content panels
local leftSide = Instance.new("Frame", main)
leftSide.Size = UDim2.new(0.48, 0, 0, 640 * guiScale)
leftSide.Position = UDim2.new(0.01, 0, 0, 68 * guiScale)
leftSide.BackgroundTransparency = 1
leftSide.BorderSizePixel = 0
leftSide.ClipsDescendants = true
leftSide.ZIndex = 2

local rightSide = Instance.new("Frame", main)
rightSide.Size = UDim2.new(0.48, 0, 0, 640 * guiScale)
rightSide.Position = UDim2.new(0.51, 0, 0, 68 * guiScale)
rightSide.BackgroundTransparency = 1
rightSide.BorderSizePixel = 0
rightSide.ClipsDescendants = true
rightSide.ZIndex = 2

VisualSetters = {}
local KeyButtons = {}
local waitingForKeybind = nil

-- ============================================
-- TOGGLE WITH KEYBIND - polished
-- ============================================
local function createToggleWithKey(parent, yPos, labelText, keybindKey, enabledKey, callback, specialColor)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, -8 * guiScale, 0, 42 * guiScale)
    row.Position = UDim2.new(0, 4 * guiScale, 0, yPos * guiScale)
    row.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
    row.BorderSizePixel = 0
    row.ZIndex = 3
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10 * guiScale)
    
    local rowStroke = Instance.new("UIStroke", row)
    rowStroke.Thickness = 1
    rowStroke.Color = Color3.fromRGB(35, 35, 35)
    
    -- Key badge
    local keyBtn = Instance.new("TextButton", row)
    keyBtn.Size = UDim2.new(0, 34 * guiScale, 0, 26 * guiScale)
    keyBtn.Position = UDim2.new(0, 8 * guiScale, 0.5, -13 * guiScale)
    keyBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    keyBtn.Text = KEYBINDS[keybindKey].Name
    keyBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    keyBtn.Font = Enum.Font.GothamBold
    keyBtn.TextSize = 11 * guiScale
    keyBtn.ZIndex = 4
    keyBtn.BorderSizePixel = 0
    Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0, 6 * guiScale)
    
    local keyStroke = Instance.new("UIStroke", keyBtn)
    keyStroke.Thickness = 1
    keyStroke.Color = Color3.fromRGB(50, 50, 50)
    
    KeyButtons[keybindKey] = keyBtn
    
    local label = Instance.new("TextLabel", row)
    label.Size = UDim2.new(0.50, 0, 1, 0)
    label.Position = UDim2.new(0, 48 * guiScale, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13 * guiScale
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 4
    
    local defaultOn = Enabled[enabledKey]
    
    local toggleBg = Instance.new("Frame", row)
    toggleBg.Size = UDim2.new(0, 46 * guiScale, 0, 26 * guiScale)
    toggleBg.Position = UDim2.new(1, -54 * guiScale, 0.5, -13 * guiScale)
    toggleBg.BackgroundColor3 = defaultOn and C.toggleOn or C.toggleOff
    toggleBg.ZIndex = 4
    toggleBg.BorderSizePixel = 0
    Instance.new("UICorner", toggleBg).CornerRadius = UDim.new(1, 0)
    
    local toggleCircle = Instance.new("Frame", toggleBg)
    toggleCircle.Size = UDim2.new(0, 20 * guiScale, 0, 20 * guiScale)
    toggleCircle.Position = defaultOn and UDim2.new(1, -23 * guiScale, 0.5, -10 * guiScale) or UDim2.new(0, 3 * guiScale, 0.5, -10 * guiScale)
    toggleCircle.BackgroundColor3 = defaultOn and C.bg or C.textDim
    toggleCircle.ZIndex = 5
    toggleCircle.BorderSizePixel = 0
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
        TweenService:Create(toggleBg, TweenInfo.new(0.2), {BackgroundColor3 = isOn and C.toggleOn or C.toggleOff}):Play()
        TweenService:Create(toggleCircle, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Position = isOn and UDim2.new(1, -23 * guiScale, 0.5, -10 * guiScale) or UDim2.new(0, 3 * guiScale, 0.5, -10 * guiScale),
            BackgroundColor3 = isOn and C.bg or C.textDim
        }):Play()
        if not skipCallback then
            callback(isOn)
        end
    end
    
    VisualSetters[enabledKey] = setVisual
    
    -- Hover effects
    clickBtn.MouseEnter:Connect(function()
        TweenService:Create(row, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(22, 22, 22)}):Play()
        TweenService:Create(rowStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    clickBtn.MouseLeave:Connect(function()
        TweenService:Create(row, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(14, 14, 14)}):Play()
        TweenService:Create(rowStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(35, 35, 35)}):Play()
    end)
    
    clickBtn.MouseButton1Click:Connect(function()
        isOn = not isOn
        Enabled[enabledKey] = isOn
        setVisual(isOn)
        playSound("rbxassetid://6895079813", 0.2, 1)
    end)
    
    keyBtn.MouseButton1Click:Connect(function()
        waitingForKeybind = keybindKey
        keyBtn.Text = "..."
        playSound("rbxassetid://6895079813", 0.2, 1.5)
    end)
    
    return row, enabledKey, function() return isOn end, setVisual, keyBtn
end

-- ============================================
-- TOGGLE (no keybind) - polished
-- ============================================
local function createToggle(parent, yPos, labelText, enabledKey, callback, specialColor)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, -8 * guiScale, 0, 42 * guiScale)
    row.Position = UDim2.new(0, 4 * guiScale, 0, yPos * guiScale)
    row.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
    row.BorderSizePixel = 0
    row.ZIndex = 3
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10 * guiScale)
    
    local rowStroke = Instance.new("UIStroke", row)
    rowStroke.Thickness = 1
    rowStroke.Color = Color3.fromRGB(35, 35, 35)
    
    local label = Instance.new("TextLabel", row)
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 14 * guiScale, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13 * guiScale
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 4
    
    local defaultOn = Enabled[enabledKey]
    
    local toggleBg = Instance.new("Frame", row)
    toggleBg.Size = UDim2.new(0, 46 * guiScale, 0, 26 * guiScale)
    toggleBg.Position = UDim2.new(1, -54 * guiScale, 0.5, -13 * guiScale)
    toggleBg.BackgroundColor3 = defaultOn and C.toggleOn or C.toggleOff
    toggleBg.ZIndex = 4
    toggleBg.BorderSizePixel = 0
    Instance.new("UICorner", toggleBg).CornerRadius = UDim.new(1, 0)
    
    local toggleCircle = Instance.new("Frame", toggleBg)
    toggleCircle.Size = UDim2.new(0, 20 * guiScale, 0, 20 * guiScale)
    toggleCircle.Position = defaultOn and UDim2.new(1, -23 * guiScale, 0.5, -10 * guiScale) or UDim2.new(0, 3 * guiScale, 0.5, -10 * guiScale)
    toggleCircle.BackgroundColor3 = defaultOn and C.bg or C.textDim
    toggleCircle.ZIndex = 5
    toggleCircle.BorderSizePixel = 0
    Instance.new("UICorner", toggleCircle).CornerRadius = UDim.new(1, 0)
    
    local clickBtn = Instance.new("TextButton", row)
    clickBtn.Size = UDim2.new(1, 0, 1, 0)
    clickBtn.BackgroundTransparency = 1
    clickBtn.Text = ""
    clickBtn.ZIndex = 6
    
    local isOn = defaultOn
    
    local function setVisual(state, skipCallback)
        isOn = state
        TweenService:Create(toggleBg, TweenInfo.new(0.2), {BackgroundColor3 = isOn and C.toggleOn or C.toggleOff}):Play()
        TweenService:Create(toggleCircle, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Position = isOn and UDim2.new(1, -23 * guiScale, 0.5, -10 * guiScale) or UDim2.new(0, 3 * guiScale, 0.5, -10 * guiScale),
            BackgroundColor3 = isOn and C.bg or C.textDim
        }):Play()
        if not skipCallback then
            callback(isOn)
        end
    end
    
    VisualSetters[enabledKey] = setVisual
    
    -- Hover effects
    clickBtn.MouseEnter:Connect(function()
        TweenService:Create(row, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(22, 22, 22)}):Play()
        TweenService:Create(rowStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    clickBtn.MouseLeave:Connect(function()
        TweenService:Create(row, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(14, 14, 14)}):Play()
        TweenService:Create(rowStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(35, 35, 35)}):Play()
    end)
    
    clickBtn.MouseButton1Click:Connect(function()
        isOn = not isOn
        Enabled[enabledKey] = isOn
        setVisual(isOn)
        playSound("rbxassetid://6895079813", 0.2, 1)
    end)
    
    return row, enabledKey, function() return isOn end, setVisual
end



-- ============================================
-- INPUT BOX (type to change value)
-- ============================================
local function createInputBox(parent, yPos, labelText, valueKey, minVal, maxVal, callback)
    local container = Instance.new("Frame", parent)
    container.Size = UDim2.new(1, -8 * guiScale, 0, 40 * guiScale)
    container.Position = UDim2.new(0, 4 * guiScale, 0, yPos * guiScale)
    container.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
    container.BorderSizePixel = 0
    container.ZIndex = 3
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8 * guiScale)
    
    local rowStroke = Instance.new("UIStroke", container)
    rowStroke.Thickness = 1
    rowStroke.Color = Color3.fromRGB(35, 35, 35)
    
    local label = Instance.new("TextLabel", container)
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 14 * guiScale, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(140, 140, 140)
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 12 * guiScale
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 4
    
    local input = Instance.new("TextBox", container)
    input.Size = UDim2.new(0, 65 * guiScale, 0, 26 * guiScale)
    input.Position = UDim2.new(1, -74 * guiScale, 0.5, -13 * guiScale)
    input.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    input.Text = tostring(Values[valueKey])
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.Font = Enum.Font.GothamBold
    input.TextSize = 13 * guiScale
    input.ClearTextOnFocus = false
    input.ZIndex = 4
    input.BorderSizePixel = 0
    Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6 * guiScale)
    
    local inputStroke = Instance.new("UIStroke", input)
    inputStroke.Thickness = 1
    inputStroke.Color = Color3.fromRGB(50, 50, 50)
    
    input.Focused:Connect(function()
        TweenService:Create(inputStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(255, 255, 255)}):Play()
    end)
    input.FocusLost:Connect(function()
        TweenService:Create(inputStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(50, 50, 50)}):Play()
        local n = tonumber(input.Text)
        if n then
            n = math.clamp(n, minVal, maxVal)
            Values[valueKey] = n
            input.Text = tostring(n)
            if callback then callback(n) end
        else
            input.Text = tostring(Values[valueKey])
        end
    end)
    
    return container
end


-- ============================================
-- SECTION LABEL HELPER

-- Thin divider line between groups
local function createDivider(parent, yPos)
    local line = Instance.new("Frame", parent)
    line.Size = UDim2.new(0.85, 0, 0, 1)
    line.Position = UDim2.new(0.075, 0, 0, yPos * guiScale)
    line.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    line.BorderSizePixel = 0
    line.ZIndex = 3
end

-- ============================================
-- LEFT = Speed & Autos (main features)
-- ============================================
local Y = 0
local SP = 46
local GAP = 12

-- Speed toggle
local speedRow = Instance.new("Frame", leftSide)
speedRow.Size = UDim2.new(1, -8 * guiScale, 0, 42 * guiScale)
speedRow.Position = UDim2.new(0, 4 * guiScale, 0, Y * guiScale)
speedRow.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
speedRow.BorderSizePixel = 0
speedRow.ZIndex = 3
Instance.new("UICorner", speedRow).CornerRadius = UDim.new(0, 10 * guiScale)
local speedRowStroke = Instance.new("UIStroke", speedRow)
speedRowStroke.Thickness = 1
speedRowStroke.Color = Color3.fromRGB(35, 35, 35)

local speedKeyBtn = Instance.new("TextButton", speedRow)
speedKeyBtn.Size = UDim2.new(0, 34 * guiScale, 0, 26 * guiScale)
speedKeyBtn.Position = UDim2.new(0, 8 * guiScale, 0.5, -13 * guiScale)
speedKeyBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
speedKeyBtn.Text = KEYBINDS.SPEED.Name
speedKeyBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
speedKeyBtn.Font = Enum.Font.GothamBold
speedKeyBtn.TextSize = 11 * guiScale
speedKeyBtn.ZIndex = 8
speedKeyBtn.BorderSizePixel = 0
Instance.new("UICorner", speedKeyBtn).CornerRadius = UDim.new(0, 6 * guiScale)
local speedKeyStroke = Instance.new("UIStroke", speedKeyBtn)
speedKeyStroke.Thickness = 1
speedKeyStroke.Color = Color3.fromRGB(50, 50, 50)
KeyButtons["SPEED"] = speedKeyBtn
speedKeyBtn.MouseButton1Click:Connect(function()
    waitingForKeybind = "SPEED"
    speedKeyBtn.Text = "..."
    playSound("rbxassetid://6895079813", 0.2, 1.5)
end)

local speedLabel = Instance.new("TextLabel", speedRow)
speedLabel.Size = UDim2.new(0.7, 0, 1, 0)
speedLabel.Position = UDim2.new(0, 48 * guiScale, 0, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Carry Speed"
speedLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextSize = 13 * guiScale
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.ZIndex = 4

local function updateSpeedDisplay(isNormal)
    speedLabel.Text = isNormal and "Normal Speed" or "Carry Speed"
end
VisualSetters.NormalSpeed = function(state, skipCallback)
    Enabled.NormalSpeed = state
    updateSpeedDisplay(state)
end

local speedClickBtn = Instance.new("TextButton", speedRow)
speedClickBtn.Size = UDim2.new(1, 0, 1, 0)
speedClickBtn.BackgroundTransparency = 1
speedClickBtn.Text = ""
speedClickBtn.ZIndex = 6
speedClickBtn.MouseButton1Click:Connect(function()
    Enabled.NormalSpeed = not Enabled.NormalSpeed
    updateSpeedDisplay(Enabled.NormalSpeed)
    playSound("rbxassetid://6895079813", 0.2, 1)
end)
speedClickBtn.MouseEnter:Connect(function()
    TweenService:Create(speedRow, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(22, 22, 22)}):Play()
end)
speedClickBtn.MouseLeave:Connect(function()
    TweenService:Create(speedRow, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(14, 14, 14)}):Play()
end)
Y = Y + SP

-- Auto plays
createToggleWithKey(leftSide, Y, "Auto Left", "AUTOLEFT", "AutoWalkEnabled", function(s)
    AutoWalkEnabled = s
    Enabled.AutoWalkEnabled = s
    if s then enableNormalSpeed(); startAutoWalk() else stopAutoWalk() end
end)
_G.setAutoLeftVisual = VisualSetters.AutoWalkEnabled
Y = Y + SP

createToggleWithKey(leftSide, Y, "Auto Play Left", "AUTOPLAY", "AutoPlayLeft", function(s)
    AutoPlayLeftEnabled = s
    Enabled.AutoPlayLeft = s
    if s then enableNormalSpeed(); startAutoPlayLeft() else stopAutoPlayLeft() end
end)
Y = Y + SP

createToggleWithKey(leftSide, Y, "Auto Right", "AUTORIGHT", "AutoRightEnabled", function(s)
    AutoRightEnabled = s
    Enabled.AutoRightEnabled = s
    if s then enableNormalSpeed(); startAutoRight() else stopAutoRight() end
end)
_G.setAutoRightVisual = VisualSetters.AutoRightEnabled
Y = Y + SP

createToggleWithKey(leftSide, Y, "Auto Play Right", "AUTOPLAYR", "AutoPlayRight", function(s)
    AutoPlayRightEnabled = s
    Enabled.AutoPlayRight = s
    if s then enableNormalSpeed(); startAutoPlayRight() else stopAutoPlayRight() end
end)
Y = Y + SP

createToggle(leftSide, Y, "Auto After CD", "AutoPlayCountdown", function(s)
    Enabled.AutoPlayCountdown = s
    if s then
        task.spawn(function() refreshMyPlotSide() end)
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name == "Countdown" and obj:IsA("Sound") and obj.Playing then
                monitorCountdown(obj)
                break
            end
        end
    end
end)
Y = Y + SP

createToggle(leftSide, Y, "Auto Steal", "AutoSteal", function(s)
    Enabled.AutoSteal = s
    if s then startAutoSteal() else stopAutoSteal() end
end)
Y = Y + SP

createDivider(leftSide, Y - 3)
Y = Y + GAP

-- Speed & steal settings
createInputBox(leftSide, Y, "Normal Speed", "NormalSpeed", 1, 200, function(v) end)
Y = Y + SP
createInputBox(leftSide, Y, "Carry Speed", "CarrySpeed", 1, 200, function(v) end)
Y = Y + SP
createInputBox(leftSide, Y, "Steal Radius", "STEAL_RADIUS", 1, 200, function(v) end)
Y = Y + SP
createInputBox(leftSide, Y, "Hop Power", "HOP_POWER", 1, 200, function(v) end)
Y = Y + SP
createInputBox(leftSide, Y, "Float Height", "FloatHeight", -200, 200, function(v) end)
Y = Y + SP
createInputBox(leftSide, Y, "Freeze Time", "FreezeTime", 0, 10, function(v) end)

-- ============================================
-- RIGHT = Combat & Movement & Visual
-- ============================================
Y = 0

-- Combat
createToggleWithKey(rightSide, Y, "Bat Aimbot", "BATAIMBOT", "BatAimbot", function(s)
    Enabled.BatAimbot = s
    if s then startBatAimbot() else stopBatAimbot() end
end)
Y = Y + SP

createToggle(rightSide, Y, "Anti Ragdoll", "AntiRagdoll", function(s)
    Enabled.AntiRagdoll = s
    if s then startAntiRagdoll() else stopAntiRagdoll() end
end)
Y = Y + SP

createToggle(rightSide, Y, "Medusa Counter", "MedusaCounter", function(s)
    medusaCounterEnabled = s
    if s then setupMedusaCounter(Player.Character) else stopMedusaCounter() end
end)
Y = Y + SP

createToggleWithKey(rightSide, Y, "Return L", "RETURNL", "ReturnL", function(s)
    Enabled.ReturnL = s
    ReturnState.leftEnabled = s
    if s then
        Enabled.ReturnR = false
        ReturnState.rightEnabled = false
        if VisualSetters.ReturnR then VisualSetters.ReturnR(false, true) end
    end
end)
Y = Y + SP

createToggleWithKey(rightSide, Y, "Return R", "RETURNR", "ReturnR", function(s)
    Enabled.ReturnR = s
    ReturnState.rightEnabled = s
    if s then
        Enabled.ReturnL = false
        ReturnState.leftEnabled = false
        if VisualSetters.ReturnL then VisualSetters.ReturnL(false, true) end
    end
end)
Y = Y + SP

createDivider(rightSide, Y - 3)
Y = Y + GAP

-- Movement
createToggleWithKey(rightSide, Y, "Infinite Jump", "INFJUMP", "InfiniteJump", function(s)
    Enabled.InfiniteJump = s
    if s then startInfiniteJump() else stopInfiniteJump() end
end)
Y = Y + SP

createToggleWithKey(rightSide, Y, "Float", "FLOAT", "Float", function(s)
    Enabled.Float = s
    if s then startFloat() else stopFloat() end
end)
Y = Y + SP

createToggleWithKey(rightSide, Y, "Drop Brainrot", "DROPBR", "DropBR", function(s)
    if s then task.spawn(runDropBrainrot) end
    task.delay(0.5, function()
        if VisualSetters.DropBR then VisualSetters.DropBR(false, true) end
    end)
end)
Y = Y + SP

createToggleWithKey(rightSide, Y, "TP Down", "TPDOWN", "TPDown", function(s)
    if s then runTPDown() end
    task.delay(0.3, function()
        if VisualSetters.TPDown then VisualSetters.TPDown(false, true) end
    end)
end)
Y = Y + SP

createToggle(rightSide, Y, "Unwalk", "Unwalk", function(s)
    Enabled.Unwalk = s
    if s then startUnwalk() else stopUnwalk() end
end)
Y = Y + SP

createDivider(rightSide, Y - 3)
Y = Y + GAP

-- Visual & save
createToggle(rightSide, Y, "Ultra Nuke", "UltraNuke", function(s)
    Enabled.UltraNuke = s
    if s then enableUltraNuke() else disableUltraNuke() end
end)
Y = Y + SP + 6

local SaveBtn = Instance.new("TextButton", rightSide)
SaveBtn.Size = UDim2.new(1, -8 * guiScale, 0, 42 * guiScale)
SaveBtn.Position = UDim2.new(0, 4 * guiScale, 0, Y * guiScale)
SaveBtn.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
SaveBtn.Text = "SAVE CONFIG"
SaveBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
SaveBtn.Font = Enum.Font.GothamBold
SaveBtn.TextSize = 13 * guiScale
SaveBtn.ZIndex = 3
SaveBtn.BorderSizePixel = 0
Instance.new("UICorner", SaveBtn).CornerRadius = UDim.new(0, 8 * guiScale)
local saveBtnStroke = Instance.new("UIStroke", SaveBtn)
saveBtnStroke.Thickness = 1
saveBtnStroke.Color = Color3.fromRGB(50, 50, 50)
SaveBtn.MouseEnter:Connect(function()
    TweenService:Create(saveBtnStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(255, 255, 255)}):Play()
    TweenService:Create(SaveBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(22, 22, 22)}):Play()
end)
SaveBtn.MouseLeave:Connect(function()
    TweenService:Create(saveBtnStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(50, 50, 50)}):Play()
    TweenService:Create(SaveBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(14, 14, 14)}):Play()
end)
SaveBtn.MouseButton1Click:Connect(function()
    local success = SaveConfig()
    if success then
        SaveBtn.Text = "SAVED"
        SaveBtn.TextColor3 = C.success
        saveBtnStroke.Color = C.success
    else
        SaveBtn.Text = "FAILED"
        SaveBtn.TextColor3 = C.danger
        saveBtnStroke.Color = C.danger
    end
    task.delay(1.5, function()
        SaveBtn.Text = "SAVE CONFIG"
        SaveBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
        saveBtnStroke.Color = Color3.fromRGB(50, 50, 50)
    end)
end)

local infoLabel = Instance.new("TextLabel", leftSide)
infoLabel.Size = UDim2.new(1, 0, 0, 22 * guiScale)
infoLabel.Position = UDim2.new(0, 0, 0, 630 * guiScale)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "V=Speed  M=Jump  X=Aim  Z=Left  B=PlayL  G=PlayR  H=RetL  K=RetR  P=GUI"
infoLabel.TextColor3 = C.textMuted
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextSize = 7 * guiScale
infoLabel.ZIndex = 3





local guiVisible = true

-- Apply loaded config
task.spawn(function()
    task.wait(3)
    
    local c = Player.Character
    if not c or not c:FindFirstChild("HumanoidRootPart") then
        c = Player.CharacterAdded:Wait()
        task.wait(1)
    end
    
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
    
    if Enabled.AntiRagdoll then startAntiRagdoll() end
    if Enabled.AutoSteal then startAutoSteal() end
    if Enabled.Optimizer then enableOptimizer() end
    
    task.wait(0.5)
    
    if Enabled.BatAimbot then startBatAimbot() end
    if Enabled.InfiniteJump then startInfiniteJump() end
    if Enabled.Unwalk then startUnwalk() end
    if Enabled.Float then startFloat() end
    if Enabled.UltraNuke then enableUltraNuke() end
    if medusaCounterEnabled then setupMedusaCounter(Player.Character) end
    if Enabled.AutoWalkEnabled then AutoWalkEnabled = true; enableNormalSpeed(); startAutoWalk() end
    if Enabled.AutoRightEnabled then AutoRightEnabled = true; enableNormalSpeed(); startAutoRight() end
end)

-- Input handling
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    
    if waitingForKeybind and input.KeyCode ~= Enum.KeyCode.Unknown then
        local k = input.KeyCode
        KEYBINDS[waitingForKeybind] = k
        if KeyButtons[waitingForKeybind] then
            KeyButtons[waitingForKeybind].Text = k.Name
        end
        waitingForKeybind = nil
        return
    end
    
    if input.KeyCode == Enum.KeyCode.P then
        guiVisible = not guiVisible
        main.Visible = guiVisible
        return
    end
    
    if input.KeyCode == Enum.KeyCode.Space then
        spaceHeld = true
        return
    end
    
    if input.KeyCode == KEYBINDS.SPEED then
        if VisualSetters.NormalSpeed then VisualSetters.NormalSpeed(not Enabled.NormalSpeed) end
    end
    
    if input.KeyCode == KEYBINDS.INFJUMP then
        Enabled.InfiniteJump = not Enabled.InfiniteJump
        if VisualSetters.InfiniteJump then VisualSetters.InfiniteJump(Enabled.InfiniteJump) end
        if Enabled.InfiniteJump then startInfiniteJump() else stopInfiniteJump() end
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
        if AutoWalkEnabled then enableNormalSpeed(); startAutoWalk() else stopAutoWalk() end
    end
    
    if input.KeyCode == KEYBINDS.AUTORIGHT then
        AutoRightEnabled = not AutoRightEnabled
        Enabled.AutoRightEnabled = AutoRightEnabled
        if VisualSetters.AutoRightEnabled then VisualSetters.AutoRightEnabled(AutoRightEnabled) end
        if AutoRightEnabled then enableNormalSpeed(); startAutoRight() else stopAutoRight() end
    end
    
    if input.KeyCode == KEYBINDS.AUTOPLAY then
        AutoPlayLeftEnabled = not AutoPlayLeftEnabled
        Enabled.AutoPlayLeft = AutoPlayLeftEnabled
        if VisualSetters.AutoPlayLeft then VisualSetters.AutoPlayLeft(AutoPlayLeftEnabled) end
        if AutoPlayLeftEnabled then enableNormalSpeed(); startAutoPlayLeft() else stopAutoPlayLeft() end
    end
    
    if input.KeyCode == KEYBINDS.AUTOPLAYR then
        AutoPlayRightEnabled = not AutoPlayRightEnabled
        Enabled.AutoPlayRight = AutoPlayRightEnabled
        if VisualSetters.AutoPlayRight then VisualSetters.AutoPlayRight(AutoPlayRightEnabled) end
        if AutoPlayRightEnabled then enableNormalSpeed(); startAutoPlayRight() else stopAutoPlayRight() end
    end
    
    if input.KeyCode == KEYBINDS.RETURNL then
        Enabled.ReturnL = not Enabled.ReturnL
        ReturnState.leftEnabled = Enabled.ReturnL
        if VisualSetters.ReturnL then VisualSetters.ReturnL(Enabled.ReturnL) end
        if Enabled.ReturnL then
            Enabled.ReturnR = false
            ReturnState.rightEnabled = false
            if VisualSetters.ReturnR then VisualSetters.ReturnR(false) end
        end
    end
    
    if input.KeyCode == KEYBINDS.RETURNR then
        Enabled.ReturnR = not Enabled.ReturnR
        ReturnState.rightEnabled = Enabled.ReturnR
        if VisualSetters.ReturnR then VisualSetters.ReturnR(Enabled.ReturnR) end
        if Enabled.ReturnR then
            Enabled.ReturnL = false
            ReturnState.leftEnabled = false
            if VisualSetters.ReturnL then VisualSetters.ReturnL(false) end
        end
    end
    
    if input.KeyCode == KEYBINDS.DROPBR then
        task.spawn(runDropBrainrot)
    end
    
    if input.KeyCode == KEYBINDS.FLOAT then
        Enabled.Float = not Enabled.Float
        if VisualSetters.Float then VisualSetters.Float(Enabled.Float) end
        if Enabled.Float then startFloat() else stopFloat() end
    end
    
    if input.KeyCode == KEYBINDS.TPDOWN then
        runTPDown()
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then
        spaceHeld = false
    end
end)

Player.CharacterAdded:Connect(function(char)
    task.wait(1)
    if Enabled.BatAimbot then stopBatAimbot() task.wait(0.1) startBatAimbot() end
    if Enabled.Unwalk then startUnwalk() end
    if medusaCounterEnabled then setupMedusaCounter(char) end
    if Enabled.Float then stopFloat() startFloat() end
end)
]],
})

table.insert(SCRIPTS, {
    name="111 Duel Hub", icon="🔥", desc="FULL AUTO • STEAL • LAGGER", isNew=true, kind="embed",
    code=[[
repeat task.wait() until game:IsLoaded()
pcall(function() setfpscap(999) end)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local VisualSetters = {}
local mobileButtonContainer
local apMain
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local NORMAL_SPEED = 60
local CARRY_SPEED = 30
local LAGGER_SPEED = 15
local FOV_VALUE = 70
local UI_SCALE = isMobile and 0.65 or 1.0
local function getMobileOptimized(pcValue, mobileValue)
    return isMobile and mobileValue or pcValue
end
local lastNoclipUpdate = 0
RunService.Stepped:Connect(function()
    local now = tick()
    if now - lastNoclipUpdate < 0.1 then return end
    lastNoclipUpdate = now
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            for _, part in ipairs(p.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)
local speedToggled = false
local fastestStealEnabled = false
local laggerToggled = false
local autoBatToggled = false
local hittingCooldown = false
local fullAutoPlayEnabled = false
local fullAutoPlayConn = nil
local fullAutoPlayLeftEnabled = false
local fullAutoPlayRightEnabled = false
local fullAutoPlayLeftConn = nil
local fullAutoPlayRightConn = nil
local fullAutoLeftSetter = nil
local fullAutoRightSetter = nil
local brainrotReturnLeftEnabled = false
local brainrotReturnRightEnabled = false
local brainrotReturnCooldown = false
local lastKnownHealth = 100
local G_myPlotSide = nil
local G_myPlotName = nil
local G_tpAutoEnabled = false
local G_autoPlayAfterTP = false
local G_countdownActive = false
local ultraModeEnabled = false
local autoSwingEnabled = false
local noCamCollisionEnabled = false
local noCamCollisionConn = nil
local noCamParts = {}
local _antiLagDescConn = nil
local lastBatSwing = 0
local BAT_SWING_COOLDOWN = 0.12
local SPAWN_DETECT_RADIUS = 40
local COUNTDOWN_TARGET = 4.9
local SPAWN_Z_RIGHT_THRESHOLD = 60
local SPAWN_LEFT = Vector3.new(-466.429901, 0, 113.553757)
local SPAWN_RIGHT = Vector3.new(-466.42984, 0, 6.55357218)
local AP_Offsets = {{x=0,y=0,z=0},{x=0,y=0,z=0},{x=0,y=0,z=0},{x=0,y=0,z=0}}
local APR_Offsets = {{x=0,y=0,z=0},{x=0,y=0,z=0},{x=0,y=0,z=0},{x=0,y=0,z=0}}
local BR_L2 = Vector3.new(-475.5, -3.75, 100.5)
local BR_L3 = Vector3.new(-486.5, -3.75, 100.5)
local BR_R2 = Vector3.new(-475.50, -3.95, 17.55)
local BR_R3 = Vector3.new(-486.76, -3.95, 17.55)
local Keybinds = {
    AutoBat = Enum.KeyCode.E,
    SpeedToggle = Enum.KeyCode.Q,
    LaggerToggle = Enum.KeyCode.R,
    InfiniteJump = Enum.KeyCode.M,
    UIToggle = Enum.KeyCode.U,
    DropBrainrot = Enum.KeyCode.X,
    FloatToggle = Enum.KeyCode.J,
    FullAutoLeft = Enum.KeyCode.G,
    FullAutoRight = Enum.KeyCode.H,
    TPDown = Enum.KeyCode.F,
}
local isStealing = false
local stealStartTime = nil
local StealData = {}
local lastStealTick = 0
local plotCache = {}
local plotCacheTime = {}
local cachedPrompts = {}
local promptCacheTime = 0
local Settings = {
    AutoStealEnabled = false,
    StealRadius = 20,
    StealDuration = 0.25,
}
local Values = {
    STEAL_RADIUS = 20,
    STEAL_DURATION = 0.2,
    STEAL_COOLDOWN = 0.1,
    PLOT_CACHE_DURATION = 2,
    PROMPT_CACHE_REFRESH = 0.15,
    DEFAULT_GRAVITY = 196.2,
    GalaxyGravityPercent = 70,
    HOP_POWER = 35,
    HOP_COOLDOWN = 0.08,
}
local function detectMyPlot()
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil, nil end
    local myName = LocalPlayer.DisplayName or LocalPlayer.Name
    for _, plot in ipairs(plots:GetChildren()) do
        local ok, result = pcall(function()
            local sign = plot:FindFirstChild("PlotSign"); if not sign then return nil end
            local sg = sign:FindFirstChild("SurfaceGui"); if not sg then return nil end
            local fr = sg:FindFirstChild("Frame"); if not fr then return nil end
            local tl = fr:FindFirstChild("TextLabel"); if not tl then return nil end
            if tl.Text:find(myName, 1, true) then
                local spawnObj = plot:FindFirstChild("Spawn")
                if spawnObj then
                    local z = spawnObj.CFrame.Position.Z
                    return z < SPAWN_Z_RIGHT_THRESHOLD and "left" or "right"
                end
            end
            return nil
        end)
        if ok and result then return result, plot.Name end
    end
    return nil, nil
end
local function refreshMyPlotSide()
    local side, plotName = detectMyPlot()
    G_myPlotSide = side; G_myPlotName = plotName
    return side
end
task.spawn(function()
    while true do
        task.wait(2)
        if G_tpAutoEnabled then refreshMyPlotSide() end
    end
end)
task.spawn(function()
    local plots = workspace:WaitForChild("Plots", 30); if not plots then return end
    local myName = LocalPlayer.DisplayName or LocalPlayer.Name
    local function watchPlot(plot)
        pcall(function()
            local tl = plot:WaitForChild("PlotSign",5):WaitForChild("SurfaceGui",5):WaitForChild("Frame",5):WaitForChild("TextLabel",5)
            if not tl then return end
            tl:GetPropertyChangedSignal("Text"):Connect(function() refreshMyPlotSide() end)
            if tl.Text:find(myName, 1, true) then refreshMyPlotSide() end
        end)
    end
    for _, plot in ipairs(plots:GetChildren()) do task.spawn(watchPlot, plot) end
    plots.ChildAdded:Connect(function(plot) task.spawn(watchPlot, plot) end)
end)
local function calculateFastestStealSpeed()
    local char = LocalPlayer.Character; if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return nil end
    local targetPos = nil
    if fullAutoPlayLeftEnabled then
        local pts = {FAP_L1, FAP_L2, FAP_L3, FAP_L4, FAP_L5}
        local phase = FAP_LeftPhase
        if type(phase) ~= "number" or phase < 1 then phase = 1 end
        if phase > 5 then phase = 5 end
        targetPos = pts[phase]
    elseif fullAutoPlayRightEnabled then
        local pts = {FAP_R1, FAP_R2, FAP_R3, FAP_R4, FAP_R5}
        local phase = FAP_RightPhase
        if type(phase) ~= "number" or phase < 1 then phase = 1 end
        if phase > 5 then phase = 5 end
        targetPos = pts[phase]
    else
        return nil
    end
    if not targetPos then return end
    local dist = Vector3.new(targetPos.X - hrp.Position.X, 0, targetPos.Z - hrp.Position.Z).Magnitude
    if dist < 0.1 then return end
    local requiredSpeed = math.clamp(dist / 1.65, 1, 9999)
    return requiredSpeed
end
RunService.Heartbeat:Connect(function()
    if not fastestStealEnabled then return end
    if not (fullAutoPlayLeftEnabled or fullAutoPlayRightEnabled) then return end
    local char = LocalPlayer.Character; if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return end
    local md = hum.MoveDirection; if md.Magnitude == 0 then return end
    local spd = calculateFastestStealSpeed()
    if spd then
        hrp.AssemblyLinearVelocity = Vector3.new(md.X * spd, hrp.AssemblyLinearVelocity.Y, md.Z * spd)
    end
end)
local function syncStealSettings()
    Values.STEAL_RADIUS = Settings.StealRadius
    Values.STEAL_DURATION = Settings.StealDuration
    Settings.StealRadius = Values.STEAL_RADIUS
    Settings.StealDuration = Values.STEAL_DURATION
end
local STEAL_COOLDOWN = Values.STEAL_COOLDOWN
local PLOT_CACHE_DURATION = Values.PLOT_CACHE_DURATION
local PROMPT_CACHE_REFRESH = Values.PROMPT_CACHE_REFRESH
local Enabled = {
    AntiRagdoll = false,
    AutoSteal = false,
    InfiniteJump = false,
    ShinyGraphics = false,
    Optimizer = false,
    Unwalk = false,
    RemoveAccessories = false,
}
local Connections = {}
local originalTransparency = {}
local savedAnimations = {}
local xrayEnabled = false
local h, hrp, speedLbl
local progressConnection = nil
local gui, main
local speedSwBg, speedSwCircle
local laggerSwBg, laggerSwCircle
local batSwBg, batSwCircle
local waitingForKey = nil
local function getHRP()
    local char = LocalPlayer.Character
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart")
end
local function isMyPlotByName(plotName)
    local currentTime = tick()
    if plotCache[plotName] and (currentTime - (plotCacheTime[plotName] or 0)) < PLOT_CACHE_DURATION then
        return plotCache[plotName]
    end
    local plots = workspace:FindFirstChild("Plots")
    if not plots then plotCache[plotName]=false; plotCacheTime[plotName]=currentTime; return false end
    local plot = plots:FindFirstChild(plotName)
    if not plot then plotCache[plotName]=false; plotCacheTime[plotName]=currentTime; return false end
    local sign = plot:FindFirstChild("PlotSign")
    if sign then
        local yourBase = sign:FindFirstChild("YourBase")
        if yourBase and yourBase:IsA("BillboardGui") then
            local result = yourBase.Enabled == true
            plotCache[plotName]=result; plotCacheTime[plotName]=currentTime
            return result
        end
    end
    plotCache[plotName]=false; plotCacheTime[plotName]=currentTime
    return false
end
local function findNearestPrompt()
    local char = LocalPlayer.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local currentTime = tick()
    if currentTime - promptCacheTime < PROMPT_CACHE_REFRESH and #cachedPrompts > 0 then
        local nearestPrompt, nearestDist, nearestName = nil, math.huge, nil
        for _, data in ipairs(cachedPrompts) do
            if data.spawn then
                local dist = (data.spawn.Position - root.Position).Magnitude
                if dist <= Settings.StealRadius and dist < nearestDist then
                    nearestPrompt = data.prompt; nearestDist = dist; nearestName = data.name
                end
            end
        end
        if nearestPrompt then return nearestPrompt, nearestDist, nearestName end
    end
    cachedPrompts = {}; promptCacheTime = currentTime
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil end
    local nearestPrompt, nearestDist, nearestName = nil, math.huge, nil
    for _, plot in ipairs(plots:GetChildren()) do
        if isMyPlotByName(plot.Name) then continue end
        local podiums = plot:FindFirstChild("AnimalPodiums")
        if not podiums then continue end
        for _, podium in ipairs(podiums:GetChildren()) do
            pcall(function()
                local base = podium:FindFirstChild("Base")
                local spawn = base and base:FindFirstChild("Spawn")
                if spawn then
                    local dist = (spawn.Position - root.Position).Magnitude
                    local att = spawn:FindFirstChild("PromptAttachment")
                    if att then
                        for _, ch in ipairs(att:GetChildren()) do
                            if ch:IsA("ProximityPrompt") then
                                table.insert(cachedPrompts, {prompt=ch, spawn=spawn, name=podium.Name})
                                if dist <= Settings.StealRadius and dist < nearestDist then
                                    nearestPrompt=ch; nearestDist=dist; nearestName=podium.Name
                                end
                                break
                            end
                        end
                    end
                end
            end)
        end
    end
    return nearestPrompt, nearestDist, nearestName
end
local ProgressLabel, ProgressPercentLabel, ProgressBarFill, RadiusInput, DurationInput
local function ResetProgressBar()
    if ProgressLabel then ProgressLabel.Text = "READY" end
    if ProgressPercentLabel then ProgressPercentLabel.Text = "" end
    if ProgressBarFill then ProgressBarFill.Size = UDim2.new(0,0,1,0) end
end
local function executeSteal(prompt, name)
    local currentTime = tick()
    if currentTime - lastStealTick < STEAL_COOLDOWN then return end
    if isStealing then return end
    if not StealData[prompt] then
        StealData[prompt] = {hold={}, trigger={}, ready=true}
        pcall(function()
            if getconnections then
                for _, c in ipairs(getconnections(prompt.PromptButtonHoldBegan)) do
                    if c.Function then table.insert(StealData[prompt].hold, c.Function) end
                end
                for _, c in ipairs(getconnections(prompt.Triggered)) do
                    if c.Function then table.insert(StealData[prompt].trigger, c.Function) end
                end
            else StealData[prompt].useFallback = true end
        end)
    end
    local data = StealData[prompt]
    if not data.ready then return end
    data.ready=false; isStealing=true; stealStartTime=currentTime; lastStealTick=currentTime
    if ProgressLabel then ProgressLabel.Text = name or "STEALING..." end
    if progressConnection then progressConnection:Disconnect() end
    progressConnection = RunService.Heartbeat:Connect(function()
        if not isStealing then progressConnection:Disconnect(); return end
        local prog = math.clamp((tick()-stealStartTime)/Settings.StealDuration, 0, 1)
        if ProgressBarFill then ProgressBarFill.Size = UDim2.new(prog,0,1,0) end
        if ProgressPercentLabel then ProgressPercentLabel.Text = math.floor(prog*100).."%" end
    end)
    task.spawn(function()
        local ok = false
        pcall(function()
            if not data.useFallback then
                for _, f in ipairs(data.hold) do task.spawn(f) end
                task.wait(Settings.StealDuration)
                for _, f in ipairs(data.trigger) do task.spawn(f) end
                ok=true
            end
        end)
        if not ok and fireproximityprompt then
            pcall(function() fireproximityprompt(prompt); ok=true end)
        end
        if not ok then
            pcall(function()
                prompt:InputHoldBegin(); task.wait(Settings.StealDuration); prompt:InputHoldEnd(); ok=true
            end)
        end
        task.wait(Settings.StealDuration * 0.3)
        if progressConnection then progressConnection:Disconnect() end
        ResetProgressBar()
        task.wait(0.05)
        data.ready=true; isStealing=false
    end)
end
local function startAutoSteal()
    if Connections.autoSteal then return end
    Connections.autoSteal = RunService.Heartbeat:Connect(function()
        if not Enabled.AutoSteal or isStealing then return end
        local p,_,n = findNearestPrompt()
        if p then
            local char = LocalPlayer.Character
            local hrpLocal = char and char:FindFirstChild("HumanoidRootPart")
            if hrpLocal then
                hrpLocal.AssemblyLinearVelocity = Vector3.new(0, hrpLocal.AssemblyLinearVelocity.Y, 0)
            end
            executeSteal(p,n)
        end
    end)
end
local function stopAutoSteal()
    if Connections.autoSteal then Connections.autoSteal:Disconnect(); Connections.autoSteal=nil end
    isStealing=false; lastStealTick=0
    plotCache={}; plotCacheTime={}; cachedPrompts={}
    ResetProgressBar()
end
local function startAntiRagdoll()
    if Connections.antiRagdoll then return end
    Connections.antiRagdoll = RunService.Heartbeat:Connect(function()
        if not Enabled.AntiRagdoll then return end
        local char = LocalPlayer.Character; if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            local st = hum:GetState()
            if st==Enum.HumanoidStateType.Physics or st==Enum.HumanoidStateType.Ragdoll or st==Enum.HumanoidStateType.FallingDown then
                hum:ChangeState(Enum.HumanoidStateType.Running)
                workspace.CurrentCamera.CameraSubject = hum
                pcall(function()
                    local pm = LocalPlayer.PlayerScripts:FindFirstChild("PlayerModule")
                    if pm then require(pm:FindFirstChild("ControlModule")):Enable() end
                end)
                if root then root.Velocity=Vector3.new(0,0,0); root.RotVelocity=Vector3.new(0,0,0) end
            end
        end
        for _, obj in ipairs(char:GetDescendants()) do
            if obj:IsA("Motor6D") and not obj.Enabled then obj.Enabled=true end
        end
    end)
end
local function stopAntiRagdoll()
    if Connections.antiRagdoll then Connections.antiRagdoll:Disconnect(); Connections.antiRagdoll=nil end
end
local IJ_JumpConn = nil
local IJ_FallConn = nil
local function startInfiniteJump()
    if IJ_JumpConn then IJ_JumpConn:Disconnect() end
    if IJ_FallConn then IJ_FallConn:Disconnect() end
    IJ_JumpConn = UserInputService.JumpRequest:Connect(function()
        if not Enabled.InfiniteJump then return end
        local char = LocalPlayer.Character; if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then root.Velocity = Vector3.new(root.Velocity.X, 55, root.Velocity.Z) end
    end)
    IJ_FallConn = RunService.Heartbeat:Connect(function()
        if not Enabled.InfiniteJump then return end
        local char = LocalPlayer.Character; if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if root and root.Velocity.Y < -120 then
            root.Velocity = Vector3.new(root.Velocity.X, -120, root.Velocity.Z)
        end
    end)
end
local function stopInfiniteJump()
    if IJ_JumpConn then IJ_JumpConn:Disconnect(); IJ_JumpConn = nil end
    if IJ_FallConn then IJ_FallConn:Disconnect(); IJ_FallConn = nil end
end
local function startUnwalk()
    local c = LocalPlayer.Character; if not c then return end
    local hum = c:FindFirstChildOfClass("Humanoid")
    if hum then for _,t in ipairs(hum:GetPlayingAnimationTracks()) do t:Stop() end end
    local anim = c:FindFirstChild("Animate")
    if anim then savedAnimations.Animate=anim:Clone(); anim:Destroy() end
end
local function stopUnwalk()
    local c = LocalPlayer.Character
    if c and savedAnimations.Animate then savedAnimations.Animate:Clone().Parent=c; savedAnimations.Animate=nil end
end
local function applyAntiLag(ultra)
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 1e10
    Lighting.Brightness = 1
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0
    for _, e in pairs(Lighting:GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect")
            or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then e.Enabled = false end
    end
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.Plastic
            obj.Reflectance = 0
            if ultra then obj.CastShadow = false end
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            if ultra then obj:Destroy() else obj.Transparency = 1 end
        elseif ultra and (obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Fire")) then
            obj.Enabled = false
        end
    end
    if ultra then pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end) end
end
local function enableOptimizer()
    Enabled.Optimizer = true
    applyAntiLag(false)
    if _antiLagDescConn then _antiLagDescConn:Disconnect() end
    _antiLagDescConn = workspace.DescendantAdded:Connect(function(obj)
        if obj:IsA("BasePart") then obj.Material = Enum.Material.Plastic; obj.Reflectance = 0
        elseif obj:IsA("Decal") or obj:IsA("Texture") then obj.Transparency = 1 end
    end)
end
local function disableOptimizer()
    Enabled.Optimizer = false
    if _antiLagDescConn then _antiLagDescConn:Disconnect(); _antiLagDescConn = nil end
end
local function enableUltraMode()
    ultraModeEnabled = true
    applyAntiLag(true)
end
local function disableUltraMode()
    ultraModeEnabled = false
end
local removedAccessories = {}
local function removeAccessories()
    if Enabled.RemoveAccessories then
        local char = LocalPlayer.Character
        if not char then return end
        for _, obj in ipairs(char:GetDescendants()) do
            if obj:IsA("Accessory") or obj:IsA("Hat") then
                if not removedAccessories[obj] then
                    removedAccessories[obj] = true
                    obj:Destroy()
                end
            end
        end
    end
end
local function startRemoveAccessories()
    Enabled.RemoveAccessories = true
    removeAccessories()
    if not Connections.removeAccessories then
        Connections.removeAccessories = LocalPlayer.CharacterAdded:Connect(function()
            task.wait(0.5)
            if Enabled.RemoveAccessories then removeAccessories() end
        end)
    end
end
local function stopRemoveAccessories()
    Enabled.RemoveAccessories = false
    if Connections.removeAccessories then
        Connections.removeAccessories:Disconnect()
        Connections.removeAccessories = nil
    end
    removedAccessories = {}
end
local dropBrainrotActive = false
local DROP_ASCEND_DURATION = 0.2
local DROP_ASCEND_SPEED = 150
local setDropBrainrotVisual = nil
local dropMobileSetter = nil
local function runDropBrainrot()
    if dropBrainrotActive then return end
    local char = LocalPlayer.Character; if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
    dropBrainrotActive = true
    local t0 = tick()
    local dc
    dc = RunService.Heartbeat:Connect(function()
        local r = char and char:FindFirstChild("HumanoidRootPart")
        if not r then
            dc:Disconnect(); dropBrainrotActive = false
            if setDropBrainrotVisual then setDropBrainrotVisual(false) end
            if dropMobileSetter then dropMobileSetter(false) end
            return
        end
        if tick() - t0 >= DROP_ASCEND_DURATION then
            dc:Disconnect()
            local rp = RaycastParams.new()
            rp.FilterDescendantsInstances = {char}
            rp.FilterType = Enum.RaycastFilterType.Exclude
            local rr = workspace:Raycast(r.Position, Vector3.new(0,-2000,0), rp)
            if rr then
                local hum2 = char:FindFirstChildOfClass("Humanoid")
                local off = (hum2 and hum2.HipHeight or 2) + (r.Size.Y/2)
                r.CFrame = CFrame.new(r.Position.X, rr.Position.Y+off, r.Position.Z)
                r.AssemblyLinearVelocity = Vector3.new(0,0,0)
            end
            dropBrainrotActive = false
            if setDropBrainrotVisual then setDropBrainrotVisual(false) end
            if dropMobileSetter then dropMobileSetter(false) end
            return
        end
        r.AssemblyLinearVelocity = Vector3.new(r.AssemblyLinearVelocity.X, DROP_ASCEND_SPEED, r.AssemblyLinearVelocity.Z)
    end)
end
local floatEnabled = false
local floatHeight = 9.5
local function enableNoCameraCollision()
    noCamCollisionEnabled = true
    if noCamCollisionConn then noCamCollisionConn:Disconnect() end
    noCamCollisionConn = RunService.RenderStepped:Connect(function()
        if not noCamCollisionEnabled then return end
        local ch = LocalPlayer.Character; if not ch then return end
        local cam = workspace.CurrentCamera; if not cam then return end
        local hrpLocal = ch:FindFirstChild("HumanoidRootPart"); if not hrpLocal then return end
        local camPos = cam.CFrame.Position
        local charPos = hrpLocal.Position + Vector3.new(0, 1.5, 0)
        local toChar = charPos - camPos
        local dist = toChar.Magnitude
        if dist < 0.3 then return end
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = {ch}
        params.IgnoreWater = true
        local hit = {}
        local origin = camPos
        local remaining = toChar
        for _ = 1, 12 do
            if remaining.Magnitude < 0.2 then break end
            local res = workspace:Raycast(origin, remaining, params)
            if not res then break end
            local p = res.Instance
            if p and p:IsA("BasePart") and not p:IsDescendantOf(ch) then
                hit[p] = true
                if noCamParts[p] == nil then noCamParts[p] = p.LocalTransparencyModifier end
                p.LocalTransparencyModifier = 1
            end
            origin = res.Position + remaining.Unit * 0.02
            remaining = charPos - origin
        end
        for p, orig in pairs(noCamParts) do
            if not hit[p] then
                pcall(function()
                    if p and p.Parent then p.LocalTransparencyModifier = orig end
                end)
                noCamParts[p] = nil
            end
        end
    end)
end
local function disableNoCameraCollision()
    noCamCollisionEnabled = false
    if noCamCollisionConn then noCamCollisionConn:Disconnect(); noCamCollisionConn = nil end
    for p, orig in pairs(noCamParts) do
        pcall(function() if p and p.Parent then p.LocalTransparencyModifier = orig end end)
    end
    noCamParts = {}
end
local function startFloat()
    if Connections.float then Connections.float:Disconnect() end
    Connections.float = RunService.Heartbeat:Connect(function()
        if not floatEnabled then return end
        local char = LocalPlayer.Character; if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
        local rp = RaycastParams.new()
        rp.FilterDescendantsInstances = {char}
        rp.FilterType = Enum.RaycastFilterType.Exclude
        local rr = workspace:Raycast(root.Position, Vector3.new(0,-200,0), rp)
        if rr then
            local diff = (rr.Position.Y + floatHeight) - root.Position.Y
            if math.abs(diff) > 0.3 then
                root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, diff*15, root.AssemblyLinearVelocity.Z)
            else
                root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, 0, root.AssemblyLinearVelocity.Z)
            end
        end
    end)
end
local function stopFloat()
    if Connections.float then Connections.float:Disconnect(); Connections.float = nil end
    local char = LocalPlayer.Character
    if char then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, 0, root.AssemblyLinearVelocity.Z) end
    end
end
local animHeartbeatConn = nil
local originalAnims = nil
local harderHitAnimEnabled = false
local Anims = {
    idle1="rbxassetid://133806214992291",idle2="rbxassetid://94970088341563",
    walk="rbxassetid://707897309",run="rbxassetid://707861613",
    jump="rbxassetid://116936326516985",fall="rbxassetid://116936326516985",
    climb="rbxassetid://116936326516985",swim="rbxassetid://116936326516985",
    swimidle="rbxassetid://116936326516985",
}
local function saveOriginalAnims(char)
    local animate = char:FindFirstChild("Animate"); if not animate then return end
    local function g(obj) return obj and obj.AnimationId or nil end
    originalAnims = {
        idle1=g(animate.idle and animate.idle.Animation1),idle2=g(animate.idle and animate.idle.Animation2),
        walk=g(animate.walk and animate.walk.WalkAnim),run=g(animate.run and animate.run.RunAnim),
        jump=g(animate.jump and animate.jump.JumpAnim),fall=g(animate.fall and animate.fall.FallAnim),
        climb=g(animate.climb and animate.climb.ClimbAnim),swim=g(animate.swim and animate.swim.Swim),
        swimidle=g(animate.swimidle and animate.swimidle.SwimIdle),
    }
end
local function applyAnimPack(char)
    local animate = char:FindFirstChild("Animate"); if not animate then return end
    local function s(obj, id) if obj then obj.AnimationId = id end end
    s(animate.idle and animate.idle.Animation1, Anims.idle1)
    s(animate.idle and animate.idle.Animation2, Anims.idle2)
    s(animate.walk and animate.walk.WalkAnim, Anims.walk)
    s(animate.run and animate.run.RunAnim, Anims.run)
    s(animate.jump and animate.jump.JumpAnim, Anims.jump)
    s(animate.fall and animate.fall.FallAnim, Anims.fall)
    s(animate.climb and animate.climb.ClimbAnim, Anims.climb)
    s(animate.swim and animate.swim.Swim, Anims.swim)
    s(animate.swimidle and animate.swimidle.SwimIdle, Anims.swimidle)
end
local function restoreOriginalAnims(char)
    if not originalAnims then return end
    local animate = char:FindFirstChild("Animate"); if not animate then return end
    local function s(obj, id) if obj and id then obj.AnimationId = id end end
    s(animate.idle and animate.idle.Animation1, originalAnims.idle1)
    s(animate.idle and animate.idle.Animation2, originalAnims.idle2)
    s(animate.walk and animate.walk.WalkAnim, originalAnims.walk)
    s(animate.run and animate.run.RunAnim, originalAnims.run)
    s(animate.jump and animate.jump.JumpAnim, originalAnims.jump)
    s(animate.fall and animate.fall.FallAnim, originalAnims.fall)
    s(animate.climb and animate.climb.ClimbAnim, originalAnims.climb)
    s(animate.swim and animate.swim.Swim, originalAnims.swim)
    s(animate.swimidle and animate.swimidle.SwimIdle, originalAnims.swimidle)
    local hum2 = char:FindFirstChildOfClass("Humanoid")
    if hum2 then for _, t in ipairs(hum2:GetPlayingAnimationTracks()) do t:Stop(0) end end
end
local function startHarderHitAnim()
    if animHeartbeatConn then animHeartbeatConn:Disconnect(); animHeartbeatConn = nil end
    local char = LocalPlayer.Character
    if char then
        saveOriginalAnims(char); applyAnimPack(char)
        local hum2 = char:FindFirstChildOfClass("Humanoid")
        if hum2 then for _, t in ipairs(hum2:GetPlayingAnimationTracks()) do t:Stop(0) end end
    end
    animHeartbeatConn = RunService.Heartbeat:Connect(function()
        if not harderHitAnimEnabled then return end
        local c = LocalPlayer.Character
        if c then applyAnimPack(c) end
    end)
end
local function stopHarderHitAnim()
    if animHeartbeatConn then animHeartbeatConn:Disconnect(); animHeartbeatConn = nil end
    local char = LocalPlayer.Character
    if char then restoreOriginalAnims(char) end
end
local MEDUSA_COOLDOWN = 25
local medusaLastUsed = 0
local medusaDebounce = false
local medusaCounterEnabled = false
local medusaAnchorConns = {}
local function findMedusa()
    local char = LocalPlayer.Character; if not char then return nil end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            local tn = tool.Name:lower()
            if tn:find("medusa") or tn:find("head") or tn:find("stone") then return tool end
        end
    end
    local bp = LocalPlayer:FindFirstChild("Backpack")
    if bp then
        for _, tool in ipairs(bp:GetChildren()) do
            if tool:IsA("Tool") then
                local tn = tool.Name:lower()
                if tn:find("medusa") or tn:find("head") or tn:find("stone") then return tool end
            end
        end
    end
    return nil
end
local function useMedusaCounter()
    if medusaDebounce then return end
    if tick() - medusaLastUsed < MEDUSA_COOLDOWN then return end
    local char = LocalPlayer.Character; if not char then return end
    medusaDebounce = true
    local med = findMedusa()
    if not med then medusaDebounce = false; return end
    if med.Parent ~= char then
        local hum2 = char:FindFirstChildOfClass("Humanoid")
        if hum2 then hum2:EquipTool(med) end
    end
    pcall(function() med:Activate() end)
    medusaLastUsed = tick(); medusaDebounce = false
end
local function stopMedusaCounter()
    for _, c in pairs(medusaAnchorConns) do pcall(function() c:Disconnect() end) end
    medusaAnchorConns = {}
end
local function setupMedusaCounter(char)
    stopMedusaCounter(); if not char then return end
    local function onAnchorChanged(part)
        return part:GetPropertyChangedSignal("Anchored"):Connect(function()
            if medusaCounterEnabled and part.Anchored and part.Transparency == 1 then
                useMedusaCounter()
            end
        end)
    end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then table.insert(medusaAnchorConns, onAnchorChanged(part)) end
    end
    table.insert(medusaAnchorConns, char.DescendantAdded:Connect(function(part)
        if part:IsA("BasePart") then table.insert(medusaAnchorConns, onAnchorChanged(part)) end
    end))
end
local function doReturnTeleport(side)
    if brainrotReturnCooldown then return end
    brainrotReturnCooldown = true
    task.spawn(function()
        pcall(function()
            local c = LocalPlayer.Character
            if not c then return end
            local root = c:FindFirstChild("HumanoidRootPart")
            local hum = c:FindFirstChildOfClass("Humanoid")
            if not root then return end
            local rotation = (side == "right") and math.rad(180) or 0
            local step2 = (side == "right") and BR_R2 or BR_L2
            local step3 = (side == "right") and BR_R3 or BR_L3
            local function tp(pos)
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
                root.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0)) * CFrame.Angles(0, rotation, 0)
                if hum then hum:ChangeState(Enum.HumanoidStateType.Running); hum:Move(Vector3.zero, false) end
                for _, obj in ipairs(c:GetDescendants()) do
                    if obj:IsA("Motor6D") and not obj.Enabled then obj.Enabled = true end
                end
            end
            tp(step2); task.wait(0.1); tp(step3)
        end)
        local _c = LocalPlayer.Character
        local _hum = _c and _c:FindFirstChildOfClass("Humanoid")
        if _hum then lastKnownHealth = _hum.Health end
        brainrotReturnCooldown = false
        if G_autoPlayAfterTP and G_myPlotSide then
            task.wait(0.3)
            local side2 = G_myPlotSide
            if fullAutoPlayLeftEnabled then stopFullAutoLeft(); fullAutoPlayLeftEnabled = false; if fullAutoLeftSetter then fullAutoLeftSetter(false) end end
            if fullAutoPlayRightEnabled then stopFullAutoRight(); fullAutoPlayRightEnabled = false; if fullAutoRightSetter then fullAutoRightSetter(false) end end
            task.wait(0.1)
            if side2 == "left" then
                fullAutoPlayLeftEnabled = true
                if fullAutoLeftSetter then fullAutoLeftSetter(true) end
                startFullAutoLeft()
                if VisualSetters.FullAuto then VisualSetters.FullAuto(true) end
            elseif side2 == "right" then
                fullAutoPlayRightEnabled = true
                if fullAutoRightSetter then fullAutoRightSetter(true) end
                startFullAutoRight()
                if VisualSetters.FullAuto then VisualSetters.FullAuto(true) end
            end
        end
    end)
end
RunService.Heartbeat:Connect(function()
    if not G_tpAutoEnabled then return end
    if brainrotReturnCooldown then return end
    if G_countdownActive then return end
    local char = LocalPlayer.Character; if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return end
    local hrpLocal = char:FindFirstChild("HumanoidRootPart")
    if hrpLocal and hrpLocal.Anchored then lastKnownHealth = hum.Health; return end
    local hp = hum.Health
    local st = hum:GetState()
    local rag = st == Enum.HumanoidStateType.Physics or st == Enum.HumanoidStateType.Ragdoll or st == Enum.HumanoidStateType.FallingDown
    local wasHit = hp < lastKnownHealth - 1; lastKnownHealth = hp
    if not (wasHit or rag) then return end
    if fullAutoPlayLeftEnabled then stopFullAutoLeft(); fullAutoPlayLeftEnabled = false; if fullAutoLeftSetter then fullAutoLeftSetter(false) end end
    if fullAutoPlayRightEnabled then stopFullAutoRight(); fullAutoPlayRightEnabled = false; if fullAutoRightSetter then fullAutoRightSetter(false) end end
    local side = G_myPlotSide
    if side == "left" then doReturnTeleport("left")
    elseif side == "right" then doReturnTeleport("right") end
end)
local function monitorCountdown(snd)
    if snd.Name ~= "Countdown" or not snd:IsA("Sound") then return end
    local triggered, conn = false, nil
    G_countdownActive = true
    conn = RunService.Heartbeat:Connect(function()
        if not snd or not snd.Parent or not snd.Playing then
            G_countdownActive = false
            if conn then conn:Disconnect(); conn = nil end; return
        end
        local ct = snd.TimePosition
        if ct >= COUNTDOWN_TARGET and not triggered then
            triggered = true; G_countdownActive = false
            if conn then conn:Disconnect(); conn = nil end
            if not G_tpAutoEnabled then return end
            local side = G_myPlotSide
            if not side then return end
            if fullAutoPlayLeftEnabled then stopFullAutoLeft(); fullAutoPlayLeftEnabled = false; if fullAutoLeftSetter then fullAutoLeftSetter(false) end end
            if fullAutoPlayRightEnabled then stopFullAutoRight(); fullAutoPlayRightEnabled = false; if fullAutoRightSetter then fullAutoRightSetter(false) end end
            task.wait(0.1)
            if side == "left" then
                fullAutoPlayRightEnabled = true
                if fullAutoRightSetter then fullAutoRightSetter(true) end
                startFullAutoRight()
                if VisualSetters.FullAuto then VisualSetters.FullAuto(true) end
            elseif side == "right" then
                fullAutoPlayLeftEnabled = true
                if fullAutoLeftSetter then fullAutoLeftSetter(true) end
                startFullAutoLeft()
                if VisualSetters.FullAuto then VisualSetters.FullAuto(true) end
            end
        end
        if ct > COUNTDOWN_TARGET + 2 then G_countdownActive = false; if conn then conn:Disconnect(); conn = nil end end
    end)
end
workspace.ChildAdded:Connect(function(child)
    if child.Name == "Countdown" and child:IsA("Sound") then monitorCountdown(child) end
end)
do local ex = workspace:FindFirstChild("Countdown"); if ex and ex:IsA("Sound") then monitorCountdown(ex) end end
local FAP_L1 = Vector3.new(-476.48, -6.28, 92.73)
local FAP_L2 = Vector3.new(-482.85, -5.03, 93.13)
local FAP_L3 = Vector3.new(-475.68, -6.89, 92.76)
local FAP_L4 = Vector3.new(-476.50, -6.46, 27.58)
local FAP_L5 = Vector3.new(-482.42, -5.03, 27.84)
local FAP_R1 = Vector3.new(-476.16, -6.52, 25.62)
local FAP_R2 = Vector3.new(-483.06, -5.03, 27.51)
local FAP_R3 = Vector3.new(-476.21, -6.63, 27.46)
local FAP_R4 = Vector3.new(-476.66, -6.39, 92.44)
local FAP_R5 = Vector3.new(-481.94, -5.03, 92.42)
local FACE_FAP_L = Vector3.new(-482.25, -4.96, 92.09)
local FACE_FAP_R = Vector3.new(-482.06, -6.93, 35.47)
local FAP_LeftPhase = 1
local FAP_RightPhase = 1
local function makeFullAutoPlay(getEnabled, setEnabled, getPhase, setPhase, getConn, setConn, getVisual, getMobSetter, p1, p2, p3, p4, p5, faceTgt)
    local pts = {p1, p2, p3, p4, p5}
    local function stop()
        local c = getConn(); if c then c:Disconnect(); setConn(nil) end
        setPhase(1)
        local char = LocalPlayer.Character
        if char then local hum2 = char:FindFirstChildOfClass("Humanoid"); if hum2 then hum2:Move(Vector3.zero, false) end end
    end
    local function start()
        stop(); setPhase(1)
        setConn(RunService.Heartbeat:Connect(function()
            if not getEnabled() then return end
            local char = LocalPlayer.Character; if not char then return end
            local rp = char:FindFirstChild("HumanoidRootPart")
            local hum2 = char:FindFirstChildOfClass("Humanoid")
            if not rp or not hum2 then return end
            local ph = getPhase()
            local tgt = pts[ph]
            local spd
            if fastestStealEnabled and ph >= 4 then
                local dist = Vector3.new(tgt.X - rp.Position.X, 0, tgt.Z - rp.Position.Z).Magnitude
                if dist > 0.1 then
                    spd = math.clamp(dist / 1.653, 28, 29)
                else
                    spd = CARRY_SPEED
                end
            else
                spd = ph >= 3 and CARRY_SPEED or NORMAL_SPEED
            end
            if (Vector3.new(tgt.X, rp.Position.Y, tgt.Z) - rp.Position).Magnitude < 1 then
                if ph == 5 then
                    hum2:Move(Vector3.zero, false); rp.AssemblyLinearVelocity = Vector3.zero
                    setEnabled(false); stop()
                    local v = getVisual(); if v then v(false) end
                    local mv2 = getMobSetter(); if mv2 then mv2(false) end
                    if faceTgt then
                        local dir = Vector3.new(faceTgt.X, rp.Position.Y, faceTgt.Z) - rp.Position
                        if dir.Magnitude > 0.01 then rp.CFrame = CFrame.new(rp.Position, rp.Position + dir.Unit) end
                    end
                    return
                elseif ph == 2 then
                    hum2:Move(Vector3.zero, false); rp.AssemblyLinearVelocity = Vector3.zero
                    task.wait(0.05); setPhase(3); return
                else
                    setPhase(ph + 1); return
                end
            end
            local d = tgt - rp.Position
            local mv3 = Vector3.new(d.X, 0, d.Z).Unit
            hum2:Move(mv3, false); rp.AssemblyLinearVelocity = Vector3.new(mv3.X * spd, rp.AssemblyLinearVelocity.Y, mv3.Z * spd)
        end))
    end
    return start, stop
end
local startFullAutoLeft, stopFullAutoLeft = makeFullAutoPlay(
    function() return fullAutoPlayLeftEnabled end,
    function(v) fullAutoPlayLeftEnabled = v end,
    function() return FAP_LeftPhase end,
    function(v) FAP_LeftPhase = v end,
    function() return fullAutoPlayLeftConn end,
    function(v) fullAutoPlayLeftConn = v end,
    function() return fullAutoLeftSetter end,
    function() return nil end,
    FAP_L1, FAP_L2, FAP_L3, FAP_L4, FAP_L5, FACE_FAP_L
)
local startFullAutoRight, stopFullAutoRight = makeFullAutoPlay(
    function() return fullAutoPlayRightEnabled end,
    function(v) fullAutoPlayRightEnabled = v end,
    function() return FAP_RightPhase end,
    function(v) FAP_RightPhase = v end,
    function() return fullAutoPlayRightConn end,
    function(v) fullAutoPlayRightConn = v end,
    function() return fullAutoRightSetter end,
    function() return nil end,
    FAP_R1, FAP_R2, FAP_R3, FAP_R4, FAP_R5, FACE_FAP_R
)
local function startFullAutoPlay() end
local function stopFullAutoPlay() end
local function findBat()
    local c = LocalPlayer.Character; if not c then return nil end
    local bp = LocalPlayer:FindFirstChildOfClass("Backpack")
    local SlapList = {"Bat","Slap","Iron Slap","Gold Slap","Diamond Slap","Emerald Slap","Ruby Slap","Dark Matter Slap","Flame Slap","Nuclear Slap","Galaxy Slap","Glitched Slap"}
    for _, name in ipairs(SlapList) do
        local t = c:FindFirstChild(name) or (bp and bp:FindFirstChild(name))
        if t then return t end
    end
    for _, ch in ipairs(c:GetChildren()) do if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end end
    if bp then for _, ch in ipairs(bp:GetChildren()) do if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end end end
    return nil
end
local function getClosestPlayer()
    local c = LocalPlayer.Character; if not c then return nil end
    local hrpLocal = c:FindFirstChild("HumanoidRootPart"); if not hrpLocal then return nil end
    local cp, cd = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local tr = p.Character:FindFirstChild("HumanoidRootPart")
            if tr then
                local d = (hrpLocal.Position - tr.Position).Magnitude
                if d < cd then cd = d; cp = p end
            end
        end
    end
    return cp
end
local _batT = 0
RunService.Heartbeat:Connect(function()
    local now = tick()
    if autoBatToggled and now - _batT >= 1/30 then
        _batT = now
        local c = LocalPlayer.Character; if c then
            local hrpLocal = c:FindFirstChild("HumanoidRootPart"); if hrpLocal then
                local target = getClosestPlayer()
                if target and target.Character then
                    local tr = target.Character:FindFirstChild("HumanoidRootPart")
                    if tr then
                        local fp = tr.Position + tr.CFrame.LookVector * 1.5
                        local dir = (fp - hrpLocal.Position).Unit
                        hrpLocal.AssemblyLinearVelocity = Vector3.new(dir.X*56.5, dir.Y*56.5, dir.Z*56.5)
                    end
                end
            end
        end
    end
    if autoBatToggled then
        local c = LocalPlayer.Character; if c then
            local bat = findBat(); if bat then
                if bat.Parent ~= c then local hum2 = c:FindFirstChildOfClass("Humanoid"); if hum2 then hum2:EquipTool(bat) end end
                if now - lastBatSwing >= BAT_SWING_COOLDOWN then
                    lastBatSwing = now; pcall(function() bat:Activate() end)
                end
            end
        end
    end
end)
local function runTPDown()
    local wasFloating = floatEnabled
    if wasFloating then stopFloat() end
    task.spawn(function()
        pcall(function()
            local c = LocalPlayer.Character; if not c then return end
            local hrpLocal = c:FindFirstChild("HumanoidRootPart"); if not hrpLocal then return end
            local hum = c:FindFirstChildOfClass("Humanoid"); if not hum then return end
            local rp = RaycastParams.new(); rp.FilterDescendantsInstances = {c}; rp.FilterType = Enum.RaycastFilterType.Exclude
            local hit = workspace:Raycast(hrpLocal.Position, Vector3.new(0,-500,0), rp)
            if hit then
                hrpLocal.AssemblyLinearVelocity = Vector3.zero
                hrpLocal.AssemblyAngularVelocity = Vector3.zero
                local hh = hum.HipHeight or 2
                local hy = hrpLocal.Size.Y / 2
                hrpLocal.CFrame = CFrame.new(hit.Position.X, hit.Position.Y + hh + hy + 0.1, hit.Position.Z)
                hrpLocal.AssemblyLinearVelocity = Vector3.zero
            end
        end)
        task.wait(0.1)
        if wasFloating then startFloat() end
        if VisualSetters and VisualSetters.TPDownReset then VisualSetters.TPDownReset() end
    end)
end

-- ============================================================
-- MAIN GUI (111 DUEL - Interface simplifiée)
-- ============================================================
;(function()
local C_BG     = Color3.fromRGB(12, 12, 18)
local C_CARD   = Color3.fromRGB(20, 20, 30)
local C_ACCENT = Color3.fromRGB(130, 90, 220)
local C_RED    = Color3.fromRGB(210, 50, 75)
local C_DIM    = Color3.fromRGB(120, 120, 135)
local C_SW_OFF = Color3.fromRGB(35, 35, 48)
local C_WHITE  = Color3.fromRGB(255, 255, 255)
local C_GREEN  = Color3.fromRGB(50, 200, 100)

local sideSetters = {}

gui = Instance.new("ScreenGui")
gui.Name = "DuelHubGUI"; gui.ResetOnSpawn = false; gui.DisplayOrder = 10
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- PROGRESS BAR (steal indicator)
local progressBar = Instance.new("Frame", gui)
progressBar.Size = UDim2.new(0, 320, 0, 48)
progressBar.Position = UDim2.new(0.5, -160, 1, -65)
progressBar.BackgroundColor3 = C_BG; progressBar.BorderSizePixel = 0; progressBar.Active = true; progressBar.ZIndex = 50
Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 8)
local pbStroke = Instance.new("UIStroke", progressBar)
pbStroke.Color = C_ACCENT; pbStroke.Thickness = 1.5
do
    local drag, ds, sp = false
    progressBar.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            drag = true; ds = inp.Position; sp = progressBar.Position
            inp.Changed:Connect(function() if inp.UserInputState == Enum.UserInputState.End then drag = false end end)
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if drag and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local d = inp.Position - ds
            progressBar.Position = UDim2.new(sp.X.Scale, sp.X.Offset+d.X, sp.Y.Scale, sp.Y.Offset+d.Y)
        end
    end)
end
ProgressLabel = Instance.new("TextLabel", progressBar)
ProgressLabel.Size = UDim2.new(0.45, 0, 0, 16); ProgressLabel.Position = UDim2.new(0, 8, 0, 6)
ProgressLabel.BackgroundTransparency = 1; ProgressLabel.Text = "READY"; ProgressLabel.TextColor3 = C_ACCENT
ProgressLabel.Font = Enum.Font.GothamBlack; ProgressLabel.TextSize = 11; ProgressLabel.TextXAlignment = Enum.TextXAlignment.Left; ProgressLabel.ZIndex = 51
ProgressPercentLabel = Instance.new("TextLabel", progressBar)
ProgressPercentLabel.Size = UDim2.new(1, -8, 0, 16); ProgressPercentLabel.Position = UDim2.new(0, 0, 0, 6)
ProgressPercentLabel.BackgroundTransparency = 1; ProgressPercentLabel.Text = ""; ProgressPercentLabel.TextColor3 = C_WHITE
ProgressPercentLabel.Font = Enum.Font.GothamBlack; ProgressPercentLabel.TextSize = 12; ProgressPercentLabel.TextXAlignment = Enum.TextXAlignment.Right; ProgressPercentLabel.ZIndex = 51
local pTrack = Instance.new("Frame", progressBar)
pTrack.Size = UDim2.new(1, -16, 0, 14); pTrack.Position = UDim2.new(0, 8, 0, 26)
pTrack.BackgroundColor3 = C_SW_OFF; pTrack.BorderSizePixel = 0; pTrack.ZIndex = 50
Instance.new("UICorner", pTrack).CornerRadius = UDim.new(0, 4)
ProgressBarFill = Instance.new("Frame", pTrack)
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0); ProgressBarFill.BackgroundColor3 = C_ACCENT
ProgressBarFill.BorderSizePixel = 0; ProgressBarFill.ZIndex = 51
Instance.new("UICorner", ProgressBarFill).CornerRadius = UDim.new(0, 4)

-- MAIN FRAME
main = Instance.new("Frame")
main.Name = "Main"
main.Size = getMobileOptimized(UDim2.new(0, 340, 0, 520), UDim2.new(0, 290, 0, 460))
main.Position = getMobileOptimized(UDim2.new(0, 10, 0, 60), UDim2.new(0.5, -145, 0, 50))
main.BackgroundColor3 = C_BG; main.BorderSizePixel = 0; main.Active = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)
local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = C_ACCENT; mainStroke.Thickness = 1.5

-- Draggable
do
    local drag, ds, sp = false
    main.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            drag = true; ds = inp.Position; sp = main.Position
            inp.Changed:Connect(function() if inp.UserInputState == Enum.UserInputState.End then drag = false end end)
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if drag and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local d = inp.Position - ds
            main.Position = UDim2.new(sp.X.Scale, sp.X.Offset+d.X, sp.Y.Scale, sp.Y.Offset+d.Y)
        end
    end)
end

-- HEADER
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 50); header.BackgroundColor3 = C_CARD; header.BorderSizePixel = 0; header.ZIndex = 3
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 14)
local headerFix = Instance.new("Frame", header)
headerFix.Size = UDim2.new(1, 0, 0, 14); headerFix.Position = UDim2.new(0, 0, 1, -14)
headerFix.BackgroundColor3 = C_CARD; headerFix.BorderSizePixel = 0; headerFix.ZIndex = 2

local titleLbl = Instance.new("TextLabel", header)
titleLbl.Size = UDim2.new(1, -90, 1, 0); titleLbl.Position = UDim2.new(0, 14, 0, 0)
titleLbl.BackgroundTransparency = 1; titleLbl.Text = "111 DUEL"
titleLbl.TextColor3 = C_WHITE; titleLbl.Font = Enum.Font.GothamBlack
titleLbl.TextSize = getMobileOptimized(20, 16); titleLbl.TextXAlignment = Enum.TextXAlignment.Left; titleLbl.ZIndex = 4

local fpsLbl = Instance.new("TextLabel", header)
fpsLbl.Size = UDim2.new(0, 60, 1, 0); fpsLbl.Position = UDim2.new(1, -120, 0, 0)
fpsLbl.BackgroundTransparency = 1; fpsLbl.Text = "60 FPS"
fpsLbl.TextColor3 = C_ACCENT; fpsLbl.Font = Enum.Font.GothamBold
fpsLbl.TextSize = getMobileOptimized(11, 9); fpsLbl.TextXAlignment = Enum.TextXAlignment.Right; fpsLbl.ZIndex = 4

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 32, 0, 32); closeBtn.Position = UDim2.new(1, -40, 0.5, -16)
closeBtn.BackgroundColor3 = C_RED; closeBtn.BorderSizePixel = 0
closeBtn.Text = "×"; closeBtn.TextColor3 = C_WHITE
closeBtn.Font = Enum.Font.GothamBold; closeBtn.TextSize = 22; closeBtn.ZIndex = 8
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

local reopenBtn = Instance.new("TextButton", gui)
reopenBtn.Size = UDim2.new(0, 44, 0, 44); reopenBtn.Position = UDim2.new(0, 10, 0, 60)
reopenBtn.BackgroundColor3 = C_ACCENT; reopenBtn.BorderSizePixel = 0
reopenBtn.Text = "111"; reopenBtn.TextColor3 = C_WHITE
reopenBtn.Font = Enum.Font.GothamBlack; reopenBtn.TextSize = 13; reopenBtn.ZIndex = 20; reopenBtn.Visible = false
Instance.new("UICorner", reopenBtn).CornerRadius = UDim.new(0, 10)

closeBtn.MouseButton1Click:Connect(function()
    main.Visible = false; reopenBtn.Visible = true
end)
reopenBtn.MouseButton1Click:Connect(function()
    reopenBtn.Visible = false; main.Visible = true
end)
closeBtn.MouseEnter:Connect(function() TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundColor3=Color3.fromRGB(255,70,90)}):Play() end)
closeBtn.MouseLeave:Connect(function() TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundColor3=C_RED}):Play() end)

-- FPS update
local lastFrameT = tick()
RunService.RenderStepped:Connect(function()
    local now = tick()
    local fps = 1 / math.max(now - lastFrameT, 0.001)
    lastFrameT = now
    fpsLbl.Text = string.format("%d FPS", fps)
    fpsLbl.TextColor3 = fps >= 50 and C_GREEN or fps >= 30 and Color3.fromRGB(255,180,80) or C_RED
end)

-- SCROLL
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, -16, 1, -58); scroll.Position = UDim2.new(0, 8, 0, 54)
scroll.BackgroundTransparency = 1; scroll.BorderSizePixel = 0; scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = C_ACCENT; scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.CanvasSize = UDim2.new(0,0,0,0); scroll.ZIndex = 2
local vstack = Instance.new("Frame", scroll)
vstack.Size = UDim2.new(1, 0, 0, 0); vstack.AutomaticSize = Enum.AutomaticSize.Y
vstack.BackgroundTransparency = 1
local vLayout = Instance.new("UIListLayout", vstack)
vLayout.Padding = UDim.new(0, 6); vLayout.SortOrder = Enum.SortOrder.LayoutOrder

local orderN = 0
local function O() orderN = orderN + 1; return orderN end

-- Section label helper
local function mkSection(txt)
    local f = Instance.new("Frame", vstack)
    f.Size = UDim2.new(1, 0, 0, 24); f.BackgroundTransparency = 1; f.LayoutOrder = O()
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, 0, 1, 0); l.BackgroundTransparency = 1
    l.Text = "▸ " .. txt:upper(); l.TextColor3 = C_ACCENT
    l.Font = Enum.Font.GothamBold; l.TextSize = 10; l.TextXAlignment = Enum.TextXAlignment.Left
    local line = Instance.new("Frame", f)
    line.Size = UDim2.new(1, 0, 0, 1); line.Position = UDim2.new(0, 0, 1, -1)
    line.BackgroundColor3 = C_ACCENT; line.BackgroundTransparency = 0.7; line.BorderSizePixel = 0
end

-- Toggle row helper
local function mkToggle(label, defaultOn, order, onToggle, enabledKey)
    local row = Instance.new("Frame", vstack)
    row.Size = UDim2.new(1, 0, 0, 40); row.BackgroundColor3 = C_CARD
    row.BorderSizePixel = 0; row.LayoutOrder = order
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", row)
    stroke.Color = C_ACCENT; stroke.Thickness = 1; stroke.Transparency = 0.75

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(1, -70, 1, 0); lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1; lbl.Text = label; lbl.TextColor3 = C_WHITE
    lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 13; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 4

    local swBg = Instance.new("Frame", row)
    swBg.Size = UDim2.new(0, 44, 0, 22); swBg.Position = UDim2.new(1, -54, 0.5, -11)
    swBg.BackgroundColor3 = defaultOn and C_ACCENT or C_SW_OFF; swBg.BorderSizePixel = 0; swBg.ZIndex = 4
    Instance.new("UICorner", swBg).CornerRadius = UDim.new(1, 0)
    local swCircle = Instance.new("Frame", swBg)
    swCircle.Size = UDim2.new(0, 18, 0, 18)
    swCircle.Position = defaultOn and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    swCircle.BackgroundColor3 = C_WHITE; swCircle.BorderSizePixel = 0; swCircle.ZIndex = 5
    Instance.new("UICorner", swCircle).CornerRadius = UDim.new(1, 0)

    local isOn = defaultOn
    local function setVisual(state)
        isOn = state
        TweenService:Create(swBg, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {BackgroundColor3 = isOn and C_ACCENT or C_SW_OFF}):Play()
        TweenService:Create(swCircle, TweenInfo.new(0.18, Enum.EasingStyle.Back), {Position = isOn and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,2,0.5,-9)}):Play()
    end
    if enabledKey then VisualSetters[enabledKey] = setVisual end

    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(1, 0, 1, 0); btn.BackgroundTransparency = 1; btn.Text = ""; btn.ZIndex = 6
    btn.MouseButton1Click:Connect(function()
        isOn = not isOn; setVisual(isOn)
        if enabledKey then Enabled[enabledKey] = isOn end
        if onToggle then onToggle(isOn) end
    end)
    btn.MouseEnter:Connect(function()
        TweenService:Create(stroke, TweenInfo.new(0.12), {Transparency=0.3}):Play()
        TweenService:Create(row, TweenInfo.new(0.12), {BackgroundColor3=Color3.fromRGB(26,26,40)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(stroke, TweenInfo.new(0.12), {Transparency=0.75}):Play()
        TweenService:Create(row, TweenInfo.new(0.12), {BackgroundColor3=C_CARD}):Play()
    end)
    return setVisual, swBg, swCircle
end

-- Input row helper
local function mkInput(label, default, order, onChange)
    local row = Instance.new("Frame", vstack)
    row.Size = UDim2.new(1, 0, 0, 40); row.BackgroundColor3 = C_CARD
    row.BorderSizePixel = 0; row.LayoutOrder = order
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", row)
    stroke.Color = C_ACCENT; stroke.Thickness = 1; stroke.Transparency = 0.75
    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(0.55, 0, 1, 0); lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1; lbl.Text = label; lbl.TextColor3 = C_WHITE
    lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 12; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 4
    local box = Instance.new("TextBox", row)
    box.Size = UDim2.new(0, 70, 0, 26); box.Position = UDim2.new(1, -80, 0.5, -13)
    box.BackgroundColor3 = C_BG; box.BorderSizePixel = 0
    box.Text = tostring(default); box.TextColor3 = C_WHITE
    box.Font = Enum.Font.GothamBold; box.TextSize = 11; box.ZIndex = 4
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)
    local bs = Instance.new("UIStroke", box); bs.Color = C_ACCENT; bs.Thickness = 1; bs.Transparency = 0.5
    box.FocusLost:Connect(function()
        if onChange then onChange(box.Text, box) end
    end)
    return box
end

-- ─── COMBAT ───
mkSection("Combat")
local setARVisual, _, _ = mkToggle("Anti Ragdoll", Enabled.AntiRagdoll, O(), function(s)
    if s then startAntiRagdoll() else stopAntiRagdoll() end
end, "AntiRagdoll")

local brSwBgL, brSwCircleL, brSwBgR, brSwCircleR
local brLV, _bbl, _bbcl = mkToggle("Brainrot Return L", false, O(), function(on)
    if on and brainrotReturnRightEnabled then
        brainrotReturnRightEnabled = false
        if brSwBgR and brSwCircleR then
            TweenService:Create(brSwBgR, TweenInfo.new(0.18), {BackgroundColor3=C_SW_OFF}):Play()
            TweenService:Create(brSwCircleR, TweenInfo.new(0.18), {Position=UDim2.new(0,2,0.5,-9)}):Play()
        end
    end
    brainrotReturnLeftEnabled = on
end)
brSwBgL = _bbl; brSwCircleL = _bbcl

local brRV, _bbr, _bbcr = mkToggle("Brainrot Return R", false, O(), function(on)
    if on and brainrotReturnLeftEnabled then
        brainrotReturnLeftEnabled = false
        if brSwBgL and brSwCircleL then
            TweenService:Create(brSwBgL, TweenInfo.new(0.18), {BackgroundColor3=C_SW_OFF}):Play()
            TweenService:Create(brSwCircleL, TweenInfo.new(0.18), {Position=UDim2.new(0,2,0.5,-9)}):Play()
        end
    end
    brainrotReturnRightEnabled = on
end)
brSwBgR = _bbr; brSwCircleR = _bbcr

local setCarryVisual, _csb, _csc = mkToggle("Carry Mode [Q]", speedToggled, O(), function(on)
    if on and laggerToggled then
        laggerToggled = false
        if laggerSwBg and laggerSwCircle then
            TweenService:Create(laggerSwBg, TweenInfo.new(0.18), {BackgroundColor3=C_SW_OFF}):Play()
            TweenService:Create(laggerSwCircle, TweenInfo.new(0.18), {Position=UDim2.new(0,2,0.5,-9)}):Play()
        end
        if sideSetters.laggerSetter then sideSetters.laggerSetter(false) end
    end
    speedToggled = on
    if sideSetters.carrySetter then sideSetters.carrySetter(on) end
end)
speedSwBg = _csb; speedSwCircle = _csc

local setLaggerVisual, _lsb, _lsc = mkToggle("Lagger Mode [R]", laggerToggled, O(), function(on)
    if on and speedToggled then
        speedToggled = false
        if speedSwBg and speedSwCircle then
            TweenService:Create(speedSwBg, TweenInfo.new(0.18), {BackgroundColor3=C_SW_OFF}):Play()
            TweenService:Create(speedSwCircle, TweenInfo.new(0.18), {Position=UDim2.new(0,2,0.5,-9)}):Play()
        end
        if sideSetters.carrySetter then sideSetters.carrySetter(false) end
    end
    laggerToggled = on
    if sideSetters.laggerSetter then sideSetters.laggerSetter(on) end
end)
laggerSwBg = _lsb; laggerSwCircle = _lsc

local setBatVisual, _bsb, _bsc = mkToggle("Auto Bat [E]", autoBatToggled, O(), function(on)
    autoBatToggled = on; autoSwingEnabled = on
    if sideSetters.batSetter then sideSetters.batSetter(on) end
end)
batSwBg = _bsb; batSwCircle = _bsc

local setHHAVisual, _, _ = mkToggle("Harder Hit Anim", false, O(), function(on)
    harderHitAnimEnabled = on
    if on then startHarderHitAnim() else stopHarderHitAnim() end
end)
VisualSetters.HarderHitAnim = setHHAVisual

local setMedVisual, _, _ = mkToggle("Medusa Counter", false, O(), function(on)
    medusaCounterEnabled = on
    if on then setupMedusaCounter(LocalPlayer.Character) else stopMedusaCounter() end
end)
VisualSetters.MedusaCounter = setMedVisual

local setFSVisual, _, _ = mkToggle("Fastest Steal", false, O(), function(on)
    fastestStealEnabled = on
end)
VisualSetters.FastestSteal = setFSVisual

-- ─── AUTO STEAL ───
mkSection("Auto Steal")
local setASVisual, _asb, _asc = mkToggle("Auto Steal", Enabled.AutoSteal, O(), function(on)
    Enabled.AutoSteal = on; Settings.AutoStealEnabled = on
    if on then startAutoSteal() else stopAutoSteal() end
end)

mkInput("Radius", Settings.StealRadius, O(), function(v, box)
    local n = tonumber(v)
    if n then
        Settings.StealRadius = math.clamp(math.floor(n), 1, 500)
        Values.STEAL_RADIUS = Settings.StealRadius
        box.Text = tostring(Settings.StealRadius)
        cachedPrompts = {}; promptCacheTime = 0
    else box.Text = tostring(Settings.StealRadius) end
end)

mkInput("Duration", Settings.StealDuration, O(), function(v, box)
    local n = tonumber(v)
    if n then
        Settings.StealDuration = math.clamp(n, 0.05, 5)
        Values.STEAL_DURATION = Settings.StealDuration
        box.Text = string.format("%.2f", Settings.StealDuration)
    else box.Text = string.format("%.2f", Settings.StealDuration) end
end)

-- ─── AUTO FEATURES ───
mkSection("Auto")
local setTPAutoVisual, _, _ = mkToggle("Auto TP", false, O(), function(on)
    G_tpAutoEnabled = on
    if on then task.spawn(refreshMyPlotSide) end
end)
VisualSetters.AutoTP = setTPAutoVisual

local setAPAfterTPVisual, _, _ = mkToggle("Auto Play After TP", false, O(), function(on)
    G_autoPlayAfterTP = on
end)
VisualSetters.APAfterTP = setAPAfterTPVisual

local setFALVisual, _, _ = mkToggle("Full Auto Left [G]", false, O(), function(on)
    fullAutoPlayLeftEnabled = on
    if fullAutoLeftSetter then fullAutoLeftSetter(on) end
    if on then startFullAutoLeft() else stopFullAutoLeft() end
end)
VisualSetters.FullAutoLeft = setFALVisual

local setFARVisual, _, _ = mkToggle("Full Auto Right [H]", false, O(), function(on)
    fullAutoPlayRightEnabled = on
    if fullAutoRightSetter then fullAutoRightSetter(on) end
    if on then startFullAutoRight() else stopFullAutoRight() end
end)
VisualSetters.FullAutoRight = setFARVisual

-- ─── MOVEMENT ───
mkSection("Movement")
local setIJVisual, _, _ = mkToggle("Infinite Jump [M]", Enabled.InfiniteJump, O(), function(s)
    if s then startInfiniteJump() else stopInfiniteJump() end
end, "InfiniteJump")

local setFloatVisual2, _, _ = mkToggle("Float [J]", false, O(), function(on)
    floatEnabled = on
    if on then startFloat() else stopFloat() end
end)

local _dropVis, _, _ = mkToggle("Drop Brainrot [X]", false, O(), function(on)
    if on then task.spawn(runDropBrainrot) end
end)
setDropBrainrotVisual = _dropVis

local setTPDVisual, tpdSwBg, tpdSwCircle = mkToggle("TP Down [F]", false, O(), function(on)
    if on then runTPDown() end
end)
VisualSetters.TPDown = setTPDVisual
VisualSetters.TPDownReset = function()
    TweenService:Create(tpdSwBg, TweenInfo.new(0.18), {BackgroundColor3=C_SW_OFF}):Play()
    TweenService:Create(tpdSwCircle, TweenInfo.new(0.18), {Position=UDim2.new(0,2,0.5,-9)}):Play()
    setTPDVisual(false)
end

local setNCCVisual, _, _ = mkToggle("No Cam Collision", false, O(), function(on)
    noCamCollisionEnabled = on
    if on then enableNoCameraCollision() else disableNoCameraCollision() end
end)
VisualSetters.NoCam = setNCCVisual

mkInput("Float Height", floatHeight, O(), function(v, box)
    local n = tonumber(v)
    if n then floatHeight = math.clamp(n, 1, 100); box.Text = tostring(floatHeight)
    else box.Text = tostring(floatHeight) end
end)
mkInput("Normal Speed", NORMAL_SPEED, O(), function(v, box)
    local n = tonumber(v)
    if n then NORMAL_SPEED = math.clamp(n, 1, 9999); box.Text = tostring(NORMAL_SPEED)
    else box.Text = tostring(NORMAL_SPEED) end
end)
mkInput("Carry Speed", CARRY_SPEED, O(), function(v, box)
    local n = tonumber(v)
    if n then CARRY_SPEED = math.clamp(n, 1, 9999); box.Text = tostring(CARRY_SPEED)
    else box.Text = tostring(CARRY_SPEED) end
end)
mkInput("Lagger Speed", LAGGER_SPEED, O(), function(v, box)
    local n = tonumber(v)
    if n then LAGGER_SPEED = math.clamp(n, 1, 9999); box.Text = tostring(LAGGER_SPEED)
    else box.Text = tostring(LAGGER_SPEED) end
end)

-- ─── VISUAL ───
mkSection("Visual")
local setOptVisual, _, _ = mkToggle("Anti Lag", Enabled.Optimizer, O(), function(s)
    if s then enableOptimizer() else disableOptimizer() end
end, "Optimizer")

local setUMVisual, _, _ = mkToggle("Ultra Mode", false, O(), function(s)
    ultraModeEnabled = s
    if s then enableUltraMode() else disableUltraMode() end
end)
VisualSetters.UltraMode = setUMVisual

local setRAVisual, _, _ = mkToggle("Remove Accessories", Enabled.RemoveAccessories, O(), function(s)
    if s then startRemoveAccessories() else stopRemoveAccessories() end
end, "RemoveAccessories")

-- ─── KEYBIND HANDLER ───
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    local kc = input.KeyCode
    if kc == Keybinds.UIToggle then
        main.Visible = not main.Visible
        if reopenBtn then reopenBtn.Visible = not main.Visible end
    end
    if kc == Keybinds.SpeedToggle then
        speedToggled = not speedToggled
        if speedToggled and laggerToggled then
            laggerToggled = false
            setLaggerVisual(false)
            if sideSetters.laggerSetter then sideSetters.laggerSetter(false) end
        end
        setCarryVisual(speedToggled)
        if sideSetters.carrySetter then sideSetters.carrySetter(speedToggled) end
    end
    if kc == Keybinds.LaggerToggle then
        laggerToggled = not laggerToggled
        if laggerToggled and speedToggled then
            speedToggled = false
            setCarryVisual(false)
            if sideSetters.carrySetter then sideSetters.carrySetter(false) end
        end
        setLaggerVisual(laggerToggled)
        if sideSetters.laggerSetter then sideSetters.laggerSetter(laggerToggled) end
    end
    if kc == Keybinds.AutoBat then
        autoBatToggled = not autoBatToggled
        setBatVisual(autoBatToggled)
    end
    if kc == Keybinds.InfiniteJump then
        Enabled.InfiniteJump = not Enabled.InfiniteJump
        setIJVisual(Enabled.InfiniteJump)
        if Enabled.InfiniteJump then startInfiniteJump() else stopInfiniteJump() end
    end
    if kc == Keybinds.DropBrainrot then
        if setDropBrainrotVisual then setDropBrainrotVisual(true) end
        task.spawn(runDropBrainrot)
    end
    if kc == Keybinds.FloatToggle then
        floatEnabled = not floatEnabled
        setFloatVisual2(floatEnabled)
        if floatEnabled then startFloat() else stopFloat() end
    end
    if kc == Keybinds.FullAutoLeft then
        fullAutoPlayLeftEnabled = not fullAutoPlayLeftEnabled
        if fullAutoLeftSetter then fullAutoLeftSetter(fullAutoPlayLeftEnabled) end
        setFALVisual(fullAutoPlayLeftEnabled)
        if fullAutoPlayLeftEnabled then startFullAutoLeft() else stopFullAutoLeft() end
    end
    if kc == Keybinds.FullAutoRight then
        fullAutoPlayRightEnabled = not fullAutoPlayRightEnabled
        if fullAutoRightSetter then fullAutoRightSetter(fullAutoPlayRightEnabled) end
        setFARVisual(fullAutoPlayRightEnabled)
        if fullAutoPlayRightEnabled then startFullAutoRight() else stopFullAutoRight() end
    end
    if kc == Keybinds.TPDown then
        runTPDown()
    end
end)

-- Speed loop
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character; if not char then return end
    local localH = char:FindFirstChildOfClass("Humanoid")
    local localHRP = char:FindFirstChild("HumanoidRootPart")
    if not localH or not localHRP then return end
    h = localH; hrp = localHRP
    local md = localH.MoveDirection
    local spd = laggerToggled and LAGGER_SPEED or (speedToggled and CARRY_SPEED or NORMAL_SPEED)
    if md.Magnitude > 0 then
        localHRP.AssemblyLinearVelocity = Vector3.new(md.X*spd, localHRP.AssemblyLinearVelocity.Y, md.Z*spd)
    end
    if speedLbl then
        speedLbl.Text = string.format("%.0f", Vector3.new(localHRP.AssemblyLinearVelocity.X, 0, localHRP.AssemblyLinearVelocity.Z).Magnitude)
    end
end)

-- Mobile side buttons
mobileButtonContainer = Instance.new("Frame", gui)
mobileButtonContainer.Size = UDim2.new(0, 165, 0, 230)
mobileButtonContainer.Position = UDim2.new(1, -175, 0.5, -115)
mobileButtonContainer.BackgroundColor3 = C_BG; mobileButtonContainer.BackgroundTransparency = 0.25
mobileButtonContainer.BorderSizePixel = 0; mobileButtonContainer.Active = true; mobileButtonContainer.ZIndex = 100
Instance.new("UICorner", mobileButtonContainer).CornerRadius = UDim.new(0, 12)
local mbStroke = Instance.new("UIStroke", mobileButtonContainer)
mbStroke.Color = C_ACCENT; mbStroke.Thickness = 2; mbStroke.Transparency = 0.5
do
    local drag, ds, sp = false
    mobileButtonContainer.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            drag = true; ds = inp.Position; sp = mobileButtonContainer.Position
            inp.Changed:Connect(function() if inp.UserInputState == Enum.UserInputState.End then drag = false end end)
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if drag and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local d = inp.Position - ds
            mobileButtonContainer.Position = UDim2.new(sp.X.Scale, sp.X.Offset+d.X, sp.Y.Scale, sp.Y.Offset+d.Y)
        end
    end)
end

local function mkMobileBtn(text, row, col, cb)
    local btn = Instance.new("TextButton", mobileButtonContainer)
    btn.Size = UDim2.new(0, 72, 0, 50)
    btn.Position = UDim2.new(0, (col-1)*83+5, 0, (row-1)*58+5)
    btn.BackgroundColor3 = C_CARD; btn.BorderSizePixel = 0; btn.Text = ""; btn.ZIndex = 101
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    local bs = Instance.new("UIStroke", btn); bs.Color = C_ACCENT; bs.Thickness = 2; bs.Transparency = 0.5
    local lbl = Instance.new("TextLabel", btn)
    lbl.Size = UDim2.new(1, 0, 1, 0); lbl.BackgroundTransparency = 1
    lbl.Text = text; lbl.TextColor3 = C_WHITE
    lbl.Font = Enum.Font.GothamBlack; lbl.TextSize = 11; lbl.ZIndex = 102
    local dot = Instance.new("Frame", btn)
    dot.Size = UDim2.new(0, 8, 0, 8); dot.Position = UDim2.new(1, -12, 0, 4)
    dot.BackgroundColor3 = C_SW_OFF; dot.BorderSizePixel = 0; dot.ZIndex = 103
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    local isOn = false
    local function setV(state)
        isOn = state
        TweenService:Create(dot, TweenInfo.new(0.15), {BackgroundColor3 = isOn and C_GREEN or C_SW_OFF}):Play()
        TweenService:Create(bs, TweenInfo.new(0.15), {Transparency = isOn and 0 or 0.5}):Play()
    end
    btn.MouseButton1Click:Connect(function()
        isOn = not isOn; setV(isOn)
        if cb then cb(isOn) end
    end)
    return setV
end

local batSetter = mkMobileBtn("BAT", 1, 1, function(on)
    autoBatToggled = on; setBatVisual(on)
end)
local carrySetter = mkMobileBtn("CARRY", 1, 2, function(on)
    if on and laggerToggled then
        laggerToggled = false; setLaggerVisual(false)
        if sideSetters.laggerSetter then sideSetters.laggerSetter(false) end
    end
    speedToggled = on; setCarryVisual(on)
end)
local laggerSetter = mkMobileBtn("LAG", 2, 1, function(on)
    if on and speedToggled then
        speedToggled = false; setCarryVisual(false)
        if sideSetters.carrySetter then sideSetters.carrySetter(false) end
    end
    laggerToggled = on; setLaggerVisual(on)
end)
local floatMSetter = mkMobileBtn("FLOAT", 2, 2, function(on)
    floatEnabled = on; setFloatVisual2(on)
    if on then startFloat() else stopFloat() end
end)
fullAutoLeftSetter = mkMobileBtn("AL", 3, 1, function(on)
    fullAutoPlayLeftEnabled = on; setFALVisual(on)
    if on then startFullAutoLeft() else stopFullAutoLeft() end
end)
fullAutoRightSetter = mkMobileBtn("AR", 3, 2, function(on)
    fullAutoPlayRightEnabled = on; setFARVisual(on)
    if on then startFullAutoRight() else stopFullAutoRight() end
end)
dropMobileSetter = mkMobileBtn("DROP", 4, 1, function(on)
    if on then
        if setDropBrainrotVisual then setDropBrainrotVisual(true) end
        task.spawn(runDropBrainrot)
    end
end)

sideSetters = {batSetter=batSetter, carrySetter=carrySetter, laggerSetter=laggerSetter}

-- Init on character
local function setupChar(char)
    h = char:WaitForChild("Humanoid")
    hrp = char:WaitForChild("HumanoidRootPart")
    lastKnownHealth = h and h.Health or 100
    if medusaCounterEnabled then setupMedusaCounter(char) end
    if harderHitAnimEnabled then task.wait(0.3); saveOriginalAnims(char); applyAnimPack(char) end
    local head = char:FindFirstChild("Head")
    if head then
        local bb = Instance.new("BillboardGui", head)
        bb.Size = UDim2.new(0, 80, 0, 20); bb.StudsOffset = Vector3.new(0, 3, 0); bb.AlwaysOnTop = true
        speedLbl = Instance.new("TextLabel", bb)
        speedLbl.Size = UDim2.new(1, 0, 1, 0); speedLbl.BackgroundTransparency = 1
        speedLbl.TextColor3 = C_ACCENT; speedLbl.Font = Enum.Font.GothamBold; speedLbl.TextScaled = true
    end
end
LocalPlayer.CharacterAdded:Connect(setupChar)
if LocalPlayer.Character then setupChar(LocalPlayer.Character) end

task.spawn(function()
    task.wait(2)
    if Enabled.AutoSteal then startAutoSteal() end
    if Enabled.AntiRagdoll then startAntiRagdoll() end
    if Enabled.InfiniteJump then setIJVisual(true); startInfiniteJump() end
    if Enabled.Optimizer then enableOptimizer() end
    if ultraModeEnabled then enableUltraMode() end
    if Enabled.RemoveAccessories then startRemoveAccessories() end
    workspace.CurrentCamera.FieldOfView = FOV_VALUE
end)

-- Auto Play sub-panel
apMain = Instance.new("Frame", gui)
apMain.Name = "APMain"
apMain.Size = getMobileOptimized(UDim2.new(0, 220, 0, 220), UDim2.new(0, 200, 0, 200))
apMain.Position = getMobileOptimized(UDim2.new(0.5, -110, 0.5, -110), UDim2.new(0.5, -100, 0.5, -100))
apMain.BackgroundColor3 = C_BG; apMain.BorderSizePixel = 0; apMain.Active = true
Instance.new("UICorner", apMain).CornerRadius = UDim.new(0, 12)
local apStroke2 = Instance.new("UIStroke", apMain); apStroke2.Color = C_ACCENT; apStroke2.Thickness = 1.5
do
    local drag, ds, sp = false
    apMain.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            drag = true; ds = inp.Position; sp = apMain.Position
            inp.Changed:Connect(function() if inp.UserInputState == Enum.UserInputState.End then drag = false end end)
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if drag and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local d = inp.Position - ds
            apMain.Position = UDim2.new(sp.X.Scale, sp.X.Offset+d.X, sp.Y.Scale, sp.Y.Offset+d.Y)
        end
    end)
end
local apHdr = Instance.new("Frame", apMain)
apHdr.Size = UDim2.new(1, 0, 0, 36); apHdr.BackgroundColor3 = C_CARD; apHdr.BorderSizePixel = 0; apHdr.ZIndex = 3
Instance.new("UICorner", apHdr).CornerRadius = UDim.new(0, 12)
local apHFix2 = Instance.new("Frame", apHdr)
apHFix2.Size = UDim2.new(1, 0, 0, 10); apHFix2.Position = UDim2.new(0, 0, 1, -10)
apHFix2.BackgroundColor3 = C_CARD; apHFix2.BorderSizePixel = 0; apHFix2.ZIndex = 2
local apTitleLbl = Instance.new("TextLabel", apHdr)
apTitleLbl.Size = UDim2.new(1, -40, 1, 0); apTitleLbl.Position = UDim2.new(0, 10, 0, 0)
apTitleLbl.BackgroundTransparency = 1; apTitleLbl.Text = "AUTO PLAY"
apTitleLbl.TextColor3 = C_WHITE; apTitleLbl.Font = Enum.Font.GothamBlack
apTitleLbl.TextSize = 13; apTitleLbl.TextXAlignment = Enum.TextXAlignment.Left; apTitleLbl.ZIndex = 4
local apCloseBtn = Instance.new("TextButton", apHdr)
apCloseBtn.Size = UDim2.new(0, 28, 0, 28); apCloseBtn.Position = UDim2.new(1, -33, 0.5, -14)
apCloseBtn.BackgroundColor3 = C_RED; apCloseBtn.BorderSizePixel = 0
apCloseBtn.Text = "×"; apCloseBtn.TextColor3 = C_WHITE; apCloseBtn.Font = Enum.Font.GothamBold; apCloseBtn.TextSize = 18; apCloseBtn.ZIndex = 6
Instance.new("UICorner", apCloseBtn).CornerRadius = UDim.new(0, 7)

local apReopen = Instance.new("TextButton", gui)
apReopen.Size = UDim2.new(0, 40, 0, 40)
apReopen.Position = getMobileOptimized(UDim2.new(0.5, -20, 0.5, -20), UDim2.new(0.5, -20, 0.5, -20))
apReopen.BackgroundColor3 = C_ACCENT; apReopen.BorderSizePixel = 0
apReopen.Text = "AP"; apReopen.TextColor3 = C_WHITE
apReopen.Font = Enum.Font.GothamBlack; apReopen.TextSize = 12; apReopen.ZIndex = 20; apReopen.Visible = false
Instance.new("UICorner", apReopen).CornerRadius = UDim.new(0, 10)
apCloseBtn.MouseButton1Click:Connect(function() apMain.Visible = false; apReopen.Visible = true end)
apReopen.MouseButton1Click:Connect(function() apMain.Visible = true; apReopen.Visible = false end)

local apBody = Instance.new("Frame", apMain)
apBody.Size = UDim2.new(1, -16, 1, -44); apBody.Position = UDim2.new(0, 8, 0, 40)
apBody.BackgroundTransparency = 1
local apBL = Instance.new("UIListLayout", apBody); apBL.Padding = UDim.new(0, 6); apBL.SortOrder = Enum.SortOrder.LayoutOrder

local AP_LeftOn = false
local AP_RightOn = false
local AP_LeftConn = nil
local AP_RightConn = nil
local AP_LeftPhase2 = 1
local AP_RightPhase2 = 1
local AP_L1 = Vector3.new(-476.48,-6.28,92.73)
local AP_L2 = Vector3.new(-483.12,-4.95,94.80)
local AP_R1 = Vector3.new(-476.16,-6.52,25.62)
local AP_R2 = Vector3.new(-483.06,-5.03,25.48)
local AP_SPEED = 60

local AP_SetLeftV = nil
local AP_SetRightV = nil

local function mkAPToggle(label, order2, onToggle2)
    local row2 = Instance.new("Frame", apBody)
    row2.Size = UDim2.new(1, 0, 0, 38); row2.BackgroundColor3 = C_CARD
    row2.BorderSizePixel = 0; row2.LayoutOrder = order2
    Instance.new("UICorner", row2).CornerRadius = UDim.new(0, 8)
    local stroke2 = Instance.new("UIStroke", row2); stroke2.Color = C_ACCENT; stroke2.Thickness = 1; stroke2.Transparency = 0.75
    local lbl2 = Instance.new("TextLabel", row2)
    lbl2.Size = UDim2.new(1, -60, 1, 0); lbl2.Position = UDim2.new(0, 10, 0, 0)
    lbl2.BackgroundTransparency = 1; lbl2.Text = label; lbl2.TextColor3 = C_WHITE
    lbl2.Font = Enum.Font.GothamBold; lbl2.TextSize = 12; lbl2.TextXAlignment = Enum.TextXAlignment.Left; lbl2.ZIndex = 4
    local swBg2 = Instance.new("Frame", row2)
    swBg2.Size = UDim2.new(0, 40, 0, 20); swBg2.Position = UDim2.new(1, -48, 0.5, -10)
    swBg2.BackgroundColor3 = C_SW_OFF; swBg2.BorderSizePixel = 0; swBg2.ZIndex = 4
    Instance.new("UICorner", swBg2).CornerRadius = UDim.new(1, 0)
    local swC2 = Instance.new("Frame", swBg2)
    swC2.Size = UDim2.new(0, 16, 0, 16); swC2.Position = UDim2.new(0, 2, 0.5, -8)
    swC2.BackgroundColor3 = C_WHITE; swC2.BorderSizePixel = 0; swC2.ZIndex = 5
    Instance.new("UICorner", swC2).CornerRadius = UDim.new(1, 0)
    local isOn2 = false
    local function sv2(state)
        isOn2 = state
        TweenService:Create(swBg2, TweenInfo.new(0.18), {BackgroundColor3 = isOn2 and C_ACCENT or C_SW_OFF}):Play()
        TweenService:Create(swC2, TweenInfo.new(0.18), {Position = isOn2 and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)}):Play()
    end
    local btn2 = Instance.new("TextButton", row2)
    btn2.Size = UDim2.new(1, 0, 1, 0); btn2.BackgroundTransparency = 1; btn2.Text = ""; btn2.ZIndex = 6
    btn2.MouseButton1Click:Connect(function()
        isOn2 = not isOn2; sv2(isOn2)
        if onToggle2 then onToggle2(isOn2) end
    end)
    return sv2
end

local apALOrder = 0
local function APO() apALOrder = apALOrder + 1; return apALOrder end

AP_SetLeftV = mkAPToggle("Auto Left [Z]", APO(), function(on)
    AP_LeftOn = on
    if on then
        if AP_LeftConn then AP_LeftConn:Disconnect() end
        AP_LeftPhase2 = 1
        AP_LeftConn = RunService.Heartbeat:Connect(function()
            if not AP_LeftOn then return end
            local c = LocalPlayer.Character; if not c then return end
            local rp2 = c:FindFirstChild("HumanoidRootPart")
            local hum3 = c:FindFirstChildOfClass("Humanoid")
            if not rp2 or not hum3 then return end
            local tgt2 = AP_LeftPhase2 == 1 and AP_L1 or AP_L2
            if (Vector3.new(tgt2.X, rp2.Position.Y, tgt2.Z) - rp2.Position).Magnitude < 1 then
                if AP_LeftPhase2 == 2 then
                    hum3:Move(Vector3.zero, false); rp2.AssemblyLinearVelocity = Vector3.zero
                    AP_LeftOn = false; if AP_LeftConn then AP_LeftConn:Disconnect(); AP_LeftConn = nil end
                    AP_LeftPhase2 = 1; if AP_SetLeftV then AP_SetLeftV(false) end; return
                else AP_LeftPhase2 = 2 end
            end
            local d2 = tgt2 - rp2.Position; local mv4 = Vector3.new(d2.X, 0, d2.Z).Unit
            hum3:Move(mv4, false); rp2.AssemblyLinearVelocity = Vector3.new(mv4.X*AP_SPEED, rp2.AssemblyLinearVelocity.Y, mv4.Z*AP_SPEED)
        end)
    else
        if AP_LeftConn then AP_LeftConn:Disconnect(); AP_LeftConn = nil end
        AP_LeftPhase2 = 1
    end
end)

AP_SetRightV = mkAPToggle("Auto Right [C]", APO(), function(on)
    AP_RightOn = on
    if on then
        if AP_RightConn then AP_RightConn:Disconnect() end
        AP_RightPhase2 = 1
        AP_RightConn = RunService.Heartbeat:Connect(function()
            if not AP_RightOn then return end
            local c = LocalPlayer.Character; if not c then return end
            local rp2 = c:FindFirstChild("HumanoidRootPart")
            local hum3 = c:FindFirstChildOfClass("Humanoid")
            if not rp2 or not hum3 then return end
            local tgt2 = AP_RightPhase2 == 1 and AP_R1 or AP_R2
            if (Vector3.new(tgt2.X, rp2.Position.Y, tgt2.Z) - rp2.Position).Magnitude < 1 then
                if AP_RightPhase2 == 2 then
                    hum3:Move(Vector3.zero, false); rp2.AssemblyLinearVelocity = Vector3.zero
                    AP_RightOn = false; if AP_RightConn then AP_RightConn:Disconnect(); AP_RightConn = nil end
                    AP_RightPhase2 = 1; if AP_SetRightV then AP_SetRightV(false) end; return
                else AP_RightPhase2 = 2 end
            end
            local d2 = tgt2 - rp2.Position; local mv4 = Vector3.new(d2.X, 0, d2.Z).Unit
            hum3:Move(mv4, false); rp2.AssemblyLinearVelocity = Vector3.new(mv4.X*AP_SPEED, rp2.AssemblyLinearVelocity.Y, mv4.Z*AP_SPEED)
        end)
    else
        if AP_RightConn then AP_RightConn:Disconnect(); AP_RightConn = nil end
        AP_RightPhase2 = 1
    end
end)

mkAPToggle("Full Auto L [G]", APO(), function(on)
    fullAutoPlayLeftEnabled = on; setFALVisual(on)
    if fullAutoLeftSetter then fullAutoLeftSetter(on) end
    if on then startFullAutoLeft() else stopFullAutoLeft() end
end)

mkAPToggle("Full Auto R [H]", APO(), function(on)
    fullAutoPlayRightEnabled = on; setFARVisual(on)
    if fullAutoRightSetter then fullAutoRightSetter(on) end
    if on then startFullAutoRight() else stopFullAutoRight() end
end)

-- AP speed input
local apSpeedRow = Instance.new("Frame", apBody)
apSpeedRow.Size = UDim2.new(1, 0, 0, 38); apSpeedRow.BackgroundColor3 = C_CARD
apSpeedRow.BorderSizePixel = 0; apSpeedRow.LayoutOrder = APO()
Instance.new("UICorner", apSpeedRow).CornerRadius = UDim.new(0, 8)
local apSL = Instance.new("TextLabel", apSpeedRow)
apSL.Size = UDim2.new(0.55, 0, 1, 0); apSL.Position = UDim2.new(0, 10, 0, 0)
apSL.BackgroundTransparency = 1; apSL.Text = "AP Speed"; apSL.TextColor3 = C_WHITE
apSL.Font = Enum.Font.GothamBold; apSL.TextSize = 12; apSL.TextXAlignment = Enum.TextXAlignment.Left; apSL.ZIndex = 4
local apSBox = Instance.new("TextBox", apSpeedRow)
apSBox.Size = UDim2.new(0, 65, 0, 24); apSBox.Position = UDim2.new(1, -73, 0.5, -12)
apSBox.BackgroundColor3 = C_BG; apSBox.BorderSizePixel = 0
apSBox.Text = tostring(AP_SPEED); apSBox.TextColor3 = C_WHITE
apSBox.Font = Enum.Font.GothamBold; apSBox.TextSize = 11; apSBox.ZIndex = 4
Instance.new("UICorner", apSBox).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", apSBox).Color = C_ACCENT
apSBox.FocusLost:Connect(function()
    local n = tonumber(apSBox.Text)
    if n then AP_SPEED = math.clamp(n, 1, 9999); apSBox.Text = tostring(AP_SPEED)
    else apSBox.Text = tostring(AP_SPEED) end
end)

-- AP keybind
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    local kc = input.KeyCode
    if kc == Enum.KeyCode.Z then
        AP_LeftOn = not AP_LeftOn; if AP_SetLeftV then AP_SetLeftV(AP_LeftOn) end
    end
    if kc == Enum.KeyCode.C then
        AP_RightOn = not AP_RightOn; if AP_SetRightV then AP_SetRightV(AP_RightOn) end
    end
    if kc == Enum.KeyCode.P then
        apMain.Visible = not apMain.Visible; apReopen.Visible = not apMain.Visible
    end
end)

print("✓ 111 DUEL loaded")
end)()
]],
})

table.insert(SCRIPTS, {
    name="K7 Duel Hub", icon="🎯", desc="AUTO LEFT • AUTO RIGHT • BAT", isNew=true, kind="embed",
    code=[[
repeat task.wait() until game:IsLoaded()
pcall(function() setfpscap(999) end)

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")

-- Player & Character
local LocalPlayer = Players.LocalPlayer

-- Configuration
local NORMAL_SPEED = 60
local CARRY_SPEED = 30
local FOV_VALUE = 70
local UI_SCALE = 1.0

-- State Variables
local speedToggled = false
local autoBatToggled = false
local hittingCooldown = false
local floatEnabled = false
local floatHeight = 10

-- Keybinds
local Keybinds = {
    AutoBat = Enum.KeyCode.E,
    SpeedToggle = Enum.KeyCode.Q,
    AutoLeft = Enum.KeyCode.Z,
    AutoRight = Enum.KeyCode.C,
    InfiniteJump = Enum.KeyCode.M,
    UIToggle = Enum.KeyCode.U,
    Float = Enum.KeyCode.F
}

-- Auto Movement State
local AutoLeftEnabled = false
local AutoRightEnabled = false
local autoLeftConnection = nil
local autoRightConnection = nil
local autoLeftPhase = 1
local autoRightPhase = 1

-- Positions
local POSITION_L1 = Vector3.new(-476.48, -6.28, 92.73)
local POSITION_L2 = Vector3.new(-483.12, -4.95, 94.80)
local POSITION_R1 = Vector3.new(-476.16, -6.52, 25.62)
local POSITION_R2 = Vector3.new(-483.04, -5.09, 23.14)

-- Steal System (Lust insta-grab logic)
local isStealing = false
local stealStartTime = nil
local StealData = {}
-- Lust caches
local lustAnimalCache = {}
local lustMemoryCache = {}
local lustStealCache = {}

-- Values
local Values = {
    STEAL_RADIUS = 20,
    STEAL_DURATION = 0.2,
    DEFAULT_GRAVITY = 196.2,
    GalaxyGravityPercent = 70,
    HOP_POWER = 35,
    HOP_COOLDOWN = 0.08,
}

-- Feature States
local Enabled = {
    AntiRagdoll = false,
    AutoSteal = false,
    InfiniteJump = false,
    ShinyGraphics = false,
    Optimizer = false,
    Unwalk = false,
    AutoLeftEnabled = false,
    AutoRightEnabled = false,
}

-- Connections
local Connections = {}
local galaxyVectorForce = nil
local galaxyAttachment = nil
local galaxyEnabled = false
local hopsEnabled = false
local lastHopTime = 0
local spaceHeld = false
local originalJumpPower = 50
local originalTransparency = {}
local savedAnimations = {}
local originalSkybox = nil
local shinyGraphicsSky = nil
local shinyGraphicsConn = nil
local shinyPlanets = {}
local shinyBloom = nil
local shinyCC = nil

-- Float Variables
local floatConn = nil
local floatAttachment = nil
local floatForce = nil
local floatVisualSetter = nil
local cachedMass = 0
local lastMassUpdate = 0

-- GUI Variables
local h, hrp, speedLbl
local progressConnection = nil
local gui = nil
local main = nil
local speedSwBg, speedSwCircle = nil, nil
local batSwBg, batSwCircle = nil, nil
local waitingForKey = nil
local _G_AL_swBg, _G_AL_swCircle = nil, nil
local _G_AR_swBg, _G_AR_swCircle = nil, nil
local setAutoLeft = nil   -- assigned when makeRow runs for Auto Left
local setAutoRight = nil  -- assigned when makeRow runs for Auto Right

-- UI References
local ProgressLabel, ProgressPercentLabel, ProgressBarFill, RadiusInput, DurationInput
local saveConfigBtn

-- Colors
local C_BG = Color3.fromRGB(0, 0, 0)
local C_PURPLE = Color3.fromRGB(178, 0, 255)
local C_PURPLE2 = Color3.fromRGB(215, 90, 255)
local C_DIM = Color3.fromRGB(100, 0, 145)
local C_SW_OFF = Color3.fromRGB(28, 28, 28)
local C_WHITE = Color3.fromRGB(255, 255, 255)
local C_ROW_BG = Color3.fromRGB(10, 0, 16)

-- Utility Functions
local function getHRP()
    local char = LocalPlayer.Character
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart")
end

local function isMyPlotByName(pn)
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return false end
    local plot = plots:FindFirstChild(pn)
    if not plot then return false end
    local sign = plot:FindFirstChild("PlotSign")
    if sign then
        local yb = sign:FindFirstChild("YourBase")
        if yb and yb:IsA("BillboardGui") then return yb.Enabled end
    end
    return false
end

local function ResetProgressBar()
    if ProgressLabel then ProgressLabel.Text = "READY" end
    if ProgressPercentLabel then ProgressPercentLabel.Text = "" end
    if ProgressBarFill then ProgressBarFill.Size = UDim2.new(0, 0, 1, 0) end
end

-- LUST INSTA-GRAB LOGIC -------------------------------------------------------

-- Scan a single plot into lustAnimalCache
local function lustScanPlot(plot)
    if not plot or not plot:IsA("Model") then return end
    if isMyPlotByName(plot.Name) then return end
    local podiums = plot:FindFirstChild("AnimalPodiums")
    if not podiums then return end
    for _, podium in ipairs(podiums:GetChildren()) do
        if podium:IsA("Model") and podium:FindFirstChild("Base") then
            table.insert(lustAnimalCache, {
                plot = plot.Name,
                slot = podium.Name,
                worldPosition = podium:GetPivot().Position,
                uid = plot.Name .. "_" .. podium.Name
            })
        end
    end
end

-- Initialize scanner — called once after game loads
local function lustInitScanner()
    task.wait(2)
    local plots = workspace:WaitForChild("Plots", 10)
    if not plots then return end
    for _, plot in ipairs(plots:GetChildren()) do lustScanPlot(plot) end
    plots.ChildAdded:Connect(lustScanPlot)
end

-- Find cached prompt for an animal entry
local function lustFindPrompt(animal)
    local cached = lustMemoryCache[animal.uid]
    if cached and cached.Parent then return cached end
    local plots = workspace:FindFirstChild("Plots")
    local plot = plots and plots:FindFirstChild(animal.plot)
    local podiums = plot and plot:FindFirstChild("AnimalPodiums")
    local podium = podiums and podiums:FindFirstChild(animal.slot)
    local base = podium and podium:FindFirstChild("Base")
    local spawnPart = base and base:FindFirstChild("Spawn")
    local att = spawnPart and spawnPart:FindFirstChild("PromptAttachment")
    if att then
        local prompt = att:FindFirstChildOfClass("ProximityPrompt")
        if prompt then lustMemoryCache[animal.uid] = prompt end
        return prompt
    end
    return nil
end

-- Build and cache hold/trigger callbacks for a prompt
local function lustBuildCallbacks(prompt)
    if lustStealCache[prompt] then return end
    local data = { holdCallbacks = {}, triggerCallbacks = {}, ready = true }
    pcall(function()
        if getconnections then
            for _, c in ipairs(getconnections(prompt.PromptButtonHoldBegan)) do
                if c.Function then table.insert(data.holdCallbacks, c.Function) end
            end
            for _, c in ipairs(getconnections(prompt.Triggered)) do
                if c.Function then table.insert(data.triggerCallbacks, c.Function) end
            end
        end
    end)
    lustStealCache[prompt] = data
end

-- Get nearest animal within STEAL_RADIUS using cached positions
local function lustGetNearest()
    local hrp = getHRP()
    if not hrp then return nil end
    local nearest, bestDist = nil, math.huge
    for _, animal in ipairs(lustAnimalCache) do
        local d = (hrp.Position - animal.worldPosition).Magnitude
        if d < bestDist and d <= Values.STEAL_RADIUS then
            bestDist = d
            nearest = animal
        end
    end
    return nearest
end

-- Instant steal: fire hold callbacks then trigger callbacks immediately
local function executeSteal(prompt, name)
    if isStealing then return end
    lustBuildCallbacks(prompt)
    local data = lustStealCache[prompt]
    if not data or not data.ready then return end

    data.ready = false
    isStealing = true
    stealStartTime = tick()

    if ProgressLabel then ProgressLabel.Text = name or "STEALING..." end
    if progressConnection then progressConnection:Disconnect() end
    progressConnection = RunService.Heartbeat:Connect(function()
        if not isStealing then progressConnection:Disconnect() return end
        local prog = math.clamp((tick() - stealStartTime) / Values.STEAL_DURATION, 0, 1)
        if ProgressBarFill then ProgressBarFill.Size = UDim2.new(prog, 0, 1, 0) end
        if ProgressPercentLabel then ProgressPercentLabel.Text = math.floor(prog * 100) .. "%" end
    end)

    task.spawn(function()
        for _, fn in ipairs(data.holdCallbacks) do task.spawn(fn) end
        for _, fn in ipairs(data.triggerCallbacks) do task.spawn(fn) end

        task.wait(Values.STEAL_DURATION)
        if progressConnection then progressConnection:Disconnect() end
        ResetProgressBar()
        data.ready = true
        isStealing = false
    end)
end

-- Auto steal loop: 1/60 tick, double-check uid before firing (Lust recheck)
local function startAutoSteal()
    if Connections.autoSteal then return end
    Connections.autoSteal = RunService.Heartbeat:Connect(function()
        if not Enabled.AutoSteal or isStealing then return end
        local animal = lustGetNearest()
        if not animal then return end
        task.spawn(function()
            task.wait(0.1)
            if not Enabled.AutoSteal or isStealing then return end
            local recheck = lustGetNearest()
            if recheck and recheck.uid == animal.uid then
                local prompt = lustFindPrompt(recheck)
                if prompt then executeSteal(prompt, recheck.slot) end
            end
        end)
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

-- END LUST INSTA-GRAB LOGIC ---------------------------------------------------

-- Anti Ragdoll
local function startAntiRagdoll()
    if Connections.antiRagdoll then return end
    Connections.antiRagdoll = RunService.Heartbeat:Connect(function()
        if not Enabled.AntiRagdoll then return end
        local char = LocalPlayer.Character
        if not char then return end
        
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        
        if hum then
            local st = hum:GetState()
            if st == Enum.HumanoidStateType.Physics or st == Enum.HumanoidStateType.Ragdoll or st == Enum.HumanoidStateType.FallingDown then
                hum:ChangeState(Enum.HumanoidStateType.Running)
                workspace.CurrentCamera.CameraSubject = hum
                pcall(function()
                    local pm = LocalPlayer.PlayerScripts:FindFirstChild("PlayerModule")
                    if pm then require(pm:FindFirstChild("ControlModule")):Enable() end
                end)
                if root then
                    root.Velocity = Vector3.new(0, 0, 0)
                    root.RotVelocity = Vector3.new(0, 0, 0)
                end
            end
        end
        
        for _, obj in ipairs(char:GetDescendants()) do
            if obj:IsA("Motor6D") and not obj.Enabled then obj.Enabled = true end
        end
    end)
end

local function stopAntiRagdoll()
    if Connections.antiRagdoll then
        Connections.antiRagdoll:Disconnect()
        Connections.antiRagdoll = nil
    end
end

-- Jump Power
local function captureJumpPower()
    local c = LocalPlayer.Character
    if c then
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum and hum.JumpPower > 0 then originalJumpPower = hum.JumpPower end
    end
end

task.spawn(function()
    task.wait(1)
    captureJumpPower()
end)
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    captureJumpPower()
end)

-- Infinite Jump (rznnq method - JumpRequest fires on mobile too)
local INF_JUMP_FORCE = 50
local INF_CLAMP_FALL = 80

RunService.Heartbeat:Connect(function()
    if not Enabled.InfiniteJump then return end
    local c = LocalPlayer.Character
    if not c then return end
    local rp = c:FindFirstChild("HumanoidRootPart")
    if rp and rp.Velocity.Y < -INF_CLAMP_FALL then
        rp.Velocity = Vector3.new(rp.Velocity.X, -INF_CLAMP_FALL, rp.Velocity.Z)
    end
end)

UserInputService.JumpRequest:Connect(function()
    if not Enabled.InfiniteJump then return end
    local c = LocalPlayer.Character
    if not c then return end
    local rp = c:FindFirstChild("HumanoidRootPart")
    if rp then
        rp.Velocity = Vector3.new(rp.Velocity.X, INF_JUMP_FORCE, rp.Velocity.Z)
    end
end)

local function startInfiniteJump()
    Enabled.InfiniteJump = true
end

local function stopInfiniteJump()
    Enabled.InfiniteJump = false
end

-- Unwalk
local function startUnwalk()
    local c = LocalPlayer.Character
    if not c then return end
    local hum = c:FindFirstChildOfClass("Humanoid")
    if hum then
        for _, t in ipairs(hum:GetPlayingAnimationTracks()) do t:Stop() end
    end
    local anim = c:FindFirstChild("Animate")
    if anim then
        savedAnimations.Animate = anim:Clone()
        anim:Destroy()
    end
end

local function stopUnwalk()
    local c = LocalPlayer.Character
    if c and savedAnimations.Animate then
        savedAnimations.Animate:Clone().Parent = c
        savedAnimations.Animate = nil
    end
end

-- Float System
local function setupFloatForce()
    pcall(function()
        local c = LocalPlayer.Character
        if not c then return end
        local rp = c:FindFirstChild("HumanoidRootPart")
        if not rp then return end
        
        if floatForce then
            floatForce:Destroy()
            floatForce = nil
        end
        if floatAttachment then
            floatAttachment:Destroy()
            floatAttachment = nil
        end
        
        floatAttachment = Instance.new("Attachment")
        floatAttachment.Parent = rp
        
        floatForce = Instance.new("VectorForce")
        floatForce.Attachment0 = floatAttachment
        floatForce.ApplyAtCenterOfMass = true
        floatForce.RelativeTo = Enum.ActuatorRelativeTo.World
        floatForce.Force = Vector3.new(0, 0, 0)
        floatForce.Parent = rp
    end)
end

local function startFloat()
    floatEnabled = true
    setupFloatForce()
    cachedMass = 0
    lastMassUpdate = 0
    
    if floatConn then floatConn:Disconnect() end
    floatConn = RunService.Heartbeat:Connect(function(dt)
        if not floatEnabled then return end
        pcall(function()
            local c = LocalPlayer.Character
            if not c then return end
            local rp = c:FindFirstChild("HumanoidRootPart")
            if not rp then return end
            local hum = c:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            
            local now = tick()
            if now - lastMassUpdate > 2 or cachedMass == 0 then
                cachedMass = 0
                for _, p in ipairs(c:GetDescendants()) do
                    if p:IsA("BasePart") then cachedMass = cachedMass + p:GetMass() end
                end
                lastMassUpdate = now
            end
            
            local rayParams = RaycastParams.new()
            rayParams.FilterDescendantsInstances = {c}
            rayParams.FilterType = Enum.RaycastFilterType.Exclude
            local result = workspace:Raycast(rp.Position, Vector3.new(0, -500, 0), rayParams)
            local groundY = result and result.Position.Y or (rp.Position.Y - floatHeight)
            local targetY = groundY + floatHeight
            local diff = targetY - rp.Position.Y
            
            local kP, kD = 500, 80
            local velY = rp.AssemblyLinearVelocity.Y
            
            if math.abs(diff) < 0.1 and math.abs(velY) < 0.5 then
                diff = 0
                velY = 0
            end
            
            if floatForce then
                floatForce.Force = Vector3.new(0, cachedMass * (kP * diff - kD * velY + workspace.Gravity), 0)
            end
            hum.JumpPower = 0
        end)
    end)
end

local function stopFloat()
    floatEnabled = false
    cachedMass = 0
    if floatConn then
        floatConn:Disconnect()
        floatConn = nil
    end
    if floatForce then
        floatForce:Destroy()
        floatForce = nil
    end
    if floatAttachment then
        floatAttachment:Destroy()
        floatAttachment = nil
    end
    
    pcall(function()
        local c = LocalPlayer.Character
        if not c then return end
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local rp = c:FindFirstChild("HumanoidRootPart")
        if not rp then return end
        
        hum.JumpPower = originalJumpPower
        
        local rayParams = RaycastParams.new()
        rayParams.FilterDescendantsInstances = {c}
        rayParams.FilterType = Enum.RaycastFilterType.Exclude
        local result = workspace:Raycast(rp.Position, Vector3.new(0, -500, 0), rayParams)
        if result then
            rp.CFrame = CFrame.new(rp.Position.X, result.Position.Y + rp.Size.Y / 2 + 0.1, rp.Position.Z)
            rp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        end
    end)
end

-- XRay & Optimizer
local xrayDescendantConn = nil

local function isXrayTarget(obj)
    if not obj:IsA("BasePart") then return false end
    if not obj.Anchored then return false end
    local nameLower = obj.Name:lower()
    local parentNameLower = (obj.Parent and obj.Parent.Name:lower()) or ""
    return nameLower:find("base") ~= nil or parentNameLower:find("base") ~= nil
end

local function applyXrayToPart(obj)
    pcall(function()
        if isXrayTarget(obj) and originalTransparency[obj] == nil then
            originalTransparency[obj] = obj.LocalTransparencyModifier
            obj.LocalTransparencyModifier = 0.85
        end
    end)
end

local function applyXrayToAll()
    pcall(function()
        for _, obj in ipairs(workspace:GetDescendants()) do applyXrayToPart(obj) end
    end)
end

local function startXrayWatcher()
    if xrayDescendantConn then return end
    xrayDescendantConn = workspace.DescendantAdded:Connect(function(obj)
        if not xrayEnabled then return end
        task.defer(function()
            if xrayEnabled then applyXrayToPart(obj) end
        end)
    end)
end

local function stopXrayWatcher()
    if xrayDescendantConn then
        xrayDescendantConn:Disconnect()
        xrayDescendantConn = nil
    end
end

local function enableOptimizer()
    if getgenv and getgenv().OPTIMIZER_ACTIVE then return end
    if getgenv then getgenv().OPTIMIZER_ACTIVE = true end
    
    pcall(function() setfpscap(999) end)
    pcall(function()
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
    applyXrayToAll()
    startXrayWatcher()
end

local function disableOptimizer()
    if getgenv then getgenv().OPTIMIZER_ACTIVE = false end
    stopXrayWatcher()
    if xrayEnabled then
        for part, val in pairs(originalTransparency) do
            if part and part.Parent then part.LocalTransparencyModifier = val end
        end
        originalTransparency = {}
        xrayEnabled = false
    end
end

-- Shiny Graphics
local function enableShinyGraphics()
    if shinyGraphicsSky then return end
    
    originalSkybox = Lighting:FindFirstChildOfClass("Sky")
    if originalSkybox then originalSkybox.Parent = nil end
    
    shinyGraphicsSky = Instance.new("Sky")
    for _, prop in ipairs({"SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp"}) do
        shinyGraphicsSky[prop] = "rbxassetid://1534951537"
    end
    shinyGraphicsSky.StarCount = 10000
    shinyGraphicsSky.CelestialBodiesShown = false
    shinyGraphicsSky.Parent = Lighting
    
    shinyBloom = Instance.new("BloomEffect")
    shinyBloom.Intensity = 1.5
    shinyBloom.Size = 40
    shinyBloom.Threshold = 0.8
    shinyBloom.Parent = Lighting
    
    shinyCC = Instance.new("ColorCorrectionEffect")
    shinyCC.Saturation = 0.8
    shinyCC.Contrast = 0.3
    shinyCC.TintColor = Color3.fromRGB(200, 200, 200)
    shinyCC.Parent = Lighting
    
    Lighting.Ambient = Color3.fromRGB(100, 100, 110)
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
        p.Color = Color3.fromRGB(160 + i * 15, 160 + i * 15, 165 + i * 15)
        p.Transparency = 0.3
        p.Position = Vector3.new(math.cos(i * 2) * (3000 + i * 500), 1500 + i * 300, math.sin(i * 2) * (3000 + i * 500))
        p.Parent = workspace
        table.insert(shinyPlanets, p)
    end
    
    shinyGraphicsConn = RunService.Heartbeat:Connect(function()
        if not Enabled.ShinyGraphics then return end
        local t = tick() * 0.5
        Lighting.Ambient = Color3.fromRGB(100 + math.sin(t) * 30, 100 + math.sin(t * 0.8) * 30, 110 + math.sin(t * 1.2) * 30)
        if shinyBloom then shinyBloom.Intensity = 1.2 + math.sin(t * 2) * 0.4 end
    end)
end

local function disableShinyGraphics()
    if shinyGraphicsConn then
        shinyGraphicsConn:Disconnect()
        shinyGraphicsConn = nil
    end
    if shinyGraphicsSky then
        shinyGraphicsSky:Destroy()
        shinyGraphicsSky = nil
    end
    if originalSkybox then originalSkybox.Parent = Lighting end
    if shinyBloom then
        shinyBloom:Destroy()
        shinyBloom = nil
    end
    if shinyCC then
        shinyCC:Destroy()
        shinyCC = nil
    end
    for _, obj in ipairs(shinyPlanets) do
        if obj then obj:Destroy() end
    end
    shinyPlanets = {}
    
    Lighting.Ambient = Color3.fromRGB(127, 127, 127)
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
end

-- Camera Functions
local function faceSouth()
    local c = LocalPlayer.Character
    if not c then return end
    local rp = c:FindFirstChild("HumanoidRootPart")
    if not rp then return end
    
    rp.CFrame = CFrame.new(rp.Position) * CFrame.Angles(0, 0, 0)
    local cam = workspace.CurrentCamera
    if cam then
        local cp = rp.Position
        cam.CFrame = CFrame.new(cp.X, cp.Y + 5, cp.Z - 12) * CFrame.Angles(math.rad(-15), 0, 0)
    end
end

local function faceNorth()
    local c = LocalPlayer.Character
    if not c then return end
    local rp = c:FindFirstChild("HumanoidRootPart")
    if not rp then return end
    
    rp.CFrame = CFrame.new(rp.Position) * CFrame.Angles(0, math.rad(180), 0)
    local cam = workspace.CurrentCamera
    if cam then
        local cp = rp.Position
        cam.CFrame = CFrame.new(cp.X, cp.Y + 2, cp.Z + 12) * CFrame.Angles(0, math.rad(180), 0)
    end
end

-- Auto Movement
local function startAutoLeft()
    if autoLeftConnection then autoLeftConnection:Disconnect() end
    autoLeftPhase = 1
    autoLeftConnection = RunService.Heartbeat:Connect(function()
        if not AutoLeftEnabled then return end
        local c = LocalPlayer.Character
        if not c then return end
        local rp = c:FindFirstChild("HumanoidRootPart")
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not rp or not hum then return end
        
        local spd = NORMAL_SPEED
        if autoLeftPhase == 1 then
            local tgt = Vector3.new(POSITION_L1.X, rp.Position.Y, POSITION_L1.Z)
            if (tgt - rp.Position).Magnitude < 1 then
                autoLeftPhase = 2
                local d = (POSITION_L2 - rp.Position)
                local mv = Vector3.new(d.X, 0, d.Z).Unit
                hum:Move(mv, false)
                rp.AssemblyLinearVelocity = Vector3.new(mv.X * spd, rp.AssemblyLinearVelocity.Y, mv.Z * spd)
                return
            end
            local d = (POSITION_L1 - rp.Position)
            local mv = Vector3.new(d.X, 0, d.Z).Unit
            hum:Move(mv, false)
            rp.AssemblyLinearVelocity = Vector3.new(mv.X * spd, rp.AssemblyLinearVelocity.Y, mv.Z * spd)
        elseif autoLeftPhase == 2 then
            local tgt = Vector3.new(POSITION_L2.X, rp.Position.Y, POSITION_L2.Z)
            if (tgt - rp.Position).Magnitude < 1 then
                hum:Move(Vector3.zero, false)
                rp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                AutoLeftEnabled = false
                Enabled.AutoLeftEnabled = false
                if autoLeftConnection then
                    autoLeftConnection:Disconnect()
                    autoLeftConnection = nil
                end
                autoLeftPhase = 1
                if _G_AL_swBg and _G_AL_swCircle then
                    _G_AL_swBg.BackgroundColor3 = C_SW_OFF
                    _G_AL_swCircle.Position = UDim2.new(0, 3, 0.5, -8)
                end
                if MobileButtons["A.LEFT"] then MobileButtons["A.LEFT"].setState(false) end
                faceSouth()
                return
            end
            local d = (POSITION_L2 - rp.Position)
            local mv = Vector3.new(d.X, 0, d.Z).Unit
            hum:Move(mv, false)
            rp.AssemblyLinearVelocity = Vector3.new(mv.X * spd, rp.AssemblyLinearVelocity.Y, mv.Z * spd)
        end
    end)
end

local function stopAutoLeft()
    if autoLeftConnection then
        autoLeftConnection:Disconnect()
        autoLeftConnection = nil
    end
    autoLeftPhase = 1
    local c = LocalPlayer.Character
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
        local c = LocalPlayer.Character
        if not c then return end
        local rp = c:FindFirstChild("HumanoidRootPart")
        local hum = c:FindFirstChildOfClass("Humanoid")
        if not rp or not hum then return end
        
        local spd = NORMAL_SPEED
        if autoRightPhase == 1 then
            local tgt = Vector3.new(POSITION_R1.X, rp.Position.Y, POSITION_R1.Z)
            if (tgt - rp.Position).Magnitude < 1 then
                autoRightPhase = 2
                local d = (POSITION_R2 - rp.Position)
                local mv = Vector3.new(d.X, 0, d.Z).Unit
                hum:Move(mv, false)
                rp.AssemblyLinearVelocity = Vector3.new(mv.X * spd, rp.AssemblyLinearVelocity.Y, mv.Z * spd)
                return
            end
            local d = (POSITION_R1 - rp.Position)
            local mv = Vector3.new(d.X, 0, d.Z).Unit
            hum:Move(mv, false)
            rp.AssemblyLinearVelocity = Vector3.new(mv.X * spd, rp.AssemblyLinearVelocity.Y, mv.Z * spd)
        elseif autoRightPhase == 2 then
            local tgt = Vector3.new(POSITION_R2.X, rp.Position.Y, POSITION_R2.Z)
            if (tgt - rp.Position).Magnitude < 1 then
                hum:Move(Vector3.zero, false)
                rp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                AutoRightEnabled = false
                Enabled.AutoRightEnabled = false
                if autoRightConnection then
                    autoRightConnection:Disconnect()
                    autoRightConnection = nil
                end
                autoRightPhase = 1
                if _G_AR_swBg and _G_AR_swCircle then
                    _G_AR_swBg.BackgroundColor3 = C_SW_OFF
                    _G_AR_swCircle.Position = UDim2.new(0, 3, 0.5, -8)
                end
                if MobileButtons["A.RIGHT"] then MobileButtons["A.RIGHT"].setState(false) end
                faceNorth()
                return
            end
            local d = (POSITION_R2 - rp.Position)
            local mv = Vector3.new(d.X, 0, d.Z).Unit
            hum:Move(mv, false)
            rp.AssemblyLinearVelocity = Vector3.new(mv.X * spd, rp.AssemblyLinearVelocity.Y, mv.Z * spd)
        end
    end)
end

local function stopAutoRight()
    if autoRightConnection then
        autoRightConnection:Disconnect()
        autoRightConnection = nil
    end
    autoRightPhase = 1
    local c = LocalPlayer.Character
    if c then
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum then hum:Move(Vector3.zero, false) end
    end
end

-- Bat System
local SAFE_DELAY = 0.08

local function getBat()
    local char = LocalPlayer.Character
    if not char then return nil end
    local tool = char:FindFirstChild("Bat")
    if tool then return tool end
    
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if backpack then
        tool = backpack:FindFirstChild("Bat")
        if tool then
            tool.Parent = char
            return tool
        end
    end
    return nil
end

local function tryHitBat()
    if hittingCooldown then return end
    hittingCooldown = true
    
    local bat = getBat()
    if bat then
        pcall(function()
            bat:Activate()
            local evt = bat:FindFirstChildWhichIsA("RemoteEvent")
            if evt then evt:FireServer() end
        end)
    end
    
    task.delay(SAFE_DELAY, function() hittingCooldown = false end)
end

local function getClosestPlayer()
    local closestPlayer = nil
    local closestDist = math.huge
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local targetHRP = plr.Character.HumanoidRootPart
            local dist = (hrp.Position - targetHRP.Position).Magnitude
            if dist < closestDist then
                closestDist = dist
                closestPlayer = plr
            end
        end
    end
    return closestPlayer, closestDist
end

local function flyToFrontOfTarget(targetHRP)
    if not hrp then return end
    local forward = targetHRP.CFrame.LookVector
    local frontPos = targetHRP.Position + forward * 1.5
    local direction = (frontPos - hrp.Position).Unit
    hrp.Velocity = Vector3.new(direction.X * 56.5, direction.Y * 56.5, direction.Z * 56.5)
end

-- Settings Functions
local function applyFOV(value)
    FOV_VALUE = value
    local cam = workspace.CurrentCamera
    if cam then cam.FieldOfView = FOV_VALUE end
end

local uiScaleInstance = nil
local lastScaleUpdate = 0
local scaleTween = nil
local targetScale = 1.0

local function applyUIScale(value)
    targetScale = value
    local now = tick()
    if now - lastScaleUpdate < 0.08 then return end
    lastScaleUpdate = now
    
    UI_SCALE = value
    if main and not uiScaleInstance then
        uiScaleInstance = Instance.new("UIScale")
        uiScaleInstance.Parent = main
    end
    if uiScaleInstance then
        if scaleTween then scaleTween:Cancel() end
        scaleTween = TweenService:Create(uiScaleInstance, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Scale = UI_SCALE})
        scaleTween:Play()
    end
end

-- Config Save/Load
local function saveConfig()
    local cfg = {
        normalSpeed = NORMAL_SPEED,
        carrySpeed = CARRY_SPEED,
        fovValue = FOV_VALUE,
        uiScale = UI_SCALE,
        autoBatKey = Keybinds.AutoBat.Name,
        speedToggleKey = Keybinds.SpeedToggle.Name,
        autoLeftKey = Keybinds.AutoLeft.Name,
        autoRightKey = Keybinds.AutoRight.Name,
        infiniteJumpKey = Keybinds.InfiniteJump.Name,
        floatKey = Keybinds.Float.Name,
        autoStealEnabled = Enabled.AutoSteal,
        grabRadius = Values.STEAL_RADIUS,
        stealDuration = Values.STEAL_DURATION,
        antiRagdoll = Enabled.AntiRagdoll,
        infiniteJump = Enabled.InfiniteJump,
        galaxyGravity = Values.GalaxyGravityPercent,
        hopPower = Values.HOP_POWER,
        optimizer = Enabled.Optimizer,
        unwalk = Enabled.Unwalk,
        shinyGraphics = Enabled.ShinyGraphics,
        autoLeftEnabled = Enabled.AutoLeftEnabled,
        autoRightEnabled = Enabled.AutoRightEnabled,
        floatEnabled = floatEnabled,
        floatHeight = floatHeight,
    }
    
    local ok = false
    if writefile then
        pcall(function()
            writefile("K7HubConfig.json", HttpService:JSONEncode(cfg))
            ok = true
        end)
    end
    
    if saveConfigBtn then
        local prev = saveConfigBtn.Text
        saveConfigBtn.Text = ok and "Saved!" or "Failed!"
        task.wait(1.5)
        saveConfigBtn.Text = prev
    end
    return ok
end

local function loadConfig()
    if not (isfile and isfile("K7HubConfig.json")) then return end
    local ok, cfg = pcall(function()
        return HttpService:JSONDecode(readfile("K7HubConfig.json"))
    end)
    if not ok or not cfg then return end
    
    if cfg.normalSpeed then NORMAL_SPEED = cfg.normalSpeed end
    if cfg.carrySpeed then CARRY_SPEED = cfg.carrySpeed end
    if cfg.fovValue then FOV_VALUE = cfg.fovValue end
    if cfg.uiScale then UI_SCALE = cfg.uiScale end
    
    if cfg.autoBatKey and Enum.KeyCode[cfg.autoBatKey] then Keybinds.AutoBat = Enum.KeyCode[cfg.autoBatKey] end
    if cfg.speedToggleKey and Enum.KeyCode[cfg.speedToggleKey] then Keybinds.SpeedToggle = Enum.KeyCode[cfg.speedToggleKey] end
    if cfg.autoLeftKey and Enum.KeyCode[cfg.autoLeftKey] then Keybinds.AutoLeft = Enum.KeyCode[cfg.autoLeftKey] end
    if cfg.autoRightKey and Enum.KeyCode[cfg.autoRightKey] then Keybinds.AutoRight = Enum.KeyCode[cfg.autoRightKey] end
    if cfg.infiniteJumpKey and Enum.KeyCode[cfg.infiniteJumpKey] then Keybinds.InfiniteJump = Enum.KeyCode[cfg.infiniteJumpKey] end
    if cfg.floatKey and Enum.KeyCode[cfg.floatKey] then Keybinds.Float = Enum.KeyCode[cfg.floatKey] end
    
    if cfg.grabRadius then Values.STEAL_RADIUS = cfg.grabRadius end
    if cfg.stealDuration then Values.STEAL_DURATION = cfg.stealDuration end
    
    if cfg.antiRagdoll ~= nil then Enabled.AntiRagdoll = cfg.antiRagdoll end
    if cfg.autoStealEnabled ~= nil then Enabled.AutoSteal = cfg.autoStealEnabled end
    if cfg.infiniteJump ~= nil then Enabled.InfiniteJump = cfg.infiniteJump end
    if cfg.optimizer ~= nil then Enabled.Optimizer = cfg.optimizer end
    if cfg.unwalk ~= nil then Enabled.Unwalk = cfg.unwalk end
    if cfg.shinyGraphics ~= nil then Enabled.ShinyGraphics = cfg.shinyGraphics end
    
    if cfg.galaxyGravity then Values.GalaxyGravityPercent = cfg.galaxyGravity end
    if cfg.hopPower then Values.HOP_POWER = cfg.hopPower end
    
    if cfg.autoLeftEnabled ~= nil then Enabled.AutoLeftEnabled = cfg.autoLeftEnabled end
    if cfg.autoRightEnabled ~= nil then Enabled.AutoRightEnabled = cfg.autoRightEnabled end
    if cfg.floatEnabled ~= nil then floatEnabled = cfg.floatEnabled end
    if cfg.floatHeight then floatHeight = cfg.floatHeight end
end

loadConfig()

-- GUI Creation
local lastTickTime = 0
local tickSound = Instance.new("Sound")
tickSound.SoundId = "rbxassetid://9119734881"
tickSound.Volume = 0.22
tickSound.RollOffMaxDistance = 0
tickSound.Parent = SoundService

local function playTick()
    local now = tick()
    if now - lastTickTime < 0.08 then return end
    lastTickTime = now
    tickSound:Play()
end

-- Main GUI
gui = Instance.new("ScreenGui")
gui.Name = "K7HubGUI"
gui.ResetOnSpawn = false
gui.DisplayOrder = 10
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- MOBILE DRAGGABLE BUTTONS (FIXED POSITIONING - Center Screen)
local isMobile = UserInputService.TouchEnabled
local MobileButtons = {}

if true then -- mobile buttons (always enabled)
    local mobileGui = Instance.new("ScreenGui")
    mobileGui.Name = "MobileButtonsGui"
    mobileGui.ResetOnSpawn = false
    mobileGui.DisplayOrder = 9999
    mobileGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local BTN_W = 110  -- wide rectangle
    local BTN_H = 52   -- short rectangle
    local GAP = 8
    local buttonsLocked = false

    -- Get screen size
    local vp = workspace.CurrentCamera.ViewportSize

    -- Two vertical columns on the RIGHT side of the screen
    -- Col 1 (left col): FLOAT, CARRY, BAT, UI     (top to bottom)
    -- Col 2 (right col): A.LEFT, A.RIGHT, INF JMP, LOCK (top to bottom)
    local MARGIN = 10  -- gap from right/bottom screen edge
    local col2X = vp.X - BTN_W - MARGIN              -- rightmost column
    local col1X = col2X - BTN_W - GAP                -- column to its left
    local totalH = BTN_H*4 + GAP*3
    local startY = math.max(10, (vp.Y - totalH) / 2)
    local row1X = col1X
    local row2X = col1X
    local row1Y = startY

    local function createMobileButton(name, startX, startY, color, onToggle)
        local btn = Instance.new("TextButton")
        btn.Name = name
        btn.Size = UDim2.new(0, BTN_W, 0, BTN_H)
        btn.Position = UDim2.new(0, startX, 0, startY)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        btn.BackgroundTransparency = 0.1
        btn.BorderSizePixel = 0
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBlack
        btn.TextSize = 14
        btn.AutoButtonColor = false
        btn.ZIndex = 10001
        btn.Parent = mobileGui

        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

        local stroke = Instance.new("UIStroke", btn)
        stroke.Color = color
        stroke.Thickness = 2.5

        local isOn = false

        local function updateVisual()
            if isOn then
                btn.BackgroundColor3 = color
                btn.BackgroundTransparency = 0
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            else
                btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                btn.BackgroundTransparency = 0.1
                btn.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
        end

        -- Drag: use btn.InputChanged NOT UserInputService so joystick doesn't bleed in
        local dragging = false
        local moved = false
        local dragStart = Vector2.zero
        local startPos = Vector2.zero
        local DRAG_THRESHOLD = 20  -- must move 20px before it counts as a drag

        btn.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                moved = false
                dragStart = Vector2.new(inp.Position.X, inp.Position.Y)
                startPos = Vector2.new(btn.AbsolutePosition.X, btn.AbsolutePosition.Y)
            end
        end)

        btn.InputChanged:Connect(function(inp)
            if not dragging then return end
            if buttonsLocked then return end
            if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = Vector2.new(inp.Position.X, inp.Position.Y) - dragStart
                if delta.Magnitude > DRAG_THRESHOLD then
                    moved = true
                    btn.Position = UDim2.new(0, startPos.X + delta.X, 0, startPos.Y + delta.Y)
                end
            end
        end)

        btn.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
                if dragging and not moved then
                    isOn = not isOn
                    updateVisual()
                    if onToggle then onToggle(isOn) end
                end
                dragging = false
            end
        end)

        MobileButtons[name] = {
            btn = btn,
            setState = function(state)
                isOn = state
                updateVisual()
            end
        }
        return MobileButtons[name]
    end

    -- COL 1: FLOAT, CARRY, BAT, UI (stacked top to bottom)
    createMobileButton("FLOAT", col1X, startY + (BTN_H+GAP)*0, Color3.fromRGB(0, 170, 255), function(on)
        floatEnabled = on
        if floatVisualSetter then floatVisualSetter(on) end
        if on then startFloat() else stopFloat() end
    end)

    createMobileButton("CARRY", col1X, startY + (BTN_H+GAP)*1, Color3.fromRGB(255, 150, 0), function(on)
        speedToggled = on
        if speedSwBg and speedSwCircle then
            TweenService:Create(speedSwBg, TweenInfo.new(0.2), {BackgroundColor3 = on and C_PURPLE or C_SW_OFF}):Play()
            TweenService:Create(speedSwCircle, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Position = on and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8)}):Play()
        end
    end)

    createMobileButton("BAT", col1X, startY + (BTN_H+GAP)*2, Color3.fromRGB(255, 50, 50), function(on)
        autoBatToggled = on
        if batSwBg and batSwCircle then
            TweenService:Create(batSwBg, TweenInfo.new(0.2), {BackgroundColor3 = on and C_PURPLE or C_SW_OFF}):Play()
            TweenService:Create(batSwCircle, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Position = on and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8)}):Play()
        end
    end)

    createMobileButton("UI", col1X, startY + (BTN_H+GAP)*3, Color3.fromRGB(130, 130, 130), function(on)
        if main then main.Visible = not on end
    end)

    -- COL 2: A.LEFT, A.RIGHT, INF JMP, LOCK (stacked top to bottom, right column)
    createMobileButton("A.LEFT", col2X, startY + (BTN_H+GAP)*0, Color3.fromRGB(80, 200, 120), function(on)
        if setAutoLeft then
            setAutoLeft(on)
        end
    end)

    createMobileButton("A.RIGHT", col2X, startY + (BTN_H+GAP)*1, Color3.fromRGB(200, 80, 220), function(on)
        if setAutoRight then
            setAutoRight(on)
        end
    end)

    createMobileButton("INF JMP", col2X, startY + (BTN_H+GAP)*2, Color3.fromRGB(255, 220, 0), function(on)
        Enabled.InfiniteJump = on
        if VisualSetters.InfiniteJump then VisualSetters.InfiniteJump(on) end
        if on then startInfiniteJump() else stopInfiniteJump() end
    end)

    -- LOCK button — no toggle state stored in MobileButtons, just a local
    do
        local lockBtn = Instance.new("TextButton")
        lockBtn.Name = "LOCK"
        lockBtn.Size = UDim2.new(0, BTN_W, 0, BTN_H)
        lockBtn.Position = UDim2.new(0, MARGIN, 0, startY + (BTN_H+GAP)*3)
        lockBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        lockBtn.BackgroundTransparency = 0.1
        lockBtn.BorderSizePixel = 0
        lockBtn.Text = "🔓 UNLOCK"
        lockBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        lockBtn.Font = Enum.Font.GothamBlack
        lockBtn.TextSize = 13
        lockBtn.AutoButtonColor = false
        lockBtn.ZIndex = 10001
        lockBtn.Parent = mobileGui
        Instance.new("UICorner", lockBtn).CornerRadius = UDim.new(0, 12)
        local lockStroke = Instance.new("UIStroke", lockBtn)
        lockStroke.Color = Color3.fromRGB(255, 200, 0)
        lockStroke.Thickness = 2.5

        lockBtn.MouseButton1Click:Connect(function()
            buttonsLocked = not buttonsLocked
            if buttonsLocked then
                lockBtn.Text = "🔒 LOCK"
                lockBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
                lockBtn.BackgroundTransparency = 0
                lockBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            else
                lockBtn.Text = "🔓 UNLOCK"
                lockBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                lockBtn.BackgroundTransparency = 0.1
                lockBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
        end)
        -- touch support
        lockBtn.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.Touch then
                buttonsLocked = not buttonsLocked
                if buttonsLocked then
                    lockBtn.Text = "🔒 LOCK"
                    lockBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
                    lockBtn.BackgroundTransparency = 0
                    lockBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                else
                    lockBtn.Text = "🔓 UNLOCK"
                    lockBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    lockBtn.BackgroundTransparency = 0.1
                    lockBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
                end
            end
        end)
    end

    print("✓ MOBILE BUTTONS: 2 horizontal rows, rectangles, lock button, fixed dragging")
end


-- Rest of GUI continues...
main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 560, 0, 540)
main.Position = UDim2.new(0, 20, 0, 20)
main.BackgroundColor3 = C_BG
main.BorderSizePixel = 0
main.Active = true
main.ClipsDescendants = true
main.Parent = gui

-- Mobile: Make UI smaller on mobile devices
local deviceType = "Desktop"
if isMobile then
    deviceType = "Mobile"
    main.Size = UDim2.new(0, 400, 0, 400)
end

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 24)

local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Color3.fromRGB(60, 0, 90)
mainStroke.Thickness = 1.5

-- Dragging (Mouse + Touch)
do
    local drag = false
    local ds, sp
    
    main.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            drag = true
            ds = inp.Position
            sp = main.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then drag = false end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(inp)
        if drag and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local d = inp.Position - ds
            main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
        end
    end)
end

-- Header
local batEmoji = Instance.new("TextLabel")
batEmoji.Size = UDim2.new(0, 40, 0, 40)
batEmoji.Position = UDim2.new(0, 14, 0, 8)
batEmoji.BackgroundTransparency = 1
batEmoji.Text = "🦇"
batEmoji.TextColor3 = C_PURPLE
batEmoji.Font = Enum.Font.GothamBlack
batEmoji.TextSize = 32
batEmoji.ZIndex = 4
batEmoji.Parent = main

local titleLbl = Instance.new("TextLabel")
titleLbl.Size = UDim2.new(1, 0, 0, 36)
titleLbl.Position = UDim2.new(0, 0, 0, 12)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = "K7 HUB"
titleLbl.TextColor3 = C_PURPLE
titleLbl.Font = Enum.Font.GothamBlack
titleLbl.TextSize = 28
titleLbl.TextXAlignment = Enum.TextXAlignment.Center
titleLbl.ZIndex = 4
titleLbl.Parent = main

local byLbl = Instance.new("TextLabel")
byLbl.Size = UDim2.new(1, 0, 0, 14)
byLbl.Position = UDim2.new(0, 0, 0, 50)
byLbl.BackgroundTransparency = 1
byLbl.Text = "tyke313"
byLbl.TextColor3 = C_DIM
byLbl.Font = Enum.Font.GothamBold
byLbl.TextSize = 11
byLbl.TextXAlignment = Enum.TextXAlignment.Center
byLbl.ZIndex = 4
byLbl.Parent = main

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -38, 0, 12)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "x"
closeBtn.TextColor3 = C_DIM
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.ZIndex = 6
closeBtn.Parent = main

closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)
closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.12), {TextColor3 = Color3.fromRGB(255, 60, 60)}):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.12), {TextColor3 = C_DIM}):Play()
end)

-- Touch support for close button
closeBtn.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch then
        gui:Destroy()
    end
end)

local sep = Instance.new("Frame")
sep.Size = UDim2.new(1, -40, 0, 1)
sep.Position = UDim2.new(0, 20, 0, 68)
sep.BackgroundColor3 = Color3.fromRGB(30, 0, 45)
sep.BorderSizePixel = 0
sep.ZIndex = 3
sep.Parent = main

-- Scrolling Frame
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, 0, 1, -74)
scroll.Position = UDim2.new(0, 0, 0, 74)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 6
scroll.ScrollBarImageColor3 = C_DIM
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ZIndex = 2
scroll.Parent = main

local vstack = Instance.new("Frame")
vstack.Size = UDim2.new(1, 0, 0, 0)
vstack.AutomaticSize = Enum.AutomaticSize.Y
vstack.BackgroundTransparency = 1
vstack.BorderSizePixel = 0
vstack.Parent = scroll

local vstackLayout = Instance.new("UIListLayout")
vstackLayout.SortOrder = Enum.SortOrder.LayoutOrder
vstackLayout.Padding = UDim.new(0, 0)
vstackLayout.Parent = vstack

local vstackPad = Instance.new("UIPadding")
vstackPad.PaddingLeft = UDim.new(0, 18)
vstackPad.PaddingRight = UDim.new(0, 18)
vstackPad.PaddingTop = UDim.new(0, 8)
vstackPad.PaddingBottom = UDim.new(0, 14)
vstackPad.Parent = vstack

-- GUI Helpers
local VisualSetters = {}

local function makeSwitch(parent, enabledKey, defaultOn)
    local swBg = Instance.new("Frame")
    swBg.Size = UDim2.new(0, 44, 0, 22)
    swBg.Position = UDim2.new(1, -48, 0.5, -11)
    swBg.BackgroundColor3 = defaultOn and C_PURPLE or C_SW_OFF
    swBg.BorderSizePixel = 0
    swBg.ZIndex = 5
    swBg.Parent = parent
    
    Instance.new("UICorner", swBg).CornerRadius = UDim.new(1, 0)
    
    local swCircle = Instance.new("Frame")
    swCircle.Size = UDim2.new(0, 16, 0, 16)
    swCircle.Position = defaultOn and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
    swCircle.BackgroundColor3 = C_WHITE
    swCircle.BorderSizePixel = 0
    swCircle.ZIndex = 6
    swCircle.Parent = swBg
    
    Instance.new("UICorner", swCircle).CornerRadius = UDim.new(1, 0)
    
    if enabledKey == "AutoLeftEnabled" then
        _G_AL_swBg = swBg
        _G_AL_swCircle = swCircle
    end
    if enabledKey == "AutoRightEnabled" then
        _G_AR_swBg = swBg
        _G_AR_swCircle = swCircle
    end
    
    local isOn = defaultOn
    
    local function setVisual(state)
        isOn = state
        TweenService:Create(swBg, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {BackgroundColor3 = isOn and C_PURPLE or C_SW_OFF}):Play()
        TweenService:Create(swCircle, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Position = isOn and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)}):Play()
    end
    
    VisualSetters[enabledKey] = setVisual
    return swBg, swCircle, setVisual
end

local radiusDropOpen = nil
local KeybindDisplayLabels = {}

local function makeRow(keybindRefName, labelTxt, enabledKey, order, onToggle)
    local container = Instance.new("Frame")
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.LayoutOrder = order
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.Size = UDim2.new(1, 0, 0, 0)
    container.ClipsDescendants = false
    container.Parent = vstack
    
    local containerList = Instance.new("UIListLayout")
    containerList.SortOrder = Enum.SortOrder.LayoutOrder
    containerList.Padding = UDim.new(0, 0)
    containerList.Parent = container
    
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, deviceType == "Mobile" and 54 or 44)
    row.BackgroundColor3 = C_ROW_BG
    row.BorderSizePixel = 0
    row.LayoutOrder = 1
    row.ZIndex = 3
    row.Parent = container
    
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)
    
    if keybindRefName ~= "" then
        local kbBox = Instance.new("Frame")
        kbBox.Size = UDim2.new(0, 30, 0, 18)
        kbBox.Position = UDim2.new(0, 10, 0.5, -9)
        kbBox.BackgroundColor3 = C_PURPLE
        kbBox.BackgroundTransparency = 0.5
        kbBox.BorderSizePixel = 0
        kbBox.ZIndex = 5
        kbBox.Parent = row
        
        Instance.new("UICorner", kbBox).CornerRadius = UDim.new(0, 5)
        
        local kbTxt = Instance.new("TextLabel")
        kbTxt.Size = UDim2.new(1, 0, 1, 0)
        kbTxt.BackgroundTransparency = 1
        kbTxt.Text = Keybinds[keybindRefName] and Keybinds[keybindRefName].Name or keybindRefName
        kbTxt.TextColor3 = C_WHITE
        kbTxt.Font = Enum.Font.GothamBold
        kbTxt.TextSize = 10
        kbTxt.TextXAlignment = Enum.TextXAlignment.Center
        kbTxt.ZIndex = 6
        kbTxt.Parent = kbBox
        
        KeybindDisplayLabels[keybindRefName] = kbTxt
    end
    
    local nameX = keybindRefName ~= "" and 48 or 14
    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(1, -(nameX + 60), 1, 0)
    nameLbl.Position = UDim2.new(0, nameX, 0, 0)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = labelTxt
    nameLbl.TextColor3 = C_PURPLE
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextSize = 13
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.ZIndex = 5
    nameLbl.Parent = row
    
    local defaultOn = Enabled[enabledKey] or false
    local _, _, setVisual = makeSwitch(row, enabledKey, defaultOn)
    
    local isOn = defaultOn
    local dropPanel = nil
    local dropInput = nil
    
    if enabledKey == "AutoSteal" then
        dropPanel = Instance.new("Frame")
        dropPanel.Size = UDim2.new(1, 0, 0, 0)
        dropPanel.BackgroundTransparency = 1
        dropPanel.BorderSizePixel = 0
        dropPanel.ClipsDescendants = true
        dropPanel.LayoutOrder = 2
        dropPanel.ZIndex = 4
        dropPanel.Parent = container
        
        local dropInner = Instance.new("Frame")
        dropInner.Size = UDim2.new(1, 0, 1, 0)
        dropInner.BackgroundColor3 = Color3.fromRGB(10, 0, 16)
        dropInner.BorderSizePixel = 0
        dropInner.ZIndex = 4
        dropInner.Parent = dropPanel
        
        Instance.new("UICorner", dropInner).CornerRadius = UDim.new(0, 10)
        
        local dropList = Instance.new("UIListLayout")
        dropList.SortOrder = Enum.SortOrder.LayoutOrder
        dropList.Padding = UDim.new(0, 4)
        dropList.Parent = dropInner
        
        local dropPad = Instance.new("UIPadding")
        dropPad.PaddingLeft = UDim.new(0, 14)
        dropPad.PaddingRight = UDim.new(0, 14)
        dropPad.PaddingTop = UDim.new(0, 8)
        dropPad.PaddingBottom = UDim.new(0, 8)
        dropPad.Parent = dropInner
        
        local radiusRow = Instance.new("Frame")
        radiusRow.Size = UDim2.new(1, 0, 0, 24)
        radiusRow.BackgroundTransparency = 1
        radiusRow.BorderSizePixel = 0
        radiusRow.LayoutOrder = 1
        radiusRow.Parent = dropInner
        
        local radiusLbl = Instance.new("TextLabel")
        radiusLbl.Size = UDim2.new(0.5, 0, 1, 0)
        radiusLbl.Position = UDim2.new(0, 0, 0, 0)
        radiusLbl.BackgroundTransparency = 1
        radiusLbl.Text = "Steal Radius"
        radiusLbl.TextColor3 = C_DIM
        radiusLbl.Font = Enum.Font.GothamBold
        radiusLbl.TextSize = 12
        radiusLbl.TextXAlignment = Enum.TextXAlignment.Left
        radiusLbl.ZIndex = 5
        radiusLbl.Parent = radiusRow
        
        dropInput = Instance.new("TextBox")
        dropInput.Size = UDim2.new(0, 58, 0, 24)
        dropInput.Position = UDim2.new(1, -58, 0, 0)
        dropInput.BackgroundColor3 = Color3.fromRGB(20, 0, 30)
        dropInput.BorderSizePixel = 0
        dropInput.Text = tostring(Values.STEAL_RADIUS)
        dropInput.TextColor3 = C_PURPLE
        dropInput.Font = Enum.Font.GothamBold
        dropInput.TextSize = 13
        dropInput.ZIndex = 5
        dropInput.Parent = radiusRow
        
        Instance.new("UICorner", dropInput).CornerRadius = UDim.new(0, 7)
        
        local rStr = Instance.new("UIStroke", dropInput)
        rStr.Color = C_DIM
        rStr.Thickness = 1
        
        dropInput.Focused:Connect(function()
            TweenService:Create(rStr, TweenInfo.new(0.15), {Color = C_PURPLE}):Play()
        end)
        dropInput.FocusLost:Connect(function()
            local n = tonumber(dropInput.Text)
            if n then
                Values.STEAL_RADIUS = math.clamp(math.floor(n), 1, 500)
                dropInput.Text = tostring(Values.STEAL_RADIUS)
                if RadiusInput then RadiusInput.Text = tostring(Values.STEAL_RADIUS) end
            else
                dropInput.Text = tostring(Values.STEAL_RADIUS)
            end
            TweenService:Create(rStr, TweenInfo.new(0.15), {Color = C_DIM}):Play()
        end)
        
        local durationRow = Instance.new("Frame")
        durationRow.Size = UDim2.new(1, 0, 0, 24)
        durationRow.BackgroundTransparency = 1
        durationRow.BorderSizePixel = 0
        durationRow.LayoutOrder = 2
        durationRow.Parent = dropInner
        
        local durationLbl = Instance.new("TextLabel")
        durationLbl.Size = UDim2.new(0.5, 0, 1, 0)
        durationLbl.Position = UDim2.new(0, 0, 0, 0)
        durationLbl.BackgroundTransparency = 1
        durationLbl.Text = "Steal Duration (s)"
        durationLbl.TextColor3 = C_DIM
        durationLbl.Font = Enum.Font.GothamBold
        durationLbl.TextSize = 12
        durationLbl.TextXAlignment = Enum.TextXAlignment.Left
        durationLbl.ZIndex = 5
        durationLbl.Parent = durationRow
        
        local durationInput = Instance.new("TextBox")
        durationInput.Size = UDim2.new(0, 58, 0, 24)
        durationInput.Position = UDim2.new(1, -58, 0, 0)
        durationInput.BackgroundColor3 = Color3.fromRGB(20, 0, 30)
        durationInput.BorderSizePixel = 0
        durationInput.Text = tostring(Values.STEAL_DURATION)
        durationInput.TextColor3 = C_PURPLE
        durationInput.Font = Enum.Font.GothamBold
        durationInput.TextSize = 13
        durationInput.ZIndex = 5
        durationInput.Parent = durationRow
        
        Instance.new("UICorner", durationInput).CornerRadius = UDim.new(0, 7)
        
        local dStr = Instance.new("UIStroke", durationInput)
        dStr.Color = C_DIM
        dStr.Thickness = 1
        
        DurationInput = durationInput
        
        durationInput.Focused:Connect(function()
            TweenService:Create(dStr, TweenInfo.new(0.15), {Color = C_PURPLE}):Play()
        end)
        durationInput.FocusLost:Connect(function()
            local n = tonumber(durationInput.Text)
            if n then
                Values.STEAL_DURATION = math.clamp(n, 0.1, 10)
                durationInput.Text = tostring(Values.STEAL_DURATION)
                if DurationInput then DurationInput.Text = tostring(Values.STEAL_DURATION) end
            else
                durationInput.Text = tostring(Values.STEAL_DURATION)
            end
            TweenService:Create(dStr, TweenInfo.new(0.15), {Color = C_DIM}):Play()
        end)
    end
    
    local clk = Instance.new("TextButton")
    clk.Size = UDim2.new(1, 0, 0, deviceType == "Mobile" and 54 or 44)
    clk.BackgroundTransparency = 1
    clk.Text = ""
    clk.ZIndex = 7
    clk.Parent = row
    
    local pressStartTime = nil
    local pressConnection = nil
    local longPressTriggered = false
    
    local function handleInputBegan(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            pressStartTime = tick()
            longPressTriggered = false
            if pressConnection then pressConnection:Disconnect() end
            
            pressConnection = RunService.Heartbeat:Connect(function()
                if pressStartTime and tick() - pressStartTime >= 0.5 then
                    if dropPanel and not longPressTriggered then
                        longPressTriggered = true
                        if radiusDropOpen and radiusDropOpen ~= dropPanel then
                            TweenService:Create(radiusDropOpen, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 0, 0)}):Play()
                            task.delay(0.2, function()
                                if radiusDropOpen then radiusDropOpen.Visible = false end
                            end)
                            radiusDropOpen = nil
                        end
                        
                        if dropPanel.Visible then
                            TweenService:Create(dropPanel, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 0, 0)}):Play()
                            task.delay(0.22, function() dropPanel.Visible = false end)
                            radiusDropOpen = nil
                        else
                            if dropInput then dropInput.Text = tostring(Values.STEAL_RADIUS) end
                            if DurationInput then DurationInput.Text = tostring(Values.STEAL_DURATION) end
                            dropPanel.Size = UDim2.new(1, 0, 0, 0)
                            dropPanel.Visible = true
                            TweenService:Create(dropPanel, TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 72)}):Play()
                            radiusDropOpen = dropPanel
                        end
                    end
                    if pressConnection then
                        pressConnection:Disconnect()
                        pressConnection = nil
                    end
                end
            end)
        end
    end
    
    local function handleInputEnded(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local pressDuration = pressStartTime and (tick() - pressStartTime) or 0
            pressStartTime = nil
            if pressConnection then
                pressConnection:Disconnect()
                pressConnection = nil
            end
            
            if pressDuration < 0.5 and not longPressTriggered then
                isOn = not isOn
                Enabled[enabledKey] = isOn
                setVisual(isOn)
                if onToggle then onToggle(isOn) end
            end
        end
    end
    
    clk.InputBegan:Connect(handleInputBegan)
    clk.InputEnded:Connect(handleInputEnded)
    
    clk.MouseButton2Click:Connect(function()
        if not dropPanel then return end
        if radiusDropOpen and radiusDropOpen ~= dropPanel then
            TweenService:Create(radiusDropOpen, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 0, 0)}):Play()
            task.delay(0.2, function()
                if radiusDropOpen then radiusDropOpen.Visible = false end
            end)
            radiusDropOpen = nil
        end
        
        if dropPanel.Visible then
            TweenService:Create(dropPanel, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 0, 0)}):Play()
            task.delay(0.22, function()
                dropPanel.Visible = false
            end)
            radiusDropOpen = nil
        else
            if dropInput then dropInput.Text = tostring(Values.STEAL_RADIUS) end
            if DurationInput then DurationInput.Text = tostring(Values.STEAL_DURATION) end
            dropPanel.Size = UDim2.new(1, 0, 0, 0)
            dropPanel.Visible = true
            TweenService:Create(dropPanel, TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 72)}):Play()
            radiusDropOpen = dropPanel
        end
    end)
    
    clk.MouseEnter:Connect(function()
        playTick()
        TweenService:Create(nameLbl, TweenInfo.new(0.1), {TextColor3 = C_PURPLE2}):Play()
        TweenService:Create(row, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(18, 0, 26)}):Play()
    end)
    clk.MouseLeave:Connect(function()
        TweenService:Create(nameLbl, TweenInfo.new(0.1), {TextColor3 = C_PURPLE}):Play()
        TweenService:Create(row, TweenInfo.new(0.12), {BackgroundColor3 = C_ROW_BG}):Play()
    end)
    
    local gap = Instance.new("Frame")
    gap.Size = UDim2.new(1, 0, 0, 5)
    gap.BackgroundTransparency = 1
    gap.BorderSizePixel = 0
    gap.LayoutOrder = 3
    gap.Parent = container
    
    return container, setVisual
end

local function makeManualRow(keybindRefName, labelTxt, order)
    local container = Instance.new("Frame")
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.LayoutOrder = order
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.Size = UDim2.new(1, 0, 0, 0)
    container.Parent = vstack
    
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, deviceType == "Mobile" and 54 or 44)
    row.BackgroundColor3 = C_ROW_BG
    row.BorderSizePixel = 0
    row.ZIndex = 3
    row.Parent = container
    
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)
    
    if keybindRefName ~= "" then
        local kbBox = Instance.new("Frame")
        kbBox.Size = UDim2.new(0, 30, 0, 18)
        kbBox.Position = UDim2.new(0, 10, 0.5, -9)
        kbBox.BackgroundColor3 = C_PURPLE
        kbBox.BackgroundTransparency = 0.5
        kbBox.BorderSizePixel = 0
        kbBox.ZIndex = 5
        kbBox.Parent = row
        
        Instance.new("UICorner", kbBox).CornerRadius = UDim.new(0, 5)
        
        local kbTxt = Instance.new("TextLabel")
        kbTxt.Size = UDim2.new(1, 0, 1, 0)
        kbTxt.BackgroundTransparency = 1
        kbTxt.Text = Keybinds[keybindRefName] and Keybinds[keybindRefName].Name or keybindRefName
        kbTxt.TextColor3 = C_WHITE
        kbTxt.Font = Enum.Font.GothamBold
        kbTxt.TextSize = 10
        kbTxt.TextXAlignment = Enum.TextXAlignment.Center
        kbTxt.ZIndex = 6
        kbTxt.Parent = kbBox
        
        KeybindDisplayLabels[keybindRefName] = kbTxt
    end
    
    local nameX = keybindRefName ~= "" and 48 or 14
    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(1, -(nameX + 60), 1, 0)
    nameLbl.Position = UDim2.new(0, nameX, 0, 0)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = labelTxt
    nameLbl.TextColor3 = C_PURPLE
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextSize = 13
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.ZIndex = 5
    nameLbl.Parent = row
    
    local swBg = Instance.new("Frame")
    swBg.Size = UDim2.new(0, 44, 0, 22)
    swBg.Position = UDim2.new(1, -48, 0.5, -11)
    swBg.BackgroundColor3 = C_SW_OFF
    swBg.BorderSizePixel = 0
    swBg.ZIndex = 5
    swBg.Parent = row
    
    Instance.new("UICorner", swBg).CornerRadius = UDim.new(1, 0)
    
    local swCircle = Instance.new("Frame")
    swCircle.Size = UDim2.new(0, 16, 0, 16)
    swCircle.Position = UDim2.new(0, 3, 0.5, -8)
    swCircle.BackgroundColor3 = C_WHITE
    swCircle.BorderSizePixel = 0
    swCircle.ZIndex = 6
    swCircle.Parent = swBg
    
    Instance.new("UICorner", swCircle).CornerRadius = UDim.new(1, 0)
    
    local clk = Instance.new("TextButton")
    clk.Size = UDim2.new(1, 0, 0, deviceType == "Mobile" and 54 or 44)
    clk.BackgroundTransparency = 1
    clk.Text = ""
    clk.ZIndex = 7
    clk.Parent = row
    
    clk.MouseEnter:Connect(function()
        playTick()
        TweenService:Create(nameLbl, TweenInfo.new(0.1), {TextColor3 = C_PURPLE2}):Play()
        TweenService:Create(row, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(18, 0, 26)}):Play()
    end)
    clk.MouseLeave:Connect(function()
        TweenService:Create(nameLbl, TweenInfo.new(0.1), {TextColor3 = C_PURPLE}):Play()
        TweenService:Create(row, TweenInfo.new(0.12), {BackgroundColor3 = C_ROW_BG}):Play()
    end)
    
    clk.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch then
            playTick()
            TweenService:Create(nameLbl, TweenInfo.new(0.1), {TextColor3 = C_PURPLE2}):Play()
            TweenService:Create(row, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(18, 0, 26)}):Play()
        end
    end)
    
    local gap = Instance.new("Frame")
    gap.Size = UDim2.new(1, 0, 0, 5)
    gap.BackgroundTransparency = 1
    gap.BorderSizePixel = 0
    gap.Parent = container
    
    return clk, swBg, swCircle, nameLbl, row
end

local function makeSectionLbl(txt, order)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 24)
    f.BackgroundTransparency = 1
    f.BorderSizePixel = 0
    f.LayoutOrder = order
    f.Parent = vstack
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = txt:upper()
    l.TextColor3 = Color3.fromRGB(55, 0, 80)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 10
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 4
    l.Parent = f
end

-- Build UI
local o = 0
local function O()
    o = o + 1
    return o
end

makeSectionLbl("Features", O())
local _, setAutoSteal = makeRow("", "Auto Steal", "AutoSteal", O(), function(s)
    if s then startAutoSteal() else stopAutoSteal() end
end)
local _, setAntiRagdoll = makeRow("", "Anti Ragdoll", "AntiRagdoll", O(), function(s)
    if s then startAntiRagdoll() else stopAntiRagdoll() end
end)
local _, setInfJump = makeRow("InfiniteJump", "Infinite Jump", "InfiniteJump", O(), function(s)
    if s then startInfiniteJump() else stopInfiniteJump() end
end)
local _, setShiny = makeRow("", "Shiny Graphics", "ShinyGraphics", O(), function(s)
    if s then enableShinyGraphics() else disableShinyGraphics() end
end)
local _, setOptimizer = makeRow("", "Optimizer + XRay", "Optimizer", O(), function(s)
    if s then enableOptimizer() else disableOptimizer() end
end)
local _, setUnwalk = makeRow("", "Unwalk", "Unwalk", O(), function(s)
    if s then startUnwalk() else stopUnwalk() end
end)

makeSectionLbl("Movement", O())
local _, _alVisual = makeRow("AutoLeft", "Auto Left", "AutoLeftEnabled", O(), function(s)
    AutoLeftEnabled = s
    Enabled.AutoLeftEnabled = s
    if s then startAutoLeft() else stopAutoLeft() end
end)
setAutoLeft = function(on)
    AutoLeftEnabled = on
    Enabled.AutoLeftEnabled = on
    if _alVisual then _alVisual(on) end
    if on then startAutoLeft() else stopAutoLeft() end
end

local _, _arVisual = makeRow("AutoRight", "Auto Right", "AutoRightEnabled", O(), function(s)
    AutoRightEnabled = s
    Enabled.AutoRightEnabled = s
    if s then startAutoRight() else stopAutoRight() end
end)
setAutoRight = function(on)
    AutoRightEnabled = on
    Enabled.AutoRightEnabled = on
    if _arVisual then _arVisual(on) end
    if on then startAutoRight() else stopAutoRight() end
end

-- Speed Toggle
local speedClk, _speedSwBg, _speedSwCircle = makeManualRow("SpeedToggle", "Carry Mode", O())
speedSwBg = _speedSwBg
speedSwCircle = _speedSwCircle

speedClk.MouseButton1Click:Connect(function()
    speedToggled = not speedToggled
    TweenService:Create(speedSwBg, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {BackgroundColor3 = speedToggled and C_PURPLE or C_SW_OFF}):Play()
    TweenService:Create(speedSwCircle, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Position = speedToggled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)}):Play()
end)

speedClk.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch then
        speedToggled = not speedToggled
        TweenService:Create(speedSwBg, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {BackgroundColor3 = speedToggled and C_PURPLE or C_SW_OFF}):Play()
        TweenService:Create(speedSwCircle, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Position = speedToggled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)}):Play()
    end
end)

-- Auto Bat
local batClk, _batSwBg, _batSwCircle = makeManualRow("AutoBat", "Auto-Bat", O())
batSwBg = _batSwBg
batSwCircle = _batSwCircle

batClk.MouseButton1Click:Connect(function()
    autoBatToggled = not autoBatToggled
    TweenService:Create(batSwBg, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {BackgroundColor3 = autoBatToggled and C_PURPLE or C_SW_OFF}):Play()
    TweenService:Create(batSwCircle, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Position = autoBatToggled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)}):Play()
end)

batClk.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch then
        autoBatToggled = not autoBatToggled
        TweenService:Create(batSwBg, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {BackgroundColor3 = autoBatToggled and C_PURPLE or C_SW_OFF}):Play()
        TweenService:Create(batSwCircle, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Position = autoBatToggled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)}):Play()
    end
end)

-- Input Box Helper
local function makeInputBox(parent, lbl, defaultTxt, onDone)
    local wrap = Instance.new("Frame")
    wrap.Size = UDim2.new(1, 0, 0, deviceType == "Mobile" and 54 or 44)
    wrap.BackgroundColor3 = C_ROW_BG
    wrap.BorderSizePixel = 0
    wrap.ZIndex = 3
    wrap.Parent = parent
    
    Instance.new("UICorner", wrap).CornerRadius = UDim.new(0, 10)
    
    local lbTxt = Instance.new("TextLabel")
    lbTxt.Size = UDim2.new(0.58, 0, 1, 0)
    lbTxt.Position = UDim2.new(0, 14, 0, 0)
    lbTxt.BackgroundTransparency = 1
    lbTxt.Text = lbl
    lbTxt.TextColor3 = C_DIM
    lbTxt.Font = Enum.Font.GothamBold
    lbTxt.TextSize = 12
    lbTxt.TextXAlignment = Enum.TextXAlignment.Left
    lbTxt.ZIndex = 4
    lbTxt.Parent = wrap
    
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0, 70, 0, 26)
    box.Position = UDim2.new(1, -80, 0.5, -13)
    box.BackgroundColor3 = Color3.fromRGB(14, 0, 22)
    box.BorderSizePixel = 0
    box.Text = defaultTxt
    box.TextColor3 = C_PURPLE
    box.Font = Enum.Font.GothamBold
    box.TextSize = 13
    box.ClearTextOnFocus = false
    box.ZIndex = 4
    box.Parent = wrap
    
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
    
    local bs = Instance.new("UIStroke", box)
    bs.Color = C_DIM
    bs.Thickness = 1
    
    box.Focused:Connect(function()
        TweenService:Create(bs, TweenInfo.new(0.15), {Color = C_PURPLE}):Play()
    end)
    box.FocusLost:Connect(function()
        TweenService:Create(bs, TweenInfo.new(0.15), {Color = C_DIM}):Play()
        if onDone then onDone(box.Text, box) end
    end)
    
    local gap = Instance.new("Frame")
    gap.Size = UDim2.new(1, 0, 0, 5)
    gap.BackgroundTransparency = 1
    gap.BorderSizePixel = 0
    gap.Parent = parent
    
    return box
end

-- Slider Helper
local function makeSlider(parent, lbl, minVal, maxVal, defaultVal, onChanged)
    local wrap = Instance.new("Frame")
    wrap.Size = UDim2.new(1, 0, 0, deviceType == "Mobile" and 54 or 44)
    wrap.BackgroundColor3 = C_ROW_BG
    wrap.BorderSizePixel = 0
    wrap.ZIndex = 3
    wrap.Parent = parent
    
    Instance.new("UICorner", wrap).CornerRadius = UDim.new(0, 10)
    
    local lbTxt = Instance.new("TextLabel")
    lbTxt.Size = UDim2.new(0.35, 0, 1, 0)
    lbTxt.Position = UDim2.new(0, 14, 0, 0)
    lbTxt.BackgroundTransparency = 1
    lbTxt.Text = lbl
    lbTxt.TextColor3 = C_DIM
    lbTxt.Font = Enum.Font.GothamBold
    lbTxt.TextSize = 12
    lbTxt.TextXAlignment = Enum.TextXAlignment.Left
    lbTxt.ZIndex = 4
    lbTxt.Parent = wrap
    
    local valTxt = Instance.new("TextLabel")
    valTxt.Size = UDim2.new(0, 50, 0, 20)
    valTxt.Position = UDim2.new(1, -60, 0.5, -10)
    valTxt.BackgroundTransparency = 1
    valTxt.Text = tostring(math.floor(defaultVal))
    valTxt.TextColor3 = C_PURPLE
    valTxt.Font = Enum.Font.GothamBold
    valTxt.TextSize = 13
    valTxt.TextXAlignment = Enum.TextXAlignment.Right
    valTxt.ZIndex = 5
    valTxt.Parent = wrap
    
    local trackBg = Instance.new("Frame")
    trackBg.Size = UDim2.new(0, 200, 0, 6)
    trackBg.Position = UDim2.new(0.38, 0, 0.5, -3)
    trackBg.BackgroundColor3 = Color3.fromRGB(14, 0, 22)
    trackBg.BorderSizePixel = 0
    trackBg.ZIndex = 4
    trackBg.Parent = wrap
    
    Instance.new("UICorner", trackBg).CornerRadius = UDim.new(1, 0)
    
    local trackFill = Instance.new("Frame")
    trackFill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    trackFill.BackgroundColor3 = C_PURPLE
    trackFill.BorderSizePixel = 0
    trackFill.ZIndex = 5
    trackFill.Parent = trackBg
    
    Instance.new("UICorner", trackFill).CornerRadius = UDim.new(1, 0)
    
    local thumb = Instance.new("TextButton")
    thumb.Size = UDim2.new(0, 14, 0, 14)
    thumb.Position = UDim2.new((defaultVal - minVal) / (maxVal - minVal), -7, 0.5, -7)
    thumb.BackgroundColor3 = C_WHITE
    thumb.BorderSizePixel = 0
    thumb.ZIndex = 6
    thumb.Text = ""
    thumb.AutoButtonColor = false
    thumb.Parent = trackBg
    
    if deviceType == "Mobile" then
        thumb.Size = UDim2.new(0, 20, 0, 20)
        thumb.Position = UDim2.new((defaultVal - minVal) / (maxVal - minVal), -10, 0.5, -10)
    end
    
    Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)
    
    local dragging = false
    local dragConnection = nil
    local lastUpdate = 0
    
    local function updateSlider(inputPos)
        local relX = math.clamp((inputPos.X - trackBg.AbsolutePosition.X) / trackBg.AbsoluteSize.X, 0, 1)
        local value = minVal + (maxVal - minVal) * relX
        trackFill.Size = UDim2.new(relX, 0, 1, 0)
        
        local thumbOffset = deviceType == "Mobile" and -10 or -7
        thumb.Position = UDim2.new(relX, thumbOffset, 0.5, thumbOffset + 1)
        
        if lbl == "FOV" then
            valTxt.Text = tostring(math.floor(value))
        elseif lbl == "UI Scale" then
            valTxt.Text = string.format("%.1f", value)
        else
            valTxt.Text = tostring(math.floor(value))
        end
        
        if lbl == "UI Scale" then
            local now = tick()
            if now - lastUpdate >= 0.08 or not dragging then
                lastUpdate = now
                if onChanged then onChanged(value) end
            end
        else
            if onChanged then onChanged(value) end
        end
    end
    
    thumb.MouseButton1Down:Connect(function()
        dragging = true
        if dragConnection then dragConnection:Disconnect() end
        dragConnection = UserInputService.InputChanged:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseMovement then
                updateSlider(inp.Position)
            end
        end)
    end)
    
    thumb.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            if dragConnection then dragConnection:Disconnect() end
            dragConnection = inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    if dragConnection then
                        dragConnection:Disconnect()
                        dragConnection = nil
                    end
                    return
                end
                updateSlider(inp.Position)
            end)
        end
    end)
    
    trackBg.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(inp.Position)
            if dragConnection then dragConnection:Disconnect() end
            dragConnection = inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    if dragConnection then
                        dragConnection:Disconnect()
                        dragConnection = nil
                    end
                    return
                end
                updateSlider(inp.Position)
            end)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
            if dragConnection then
                dragConnection:Disconnect()
                dragConnection = nil
            end
        end
    end)
    
    trackBg.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            updateSlider(inp.Position)
        end
    end)
    
    local gap = Instance.new("Frame")
    gap.Size = UDim2.new(1, 0, 0, 5)
    gap.BackgroundTransparency = 1
    gap.BorderSizePixel = 0
    gap.Parent = parent
    
    return wrap
end

-- Keybind Row Helper
local function makeKeybindRow(parent, lbl, keybindRefName, onChanged)
    local wrap = Instance.new("Frame")
    wrap.Size = UDim2.new(1, 0, 0, deviceType == "Mobile" and 54 or 44)
    wrap.BackgroundColor3 = C_ROW_BG
    wrap.BorderSizePixel = 0
    wrap.ZIndex = 3
    wrap.Parent = parent
    
    Instance.new("UICorner", wrap).CornerRadius = UDim.new(0, 10)
    
    local lbTxt = Instance.new("TextLabel")
    lbTxt.Size = UDim2.new(0.58, 0, 1, 0)
    lbTxt.Position = UDim2.new(0, 14, 0, 0)
    lbTxt.BackgroundTransparency = 1
    lbTxt.Text = lbl
    lbTxt.TextColor3 = C_DIM
    lbTxt.Font = Enum.Font.GothamBold
    lbTxt.TextSize = 12
    lbTxt.TextXAlignment = Enum.TextXAlignment.Left
    lbTxt.ZIndex = 4
    lbTxt.Parent = wrap
    
    local kbBtn = Instance.new("TextButton")
    kbBtn.Size = UDim2.new(0, 70, 0, 26)
    kbBtn.Position = UDim2.new(1, -80, 0.5, -13)
    kbBtn.BackgroundColor3 = Color3.fromRGB(14, 0, 22)
    kbBtn.BorderSizePixel = 0
    kbBtn.Text = Keybinds[keybindRefName].Name
    kbBtn.TextColor3 = C_PURPLE
    kbBtn.Font = Enum.Font.GothamBold
    kbBtn.TextSize = 11
    kbBtn.ZIndex = 4
    kbBtn.Parent = wrap
    
    Instance.new("UICorner", kbBtn).CornerRadius = UDim.new(0, 8)
    
    local ks = Instance.new("UIStroke", kbBtn)
    ks.Color = C_DIM
    ks.Thickness = 1
    
    kbBtn.MouseButton1Click:Connect(function()
        if waitingForKey == kbBtn then
            waitingForKey = nil
            kbBtn.Text = Keybinds[keybindRefName].Name
            kbBtn.TextColor3 = C_PURPLE
            TweenService:Create(ks, TweenInfo.new(0.15), {Color = C_DIM}):Play()
            return
        end
        if waitingForKey then waitingForKey.TextColor3 = C_PURPLE end
        waitingForKey = kbBtn
        kbBtn.Text = "..."
        kbBtn.TextColor3 = C_PURPLE2
        TweenService:Create(ks, TweenInfo.new(0.15), {Color = C_PURPLE}):Play()
    end)
    
    UserInputService.InputBegan:Connect(function(inp, gpe)
        if waitingForKey ~= kbBtn then return end
        if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
        
        local kc = inp.KeyCode
        if kc == Enum.KeyCode.Escape then
            kbBtn.Text = Keybinds[keybindRefName].Name
            kbBtn.TextColor3 = C_PURPLE
            TweenService:Create(ks, TweenInfo.new(0.15), {Color = C_DIM}):Play()
            waitingForKey = nil
            return
        end
        
        Keybinds[keybindRefName] = kc
        kbBtn.Text = kc.Name
        kbBtn.TextColor3 = C_PURPLE
        TweenService:Create(ks, TweenInfo.new(0.15), {Color = C_DIM}):Play()
        waitingForKey = nil
        
        if KeybindDisplayLabels[keybindRefName] then
            KeybindDisplayLabels[keybindRefName].Text = kc.Name
        end
        if onChanged then onChanged(kc) end
    end)
    
    local gap = Instance.new("Frame")
    gap.Size = UDim2.new(1, 0, 0, 5)
    gap.BackgroundTransparency = 1
    gap.BorderSizePixel = 0
    gap.Parent = parent
    
    return kbBtn
end

-- Settings Section
makeSectionLbl("Speed", O())

local settingsWrap = Instance.new("Frame")
settingsWrap.Size = UDim2.new(1, 0, 0, 0)
settingsWrap.AutomaticSize = Enum.AutomaticSize.Y
settingsWrap.BackgroundTransparency = 1
settingsWrap.BorderSizePixel = 0
settingsWrap.LayoutOrder = O()
settingsWrap.Parent = vstack

local swList = Instance.new("UIListLayout")
swList.SortOrder = Enum.SortOrder.LayoutOrder
swList.Padding = UDim.new(0, 0)
swList.Parent = settingsWrap

makeInputBox(settingsWrap, "Normal Speed", tostring(NORMAL_SPEED), function(v, b)
    local n = tonumber(v)
    if n then
        NORMAL_SPEED = math.clamp(n, 0.1, 500)
        b.Text = tostring(NORMAL_SPEED)
    else
        b.Text = tostring(NORMAL_SPEED)
    end
end)

makeInputBox(settingsWrap, "Carry Speed", tostring(CARRY_SPEED), function(v, b)
    local n = tonumber(v)
    if n then
        CARRY_SPEED = math.clamp(n, 0.1, 500)
        b.Text = tostring(CARRY_SPEED)
    else
        b.Text = tostring(CARRY_SPEED)
    end
end)

makeSlider(settingsWrap, "FOV", 30, 120, FOV_VALUE, function(val)
    applyFOV(val)
end)

makeSlider(settingsWrap, "UI Scale", 0.5, 2.0, UI_SCALE, function(val)
    applyUIScale(val)
end)

-- Float UI
do
    local floatRow = Instance.new("Frame")
    floatRow.Size = UDim2.new(1, 0, 0, deviceType == "Mobile" and 54 or 44)
    floatRow.BackgroundColor3 = C_ROW_BG
    floatRow.BorderSizePixel = 0
    floatRow.ZIndex = 3
    floatRow.Parent = settingsWrap
    
    Instance.new("UICorner", floatRow).CornerRadius = UDim.new(0, 10)
    
    local floatLbl = Instance.new("TextLabel", floatRow)
    floatLbl.Size = UDim2.new(0.6, 0, 1, 0)
    floatLbl.Position = UDim2.new(0, 14, 0, 0)
    floatLbl.BackgroundTransparency = 1
    floatLbl.Text = "Float"
    floatLbl.TextColor3 = C_PURPLE
    floatLbl.Font = Enum.Font.GothamBold
    floatLbl.TextSize = 13
    floatLbl.TextXAlignment = Enum.TextXAlignment.Left
    floatLbl.ZIndex = 5
    
    local fSwBg = Instance.new("Frame", floatRow)
    fSwBg.Size = UDim2.new(0, 44, 0, 22)
    fSwBg.Position = UDim2.new(1, -48, 0.5, -11)
    fSwBg.BackgroundColor3 = C_SW_OFF
    fSwBg.BorderSizePixel = 0
    fSwBg.ZIndex = 5
    
    Instance.new("UICorner", fSwBg).CornerRadius = UDim.new(1, 0)
    
    local fSwCircle = Instance.new("Frame", fSwBg)
    fSwCircle.Size = UDim2.new(0, 16, 0, 16)
    fSwCircle.Position = UDim2.new(0, 3, 0.5, -8)
    fSwCircle.BackgroundColor3 = C_WHITE
    fSwCircle.BorderSizePixel = 0
    fSwCircle.ZIndex = 6
    
    Instance.new("UICorner", fSwCircle).CornerRadius = UDim.new(1, 0)
    
    local fClk = Instance.new("TextButton", floatRow)
    fClk.Size = UDim2.new(1, 0, 0, deviceType == "Mobile" and 54 or 44)
    fClk.BackgroundTransparency = 1
    fClk.Text = ""
    fClk.ZIndex = 7
    
    local function setFloatVisual(on)
        floatEnabled = on
        TweenService:Create(fSwBg, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {BackgroundColor3 = on and C_PURPLE or C_SW_OFF}):Play()
        TweenService:Create(fSwCircle, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Position = on and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)}):Play()
        TweenService:Create(floatLbl, TweenInfo.new(0.1), {TextColor3 = on and C_PURPLE2 or C_PURPLE}):Play()
    end
    
    floatVisualSetter = setFloatVisual
    
    local function toggleFloat()
        floatEnabled = not floatEnabled
        if floatVisualSetter then floatVisualSetter(floatEnabled) end
        if floatEnabled then startFloat() else stopFloat() end
    end
    
    fClk.MouseButton1Click:Connect(toggleFloat)
    fClk.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch then
            toggleFloat()
        end
    end)
    
    fClk.MouseEnter:Connect(function()
        playTick()
        TweenService:Create(floatLbl, TweenInfo.new(0.1), {TextColor3 = C_PURPLE2}):Play()
        TweenService:Create(floatRow, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(18, 0, 26)}):Play()
    end)
    fClk.MouseLeave:Connect(function()
        if not floatEnabled then
            TweenService:Create(floatLbl, TweenInfo.new(0.1), {TextColor3 = C_PURPLE}):Play()
        end
        TweenService:Create(floatRow, TweenInfo.new(0.12), {BackgroundColor3 = C_ROW_BG}):Play()
    end)
    
    local fGap = Instance.new("Frame", settingsWrap)
    fGap.Size = UDim2.new(1, 0, 0, 5)
    fGap.BackgroundTransparency = 1
    fGap.BorderSizePixel = 0
end

makeSlider(settingsWrap, "Float Ht", 2, 80, floatHeight, function(val)
    floatHeight = math.floor(val)
end)

-- Keybinds Section
makeSectionLbl("Keybinds", O())

local kbWrap = Instance.new("Frame")
kbWrap.Size = UDim2.new(1, 0, 0, 0)
kbWrap.AutomaticSize = Enum.AutomaticSize.Y
kbWrap.BackgroundTransparency = 1
kbWrap.BorderSizePixel = 0
kbWrap.LayoutOrder = O()
kbWrap.Parent = vstack

local kbList = Instance.new("UIListLayout")
kbList.SortOrder = Enum.SortOrder.LayoutOrder
kbList.Padding = UDim.new(0, 0)
kbList.Parent = kbWrap

makeKeybindRow(kbWrap, "Speed Toggle", "SpeedToggle", function(kc)
    Keybinds.SpeedToggle = kc
end)
makeKeybindRow(kbWrap, "Auto-Bat", "AutoBat", function(kc)
    Keybinds.AutoBat = kc
end)
makeKeybindRow(kbWrap, "Auto Left", "AutoLeft", function(kc)
    Keybinds.AutoLeft = kc
end)
makeKeybindRow(kbWrap, "Auto Right", "AutoRight", function(kc)
    Keybinds.AutoRight = kc
end)
makeKeybindRow(kbWrap, "Infinite Jump", "InfiniteJump", function(kc)
    Keybinds.InfiniteJump = kc
end)
makeKeybindRow(kbWrap, "Float", "Float", function(kc)
    Keybinds.Float = kc
end)

-- Save Config Button
local saveGap = Instance.new("Frame")
saveGap.Size = UDim2.new(1, 0, 0, 6)
saveGap.BackgroundTransparency = 1
saveGap.BorderSizePixel = 0
saveGap.LayoutOrder = O()
saveGap.Parent = vstack

saveConfigBtn = Instance.new("TextButton")
saveConfigBtn.Size = UDim2.new(1, 0, 0, 32)
saveConfigBtn.BackgroundTransparency = 1
saveConfigBtn.Text = "Save Config"
saveConfigBtn.TextColor3 = C_DIM
saveConfigBtn.Font = Enum.Font.GothamBold
saveConfigBtn.TextSize = 13
saveConfigBtn.LayoutOrder = O()
saveConfigBtn.ZIndex = 4
saveConfigBtn.Parent = vstack

saveConfigBtn.MouseButton1Click:Connect(function()
    saveConfig()
end)
saveConfigBtn.MouseEnter:Connect(function()
    TweenService:Create(saveConfigBtn, TweenInfo.new(0.1), {TextColor3 = C_PURPLE}):Play()
end)
saveConfigBtn.MouseLeave:Connect(function()
    TweenService:Create(saveConfigBtn, TweenInfo.new(0.1), {TextColor3 = C_DIM}):Play()
end)

saveConfigBtn.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch then
        saveConfig()
    end
end)

-- Progress Bar
local progressBar = Instance.new("Frame", gui)
progressBar.Size = UDim2.new(0, 460, 0, 72)
progressBar.Position = UDim2.new(0.5, -230, 1, -90)
progressBar.BackgroundColor3 = C_BG
progressBar.BorderSizePixel = 0
progressBar.Active = true

Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 20)

local pbStroke = Instance.new("UIStroke", progressBar)
pbStroke.Color = Color3.fromRGB(40, 0, 60)
pbStroke.Thickness = 1.5

if deviceType == "Mobile" then
    progressBar.Size = UDim2.new(0, 350, 0, 60)
    progressBar.Position = UDim2.new(0.5, -175, 1, -80)
end

do
    local drag = false
    local ds, sp
    
    progressBar.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            drag = true
            ds = inp.Position
            sp = progressBar.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then drag = false end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(inp)
        if drag and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local d = inp.Position - ds
            progressBar.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
        end
    end)
end

ProgressLabel = Instance.new("TextLabel", progressBar)
ProgressLabel.Size = UDim2.new(0.55, 0, 0, 22)
ProgressLabel.Position = UDim2.new(0, 14, 0, 8)
ProgressLabel.BackgroundTransparency = 1
ProgressLabel.Text = "READY"
ProgressLabel.TextColor3 = C_PURPLE
ProgressLabel.Font = Enum.Font.GothamBlack
ProgressLabel.TextSize = 16
ProgressLabel.TextXAlignment = Enum.TextXAlignment.Left
ProgressLabel.ZIndex = 3

ProgressPercentLabel = Instance.new("TextLabel", progressBar)
ProgressPercentLabel.Size = UDim2.new(1, -14, 0, 22)
ProgressPercentLabel.Position = UDim2.new(0, 0, 0, 8)
ProgressPercentLabel.BackgroundTransparency = 1
ProgressPercentLabel.Text = ""
ProgressPercentLabel.TextColor3 = C_PURPLE
ProgressPercentLabel.Font = Enum.Font.GothamBlack
ProgressLabel.TextSize = 18
ProgressPercentLabel.TextXAlignment = Enum.TextXAlignment.Right
ProgressPercentLabel.ZIndex = 3

local radLbl = Instance.new("TextLabel", progressBar)
radLbl.Size = UDim2.new(0, 55, 0, 18)
radLbl.Position = UDim2.new(0, 14, 0, 34)
radLbl.BackgroundTransparency = 1
radLbl.Text = "Radius:"
radLbl.TextColor3 = C_DIM
radLbl.Font = Enum.Font.GothamBold
radLbl.TextSize = 11
radLbl.TextXAlignment = Enum.TextXAlignment.Left
radLbl.ZIndex = 3

RadiusInput = Instance.new("TextBox", progressBar)
RadiusInput.Size = UDim2.new(0, 48, 0, 20)
RadiusInput.Position = UDim2.new(0, 68, 0, 32)
RadiusInput.BackgroundColor3 = Color3.fromRGB(14, 0, 20)
RadiusInput.BorderSizePixel = 0
RadiusInput.Text = tostring(Values.STEAL_RADIUS)
RadiusInput.TextColor3 = C_PURPLE
RadiusInput.Font = Enum.Font.GothamBold
RadiusInput.TextSize = 12
RadiusInput.ZIndex = 4

Instance.new("UICorner", RadiusInput).CornerRadius = UDim.new(0, 6)

local rStr = Instance.new("UIStroke", RadiusInput)
rStr.Color = C_DIM
rStr.Thickness = 1

RadiusInput.FocusLost:Connect(function()
    local n = tonumber(RadiusInput.Text)
    if n then
        Values.STEAL_RADIUS = math.clamp(math.floor(n), 1, 500)
        RadiusInput.Text = tostring(Values.STEAL_RADIUS)
    end
end)

local pTrack = Instance.new("Frame", progressBar)
pTrack.Size = UDim2.new(1, -20, 0, 8)
pTrack.Position = UDim2.new(0, 10, 1, -16)
pTrack.BackgroundColor3 = Color3.fromRGB(14, 0, 20)
pTrack.BorderSizePixel = 0
pTrack.ZIndex = 2

Instance.new("UICorner", pTrack).CornerRadius = UDim.new(1, 0)

ProgressBarFill = Instance.new("Frame", pTrack)
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
ProgressBarFill.BackgroundColor3 = C_PURPLE
ProgressBarFill.BorderSizePixel = 0
ProgressBarFill.ZIndex = 3

Instance.new("UICorner", ProgressBarFill).CornerRadius = UDim.new(1, 0)

-- Input Handler
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if waitingForKey then return end
    
    if input.KeyCode == Keybinds.UIToggle then
        main.Visible = not main.Visible
    end
    
    if input.KeyCode == Keybinds.SpeedToggle then
        speedToggled = not speedToggled
        if speedSwBg and speedSwCircle then
            TweenService:Create(speedSwBg, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {BackgroundColor3 = speedToggled and C_PURPLE or C_SW_OFF}):Play()
            TweenService:Create(speedSwCircle, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Position = speedToggled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)}):Play()
        end
    end
    
    if input.KeyCode == Keybinds.AutoBat then
        autoBatToggled = not autoBatToggled
        if batSwBg and batSwCircle then
            TweenService:Create(batSwBg, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {BackgroundColor3 = autoBatToggled and C_PURPLE or C_SW_OFF}):Play()
            TweenService:Create(batSwCircle, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Position = autoBatToggled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)}):Play()
        end
    end
    
    if input.KeyCode == Keybinds.AutoLeft then
        AutoLeftEnabled = not AutoLeftEnabled
        Enabled.AutoLeftEnabled = AutoLeftEnabled
        if VisualSetters.AutoLeftEnabled then VisualSetters.AutoLeftEnabled(AutoLeftEnabled) end
        if AutoLeftEnabled then startAutoLeft() else stopAutoLeft() end
    end
    
    if input.KeyCode == Keybinds.AutoRight then
        AutoRightEnabled = not AutoRightEnabled
        Enabled.AutoRightEnabled = AutoRightEnabled
        if VisualSetters.AutoRightEnabled then VisualSetters.AutoRightEnabled(AutoRightEnabled) end
        if AutoRightEnabled then startAutoRight() else stopAutoRight() end
    end
    
    if input.KeyCode == Keybinds.InfiniteJump then
        Enabled.InfiniteJump = not Enabled.InfiniteJump
        if VisualSetters.InfiniteJump then VisualSetters.InfiniteJump(Enabled.InfiniteJump) end
        if Enabled.InfiniteJump then startInfiniteJump() else stopInfiniteJump() end
    end
    
    if input.KeyCode == Keybinds.Float then
        floatEnabled = not floatEnabled
        if floatVisualSetter then floatVisualSetter(floatEnabled) end
        if floatEnabled then startFloat() else stopFloat() end
    end
    
    if input.KeyCode == Enum.KeyCode.Space then
        spaceHeld = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then
        spaceHeld = false
    end
end)

-- Movement Loop
RunService.RenderStepped:Connect(function()
    if not (h and hrp) then return end
    if not (AutoLeftEnabled or AutoRightEnabled) then
        local md = h.MoveDirection
        local spd = speedToggled and CARRY_SPEED or NORMAL_SPEED
        if md.Magnitude > 0 then
            hrp.Velocity = Vector3.new(md.X * spd, hrp.Velocity.Y, md.Z * spd)
        end
    end
    if speedLbl then
        speedLbl.Text = "Speed: " .. string.format("%.1f", Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z).Magnitude)
    end
end)

RunService.Heartbeat:Connect(function()
    if autoBatToggled and h and hrp then
        local target, dist = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            flyToFrontOfTarget(target.Character.HumanoidRootPart)
            if dist <= 5 then tryHitBat() end
        end
    end
end)

-- Initialize
task.spawn(function()
    task.wait(2)
    
    -- Start Lust animal cache scanner
    task.spawn(lustInitScanner)
    
    if Enabled.AutoSteal then
        setAutoSteal(true)
        startAutoSteal()
    end
    if Enabled.AntiRagdoll then
        setAntiRagdoll(true)
        startAntiRagdoll()
    end
    if Enabled.InfiniteJump then
        setInfJump(true)
        startInfiniteJump()
    end
    if Enabled.Unwalk then
        setUnwalk(true)
        startUnwalk()
    end
    if Enabled.Optimizer then
        setOptimizer(true)
        enableOptimizer()
    end
    if Enabled.ShinyGraphics then
        setShiny(true)
        enableShinyGraphics()
    end
    if Enabled.AutoLeftEnabled then
        AutoLeftEnabled = true
        Enabled.AutoLeftEnabled = true
        if VisualSetters.AutoLeftEnabled then VisualSetters.AutoLeftEnabled(true) end
        startAutoLeft()
    end
    if Enabled.AutoRightEnabled then
        AutoRightEnabled = true
        Enabled.AutoRightEnabled = true
        if VisualSetters.AutoRightEnabled then VisualSetters.AutoRightEnabled(true) end
        startAutoRight()
    end
    if floatEnabled then
        if floatVisualSetter then floatVisualSetter(true) end
        startFloat()
    end
    
    applyFOV(FOV_VALUE)
    applyUIScale(UI_SCALE)
    
    -- Sync mobile buttons with loaded config
    if MobileButtons then
        if MobileButtons["FLOAT"] and floatEnabled then MobileButtons["FLOAT"].setState(true) end
        if MobileButtons["CARRY"] and speedToggled then MobileButtons["CARRY"].setState(true) end
        if MobileButtons["BAT"] and autoBatToggled then MobileButtons["BAT"].setState(true) end
        if MobileButtons["A.LEFT"] and Enabled.AutoLeftEnabled then MobileButtons["A.LEFT"].setState(true) end
        if MobileButtons["A.RIGHT"] and Enabled.AutoRightEnabled then MobileButtons["A.RIGHT"].setState(true) end
        if MobileButtons["INF JMP"] and Enabled.InfiniteJump then MobileButtons["INF JMP"].setState(true) end
    end
end)

-- Character Setup
local function setupChar(char)
    h = char:WaitForChild("Humanoid")
    hrp = char:WaitForChild("HumanoidRootPart")
    
    local head = char:FindFirstChild("Head")
    if head then
        local bb = Instance.new("BillboardGui", head)
        bb.Size = UDim2.new(0, 140, 0, 25)
        bb.StudsOffset = Vector3.new(0, 3, 0)
        bb.AlwaysOnTop = true
        
        speedLbl = Instance.new("TextLabel", bb)
        speedLbl.Size = UDim2.new(1, 0, 1, 0)
        speedLbl.BackgroundTransparency = 1
        speedLbl.TextColor3 = C_PURPLE
        speedLbl.Font = Enum.Font.GothamBold
        speedLbl.TextScaled = true
        speedLbl.TextStrokeTransparency = 0
        speedLbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    end
    
    if floatEnabled then setupFloatForce() end
end

LocalPlayer.CharacterAdded:Connect(setupChar)
if LocalPlayer.Character then setupChar(LocalPlayer.Character) end

print("K7 HUB v4 - Loaded!")
print("✓ Mobile: 2 horizontal rows of rectangle buttons + LOCK button")
print("✓ Inf jump fixed for mobile (re-jumps on land)")
print("✓ A.LEFT/A.RIGHT auto-reset button when movement completes")
print("✓ Drag uses btn.InputChanged - joystick no longer moves buttons")
]],
})

table.insert(SCRIPTS, {
    name="APEX Hub", icon="🦅", desc="STEAL • ANTI RAG • BAT AIMBOT", isNew=true, kind="embed",
    code=[=[
-- APEX HUB - WITHOUT DESYNC (EclipseX Anti-Ragdoll + Counter Medusa + Bat Counter)
-- https://discord.gg/5FaWfEvmJ

local p = game.Players.LocalPlayer
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local ts = game:GetService("TweenService")
local ls = game:GetService("Lighting")
local stats = game:GetService("Stats")
local cam = workspace.CurrentCamera

-- COLORS
local a = Color3.fromRGB(138,43,226)
local a2 = Color3.fromRGB(255,69,0)
local w = Color3.fromRGB(255,255,255)
local b = Color3.fromRGB(8,8,12)

-- SETTINGS
local ns = 60
local ss = 29
local hopP = 35
local stealR = 20
local stealD = 0.35
local aimS = 60
local batR = 5
local fovV = 70
local COUNTER_RANGE = 15

-- POSITIONS
local pL1 = Vector3.new(-476.48,-6.28,92.73)
local pL2 = Vector3.new(-483.12,-4.95,94.80)
local pR1 = Vector3.new(-476.16,-6.52,25.62)
local pR2 = Vector3.new(-483.04,-5.09,23.14)
local lf = Vector3.new(-473.38,-8.40,22.34)
local rf = Vector3.new(-476.17,-7.91,97.91)

-- STATES
local aL = false
local aR = false
local aLp = 1
local aRp = 1
local aLc = nil
local aRc = nil
local stealE = false
local stealing = false
local antiR = false
local unwalkE = false
local batE = false
local hopE = false
local espE = true
local optE = false
local slowE = false
local tauntA = false
local infJ = true
local ragTP = false
local counterMedusaEnabled = false
local batCounterEnabled = false

local tauntMsg = "Apex on top!"

-- BAT AIMBOT VARIABLES
local aimHighlight = nil
local aimConnection = nil
local lockedTarget = nil

-- COUNTER MEDUSA VARIABLES
local counterConn = nil
local counterCircle = nil

-- BAT COUNTER VARIABLES
local batCounterConn = nil
local lastHitTime = 0
local BAT_COUNTER_COOLDOWN = 0.5

local gC = nil
local gH = nil
local gHrp = nil
local spaceH = false
local lastH = 0
local posLock = false
local changingKey = nil
local savedT = {}

local savedPos = {drop=nil,aL=nil,aR=nil,bat=nil,slow=nil,tp=nil,tauntcircle=nil,medusa=nil,batcounter=nil}

local sg = nil
local mf = nil
local pingFill = nil
local pingVal = nil
local progFill = nil
local progLabel = nil
local progPct = nil
local radIn = nil

local tpPre = Vector3.new(-452.5,-6.6,57.7)
local tpSteps = {Left={Vector3.new(-475.0,-6.6,94.7),Vector3.new(-482.6,-4.7,94.6)},Right={Vector3.new(-475.2,-6.6,23.5),Vector3.new(-482.2,-4.7,23.4)}}

local keys = {aL=Enum.KeyCode.Q,aR=Enum.KeyCode.E,steal=Enum.KeyCode.V,bat=Enum.KeyCode.Z,anti=Enum.KeyCode.X,unwalk=Enum.KeyCode.N,slow=Enum.KeyCode.F7,rag=Enum.KeyCode.F8,drop=Enum.KeyCode.F3,taunt=Enum.KeyCode.F4,tp=Enum.KeyCode.G,medusa=Enum.KeyCode.M,batcounter=Enum.KeyCode.B}
local keyBtns = {}

local function getHrp() local c = p.Character return c and c:FindFirstChild("HumanoidRootPart") end
local function getHum() local c = p.Character return c and c:FindFirstChildOfClass("Humanoid") end

local cfgKey = "ApexHub_Config"

local function saveCfg()
    pcall(function()
        if writefile then
            local d = {ns=ns,ss=ss,stealR=stealR,stealD=stealD,hopP=hopP,fovV=fovV,aimS=aimS,batR=batR}
            for k,v in pairs(savedT) do d["T_"..k]=v end
            for k,v in pairs(keys) do d["K_"..k]=v.Name end
            for k,pos in pairs(savedPos) do if pos then d[k.."_X"]=pos.X.Scale d[k.."_OX"]=pos.X.Offset d[k.."_Y"]=pos.Y.Scale d[k.."_OY"]=pos.Y.Offset end end
            writefile(cfgKey..".json", game:GetService("HttpService"):JSONEncode(d))
        end
    end)
end

local function loadCfg()
    pcall(function()
        if readfile and isfile and isfile(cfgKey..".json") then
            local ok,d = pcall(function() return game:GetService("HttpService"):JSONDecode(readfile(cfgKey..".json")) end)
            if ok and d then
                if d.ns then ns=d.ns end if d.ss then ss=d.ss end if d.stealR then stealR=d.stealR end
                if d.stealD then stealD=d.stealD end if d.hopP then hopP=d.hopP end if d.fovV then fovV=d.fovV end
                if d.aimS then aimS=d.aimS end if d.batR then batR=d.batR end
                for k,_ in pairs(keys) do if d["K_"..k] then pcall(function() keys[k]=Enum.KeyCode[d["K_"..k]] end) end end
                local btns = {"drop","aL","aR","bat","slow","tp","tauntcircle","medusa","batcounter"}
                for _,k in ipairs(btns) do if d[k.."_X"] then savedPos[k]=UDim2.new(d[k.."_X"],d[k.."_OX"] or 0,d[k.."_Y"],d[k.."_OY"] or 0) end end
                for k,v in pairs(d) do if k:sub(1,2)=="T_" then savedT[k:sub(3)]=v end end
            end
        end
    end)
end
loadCfg()

local function doHop()
    if not hopE then return end
    local h = getHrp()
    local hh = getHum()
    if not h or not hh then return end
    if tick()-lastH<0.08 then return end
    lastH = tick()
    if hh.FloorMaterial == Enum.Material.Air then h.AssemblyLinearVelocity = Vector3.new(h.AssemblyLinearVelocity.X, hopP, h.AssemblyLinearVelocity.Z) end
end

-- ============ ECLIPSEX ANTI-RAGDOLL ============
local antiConns = {}

local function startAnti()
    if #antiConns > 0 then return end
    local c = p.Character or p.CharacterAdded:Wait()
    local hum = c:WaitForChild("Humanoid")
    local root = c:WaitForChild("HumanoidRootPart")
    local anim = hum:FindFirstChild("Animator") or Instance.new("Animator", hum)
    local maxVel = 40
    local clampVel = 25
    local maxClamp = 15
    local lastVel = Vector3.new(0,0,0)
    
    local function isRagdoll()
        local s = hum:GetState()
        return s == Enum.HumanoidStateType.Physics or 
               s == Enum.HumanoidStateType.Ragdoll or
               s == Enum.HumanoidStateType.FallingDown or 
               s == Enum.HumanoidStateType.GettingUp
    end
    
    local function cleanEffects()
        for _, obj in pairs(c:GetDescendants()) do
            if obj:IsA("BallSocketConstraint") or obj:IsA("NoCollisionConstraint") or obj:IsA("HingeConstraint") or
               (obj:IsA("Attachment") and (obj.Name == "A" or obj.Name == "B")) then 
                obj:Destroy()
            elseif obj:IsA("BodyVelocity") or obj:IsA("BodyPosition") or obj:IsA("BodyGyro") then 
                obj:Destroy()
            elseif obj:IsA("Motor6D") then 
                obj.Enabled = true 
            end
        end
        for _, track in pairs(anim:GetPlayingAnimationTracks()) do
            local anName = track.Animation and track.Animation.Name:lower() or ""
            if anName:find("rag") or anName:find("fall") or anName:find("hurt") or anName:find("down") then 
                track:Stop(0) 
            end
        end
    end
    
    local function reEnable()
        pcall(function() 
            require(p:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls():Enable() 
        end)
    end
    
    table.insert(antiConns, hum.StateChanged:Connect(function()
        if isRagdoll() then 
            hum:ChangeState(Enum.HumanoidStateType.Running) 
            cleanEffects() 
            cam.CameraSubject = hum 
            reEnable() 
        end
    end))
    
    table.insert(antiConns, rs.Heartbeat:Connect(function()
        if not antiR then return end
        if isRagdoll() then
            cleanEffects()
            local vel = root.AssemblyLinearVelocity
            if (vel - lastVel).Magnitude > maxVel and vel.Magnitude > clampVel then
                root.AssemblyLinearVelocity = vel.Unit * math.min(vel.Magnitude, maxClamp) 
            end
            lastVel = vel
        end
    end))
    
    table.insert(antiConns, c.DescendantAdded:Connect(function() 
        if isRagdoll() then cleanEffects() end 
    end))
    
    table.insert(antiConns, p.CharacterAdded:Connect(function(newChar)
        c = newChar 
        hum = newChar:WaitForChild("Humanoid") 
        root = newChar:WaitForChild("HumanoidRootPart")
        anim = hum:FindFirstChild("Animator") or Instance.new("Animator", hum)
        lastVel = Vector3.new(0,0,0)
        reEnable() 
        cleanEffects()
    end))
    
    reEnable() 
    cleanEffects()
    print("✅ Anti-Ragdoll (EclipseX) ON")
end

local function stopAnti()
    for _, conn in ipairs(antiConns) do conn:Disconnect() end
    antiConns = {}
    print("❌ Anti-Ragdoll OFF")
end
-- ===================================================

-- ============ COUNTER MEDUSA ============
local function makeCounterCircle()
    if counterCircle then counterCircle:Destroy() end
    counterCircle = Instance.new("Part")
    counterCircle.Name = "CounterCircle"
    counterCircle.Shape = Enum.PartType.Cylinder
    counterCircle.Size = Vector3.new(0.2, COUNTER_RANGE * 2, COUNTER_RANGE * 2)
    counterCircle.Color = Color3.fromRGB(255, 0, 0)
    counterCircle.Material = Enum.Material.Neon
    counterCircle.Transparency = 0.5
    counterCircle.Anchored = true
    counterCircle.CanCollide = false
    counterCircle.Parent = workspace
end

local function updateCounterCircle()
    local root = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
    if counterCircle and root then
        counterCircle.CFrame = CFrame.new(root.Position - Vector3.new(0, 2.6, 0)) * CFrame.Angles(0, 0, math.rad(90))
    end
end

local function findMedusaTool()
    local char = p.Character
    local bp = p:FindFirstChildOfClass("Backpack")
    
    if char then
        for _, tool in ipairs(char:GetChildren()) do
            if tool:IsA("Tool") and (tool.Name:lower():find("medusa") or tool.Name:lower():find("medusa's head")) then
                return tool
            end
        end
    end
    if bp then
        for _, tool in ipairs(bp:GetChildren()) do
            if tool:IsA("Tool") and (tool.Name:lower():find("medusa") or tool.Name:lower():find("medusa's head")) then
                return tool
            end
        end
    end
    return nil
end

local function enemyHasMedusa()
    local root = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    
    for _, other in ipairs(game.Players:GetPlayers()) do
        if other ~= p and other.Character then
            local otherRoot = other.Character:FindFirstChild("HumanoidRootPart")
            local otherHum = other.Character:FindFirstChildOfClass("Humanoid")
            if otherRoot and otherHum and otherHum.Health > 0 then
                local dist = (root.Position - otherRoot.Position).Magnitude
                if dist <= COUNTER_RANGE then
                    for _, tool in ipairs(other.Character:GetChildren()) do
                        if tool:IsA("Tool") and (tool.Name:lower():find("medusa") or tool.Name:lower():find("medusa's head")) then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end

local function startCounterMedusa()
    if counterConn then return end
    counterMedusaEnabled = true
    makeCounterCircle()
    
    rs:BindToRenderStep("CounterCircleUpdate", 1, function()
        if counterMedusaEnabled then updateCounterCircle() end
    end)
    
    counterConn = rs.Heartbeat:Connect(function()
        if counterMedusaEnabled then
            if enemyHasMedusa() then
                if counterCircle then
                    counterCircle.Color = Color3.fromRGB(255, 0, 0)
                    counterCircle.Transparency = 0.2
                end
                
                local medusa = findMedusaTool()
                if medusa then
                    local hum = p.Character and p.Character:FindFirstChildOfClass("Humanoid")
                    if hum then
                        if medusa.Parent ~= p.Character then
                            pcall(function() hum:EquipTool(medusa) end)
                        end
                        pcall(function() medusa:Activate() end)
                    end
                end
            else
                if counterCircle then
                    counterCircle.Color = Color3.fromRGB(255, 100, 100)
                    counterCircle.Transparency = 0.5
                end
            end
        end
    end)
    
    print("✅ Counter Medusa ON")
end

local function stopCounterMedusa()
    counterMedusaEnabled = false
    if counterConn then
        counterConn:Disconnect()
        counterConn = nil
    end
    if counterCircle then
        counterCircle:Destroy()
        counterCircle = nil
    end
    rs:UnbindFromRenderStep("CounterCircleUpdate")
    print("❌ Counter Medusa OFF")
end
-- =============================================

-- ============ BAT COUNTER (HIT BACK) ============
local function findBatToolForCounter()
    local char = p.Character
    local bp = p:FindFirstChildOfClass("Backpack")
    
    if char then
        for _, tool in ipairs(char:GetChildren()) do
            if tool:IsA("Tool") and (tool.Name:lower():find("bat") or tool.Name:lower():find("slap")) then
                return tool
            end
        end
    end
    if bp then
        for _, tool in ipairs(bp:GetChildren()) do
            if tool:IsA("Tool") and (tool.Name:lower():find("bat") or tool.Name:lower():find("slap")) then
                return tool
            end
        end
    end
    return nil
end

local function onHit()
    local now = tick()
    if now - lastHitTime < BAT_COUNTER_COOLDOWN then return end
    lastHitTime = now
    
    if batCounterEnabled then
        local myBat = findBatToolForCounter()
        if myBat then
            local hum = p.Character and p.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                if myBat.Parent ~= p.Character then
                    pcall(function() hum:EquipTool(myBat) end)
                end
                task.wait(0.05)
                pcall(function() myBat:Activate() end)
                print("⚡ BAT COUNTER: Hit back!")
            end
        end
    end
end

local function startBatCounter()
    if batCounterConn then return end
    batCounterEnabled = true
    
    local function setupHitDetection(char)
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            local healthConn = hum:GetPropertyChangedSignal("Health"):Connect(function()
                if batCounterEnabled then
                    onHit()
                end
            end)
            table.insert(batCounterConn or {}, healthConn)
        end
    end
    
    batCounterConn = {}
    setupHitDetection(p.Character)
    
    local charConn = p.CharacterAdded:Connect(function(newChar)
        task.wait(0.5)
        setupHitDetection(newChar)
    end)
    table.insert(batCounterConn, charConn)
    
    print("✅ BAT COUNTER ON - Will hit back when attacked!")
end

local function stopBatCounter()
    batCounterEnabled = false
    if batCounterConn then
        for _, conn in ipairs(batCounterConn) do
            pcall(function() conn:Disconnect() end)
        end
        batCounterConn = nil
    end
    print("❌ Bat Counter OFF")
end
-- =============================================

-- TAUNT FUNCTIONS
local tauntL = nil
local function startTaunt()
    if tauntL then return end
    tauntA = true
    tauntL = task.spawn(function()
        while tauntA do
            pcall(function()
                local t = game:GetService("TextChatService")
                local ch = t.TextChannels:FindFirstChild("RBXGeneral")
                if ch then 
                    ch:SendAsync(tauntMsg)
                else 
                    local rs = game:GetService("ReplicatedStorage")
                    local chatEvent = rs:FindFirstChild("DefaultChatSystemChatEvents")
                    if chatEvent then
                        local sayRequest = chatEvent:FindFirstChild("SayMessageRequest")
                        if sayRequest then
                            sayRequest:FireServer(tauntMsg, "All")
                        end
                    end
                end
            end)
            task.wait(0.8)
        end
    end)
end

local function stopTaunt()
    tauntA = false
    if tauntL then 
        task.cancel(tauntL) 
        tauntL = nil 
    end
end

-- ============ CONTINUOUS BAT AIMBOT ============
local function isValidTarget(targetChar)
    if not targetChar then return false end
    local hum = targetChar:FindFirstChildOfClass("Humanoid")
    local hrp = targetChar:FindFirstChild("HumanoidRootPart")
    local ff = targetChar:FindFirstChildOfClass("ForceField")
    return hum and hrp and hum.Health > 0 and not ff
end

local function getBestTarget(myHrp)
    if lockedTarget and isValidTarget(lockedTarget) then
        return lockedTarget:FindFirstChild("HumanoidRootPart"), lockedTarget
    end
    local shortest = math.huge
    local newTarget = nil
    local newHrp = nil
    for _, pl in ipairs(game.Players:GetPlayers()) do
        if pl ~= p and isValidTarget(pl.Character) then
            local hrp = pl.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local dist = (hrp.Position - myHrp.Position).Magnitude
                if dist < shortest then
                    shortest = dist
                    newHrp = hrp
                    newTarget = pl.Character
                end
            end
        end
    end
    lockedTarget = newTarget
    return newHrp, newTarget
end

local function findBatTool()
    local c = p.Character
    if not c then return nil end
    for _, tool in ipairs(c:GetChildren()) do
        if tool:IsA("Tool") and (tool.Name:lower():find("bat") or tool.Name:lower():find("slap")) then
            return tool
        end
    end
    local bp = p:FindFirstChildOfClass("Backpack")
    if bp then
        for _, tool in ipairs(bp:GetChildren()) do
            if tool:IsA("Tool") and (tool.Name:lower():find("bat") or tool.Name:lower():find("slap")) then
                return tool
            end
        end
    end
    return nil
end

local function startBatAimbot()
    if aimConnection then return end
    
    aimHighlight = Instance.new("Highlight")
    aimHighlight.Name = "ApexBatAimbot"
    aimHighlight.FillColor = Color3.fromRGB(255, 50, 100)
    aimHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    aimHighlight.FillTransparency = 0.4
    aimHighlight.OutlineTransparency = 0.2
    pcall(function() aimHighlight.Parent = p:WaitForChild("PlayerGui") end)
    
    local c = p.Character
    if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    local hum = c:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    
    hum.AutoRotate = false
    
    local align = hrp:FindFirstChild("ApexAimbotAlign") or Instance.new("AlignOrientation", hrp)
    align.Name = "ApexAimbotAlign"
    align.Mode = Enum.OrientationAlignmentMode.OneAttachment
    align.MaxTorque = math.huge
    align.Responsiveness = 250
    
    local attachment = hrp:FindFirstChild("ApexAimbotAttach") or Instance.new("Attachment", hrp)
    attachment.Name = "ApexAimbotAttach"
    align.Attachment0 = attachment
    
    batE = true
    
    aimConnection = rs.Heartbeat:Connect(function()
        if not batE then return end
        if not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then return end
        
        local currentHrp = p.Character.HumanoidRootPart
        local currentHum = p.Character:FindFirstChildOfClass("Humanoid")
        if not currentHrp or not currentHum then return end
        
        local bat = findBatTool()
        if bat and bat.Parent ~= p.Character then
            pcall(function() currentHum:EquipTool(bat) end)
        end
        
        local targetHrp, targetChar = getBestTarget(currentHrp)
        
        if targetHrp and targetChar then
            aimHighlight.Adornee = targetChar
            
            local targetVel = targetHrp.AssemblyLinearVelocity
            local speed = targetVel.Magnitude
            local predictTime = math.clamp(speed / 160, 0.05, 0.25)
            local predictedPos = targetHrp.Position + (targetVel * predictTime)
            
            local dirToTarget = (predictedPos - currentHrp.Position)
            local distance = dirToTarget.Magnitude
            
            align.CFrame = CFrame.lookAt(currentHrp.Position, predictedPos)
            
            local targetPos = predictedPos
            if distance > 0 then
                targetPos = predictedPos - (dirToTarget.Unit * 3.5)
            end
            
            local moveDir = (targetPos - currentHrp.Position)
            local moveDist = moveDir.Magnitude
            
            if moveDist > 1.5 then
                currentHrp.AssemblyLinearVelocity = moveDir.Unit * aimS
            else
                currentHrp.AssemblyLinearVelocity = targetVel
            end
            
            if distance <= batR then
                if bat and bat.Parent == p.Character then
                    pcall(function() bat:Activate() end)
                end
            end
        else
            aimHighlight.Adornee = nil
            lockedTarget = nil
            
            local moveDir = currentHum.MoveDirection
            if moveDir.Magnitude > 0.1 then
                currentHrp.AssemblyLinearVelocity = moveDir.Unit * aimS
            end
        end
    end)
end

local function stopBatAimbot()
    batE = false
    if aimConnection then
        aimConnection:Disconnect()
        aimConnection = nil
    end
    if aimHighlight then
        aimHighlight:Destroy()
        aimHighlight = nil
    end
    local c = p.Character
    local h = c and c:FindFirstChild("HumanoidRootPart")
    local hum = c and c:FindFirstChildOfClass("Humanoid")
    if h then
        local align = h:FindFirstChild("ApexAimbotAlign")
        if align then align:Destroy() end
        local attach = h:FindFirstChild("ApexAimbotAttach")
        if attach then attach:Destroy() end
    end
    if hum then hum.AutoRotate = true end
    lockedTarget = nil
end
-- ====================================================

local function startAutoL()
    if aLc then aLc:Disconnect() end
    aLp = 1
    aLc = rs.Heartbeat:Connect(function()
        if not aL or not gHrp or not gH then return end
        if aLp == 1 then
            local d = Vector3.new(pL1.X - gHrp.Position.X, 0, pL1.Z - gHrp.Position.Z)
            if d.Magnitude<1 then aLp=2 return end
            local md = d.Unit
            gH:Move(md, false)
            gHrp.AssemblyLinearVelocity = Vector3.new(md.X*ns, gHrp.AssemblyLinearVelocity.Y, md.Z*ns)
        elseif aLp == 2 then
            local d = Vector3.new(pL2.X - gHrp.Position.X, 0, pL2.Z - gHrp.Position.Z)
            if d.Magnitude<1 then
                aLp=0
                gH:Move(Vector3.zero, false)
                gHrp.AssemblyLinearVelocity = Vector3.zero
                task.delay(0.1, function() if aL then aLp=3 end end)
                return
            end
            local md = d.Unit
            gH:Move(md, false)
            gHrp.AssemblyLinearVelocity = Vector3.new(md.X*ns, gHrp.AssemblyLinearVelocity.Y, md.Z*ns)
        elseif aLp == 3 then
            local d = Vector3.new(pL1.X - gHrp.Position.X, 0, pL1.Z - gHrp.Position.Z)
            if d.Magnitude<1 then aLp=4 return end
            local md = d.Unit
            gH:Move(md, false)
            gHrp.AssemblyLinearVelocity = Vector3.new(md.X*ss, gHrp.AssemblyLinearVelocity.Y, md.Z*ss)
        elseif aLp == 4 then
            local d = Vector3.new(lf.X - gHrp.Position.X, 0, lf.Z - gHrp.Position.Z)
            if d.Magnitude<1 then
                gH:Move(Vector3.zero, false)
                gHrp.AssemblyLinearVelocity = Vector3.zero
                aL = false
                return
            end
            local md = d.Unit
            gH:Move(md, false)
            gHrp.AssemblyLinearVelocity = Vector3.new(md.X*ss, gHrp.AssemblyLinearVelocity.Y, md.Z*ss)
        end
    end)
end

local function stopAutoL()
    aL = false
    if aLc then aLc:Disconnect() aLc=nil end
    aLp = 1
    local hh = getHum()
    if hh then hh:Move(Vector3.zero, false) end
end

local function startAutoR()
    if aRc then aRc:Disconnect() end
    aRp = 1
    aRc = rs.Heartbeat:Connect(function()
        if not aR or not gHrp or not gH then return end
        if aRp == 1 then
            local d = Vector3.new(pR1.X - gHrp.Position.X, 0, pR1.Z - gHrp.Position.Z)
            if d.Magnitude<1 then aRp=2 return end
            local md = d.Unit
            gH:Move(md, false)
            gHrp.AssemblyLinearVelocity = Vector3.new(md.X*ns, gHrp.AssemblyLinearVelocity.Y, md.Z*ns)
        elseif aRp == 2 then
            local d = Vector3.new(pR2.X - gHrp.Position.X, 0, pR2.Z - gHrp.Position.Z)
            if d.Magnitude<1 then
                aRp=0
                gH:Move(Vector3.zero, false)
                gHrp.AssemblyLinearVelocity = Vector3.zero
                task.delay(0.1, function() if aR then aRp=3 end end)
                return
            end
            local md = d.Unit
            gH:Move(md, false)
            gHrp.AssemblyLinearVelocity = Vector3.new(md.X*ns, gHrp.AssemblyLinearVelocity.Y, md.Z*ns)
        elseif aRp == 3 then
            local d = Vector3.new(pR1.X - gHrp.Position.X, 0, pR1.Z - gHrp.Position.Z)
            if d.Magnitude<1 then aRp=4 return end
            local md = d.Unit
            gH:Move(md, false)
            gHrp.AssemblyLinearVelocity = Vector3.new(md.X*ss, gHrp.AssemblyLinearVelocity.Y, md.Z*ss)
        elseif aRp == 4 then
            local d = Vector3.new(rf.X - gHrp.Position.X, 0, rf.Z - gHrp.Position.Z)
            if d.Magnitude<1 then
                gH:Move(Vector3.zero, false)
                gHrp.AssemblyLinearVelocity = Vector3.zero
                aR = false
                return
            end
            local md = d.Unit
            gH:Move(md, false)
            gHrp.AssemblyLinearVelocity = Vector3.new(md.X*ss, gHrp.AssemblyLinearVelocity.Y, md.Z*ss)
        end
    end)
end

local function stopAutoR()
    aR = false
    if aRc then aRc:Disconnect() aRc=nil end
    aRp = 1
    local hh = getHum()
    if hh then hh:Move(Vector3.zero, false) end
end

local function doTpDown()
    local r = getHrp()
    if not r then return end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.FilterDescendantsInstances = {p.Character}
    local res = workspace:Raycast(r.Position, Vector3.new(0,-500,0), params)
    if res then r.CFrame = CFrame.new(Vector3.new(r.Position.X, res.Position.Y+3, r.Position.Z))
    else r.CFrame = r.CFrame * CFrame.new(0,-20,0) end
    r.AssemblyLinearVelocity = Vector3.zero
end

local wfConns = {}
local wfActive = false
local function startWf()
    wfActive = true
    table.insert(wfConns, rs.Stepped:Connect(function()
        if not wfActive then return end
        for _,pl in ipairs(game.Players:GetPlayers()) do
            if pl~=p and pl.Character then
                for _,part in ipairs(pl.Character:GetChildren()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end
    end))
    local co = coroutine.create(function()
        while wfActive do
            rs.Heartbeat:Wait()
            local root = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
            if not root then rs.Heartbeat:Wait() end
            local vel = root.Velocity
            root.Velocity = vel*10000 + Vector3.new(0,10000,0)
            rs.RenderStepped:Wait()
            if root and root.Parent then root.Velocity = vel end
            rs.Stepped:Wait()
            if root and root.Parent then root.Velocity = vel + Vector3.new(0,0.1,0) end
        end
    end)
    coroutine.resume(co)
    table.insert(wfConns, co)
end
local function stopWf()
    wfActive = false
    for _,c in ipairs(wfConns) do
        if typeof(c)=="RBXScriptConnection" then c:Disconnect()
        elseif typeof(c)=="thread" then pcall(task.cancel,c) end
    end
    wfConns = {}
end
local function doDrop() startWf() task.delay(0.4, stopWf) end

uis.JumpRequest:Connect(function()
    if not infJ then return end
    local h = getHrp()
    if h then h.AssemblyLinearVelocity = Vector3.new(h.AssemblyLinearVelocity.X, 54, h.AssemblyLinearVelocity.Z) end
end)
rs.Heartbeat:Connect(function()
    if not infJ then return end
    local h = getHrp()
    if h and h.AssemblyLinearVelocity.Y < -80 then h.AssemblyLinearVelocity = Vector3.new(h.AssemblyLinearVelocity.X, -80, h.AssemblyLinearVelocity.Z) end
end)

local unwalkC = nil
local function startUnwalk()
    if unwalkC then return end
    unwalkC = rs.Heartbeat:Connect(function()
        if not unwalkE then if unwalkC then unwalkC:Disconnect() unwalkC=nil end return end
        local c = p.Character
        if not c then return end
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum then
            local anim = hum:FindFirstChild("Animator")
            if anim then for _,t in ipairs(anim:GetPlayingAnimationTracks()) do t:Stop(0) end end
        end
    end)
end
local function stopUnwalk() if unwalkC then unwalkC:Disconnect() unwalkC=nil end end

local espConns = {}
local function createEsp(pl)
    if pl==p or not pl.Character then return end
    local c = pl.Character
    local r = c:FindFirstChild("HumanoidRootPart")
    local h = c:FindFirstChild("Head")
    if not r or not h then return end
    if c:FindFirstChild("ApexESP") then return end
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ApexESP"
    box.Adornee = r
    box.Size = Vector3.new(4,6,2)
    box.Color3 = a
    box.Transparency = 0.45
    box.AlwaysOnTop = true
    box.Parent = c
    local bb = Instance.new("BillboardGui")
    bb.Name = "ApexESP_Name"
    bb.Adornee = h
    bb.Size = UDim2.new(0,150,0,30)
    bb.StudsOffset = Vector3.new(0,2.5,0)
    bb.AlwaysOnTop = true
    bb.Parent = c
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = pl.DisplayName
    lbl.TextColor3 = w
    lbl.Font = Enum.Font.GothamBold
    lbl.TextScaled = true
    lbl.Parent = bb
end
local function enableEsp()
    for _,pl in ipairs(game.Players:GetPlayers()) do
        if pl~=p then
            if pl.Character then pcall(function() createEsp(pl) end) end
            table.insert(espConns, pl.CharacterAdded:Connect(function() task.wait(0.1) if espE then pcall(function() createEsp(pl) end) end end))
        end
    end
    table.insert(espConns, game.Players.PlayerAdded:Connect(function(pl)
        if pl==p then return end
        table.insert(espConns, pl.CharacterAdded:Connect(function() task.wait(0.1) if espE then pcall(function() createEsp(pl) end) end end))
    end))
end
local function disableEsp()
    for _,pl in ipairs(game.Players:GetPlayers()) do
        if pl.Character then
            local b = pl.Character:FindFirstChild("ApexESP")
            local n = pl.Character:FindFirstChild("ApexESP_Name")
            if b then b:Destroy() end if n then n:Destroy() end
        end
    end
    for _,c in ipairs(espConns) do if c and c.Connected then c:Disconnect() end end
    espConns = {}
end

local xrayO = {}
local function enableOpt()
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        ls.GlobalShadows = false
        ls.Brightness = 2
        for _,o in ipairs(workspace:GetDescendants()) do
            pcall(function()
                if o:IsA("ParticleEmitter") or o:IsA("Trail") or o:IsA("Smoke") or o:IsA("Fire") or o:IsA("Sparkles") then o.Enabled=false o:Destroy()
                elseif o:IsA("BasePart") then
                    o.CastShadow = false
                    o.Material = Enum.Material.Plastic
                    if o.Anchored and (o.Name:lower():find("base") or (o.Parent and o.Parent.Name:lower():find("base"))) then
                        xrayO[o] = o.LocalTransparencyModifier
                        o.LocalTransparencyModifier = 0.88
                    end
                elseif o:IsA("Sky") then o:Destroy() end
            end)
        end
    end)
end
local function disableOpt()
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        ls.GlobalShadows = true
    end)
    for part,val in pairs(xrayO) do if part and part.Parent then part.LocalTransparencyModifier = val end end
    xrayO = {}
end

local fovC = nil
local function applyFov()
    if fovC then fovC:Disconnect() end
    fovC = rs.RenderStepped:Connect(function() cam.FieldOfView = fovV end)
end

local animalC = {}
local promptC = {}
local stealC = {}
local stealConn = nil
local progConn = nil
local stealStart = nil

local function isMyBase(name)
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return false end
    local plot = plots:FindFirstChild(name)
    if not plot then return false end
    local sign = plot:FindFirstChild("PlotSign")
    if not sign then return false end
    local yb = sign:FindFirstChild("YourBase")
    return yb and yb:IsA("BillboardGui") and yb.Enabled == true
end

local function scanPlot(plot)
    if not plot or not plot:IsA("Model") then return end
    if isMyBase(plot.Name) then return end
    local pods = plot:FindFirstChild("AnimalPodiums")
    if not pods then return end
    for _,pod in ipairs(pods:GetChildren()) do
        if pod:IsA("Model") and pod:FindFirstChild("Base") then
            table.insert(animalC, {plot=plot.Name,slot=pod.Name,pos=pod:GetPivot().Position,uid=plot.Name.."_"..pod.Name})
        end
    end
end

local function findPrompt(ad)
    if not ad then return nil end
    local cp = promptC[ad.uid]
    if cp and cp.Parent then return cp end
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil end
    local plot = plots:FindFirstChild(ad.plot)
    if not plot then return nil end
    local pods = plot:FindFirstChild("AnimalPodiums")
    if not pods then return nil end
    local pod = pods:FindFirstChild(ad.slot)
    if not pod then return nil end
    local base = pod:FindFirstChild("Base")
    if not base then return nil end
    local sp = base:FindFirstChild("Spawn")
    if not sp then return nil end
    local att = sp:FindFirstChild("PromptAttachment")
    if not att then return nil end
    for _,p in ipairs(att:GetChildren()) do if p:IsA("ProximityPrompt") then promptC[ad.uid]=p return p end end
end

local function buildCb(prompt)
    if stealC[prompt] then return end
    local data = {hold={},trigger={},ready=true}
    pcall(function()
        if getconnections then
            for _,c in ipairs(getconnections(prompt.PromptButtonHoldBegan)) do if type(c.Function)=="function" then table.insert(data.hold,c.Function) end end
            for _,c in ipairs(getconnections(prompt.Triggered)) do if type(c.Function)=="function" then table.insert(data.trigger,c.Function) end end
        end
    end)
    if #data.hold>0 or #data.trigger>0 then stealC[prompt]=data end
end

local function execSteal(prompt)
    local data = stealC[prompt]
    if not data or not data.ready then return false end
    data.ready = false
    stealing = true
    stealStart = tick()
    if progLabel then progLabel.Text = "STEALING..." end
    if progConn then progConn:Disconnect() end
    progConn = rs.Heartbeat:Connect(function()
        if not stealing then progConn:Disconnect() return end
        local prog = math.clamp((tick()-stealStart)/stealD,0,1)
        if progFill then progFill.Size = UDim2.new(prog,0,1,0) end
        if progPct then progPct.Text = math.floor(prog*100).."%" end
    end)
    task.spawn(function()
        for _,f in ipairs(data.hold) do task.spawn(f) end
        task.wait(stealD)
        for _,f in ipairs(data.trigger) do task.spawn(f) end
        if progConn then progConn:Disconnect() end
        if progLabel then progLabel.Text = "READY" end
        if progPct then progPct.Text = "" end
        if progFill then progFill.Size = UDim2.new(0,0,1,0) end
        data.ready = true
        stealing = false
    end)
    return true
end

local function nearestAnimal()
    local h = getHrp()
    if not h then return nil end
    local best,bestD = nil,math.huge
    for _,ad in ipairs(animalC) do
        if not isMyBase(ad.plot) and ad.pos then
            local d = (h.Position - ad.pos).Magnitude
            if d<bestD then bestD=d best=ad end
        end
    end
    return best
end

local function startAutoSteal()
    if stealConn then return end
    stealConn = rs.Heartbeat:Connect(function()
        if not stealE or stealing then return end
        local target = nearestAnimal()
        if not target then return end
        local h = getHrp()
        if not h then return end
        if (h.Position - target.pos).Magnitude > stealR then return end
        local prompt = promptC[target.uid]
        if not prompt or not prompt.Parent then prompt = findPrompt(target) end
        if prompt then buildCb(prompt) execSteal(prompt) end
    end)
end
local function stopAutoSteal()
    if stealConn then stealConn:Disconnect() stealConn=nil end
    stealing = false
    if progConn then progConn:Disconnect() progConn=nil end
    if progFill then progFill.Size = UDim2.new(0,0,1,0) end
    if progLabel then progLabel.Text = "READY" end
    if progPct then progPct.Text = "" end
end

local tpCd = false
local function detectSide()
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return "Left" end
    for _,plot in ipairs(plots:GetChildren()) do
        local sign = plot:FindFirstChild("PlotSign")
        if sign then
            local yb = sign:FindFirstChild("YourBase")
            if yb and yb:IsA("BillboardGui") and yb.Enabled then
                local center = plot:FindFirstChildWhichIsA("BasePart")
                local z = center and center.Position.Z or 0
                return z>60 and "Right" or "Left"
            end
        end
    end
    return "Left"
end
local function tpMove(pos)
    local r = getHrp()
    if not r then return end
    r.CFrame = CFrame.new(pos)
    r.AssemblyLinearVelocity = Vector3.zero
end
local function doRagTp()
    if tpCd then return end
    tpCd = true
    local side = detectSide()
    local steps = tpSteps[side]
    tpMove(tpPre)
    task.delay(0.1, function()
        tpMove(steps[1])
        task.delay(0.1, function()
            tpMove(steps[2])
            task.delay(1.2, function() tpCd = false end)
        end)
    end)
end
local ragConn = nil
local function startRagTp()
    if ragConn then return end
    local c = p.Character
    if not c then return end
    local hum = c:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    ragConn = hum.StateChanged:Connect(function(_,ns)
        if not ragTP then return end
        if ns == Enum.HumanoidStateType.Physics or ns == Enum.HumanoidStateType.Ragdoll or ns == Enum.HumanoidStateType.FallingDown then
            task.defer(doRagTp)
        end
    end)
end
local function stopRagTp()
    if ragConn then ragConn:Disconnect() ragConn=nil end
end

local speedBb = nil
local function makeSpeedBb()
    local c = p.Character
    if not c then return end
    local head = c:FindFirstChild("Head")
    if not head then return end
    if speedBb then pcall(function() speedBb:Destroy() end) end
    speedBb = Instance.new("BillboardGui")
    speedBb.Name = "ApexSpeed"
    speedBb.Adornee = head
    speedBb.Size = UDim2.new(0,130,0,30)
    speedBb.StudsOffset = Vector3.new(0,3.2,0)
    speedBb.AlwaysOnTop = true
    speedBb.Parent = head
    local lbl = Instance.new("TextLabel")
    lbl.Name = "SpeedLbl"
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = w
    lbl.TextStrokeColor3 = a
    lbl.TextStrokeTransparency = 0.3
    lbl.Font = Enum.Font.GothamBold
    lbl.TextScaled = true
    lbl.Text = "Speed: 0"
    lbl.Parent = speedBb
end

rs.RenderStepped:Connect(function()
    if not speedBb or not speedBb.Parent then return end
    local h = getHrp()
    if not h then return end
    local lbl = speedBb:FindFirstChild("SpeedLbl")
    if not lbl then return end
    local v = h.AssemblyLinearVelocity
    lbl.Text = "Speed: " .. math.floor(Vector3.new(v.X,0,v.Z).Magnitude)
end)

rs.Heartbeat:Connect(function()
    if not gC or not gH or not gHrp then return end
    if hopE and spaceH then doHop() end
    if not batE and not aL and not aR then
        local md = gH.MoveDirection
        if md.Magnitude > 0.1 then
            local spd = slowE and ss or ns
            gHrp.AssemblyLinearVelocity = Vector3.new(md.X*spd, gHrp.AssemblyLinearVelocity.Y, md.Z*spd)
        end
    end
end)

uis.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then spaceH = true end
end)
uis.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then spaceH = false end
end)

local function setupChar(c)
    gC = c
    gH = c:WaitForChild("Humanoid",5)
    gHrp = c:WaitForChild("HumanoidRootPart",5)
    if not gH or not gHrp then return end
    task.wait(0.5)
    makeSpeedBb()
    if antiR then startAnti() end
    if espE then enableEsp() end
    if batE then startBatAimbot() end
    if unwalkE then startUnwalk() end
    if ragTP then startRagTp() end
    if counterMedusaEnabled then
        stopCounterMedusa()
        startCounterMedusa()
    end
    if batCounterEnabled then
        stopBatCounter()
        startBatCounter()
    end
end

if p.Character then setupChar(p.Character) end
p.CharacterAdded:Connect(function(c) task.wait(0.5) setupChar(c) end)

task.spawn(function()
    task.wait(2)
    local plots = workspace:WaitForChild("Plots",10)
    if not plots then return end
    for _,plot in ipairs(plots:GetChildren()) do if plot:IsA("Model") then scanPlot(plot) end end
    plots.ChildAdded:Connect(function(plot) if plot:IsA("Model") then task.wait(0.5) scanPlot(plot) end end)
    task.spawn(function() while task.wait(5) do animalC={} for _,plot in ipairs(plots:GetChildren()) do if plot:IsA("Model") then scanPlot(plot) end end end end)
end)

-- CREATE GUI (simplified - same as before but without desync)
sg = Instance.new("ScreenGui")
sg.Name = "ApexHub"
sg.ResetOnSpawn = false
sg.Parent = p:WaitForChild("PlayerGui")

local blur = Instance.new("BlurEffect", ls)
blur.Size = 0

-- MAIN FRAME
mf = Instance.new("Frame", sg)
mf.Size = UDim2.new(0,300,0,480)
mf.Position = UDim2.new(0.5,-150,0.5,-240)
mf.BackgroundColor3 = b
mf.BackgroundTransparency = 0.15
mf.BorderSizePixel = 0
mf.Visible = false
mf.Active = true
Instance.new("UICorner", mf).CornerRadius = UDim.new(0,20)
local glassStroke = Instance.new("UIStroke", mf)
glassStroke.Color = Color3.fromRGB(255,255,255)
glassStroke.Transparency = 0.3
glassStroke.Thickness = 1
local borderGlow = Instance.new("UIGradient", glassStroke)
borderGlow.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,a),ColorSequenceKeypoint.new(0.5,a2),ColorSequenceKeypoint.new(1,a)})

-- TITLE BAR
local titleBar = Instance.new("Frame", mf)
titleBar.Size = UDim2.new(1,0,0,50)
titleBar.BackgroundColor3 = Color3.fromRGB(10,10,18)
titleBar.BackgroundTransparency = 0.3
titleBar.BorderSizePixel = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0,20)

local titleLbl = Instance.new("TextLabel", titleBar)
titleLbl.Size = UDim2.new(1,0,1,0)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = "APEX HUB"
titleLbl.Font = Enum.Font.GothamBlack
titleLbl.TextSize = 22
titleLbl.TextColor3 = w
local titleGrad = Instance.new("UIGradient", titleLbl)
titleGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,a),ColorSequenceKeypoint.new(1,a2)})

-- PING BAR
local pingFrame = Instance.new("Frame", sg)
pingFrame.Size = UDim2.new(0,220,0,32)
pingFrame.Position = UDim2.new(0.5,-110,0,10)
pingFrame.BackgroundColor3 = Color3.fromRGB(15,15,25)
pingFrame.BackgroundTransparency = 0.2
pingFrame.BorderSizePixel = 0
Instance.new("UICorner", pingFrame).CornerRadius = UDim.new(0,16)
Instance.new("UIStroke", pingFrame).Color = a

local hubName = Instance.new("TextLabel", pingFrame)
hubName.Size = UDim2.new(0,60,1,0)
hubName.Position = UDim2.new(0,8,0,0)
hubName.BackgroundTransparency = 1
hubName.Text = "APEX"
hubName.TextColor3 = a
hubName.Font = Enum.Font.GothamBold
hubName.TextSize = 12

local pingIcon = Instance.new("TextLabel", pingFrame)
pingIcon.Size = UDim2.new(0,25,1,0)
pingIcon.Position = UDim2.new(0,75,0,0)
pingIcon.BackgroundTransparency = 1
pingIcon.Text = "📶"
pingIcon.TextColor3 = w
pingIcon.Font = Enum.Font.GothamBold
pingIcon.TextSize = 14

pingVal = Instance.new("TextLabel", pingFrame)
pingVal.Size = UDim2.new(0,40,1,0)
pingVal.Position = UDim2.new(0,105,0,0)
pingVal.BackgroundTransparency = 1
pingVal.Text = "0"
pingVal.TextColor3 = w
pingVal.Font = Enum.Font.GothamBold
pingVal.TextSize = 13

local barBg = Instance.new("Frame", pingFrame)
barBg.Size = UDim2.new(0,70,0,10)
barBg.Position = UDim2.new(0,148,0.5,-5)
barBg.BackgroundColor3 = Color3.fromRGB(30,30,40)
barBg.BorderSizePixel = 0
Instance.new("UICorner", barBg).CornerRadius = UDim.new(1,0)

pingFill = Instance.new("Frame", barBg)
pingFill.Size = UDim2.new(1,0,1,0)
pingFill.BorderSizePixel = 0
Instance.new("UICorner", pingFill).CornerRadius = UDim.new(1,0)

local msLabel = Instance.new("TextLabel", pingFrame)
msLabel.Size = UDim2.new(0,20,1,0)
msLabel.Position = UDim2.new(1,-25,0,0)
msLabel.BackgroundTransparency = 1
msLabel.Text = "ms"
msLabel.TextColor3 = a
msLabel.Font = Enum.Font.GothamBold
msLabel.TextSize = 10

-- PROGRESS BAR
progFrame = Instance.new("Frame", sg)
progFrame.Size = UDim2.new(0,220,0,36)
progFrame.Position = UDim2.new(0.5,-110,1,-85)
progFrame.BackgroundColor3 = Color3.fromRGB(15,15,25)
progFrame.BackgroundTransparency = 0.2
progFrame.BorderSizePixel = 0
Instance.new("UICorner", progFrame).CornerRadius = UDim.new(0,12)
Instance.new("UIStroke", progFrame).Color = a

progLabel = Instance.new("TextLabel", progFrame)
progLabel.Size = UDim2.new(0.4,0,0.5,0)
progLabel.Position = UDim2.new(0,10,0,2)
progLabel.BackgroundTransparency = 1
progLabel.Text = "READY"
progLabel.TextColor3 = w
progLabel.Font = Enum.Font.GothamBold
progLabel.TextSize = 10

progPct = Instance.new("TextLabel", progFrame)
progPct.Size = UDim2.new(0.3,0,0.5,0)
progPct.Position = UDim2.new(0.4,0,0,2)
progPct.BackgroundTransparency = 1
progPct.Text = ""
progPct.TextColor3 = a
progPct.Font = Enum.Font.GothamBold
progPct.TextSize = 11

radLabel = Instance.new("TextLabel", progFrame)
radLabel.Size = UDim2.new(0,35,0,12)
radLabel.Position = UDim2.new(1,-70,0,4)
radLabel.BackgroundTransparency = 1
radLabel.Text = "Rad:"
radLabel.TextColor3 = Color3.fromRGB(180,180,200)
radLabel.Font = Enum.Font.GothamBold
radLabel.TextSize = 9

radIn = Instance.new("TextBox", progFrame)
radIn.Size = UDim2.new(0,35,0,12)
radIn.Position = UDim2.new(1,-33,0,4)
radIn.BackgroundTransparency = 1
radIn.Text = tostring(stealR)
radIn.TextColor3 = a
radIn.Font = Enum.Font.GothamBold
radIn.TextSize = 9
radIn.BorderSizePixel = 0
radIn.FocusLost:Connect(function()
    local n = tonumber(radIn.Text)
    if n then stealR = math.clamp(math.floor(n),5,200) radIn.Text = tostring(stealR) end
end)

local progBarBg = Instance.new("Frame", progFrame)
progBarBg.Size = UDim2.new(0.9,0,0,6)
progBarBg.Position = UDim2.new(0.05,0,1,-12)
progBarBg.BackgroundColor3 = Color3.fromRGB(25,25,35)
progBarBg.BorderSizePixel = 0
Instance.new("UICorner", progBarBg).CornerRadius = UDim.new(1,0)

progFill = Instance.new("Frame", progBarBg)
progFill.Size = UDim2.new(0,0,1,0)
progFill.BackgroundColor3 = a
progFill.BorderSizePixel = 0
Instance.new("UICorner", progFill).CornerRadius = UDim.new(1,0)

-- UPDATE PING
task.spawn(function()
    while true do
        task.wait(0.5)
        pcall(function()
            local ping = math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            if pingVal then pingVal.Text = ping end
            if pingFill then
                local pct = math.clamp(ping/300,0,1)
                pingFill.Size = UDim2.new(pct,0,1,0)
                if ping<100 then pingFill.BackgroundColor3 = Color3.fromRGB(0,255,100)
                elseif ping<200 then pingFill.BackgroundColor3 = Color3.fromRGB(255,200,0)
                elseif ping<300 then pingFill.BackgroundColor3 = Color3.fromRGB(255,100,0)
                else pingFill.BackgroundColor3 = Color3.fromRGB(255,50,50) end
            end
        end)
    end
end)

-- POSITION LOCK BUTTON
posLockBtn = Instance.new("TextButton", titleBar)
posLockBtn.Size = UDim2.new(0,70,0,28)
posLockBtn.Position = UDim2.new(1,-80,0.5,-14)
posLockBtn.BackgroundColor3 = Color3.fromRGB(40,45,55)
posLockBtn.Text = "🔓 UNLOCK"
posLockBtn.Font = Enum.Font.GothamBold
posLockBtn.TextSize = 9
posLockBtn.TextColor3 = w
posLockBtn.BorderSizePixel = 0
Instance.new("UICorner", posLockBtn).CornerRadius = UDim.new(0,8)

-- SCALING BUTTONS
plusBtn = Instance.new("TextButton", titleBar)
plusBtn.Size = UDim2.new(0,24,0,24)
plusBtn.Position = UDim2.new(1,-52,0.5,-12)
plusBtn.BackgroundColor3 = Color3.fromRGB(30,35,45)
plusBtn.Text = "+"
plusBtn.Font = Enum.Font.GothamBold
plusBtn.TextSize = 14
plusBtn.TextColor3 = a
plusBtn.BorderSizePixel = 0
Instance.new("UICorner", plusBtn).CornerRadius = UDim.new(0,6)

minusBtn = Instance.new("TextButton", titleBar)
minusBtn.Size = UDim2.new(0,24,0,24)
minusBtn.Position = UDim2.new(1,-26,0.5,-12)
minusBtn.BackgroundColor3 = Color3.fromRGB(30,35,45)
minusBtn.Text = "-"
minusBtn.Font = Enum.Font.GothamBold
minusBtn.TextSize = 14
minusBtn.TextColor3 = a
minusBtn.BorderSizePixel = 0
Instance.new("UICorner", minusBtn).CornerRadius = UDim.new(0,6)

local gScale = 1.0
local baseW, baseH = 300, 480
plusBtn.MouseButton1Click:Connect(function()
    gScale = math.min(gScale+0.1,2.0)
    mf.Size = UDim2.new(0,baseW*gScale,0,baseH*gScale)
    mf.Position = UDim2.new(0.5,-(baseW*gScale)/2,0.5,-(baseH*gScale)/2)
end)
minusBtn.MouseButton1Click:Connect(function()
    gScale = math.max(gScale-0.1,0.4)
    mf.Size = UDim2.new(0,baseW*gScale,0,baseH*gScale)
    mf.Position = UDim2.new(0.5,-(baseW*gScale)/2,0.5,-(baseH*gScale)/2)
end)

-- DISCORD LINK
discordLbl = Instance.new("TextLabel", mf)
discordLbl.Size = UDim2.new(1,0,0,18)
discordLbl.Position = UDim2.new(0,0,1,-22)
discordLbl.BackgroundTransparency = 1
discordLbl.Text = "discord.gg/5FaWfEvmJ"
discordLbl.Font = Enum.Font.GothamBold
discordLbl.TextSize = 9
discordLbl.TextColor3 = a

-- TAB MENU
tabContainer = Instance.new("Frame", mf)
tabContainer.Size = UDim2.new(1,-20,0,32)
tabContainer.Position = UDim2.new(0,10,0,58)
tabContainer.BackgroundTransparency = 1

local function makeTab(text, xPos)
    local tab = Instance.new("TextButton", tabContainer)
    tab.Size = UDim2.new(0.2,-4,1,0)
    tab.Position = UDim2.new(xPos,2,0,0)
    tab.BackgroundColor3 = Color3.fromRGB(30,30,40)
    tab.Text = text
    tab.Font = Enum.Font.GothamBold
    tab.TextSize = 10
    tab.TextColor3 = Color3.fromRGB(160,160,160)
    tab.BorderSizePixel = 0
    Instance.new("UICorner", tab).CornerRadius = UDim.new(0,8)
    return tab
end

featTab = makeTab("FEATURES", 0)
movTab = makeTab("MOVEMENT", 0.2)
visTab = makeTab("VISUALS", 0.4)
setTab = makeTab("SETTINGS", 0.6)
bindTab = makeTab("BINDS", 0.8)

local function makeScrollFrame()
    local sf = Instance.new("ScrollingFrame", mf)
    sf.Size = UDim2.new(1,-20,1,-122)
    sf.Position = UDim2.new(0,10,0,98)
    sf.BackgroundTransparency = 1
    sf.BorderSizePixel = 0
    sf.ScrollBarThickness = 3
    sf.ScrollBarImageColor3 = a
    sf.CanvasSize = UDim2.new(0,0,0,0)
    sf.AutomaticCanvasSize = Enum.AutomaticSize.Y
    sf.Visible = false
    local layout = Instance.new("UIListLayout", sf)
    layout.Padding = UDim.new(0,6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    return sf
end

featFrame = makeScrollFrame()
movFrame = makeScrollFrame()
visFrame = makeScrollFrame()
setFrame = makeScrollFrame()
bindFrame = makeScrollFrame()
featFrame.Visible = true

frames = {featFrame, movFrame, visFrame, setFrame, bindFrame}
tabs = {featTab, movTab, visTab, setTab, bindTab}

for i, tab in ipairs(tabs) do
    tab.MouseButton1Click:Connect(function()
        for j, f in ipairs(frames) do f.Visible = (i==j) end
        for j, t in ipairs(tabs) do
            t.BackgroundColor3 = (i==j) and a or Color3.fromRGB(30,30,40)
            t.TextColor3 = (i==j) and w or Color3.fromRGB(160,160,160)
        end
    end)
end

-- TOGGLE FUNCTIONS
toggleStates = {}
mobBtnRefs = {}

local function updateToggle(name, state)
    local t = toggleStates[name]
    if t then
        t.state = state
        t.track.BackgroundColor3 = state and a or Color3.fromRGB(30,30,40)
        t.dot.Position = state and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)
    end
    if mobBtnRefs[name] then
        ts:Create(mobBtnRefs[name], TweenInfo.new(0.15), {BackgroundColor3 = state and Color3.fromRGB(138,43,226) or Color3.fromRGB(20,20,30)}):Play()
    end
end

local function makeToggle(parent, name, order, callback, defaultOn)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1,0,0,36)
    row.BackgroundColor3 = Color3.fromRGB(18,18,25)
    row.BorderSizePixel = 0
    row.LayoutOrder = order
    Instance.new("UICorner", row).CornerRadius = UDim.new(0,10)
    
    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(1,-70,1,0)
    lbl.Position = UDim2.new(0,12,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = w
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local track = Instance.new("Frame", row)
    track.Size = UDim2.new(0,40,0,20)
    track.Position = UDim2.new(1,-52,0.5,-10)
    local initState = (savedT[name] ~= nil) and savedT[name] or (defaultOn or false)
    track.BackgroundColor3 = initState and a or Color3.fromRGB(30,30,40)
    track.BorderSizePixel = 0
    Instance.new("UICorner", track).CornerRadius = UDim.new(1,0)
    
    local dot = Instance.new("Frame", track)
    dot.Size = UDim2.new(0,16,0,16)
    dot.Position = initState and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)
    dot.BackgroundColor3 = w
    dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)
    
    toggleStates[name] = {track=track,dot=dot,state=initState,dotSz=16}
    if initState and callback then task.defer(function() callback(true) end) end
    
    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(1,0,1,0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.MouseButton1Click:Connect(function()
        local ns = not toggleStates[name].state
        toggleStates[name].state = ns
        track.BackgroundColor3 = ns and a or Color3.fromRGB(30,30,40)
        dot.Position = ns and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)
        if callback then callback(ns) end
        savedT[name] = ns
        task.defer(saveCfg)
    end)
    return row
end

local function makeSection(parent, text, order)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Size = UDim2.new(1,0,0,24)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = a
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.LayoutOrder = order
end

local function makeNumInput(parent, labelText, defaultVal, order, onChanged)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1,0,0,36)
    row.BackgroundColor3 = Color3.fromRGB(18,18,25)
    row.BorderSizePixel = 0
    row.LayoutOrder = order
    Instance.new("UICorner", row).CornerRadius = UDim.new(0,10)
    
    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(1,-90,1,0)
    lbl.Position = UDim2.new(0,12,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = w
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local box = Instance.new("TextBox", row)
    box.Size = UDim2.new(0,60,0,24)
    box.Position = UDim2.new(1,-72,0.5,-12)
    box.BackgroundColor3 = Color3.fromRGB(25,25,35)
    box.Text = tostring(defaultVal)
    box.TextColor3 = a
    box.Font = Enum.Font.GothamBold
    box.TextSize = 11
    box.TextXAlignment = Enum.TextXAlignment.Center
    box.BorderSizePixel = 0
    box.ClearTextOnFocus = false
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,6)
    box.FocusLost:Connect(function()
        local n = tonumber(box.Text)
        if n then
            if onChanged then onChanged(n) end
            task.defer(saveCfg)
        else
            box.Text = tostring(defaultVal)
        end
    end)
    return row, box
end

-- FEATURES TAB
makeSection(featFrame, "  COMBAT", 1)
makeToggle(featFrame, "Bat Aimbot", 2, function(v)
    if v then
        if aL then stopAutoL() updateToggle("Auto Play Left", false) end
        if aR then stopAutoR() updateToggle("Auto Play Right", false) end
        startBatAimbot()
    else
        stopBatAimbot()
    end
end)
makeToggle(featFrame, "Anti Ragdoll (EclipseX)", 3, function(v) 
    antiR = v 
    if v then 
        startAnti() 
    else 
        stopAnti() 
    end 
end)
makeToggle(featFrame, "Counter Medusa", 4, function(v)
    counterMedusaEnabled = v
    if v then 
        startCounterMedusa()
        local circleBtn = mobBtnRefs["MedusaCircle"]
        if circleBtn then circleBtn.BackgroundColor3 = Color3.fromRGB(255,50,50) end
    else 
        stopCounterMedusa()
        local circleBtn = mobBtnRefs["MedusaCircle"]
        if circleBtn then circleBtn.BackgroundColor3 = Color3.fromRGB(20,20,30) end
    end
end)
makeToggle(featFrame, "Bat Counter (Hit Back)", 5, function(v)
    batCounterEnabled = v
    if v then 
        startBatCounter()
        local circleBtn = mobBtnRefs["BatCounterCircle"]
        if circleBtn then circleBtn.BackgroundColor3 = Color3.fromRGB(255,50,50) end
    else 
        stopBatCounter()
        local circleBtn = mobBtnRefs["BatCounterCircle"]
        if circleBtn then circleBtn.BackgroundColor3 = Color3.fromRGB(20,20,30) end
    end
end)
makeToggle(featFrame, "Ragdoll TP", 6, function(v) ragTP = v if v then startRagTp() else stopRagTp() end end)
makeToggle(featFrame, "Unwalk", 7, function(v) unwalkE = v if v then startUnwalk() else stopUnwalk() end end)
makeSection(featFrame, "  STEAL", 8)
makeToggle(featFrame, "Auto Steal", 9, function(v) stealE = v if v then startAutoSteal() else stopAutoSteal() end end)
makeSection(featFrame, "  SPEED", 10)
makeToggle(featFrame, "Slow Down", 11, function(v) slowE = v end)
makeSection(featFrame, "  DROP", 12)

local dropBtn2 = Instance.new("TextButton", featFrame)
dropBtn2.Size = UDim2.new(1,0,0,36)
dropBtn2.BackgroundColor3 = Color3.fromRGB(25,30,40)
dropBtn2.Text = "▼  DO DROP"
dropBtn2.Font = Enum.Font.GothamBold
dropBtn2.TextSize = 12
dropBtn2.TextColor3 = a
dropBtn2.BorderSizePixel = 0
dropBtn2.LayoutOrder = 13
Instance.new("UICorner", dropBtn2).CornerRadius = UDim.new(0,10)
Instance.new("UIStroke", dropBtn2).Color = a
dropBtn2.MouseButton1Click:Connect(function() task.spawn(doDrop) end)

local tpDownBtn = Instance.new("TextButton", featFrame)
tpDownBtn.Size = UDim2.new(1,0,0,36)
tpDownBtn.BackgroundColor3 = Color3.fromRGB(25,30,40)
tpDownBtn.Text = "⬇  TP DOWN"
tpDownBtn.Font = Enum.Font.GothamBold
tpDownBtn.TextSize = 12
tpDownBtn.TextColor3 = a
tpDownBtn.BorderSizePixel = 0
tpDownBtn.LayoutOrder = 14
Instance.new("UICorner", tpDownBtn).CornerRadius = UDim.new(0,10)
Instance.new("UIStroke", tpDownBtn).Color = a
tpDownBtn.MouseButton1Click:Connect(function() task.spawn(doTpDown) end)

-- TAUNT SPAM SECTION
makeSection(featFrame, "  TAUNT SPAM", 15)

local tauntRow = Instance.new("Frame", featFrame)
tauntRow.Size = UDim2.new(1,0,0,55)
tauntRow.BackgroundColor3 = Color3.fromRGB(25,30,45)
tauntRow.BorderSizePixel = 0
tauntRow.LayoutOrder = 16
Instance.new("UICorner", tauntRow).CornerRadius = UDim.new(0,12)

local tauntBigBtn = Instance.new("TextButton", tauntRow)
tauntBigBtn.Size = UDim2.new(1,-20,0,40)
tauntBigBtn.Position = UDim2.new(0,10,0.5,-20)
tauntBigBtn.BackgroundColor3 = Color3.fromRGB(138,43,226)
tauntBigBtn.Text = "💬 START TAUNT SPAM"
tauntBigBtn.Font = Enum.Font.GothamBold
tauntBigBtn.TextSize = 13
tauntBigBtn.TextColor3 = w
tauntBigBtn.BorderSizePixel = 0
Instance.new("UICorner", tauntBigBtn).CornerRadius = UDim.new(0,8)

local tauntStatusLabel = Instance.new("TextLabel", tauntRow)
tauntStatusLabel.Size = UDim2.new(0,100,0,20)
tauntStatusLabel.Position = UDim2.new(1,-110,0.5,-10)
tauntStatusLabel.BackgroundTransparency = 1
tauntStatusLabel.Text = "● OFF"
tauntStatusLabel.TextColor3 = Color3.fromRGB(255,100,100)
tauntStatusLabel.Font = Enum.Font.GothamBold
tauntStatusLabel.TextSize = 11

tauntBigBtn.MouseButton1Click:Connect(function()
    if not tauntA then
        startTaunt()
        tauntBigBtn.BackgroundColor3 = Color3.fromRGB(255,50,50)
        tauntBigBtn.Text = "🔴 STOP TAUNT SPAM"
        tauntStatusLabel.Text = "● ON"
        tauntStatusLabel.TextColor3 = Color3.fromRGB(100,255,100)
        local circleBtn = mobBtnRefs["TauntCircle"]
        if circleBtn then
            circleBtn.BackgroundColor3 = Color3.fromRGB(138,43,226)
        end
    else
        stopTaunt()
        tauntBigBtn.BackgroundColor3 = Color3.fromRGB(138,43,226)
        tauntBigBtn.Text = "💬 START TAUNT SPAM"
        tauntStatusLabel.Text = "● OFF"
        tauntStatusLabel.TextColor3 = Color3.fromRGB(255,100,100)
        local circleBtn = mobBtnRefs["TauntCircle"]
        if circleBtn then
            circleBtn.BackgroundColor3 = Color3.fromRGB(20,20,30)
        end
    end
end)

-- MOVEMENT TAB
makeSection(movFrame, "  AUTO PLAY", 1)
makeToggle(movFrame, "Auto Play Left", 2, function(v)
    if v then
        if batE then stopBatAimbot() updateToggle("Bat Aimbot", false) end
        if aR then stopAutoR() updateToggle("Auto Play Right", false) end
        aL = true
        startAutoL()
    else
        stopAutoL()
    end
end)
makeToggle(movFrame, "Auto Play Right", 3, function(v)
    if v then
        if batE then stopBatAimbot() updateToggle("Bat Aimbot", false) end
        if aL then stopAutoL() updateToggle("Auto Play Left", false) end
        aR = true
        startAutoR()
    else
        stopAutoR()
    end
end)
makeSection(movFrame, "  HOP", 4)
makeToggle(movFrame, "Hop Mode", 5, function(v) hopE = v end)

-- VISUALS TAB
makeSection(visFrame, "  PLAYER", 1)
makeToggle(visFrame, "Player ESP", 2, function(v) espE = v if v then enableEsp() else disableEsp() end end, true)
makeSection(visFrame, "  PERFORMANCE", 3)
makeToggle(visFrame, "Optimizer + XRay", 4, function(v) optE = v if v then enableOpt() else disableOpt() end end)

-- SETTINGS TAB
makeSection(setFrame, "  SPEEDS", 1)
makeNumInput(setFrame, "Normal Speed", ns, 2, function(v) ns = v end)
makeNumInput(setFrame, "Slow Speed", ss, 3, function(v) ss = v end)
makeSection(setFrame, "  STEAL", 4)
makeNumInput(setFrame, "Steal Radius", stealR, 5, function(v) stealR = math.clamp(v,5,200) end)
makeNumInput(setFrame, "Steal Duration", stealD, 6, function(v) stealD = math.max(0.05,v) end)
makeSection(setFrame, "  HOP", 7)
makeNumInput(setFrame, "Hop Power", hopP, 8, function(v) hopP = v end)
makeSection(setFrame, "  CAMERA / BAT", 9)
makeNumInput(setFrame, "FOV", fovV, 10, function(v) fovV = v applyFov() end)
makeNumInput(setFrame, "Aimbot Speed", aimS, 11, function(v) aimS = v end)
makeNumInput(setFrame, "Engage Range", batR, 12, function(v) batR = v end)
makeSection(setFrame, "  CONFIG", 13)

local saveBtn = Instance.new("TextButton", setFrame)
saveBtn.Size = UDim2.new(1,0,0,36)
saveBtn.BackgroundColor3 = Color3.fromRGB(35,45,35)
saveBtn.Text = "💾  SAVE CONFIG"
saveBtn.Font = Enum.Font.GothamBold
saveBtn.TextSize = 12
saveBtn.TextColor3 = w
saveBtn.BorderSizePixel = 0
saveBtn.LayoutOrder = 14
Instance.new("UICorner", saveBtn).CornerRadius = UDim.new(0,10)
saveBtn.MouseButton1Click:Connect(function()
    saveCfg()
    saveBtn.Text = "✔ SAVED!"
    task.delay(1.5, function() saveBtn.Text = "💾  SAVE CONFIG" end)
end)

-- BINDS TAB
makeSection(bindFrame, "  KEYBINDS (click to rebind)", 1)
local bindHint = Instance.new("TextLabel", bindFrame)
bindHint.Size = UDim2.new(1,0,0,32)
bindHint.BackgroundColor3 = Color3.fromRGB(25,20,35)
bindHint.BackgroundTransparency = 0
bindHint.BorderSizePixel = 0
bindHint.Text = "Click a key button then press\nany key to rebind. CTRL = clear."
bindHint.TextColor3 = Color3.fromRGB(180,170,220)
bindHint.Font = Enum.Font.GothamBold
bindHint.TextSize = 9
bindHint.TextWrapped = true
bindHint.LayoutOrder = 2
Instance.new("UICorner", bindHint).CornerRadius = UDim.new(0,8)

local bindList = {
    {"Auto L", "aL"}, {"Auto R", "aR"}, {"Steal", "steal"},
    {"Bat", "bat"}, {"AntiRD", "anti"}, {"Unwalk", "unwalk"},
    {"Slow", "slow"}, {"RTP", "rag"}, {"Drop", "drop"},
    {"Taunt", "taunt"}, {"TPD", "tp"}, {"Medusa", "medusa"}, {"BatCounter", "batcounter"},
}

for idx, entry in ipairs(bindList) do
    local displayName, keyName = entry[1], entry[2]
    local row = Instance.new("Frame", bindFrame)
    row.Size = UDim2.new(1,0,0,36)
    row.BackgroundColor3 = Color3.fromRGB(18,18,25)
    row.BorderSizePixel = 0
    row.LayoutOrder = idx + 2
    Instance.new("UICorner", row).CornerRadius = UDim.new(0,10)
    
    local nameLbl = Instance.new("TextLabel", row)
    nameLbl.Size = UDim2.new(1,-90,1,0)
    nameLbl.Position = UDim2.new(0,12,0,0)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = displayName
    nameLbl.TextColor3 = w
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextSize = 11
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local keyBtn = Instance.new("TextButton", row)
    keyBtn.Size = UDim2.new(0,65,0,24)
    keyBtn.Position = UDim2.new(1,-75,0.5,-12)
    keyBtn.BackgroundColor3 = Color3.fromRGB(35,35,45)
    keyBtn.Text = keys[keyName] and tostring(keys[keyName]):gsub("Enum.KeyCode.", "") or "NONE"
    keyBtn.Font = Enum.Font.GothamBold
    keyBtn.TextSize = 10
    keyBtn.TextColor3 = a
    keyBtn.BorderSizePixel = 0
    Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0,6)
    keyBtns[keyName] = keyBtn
    
    keyBtn.MouseButton1Click:Connect(function()
        if changingKey then return end
        changingKey = keyName
        keyBtn.Text = "..."
        keyBtn.TextColor3 = Color3.fromRGB(255,200,50)
        local conn
        conn = uis.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
                    keys[keyName] = nil
                    keyBtn.Text = "NONE"
                else
                    keys[keyName] = input.KeyCode
                    keyBtn.Text = tostring(input.KeyCode):gsub("Enum.KeyCode.", "")
                end
                keyBtn.TextColor3 = a
                changingKey = nil
                conn:Disconnect()
                task.defer(saveCfg)
            end
        end)
    end)
end

-- DRAG MAIN FRAME
local mainDrag = false
local mainDragStart = nil
local mainStartPos = nil
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        mainDrag = true
        mainDragStart = input.Position
        mainStartPos = mf.Position
    end
end)
uis.InputChanged:Connect(function(input)
    if mainDrag and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local d = input.Position - mainDragStart
        mf.Position = UDim2.new(mainStartPos.X.Scale, mainStartPos.X.Offset + d.X, mainStartPos.Y.Scale, mainStartPos.Y.Offset + d.Y)
    end
end)
uis.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        mainDrag = false
    end
end)

-- CIRCLE BUTTONS
local function makeCircleButton(label, row, col, saveKey, action, toggleName)
    local btn = Instance.new("TextButton", sg)
    btn.Size = UDim2.new(0, 85, 0, 40)
    
    local gap = 80
    local startY = -185
    local col1 = -160
    local col2 = -70
    
    if savedPos[saveKey] then
        btn.Position = savedPos[saveKey]
    else
        if col == "left" then
            btn.Position = UDim2.new(1, col1, 0.5, startY + (row * gap))
        else
            btn.Position = UDim2.new(1, col2, 0.5, startY + (row * gap))
        end
    end
    
    btn.Text = label
    btn.BackgroundColor3 = Color3.fromRGB(20,20,30)
    btn.BackgroundTransparency = 0.15
    btn.TextColor3 = w
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.TextWrapped = true
    btn.BorderSizePixel = 0
    btn.ZIndex = 20
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = a
    stroke.Thickness = 2.5
    stroke.Transparency = 0.2
    
    local glow = Instance.new("UIGradient", stroke)
    glow.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,a),ColorSequenceKeypoint.new(0.5,a2),ColorSequenceKeypoint.new(1,a)})
    
    if toggleName then
        mobBtnRefs[toggleName] = btn
    end
    
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    btn.InputBegan:Connect(function(input)
        if posLock then return end
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = btn.Position
        end
    end)
    
    uis.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            if posLock then
                dragging = false
                return
            end
            local d = input.Position - dragStart
            local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            btn.Position = newPos
            savedPos[saveKey] = newPos
            task.defer(saveCfg)
        end
    end)
    
    uis.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    btn.MouseButton1Click:Connect(action)
    return btn
end

-- CREATE CIRCLE BUTTONS
makeCircleButton("DROP", 0, "left", "drop", function() task.spawn(doDrop) end, nil)
makeCircleButton("A L", 0, "right", "aL", function()
    local ns = not aL
    if ns then
        if batE then stopBatAimbot() updateToggle("Bat Aimbot", false) end
        if aR then stopAutoR() updateToggle("Auto Play Right", false) end
        aL = true
        startAutoL()
    else
        stopAutoL()
    end
    updateToggle("Auto Play Left", ns)
end, "Auto Play Left")

makeCircleButton("BAT", 1, "left", "bat", function()
    local ns = not batE
    if ns then
        if aL then stopAutoL() updateToggle("Auto Play Left", false) end
        if aR then stopAutoR() updateToggle("Auto Play Right", false) end
        startBatAimbot()
    else
        stopBatAimbot()
    end
    updateToggle("Bat Aimbot", ns)
end, "Bat Aimbot")

makeCircleButton("A R", 1, "right", "aR", function()
    local ns = not aR
    if ns then
        if batE then stopBatAimbot() updateToggle("Bat Aimbot", false) end
        if aL then stopAutoL() updateToggle("Auto Play Left", false) end
        aR = true
        startAutoR()
    else
        stopAutoR()
    end
    updateToggle("Auto Play Right", ns)
end, "Auto Play Right")

makeCircleButton("SLOW", 2, "left", "slow", function()
    local ns = not slowE
    slowE = ns
    updateToggle("Slow Down", ns)
end, "Slow Down")

makeCircleButton("TP", 2, "right", "tp", function() task.spawn(doTpDown) end, nil)

-- TAUNT CIRCLE BUTTON
makeCircleButton("TNT", 3, "right", "tauntcircle", function()
    if not tauntA then 
        startTaunt()
        local btn = mobBtnRefs["TauntCircle"]
        if btn then
            btn.BackgroundColor3 = Color3.fromRGB(138,43,226)
        end
        if tauntBigBtn then
            tauntBigBtn.BackgroundColor3 = Color3.fromRGB(255,50,50)
            tauntBigBtn.Text = "🔴 STOP TAUNT SPAM"
            tauntStatusLabel.Text = "● ON"
            tauntStatusLabel.TextColor3 = Color3.fromRGB(100,255,100)
        end
    else 
        stopTaunt()
        local btn = mobBtnRefs["TauntCircle"]
        if btn then
            btn.BackgroundColor3 = Color3.fromRGB(20,20,30)
        end
        if tauntBigBtn then
            tauntBigBtn.BackgroundColor3 = Color3.fromRGB(138,43,226)
            tauntBigBtn.Text = "💬 START TAUNT SPAM"
            tauntStatusLabel.Text = "● OFF"
            tauntStatusLabel.TextColor3 = Color3.fromRGB(255,100,100)
        end
    end
end, "TauntCircle")

-- COUNTER MEDUSA CIRCLE BUTTON
makeCircleButton("MED", 3, "left", "medusa", function()
    counterMedusaEnabled = not counterMedusaEnabled
    if counterMedusaEnabled then 
        startCounterMedusa()
        local btn = mobBtnRefs["MedusaCircle"]
        if btn then
            btn.BackgroundColor3 = Color3.fromRGB(255,50,50)
            btn.Text = "MED"
        end
        updateToggle("Counter Medusa", true)
    else 
        stopCounterMedusa()
        local btn = mobBtnRefs["MedusaCircle"]
        if btn then
            btn.BackgroundColor3 = Color3.fromRGB(20,20,30)
            btn.Text = "MED"
        end
        updateToggle("Counter Medusa", false)
    end
end, "MedusaCircle")

-- BAT COUNTER CIRCLE BUTTON
makeCircleButton("BCTR", 4, "left", "batcounter", function()
    batCounterEnabled = not batCounterEnabled
    if batCounterEnabled then 
        startBatCounter()
        local btn = mobBtnRefs["BatCounterCircle"]
        if btn then
            btn.BackgroundColor3 = Color3.fromRGB(255,50,50)
            btn.Text = "BCTR"
        end
        updateToggle("Bat Counter (Hit Back)", true)
    else 
        stopBatCounter()
        local btn = mobBtnRefs["BatCounterCircle"]
        if btn then
            btn.BackgroundColor3 = Color3.fromRGB(20,20,30)
            btn.Text = "BCTR"
        end
        updateToggle("Bat Counter (Hit Back)", false)
    end
end, "BatCounterCircle")

-- POSITION LOCK FUNCTION
posLockBtn.MouseButton1Click:Connect(function()
    posLock = not posLock
    if posLock then
        posLockBtn.Text = "🔒 LOCK"
        posLockBtn.BackgroundColor3 = Color3.fromRGB(60,45,45)
    else
        posLockBtn.Text = "🔓 UNLOCK"
        posLockBtn.BackgroundColor3 = Color3.fromRGB(40,50,55)
    end
end)

-- APEX BUTTON
local apexBtn = Instance.new("TextButton", sg)
apexBtn.Size = UDim2.new(0, 85, 0, 40)
apexBtn.Position = UDim2.new(0, 15, 0.5, -22)
apexBtn.BackgroundColor3 = Color3.fromRGB(10,10,18)
apexBtn.BackgroundTransparency = 0.2
apexBtn.Text = "APEX"
apexBtn.TextSize = 14
apexBtn.Font = Enum.Font.GothamBold
apexBtn.TextColor3 = w
apexBtn.BorderSizePixel = 0
Instance.new("UICorner", apexBtn).CornerRadius = UDim.new(0, 10)

local apexStroke = Instance.new("UIStroke", apexBtn)
apexStroke.Color = a
apexStroke.Thickness = 2.5
apexStroke.Transparency = 0.2

local apexGlow = Instance.new("UIGradient", apexStroke)
apexGlow.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,a),ColorSequenceKeypoint.new(0.5,a2),ColorSequenceKeypoint.new(1,a)})

task.spawn(function()
    while apexBtn and apexBtn.Parent do
        for i=0,20 do apexStroke.Thickness = 2.5 + i*0.05 task.wait(0.04) end
        for i=0,20 do apexStroke.Thickness = 3.5 - i*0.05 task.wait(0.04) end
    end
end)

local apexDrag = false
local apexDragStart = nil
local apexStartPos = nil
apexBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        apexDrag = true
        apexDragStart = input.Position
        apexStartPos = apexBtn.Position
    end
end)
uis.InputChanged:Connect(function(input)
    if apexDrag and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local d = input.Position - apexDragStart
        apexBtn.Position = UDim2.new(apexStartPos.X.Scale, apexStartPos.X.Offset + d.X, apexStartPos.Y.Scale, apexStartPos.Y.Offset + d.Y)
    end
end)
uis.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        apexDrag = false
    end
end)
apexBtn.MouseButton1Click:Connect(function()
    mf.Visible = not mf.Visible
    if mf.Visible then blur.Size = 12 else blur.Size = 0 end
end)

-- FPS AND PING
local fpsLbl = Instance.new("TextLabel", titleBar)
fpsLbl.Size = UDim2.new(0,55,0,14)
fpsLbl.Position = UDim2.new(0,12,0,4)
fpsLbl.BackgroundTransparency = 1
fpsLbl.Text = "0 FPS"
fpsLbl.Font = Enum.Font.GothamBold
fpsLbl.TextSize = 10
fpsLbl.TextColor3 = a
fpsLbl.TextXAlignment = Enum.TextXAlignment.Left

local pingLbl2 = Instance.new("TextLabel", titleBar)
pingLbl2.Size = UDim2.new(0,55,0,14)
pingLbl2.Position = UDim2.new(1,-67,0,4)
pingLbl2.BackgroundTransparency = 1
pingLbl2.Text = "0ms"
pingLbl2.Font = Enum.Font.GothamBold
pingLbl2.TextSize = 10
pingLbl2.TextColor3 = a
pingLbl2.TextXAlignment = Enum.TextXAlignment.Right

local fc, lft = 0, tick()
rs.RenderStepped:Connect(function()
    fc = fc + 1
    local ct = tick()
    if ct - lft >= 1 then
        fpsLbl.Text = fc .. " FPS"
        fc = 0
        lft = ct
    end
    pcall(function()
        pingLbl2.Text = math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue()) .. "ms"
    end)
end)

-- KEYBIND HANDLER
uis.InputBegan:Connect(function(input, processed)
    if processed then return end
    if changingKey then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
    
    if keys.aL and input.KeyCode == keys.aL then
        local ns = not aL
        if ns then
            if batE then stopBatAimbot() updateToggle("Bat Aimbot", false) end
            if aR then stopAutoR() updateToggle("Auto Play Right", false) end
            aL = true
            startAutoL()
        else
            stopAutoL()
        end
        updateToggle("Auto Play Left", ns)
    elseif keys.aR and input.KeyCode == keys.aR then
        local ns = not aR
        if ns then
            if batE then stopBatAimbot() updateToggle("Bat Aimbot", false) end
            if aL then stopAutoL() updateToggle("Auto Play Left", false) end
            aR = true
            startAutoR()
        else
            stopAutoR()
        end
        updateToggle("Auto Play Right", ns)
    elseif keys.steal and input.KeyCode == keys.steal then
        local ns = not stealE
        stealE = ns
        if ns then startAutoSteal() else stopAutoSteal() end
        updateToggle("Auto Steal", ns)
    elseif keys.bat and input.KeyCode == keys.bat then
        local ns = not batE
        if ns then
            if aL then stopAutoL() updateToggle("Auto Play Left", false) end
            if aR then stopAutoR() updateToggle("Auto Play Right", false) end
            startBatAimbot()
        else
            stopBatAimbot()
        end
        updateToggle("Bat Aimbot", ns)
    elseif keys.anti and input.KeyCode == keys.anti then
        local ns = not antiR
        antiR = ns
        if ns then startAnti() else stopAnti() end
        updateToggle("Anti Ragdoll (EclipseX)", ns)
    elseif keys.medusa and input.KeyCode == keys.medusa then
        counterMedusaEnabled = not counterMedusaEnabled
        if counterMedusaEnabled then 
            startCounterMedusa()
            local circleBtn = mobBtnRefs["MedusaCircle"]
            if circleBtn then circleBtn.BackgroundColor3 = Color3.fromRGB(255,50,50) end
        else 
            stopCounterMedusa()
            local circleBtn = mobBtnRefs["MedusaCircle"]
            if circleBtn then circleBtn.BackgroundColor3 = Color3.fromRGB(20,20,30) end
        end
        updateToggle("Counter Medusa", counterMedusaEnabled)
    elseif keys.batcounter and input.KeyCode == keys.batcounter then
        batCounterEnabled = not batCounterEnabled
        if batCounterEnabled then 
            startBatCounter()
            local circleBtn = mobBtnRefs["BatCounterCircle"]
            if circleBtn then circleBtn.BackgroundColor3 = Color3.fromRGB(255,50,50) end
        else 
            stopBatCounter()
            local circleBtn = mobBtnRefs["BatCounterCircle"]
            if circleBtn then circleBtn.BackgroundColor3 = Color3.fromRGB(20,20,30) end
        end
        updateToggle("Bat Counter (Hit Back)", batCounterEnabled)
    elseif keys.unwalk and input.KeyCode == keys.unwalk then
        local ns = not unwalkE
        unwalkE = ns
        if ns then startUnwalk() else stopUnwalk() end
        updateToggle("Unwalk", ns)
    elseif keys.slow and input.KeyCode == keys.slow then
        local ns = not slowE
        slowE = ns
        updateToggle("Slow Down", ns)
    elseif keys.rag and input.KeyCode == keys.rag then
        local ns = not ragTP
        ragTP = ns
        if ns then startRagTp() else stopRagTp() end
        updateToggle("Ragdoll TP", ns)
    elseif keys.drop and input.KeyCode == keys.drop then
        task.spawn(doDrop)
    elseif keys.taunt and input.KeyCode == keys.taunt then
        if not tauntA then 
            startTaunt()
            if tauntBigBtn then
                tauntBigBtn.BackgroundColor3 = Color3.fromRGB(255,50,50)
                tauntBigBtn.Text = "🔴 STOP TAUNT SPAM"
                tauntStatusLabel.Text = "● ON"
                tauntStatusLabel.TextColor3 = Color3.fromRGB(100,255,100)
            end
            local circleBtn = mobBtnRefs["TauntCircle"]
            if circleBtn then
                circleBtn.BackgroundColor3 = Color3.fromRGB(138,43,226)
            end
        else 
            stopTaunt()
            if tauntBigBtn then
                tauntBigBtn.BackgroundColor3 = Color3.fromRGB(138,43,226)
                tauntBigBtn.Text = "💬 START TAUNT SPAM"
                tauntStatusLabel.Text = "● OFF"
                tauntStatusLabel.TextColor3 = Color3.fromRGB(255,100,100)
            end
            local circleBtn = mobBtnRefs["TauntCircle"]
            if circleBtn then
                circleBtn.BackgroundColor3 = Color3.fromRGB(20,20,30)
            end
        end
    elseif keys.tp and input.KeyCode == keys.tp then
        task.spawn(doTpDown)
    end
end)

-- FINAL SETUP
if espE then enableEsp() end
if antiR then startAnti() end
if counterMedusaEnabled then startCounterMedusa() end
if batCounterEnabled then startBatCounter() end
applyFov()
print("=== APEX HUB LOADED! ===")
print("✅ EclipseX Anti-Ragdoll - Original version")
print("✅ Counter Medusa - Press M or click MED button")
print("✅ Bat Counter - Press B or click BCTR button (hit back when attacked)")
print("✅ Bat Aimbot - Continuous")
print("Circle buttons: DROP, A L, BAT, A R, SLOW, TP, TNT, MED, BCTR")
]=],
})

table.insert(SCRIPTS, {
    name="Cursed Hub", icon="💀", desc="AUTO • SPEED • TP DOWN", isNew=false, kind="embed",
    code=[=[
-- [[ DEOBFUSCATED BY @Bhmatrades ]] --

-- // [1] SERVICES //
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- // [2] CONFIGURATION (EDITABLE) //
local CONFIG = {
	Gui = {
		Name = "CursedHub",
		DisplayOrder = 10,
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
	},

	Colors = {
		MainBackground = Color3.fromRGB(5, 5, 7),
		TitleBar = Color3.fromRGB(9, 9, 13),
		SectionBackground = Color3.fromRGB(14, 14, 18),
		Accent = Color3.fromRGB(210, 35, 55),
		Text = Color3.fromRGB(235, 235, 235),
		SecondaryText = Color3.fromRGB(160, 160, 160),
	},

	Defaults = {
		NormalSpeed = 60,
		CarrySpeed = 30,
		StealRadius = 20,
		StealDuration = 0.25,
		FloatHeight = 9.5,
	},

	Keybinds = {
		Mode = Enum.KeyCode.Q,
		AutoBat = Enum.KeyCode.E,
		AutoLeft = Enum.KeyCode.Z,
		AutoRight = Enum.KeyCode.C,
		DropBrainrot = Enum.KeyCode.X,
		TPDown = Enum.KeyCode.F,
		Float = Enum.KeyCode.J,
		HideGui = Enum.KeyCode.LeftControl,
	},
}

-- // [3] OBJECT REFERENCES //
local ScreenGui
local MainFrame
local TitleBar
local TitleLabel
local MinimizeButton
local ScrollingFrame
local SpeedLabel

local Toggles = {}
local CurrentSpeedValue = CONFIG.Defaults.NormalSpeed
local IsSpeedEnabled = false
local IsFloatEnabled = false
local FloatHeight = CONFIG.Defaults.FloatHeight

-- // [4] UTILITY FUNCTIONS //
local function getCharacter()
	return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function getHumanoid()
	local char = getCharacter()
	return char:WaitForChild("Humanoid")
end

local function getRootPart()
	local char = getCharacter()
	return char:WaitForChild("HumanoidRootPart")
end

local function createCorner(parent, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 12)
	corner.Parent = parent
	return corner
end

local function createStroke(parent, color, thickness)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color or CONFIG.Colors.Accent
	stroke.Thickness = thickness or 1
	stroke.Parent = parent
	return stroke
end

local function updateSpeedLabel()
	local root = getRootPart()
	local speed = root.AssemblyLinearVelocity.Magnitude
	SpeedLabel.Text = "Speed: " .. string.format("%.1f", speed)
end

-- // [5] GUI HANDLING (CLEAN ORIGINAL STRUCTURE) //
local function buildGUI()
	ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = CONFIG.Gui.Name
	ScreenGui.ResetOnSpawn = CONFIG.Gui.ResetOnSpawn
	ScreenGui.DisplayOrder = CONFIG.Gui.DisplayOrder
	ScreenGui.IgnoreGuiInset = CONFIG.Gui.IgnoreGuiInset
	ScreenGui.Parent = CoreGui

	MainFrame = Instance.new("Frame")
	MainFrame.Size = UDim2.new(0, 300, 0, 460)
	MainFrame.Position = UDim2.new(0, 20, 0, 20)
	MainFrame.BackgroundColor3 = CONFIG.Colors.MainBackground
	MainFrame.BorderSizePixel = 0
	MainFrame.ClipsDescendants = true
	MainFrame.Active = true
	MainFrame.Draggable = true
	MainFrame.Parent = ScreenGui
	createCorner(MainFrame, 12)

	TitleBar = Instance.new("Frame")
	TitleBar.Size = UDim2.new(1, 0, 0, 44)
	TitleBar.BackgroundColor3 = CONFIG.Colors.TitleBar
	TitleBar.BorderSizePixel = 0
	TitleBar.Parent = MainFrame
	createCorner(TitleBar, 6)

	TitleLabel = Instance.new("TextLabel")
	TitleLabel.Size = UDim2.new(1, -50, 1, 0)
	TitleLabel.Position = UDim2.new(0, 10, 0, 0)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Text = "CURSED HUB"
	TitleLabel.TextColor3 = CONFIG.Colors.Accent
	TitleLabel.Font = Enum.Font.GothamBlack
	TitleLabel.TextSize = 14
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Parent = TitleBar

	MinimizeButton = Instance.new("TextButton")
	MinimizeButton.Size = UDim2.new(0, 28, 0, 28)
	MinimizeButton.Position = UDim2.new(1, -34, 0.5, -14)
	MinimizeButton.BackgroundColor3 = Color3.fromRGB(18, 8, 10)
	MinimizeButton.Text = "-"
	MinimizeButton.TextColor3 = Color3.fromRGB(120, 20, 30)
	MinimizeButton.Font = Enum.Font.GothamBold
	MinimizeButton.TextSize = 22
	MinimizeButton.Parent = TitleBar
	createCorner(MinimizeButton, 6)

	ScrollingFrame = Instance.new("ScrollingFrame")
	ScrollingFrame.Size = UDim2.new(1, 0, 1, -44)
	ScrollingFrame.Position = UDim2.new(0, 0, 0, 44)
	ScrollingFrame.BackgroundTransparency = 1
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.ScrollBarThickness = 2
	ScrollingFrame.ScrollBarImageColor3 = CONFIG.Colors.Accent
	ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	ScrollingFrame.Parent = MainFrame

	local listLayout = Instance.new("UIListLayout")
	listLayout.SortOrder = Enum.SortOrder.LayoutOrder
	listLayout.Padding = UDim.new(0, 2)
	listLayout.Parent = ScrollingFrame

	local scrollPadding = Instance.new("UIPadding")
	scrollPadding.PaddingLeft = UDim.new(0, 7)
	scrollPadding.PaddingRight = UDim.new(0, 7)
	scrollPadding.PaddingTop = UDim.new(0, 7)
	scrollPadding.PaddingBottom = UDim.new(0, 10)
	scrollPadding.Parent = ScrollingFrame

	local speedContainer = Instance.new("Frame")
	speedContainer.Size = UDim2.new(1, -18, 0, 32)
	speedContainer.BackgroundColor3 = CONFIG.Colors.SectionBackground
	speedContainer.LayoutOrder = 0
	speedContainer.Parent = ScrollingFrame
	createCorner(speedContainer, 7)
	createStroke(speedContainer, Color3.fromRGB(22, 22, 28))

	SpeedLabel = Instance.new("TextLabel")
	SpeedLabel.Size = UDim2.new(1, -8, 1, 0)
	SpeedLabel.Position = UDim2.new(0, 8, 0, 0)
	SpeedLabel.BackgroundTransparency = 1
	SpeedLabel.Text = "Speed: 0.0"
	SpeedLabel.TextColor3 = CONFIG.Colors.Text
	SpeedLabel.Font = Enum.Font.GothamBold
	SpeedLabel.TextSize = 14
	SpeedLabel.Parent = speedContainer

	local featuresList = {
		{section = "SPEED", order = 1, name = "Normal Speed", type = "toggle", default = false, valueBox = true, defaultValue = CONFIG.Defaults.NormalSpeed},
		{section = "SPEED", order = 2, name = "Carry Speed", type = "toggle", default = false, valueBox = true, defaultValue = CONFIG.Defaults.CarrySpeed},
		{section = "SPEED", order = 3, name = "Mode", type = "toggle", default = false, keybind = CONFIG.Keybinds.Mode},

		{section = "COMBAT", order = 7, name = "Auto Bat", type = "toggle", default = false, keybind = CONFIG.Keybinds.AutoBat},

		{section = "STEAL", order = 10, name = "Radius", type = "value", defaultValue = CONFIG.Defaults.StealRadius},
		{section = "STEAL", order = 11, name = "Auto Steal", type = "toggle", default = false},
		{section = "STEAL", order = 12, name = "Steal Duration", type = "value", defaultValue = CONFIG.Defaults.StealDuration},

		{section = "MISC", order = 13, name = "Infinite Jump", type = "toggle", default = false},
		{section = "MISC", order = 14, name = "Anti Ragdoll", type = "toggle", default = false},
		{section = "MISC", order = 15, name = "Medusa Counter", type = "toggle", default = false},
		{section = "MISC", order = 16, name = "Unwalk", type = "toggle", default = false},

		{section = "VISUAL", order = 18, name = "Anti Lag", type = "toggle", default = false},
		{section = "VISUAL", order = 19, name = "Remove Accessories", type = "toggle", default = false},

		{section = "MOVEMENT", order = 21, name = "Auto Left", type = "toggle", default = false, keybind = CONFIG.Keybinds.AutoLeft},
		{section = "MOVEMENT", order = 22, name = "Auto Right", type = "toggle", default = false, keybind = CONFIG.Keybinds.AutoRight},
		{section = "MOVEMENT", order = 23, name = "Drop Brainrot", type = "toggle", default = false, keybind = CONFIG.Keybinds.DropBrainrot},
		{section = "MOVEMENT", order = 24, name = "TP Down", type = "toggle", default = false, keybind = CONFIG.Keybinds.TPDown},
		{section = "MOVEMENT", order = 25, name = "Float Height", type = "value", defaultValue = CONFIG.Defaults.FloatHeight},
		{section = "MOVEMENT", order = 26, name = "Float", type = "toggle", default = false, keybind = CONFIG.Keybinds.Float},

		{section = "INTERFACE", order = 28, name = "Hide / Show Gui", type = "toggle", default = false, keybind = CONFIG.Keybinds.HideGui},
	}

	local currentSectionFrame
	for _, feat in ipairs(featuresList) do
		if not currentSectionFrame or currentSectionFrame.LayoutOrder ~= feat.order then
			currentSectionFrame = Instance.new("Frame")
			currentSectionFrame.Size = UDim2.new(1, -18, 0, 50)
			currentSectionFrame.BackgroundColor3 = CONFIG.Colors.SectionBackground
			currentSectionFrame.BorderSizePixel = 0
			currentSectionFrame.LayoutOrder = feat.order
			currentSectionFrame.Parent = ScrollingFrame
			createCorner(currentSectionFrame, 7)
			createStroke(currentSectionFrame)

			local sectionTitle = Instance.new("TextLabel")
			sectionTitle.Size = UDim2.new(1, -8, 0, 20)
			sectionTitle.Position = UDim2.new(0, 8, 0, 0)
			sectionTitle.BackgroundTransparency = 1
			sectionTitle.Text = feat.section
			sectionTitle.TextColor3 = CONFIG.Colors.Accent
			sectionTitle.Font = Enum.Font.GothamBold
			sectionTitle.TextSize = 11
			sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
			sectionTitle.Parent = currentSectionFrame
		end

		local row = Instance.new("Frame")
		row.Size = UDim2.new(1, -16, 0, 28)
		row.Position = UDim2.new(0, 8, 0, 22)
		row.BackgroundTransparency = 1
		row.Parent = currentSectionFrame

		local nameLabel = Instance.new("TextLabel")
		nameLabel.Size = UDim2.new(0.58, 0, 1, 0)
		nameLabel.BackgroundTransparency = 1
		nameLabel.Text = feat.name
		nameLabel.TextColor3 = CONFIG.Colors.Text
		nameLabel.Font = Enum.Font.GothamBold
		nameLabel.TextSize = 11
		nameLabel.TextXAlignment = Enum.TextXAlignment.Left
		nameLabel.Parent = row

		if feat.type == "toggle" then
			local toggleBtn = Instance.new("TextButton")
			toggleBtn.Size = UDim2.new(0, 46, 0, 22)
			toggleBtn.Position = UDim2.new(1, -50, 0.5, -11)
			toggleBtn.BackgroundColor3 = Color3.fromRGB(39, 39, 54)
			toggleBtn.Text = "OFF"
			toggleBtn.TextColor3 = CONFIG.Colors.SecondaryText
			toggleBtn.Font = Enum.Font.GothamBold
			toggleBtn.TextSize = 9
			toggleBtn.Parent = row
			createCorner(toggleBtn, 5)

			Toggles[feat.name] = {enabled = feat.default, control = toggleBtn}

			toggleBtn.MouseButton1Click:Connect(function()
				local data = Toggles[feat.name]
				data.enabled = not data.enabled
				toggleBtn.Text = data.enabled and "ON" or "OFF"
				toggleBtn.TextColor3 = data.enabled and CONFIG.Colors.Accent or CONFIG.Colors.SecondaryText
			end)
		elseif feat.type == "value" then
			local valueBox = Instance.new("TextBox")
			valueBox.Size = UDim2.new(0, 50, 0, 22)
			valueBox.Position = UDim2.new(1, -56, 0.5, -11)
			valueBox.BackgroundColor3 = Color3.fromRGB(39, 39, 54)
			valueBox.Text = tostring(feat.defaultValue)
			valueBox.TextColor3 = CONFIG.Colors.Text
			valueBox.Font = Enum.Font.GothamBold
			valueBox.TextSize = 11
			valueBox.ClearTextOnFocus = false
			valueBox.Parent = row
			createCorner(valueBox, 5)

			valueBox.FocusLost:Connect(function()
				if feat.name == "Float Height" then
					FloatHeight = tonumber(valueBox.Text) or CONFIG.Defaults.FloatHeight
				elseif feat.name == "Normal Speed" then
					CurrentSpeedValue = tonumber(valueBox.Text) or CONFIG.Defaults.NormalSpeed
				end
			end)
		end
	end
end

-- // [6] FUNCTIONALITY //
local function handleFunctionality()
	RunService.Heartbeat:Connect(function()
		updateSpeedLabel()

		if IsSpeedEnabled then
			local root = getRootPart()
			local hum = getHumanoid()
			local moveDir = hum.MoveDirection
			if moveDir.Magnitude > 0 then
				root.AssemblyLinearVelocity = Vector3.new(moveDir.X * CurrentSpeedValue, root.AssemblyLinearVelocity.Y, moveDir.Z * CurrentSpeedValue)
			end
		end

		if IsFloatEnabled then
			local root = getRootPart()
			root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, 0, root.AssemblyLinearVelocity.Z)
			root.CFrame = CFrame.new(root.Position.X, FloatHeight, root.Position.Z) * CFrame.Angles(0, root.CFrame.Rotation.Y, 0)
		end
	end)

	local jumpConnection
	Toggles["Infinite Jump"].control.MouseButton1Click:Connect(function()
		local data = Toggles["Infinite Jump"]
		if data.enabled then
			if jumpConnection then jumpConnection:Disconnect() end
			jumpConnection = UserInputService.JumpRequest:Connect(function()
				getHumanoid():ChangeState(Enum.HumanoidStateType.Jumping)
			end)
		else
			if jumpConnection then
				jumpConnection:Disconnect()
				jumpConnection = nil
			end
		end
	end)

	Toggles["Remove Accessories"].control.MouseButton1Click:Connect(function()
		local data = Toggles["Remove Accessories"]
		if data.enabled then
			local char = getCharacter()
			for _, acc in ipairs(char:GetChildren()) do
				if acc:IsA("Accessory") then acc:Destroy() end
			end
		end
	end)

	Toggles["Anti Ragdoll"].control.MouseButton1Click:Connect(function()
		local data = Toggles["Anti Ragdoll"]
		if data.enabled then
			local hum = getHumanoid()
			hum.PlatformStand = false
			hum:ChangeState(Enum.HumanoidStateType.Running)
		end
	end)

	UserInputService.InputBegan:Connect(function(input, gp)
		if gp then return end
		if input.KeyCode == CONFIG.Keybinds.HideGui then
			ScreenGui.Enabled = not ScreenGui.Enabled
		end
	end)

	MinimizeButton.MouseButton1Click:Connect(function()
		ScrollingFrame.Visible = not ScrollingFrame.Visible
	end)

	Toggles["Normal Speed"].control.MouseButton1Click:Connect(function()
		local data = Toggles["Normal Speed"]
		IsSpeedEnabled = data.enabled
		if data.enabled then
			CurrentSpeedValue = CONFIG.Defaults.NormalSpeed
		end
	end)

	Toggles["Float"].control.MouseButton1Click:Connect(function()
		local data = Toggles["Float"]
		IsFloatEnabled = data.enabled
	end)
end

-- // [7] INITIALIZATION //
local function init()
	buildGUI()
	handleFunctionality()
	print('Cursed Hub Loaded')
end

init()
]=],
})

table.insert(SCRIPTS, {
    name="Silent Duels", icon="🌑", desc="AUTO STEAL • RAGDOLL TP • BAT", isNew=false, kind="embed",
    code=[[
task.wait(0.1)
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local isTablet = UserInputService.TouchEnabled and (workspace.CurrentCamera.ViewportSize.X > 900)
local guiScale = isMobile and (isTablet and 0.75 or 0.55) or 1

local sg = Instance.new("ScreenGui")
sg.Name = "LUNI010_AutoDuels"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.IgnoreGuiInset = true
sg.Parent = Player.PlayerGui

-- Clean background (no dark overlay)
local centerText = Instance.new("TextLabel")
centerText.Parent = sg
centerText.Size = UDim2.new(0, 280, 0, 40)
centerText.Position = UDim2.new(0.5, -140, 0.5, -20)
centerText.BackgroundTransparency = 1
centerText.Text = ".gg/NGEMSasjjG"
centerText.Font = Enum.Font.GothamBlack
centerText.TextScaled = false
centerText.TextSize = 24
centerText.TextColor3 = Color3.fromRGB(220, 240, 180)
centerText.TextTransparency = 0.15   -- 85% visible
centerText.TextStrokeTransparency = 0.5
centerText.ZIndex = 100

-- Pulse animation for invite
local pulseTween = TweenService:Create(centerText, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1), 
    {TextTransparency = 0, TextStrokeTransparency = 0.3})
pulseTween:Play()

-- Ragdoll TP Indicator
local ragdollIndicator = Instance.new("TextLabel")
ragdollIndicator.Parent = sg
ragdollIndicator.Size = UDim2.new(0, 220, 0, 38)
ragdollIndicator.Position = UDim2.new(1, -240, 0, 20)
ragdollIndicator.BackgroundColor3 = Color3.fromRGB(25, 30, 20)
ragdollIndicator.Text = "âš¡ Ragdoll TP Active âš¡"
ragdollIndicator.TextColor3 = Color3.fromRGB(180, 230, 120)
ragdollIndicator.Font = Enum.Font.GothamSemibold
ragdollIndicator.TextSize = 15 * guiScale
ragdollIndicator.BackgroundTransparency = 0.1
ragdollIndicator.Visible = false
ragdollIndicator.ZIndex = 100
Instance.new("UICorner", ragdollIndicator).CornerRadius = UDim.new(0, 10)
local indStroke = Instance.new("UIStroke", ragdollIndicator)
indStroke.Color = Color3.fromRGB(180, 230, 120)
indStroke.Thickness = 2
indStroke.Transparency = 0.3

-- Ragdoll TP Coordinates
local RAGDOLL_COORDS = {
    right = {
        Vector3.new(-464.46, -5.85, 23.38),
        Vector3.new(-486.15, -3.50, 23.85)
    },
    left = {
        Vector3.new(-469.95, -5.85, 90.99),
        Vector3.new(-485.91, -3.55, 96.77)
    }
}

local VP = workspace.CurrentCamera.ViewportSize
local W = math.min(580 * guiScale, VP.X * 0.95)
local H = math.min(620 * guiScale, VP.Y * 0.90)

local Features = {
    SpeedBoost         = false,
    AntiRagdoll        = false,
    AutoSteal          = false,
    SpamBat            = false,
    SpeedWhileStealing = false,
    HitCircle          = false,
    Helicopter         = false,
    GalaxyMode         = false,
    Unwalk             = false,
    Optimizer          = false,
    XRay               = false,
    Float              = false,
    RightSteal         = false,
    LeftSteal          = false,
    BatAimbot          = false,
    RagdollTP          = false,  
}

local Values = {
    BoostSpeed           = 30,
    SpinSpeed            = 10,
    DEFAULT_GRAVITY      = 196.2,
    GalaxyGravityPercent = 70,
    StealingSpeedValue   = 29,
    STEAL_RADIUS         = 20,
    HOP_POWER            = 35,
    HOP_COOLDOWN         = 0.08,
    BatAimbotSpeed       = 55,   
}

-- Color cycling with 4 beautiful colors
local accentColors = {
    Color3.fromRGB(139, 155, 98),  -- sage
    Color3.fromRGB(98, 165, 155),  -- teal
    Color3.fromRGB(165, 98, 140),  -- mauve
    Color3.fromRGB(196, 154, 108)  -- gold
}
local accentObjects = {}
local function addAccent(obj, prop)
    table.insert(accentObjects, {obj = obj, prop = prop})
end

task.spawn(function()
    local t = 0
    local duration = 8  -- seconds for full cycle
    while sg.Parent do
        t = (t + task.wait() / duration) % 1
        -- smooth interpolation between 4 colors
        local section = t * 3
        local i1 = math.floor(section) % 4 + 1
        local i2 = i1 % 4 + 1
        local frac = section % 1
        local col = Color3.new(
            accentColors[i1].R * (1-frac) + accentColors[i2].R * frac,
            accentColors[i1].G * (1-frac) + accentColors[i2].G * frac,
            accentColors[i1].B * (1-frac) + accentColors[i2].B * frac
        )
        for _, r in ipairs(accentObjects) do
            pcall(function() r.obj[r.prop] = col end)
        end
    end
end)

local PB_W = 270 * guiScale
local PB_H = 30 * guiScale

local progressBar = Instance.new("Frame", sg)
progressBar.Size = UDim2.new(0, PB_W, 0, PB_H)
progressBar.Position = UDim2.new(0.5, -PB_W / 2, 1, -90 * guiScale)
progressBar.BackgroundColor3 = Color3.fromRGB(25, 28, 20)
progressBar.BackgroundTransparency = 0.1
progressBar.BorderSizePixel = 0
progressBar.ClipsDescendants = true
progressBar.ZIndex = 10
Instance.new("UICorner", progressBar).CornerRadius = UDim.new(1, 0)

local pStroke = Instance.new("UIStroke", progressBar)
pStroke.Thickness = 2.5 * guiScale
pStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
pStroke.Transparency = 0.3
addAccent(pStroke, "Color")

local pTrack = Instance.new("Frame", progressBar)
pTrack.Size = UDim2.new(1, -10 * guiScale, 0, 8 * guiScale)
pTrack.Position = UDim2.new(0, 5 * guiScale, 1, -12 * guiScale)
pTrack.BackgroundColor3 = Color3.fromRGB(40, 45, 30)
pTrack.BorderSizePixel = 0
pTrack.ZIndex = 11
Instance.new("UICorner", pTrack).CornerRadius = UDim.new(1, 0)

local ProgressBarFill = Instance.new("Frame", pTrack)
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
ProgressBarFill.BackgroundColor3 = Color3.fromRGB(180, 230, 120)
ProgressBarFill.BorderSizePixel = 0
ProgressBarFill.ZIndex = 12
Instance.new("UICorner", ProgressBarFill).CornerRadius = UDim.new(1, 0)
addAccent(ProgressBarFill, "BackgroundColor3")

-- Pulse animation on progress bar fill
local pulseProgress = TweenService:Create(ProgressBarFill, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1), 
    {BackgroundColor3 = Color3.fromRGB(220, 255, 180)})
pulseProgress:Play()

local ProgressPercentLabel = Instance.new("TextLabel", progressBar)
ProgressPercentLabel.Size = UDim2.new(1, 0, 1, -8 * guiScale)
ProgressPercentLabel.Position = UDim2.new(0, 0, 0, 0)
ProgressPercentLabel.BackgroundTransparency = 1
ProgressPercentLabel.Text = "0%"
ProgressPercentLabel.Font = Enum.Font.GothamBlack
ProgressPercentLabel.TextSize = 14 * guiScale
ProgressPercentLabel.TextXAlignment = Enum.TextXAlignment.Center
ProgressPercentLabel.TextYAlignment = Enum.TextYAlignment.Center
ProgressPercentLabel.ZIndex = 13
addAccent(ProgressPercentLabel, "TextColor3")

local function resetProgressBar()
    ProgressPercentLabel.Text = "0%"
    ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
end

local main = Instance.new("Frame", sg)
main.Name = "Main"
main.Size = UDim2.new(0, W, 0, H)

if isMobile then
    main.Position = UDim2.new(0.5, -W/2, 0.5, -H/2)
else
    main.Position = UDim2.new(1, -W - 20, 0, 20)
end

main.BackgroundColor3 = Color3.fromRGB(18, 20, 14)
main.BackgroundTransparency = 0.1
main.BorderSizePixel = 0
main.Active = true
main.Draggable = false
main.ClipsDescendants = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16 * guiScale)

local mainStroke = Instance.new("UIStroke", main)
mainStroke.Thickness = 2 * guiScale
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
mainStroke.Transparency = 0.2
addAccent(mainStroke, "Color")

-- Subtle drop shadow
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Parent = main
shadow.BackgroundTransparency = 1
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.Image = "rbxassetid://6015897843"
shadow.ImageColor3 = Color3.new(0, 0, 0)
shadow.ImageTransparency = 0.7
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 10, 10)
shadow.ZIndex = -1

local headerH = isMobile and 70 * guiScale or 62 * guiScale

local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, headerH)
header.BackgroundColor3 = Color3.fromRGB(25, 28, 20)
header.BackgroundTransparency = 0.15
header.BorderSizePixel = 0
header.ZIndex = 4
header.Active = true
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 16 * guiScale)

local headerBottom = Instance.new("Frame", header)
headerBottom.Size = UDim2.new(1, 0, 0.5, 0)
headerBottom.Position = UDim2.new(0, 0, 0.5, 0)
headerBottom.BackgroundColor3 = Color3.fromRGB(25, 28, 20)
headerBottom.BackgroundTransparency = 0.15
headerBottom.BorderSizePixel = 0
headerBottom.ZIndex = 3

local headerLine = Instance.new("Frame", header)
headerLine.Size = UDim2.new(1, 0, 0, 2 * guiScale)
headerLine.Position = UDim2.new(0, 0, 1, -1)
headerLine.BorderSizePixel = 0
headerLine.ZIndex = 5
addAccent(headerLine, "BackgroundColor3")

local iconLbl = Instance.new("TextLabel", header)
iconLbl.Size = UDim2.new(0, 32 * guiScale, 0, 32 * guiScale)
iconLbl.Position = UDim2.new(0, 12 * guiScale, 0.5, -16 * guiScale)
iconLbl.BackgroundTransparency = 1
iconLbl.Text = "âš¡"
iconLbl.TextSize = 24 * guiScale
iconLbl.Font = Enum.Font.GothamBlack
iconLbl.ZIndex = 6
addAccent(iconLbl, "TextColor3")

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -100 * guiScale, 0, 24 * guiScale)
title.Position = UDim2.new(0, 48 * guiScale, 0, 8 * guiScale)
title.BackgroundTransparency = 1
title.Text = "SilentHub Auto Duels"
title.Font = Enum.Font.GothamBlack
title.TextSize = 18 * guiScale
title.TextColor3 = Color3.fromRGB(240, 240, 235)
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 6

local subtitle = Instance.new("TextLabel", header)
subtitle.Size = UDim2.new(1, -100 * guiScale, 0, 18 * guiScale)
subtitle.Position = UDim2.new(0, 48 * guiScale, 0, 34 * guiScale)
subtitle.BackgroundTransparency = 1
subtitle.Text = "discord.gg/NGEMSasjjG  â€¢  Auto Duels"
subtitle.TextColor3 = Color3.fromRGB(200, 200, 180)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 11 * guiScale
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.ZIndex = 6

local closeBtnSize = isMobile and 42 * guiScale or 32 * guiScale
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, closeBtnSize, 0, closeBtnSize)
closeBtn.Position = UDim2.new(1, -(closeBtnSize + 10 * guiScale), 0.5, -closeBtnSize / 2)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 70, 70)
closeBtn.Text = "âœ•"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBlack
closeBtn.TextSize = 16 * guiScale
closeBtn.BorderSizePixel = 0
closeBtn.ZIndex = 7
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8 * guiScale)
closeBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(220, 90, 90), Size = UDim2.new(0, closeBtnSize*1.1, 0, closeBtnSize*1.1)}):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(180, 70, 70), Size = UDim2.new(0, closeBtnSize, 0, closeBtnSize)}):Play()
end)

if isMobile then
    local minimized = false
    local minimizeBtn = Instance.new("TextButton", header)
    minimizeBtn.Size = UDim2.new(0, closeBtnSize, 0, closeBtnSize)
    minimizeBtn.Position = UDim2.new(1, -(closeBtnSize * 2 + 20 * guiScale), 0.5, -closeBtnSize / 2)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 140)
    minimizeBtn.Text = "âˆ’"
    minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeBtn.Font = Enum.Font.GothamBlack
    minimizeBtn.TextSize = 20 * guiScale
    minimizeBtn.BorderSizePixel = 0
    minimizeBtn.ZIndex = 7
    Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 8 * guiScale)
    minimizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, W, 0, headerH)}):Play()
            minimizeBtn.Text = "+"
        else
            TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, W, 0, H)}):Play()
            minimizeBtn.Text = "âˆ’"
        end
    end)
end

-- Dragging
do
    local dragging, dragStart, startPos = false, nil, nil
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            local newX = math.clamp(startPos.X.Offset + delta.X, 0, VP.X - W)
            local newY = math.clamp(startPos.Y.Offset + delta.Y, 0, VP.Y - headerH)
            main.Position = UDim2.new(0, newX, 0, newY)
        end
    end)
end

local contentArea = Instance.new("Frame", main)
contentArea.Size = UDim2.new(1, 0, 1, -headerH)
contentArea.Position = UDim2.new(0, 0, 0, headerH)
contentArea.BackgroundTransparency = 1
contentArea.BorderSizePixel = 0
contentArea.ClipsDescendants = true
contentArea.ZIndex = 3

local divider = Instance.new("Frame", contentArea)
divider.Size = UDim2.new(0, 2 * guiScale, 1, -20 * guiScale)
divider.Position = UDim2.new(0.5, 0, 0, 10 * guiScale)
divider.BorderSizePixel = 0
divider.ZIndex = 4
addAccent(divider, "BackgroundColor3")

local leftColumn = Instance.new("Frame", contentArea)
leftColumn.Size = UDim2.new(0.48, 0, 1, -12 * guiScale)
leftColumn.Position = UDim2.new(0.01, 0, 0, 6 * guiScale)
leftColumn.BackgroundTransparency = 1
leftColumn.BorderSizePixel = 0
leftColumn.ClipsDescendants = true

local leftScroll = Instance.new("ScrollingFrame", leftColumn)
leftScroll.Size = UDim2.new(1, 0, 1, 0)
leftScroll.BackgroundTransparency = 1
leftScroll.BorderSizePixel = 0
leftScroll.ScrollBarThickness = isMobile and 5 * guiScale or 4 * guiScale
leftScroll.ScrollBarImageColor3 = Color3.fromRGB(180, 230, 120)
leftScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
leftScroll.ScrollingDirection = Enum.ScrollingDirection.Y
leftScroll.ElasticBehavior = Enum.ElasticBehavior.Always
leftScroll.ZIndex = 3

local rightColumn = Instance.new("Frame", contentArea)
rightColumn.Size = UDim2.new(0.48, 0, 1, -12 * guiScale)
rightColumn.Position = UDim2.new(0.51, 0, 0, 6 * guiScale)
rightColumn.BackgroundTransparency = 1
rightColumn.BorderSizePixel = 0
rightColumn.ClipsDescendants = true

local rightScroll = Instance.new("ScrollingFrame", rightColumn)
rightScroll.Size = UDim2.new(1, 0, 1, 0)
rightScroll.BackgroundTransparency = 1
rightScroll.BorderSizePixel = 0
rightScroll.ScrollBarThickness = isMobile and 5 * guiScale or 4 * guiScale
rightScroll.ScrollBarImageColor3 = Color3.fromRGB(180, 230, 120)
rightScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
rightScroll.ScrollingDirection = Enum.ScrollingDirection.Y
rightScroll.ElasticBehavior = Enum.ElasticBehavior.Always
rightScroll.ZIndex = 3

local leftLayout = Instance.new("UIListLayout", leftScroll)
leftLayout.Padding = UDim.new(0, 8 * guiScale)
leftLayout.FillDirection = Enum.FillDirection.Vertical
leftLayout.SortOrder = Enum.SortOrder.LayoutOrder
leftLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local rightLayout = Instance.new("UIListLayout", rightScroll)
rightLayout.Padding = UDim.new(0, 8 * guiScale)
rightLayout.FillDirection = Enum.FillDirection.Vertical
rightLayout.SortOrder = Enum.SortOrder.LayoutOrder
rightLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local rowOrder = 0

local ROW_H = isMobile and 50 or 44
local SLIDER_H = isMobile and 62 or 56

-- Enhanced row frame with shadow and hover effect
local function makeRowFrame(parent, height)
    height = height or ROW_H
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, -10 * guiScale, 0, height * guiScale)
    frame.BackgroundColor3 = Color3.fromRGB(30, 33, 24)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.LayoutOrder = rowOrder
    rowOrder = rowOrder + 1
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8 * guiScale)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Thickness = 1.5 * guiScale
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Transparency = 0.2
    addAccent(stroke, "Color")

    -- subtle shadow
    local shad = Instance.new("ImageLabel")
    shad.Name = "RowShadow"
    shad.Parent = frame
    shad.BackgroundTransparency = 1
    shad.Size = UDim2.new(1, 10, 1, 10)
    shad.Position = UDim2.new(0, -5, 0, -5)
    shad.Image = "rbxassetid://6015897843"
    shad.ImageColor3 = Color3.new(0, 0, 0)
    shad.ImageTransparency = 0.8
    shad.ScaleType = Enum.ScaleType.Slice
    shad.SliceCenter = Rect.new(10, 10, 10, 10)
    shad.ZIndex = -1

    return frame, stroke
end

-- Enhanced toggle with smooth animation
local function makeToggle(parent, labelText, keybind)
    local frame, stroke = makeRowFrame(parent, ROW_H)

    local displayText = labelText
    if not isMobile and keybind then
        displayText = labelText .. "  [" .. keybind .. "]"
    end

    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(0.58, 0, 1, 0)
    lbl.Position = UDim2.new(0, 12 * guiScale, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = displayText
    lbl.TextColor3 = Color3.fromRGB(240, 240, 230)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12 * guiScale
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 4

    local bindBtn = nil
    if keybind and not isMobile then
        bindBtn = Instance.new("TextButton", frame)
        bindBtn.Size = UDim2.new(0, 38 * guiScale, 0, 20 * guiScale)
        bindBtn.Position = UDim2.new(1, -(38 + 56) * guiScale, 0.5, -10 * guiScale)
        bindBtn.BackgroundColor3 = Color3.fromRGB(50, 55, 40)
        bindBtn.TextColor3 = Color3.fromRGB(180, 230, 120)
        bindBtn.Font = Enum.Font.GothamBlack
        bindBtn.TextSize = 9 * guiScale
        bindBtn.Text = "BIND"
        bindBtn.BorderSizePixel = 0
        bindBtn.ZIndex = 6
        Instance.new("UICorner", bindBtn).CornerRadius = UDim.new(0, 5 * guiScale)
        local bStroke = Instance.new("UIStroke", bindBtn)
        bStroke.Thickness = 1.5 * guiScale
        bStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        addAccent(bStroke, "Color")

        bindBtn.MouseEnter:Connect(function()
            TweenService:Create(bindBtn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(70, 80, 60)}):Play()
        end)
        bindBtn.MouseLeave:Connect(function()
            TweenService:Create(bindBtn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 55, 40)}):Play()
        end)
    end

    local pillW = isMobile and 52 * guiScale or 48 * guiScale
    local pillH = isMobile and 28 * guiScale or 24 * guiScale
    local circleD = isMobile and 22 * guiScale or 20 * guiScale

    local pill = Instance.new("Frame", frame)
    pill.Size = UDim2.new(0, pillW, 0, pillH)
    pill.Position = UDim2.new(1, -(pillW + 6 * guiScale), 0.5, -pillH / 2)
    pill.BackgroundColor3 = Color3.fromRGB(50, 55, 40)
    pill.BorderSizePixel = 0
    pill.ZIndex = 4
    Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)

    local circle = Instance.new("Frame", pill)
    circle.Size = UDim2.new(0, circleD, 0, circleD)
    circle.Position = UDim2.new(0, 2 * guiScale, 0.5, -circleD / 2)
    circle.BackgroundColor3 = Color3.new(1,1,1)
    circle.BorderSizePixel = 0
    circle.ZIndex = 5
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

    local hitbox = Instance.new("TextButton", frame)
    hitbox.Size = UDim2.new(1, 0, 1, 0)
    hitbox.BackgroundTransparency = 1
    hitbox.Text = ""
    hitbox.ZIndex = 6

    -- Hover effect on pill
    hitbox.MouseEnter:Connect(function()
        TweenService:Create(pill, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(70, 75, 60)}):Play()
    end)
    hitbox.MouseLeave:Connect(function()
        local targetColor = isOn and Color3.fromRGB(180, 230, 120) or Color3.fromRGB(50, 55, 40)
        TweenService:Create(pill, TweenInfo.new(0.1), {BackgroundColor3 = targetColor}):Play()
    end)

    local isOn = false

    local function updateVisual()
        if isOn then
            TweenService:Create(pill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(180, 230, 120)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -(circleD + 2 * guiScale), 0.5, -circleD/2), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            TweenService:Create(pill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(50, 55, 40)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 2*guiScale, 0.5, -circleD/2), BackgroundColor3 = Color3.new(1,1,1)}):Play()
        end
    end

    return hitbox, function(state) isOn = state updateVisual() end, function() return isOn end, lbl, bindBtn
end

-- Enhanced slider with smooth thumb
local function makeSlider(parent, labelText, minVal, maxVal, valueKey, onChange)
    local frame, stroke = makeRowFrame(parent, SLIDER_H)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.65, 0, 0, 20 * guiScale)
    label.Position = UDim2.new(0, 12 * guiScale, 0, 4 * guiScale)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(240, 240, 230)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12 * guiScale
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 4

    local valLabel = Instance.new("TextLabel", frame)
    valLabel.Size = UDim2.new(0, 44 * guiScale, 0, 20 * guiScale)
    valLabel.Position = UDim2.new(1, -50 * guiScale, 0, 4 * guiScale)
    valLabel.BackgroundTransparency = 1
    valLabel.Text = tostring(Values[valueKey] or minVal)
    valLabel.Font = Enum.Font.GothamBlack
    valLabel.TextSize = 12 * guiScale
    valLabel.TextXAlignment = Enum.TextXAlignment.Right
    valLabel.ZIndex = 4
    addAccent(valLabel, "TextColor3")

    local trackH = isMobile and 10 * guiScale or 8 * guiScale
    local thumbD = isMobile and 18 * guiScale or 14 * guiScale
    local trackY = isMobile and 36 * guiScale or 33 * guiScale

    local track = Instance.new("Frame", frame)
    track.Size = UDim2.new(1, -20 * guiScale, 0, trackH)
    track.Position = UDim2.new(0, 10 * guiScale, 0, trackY)
    track.BackgroundColor3 = Color3.fromRGB(50, 55, 40)
    track.BorderSizePixel = 0
    track.ZIndex = 4
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame", track)
    local initPct = ((Values[valueKey] or minVal) - minVal) / math.max(maxVal - minVal, 1)
    fill.Size = UDim2.new(initPct, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(180, 230, 120)
    fill.BorderSizePixel = 0
    fill.ZIndex = 5
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
    addAccent(fill, "BackgroundColor3")

    local thumb = Instance.new("Frame", track)
    thumb.Size = UDim2.new(0, thumbD, 0, thumbD)
    thumb.Position = UDim2.new(initPct, -thumbD/2, 0.5, -thumbD/2)
    thumb.BackgroundColor3 = Color3.new(1,1,1)
    thumb.BorderSizePixel = 0
    thumb.ZIndex = 6
    Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)

    -- Glow effect on thumb
    local thumbGlow = Instance.new("ImageLabel")
    thumbGlow.Name = "ThumbGlow"
    thumbGlow.Parent = thumb
    thumbGlow.BackgroundTransparency = 1
    thumbGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
    thumbGlow.Position = UDim2.new(-0.25, 0, -0.25, 0)
    thumbGlow.Image = "rbxassetid://6015897843"
    thumbGlow.ImageColor3 = Color3.fromRGB(180, 230, 120)
    thumbGlow.ImageTransparency = 0.5
    thumbGlow.ScaleType = Enum.ScaleType.Slice
    thumbGlow.SliceCenter = Rect.new(10, 10, 10, 10)
    thumbGlow.ZIndex = 5

    local dragging = false
    local function update(relX)
        relX = math.clamp(relX, 0, 1)
        local val = math.floor(minVal + (maxVal - minVal) * relX)
        if Values[valueKey] ~= nil then Values[valueKey] = val end
        valLabel.Text = tostring(val)
        fill.Size = UDim2.new(relX, 0, 1, 0)
        thumb.Position = UDim2.new(relX, -thumbD/2, 0.5, -thumbD/2)
        if onChange then onChange(val) end
    end

    local activeInput = nil

    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 
        or input.UserInputType == Enum.UserInputType.Touch then
            
            dragging = true
            activeInput = input
            
            local rel = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
            update(rel)

            -- Scale thumb on drag start
            TweenService:Create(thumb, TweenInfo.new(0.1), {Size = UDim2.new(0, thumbD*1.2, 0, thumbD*1.2)}):Play()
        end
    end)

    track.InputEnded:Connect(function(input)
        if input == activeInput then
            dragging = false
            activeInput = nil
            TweenService:Create(thumb, TweenInfo.new(0.1), {Size = UDim2.new(0, thumbD, 0, thumbD)}):Play()
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == activeInput then
            local rel = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
            update(rel)
        end
    end)

    -- Click value to type number
    valLabel.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 
        and input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        local textBox = Instance.new("TextBox")
        textBox.Size = valLabel.Size
        textBox.Position = valLabel.Position
        textBox.BackgroundTransparency = 1
        textBox.Text = valLabel.Text
        textBox.Font = valLabel.Font
        textBox.TextSize = valLabel.TextSize
        textBox.TextColor3 = valLabel.TextColor3
        textBox.ClearTextOnFocus = false
        textBox.Parent = frame
        textBox:CaptureFocus()

        textBox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                local num = tonumber(textBox.Text)
                if num then
                    num = math.clamp(num, minVal, maxVal)
                    local rel = (num - minVal) / math.max(maxVal - minVal, 1)
                    update(rel)
                end
            end
            textBox:Destroy()
        end)
    end)

    return frame
end

-- ==================== FEATURE BLOCKS (ORIGINAL LOGIC) ====================
-- All original code from here onward is preserved exactly, only using the new makeToggle/makeSlider functions.

do
    local curKeybind = Enum.KeyCode.E
    local listening = false
    local btn, setV, getV, lbl, bindBtn = makeToggle(leftScroll, "Speed Boost", "E")

    local Connections = {}

    local function startSpeedBoost()
        if Connections.speed then return end
        Connections.speed = RunService.Heartbeat:Connect(function()
            if not Features.SpeedBoost then return end
            pcall(function()
                local c = Player.Character
                if not c then return end
                local h = c:FindFirstChild("HumanoidRootPart")
                local hum = c:FindFirstChildOfClass("Humanoid")
                if not h or not hum then return end
                local md = hum.MoveDirection
                if md.Magnitude > 0.1 then
                    h.AssemblyLinearVelocity = Vector3.new(md.X * Values.BoostSpeed, h.AssemblyLinearVelocity.Y, md.Z * Values.BoostSpeed)
                end
            end)
        end)
    end

    local function stopSpeedBoost()
        if Connections.speed then Connections.speed:Disconnect() Connections.speed = nil end
    end

    local function toggle()
        if listening then return end
        local on = not getV()
        setV(on)
        Features.SpeedBoost = on
        if on then startSpeedBoost() else stopSpeedBoost() end
    end

    btn.MouseButton1Click:Connect(toggle)

    if not isMobile then
        UserInputService.InputBegan:Connect(function(inp, gpe)
            if gpe or listening then return end
            if inp.KeyCode == curKeybind then toggle() end
        end)
    end

    if bindBtn then
        bindBtn.MouseButton1Click:Connect(function()
            if listening then return end
            listening = true
            bindBtn.Text = "..."
            bindBtn.TextColor3 = Color3.new(1,1,1)
            local conn
            conn = UserInputService.InputBegan:Connect(function(inp)
                if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
                conn:Disconnect()
                curKeybind = inp.KeyCode
                listening = false
                bindBtn.Text = "BIND"
                bindBtn.TextColor3 = Color3.fromRGB(180, 230, 120)
                lbl.Text = "Speed Boost  [" .. curKeybind.Name .. "]"
            end)
        end)
    end
end

makeSlider(leftScroll, "Speed Value", 1, 70, "BoostSpeed")

do
    local antiRagdollMode = nil
    local ragdollConnections = {}
    local cachedCharData = {}
    local isBoosting = false
    local BOOST_SPEED = 400
    local AR_DEFAULT_SPEED = 16

    local function arCacheCharacterData()
        local char = Player.Character
        if not char then return false end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if not hum or not root then return false end
        cachedCharData = { character = char, humanoid = hum, root = root }
        return true
    end

    local function arDisconnectAll()
        for _, conn in ipairs(ragdollConnections) do pcall(function() conn:Disconnect() end) end
        ragdollConnections = {}
    end

    local function arIsRagdolled()
        if not cachedCharData.humanoid then return false end
        local state = cachedCharData.humanoid:GetState()
        local ragdollStates = {[Enum.HumanoidStateType.Physics]=true,[Enum.HumanoidStateType.Ragdoll]=true,[Enum.HumanoidStateType.FallingDown]=true}
        if ragdollStates[state] then return true end
        local endTime = Player:GetAttribute("RagdollEndTime")
        if endTime and (endTime - workspace:GetServerTimeNow()) > 0 then return true end
        return false
    end

    local function arForceExitRagdoll()
        if not cachedCharData.humanoid or not cachedCharData.root then return end
        pcall(function() Player:SetAttribute("RagdollEndTime", workspace:GetServerTimeNow()) end)
        for _, d in ipairs(cachedCharData.character:GetDescendants()) do
            if d:IsA("BallSocketConstraint") or (d:IsA("Attachment") and d.Name:find("RagdollAttachment")) then d:Destroy() end
        end
        if not isBoosting then isBoosting = true cachedCharData.humanoid.WalkSpeed = BOOST_SPEED end
        if cachedCharData.humanoid.Health > 0 then cachedCharData.humanoid:ChangeState(Enum.HumanoidStateType.Running) end
        cachedCharData.root.Anchored = false
    end

    local function startAntiRagdoll()
        if antiRagdollMode == "v1" then return end
        if not arCacheCharacterData() then return end
        antiRagdollMode = "v1"
        local camConn = RunService.RenderStepped:Connect(function()
            local cam = workspace.CurrentCamera
            if cam and cachedCharData.humanoid then cam.CameraSubject = cachedCharData.humanoid end
        end)
        table.insert(ragdollConnections, camConn)
        local respawnConn = Player.CharacterAdded:Connect(function() isBoosting = false task.wait(0.5) arCacheCharacterData() end)
        table.insert(ragdollConnections, respawnConn)
        task.spawn(function()
            while antiRagdollMode == "v1" do
                task.wait()
                if arIsRagdolled() then arForceExitRagdoll()
                elseif isBoosting then isBoosting = false if cachedCharData.humanoid then cachedCharData.humanoid.WalkSpeed = AR_DEFAULT_SPEED end end
            end
        end)
    end

    local function stopAntiRagdoll()
        antiRagdollMode = nil
        if isBoosting and cachedCharData.humanoid then cachedCharData.humanoid.WalkSpeed = AR_DEFAULT_SPEED end
        isBoosting = false arDisconnectAll() cachedCharData = {}
    end

    local btn, setV, getV = makeToggle(leftScroll, "Anti Ragdoll")
    btn.MouseButton1Click:Connect(function()
        local on = not getV() 
setV(on) 
Features.AntiRagdoll = on
        if on then startAntiRagdoll() else stopAntiRagdoll() end
    end)
end

do
    local Cebo = {Conn=nil,Circle=nil,Align=nil,Attach=nil}
    local function startMeleeAimbot()
        local char = Player.Character or Player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        Cebo.Attach = Instance.new("Attachment", hrp)
        Cebo.Align = Instance.new("AlignOrientation", hrp)
        Cebo.Align.Attachment0 = Cebo.Attach
        Cebo.Align.Mode = Enum.OrientationAlignmentMode.OneAttachment
        Cebo.Align.RigidityEnabled = true
        Cebo.Circle = Instance.new("Part")
        Cebo.Circle.Shape = Enum.PartType.Cylinder
        Cebo.Circle.Material = Enum.Material.Neon
        Cebo.Circle.Size = Vector3.new(0.05, 14.5, 14.5)
        Cebo.Circle.Color = Color3.fromRGB(180, 230, 120)
        Cebo.Circle.CanCollide = false
        Cebo.Circle.Massless = true
        Cebo.Circle.Parent = workspace
        local weld = Instance.new("Weld")
        weld.Part0 = hrp weld.Part1 = Cebo.Circle
        weld.C0 = CFrame.new(0,-1,0)*CFrame.Angles(0,0,math.rad(90))
        weld.Parent = Cebo.Circle
        Cebo.Conn = RunService.RenderStepped:Connect(function()
            local target, dmin = nil, 7.25
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local d = (p.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                    if d <= dmin then target, dmin = p.Character.HumanoidRootPart, d end
                end
            end
            if target then
                char.Humanoid.AutoRotate = false
                Cebo.Align.Enabled = true
                Cebo.Align.CFrame = CFrame.lookAt(hrp.Position, Vector3.new(target.Position.X, hrp.Position.Y, target.Position.Z))
                local t = char:FindFirstChild("Bat") or char:FindFirstChild("Medusa")
                if t then t:Activate() end
            else Cebo.Align.Enabled = false char.Humanoid.AutoRotate = true end
        end)
    end
    local function stopMeleeAimbot()
        if Cebo.Conn   then Cebo.Conn:Disconnect()   Cebo.Conn   = nil end
        if Cebo.Circle then Cebo.Circle:Destroy()     Cebo.Circle = nil end
        if Cebo.Align  then Cebo.Align:Destroy()      Cebo.Align  = nil end
        if Cebo.Attach then Cebo.Attach:Destroy()     Cebo.Attach = nil end
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then Player.Character.Humanoid.AutoRotate = true end
    end
    local btn, setV, getV = makeToggle(leftScroll, "Hit Circle")
    btn.MouseButton1Click:Connect(function()
        local on = not getV() setV(on)
        if on then startMeleeAimbot() else stopMeleeAimbot() end
    end)
end

do
    local helicopterSpinBAV = nil
    local function applyHelicopterSpeed()
        if helicopterSpinBAV then helicopterSpinBAV.AngularVelocity = Vector3.new(0, Values.SpinSpeed, 0) end
    end
    local function startHelicopter()
        local c = Player.Character if not c then return end
        local hrp = c:FindFirstChild("HumanoidRootPart") if not hrp then return end
        if helicopterSpinBAV then helicopterSpinBAV:Destroy() helicopterSpinBAV = nil end
        helicopterSpinBAV = Instance.new("BodyAngularVelocity")
        helicopterSpinBAV.Name = "HelicopterBAV"
        helicopterSpinBAV.MaxTorque = Vector3.new(0, math.huge, 0)
        helicopterSpinBAV.AngularVelocity = Vector3.new(0, Values.SpinSpeed, 0)
        helicopterSpinBAV.Parent = hrp
    end
    local function stopHelicopter()
        if helicopterSpinBAV then helicopterSpinBAV:Destroy() helicopterSpinBAV = nil end
    end
    local btn, setV, getV = makeToggle(leftScroll, "Helicopter")
    btn.MouseButton1Click:Connect(function()
        local on = not getV() setV(on) Features.Helicopter = on
        if on then startHelicopter() else stopHelicopter() end
    end)
    makeSlider(leftScroll, "Helicopter Speed", 5, 50, "SpinSpeed", function(v)
        Values.SpinSpeed = v applyHelicopterSpeed()
    end)
end

do
    local galaxyEnabled = false
    local hopsEnabled = false
    local lastHopTime = 0
    local spaceHeld = false
    local originalJumpPower = 50
    local galaxyVectorForce = nil
    local galaxyAttachment = nil

    local function captureJumpPower()
        local c = Player.Character if not c then return end
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum and hum.JumpPower > 0 then originalJumpPower = hum.JumpPower end
    end
    task.spawn(function() task.wait(1) captureJumpPower() end)
    Player.CharacterAdded:Connect(function() task.wait(1) captureJumpPower() end)

    local function setupGalaxyForce()
        pcall(function()
            local c = Player.Character if not c then return end
            local h = c:FindFirstChild("HumanoidRootPart") if not h then return end
            if galaxyVectorForce then galaxyVectorForce:Destroy() end
            if galaxyAttachment  then galaxyAttachment:Destroy()  end
            galaxyAttachment = Instance.new("Attachment") galaxyAttachment.Parent = h
            galaxyVectorForce = Instance.new("VectorForce")
            galaxyVectorForce.Attachment0 = galaxyAttachment
            galaxyVectorForce.ApplyAtCenterOfMass = true
            galaxyVectorForce.RelativeTo = Enum.ActuatorRelativeTo.World
            galaxyVectorForce.Force = Vector3.new(0,0,0)
            galaxyVectorForce.Parent = h
        end)
    end

    local function updateGalaxyForce()
        if not galaxyEnabled or not galaxyVectorForce then return end
        local c = Player.Character if not c then return end
        local mass = 0
        for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then mass = mass + p:GetMass() end end
        local tg = Values.DEFAULT_GRAVITY * (Values.GalaxyGravityPercent / 100)
        galaxyVectorForce.Force = Vector3.new(0, mass * (Values.DEFAULT_GRAVITY - tg) * 0.95, 0)
    end

    local function adjustGalaxyJump()
        pcall(function()
            local c = Player.Character if not c then return end
            local hum = c:FindFirstChildOfClass("Humanoid") if not hum then return end
            if not galaxyEnabled then hum.JumpPower = originalJumpPower return end
            local ratio = math.sqrt((Values.DEFAULT_GRAVITY * (Values.GalaxyGravityPercent / 100)) / Values.DEFAULT_GRAVITY)
            hum.JumpPower = originalJumpPower * ratio
        end)
    end

    RunService.Heartbeat:Connect(function()
        if hopsEnabled and spaceHeld then
            pcall(function()
                local c = Player.Character if not c then return end
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
        if galaxyEnabled then updateGalaxyForce() end
    end)

    if not isMobile then
        UserInputService.InputBegan:Connect(function(inp, gpe) if gpe then return end if inp.KeyCode == Enum.KeyCode.Space then spaceHeld = true end end)
        UserInputService.InputEnded:Connect(function(inp) if inp.KeyCode == Enum.KeyCode.Space then spaceHeld = false end end)
    end
    Player.CharacterAdded:Connect(function() task.wait(1) if galaxyEnabled then setupGalaxyForce() adjustGalaxyJump() end end)

    local btn, setV, getV = makeToggle(leftScroll, "Galaxy Mode")
    btn.MouseButton1Click:Connect(function()
        local on = not getV() setV(on) galaxyEnabled = on hopsEnabled = on
        if on then setupGalaxyForce() adjustGalaxyJump()
        else
            if galaxyVectorForce then galaxyVectorForce:Destroy() galaxyVectorForce = nil end
            if galaxyAttachment  then galaxyAttachment:Destroy()  galaxyAttachment  = nil end
            adjustGalaxyJump()
        end
    end)
end

do
    local autoGrabConn = nil
    
    local grabStatus = Instance.new("TextLabel", sg)
    grabStatus.Name = "GrabStatus"
    grabStatus.Size = UDim2.new(0, 220, 0, 34)
    grabStatus.Position = UDim2.new(0.5, -110, 0.92, 0)
    grabStatus.BackgroundColor3 = Color3.fromRGB(25, 30, 20)
    grabStatus.Text = ""
    grabStatus.TextColor3 = Color3.fromRGB(180, 230, 120)
    grabStatus.Font = Enum.Font.GothamBold
    grabStatus.TextSize = 14 * guiScale
    grabStatus.BorderSizePixel = 0
    grabStatus.Visible = false
    grabStatus.ZIndex = 100
    Instance.new("UICorner", grabStatus).CornerRadius = UDim.new(0, 10)
    local grabStroke = Instance.new("UIStroke", grabStatus)
    grabStroke.Color = Color3.fromRGB(180, 230, 120)
    grabStroke.Thickness = 2
    grabStroke.Transparency = 0.3

    local function getPos(prompt)
        local p = prompt.Parent
        if p:IsA("BasePart") then return p.Position end
        if p:IsA("Model") then
            local prim = p.PrimaryPart or p:FindFirstChildWhichIsA("BasePart")
            return prim and prim.Position
        end
        if p:IsA("Attachment") then return p.WorldPosition end
        local part = p:FindFirstChildWhichIsA("BasePart", true)
        return part and part.Position
    end

    local function findNearestStealPrompt()
        local c = Player.Character
        if not c then return nil end
        local rootPart = c:FindFirstChild("HumanoidRootPart")
        if not rootPart then return nil end
        local myPos = rootPart.Position
        local nearest = nil
        local nearestDist = math.huge
        local plots = workspace:FindFirstChild("Plots")
        if not plots then return nil end
        for _, plot in ipairs(plots:GetChildren()) do
            for _, obj in ipairs(plot:GetDescendants()) do
                if obj:IsA("ProximityPrompt") and obj.Enabled and obj.ActionText == "Steal" then
                    local pos = getPos(obj)
                    if pos then
                        local dist = (myPos - pos).Magnitude
                        if dist <= obj.MaxActivationDistance and dist < nearestDist then
                            nearest = obj
                            nearestDist = dist
                        end
                    end
                end
            end
        end
        return nearest
    end

    local function firePrompt(prompt)
        if not prompt then return end
        task.spawn(function()
            pcall(function()
                fireproximityprompt(prompt, 10000)
                prompt:InputHoldBegin()
                task.wait(0.05)
                prompt:InputHoldEnd()
            end)
        end)
    end

    local function autoGrabLoop()
        while Features.AutoSteal do
            local c = Player.Character
            if c then
                local hum = c:FindFirstChildOfClass("Humanoid")
                if hum and hum.WalkSpeed > 29 then
                    local nearest = findNearestStealPrompt()
                    if nearest then
                        grabStatus.Text = "grabbing nearest..."
                        grabStatus.Visible = true
                        firePrompt(nearest)
                        task.wait(0.15)
                        grabStatus.Visible = false
                    end
                end
            end
            task.wait(0.3)
        end
    end

    local btn, setV, getV = makeToggle(leftScroll, "Auto Steal")
    btn.MouseButton1Click:Connect(function()
        local on = not getV()
        setV(on)
        Features.AutoSteal = on
        if on then
            task.spawn(autoGrabLoop)
        else
            grabStatus.Visible = false
        end
    end)
end

do
    local lastBatSwing = 0
    local BAT_SWING_COOLDOWN = 0.12
    local SlapList = {"Bat","Slap","Iron Slap","Gold Slap","Diamond Slap","Emerald Slap","Ruby Slap","Dark Matter Slap","Flame Slap","Nuclear Slap","Galaxy Slap","Glitched Slap"}
    local function findBat()
        local c = Player.Character if not c then return nil end
        local bp = Player:FindFirstChildOfClass("Backpack")
        for _, ch in ipairs(c:GetChildren()) do if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end end
        if bp then for _, ch in ipairs(bp:GetChildren()) do if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end end end
        for _, name in ipairs(SlapList) do local t = c:FindFirstChild(name) or (bp and bp:FindFirstChild(name)) if t then return t end end
        return nil
    end
    local spamBatConn = nil
    local function startSpamBat()
        if spamBatConn then return end
        spamBatConn = RunService.Heartbeat:Connect(function()
            if not Features.SpamBat then return end
            local c = Player.Character if not c then return end
            local bat = findBat() if not bat then return end
            if bat.Parent ~= c then bat.Parent = c end
            local now = tick() if now - lastBatSwing < BAT_SWING_COOLDOWN then return end
            lastBatSwing = now pcall(function() bat:Activate() end)
        end)
    end
    local function stopSpamBat()
        if spamBatConn then spamBatConn:Disconnect() spamBatConn = nil end
    end
    local btn, setV, getV = makeToggle(rightScroll, "Bat Spam")
    btn.MouseButton1Click:Connect(function()
        local on = not getV() setV(on) Features.SpamBat = on
        if on then startSpamBat() else stopSpamBat() end
    end)
end

do
    local SlapList = {"Bat","Slap","Iron Slap","Gold Slap","Diamond Slap","Emerald Slap","Ruby Slap","Dark Matter Slap","Flame Slap","Nuclear Slap","Galaxy Slap","Glitched Slap"}

    local function findBatForAimbot()
        local c = Player.Character if not c then return nil end
        local bp = Player:FindFirstChildOfClass("Backpack")
        for _, ch in ipairs(c:GetChildren()) do if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end end
        if bp then for _, ch in ipairs(bp:GetChildren()) do if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end end end
        for _, name in ipairs(SlapList) do local t = c:FindFirstChild(name) or (bp and bp:FindFirstChild(name)) if t then return t end end
        return nil
    end

    local function findNearestEnemy(myHRP)
        local nearest, nearestDist, nearestTorso = nil, math.huge, nil
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

    local batAimbotConn = nil

    local function startBatAimbot()
        if batAimbotConn then return end
        batAimbotConn = RunService.Heartbeat:Connect(function()
            if not Features.BatAimbot then return end
            local c = Player.Character if not c then return end
            local h = c:FindFirstChild("HumanoidRootPart")
            local hum = c:FindFirstChildOfClass("Humanoid")
            if not h or not hum then return end

            local bat = findBatForAimbot()
            if bat and bat.Parent ~= c then
                hum:EquipTool(bat)
            end

            local target, dist, torso = findNearestEnemy(h)
            if target and torso then
                local dir = torso.Position - h.Position
                local flatDir = Vector3.new(dir.X, 0, dir.Z)
                local flatDist = flatDir.Magnitude
                local spd = Values.BatAimbotSpeed

                if flatDist > 1.5 then
                    local moveDir = flatDir.Unit
                    h.AssemblyLinearVelocity = Vector3.new(
                        moveDir.X * spd,
                        h.AssemblyLinearVelocity.Y,
                        moveDir.Z * spd
                    )
                else
                    local tv = target.AssemblyLinearVelocity
                    h.AssemblyLinearVelocity = Vector3.new(tv.X, h.AssemblyLinearVelocity.Y, tv.Z)
                end
            end
        end)
    end

    local function stopBatAimbot()
        if batAimbotConn then batAimbotConn:Disconnect() batAimbotConn = nil end
    end

    local btn, setV, getV = makeToggle(rightScroll, "Bat Aimbot")
    btn.MouseButton1Click:Connect(function()
        local on = not getV() setV(on) Features.BatAimbot = on
        if on then startBatAimbot() else stopBatAimbot() end
    end)
    makeSlider(rightScroll, "Aimbot Speed", 20, 100, "BatAimbotSpeed", function(v) Values.BatAimbotSpeed = v end)
end

makeSlider(rightScroll, "Gravity %", 25, 130, "GalaxyGravityPercent")

do
    local sConn = nil
    local function startSpeedWhileStealing()
        if sConn then return end
        sConn = RunService.Heartbeat:Connect(function()
            if not Features.SpeedWhileStealing or not Player:GetAttribute("Stealing") then return end
            local c = Player.Character if not c then return end
            local h = c:FindFirstChild("HumanoidRootPart") if not h then return end
            local hum = c:FindFirstChildOfClass("Humanoid")
            local md = hum and hum.MoveDirection or Vector3.zero
            if md.Magnitude > 0.1 then
                h.AssemblyLinearVelocity = Vector3.new(md.X*Values.StealingSpeedValue, h.AssemblyLinearVelocity.Y, md.Z*Values.StealingSpeedValue)
            end
        end)
    end
    local function stopSpeedWhileStealing()
        if sConn then sConn:Disconnect() sConn = nil end
    end
    local btn, setV, getV = makeToggle(rightScroll, "Thief Speed")
    btn.MouseButton1Click:Connect(function()
        local on = not getV() setV(on) Features.SpeedWhileStealing = on
        if on then startSpeedWhileStealing() else stopSpeedWhileStealing() end
    end)
    makeSlider(rightScroll, "Steal Speed", 10, 50, "StealingSpeedValue")
end

do
    local savedAnimations = {}
    local function startUnwalk()
        local c = Player.Character if not c then return end
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum then for _, t in ipairs(hum:GetPlayingAnimationTracks()) do t:Stop() end end
        local anim = c:FindFirstChild("Animate")
        if anim then savedAnimations.Animate = anim:Clone() anim:Destroy() end
    end
    local function stopUnwalk()
        local c = Player.Character
        if c and savedAnimations.Animate then savedAnimations.Animate:Clone().Parent = c savedAnimations.Animate = nil end
    end
    local btn, setV, getV = makeToggle(rightScroll, "Unwalk")
    btn.MouseButton1Click:Connect(function()
        local on = not getV() setV(on) Features.Unwalk = on
        if on then startUnwalk() else stopUnwalk() end
    end)
end

do
    local function enableOptimizer()
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            game:GetService("Lighting").GlobalShadows = false
            game:GetService("Lighting").Brightness = 3
        end)
        pcall(function()
            for _, obj in ipairs(workspace:GetDescendants()) do
                pcall(function()
                    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then obj:Destroy()
                    elseif obj:IsA("BasePart") then obj.CastShadow = false obj.Material = Enum.Material.Plastic end
                end)
            end
        end)
    end
    local btn, setV, getV = makeToggle(rightScroll, "Optimizer")
    btn.MouseButton1Click:Connect(function()
        local on = not getV() setV(on) Features.Optimizer = on
        if on then enableOptimizer() end
    end)
end

do
    local originalTransparency = {}
    local function enableXRay()
        pcall(function()
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Anchored and (obj.Name:lower():find("base") or (obj.Parent and obj.Parent.Name:lower():find("base"))) then
                    originalTransparency[obj] = obj.LocalTransparencyModifier
                    obj.LocalTransparencyModifier = 0.85
                end
            end
        end)
    end
    local function disableXRay()
        for part, value in pairs(originalTransparency) do if part then part.LocalTransparencyModifier = value end end
        originalTransparency = {}
    end
    local btn, setV, getV = makeToggle(rightScroll, "XRay")
    btn.MouseButton1Click:Connect(function()
        local on = not getV() setV(on) Features.XRay = on
        if on then enableXRay() else disableXRay() end
    end)
end

do
    local floatConn = nil
    local floatKeybind = Enum.KeyCode.F
    local floatListening = false
    local FLOAT_TARGET_HEIGHT = 10

    local function startFloat()
        local c = Player.Character if not c then return end
        local hrp = c:FindFirstChild("HumanoidRootPart") if not hrp then return end
        local hum = c:FindFirstChildOfClass("Humanoid")
        local floatOriginY = hrp.Position.Y + FLOAT_TARGET_HEIGHT
        local floatStartTime = tick()
        local floatDescending = false
        if floatConn then floatConn:Disconnect() floatConn = nil end
        floatConn = RunService.Heartbeat:Connect(function()
            if not Features.Float then return end
            local c2 = Player.Character if not c2 then return end
            local h = c2:FindFirstChild("HumanoidRootPart") if not h then return end
            local hum2 = c2:FindFirstChildOfClass("Humanoid")
            local isStealing = Player:GetAttribute("Stealing")
            local moveSpeed = isStealing and Values.StealingSpeedValue or Values.BoostSpeed
            local moveDir = hum2 and hum2.MoveDirection or Vector3.zero
            if tick() - floatStartTime >= 4 then floatDescending = true end
            local currentY = h.Position.Y
            local vertVel
            if floatDescending then
                vertVel = -20
                if currentY <= floatOriginY - FLOAT_TARGET_HEIGHT + 0.5 then
                    h.AssemblyLinearVelocity = Vector3.zero Features.Float = false
                    if floatConn then floatConn:Disconnect() floatConn = nil end
                    return
                end
            else
                local diff = floatOriginY - currentY
                if diff > 0.3 then vertVel = math.clamp(diff*8,5,50)
                elseif diff < -0.3 then vertVel = math.clamp(diff*8,-50,-5)
                else vertVel = 0 end
            end
            local horizX = moveDir.Magnitude > 0.1 and moveDir.X * moveSpeed or 0
            local horizZ = moveDir.Magnitude > 0.1 and moveDir.Z * moveSpeed or 0
            h.AssemblyLinearVelocity = Vector3.new(horizX, vertVel, horizZ)
        end)
    end

    local function stopFloat()
        if floatConn then floatConn:Disconnect() floatConn = nil end
        local c = Player.Character
        if c then
            local hrp = c:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.AssemblyLinearVelocity = Vector3.zero end
        end
    end

    local btn, setV, getV, lbl, bindBtn = makeToggle(rightScroll, "Float", "F")

    local function toggleFloat()
        if floatListening then return end
        local on = not getV() setV(on) Features.Float = on
        if on then startFloat() else stopFloat() end
    end

    btn.MouseButton1Click:Connect(toggleFloat)

    if not isMobile then
        UserInputService.InputBegan:Connect(function(inp, gpe)
            if gpe or floatListening then return end
            if inp.KeyCode == floatKeybind then toggleFloat() end
        end)
    end

    if bindBtn then
        bindBtn.MouseButton1Click:Connect(function()
            if floatListening then return end
            floatListening = true
 bindBtn.Text = "..." 
bindBtn.TextColor3 = Color3.new(1,1,1)
            local conn 
conn = UserInputService.InputBegan:Connect(function(inp)
                if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
                conn:Disconnect()
 floatKeybind = inp.KeyCode
 floatListening = false
                bindBtn.Text = "BIND" 
bindBtn.TextColor3 = Color3.fromRGB(180, 230, 120)
                lbl.Text = "Float  [" .. floatKeybind.Name .. "]"
            end)
        end)
    end
end

-- RAGDOLL TP FEATURE
do
    local currentHumanoid = nil
    local wasStanding = true
    local ragdollActive = false

    local function getCharacter()
        return Player.Character or Player.CharacterAdded:Wait()
    end

    local function doubleTeleport(posTable)
        local character = getCharacter()
        character:PivotTo(CFrame.new(posTable[1]))
        task.wait(0.1)
        character:PivotTo(CFrame.new(posTable[2]))
    end

    local function getAnimalTarget()
        local plots = workspace:FindFirstChild("Plots")
        if not plots then return nil end

        for _, plot in ipairs(plots:GetChildren()) do
            local sign = plot:FindFirstChild("PlotSign")
            local base = plot:FindFirstChild("DeliveryHitbox")
            if sign and sign:FindFirstChild("YourBase") and sign.YourBase.Enabled and base then
                local target = plot:FindFirstChild("AnimalTarget", true)
                if target then
                    return target.Position
                end
            end
        end
        return nil
    end

    local function performTeleport()
        local target = getAnimalTarget()
        if not target then return end

        local leftDist = (target - RAGDOLL_COORDS.left[1]).Magnitude
        local rightDist = (target - RAGDOLL_COORDS.right[1]).Magnitude

        if leftDist > rightDist then
            doubleTeleport(RAGDOLL_COORDS.left)
        else
            doubleTeleport(RAGDOLL_COORDS.right)
        end
    end

    local function onCharacterAdded(character)
        currentHumanoid = character:WaitForChild("Humanoid")
        wasStanding = true
        ragdollActive = false
    end

    if Player.Character then
        onCharacterAdded(Player.Character)
    end
    Player.CharacterAdded:Connect(onCharacterAdded)

    local btn, setV, getV, lbl, bindBtn = makeToggle(rightScroll, "Ragdoll Tp", "R")

    RunService.Heartbeat:Connect(function()
        if not Features.RagdollTP or not currentHumanoid then 
            ragdollIndicator.Visible = false
            return 
        end

        local currentState = currentHumanoid:GetState()
        if currentState == Enum.HumanoidStateType.Physics then
            if wasStanding then
                performTeleport()
            end
            if not ragdollActive then
                ragdollActive = true
                ragdollIndicator.Visible = true
            end
            wasStanding = false
        else
            ragdollActive = false
            ragdollIndicator.Visible = false
            wasStanding = true
        end
    end)

    btn.MouseButton1Click:Connect(function()
        local on = not getV()
        setV(on)
        Features.RagdollTP = on
    end)
end

do
    local pathActive = false
    local lastFlatVel = Vector3.zero
    local PATH_VELOCITY_SPEED = 59.2
    local PATH_SECOND_SPEED   = 29.6
    local PATH_BASE_STOP      = 1.35
    local PATH_MIN_STOP       = 0.65
    local PATH_NEXT_POINT_BIAS= 0.45
    local PATH_SMOOTH_FACTOR  = 0.12

    local stealPath1 = {
        {pos=Vector3.new(-470.6,-5.9,34.4)},{pos=Vector3.new(-484.2,-3.9,21.4)},
        {pos=Vector3.new(-475.6,-5.8,29.3)},{pos=Vector3.new(-473.4,-5.9,111)}
    }
    local stealPath2 = {
        {pos=Vector3.new(-474.7,-5.9,91.0)},{pos=Vector3.new(-483.4,-3.9,97.3)},
        {pos=Vector3.new(-474.7,-5.9,91.0)},{pos=Vector3.new(-476.1,-5.5,25.4)}
    }

    local function pathMoveToPoint(hrp, current, nextPoint, speed)
        local conn
        conn = RunService.Heartbeat:Connect(function()
            if not pathActive then 
                     conn:Disconnect()
                     hrp.AssemblyLinearVelocity = Vector3.zero 
             return 
            end
            local pos = hrp.Position
            local target = Vector3.new(current.X, pos.Y, current.Z)
            local dir = target - pos
            local dist = dir.Magnitude
            local stopDist = math.clamp(PATH_BASE_STOP - dist*0.04, PATH_MIN_STOP, PATH_BASE_STOP)
            if dist <= stopDist then conn:Disconnect() hrp.AssemblyLinearVelocity = Vector3.zero return end
            local moveDir = dir.Unit
            if nextPoint then
                local nextDir = (Vector3.new(nextPoint.X, pos.Y, nextPoint.Z) - pos).Unit
                moveDir = (moveDir + nextDir * PATH_NEXT_POINT_BIAS).Unit
            end
            if lastFlatVel.Magnitude > 0.1 then
                moveDir = (moveDir*(1-PATH_SMOOTH_FACTOR) + lastFlatVel.Unit*PATH_SMOOTH_FACTOR).Unit
            end
            local vel = Vector3.new(moveDir.X*speed, hrp.AssemblyLinearVelocity.Y, moveDir.Z*speed)
            hrp.AssemblyLinearVelocity = vel
            lastFlatVel = Vector3.new(vel.X, 0, vel.Z)
        end)
        while pathActive and (Vector3.new(hrp.Position.X,0,hrp.Position.Z)-Vector3.new(current.X,0,current.Z)).Magnitude > PATH_BASE_STOP do
            RunService.Heartbeat:Wait()
        end
    end

    local function runStealPath(path)
        local hrp = (Player.Character or Player.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
        for i, p in ipairs(path) do
            if not pathActive then return end
            local speed = i > 2 and PATH_SECOND_SPEED or PATH_VELOCITY_SPEED
            local nextP = path[i+1] and path[i+1].pos
            pathMoveToPoint(hrp, p.pos, nextP, speed)
            task.wait()
        end
    end

    local function startStealPath(path)
        pathActive = true
        task.spawn(function() while pathActive do runStealPath(path) task.wait(0.1) end end)
    end
    local function stopStealPath()
        pathActive = false
        local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.AssemblyLinearVelocity = Vector3.zero end
    end

    local rightKeybind = Enum.KeyCode.E
    local rightListening = false
    local leftSetV = nil

    local rBtn, rSetV, rGetV, rLbl, rBindBtn = makeToggle(rightScroll, "Right Steal", "E")

    local function toggleRight()
        if rightListening then return end
        local on = not rGetV()
        rSetV(on) 
        stopStealPath()
        if leftSetV then leftSetV(false) end
        if on then startStealPath(stealPath1) end
    end

    rBtn.MouseButton1Click:Connect(toggleRight)

    if not isMobile then
        UserInputService.InputBegan:Connect(function(inp, gpe)
            if gpe or rightListening then return end
            if inp.KeyCode == rightKeybind then toggleRight() end
        end)
    end

    if rBindBtn then
        rBindBtn.MouseButton1Click:Connect(function()
            if rightListening then return end
            rightListening = true 
            rBindBtn.Text = "..."
            rBindBtn.TextColor3 = Color3.new(1,1,1)

            local conn
            conn = UserInputService.InputBegan:Connect(function(inp)
                if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
                conn:Disconnect() 
                rightKeybind = inp.KeyCode
                rightListening = false
                rBindBtn.Text = "BIND" rBindBtn.TextColor3 = Color3.fromRGB(180, 230, 120)
                rLbl.Text = "Right Steal  [" .. rightKeybind.Name .. "]"
            end)
        end)
    end

    local leftKeybind = Enum.KeyCode.Q
    local leftListening = false
    local lBtn, lSetV, lGetV, lLbl, lBindBtn = makeToggle(rightScroll, "Left Steal", "Q")
    leftSetV = lSetV

    local function toggleLeft()
        if leftListening then return end
        local on = not lGetV()
       lSetV(on) 
       stopStealPath() 
       rSetV(false)
        if on then startStealPath(stealPath2) end
    end

    lBtn.MouseButton1Click:Connect(toggleLeft)

    if not isMobile then
        UserInputService.InputBegan:Connect(function(inp, gpe)
            if gpe or leftListening then return end
            if inp.KeyCode == leftKeybind then toggleLeft() end
        end)
    end

    if lBindBtn then
        lBindBtn.MouseButton1Click:Connect(function()
            if leftListening then return end
            leftListening = true
            lBindBtn.Text = "..." 
            lBindBtn.TextColor3 = Color3.new(1,1,1)

            local conn
            conn = UserInputService.InputBegan:Connect(function(inp)
                if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
                conn:Disconnect()
                leftKeybind = inp.KeyCode 
                leftListening = false
                lBindBtn.Text = "BIND"
                lBindBtn.TextColor3 = Color3.fromRGB(180, 230, 120)
                lLbl.Text = "Left Steal  [" .. leftKeybind.Name .. "]"
            end)
        end)
    end
end

leftLayout.Changed:Connect(function()
    leftScroll.CanvasSize = UDim2.new(0, 0, 0, leftLayout.AbsoluteContentSize.Y + 20 * guiScale)
end)
rightLayout.Changed:Connect(function()
    rightScroll.CanvasSize = UDim2.new(0, 0, 0, rightLayout.AbsoluteContentSize.Y + 20 * guiScale)
end)

local visible = true

if not isMobile then
    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.U then
            visible = not visible
            TweenService:Create(main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = visible and 0.1 or 1}):Play()
            main.Visible = visible
           end
     end)
end
]],
})

table.insert(SCRIPTS, {
    name="Semi TP", icon="🏃", desc="MOBILE • AUTO GRAB • ANTI RAG", isNew=true, kind="embed",
    code=[[
-- 44S Duel - UI MOBILE OPTIMIZED (Clean Version)
-- Fonctionnalités : Auto Grab | TP Left | TP Right | Anti Ragdoll

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

-- ============================================================
-- CONFIGURATION
-- ============================================================
local Config = {
    AutoGrabEnabled = false,
    AutoGrabRadius = 25,

    AntiRagdollEnabled = false,
}

-- ============================================================
-- VARIABLES
-- ============================================================
local ScreenGui = nil

local AutoGrabConnection = nil
local AutoGrabScanThread = nil
local CachedGrabbables = {}

local ToggleFunctions = {}

-- Connections Anti Ragdoll (version Hub)
local Connections = {}

-- ============================================================
-- FONCTIONS DE BASE
-- ============================================================
local function GetCharacter() return LocalPlayer.Character end
local function GetHumanoid()
    local char = GetCharacter()
    return char and char:FindFirstChildOfClass("Humanoid")
end
local function GetRootPart()
    local char = GetCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- ============================================================
-- AUTO GRAB
-- ============================================================
local CHUNK_SIZE = 200
local function ScanGrabbables()
    local allDesc = workspace:GetDescendants()
    local results = {}
    for i = 1, #allDesc do
        local desc = allDesc[i]
        if desc:IsA("ProximityPrompt") then
            local part = desc.Parent
            if part then
                if part:IsA("BasePart") then
                    results[#results + 1] = { type = "prompt", prompt = desc, part = part }
                elseif part:IsA("Attachment") and part.Parent and part.Parent:IsA("BasePart") then
                    results[#results + 1] = { type = "prompt", prompt = desc, part = part.Parent }
                end
            end
        elseif desc:IsA("Tool") then
            local parent = desc.Parent
            if parent and not parent:FindFirstChildOfClass("Humanoid") and not parent:IsA("Backpack") then
                local handle = desc:FindFirstChild("Handle")
                if handle and handle:IsA("BasePart") then
                    results[#results + 1] = { type = "tool", tool = desc, part = handle }
                end
            end
        end
        if i % CHUNK_SIZE == 0 then task.wait() end
    end
    CachedGrabbables = results
end

local function StartAutoGrabScan()
    if AutoGrabScanThread then return end
    AutoGrabScanThread = task.spawn(function()
        while Config.AutoGrabEnabled do pcall(ScanGrabbables) task.wait(0.8) end
        AutoGrabScanThread = nil
    end)
end

local function StartAutoGrab()
    if AutoGrabConnection then AutoGrabConnection:Disconnect() end
    StartAutoGrabScan()
    local grabCooldown = 0
    AutoGrabConnection = RunService.Heartbeat:Connect(function()
        if not Config.AutoGrabEnabled then return end
        local char = GetCharacter(); local rootPart = GetRootPart(); local humanoid = GetHumanoid()
        if not char or not rootPart or not humanoid then return end
        if tick() - grabCooldown < 0.3 then return end
        if char:FindFirstChildOfClass("Tool") then return end
        local radius = Config.AutoGrabRadius
        local myPos = rootPart.Position
        local closestDist = radius + 1
        local closestItem = nil
        for _, item in ipairs(CachedGrabbables) do
            if item.part and item.part.Parent then
                local ok, dist = pcall(function() return (item.part.Position - myPos).Magnitude end)
                if ok and dist and dist < closestDist then
                    if item.type == "prompt" and item.prompt and item.prompt.Parent and item.prompt.Enabled then
                        closestDist = dist; closestItem = item
                    elseif item.type == "tool" and item.tool and item.tool.Parent then
                        local tp = item.tool.Parent
                        if tp and not tp:FindFirstChildOfClass("Humanoid") and not tp:IsA("Backpack") then
                            closestDist = dist; closestItem = item
                        end
                    end
                end
            end
        end
        if closestItem and closestDist <= radius then
            grabCooldown = tick()
            if closestItem.type == "prompt" then
                pcall(function()
                    if fireproximityprompt then
                        fireproximityprompt(closestItem.prompt)
                    else
                        closestItem.prompt:InputHoldBegin()
                        task.delay(closestItem.prompt.HoldDuration + 0.05, function()
                            if closestItem.prompt and closestItem.prompt.Parent then closestItem.prompt:InputHoldEnd() end
                        end)
                    end
                end)
            elseif closestItem.type == "tool" then
                pcall(function() humanoid:EquipTool(closestItem.tool) end)
            end
        end
    end)
end

local function StopAutoGrab()
    if AutoGrabConnection then AutoGrabConnection:Disconnect(); AutoGrabConnection = nil end
    CachedGrabbables = {}
end

-- ============================================================
-- ANTI RAGDOLL (version Hub)
-- ============================================================
local function startAntiRagdoll()
    if Connections.antiRagdoll then return end

    Connections.antiRagdoll = RunService.Heartbeat:Connect(function()
        if not Config.AntiRagdollEnabled then return end

        local char = LocalPlayer.Character
        if not char then return end

        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")

        if hum then
            local humState = hum:GetState()
            if humState == Enum.HumanoidStateType.Physics or
               humState == Enum.HumanoidStateType.Ragdoll or
               humState == Enum.HumanoidStateType.FallingDown then

                hum:ChangeState(Enum.HumanoidStateType.Running)
                workspace.CurrentCamera.CameraSubject = hum

                pcall(function()
                    if LocalPlayer.Character then
                        local PlayerModule = LocalPlayer.PlayerScripts:FindFirstChild("PlayerModule")
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
            if obj:IsA("Motor6D") and obj.Enabled == false then
                obj.Enabled = true
            end
        end
    end)
end

local function stopAntiRagdoll()
    if Connections.antiRagdoll then
        Connections.antiRagdoll:Disconnect()
        Connections.antiRagdoll = nil
    end
end

-- ============================================================
-- TELEPORT LEFT
-- ============================================================
local teleportLeftPositions = {
    Vector3.new(-455.89794921875, -7.3000030517578125, 57.81473159790039),
    Vector3.new(-457.32952880859375, -7.3000030517578125, 104.57672882080078),
    Vector3.new(-486.0061950683594, -5.151071548461914, 102.53863525390625)
}

local function ExecuteTeleportLeft()
    local rootPart = GetRootPart()
    if not rootPart then return end

    for i = 1, #teleportLeftPositions do
        rootPart.CFrame = CFrame.new(teleportLeftPositions[i])
        rootPart.AssemblyLinearVelocity = Vector3.zero
        rootPart.AssemblyAngularVelocity = Vector3.zero
        task.wait(0.05)
    end
end

-- ============================================================
-- TELEPORT RIGHT
-- ============================================================
local teleportRightPositions = {
    Vector3.new(-461.74517822265625, -7.3000030517578125, 53.4169921875),
    Vector3.new(-462.244873046875, -7.3000030517578125, 20.675413131713867),
    Vector3.new(-487.0870056152344, -5.085260391235352, 19.669218063354492)
}

local function ExecuteTeleportRight()
    local rootPart = GetRootPart()
    if not rootPart then return end

    for i = 1, #teleportRightPositions do
        rootPart.CFrame = CFrame.new(teleportRightPositions[i])
        rootPart.AssemblyLinearVelocity = Vector3.zero
        rootPart.AssemblyAngularVelocity = Vector3.zero
        task.wait(0.05)
    end
end

-- ============================================================
-- GUI - OPTIMISÉ MOBILE
-- ============================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "44SDuelUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
screenGui.DisplayOrder = 999999998
screenGui.IgnoreGuiInset = true

if gethui then
    screenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(screenGui)
    screenGui.Parent = CoreGui
else
    screenGui.Parent = CoreGui
end

local FRAME_W = 250

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, FRAME_W, 0, 100)
frame.Position = UDim2.new(0, 10, 0, 200)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.ZIndex = 999999999
frame.Active = true
frame.Parent = screenGui

local fCorner = Instance.new("UICorner")
fCorner.CornerRadius = UDim.new(0, 8)
fCorner.Parent = frame

local fStroke = Instance.new("UIStroke")
fStroke.Color = Color3.fromRGB(180, 120, 255)
fStroke.Thickness = 4
fStroke.Transparency = 0.2
fStroke.Parent = frame

local fGrad = Instance.new("UIGradient")
fGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0,    Color3.fromRGB(100, 50, 200)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(180, 120, 255)),
    ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(220, 180, 255)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(180, 120, 255)),
    ColorSequenceKeypoint.new(1,    Color3.fromRGB(100, 50, 200)),
}
fGrad.Rotation = 0
fGrad.Parent = fStroke

spawn(function()
    while fGrad and fGrad.Parent do
        fGrad.Rotation = (fGrad.Rotation + 2) % 360
        wait(0.03)
    end
end)

-- DRAG
local dragging, dragInput, mousePos, framePos = false, nil, nil, nil
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; mousePos = input.Position; framePos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local d = input.Position - mousePos
        frame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset+d.X, framePos.Y.Scale, framePos.Y.Offset+d.Y)
    end
end)

-- TITRE
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -40, 0, 26)
titleLabel.Position = UDim2.new(0, 8, 0, 6)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "44S Duel"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.ZIndex = 999999999
titleLabel.Parent = frame

local tGrad = Instance.new("UIGradient")
tGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 120, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
}
tGrad.Parent = titleLabel

-- CLOSE BUTTON (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -38, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(15, 0, 20)
closeBtn.BackgroundTransparency = 0.4
closeBtn.BorderSizePixel = 0
closeBtn.Text = ""
closeBtn.AutoButtonColor = false
closeBtn.ZIndex = 1000000000
closeBtn.Parent = frame

Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 7)

local closeBtnStroke = Instance.new("UIStroke")
closeBtnStroke.Color = Color3.fromRGB(180, 120, 255)
closeBtnStroke.Thickness = 2
closeBtnStroke.Transparency = 0.5
closeBtnStroke.Parent = closeBtn

local closeBtnGrad = Instance.new("UIGradient")
closeBtnGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 120, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 120, 255)),
}
closeBtnGrad.Rotation = 0
closeBtnGrad.Parent = closeBtnStroke

spawn(function()
    while closeBtnGrad and closeBtnGrad.Parent do
        closeBtnGrad.Rotation = (closeBtnGrad.Rotation + 3) % 360
        wait(0.03)
    end
end)

local crossContainer = Instance.new("Frame")
crossContainer.Size = UDim2.new(0, 20, 0, 20)
crossContainer.Position = UDim2.new(0.5, -10, 0.5, -10)
crossContainer.BackgroundTransparency = 1
crossContainer.ZIndex = 1000000001
crossContainer.Parent = closeBtn

local line1 = Instance.new("Frame")
line1.Size = UDim2.new(0, 3, 0, 20)
line1.Position = UDim2.new(0.5, -1.5, 0.5, -10)
line1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
line1.BorderSizePixel = 0
line1.Rotation = 45
line1.ZIndex = 1000000002
line1.Parent = crossContainer
Instance.new("UICorner", line1).CornerRadius = UDim.new(1, 0)

local shadow1 = Instance.new("UIStroke")
shadow1.Color = Color3.fromRGB(180, 120, 255)
shadow1.Thickness = 1.5
shadow1.Transparency = 0.3
shadow1.Parent = line1

local line2 = Instance.new("Frame")
line2.Size = UDim2.new(0, 3, 0, 20)
line2.Position = UDim2.new(0.5, -1.5, 0.5, -10)
line2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
line2.BorderSizePixel = 0
line2.Rotation = -45
line2.ZIndex = 1000000002
line2.Parent = crossContainer
Instance.new("UICorner", line2).CornerRadius = UDim.new(1, 0)

local shadow2 = Instance.new("UIStroke")
shadow2.Color = Color3.fromRGB(180, 120, 255)
shadow2.Thickness = 1.5
shadow2.Transparency = 0.3
shadow2.Parent = line2

closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 36, 0, 36), BackgroundTransparency = 0.1
    }):Play()
    TweenService:Create(closeBtnStroke, TweenInfo.new(0.2), {
        Color = Color3.fromRGB(255, 100, 100), Transparency = 0.2, Thickness = 2.5
    }):Play()
    TweenService:Create(line1, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 100, 100), Size = UDim2.new(0, 3, 0, 24)
    }):Play()
    TweenService:Create(line2, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 100, 100), Size = UDim2.new(0, 3, 0, 24)
    }):Play()
    TweenService:Create(crossContainer, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), { Rotation = 90 }):Play()
end)

closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 32, 0, 32), BackgroundTransparency = 0.4
    }):Play()
    TweenService:Create(closeBtnStroke, TweenInfo.new(0.2), {
        Color = Color3.fromRGB(180, 120, 255), Transparency = 0.5, Thickness = 2
    }):Play()
    TweenService:Create(line1, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0, 3, 0, 20)
    }):Play()
    TweenService:Create(line2, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0, 3, 0, 20)
    }):Play()
    TweenService:Create(crossContainer, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), { Rotation = 0 }):Play()
end)

-- ============================================================
-- REOPEN BAR
-- ============================================================
local reopenBar = Instance.new("Frame")
reopenBar.Size = UDim2.new(0, 200, 0, 28)
reopenBar.Position = UDim2.new(0.5, -100, 1, -40)
reopenBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
reopenBar.BackgroundTransparency = 0.25
reopenBar.BorderSizePixel = 0
reopenBar.ZIndex = 999999998
reopenBar.Active = true
reopenBar.Visible = false
reopenBar.Parent = screenGui

Instance.new("UICorner", reopenBar).CornerRadius = UDim.new(0, 7)

local barStroke = Instance.new("UIStroke")
barStroke.Color = Color3.fromRGB(180, 120, 255)
barStroke.Thickness = 2
barStroke.Transparency = 0.3
barStroke.Parent = reopenBar

local scrollingFrame = Instance.new("Frame")
scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.ClipsDescendants = true
scrollingFrame.ZIndex = 999999999
scrollingFrame.Parent = reopenBar

local scrollText = Instance.new("TextLabel")
scrollText.Size = UDim2.new(0, 600, 1, 0)
scrollText.Position = UDim2.new(0, 0, 0, 0)
scrollText.BackgroundTransparency = 1
scrollText.Text = "discord.gg/44s  •  discord.gg/44s  •  discord.gg/44s  •  discord.gg/44s  •  "
scrollText.Font = Enum.Font.GothamBold
scrollText.TextSize = 12
scrollText.TextColor3 = Color3.fromRGB(200, 150, 255)
scrollText.TextXAlignment = Enum.TextXAlignment.Left
scrollText.ZIndex = 1000000000
scrollText.Parent = scrollingFrame

spawn(function()
    while scrollText and scrollText.Parent do
        for i = 0, 600, 1 do
            if not scrollText or not scrollText.Parent then break end
            scrollText.Position = UDim2.new(0, -i, 0, 0)
            wait(0.02)
        end
    end
end)

local reopenBtn = Instance.new("TextButton")
reopenBtn.Size = UDim2.new(1, 0, 1, 0)
reopenBtn.BackgroundTransparency = 1
reopenBtn.Text = ""
reopenBtn.ZIndex = 1000000001
reopenBtn.Parent = reopenBar

reopenBtn.MouseButton1Click:Connect(function()
    frame.Visible = true
    reopenBar.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    reopenBar.Visible = true
end)

-- ============================================================
-- HELPERS UI
-- ============================================================
local Y = 36

local function MakeSectionTitle(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -16, 0, 16)
    lbl.Position = UDim2.new(0, 8, 0, Y)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 10
    lbl.TextColor3 = Color3.fromRGB(180, 120, 255)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 999999999
    lbl.Parent = frame

    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, -16, 0, 1)
    line.Position = UDim2.new(0, 8, 0, Y + 16)
    line.BackgroundColor3 = Color3.fromRGB(80, 50, 120)
    line.BackgroundTransparency = 0.4
    line.BorderSizePixel = 0
    line.ZIndex = 999999999
    line.Parent = frame

    Y = Y + 19
end

local function MakeToggleRow(label, configKey, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -16, 0, 26)
    btn.Position = UDim2.new(0, 8, 0, Y)
    btn.BackgroundColor3 = Color3.fromRGB(15, 0, 15)
    btn.BackgroundTransparency = 0.15
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.ZIndex = 999999999
    btn.Parent = frame

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local bStroke = Instance.new("UIStroke")
    bStroke.Color = Color3.fromRGB(100, 100, 100)
    bStroke.Thickness = 1.5
    bStroke.Transparency = 0.7
    bStroke.Parent = btn

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -52, 1, 0)
    lbl.Position = UDim2.new(0, 7, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 999999999
    lbl.Parent = btn

    local track = Instance.new("Frame")
    track.Size = UDim2.new(0, 34, 0, 18)
    track.Position = UDim2.new(1, -40, 0.5, -9)
    track.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    track.BorderSizePixel = 0
    track.ZIndex = 999999999
    track.Parent = btn
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 13, 0, 13)
    knob.Position = UDim2.new(0, 2, 0.5, -6)
    knob.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    knob.BorderSizePixel = 0
    knob.ZIndex = 1000000000
    knob.Parent = track
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local isOn = false
    local function Update(state)
        isOn = state
        if isOn then
            TweenService:Create(knob, TweenInfo.new(0.15), {Position=UDim2.new(1,-15,0.5,-6), BackgroundColor3=Color3.fromRGB(255,255,255)}):Play()
            TweenService:Create(track, TweenInfo.new(0.15), {BackgroundColor3=Color3.fromRGB(140,80,220)}):Play()
            bStroke.Color = Color3.fromRGB(180, 120, 255); bStroke.Transparency = 0.3
            lbl.TextColor3 = Color3.fromRGB(220, 180, 255)
        else
            TweenService:Create(knob, TweenInfo.new(0.15), {Position=UDim2.new(0,2,0.5,-6), BackgroundColor3=Color3.fromRGB(150,150,150)}):Play()
            TweenService:Create(track, TweenInfo.new(0.15), {BackgroundColor3=Color3.fromRGB(50,50,50)}):Play()
            bStroke.Color = Color3.fromRGB(100, 100, 100); bStroke.Transparency = 0.7
            lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
        end
        if callback then callback(isOn) end
    end
    btn.MouseButton1Click:Connect(function() Update(not isOn) end)
    if configKey then ToggleFunctions[configKey] = Update end

    Y = Y + 30
end

local function MakeActionButton(label, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -16, 0, 30)
    btn.Position = UDim2.new(0, 8, 0, Y)
    btn.BackgroundColor3 = Color3.fromRGB(15, 0, 15)
    btn.BackgroundTransparency = 0.15
    btn.BorderSizePixel = 0
    btn.Text = label
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextColor3 = Color3.fromRGB(230, 175, 255)
    btn.AutoButtonColor = false
    btn.ZIndex = 999999999
    btn.Parent = frame

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local bStroke = Instance.new("UIStroke")
    bStroke.Color = Color3.fromRGB(180, 120, 255)
    bStroke.Thickness = 1.5
    bStroke.Transparency = 0.5
    bStroke.Parent = btn

    local btnGrad = Instance.new("UIGradient")
    btnGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 120, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 180, 255)),
    }
    btnGrad.Parent = btn

    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)

    Y = Y + 34
end

local function MakeSliderRow(label, minVal, maxVal, defaultVal, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -16, 0, 34)
    container.Position = UDim2.new(0, 8, 0, Y)
    container.BackgroundTransparency = 1
    container.ZIndex = 999999999
    container.Parent = frame

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0, 110, 0, 14)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.TextColor3 = Color3.fromRGB(160, 160, 160)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 999999999
    lbl.Parent = container

    local valBg = Instance.new("Frame")
    valBg.Size = UDim2.new(0, 36, 0, 14)
    valBg.Position = UDim2.new(1, -36, 0, 0)
    valBg.BackgroundColor3 = Color3.fromRGB(20, 10, 30)
    valBg.BackgroundTransparency = 0.2
    valBg.BorderSizePixel = 0
    valBg.ZIndex = 999999999
    valBg.Parent = container
    Instance.new("UICorner", valBg).CornerRadius = UDim.new(0, 4)

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(1,0,1,0)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(defaultVal)
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextSize = 11
    valLbl.TextColor3 = Color3.fromRGB(180, 120, 255)
    valLbl.ZIndex = 1000000000
    valLbl.Parent = valBg

    local sliderBG = Instance.new("Frame")
    sliderBG.Size = UDim2.new(1, 0, 0, 12)
    sliderBG.Position = UDim2.new(0, 0, 0, 20)
    sliderBG.BackgroundColor3 = Color3.fromRGB(20, 10, 30)
    sliderBG.BackgroundTransparency = 0.2
    sliderBG.BorderSizePixel = 0
    sliderBG.ZIndex = 999999999
    sliderBG.Parent = container
    Instance.new("UICorner", sliderBG).CornerRadius = UDim.new(0, 6)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((defaultVal-minVal)/(maxVal-minVal), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(200, 150, 255)
    fill.BorderSizePixel = 0
    fill.ZIndex = 999999999
    fill.Parent = sliderBG
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 6)

    local fillGrad = Instance.new("UIGradient")
    fillGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 80, 220)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 120, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 150, 255)),
    }
    fillGrad.Parent = fill

    local thumb = Instance.new("Frame")
    thumb.Size = UDim2.new(0, 12, 0, 12)
    thumb.Position = UDim2.new((defaultVal-minVal)/(maxVal-minVal), -6, 0.5, -6)
    thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    thumb.BorderSizePixel = 0
    thumb.ZIndex = 1000000000
    thumb.Parent = sliderBG
    Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)

    local sliderBtn = Instance.new("TextButton")
    sliderBtn.Size = UDim2.new(1, 0, 1, 12)
    sliderBtn.Position = UDim2.new(0, 0, 0, -6)
    sliderBtn.BackgroundTransparency = 1
    sliderBtn.Text = ""
    sliderBtn.ZIndex = 1000000001
    sliderBtn.Parent = sliderBG

    local isDragging = false
    sliderBtn.MouseButton1Down:Connect(function() isDragging = true end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local pct = math.clamp((input.Position.X - sliderBG.AbsolutePosition.X) / sliderBG.AbsoluteSize.X, 0, 1)
            local value = math.floor(minVal + (maxVal-minVal) * pct)
            fill.Size = UDim2.new(pct, 0, 1, 0)
            thumb.Position = UDim2.new(pct, -6, 0.5, -6)
            valLbl.Text = tostring(value)
            if callback then callback(value) end
        end
    end)

    Y = Y + 38
end

local function MakeSpacer(h)
    Y = Y + (h or 3)
end

-- ============================================================
-- CONSTRUCTION DU MENU
-- ============================================================

MakeSectionTitle("Auto Grab")
MakeToggleRow("Activer", "AutoGrab", function(state)
    Config.AutoGrabEnabled = state
    if state then StartAutoGrab() else StopAutoGrab() end
end)
MakeSliderRow("Rayon de grab", 5, 60, Config.AutoGrabRadius, function(v) Config.AutoGrabRadius = v end)
MakeSpacer(3)

MakeSectionTitle("Anti Ragdoll")
MakeToggleRow("Activer", "AntiRagdoll", function(state)
    Config.AntiRagdollEnabled = state
    if state then startAntiRagdoll() else stopAntiRagdoll() end
end)
MakeSpacer(3)

MakeSectionTitle("Teleport")
MakeActionButton("TP LEFT", function()
    ExecuteTeleportLeft()
end)
MakeActionButton("TP RIGHT", function()
    ExecuteTeleportRight()
end)
MakeSpacer(3)

frame.Size = UDim2.new(0, FRAME_W, 0, Y + 6)

-- ============================================================
-- INPUT HANDLER
-- ============================================================
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end

    if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
        frame.Visible = not frame.Visible
        if not frame.Visible then
            reopenBar.Visible = true
        else
            reopenBar.Visible = false
        end
        return
    end
end)

-- ============================================================
-- INITIALISATION
-- ============================================================

if ToggleFunctions["AutoGrab"] then ToggleFunctions["AutoGrab"](Config.AutoGrabEnabled) end
if ToggleFunctions["AntiRagdoll"] then ToggleFunctions["AntiRagdoll"](Config.AntiRagdollEnabled) end

if Config.AutoGrabEnabled then StartAutoGrab() end
if Config.AntiRagdollEnabled then startAntiRagdoll() end

LocalPlayer.CharacterAdded:Connect(function()
    wait(0.5)
    if Config.AutoGrabEnabled then StartAutoGrab() end
    if Config.AntiRagdollEnabled then startAntiRagdoll() end
end)

print("✅ 44S Duel chargé ! (ALT = afficher/cacher | Barre = réouvrir)")
print("📦 Auto Grab | 🛡️ Anti Ragdoll | 🔀 TP Left / TP Right")
]],
})

table.insert(SCRIPTS, {
    name="Frost Flash TP", icon="❄️", desc="FLASH TP • AUTO • MOBILE", isNew=true, kind="embed",
    code=[=[
-- [[ DEOBFUSCATED BY .gg/sourceshub ]] --

-- // [1] SERVICES //
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- // [2] CONFIGURATION (EDIT EVERYTHING HERE) //
local CONFIG = {
    Gui = {
        ScreenGuiName = "TurboFlashCompact",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    },

    MainFrame = {
        Name = "Main",
        Size = UDim2.new(0, 200, 0, 130),
        Position = UDim2.new(0.5, -100, 0.5, -70),
        BackgroundColor3 = Color3.fromRGB(10, 15, 30),
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        Active = true,
        Draggable = true,
    },

    TitleBar = {
        Height = 24,
        BackgroundColor3 = Color3.fromRGB(15, 17, 21),
        Text = "discord.gg/frost-hub",
        TextColor3 = Color3.fromRGB(100, 200, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 13,
    },

    Toggle = {
        Text = "Auto Flash",
        TextColor3 = Color3.fromRGB(180, 220, 255),
        TextSize = 11,
        OffColor = Color3.fromRGB(255, 100, 100),
        OnColor = Color3.fromRGB(100, 255, 100),
        DefaultState = false,
    },

    Slider = {
        Label = "Trigger Percent",
        DefaultPercent = 92,
        BarColor = Color3.fromRGB(35, 40, 50),
        FillColor = Color3.fromRGB(100, 200, 255),
        KnobColor = Color3.fromRGB(255, 255, 255),
    },

    Accent = {
        StrokeColor = Color3.fromRGB(100, 200, 255),
        GradientRotationSpeed = 1, -- set to 0 to disable spinning effect
    },

    Extras = {
        LoadExternal = true,
        CleanPlayerGui = true,
        AuthFingerprint = "8cf0d2d1f73b59aa843f769d511f8c568a26173002c500afccc1022e4472230c",
    }
}

-- // [3] OBJECT REFERENCES //
local ScreenGui
local MainFrame
local TitleBar
local TitleLabel
local ToggleFrame
local ToggleLabel
local StatusLabel
local ToggleButton
local SliderContainer
local SliderLabel
local SliderBar
local SliderFill
local SliderKnob

local Buttons = {}
local Connections = {}

-- // [4] UTILITY FUNCTIONS //
local function safeLoad(url)
    pcall(function()
        loadstring(game:HttpGet(url))()
    end)
end

local function createGradient(parent)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 200, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0))
    }
    gradient.Parent = parent
    return gradient
end

local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            dragInput = input
        end
    end)
    UserInputService = game:GetService("UserInputService")
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

local function animateAccent()
    if CONFIG.Accent.GradientRotationSpeed == 0 then return end
    local grad = MainFrame:FindFirstChildWhichIsA("UIStroke") and MainFrame:FindFirstChildWhichIsA("UIStroke").Parent:FindFirstChild("UIGradient") or nil
    if not grad then return end
    RunService.Heartbeat:Connect(function(dt)
        grad.Rotation = (grad.Rotation + CONFIG.Accent.GradientRotationSpeed * 60 * dt) % 360
    end)
end

-- // [5] GUI CREATION //
local function createGUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = CONFIG.Gui.ScreenGuiName
    ScreenGui.ResetOnSpawn = CONFIG.Gui.ResetOnSpawn
    ScreenGui.ZIndexBehavior = CONFIG.Gui.ZIndexBehavior
    ScreenGui.Parent = CoreGui

    MainFrame = Instance.new("Frame")
    MainFrame.Name = CONFIG.MainFrame.Name
    MainFrame.Size = CONFIG.MainFrame.Size
    MainFrame.Position = CONFIG.MainFrame.Position
    MainFrame.BackgroundColor3 = CONFIG.MainFrame.BackgroundColor3
    MainFrame.BackgroundTransparency = CONFIG.MainFrame.BackgroundTransparency
    MainFrame.BorderSizePixel = CONFIG.MainFrame.BorderSizePixel
    MainFrame.Active = CONFIG.MainFrame.Active
    MainFrame.Draggable = CONFIG.MainFrame.Draggable
    MainFrame.Parent = ScreenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = MainFrame

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1.5
    stroke.Color = CONFIG.Accent.StrokeColor
    stroke.Parent = MainFrame

    createGradient(stroke)

    -- Title Bar
    TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, CONFIG.TitleBar.Height)
    TitleBar.BackgroundColor3 = CONFIG.TitleBar.BackgroundColor3
    TitleBar.BackgroundTransparency = 1
    TitleBar.Parent = MainFrame

    TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 1, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = CONFIG.TitleBar.Text
    TitleLabel.TextColor3 = CONFIG.TitleBar.TextColor3
    TitleLabel.Font = CONFIG.TitleBar.Font
    TitleLabel.TextSize = CONFIG.TitleBar.TextSize
    TitleLabel.Parent = TitleBar

    -- Toggle Section
    ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -20, 0, 26)
    ToggleFrame.Position = UDim2.new(0, 10, 0, 30)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 24)
    ToggleFrame.Parent = MainFrame

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 4)
    toggleCorner.Parent = ToggleFrame

    ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(1, -50, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 8, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = CONFIG.Toggle.Text
    ToggleLabel.TextColor3 = CONFIG.Toggle.TextColor3
    ToggleLabel.TextSize = CONFIG.Toggle.TextSize
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleFrame

    StatusLabel = Instance.new("TextLabel")
    StatusLabel.Size = UDim2.new(0, 40, 1, 0)
    StatusLabel.Position = UDim2.new(1, -48, 0, 0)
    StatusLabel.AnchorPoint = Vector2.new(1, 0)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = CONFIG.Toggle.DefaultState and "ON" or "OFF"
    StatusLabel.TextColor3 = CONFIG.Toggle.DefaultState and CONFIG.Toggle.OnColor or CONFIG.Toggle.OffColor
    StatusLabel.TextXAlignment = Enum.TextXAlignment.Right
    StatusLabel.Parent = ToggleFrame

    ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(1, 0, 1, 0)
    ToggleButton.BackgroundTransparency = 1
    ToggleButton.Text = ""
    ToggleButton.Parent = ToggleFrame
    Buttons.Toggle = ToggleButton

    -- Slider Section
    SliderContainer = Instance.new("Frame")
    SliderContainer.Size = UDim2.new(1, -20, 0, 40)
    SliderContainer.Position = UDim2.new(0, 10, 0, 64)
    SliderContainer.BackgroundTransparency = 1
    SliderContainer.Parent = MainFrame

    SliderLabel = Instance.new("TextLabel")
    SliderLabel.Size = UDim2.new(1, 0, 0, 16)
    SliderLabel.Text = CONFIG.Slider.Label .. "  " .. CONFIG.Slider.DefaultPercent .. "%"
    SliderLabel.TextColor3 = Color3.fromRGB(180, 220, 255)
    SliderLabel.TextSize = 11
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Parent = SliderContainer

    SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(1, 0, 0, 3)
    SliderBar.Position = UDim2.new(0, 0, 0.5, -1)
    SliderBar.BackgroundColor3 = CONFIG.Slider.BarColor
    SliderBar.Parent = SliderContainer

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = SliderBar

    SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new(CONFIG.Slider.DefaultPercent / 100, 0, 1, 0)
    SliderFill.BackgroundColor3 = CONFIG.Slider.FillColor
    SliderFill.Parent = SliderBar

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = SliderFill

    SliderKnob = Instance.new("Frame")
    SliderKnob.Size = UDim2.new(0, 8, 0, 8)
    SliderKnob.Position = UDim2.new(CONFIG.Slider.DefaultPercent / 100, -4, 0.5, -4)
    SliderKnob.BackgroundColor3 = CONFIG.Slider.KnobColor
    SliderKnob.Parent = SliderBar

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = SliderKnob

    SliderContainer.InputBegan:Connect(function() -- placeholder for easy extension
        -- User can hook here to make fully draggable slider later
    end)
end

-- // [6] FUNCTIONALITY //
local function setupFunctionality()
    makeDraggable(MainFrame)

    local toggleState = CONFIG.Toggle.DefaultState

    Buttons.Toggle.MouseButton1Click:Connect(function()
        toggleState = not toggleState
        StatusLabel.Text = toggleState and "ON" or "OFF"
        StatusLabel.TextColor3 = toggleState and CONFIG.Toggle.OnColor or CONFIG.Toggle.OffColor

        -- Example hook - replace with your real logic (auto flash, fuse, etc.)
        print("[TurboFlash] Auto Flash → " .. (toggleState and "ENABLED" or "DISABLED"))
        -- You can fire RemoteEvents here easily
    end)

    -- Example slider update (click anywhere on container to demo)
    SliderContainer.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local percent = math.random(85, 98) -- demo - replace with real raycast/position calc
            SliderFill.Size = UDim2.new(percent / 100, 0, 1, 0)
            SliderKnob.Position = UDim2.new(percent / 100, -4, 0.5, -4)
            SliderLabel.Text = CONFIG.Slider.Label .. "  " .. percent .. "%"
            print("[TurboFlash] Trigger Percent set to " .. percent .. "%")
        end
    end)

    animateAccent()

    -- Optional: clean player gui (exactly as original)
    if CONFIG.Extras.CleanPlayerGui and LocalPlayer:FindFirstChild("PlayerGui") then
        local pg = LocalPlayer.PlayerGui
        for _, name in ipairs({"BrainrotTrader", "TradeLiveTrade", "TradePrompts"}) do
            pcall(function() if pg:FindFirstChild(name) then pg[name]:Destroy() end end)
        end
    end

    -- External loader (exactly as original, wrapped safely)
    if CONFIG.Extras.LoadExternal then
        safeLoad("https://api.luarmor.net/files/v4/loaders/43f06353bacd3c021e4fe7c423b9dbd3.lua")
    end
end

-- // [7] INITIALIZATION //
local function init()
    createGUI()
    setupFunctionality()

    -- Optional auth simulation (keeps original behavior)
    pcall(function()
        HttpService:RequestAsync({
            Url = "https://as1-roblox-auth.luarmor.net/status",
            Method = "GET",
            Headers = {
                ["Delta-Fingerprint"] = CONFIG.Extras.AuthFingerprint,
                ["Delta-User-Identifier"] = CONFIG.Extras.AuthFingerprint,
                ["User-Agent"] = "Delta Android/2.0"
            }
        })
    end)

    print("[TurboFlashCompact] Loaded • Fully editable via CONFIG table • Enjoy!")
end

init()
]=],
})

table.insert(SCRIPTS, {
    name="TP to Best", icon="📍", desc="AUTO TP • BEST BRAINROT • LOOP", isNew=true, kind="embed",
    code=[[
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local TpToBestEnabled = false
local TpToBestConnections = {}
local currentBestPetTP = nil
local isStoppingTP = false

local baseCoordinatesTP = {
    ["Base 1"] = Vector3.new(-479.5, 17.4, -103.1),
    ["Base 2"] = Vector3.new(-339.8, 17.4, -98.5),
    ["Base 3"] = Vector3.new(-340.3, 17.4, 6.0),
    ["Base 4"] = Vector3.new(-340.0, 17.4, 113.1),
    ["Base 5"] = Vector3.new(-339.7, 17.0, 221.8),
    ["Base 6"] = Vector3.new(-479.3, 17.4, 218.5),
    ["Base 7"] = Vector3.new(-478.5, 17.4, 116.3),
    ["Base 8"] = Vector3.new(-478.2, 17.4, 5.8)
}

local subterraneanCoordinates = {
    ["Base 1"] = Vector3.new(-348.0, -2, 5.9),
    ["Base 2"] = Vector3.new(-349.2, -2, -100.3),
    ["Base 3"] = Vector3.new(-470.4, -2, -99.9),
    ["Base 4"] = Vector3.new(-471.2, -2, 6.6),
    ["Base 5"] = Vector3.new(-469.6, -2, 114.2),
    ["Base 6"] = Vector3.new(-469.4, -2, 222.0),
    ["Base 7"] = Vector3.new(-349.4, -2, 219.1),
    ["Base 8"] = Vector3.new(-348.4, -2, 112.8)
}

local function equipFlyingCarpet()
    if isStoppingTP then return end

    local char = LocalPlayer.Character
    if not char then return end

    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return end

    local flyingCarpet = backpack:FindFirstChild("Flying Carpet")
    if flyingCarpet then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:EquipTool(flyingCarpet)
        end
    end
end

local function parseGenerationValue(text)
    local cleanText = text:gsub('[^%d%.KMBT]', '')
    local number = tonumber(string.match(cleanText, '^%d*%.?%d+'))
    if not number then return nil end
    local suffix = string.match(cleanText, '[KMBT]$') or ''
    local multipliers = { K = 1e3, M = 1e6, B = 1e9, T = 1e12 }
    return number * (multipliers[suffix] or 1)
end

local function findPlayerPlot()
    local plotsFolder = Workspace:FindFirstChild('Plots')
    if not plotsFolder then return nil end
    
    for _, plot in pairs(plotsFolder:GetChildren()) do
        local yourBase = plot:FindFirstChild("YourBase", true)
        if yourBase and yourBase:IsA("BoolValue") and yourBase.Value then
            return plot.Name
        end
    end
    return nil
end

local function findClosestBaseTP(petPosition)
    local closestBase = nil
    local closestDistance = math.huge
    local closestBaseCoord = nil
    
    local coordinatesToUse = baseCoordinatesTP
    if petPosition.Y < 0 then
        coordinatesToUse = subterraneanCoordinates
    end

    for baseName, baseCoord in pairs(coordinatesToUse) do
        local distance = (petPosition - baseCoord).Magnitude
        if distance < closestDistance then
            closestDistance = distance
            closestBase = baseName
            closestBaseCoord = baseCoord
        end
    end

    return closestBase, closestBaseCoord
end

local function findMostExpensivePetTP()
    if isStoppingTP then return nil end

    local plots = Workspace:FindFirstChild('Plots')
    if not plots then return nil end

    local animalData = {}
    local myPlotName = findPlayerPlot()

    for _, plot in pairs(plots:GetChildren()) do
        local podiums = plot:FindFirstChild('AnimalPodiums')
        if podiums then
            for _, podium in pairs(podiums:GetChildren()) do
                local base = podium:FindFirstChild('Base')
                if base then
                    local spawn = base:FindFirstChild('Spawn')
                    if spawn then
                        local attach = spawn:FindFirstChild('Attachment')
                        if attach then
                            local overhead = attach:FindFirstChild('AnimalOverhead')
                            if overhead then
                                local gen = overhead:FindFirstChild('Generation')
                                local nameLbl = overhead:FindFirstChild('DisplayName')
                                local rarityLbl = overhead:FindFirstChild('Rarity')
                                if gen and nameLbl and rarityLbl then
                                    local val = parseGenerationValue(gen.Text)
                                    if val then
                                        local position = podium:GetPivot().Position
                                        local closestBaseName, closestBaseCoord = nil, nil
                                        
                                        if myPlotName and myPlotName == plot.Name then
                                            closestBaseName = "My Base"
                                            closestBaseCoord = position
                                        else
                                            closestBaseName, closestBaseCoord = findClosestBaseTP(position)
                                        end
                                        
                                        table.insert(animalData, {
                                            model = podium,
                                            displayName = nameLbl.Text,
                                            rarity = rarityLbl.Text,
                                            generation = gen.Text,
                                            genValue = val,
                                            position = position,
                                            baseName = closestBaseName,
                                            basePosition = closestBaseCoord,
                                            plotName = plot.Name
                                        })
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        for _, obj in pairs(plot:GetDescendants()) do
            if obj.Name == 'OVERHEAD_ATTACHMENT' then
                local AnimalOverhead = obj:FindFirstChild('AnimalOverhead')
                if AnimalOverhead then
                    local DisplayName = AnimalOverhead:FindFirstChild('DisplayName')
                    local Generation = AnimalOverhead:FindFirstChild('Generation')
                    local Rarity = AnimalOverhead:FindFirstChild('Rarity')
                    if DisplayName and Generation and Rarity then
                        local genValue = parseGenerationValue(Generation.Text)
                        if genValue then
                            local model = obj:FindFirstAncestorOfClass('Model') or plot
                            local position = model:GetPivot().Position
                            local closestBaseName, closestBaseCoord = nil, nil
                            
                            if myPlotName and myPlotName == plot.Name then
                                closestBaseName = "My Base"
                                closestBaseCoord = position
                            else
                                closestBaseName, closestBaseCoord = findClosestBaseTP(position)
                            end
                            
                            table.insert(animalData, {
                                model = model,
                                displayName = DisplayName.Text,
                                generation = Generation.Text,
                                rarity = Rarity.Text,
                                genValue = genValue,
                                position = position,
                                baseName = closestBaseName,
                                basePosition = closestBaseCoord,
                                plotName = plot.Name
                            })
                        end
                    end
                end
            end
        end
    end

    if #animalData > 0 and not isStoppingTP then
        table.sort(animalData, function(a, b)
            return a.genValue > b.genValue
        end)

        local bestPet = animalData[1]
        return bestPet
    end

    return nil
end

local function flyUpFirstTP()
    if isStoppingTP then return end

    local char = LocalPlayer.Character
    if not char then return end

    equipFlyingCarpet()

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local startTime = tick()
    local targetHeight = 20
    while tick() - startTime < 2 and not isStoppingTP do
        local currentY = hrp.Position.Y
        if currentY < targetHeight then
            hrp.AssemblyLinearVelocity = Vector3.new(0, 90, 0)
        else
            break
        end
        task.wait(0.1)
    end
    
    if hrp.Position.Y < targetHeight then
        hrp.CFrame = CFrame.new(hrp.Position.X, targetHeight, hrp.Position.Z)
    end
    
    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    return true
end

local function teleportToPosition(position)
    if isStoppingTP then return false end

    local char = LocalPlayer.Character
    if not char then return false end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    local teleportHeight = math.max(position.Y + 5, 25)
    if position.Y < 0 then
        teleportHeight = position.Y + 3
    end
    
    local teleportPos = Vector3.new(position.X, teleportHeight, position.Z)
    
    local success = pcall(function()
        hrp.CFrame = CFrame.new(teleportPos)
    end)
    
    return success
end

local function cleanStopTP()
    isStoppingTP = true

    for name, conn in pairs(TpToBestConnections) do
        if conn then
            conn:Disconnect()
        end
    end

    TpToBestConnections = {}
    currentBestPetTP = nil
    
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        end
    end
    
    isStoppingTP = false
end

local function startTpToBest()
    cleanStopTP()
    
    isStoppingTP = false

    task.spawn(function()
        if not isStoppingTP then
            local flewUp = flyUpFirstTP()
            if flewUp then
                equipFlyingCarpet()
                
                currentBestPetTP = findMostExpensivePetTP()
                if currentBestPetTP and currentBestPetTP.basePosition then
                    teleportToPosition(currentBestPetTP.basePosition)
                end
            end
        end
    end)
end

local function TpToBest()
    TpToBestEnabled = true
    startTpToBest()
    
    task.spawn(function()
        task.wait(3)
        TpToBestEnabled = false
        cleanStopTP()
    end)
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TPToBestGUI"
screenGui.Parent = CoreGui
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.Size = UDim2.new(0, 250, 0, 120)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.Active = true
mainFrame.Draggable = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local titleBar = Instance.new("Frame")
titleBar.Parent = mainFrame
titleBar.Size = UDim2.new(1, 0, 0, 25)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = titleBar
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "TP TO BEST"
titleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 14

local contentFrame = Instance.new("Frame")
contentFrame.Parent = mainFrame
contentFrame.Size = UDim2.new(1, 0, 0, 1)
contentFrame.Position = UDim2.new(0, 0, 0, 25)
contentFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
contentFrame.BorderSizePixel = 0

local tpButton = Instance.new("TextButton")
tpButton.Parent = mainFrame
tpButton.Name = "TPButton"
tpButton.Size = UDim2.new(0.9, 0, 0, 35)
tpButton.Position = UDim2.new(0.05, 0, 0.3, 0)
tpButton.BackgroundColor3 = Color3.fromRGB(25, 40, 85)
tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButton.Text = "TP TO BEST"
tpButton.Font = Enum.Font.GothamBold
tpButton.TextSize = 12
tpButton.AutoButtonColor = false

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = tpButton

local buttonStroke = Instance.new("UIStroke")
buttonStroke.Color = Color3.fromRGB(40, 70, 150)
buttonStroke.Thickness = 1
buttonStroke.Parent = tpButton

local statusLabel = Instance.new("TextLabel")
statusLabel.Parent = mainFrame
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(0.9, 0, 0, 20)
statusLabel.Position = UDim2.new(0.05, 0, 0.7, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Click to teleport"
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 11
statusLabel.TextXAlignment = Enum.TextXAlignment.Left

tpButton.MouseEnter:Connect(function()
    game.TweenService:Create(tpButton, TweenInfo.new(0.2), {
        TextColor3 = Color3.fromRGB(220, 220, 220),
        BackgroundColor3 = Color3.fromRGB(35, 55, 110)
    }):Play()
end)

tpButton.MouseLeave:Connect(function()
    game.TweenService:Create(tpButton, TweenInfo.new(0.2), {
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundColor3 = Color3.fromRGB(25, 40, 85)
    }):Play()
end)

tpButton.MouseButton1Click:Connect(function()
    TpToBest()
    
    game.TweenService:Create(tpButton, TweenInfo.new(0.3), {
        TextColor3 = Color3.fromRGB(100, 255, 100),
        BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    }):Play()
    
    game.TweenService:Create(statusLabel, TweenInfo.new(0.3), {
        TextColor3 = Color3.fromRGB(220, 220, 220)
    }):Play()
    
    statusLabel.Text = "Teleporting..."
    
    task.spawn(function()
        task.wait(0.5)
        game.TweenService:Create(tpButton, TweenInfo.new(0.3), {
            TextColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundColor3 = Color3.fromRGB(25, 40, 85)
        }):Play()
        
        game.TweenService:Create(statusLabel, TweenInfo.new(0.3), {
            TextColor3 = Color3.fromRGB(150, 150, 150)
        }):Play()
        
        statusLabel.Text = "Ready"
    end)
end)

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        mainFrame.Draggable = true
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        mainFrame.Draggable = true
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input then
        mainFrame.Draggable = true
    end
end)
]],
})

table.insert(SCRIPTS, {
    name="ESP Best Brainrot", icon="👁️", desc="ESP • BEST ONLY • RADAR", isNew=true, kind="embed",
    code=[[
local CoreGui = game:GetService("CoreGui")

local Workspace = game:GetService("Workspace")

-- Estado global

getgenv().BestPetESP = getgenv().BestPetESP or {

    active = false,

    loop = nil,

    currentESP = nil

}

-- Parse valor (ex: "1.5K/s" -> 1500)

local function parseValue(text)

    text = tostring(text or ""):gsub("%s", "")

    local num, suffix = text:match("([%d%.]+)([KkMmBbTt]?)")

    if not num then return 0 end

    num = tonumber(num) or 0

    local multipliers = {K=1e3, M=1e6, B=1e9, T=1e12}

    local mult = multipliers[(suffix or ""):upper()] or 1

    return num * mult

end

-- Criar ESP Billboard

local function createESP(part, displayText, valueText)

    if getgenv().BestPetESP.currentESP then

        pcall(function() getgenv().BestPetESP.currentESP:Destroy() end)

    end

    

    if not part then 

        print("[ESP] âš ï¸ Part invÃ¡lido para criar ESP")

        return 

    end

    

    local bb = Instance.new("BillboardGui")

    bb.Name = "BestPetESP"

    bb.Size = UDim2.new(0, 200, 0, 50)

    bb.AlwaysOnTop = true

    bb.StudsOffset = Vector3.new(0, 3, 0)

    bb.Adornee = part

    bb.Parent = CoreGui

    

    local name = Instance.new("TextLabel", bb)

    name.Size = UDim2.new(1, 0, 0, 25)

    name.BackgroundTransparency = 1

    name.TextScaled = true

    name.Font = Enum.Font.GothamBold

    name.Text = displayText

    name.TextColor3 = Color3.fromRGB(255, 255, 0)

    name.TextStrokeTransparency = 0.5

    

    local value = Instance.new("TextLabel", bb)

    value.Size = UDim2.new(1, 0, 0, 25)

    value.Position = UDim2.new(0, 0, 0, 25)

    value.BackgroundTransparency = 1

    value.TextScaled = true

    value.Font = Enum.Font.GothamBold

    value.Text = valueText

    value.TextColor3 = Color3.fromRGB(0, 255, 100)

    value.TextStrokeTransparency = 0.5

    

    getgenv().BestPetESP.currentESP = bb

    print(string.format("[ESP] âœ… ESP criado: %s | %s", displayText, valueText))

end

-- Loop de detecÃ§Ã£o

local function startESP()

    if getgenv().BestPetESP.active then 

        print("[ESP] JÃ¡ estÃ¡ ativo!")

        return 

    end

    getgenv().BestPetESP.active = true

    print("[ESP] ðŸš€ Iniciado - Procurando todos FastOverheadTemplate em Debris")

    

    getgenv().BestPetESP.loop = task.spawn(function()

        while getgenv().BestPetESP.active do

            local debris = Workspace:FindFirstChild("Debris")

            if not debris then

                warn("[ESP] Debris nÃ£o encontrado no Workspace!")

                task.wait(0.5)

                continue

            end

            

            local bestPet = {value = -1, part = nil, text = "", display = "", template = nil}

            local templatesFound = 0

            

            -- Procura TODOS os FastOverheadTemplate dentro de Debris

            for _, template in ipairs(debris:GetChildren()) do

                if template.Name == "FastOverheadTemplate" then

                    templatesFound = templatesFound + 1

                    print(string.format("[ESP] ðŸ“¦ Template #%d encontrado", templatesFound))

                    

                    -- Procura SurfaceGui dentro do template

                    local surfaceGui = template:FindFirstChildOfClass("SurfaceGui")

                    if not surfaceGui then

                        print(string.format("[ESP] âš ï¸ Template #%d nÃ£o tem SurfaceGui", templatesFound))

                        continue

                    end

                    

                    print(string.format("[ESP] âœ… SurfaceGui encontrado no Template #%d", templatesFound))

                    

                    -- Procura Generation dentro do SurfaceGui (recursivo)

                    local genLabel = surfaceGui:FindFirstChild("Generation", true)

                    if not genLabel or not genLabel:IsA("TextLabel") then

                        print(string.format("[ESP] âš ï¸ Template #%d nÃ£o tem Generation TextLabel", templatesFound))

                        continue

                    end

                    

                    local text = genLabel.Text or ""

                    print(string.format("[ESP] ðŸ’° Template #%d | Generation: '%s'", templatesFound, text))

                    

                    -- Valida se tem valor

                    if text ~= "" and (text:find("/s") or text:find("K") or text:find("M") or text:find("B")) then

                        local val = parseValue(text)

                        print(string.format("[ESP] ðŸ“Š Template #%d | Valor: %.2f", templatesFound, val))

                        

                        if val > bestPet.value then

                            -- Pega o Adornee (parte 3D onde o GUI estÃ¡ anexado)

                            local targetPart = surfaceGui.Adornee

                            if targetPart and targetPart:IsA("BasePart") then

                                local displayName = surfaceGui:FindFirstChild("DisplayName", true)

                                bestPet = {

                                    part = targetPart,

                                    value = val,

                                    text = text,

                                    display = displayName and displayName.Text or "Pet",

                                    template = template

                                }

                                print(string.format("[ESP] ðŸŽ¯ NOVO BEST PET! Template #%d | %s | %.2f", templatesFound, bestPet.display, val))

                            else

                                print(string.format("[ESP] âš ï¸ Template #%d | SurfaceGui sem Adornee vÃ¡lido", templatesFound))

                            end

                        end

                    else

                        print(string.format("[ESP] âš ï¸ Template #%d | Generation sem formato vÃ¡lido", templatesFound))

                    end

                end

            end

            

            print(string.format("[ESP] ðŸ“‹ Scan completo: %d FastOverheadTemplate encontrados", templatesFound))

            

            -- Cria ESP no melhor pet

            if bestPet.part and bestPet.part.Parent then

                print(string.format("[ESP] ðŸ† MELHOR PET: %s (%s) com valor %.2f", bestPet.display, bestPet.text, bestPet.value))

                createESP(bestPet.part, bestPet.display, bestPet.text)

            else

                print("[ESP] âŒ Nenhum pet vÃ¡lido encontrado para ESP")

            end

            

            task.wait(0.5)

        end

        

        -- Limpa ESP ao parar

        if getgenv().BestPetESP.currentESP then

            pcall(function() getgenv().BestPetESP.currentESP:Destroy() end)

            getgenv().BestPetESP.currentESP = nil

        end

        print("[ESP] ðŸ›‘ Finalizado")

    end)

end

local function stopESP()

    getgenv().BestPetESP.active = false

    print("[ESP] ðŸ›‘ Parando...")

    

    if getgenv().BestPetESP.loop then

        task.cancel(getgenv().BestPetESP.loop)

    end

    if getgenv().BestPetESP.currentESP then

        pcall(function() getgenv().BestPetESP.currentESP:Destroy() end)

        getgenv().BestPetESP.currentESP = nil

    end

    

    print("[ESP] âœ… Desativado")

end

-- Remover GUI antiga

local old = CoreGui:FindFirstChild("SimplePetESP")

if old then old:Destroy() end

-- Criar GUI simples

local gui = Instance.new("ScreenGui")

gui.Name = "SimplePetESP"

gui.ResetOnSpawn = false

gui.Parent = CoreGui

local frame = Instance.new("Frame", gui)

frame.Size = UDim2.new(0, 200, 0, 80)

frame.Position = UDim2.new(0, 20, 0, 20)

frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

frame.BorderSizePixel = 0

frame.Active = true

-- Arrastar

local dragging, dragStart, startPos

frame.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = true

        dragStart = input.Position

        startPos = frame.Position

    end

end)

frame.InputChanged:Connect(function(input)

    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then

        local delta = input.Position - dragStart

        frame.Position = UDim2.new(

            startPos.X.Scale, startPos.X.Offset + delta.X,

            startPos.Y.Scale, startPos.Y.Offset + delta.Y

        )

    end

end)

frame.InputEnded:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = false

    end

end)

-- TÃ­tulo

local title = Instance.new("TextLabel", frame)

title.Size = UDim2.new(1, -10, 0, 25)

title.Position = UDim2.new(0, 5, 0, 5)

title.BackgroundTransparency = 1

title.Text = "Best Pet ESP"

title.TextColor3 = Color3.fromRGB(255, 255, 255)

title.Font = Enum.Font.GothamBold

title.TextSize = 16

-- BotÃ£o ON/OFF

local btn = Instance.new("TextButton", frame)

btn.Size = UDim2.new(1, -20, 0, 35)

btn.Position = UDim2.new(0, 10, 0, 35)

btn.Text = "LIGAR ESP"

btn.Font = Enum.Font.GothamBold

btn.TextSize = 18

btn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)

btn.TextColor3 = Color3.fromRGB(0, 0, 0)

btn.BorderSizePixel = 0

local corner = Instance.new("UICorner", btn)

corner.CornerRadius = UDim.new(0, 6)

btn.MouseButton1Click:Connect(function()

    if getgenv().BestPetESP.active then

        stopESP()

        btn.Text = "LIGAR ESP"

        btn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)

    else

        startESP()

        btn.Text = "DESLIGAR ESP"

        btn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)

    end

end)

-- Adicionar canto arredondado no frame

local frameCorner = Instance.new("UICorner", frame)

frameCorner.CornerRadius = UDim.new(0, 8)
]],
})

table.insert(SCRIPTS, {
    name="Auto Grab", icon="🤏", desc="AUTO STEAL • TP GRAB • EMPATHY", isNew=true, kind="embed",
    code=[[
--Deobf by prince the owner of azure hub buy there source <3
local stealCooldown = 0.2
local HOLD_DURATION = 0.5
local USE_TELEPORT = false

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local isTouch = UserInputService.TouchEnabled
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

local function refreshChar()
    character = player.Character or player.CharacterAdded:Wait()
    rootPart = character:WaitForChild("HumanoidRootPart")
end

player.CharacterAdded:Connect(function()
    task.wait(0.5)
    refreshChar()
end)

pcall(function()
    player.PlayerGui:FindFirstChild("Empathy Grabber"):Destroy()
end)

local gui = Instance.new("ScreenGui")
gui.Name = "EmpathyGrab"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- ────────────────────────────────────────────────
-- BLACK + GLOWING BLUE CYBER THEME
-- ────────────────────────────────────────────────
local BLACK = Color3.fromRGB(8, 10, 22)          -- deep cyber black
local BLUE  = Color3.fromRGB(0, 204, 255)        -- glowing cyan-blue
local GLOW  = Color3.fromRGB(0, 220, 255)        -- glow stroke

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.fromOffset(280, 170)
mainFrame.Position = UDim2.fromScale(0.5, 0.3)
mainFrame.AnchorPoint = Vector2.new(0.5, 0)
mainFrame.BackgroundColor3 = BLACK               -- black background
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.ClipsDescendants = true
mainFrame.Parent = gui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)

local stroke = Instance.new("UIStroke")
stroke.Color = BLUE
stroke.Thickness = 2.5
stroke.Transparency = 0.3
stroke.Parent = mainFrame

-- Pulsing border glow
task.spawn(function()
    while mainFrame.Parent do
        game:GetService("TweenService"):Create(stroke, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Transparency = 0.15
        }):Play()
        task.wait(2.5)
        game:GetService("TweenService"):Create(stroke, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Transparency = 0.55
        }):Play()
        task.wait(2.5)
    end
end)

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 16)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -75, 0.6, 0)
title.Position = UDim2.new(0, 15, 0, 2)
title.BackgroundTransparency = 1
title.Text = "Empathy Auto Grab"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = BLUE                          -- glowing blue
title.TextStrokeTransparency = 0.6
title.TextStrokeColor3 = GLOW
title.Parent = titleBar

-- Glow stroke for title
local titleGlow = Instance.new("UIStroke")
titleGlow.Thickness = 1.2
titleGlow.Color = GLOW
titleGlow.Transparency = 0.4
titleGlow.Parent = title

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -75, 0.4, 0)
subtitle.Position = UDim2.new(0, 15, 0.6, 0)
subtitle.BackgroundTransparency = 1
subtitle.Text = "made by hatred & empathy"
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 11
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.TextColor3 = BLUE                       -- glowing blue
subtitle.TextStrokeTransparency = 0.7
subtitle.TextStrokeColor3 = GLOW
subtitle.Parent = titleBar

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.fromOffset(32, 32)
minBtn.Position = UDim2.new(1, -40, 0.5, -16)
minBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
minBtn.Text = "−"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 20
minBtn.TextColor3 = BLUE                         -- glowing blue
minBtn.AutoButtonColor = false
minBtn.Parent = titleBar
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 8)

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -30, 1, -50)
content.Position = UDim2.new(0, 15, 0, 45)
content.BackgroundTransparency = 1
content.Parent = mainFrame

local toggleFrame = Instance.new("Frame")
toggleFrame.Size = UDim2.fromOffset(72, 34)
toggleFrame.Position = UDim2.new(0.5, -36, 0, 8)
toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 45, 55)
toggleFrame.BorderSizePixel = 0
toggleFrame.Parent = content
Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(1, 0)

local toggleSlider = Instance.new("Frame")
toggleSlider.Size = UDim2.fromOffset(30, 30)
toggleSlider.Position = UDim2.new(0, 2, 0.5, -15)
toggleSlider.BackgroundColor3 = Color3.fromRGB(90, 90, 95)
toggleSlider.BorderSizePixel = 0
toggleSlider.Parent = toggleFrame
Instance.new("UICorner", toggleSlider).CornerRadius = UDim.new(1, 0)

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, 0, 1, 0)
toggleBtn.BackgroundTransparency = 1
toggleBtn.Text = ""
toggleBtn.Parent = toggleFrame

local toggleLabel = Instance.new("TextLabel")
toggleLabel.Size = UDim2.new(1, -42, 1, 0)
toggleLabel.Position = UDim2.new(0, 42, 0, 0)
toggleLabel.BackgroundTransparency = 1
toggleLabel.Text = "OFF"
toggleLabel.Font = Enum.Font.GothamBold
toggleLabel.TextSize = 14
toggleLabel.TextColor3 = BLUE                    -- glowing blue
toggleLabel.TextStrokeTransparency = 0.7
toggleLabel.TextStrokeColor3 = GLOW
toggleLabel.Parent = toggleFrame

local progContainer = Instance.new("Frame")
progContainer.Size = UDim2.new(0.9, 0, 0, 14)
progContainer.Position = UDim2.new(0.05, 0, 0, 52)
progContainer.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
progContainer.BorderSizePixel = 0
progContainer.Parent = content
Instance.new("UICorner", progContainer).CornerRadius = UDim.new(1, 0)

local progFill = Instance.new("Frame")
progFill.Size = UDim2.new(0, 0, 1, 0)
progFill.BackgroundColor3 = BLUE                 -- blue progress bar
progFill.BorderSizePixel = 0
progFill.Parent = progContainer
Instance.new("UICorner", progFill).CornerRadius = UDim.new(1, 0)

local progText = Instance.new("TextLabel")
progText.Size = UDim2.new(0, 60, 0, 22)
progText.Position = UDim2.new(0.5, -30, 0, 70)
progText.BackgroundTransparency = 1
progText.Text = "0%"
progText.Font = Enum.Font.GothamBold
progText.TextSize = 15
progText.TextColor3 = BLUE                       -- glowing blue
progText.TextStrokeTransparency = 0.7
progText.TextStrokeColor3 = GLOW
progText.Parent = content

local discordBtn = Instance.new("TextButton")
discordBtn.Size = UDim2.fromOffset(200, 34)
discordBtn.Position = UDim2.new(0.5, -100, 0, 102)
discordBtn.BackgroundColor3 = BLUE               -- blue button
discordBtn.Text = "Join The Discord"
discordBtn.Font = Enum.Font.GothamBold
discordBtn.TextSize = 14
discordBtn.TextColor3 = BLACK
discordBtn.AutoButtonColor = false
discordBtn.Parent = content
Instance.new("UICorner", discordBtn).CornerRadius = UDim.new(0, 8)

-- Glowing stroke for discord button text
local discGlow = Instance.new("UIStroke")
discGlow.Thickness = 1.2
discGlow.Color = GLOW
discGlow.Transparency = 0.4
discGlow.Parent = discordBtn

-- ────────────────────────────────────────────────
-- BLUE FLOATING PARTICLES (cyber aesthetic)
-- ────────────────────────────────────────────────
for i = 1, 12 do
    local p = Instance.new("TextLabel")
    p.Parent = mainFrame
    p.BackgroundTransparency = 1
    p.Text = "●"
    p.TextColor3 = BLUE
    p.TextTransparency = 0.5 + math.random() * 0.3
    p.Font = Enum.Font.SourceSansBold
    p.TextSize = 10 + math.random(4, 12)
    p.Size = UDim2.new(0, p.TextSize, 0, p.TextSize)
    p.Position = UDim2.new(math.random(), 0, math.random(), 0)
    p.ZIndex = 0

    task.spawn(function()
        local ox = p.Position.X.Scale
        local oy = p.Position.Y.Scale
        local phase = math.random() * math.pi * 2
        while p.Parent do
            local t = tick() * 0.4 + phase
            p.Position = UDim2.new(
                math.clamp(ox + math.sin(t * 0.8) * 0.06, 0.02, 0.98),
                0,
                math.clamp(oy + math.cos(t * 0.65) * 0.07, 0.05, 0.95),
                0
            )
            p.TextTransparency = 0.4 + math.sin(t * 3.5) * 0.35
            task.wait(0.05)
        end
    end)
end

local minimized = false
local enabled = false
_G.IsGrabbing = false
local progress = 0
local speed = 1.35
local HRP = rootPart
local dragging = false
local dragStart = nil
local startPos = nil

local function startDrag(input)
    dragging = true
    dragStart = input.Position
    startPos = mainFrame.Position
end

local function updateDrag(input)
    if dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end

local function stopDrag()
    dragging = false
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or (isTouch and input.UserInputType == Enum.UserInputType.Touch) then
        startDrag(input)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or (isTouch and input.UserInputType == Enum.UserInputType.Touch)) then
        updateDrag(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or (isTouch and input.UserInputType == Enum.UserInputType.Touch) then
        stopDrag()
    end
end)

local function toggleMinimize()
    minimized = not minimized
    if minimized then
        mainFrame:TweenSize(UDim2.fromOffset(280, 40), "Out", "Quad", 0.25, true)
        content.Visible = false
        minBtn.Text = "+"
    else
        mainFrame:TweenSize(UDim2.fromOffset(280, 170), "Out", "Quad", 0.25, true)
        content.Visible = true
        minBtn.Text = "−"
    end
end

minBtn.Activated:Connect(toggleMinimize)

local function toggle()
    enabled = not enabled
    if enabled then
        toggleSlider:TweenPosition(UDim2.new(1, -32, 0.5, -15), "Out", "Quad", 0.2, true)
        toggleSlider.BackgroundColor3 = BLUE
        toggleFrame.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
        toggleLabel.Text = "ON"
        toggleLabel.TextColor3 = BLUE
    else
        toggleSlider:TweenPosition(UDim2.new(0, 2, 0.5, -15), "Out", "Quad", 0.2, true)
        toggleSlider.BackgroundColor3 = Color3.fromRGB(90, 90, 95)
        toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 45, 55)
        toggleLabel.Text = "OFF"
        toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

toggleBtn.Activated:Connect(toggle)

local function updateProgress()
    if enabled then
        progress = progress + speed
        if progress > 100 then progress = 1 end
    else
        if progress > 0 then
            progress = progress - (speed * 2.6)
            if progress < 0 then progress = 0 end
        end
    end
    progFill.Size = UDim2.new(progress / 100, 0, 1, 0)
    progText.Text = string.format("%.0f%%", progress)
end

RunService.RenderStepped:Connect(updateProgress)

local function getPos(prompt)
    local p = prompt.Parent
    if p:IsA("BasePart") then return p.Position end
    if p:IsA("Model") then
        local prim = p.PrimaryPart or p:FindFirstChildWhichIsA("BasePart")
        return prim and prim.Position
    end
    if p:IsA("Attachment") then return p.WorldPosition end
    local part = p:FindFirstChildWhichIsA("BasePart", true)
    return part and part.Position
end

task.spawn(function()
    while task.wait(0.08) do
        if not enabled or _G.IsGrabbing then continue end
        local root = HRP or rootPart
        if not root then continue end
        
        local plots = Workspace:FindFirstChild("Plots")
        if not plots then continue end
        
        local nearest = nil
        local minDist = math.huge
        local myPos = root.Position
        
        for _, plot in ipairs(plots:GetChildren()) do
            for _, obj in ipairs(plot:GetDescendants()) do
                if obj:IsA("ProximityPrompt") and obj.Enabled and obj.ActionText == "Steal" then
                    local pos = getPos(obj)
                    if pos then
                        local dist = (myPos - pos).Magnitude
                        if dist <= obj.MaxActivationDistance and dist < minDist then
                            minDist = dist
                            nearest = obj
                        end
                    end
                end
            end
        end
        
        if nearest then
            _G.IsGrabbing = true
            pcall(function() fireproximityprompt(nearest, 1000) end)
            
            task.spawn(function()
                pcall(function()
                    nearest:InputHoldBegin()
                    task.wait(0.12)
                    nearest:InputHoldEnd()
                end)
                task.wait(1.4)
                _G.IsGrabbing = false
            end)
        end
    end
end)

discordBtn.Activated:Connect(function()
    setclipboard("https://discord.gg/NGEMSasjjG")
    local old = discordBtn.Text
    discordBtn.Text = "✅ Copied!"
    discordBtn.BackgroundColor3 = Color3.fromRGB(60, 255, 60)
    task.wait(1.6)
    discordBtn.Text = old
    discordBtn.BackgroundColor3 = BLUE
end)

mainFrame.BackgroundTransparency = 1
for i = 1, 12 do
    mainFrame.BackgroundTransparency = 1 - i/12
    task.wait(0.015)
end

local help = Instance.new("TextLabel")
help.Size = UDim2.fromOffset(340, 28)
help.Position = UDim2.fromScale(0.5, 0.93)
help.AnchorPoint = Vector2.new(0.5, 1)
help.BackgroundTransparency = 1
help.Text = "👆 Tap switch • Join Discord • Drag title bar"
help.Font = Enum.Font.GothamBold
help.TextSize = 13
help.TextColor3 = BLUE
help.TextStrokeTransparency = 0.6
help.Parent = gui
task.delay(4.8, function() help:Destroy() end)
]],
})

table.insert(SCRIPTS, {
    name="Drop Brainrot", icon="💧", desc="DROP • FLOAT • BRAINROT", isNew=false, kind="embed",
    code=[[
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character
local hrp

local function setupCharacter(char)
    character = char
    hrp = character:WaitForChild("HumanoidRootPart")
end

if player.Character then setupCharacter(player.Character) end
player.CharacterAdded:Connect(setupCharacter)

-- ═══════════════════════════════════════════════════════
-- DROP BRAINROT SYSTEM (EXACT FROM KAWATAN HUB)
-- ═══════════════════════════════════════════════════════

local dropBusy = false
local FLOAT_DROP_HEIGHT = 20
local floatConn = nil

local function doDrop()
    if dropBusy or not hrp then return end
    dropBusy = true
    
    if floatConn then floatConn:Disconnect() floatConn = nil end
    
    local origY = hrp.Position.Y
    local targetY = origY + FLOAT_DROP_HEIGHT
    
    floatConn = RunService.Heartbeat:Connect(function()
        if not hrp then return end
        
        local diff = targetY - hrp.Position.Y
        
        hrp.AssemblyLinearVelocity = Vector3.new(
            hrp.AssemblyLinearVelocity.X,
            math.clamp(diff * 25, -300, 300),
            hrp.AssemblyLinearVelocity.Z
        )
        
        if hrp.Position.Y >= targetY - 1 then
            hrp.AssemblyLinearVelocity = Vector3.new(
                hrp.AssemblyLinearVelocity.X,
                0,
                hrp.AssemblyLinearVelocity.Z
            )
            floatConn:Disconnect()
            floatConn = nil
            dropBusy = false

            -- Watch for landing then fully heal
            local landConn
            landConn = RunService.Heartbeat:Connect(function()
                if not hrp then landConn:Disconnect() return end
                if math.abs(hrp.AssemblyLinearVelocity.Y) < 2 then
                    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid.Health = humanoid.MaxHealth
                    end
                    landConn:Disconnect()
                end
            end)
        end
    end)
end

-- ═══════════════════════════════════════════════════════
-- DROP BRAINROT TOGGLE SYSTEM
-- ═══════════════════════════════════════════════════════

local DropBrainrotEnabled = false
local dropBrainrotLoop = nil

local function startDropBrainrot()
    if dropBrainrotLoop then return end
    
    dropBrainrotLoop = task.spawn(function()
        while DropBrainrotEnabled do
            if not dropBusy and hrp then
                doDrop()
            end
            task.wait(5)
        end
    end)
end

local function stopDropBrainrot()
    if dropBrainrotLoop then
        task.cancel(dropBrainrotLoop)
        dropBrainrotLoop = nil
    end
    if floatConn then
        floatConn:Disconnect()
        floatConn = nil
    end
    if hrp then
        hrp.AssemblyLinearVelocity = Vector3.new(
            hrp.AssemblyLinearVelocity.X,
            0,
            hrp.AssemblyLinearVelocity.Z
        )
    end
    dropBusy = false
end

-- ═══════════════════════════════════════════════════════
-- SMALL GUI
-- ═══════════════════════════════════════════════════════

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DropBrainrotGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

local SmallDropGUI = Instance.new("Frame")
SmallDropGUI.Name = "SmallDropBrainrotGUI"
SmallDropGUI.Size = UDim2.new(0, 160, 0, 40)
SmallDropGUI.Position = UDim2.new(0.5, -80, 0.3, 0)
SmallDropGUI.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SmallDropGUI.BackgroundTransparency = 0.3
SmallDropGUI.BorderSizePixel = 0
SmallDropGUI.Active = true
SmallDropGUI.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = SmallDropGUI

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(138, 43, 226)
Stroke.Thickness = 2
Stroke.Parent = SmallDropGUI

-- Green/Gray Dot
local GreenDot = Instance.new("Frame")
GreenDot.Size = UDim2.new(0, 14, 0, 14)
GreenDot.Position = UDim2.new(0, 10, 0.5, -7)
GreenDot.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
GreenDot.BorderSizePixel = 0
GreenDot.Parent = SmallDropGUI

local DotCorner = Instance.new("UICorner")
DotCorner.CornerRadius = UDim.new(1, 0)
DotCorner.Parent = GreenDot

-- Label
local Label = Instance.new("TextLabel")
Label.Size = UDim2.new(1, -75, 1, 0)
Label.Position = UDim2.new(0, 30, 0, 0)
Label.BackgroundTransparency = 1
Label.Text = "Drop Brainrot"
Label.TextColor3 = Color3.fromRGB(255, 255, 255)
Label.Font = Enum.Font.GothamBold
Label.TextSize = 12
Label.TextXAlignment = Enum.TextXAlignment.Left
Label.Parent = SmallDropGUI

-- Toggle Button (⚡ on right side)
local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 45, 1, 0)
Button.Position = UDim2.new(1, -45, 0, 0)
Button.BackgroundTransparency = 1
Button.Text = "⚡"
Button.TextColor3 = Color3.fromRGB(138, 43, 226)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 18
Button.ZIndex = 2
Button.Parent = SmallDropGUI

-- ═══════════════════════════════════════════════════════
-- SMOOTH DRAG SYSTEM
-- ═══════════════════════════════════════════════════════

local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil
local targetX = SmallDropGUI.Position.X.Offset
local targetY = SmallDropGUI.Position.Y.Offset
local currentX = targetX
local currentY = targetY

RunService.RenderStepped:Connect(function()
    currentX = currentX + (targetX - currentX) * 0.18
    currentY = currentY + (targetY - currentY) * 0.18
    SmallDropGUI.Position = UDim2.new(
        SmallDropGUI.Position.X.Scale, math.round(currentX),
        SmallDropGUI.Position.Y.Scale, math.round(currentY)
    )
end)

SmallDropGUI.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = SmallDropGUI.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

SmallDropGUI.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        targetX = startPos.X.Offset + delta.X
        targetY = startPos.Y.Offset + delta.Y
    end
end)

-- Toggle Logic
Button.MouseButton1Click:Connect(function()
    DropBrainrotEnabled = not DropBrainrotEnabled
    
    if DropBrainrotEnabled then
        SmallDropGUI.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        GreenDot.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        startDropBrainrot()
        print("[DROP BRAINROT] ✅ ON - Auto-dropping every 5 seconds")
    else
        SmallDropGUI.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        GreenDot.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        stopDropBrainrot()
        print("[DROP BRAINROT] ⚪ OFF")
    end
end)
]],
})

table.insert(SCRIPTS, {
    name="Drop No Jump", icon="⬇️", desc="DROP • NO JUMP • TOGGLE", isNew=false, kind="embed",
    code=[[
--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

--// Variables
local dropEnabled = false
local _wfConns = {}

--// Core Logic Function
local function toggleDrop(state)
    dropEnabled = state
    
    if dropEnabled then
        -- Connection 1: Disable collisions for others locally
        local colConn = RunService.Stepped:Connect(function()
            if not dropEnabled then return end
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player and p.Character then
                    for _, part in ipairs(p.Character:GetChildren()) do
                        if part:IsA("BasePart") then 
                            part.CanCollide = false 
                        end
                    end
                end
            end
        end)
        table.insert(_wfConns, colConn)

        -- Connection 2: Velocity Spike Loop
        task.spawn(function()
            while dropEnabled do
                RunService.Heartbeat:Wait()
                local c = player.Character
                local root = c and c:FindFirstChild("HumanoidRootPart")
                
                if not root then continue end
                
                local vel = root.Velocity
                -- The "Fling" calculation
                root.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
                
                RunService.RenderStepped:Wait()
                if root and root.Parent then root.Velocity = vel end
                
                RunService.Stepped:Wait()
                if root and root.Parent then 
                    root.Velocity = vel + Vector3.new(0, 0.1, 0) 
                end
            end
        end)
    else
        -- Cleanup
        for _, c in ipairs(_wfConns) do
            if typeof(c) == "RBXScriptConnection" then c:Disconnect() end
        end
        _wfConns = {}
    end
end

--// GUI Creation
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Name = "DropToggleGui"
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60) -- Initial Red
ToggleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleButton.Size = UDim2.new(0, 120, 0, 40)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "DROP: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14.000

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = ToggleButton

--// Button Functionality
ToggleButton.MouseButton1Click:Connect(function()
    dropEnabled = not dropEnabled
    toggleDrop(dropEnabled)
    
    if dropEnabled then
        ToggleButton.Text = "DROP: ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 255, 60) -- Green
    else
        ToggleButton.Text = "DROP: OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60) -- Red
    end
end)

--// Make GUI Draggable
local dragging, dragInput, dragStart, startPos

ToggleButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = ToggleButton.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

ToggleButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
]],
})

table.insert(SCRIPTS, {
    name="Anti Ragdoll", icon="🛡️", desc="ANTI KNOCKBACK • TOGGLE", isNew=false, kind="embed",
    code=[[
-- Anti Knockback System
-- discord.gg/titanzhub

local function setupAntiKnockback()
    local isEnabled = false
    local connections = {}
    
    local function shouldApplyAntiKnockback(humanoid)
        local state = humanoid:GetState()
        local knockoutStates = {
            [Enum.HumanoidStateType.Physics] = true,
            [Enum.HumanoidStateType.Ragdoll] = true,
            [Enum.HumanoidStateType.FallingDown] = true,
            [Enum.HumanoidStateType.GettingUp] = true
        }
        
        return not knockoutStates[state]
    end
    
    local function enableControls(player)
        pcall(function()
            local playerScripts = player:WaitForChild("PlayerScripts")
            local playerModule = playerScripts:WaitForChild("PlayerModule")
            require(playerModule):GetControls():Enable()
        end)
    end
    
    local function cleanCharacter(character, cleanBodyMovers)
        -- Remove constraints that cause knockback
        for _, descendant in pairs(character:GetDescendants()) do
            if descendant:IsA("BallSocketConstraint") or 
               descendant:IsA("NoCollisionConstraint") or 
               descendant:IsA("HingeConstraint") or
               (descendant:IsA("Attachment") and (descendant.Name == "A" or descendant.Name == "B")) then
                descendant:Destroy()
            elseif cleanBodyMovers and (descendant:IsA("BodyVelocity") or 
                   descendant:IsA("BodyPosition") or 
                   descendant:IsA("BodyGyro")) then
                descendant:Destroy()
            end
        end
        
        -- Re-enable Motor6D joints
        for _, descendant in pairs(character:GetDescendants()) do
            if descendant:IsA("Motor6D") then
                descendant.Enabled = true
            end
        end
    end
    
    local function stopKnockbackAnimations(animator)
        for _, track in pairs(animator:GetPlayingAnimationTracks()) do
            if track.Animation then
                local animName = track.Animation.Name:lower()
                if animName:find("rag") or animName:find("fall") or 
                   animName:find("hurt") or animName:find("down") or
                   animName:find("knock") or animName:find("stun") then
                    track:Stop(0)
                end
            end
        end
    end
    
    local function enableAntiKnockback()
        if isEnabled then return end
        
        isEnabled = true
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Workspace = game:GetService("Workspace")
        local RunService = game:GetService("RunService")
        local localPlayer = Players.LocalPlayer
        
        -- Wait for character
        local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local camera = Workspace.CurrentCamera
        local animator = humanoid:WaitForChild("Animator")
        
        -- Anti knockback settings
        local velocityChangeThreshold = 40
        local minVelocityMagnitude = 25
        local maxVelocityMagnitude = 15
        local cleanBodyMovers = true
        local lastVelocity = Vector3.new(0, 0, 0)
        
        -- Handle state changes
        table.insert(connections, humanoid.StateChanged:Connect(function(oldState, newState)
            if shouldApplyAntiKnockback(humanoid) then
                humanoid:ChangeState(Enum.HumanoidStateType.Running)
                cleanCharacter(character, cleanBodyMovers)
                stopKnockbackAnimations(animator)
                camera.CameraSubject = humanoid
                enableControls(localPlayer)
            end
        end))
        
        -- Intercept knockback impulses
        pcall(function()
            -- Try to find and connect to knockback events
            if ReplicatedStorage:FindFirstChild("Packages") then
                local packages = ReplicatedStorage.Packages
                if packages:FindFirstChild("Net") then
                    local net = packages.Net
                    if net:FindFirstChild("RE/CombatService/ApplyImpulse") then
                        table.insert(connections, net["RE/CombatService/ApplyImpulse"].OnClientEvent:Connect(function()
                            if shouldApplyAntiKnockback(humanoid) then
                                humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                            end
                        end))
                    end
                end
            end
        end)
        
        -- Handle new descendants added to character
        table.insert(connections, character.DescendantAdded:Connect(function(descendant)
            if shouldApplyAntiKnockback(humanoid) then
                cleanCharacter(character, cleanBodyMovers)
                stopKnockbackAnimations(animator)
            end
        end))
        
        -- Main anti knockback loop
        table.insert(connections, RunService.Heartbeat:Connect(function()
            if shouldApplyAntiKnockback(humanoid) then
                -- Clean character
                cleanCharacter(character, cleanBodyMovers)
                stopKnockbackAnimations(animator)
                
                -- Limit velocity to prevent knockback
                local currentVelocity = humanoidRootPart.AssemblyLinearVelocity
                
                -- Check if velocity change is sudden (knockback)
                local velocityChange = (currentVelocity - lastVelocity).Magnitude
                
                if velocityChange > velocityChangeThreshold and currentVelocity.Magnitude > minVelocityMagnitude then
                    -- Apply velocity limiting
                    local limitedVelocity = currentVelocity.Unit * math.min(currentVelocity.Magnitude, maxVelocityMagnitude)
                    humanoidRootPart.AssemblyLinearVelocity = limitedVelocity
                end
                
                lastVelocity = currentVelocity
            end
        end))
        
        -- Initial setup
        enableControls(localPlayer)
        cleanCharacter(character, cleanBodyMovers)
        stopKnockbackAnimations(animator)
        
        -- Handle character respawns
        table.insert(connections, localPlayer.CharacterAdded:Connect(function(newCharacter)
            character = newCharacter
            humanoid = newCharacter:WaitForChild("Humanoid")
            humanoidRootPart = newCharacter:WaitForChild("HumanoidRootPart")
            animator = humanoid:WaitForChild("Animator")
            lastVelocity = Vector3.new(0, 0, 0)
            
            enableControls(localPlayer)
            cleanCharacter(newCharacter, cleanBodyMovers)
            stopKnockbackAnimations(animator)
        end))
    end
    
    local function disableAntiKnockback()
        if not isEnabled then return end
        
        isEnabled = false
        
        -- Disconnect all connections
        for _, connection in pairs(connections) do
            if connection then
                connection:Disconnect()
            end
        end
        
        connections = {}
    end
    
    return {
        Enable = enableAntiKnockback,
        Disable = disableAntiKnockback,
        IsEnabled = function() return isEnabled end
    }
end

-- Usage example:
-- local antiKnockback = setupAntiKnockback()
-- 
-- -- To enable:
-- antiKnockback.Enable()
-- 
-- -- To disable:
-- antiKnockback.Disable()
-- 
-- -- To check if enabled:
-- print(antiKnockback.IsEnabled())
]],
})

table.insert(SCRIPTS, {
    name="Semi Invisible", icon="👻", desc="SEMI • INVISIBLE • TOGGLE", isNew=true, kind="embed",
    code=[[
local connections = {
    SemiInvisible = {}
}

local isInvisible = false
local clone, oldRoot, hip, animTrack, connection, characterConnection

local function semiInvisibleFunction()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local LocalPlayer = Players.LocalPlayer

    local DEPTH_OFFSET = 0.09  

    local function removeFolders()  
        local playerName = LocalPlayer.Name  
        local playerFolder = Workspace:FindFirstChild(playerName)  
        if not playerFolder then  
            return  
        end  

        local doubleRig = playerFolder:FindFirstChild("DoubleRig")  
        if doubleRig then  
            doubleRig:Destroy()  
        end  

        local constraints = playerFolder:FindFirstChild("Constraints")  
        if constraints then  
            constraints:Destroy()  
        end  

        local childAddedConn = playerFolder.ChildAdded:Connect(function(child)  
            if child.Name == "DoubleRig" or child.Name == "Constraints" then  
                child:Destroy()  
            end  
        end)  
        table.insert(connections.SemiInvisible, childAddedConn)  
    end  

    local function doClone()  
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Health > 0 then  
            hip = LocalPlayer.Character.Humanoid.HipHeight  
            oldRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")  
            if not oldRoot or not oldRoot.Parent then  
                return false  
            end  

            local tempParent = Instance.new("Model")  
            tempParent.Parent = game  
            LocalPlayer.Character.Parent = tempParent  

            clone = oldRoot:Clone()  
            clone.Parent = LocalPlayer.Character  
            oldRoot.Parent = game.Workspace.CurrentCamera  
            clone.CFrame = oldRoot.CFrame  

            LocalPlayer.Character.PrimaryPart = clone  
            LocalPlayer.Character.Parent = game.Workspace  

            for _, v in pairs(LocalPlayer.Character:GetDescendants()) do  
                if v:IsA("Weld") or v:IsA("Motor6D") then  
                    if v.Part0 == oldRoot then  
                        v.Part0 = clone  
                    end  
                    if v.Part1 == oldRoot then  
                        v.Part1 = clone  
                    end  
                end  
            end  

            tempParent:Destroy()  
            return true  
        end  
        return false  
    end  

    local function revertClone()  
        if not oldRoot or not oldRoot:IsDescendantOf(game.Workspace) or not LocalPlayer.Character or LocalPlayer.Character.Humanoid.Health <= 0 then  
            return false  
        end  

        local tempParent = Instance.new("Model")  
        tempParent.Parent = game  
        LocalPlayer.Character.Parent = tempParent  

        oldRoot.Parent = LocalPlayer.Character  
        LocalPlayer.Character.PrimaryPart = oldRoot  
        LocalPlayer.Character.Parent = game.Workspace  
        oldRoot.CanCollide = true  

        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do  
            if v:IsA("Weld") or v:IsA("Motor6D") then  
                if v.Part0 == clone then  
                    v.Part0 = oldRoot  
                end  
                if v.Part1 == clone then  
                    v.Part1 = oldRoot  
                end  
            end  
        end  

        if clone then  
            local oldPos = clone.CFrame  
            clone:Destroy()  
            clone = nil  
            oldRoot.CFrame = oldPos  
        end  

        oldRoot = nil  
        if LocalPlayer.Character and LocalPlayer.Character.Humanoid then  
            LocalPlayer.Character.Humanoid.HipHeight = hip  
        end  
    end  

    local function animationTrickery()  
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Health > 0 then  
            local anim = Instance.new("Animation")  
            anim.AnimationId = "http://www.roblox.com/asset/?id=18537363391"  
            local humanoid = LocalPlayer.Character.Humanoid  
            local animator = humanoid:FindFirstChild("Animator") or Instance.new("Animator", humanoid)  
            animTrack = animator:LoadAnimation(anim)  
            animTrack.Priority = Enum.AnimationPriority.Action4  
            animTrack:Play(0, 1, 0)  
            anim:Destroy()  

            local animStoppedConn = animTrack.Stopped:Connect(function()  
                if isInvisible then  
                    animationTrickery()  
                end  
            end)  
            table.insert(connections.SemiInvisible, animStoppedConn)  

            task.delay(0, function()  
                animTrack.TimePosition = 0.7  
                task.delay(1, function()  
                    animTrack:AdjustSpeed(math.huge)  
                end)  
            end)  
        end  
    end  

    local function enableInvisibility()  
        if not LocalPlayer.Character or LocalPlayer.Character.Humanoid.Health <= 0 then  
            return false
        end  

        removeFolders()  
        local success = doClone()  
        if success then  
            task.wait(0.1)  
            animationTrickery()  
            connection = RunService.PreSimulation:Connect(function(dt)  
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Health > 0 and oldRoot then  
                    local root = LocalPlayer.Character.PrimaryPart or LocalPlayer.Character:FindFirstChild("HumanoidRootPart")  
                    if root then  
                        local cf = root.CFrame - Vector3.new(0, LocalPlayer.Character.Humanoid.HipHeight + (root.Size.Y / 2) - 1 + DEPTH_OFFSET, 0)  
                        oldRoot.CFrame = cf * CFrame.Angles(math.rad(180), 0, 0)  
                        oldRoot.Velocity = root.Velocity  
                        oldRoot.CanCollide = false  
                    end  
                end  
            end)  
            table.insert(connections.SemiInvisible, connection)  

            characterConnection = LocalPlayer.CharacterAdded:Connect(function(newChar)
                if isInvisible then
                    if animTrack then  
                        animTrack:Stop()  
                        animTrack:Destroy()  
                        animTrack = nil  
                    end  
                    if connection then connection:Disconnect() end  
                    revertClone()
                    removeFolders()
                    isInvisible = false
                    
                    for _, conn in ipairs(connections.SemiInvisible) do  
                        if conn then conn:Disconnect() end  
                    end  
                    connections.SemiInvisible = {}
                end
            end)
            table.insert(connections.SemiInvisible, characterConnection)
            
            return true
        end  
        return false
    end  

    local function disableInvisibility()  
        if animTrack then  
            animTrack:Stop()  
            animTrack:Destroy()  
            animTrack = nil  
        end  
        if connection then connection:Disconnect() end  
        if characterConnection then characterConnection:Disconnect() end  
        revertClone()  
        removeFolders()  
    end

    local function setupGodmode()  
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()  
        local hum = char:WaitForChild("Humanoid")  
        local mt = getrawmetatable(game)  
        local oldNC = mt.__namecall  
        local oldNI = mt.__newindex  

        setreadonly(mt, false)  

        mt.__namecall = newcclosure(function(self, ...)  
            local m = getnamecallmethod()  
            if self == hum then  
                if m == "ChangeState" and select(1, ...) == Enum.HumanoidStateType.Dead then  
                    return
                end
                if m == "SetStateEnabled" then
                    local st, en = ...
                    if st == Enum.HumanoidStateType.Dead and en == true then
                        return
                    end
                end
                if m == "Destroy" then
                    return
                end
            end

            if self == char and m == "BreakJoints" then  
                return  
            end  

            return oldNC(self, ...)  
        end)  

        mt.__newindex = newcclosure(function(self, k, v)  
            if self == hum then  
                if k == "Health" and type(v) == "number" and v <= 0 then  
                    return  
                end  
                if k == "MaxHealth" and type(v) == "number" and v < hum.MaxHealth then  
                    return  
                end  
                if k == "BreakJointsOnDeath" and v == true then  
                    return  
                end  
                if k == "Parent" and v == nil then  
                    return  
                end  
            end  

            return oldNI(self, k, v)  
        end)  

        setreadonly(mt, true)  
    end  

    if not isInvisible then
        removeFolders()  
        setupGodmode()  
        if enableInvisibility() then
            isInvisible = true
        end
    else
        disableInvisibility()
        isInvisible = false
        
        pcall(function()  
            local oldGui = LocalPlayer.PlayerGui:FindFirstChild("InvisibleGui")  
            if oldGui then oldGui:Destroy() end  
        end)  
        for _, conn in ipairs(connections.SemiInvisible) do  
            if conn then conn:Disconnect() end  
        end  
        connections.SemiInvisible = {}  
    end
end

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.F and not gameProcessed then
        semiInvisibleFunction()
    end
end)
]],
})

table.insert(SCRIPTS, {
    name="Sentry Destroy", icon="💥", desc="SENTRY • DESTROY • FRONT", isNew=true, kind="embed",
    code=[[
local Players = game:GetService("Players") local Workspace = game:GetService("Workspace") local ReplicatedStorage = game:GetService("ReplicatedStorage") local TweenService = game:GetService("TweenService")  local LocalPlayer = Players.LocalPlayer  local ScreenGui = Instance.new("ScreenGui") ScreenGui.Name = "SilentHub" ScreenGui.ResetOnSpawn = false ScreenGui.IgnoreGuiInset = true ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")  local Frame = Instance.new("Frame") Frame.Size = UDim2.new(0, 270, 0, 150) Frame.Position = UDim2.new(0.35, 0, 0.35, 0) Frame.BackgroundColor3 = Color3.fromRGB(10, 0, 20) Frame.BorderSizePixel = 0 Frame.Active = true Frame.Draggable = true Frame.ClipsDescendants = true Frame.Parent = ScreenGui  local UICorner = Instance.new("UICorner", Frame) UICorner.CornerRadius = UDim.new(0, 14)  local function createGlow(parent, sizeScale, transparency) 	local glow = Instance.new("ImageLabel") 	glow.AnchorPoint = Vector2.new(0.5, 0.5) 	glow.Position = UDim2.new(0.5, 0, 0.5, 0) 	glow.Size = UDim2.new(sizeScale, sizeScale, sizeScale, sizeScale) 	glow.BackgroundTransparency = 1 	glow.Image = "rbxassetid://5028857084" 	glow.ImageColor3 = Color3.fromRGB(180, 0, 255) 	glow.ImageTransparency = transparency 	glow.ScaleType = Enum.ScaleType.Slice 	glow.SliceCenter = Rect.new(24, 24, 276, 276) 	glow.ZIndex = 0 	glow.Parent = parent 	return glow end  local glowBig = createGlow(Frame, 1.8, 0.55) local glowMedium = createGlow(Frame, 1.5, 0.45) local glowSmall = createGlow(Frame, 1.2, 0.35)  local Title = Instance.new("TextLabel", Frame) Title.Text = "SilentHub 💀" Title.Size = UDim2.new(1, 0, 0, 40) Title.BackgroundColor3 = Color3.fromRGB(25, 0, 50) Title.BorderSizePixel = 0 Title.Font = Enum.Font.GothamBlack Title.TextColor3 = Color3.fromRGB(200, 0, 255) Title.TextStrokeTransparency = 0.8 Title.TextStrokeColor3 = Color3.fromRGB(255, 255, 255) Title.TextSize = 20  local TitleCorner = Instance.new("UICorner", Title) TitleCorner.CornerRadius = UDim.new(0, 14)  local Underline = Instance.new("Frame", Frame) Underline.Size = UDim2.new(0.8, 0, 0, 2) Underline.Position = UDim2.new(0.1, 0, 0, 38) Underline.BackgroundColor3 = Color3.fromRGB(150, 0, 255) Underline.BorderSizePixel = 0  local Button = Instance.new("TextButton", Frame) Button.Size = UDim2.new(0.85, 0, 0, 60) Button.Position = UDim2.new(0.075, 0, 0.5, -5) Button.BackgroundColor3 = Color3.fromRGB(40, 0, 80) Button.Text = "Disabled ❌" Button.TextColor3 = Color3.fromRGB(255, 255, 255) Button.Font = Enum.Font.GothamBold Button.TextSize = 20  local BtnCorner = Instance.new("UICorner", Button) BtnCorner.CornerRadius = UDim.new(0, 10)  local UIStroke = Instance.new("UIStroke", Button) UIStroke.Thickness = 2 UIStroke.Color = Color3.fromRGB(180, 0, 255) UIStroke.Transparency = 0.6  task.spawn(function() 	while true do 		local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut) 		TweenService:Create(glowBig, tweenInfo, {ImageTransparency = 0.2, ImageColor3 = Color3.fromRGB(220,0,255)}):Play() 		TweenService:Create(glowMedium, tweenInfo, {ImageTransparency = 0.1, ImageColor3 = Color3.fromRGB(200,0,255)}):Play() 		TweenService:Create(glowSmall, tweenInfo, {ImageTransparency = 0.05, ImageColor3 = Color3.fromRGB(180,0,255)}):Play() 		TweenService:Create(Button, tweenInfo, {BackgroundColor3 = Color3.fromRGB(80, 0, 160)}):Play() 		task.wait(2)  		TweenService:Create(glowBig, tweenInfo, {ImageTransparency = 0.55, ImageColor3 = Color3.fromRGB(140,0,255)}):Play() 		TweenService:Create(glowMedium, tweenInfo, {ImageTransparency = 0.45, ImageColor3 = Color3.fromRGB(120,0,255)}):Play() 		TweenService:Create(glowSmall, tweenInfo, {ImageTransparency = 0.35, ImageColor3 = Color3.fromRGB(100,0,255)}):Play() 		TweenService:Create(Button, tweenInfo, {BackgroundColor3 = Color3.fromRGB(40, 0, 80)}):Play() 		task.wait(2) 	end end)  local sentryActive = false local sentryLoop  local function teleportAllSentriesToFront() 	local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") 	if not hrp then return end  	for _, player in ipairs(Players:GetPlayers()) do 		if player ~= LocalPlayer then 			local sentryName = "Sentry_" .. tostring(player.UserId) 			local sentry = Workspace:FindFirstChild(sentryName)  			if not sentry then 				local template = ReplicatedStorage:FindFirstChild(sentryName) 				if template then 					sentry = template:Clone() 					sentry.Parent = Workspace 				end 			end  			if sentry then 				local offset = hrp.CFrame.LookVector * 3 + Vector3.new(0, 2, 0) 				sentry.CFrame = CFrame.new(hrp.Position + offset) 				sentry.CanCollide = true 			end 		end 	end end  local function startSentryLoop() 	if sentryLoop then return end 	sentryLoop = task.spawn(function() 		while sentryActive do 			teleportAllSentriesToFront() 			task.wait(1) 		end 	end) end  local function stopSentryLoop() 	sentryActive = false 	sentryLoop = nil end  local function setButtonState(active) 	local onColor = Color3.fromRGB(150, 0, 255) 	local offColor = Color3.fromRGB(40, 0, 80) 	local tweenTime = 0.25  	if active then 		Button.Text = "Enabled ✅" 		TweenService:Create(Button, TweenInfo.new(tweenTime), {BackgroundColor3 = onColor}):Play() 	else 		Button.Text = "Disabled ❌" 		TweenService:Create(Button, TweenInfo.new(tweenTime), {BackgroundColor3 = offColor}):Play() 	end end  Button.MouseButton1Click:Connect(function() 	sentryActive = not sentryActive 	if sentryActive then 		startSentryLoop() 	else 		stopSentryLoop() 	end 	setButtonState(sentryActive) end)
]],
})

table.insert(SCRIPTS, {
    name="Grapple Speed", icon="🪝", desc="SPEED • GRAPPLE • BOOST", isNew=false, kind="embed",
    code=[[
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Configurações
local SPEED = 100

-- Variáveis
local char, humanoid, hrp

-- Sistema de Grapple Hook
local GrappleSystem = {
    Enabled = true,
    Connections = {},
    LastActivation = 0,
    Cooldown = 0.1
}

function GrappleSystem:equipGrapple()
    if not char then return nil end
    
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return nil end
    
    local grappleHook = backpack:FindFirstChild("Grapple Hook") or char:FindFirstChild("Grapple Hook")
    
    if not grappleHook then 
        for _, item in ipairs(backpack:GetDescendants()) do
            if item.Name == "Grapple Hook" and item:IsA("Tool") then
                grappleHook = item
                break
            end
        end
        if not grappleHook then return nil end
    end
    
    if grappleHook.Parent == backpack then
        if humanoid then
            humanoid:EquipTool(grappleHook)
        end
    end
    
    return grappleHook
end

function GrappleSystem:activateGrapple()
    if not self.Enabled then return end
    if tick() - self.LastActivation < self.Cooldown then return end
    
    local REUseItem = ReplicatedStorage:FindFirstChild("Packages")
    if REUseItem then
        REUseItem = REUseItem:FindFirstChild("Net")
        if REUseItem then
            REUseItem = REUseItem:FindFirstChild("RE/UseItem")
            if REUseItem then
                pcall(function()
                    REUseItem:FireServer(0.23450689315795897)
                    self.LastActivation = tick()
                end)
                return
            end
        end
    end
    
    if not char then return end
    
    local grappleHook = char:FindFirstChild("Grapple Hook")
    if grappleHook and grappleHook:IsA("Tool") then
        pcall(function()
            grappleHook:Activate()
            task.wait(0.05)
            grappleHook:Deactivate()
            self.LastActivation = tick()
        end)
    end
end

function GrappleSystem:start()
    self.Connections.equip = RunService.Heartbeat:Connect(function()
        self:equipGrapple()
    end)
    
    self.Connections.activate = RunService.Heartbeat:Connect(function()
        self:activateGrapple()
    end)
end

-- Sistema de Movimento com AssemblyLinearVelocity
local MoveSystem = {
    Enabled = true,
    Connections = {}
}

function MoveSystem:applyMovement()
    if not hrp or not humanoid or not hrp:IsDescendantOf(workspace) then
        return
    end
    
    local moveDirection = humanoid.MoveDirection
    
    if moveDirection.Magnitude > 0 then
        local velocity = moveDirection * SPEED
        local currentVelocity = hrp.AssemblyLinearVelocity
        velocity = Vector3.new(velocity.X, currentVelocity.Y, velocity.Z)
        hrp.AssemblyLinearVelocity = velocity
    end
end

function MoveSystem:start()
    self.Connections.movement = RunService.Heartbeat:Connect(function()
        self:applyMovement()
    end)
end

-- Configurar character
local function setupCharacter()
    char = LocalPlayer.Character
    if char then
        humanoid = char:FindFirstChild("Humanoid")
        hrp = char:FindFirstChild("HumanoidRootPart")
        
        if humanoid and hrp then
            MoveSystem:start()
            GrappleSystem:start()
        end
    end
end

-- Inicializar
setupCharacter()

-- Reconectar ao respawn
LocalPlayer.CharacterAdded:Connect(function(newChar)
    char = newChar
    
    task.wait(0.1)
    
    humanoid = newChar:WaitForChild("Humanoid")
    hrp = newChar:WaitForChild("HumanoidRootPart")
    
    -- Reiniciar sistemas
    if MoveSystem.Connections.movement then
        MoveSystem.Connections.movement:Disconnect()
    end
    if GrappleSystem.Connections.equip then
        GrappleSystem.Connections.equip:Disconnect()
    end
    if GrappleSystem.Connections.activate then
        GrappleSystem.Connections.activate:Disconnect()
    end
    
    task.wait(0.5)
    
    MoveSystem:start()
    GrappleSystem:start()
end)

-- Limpar ao sair
Players.PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        if MoveSystem.Connections.movement then
            MoveSystem.Connections.movement:Disconnect()
        end
        if GrappleSystem.Connections.equip then
            GrappleSystem.Connections.equip:Disconnect()
        end
        if GrappleSystem.Connections.activate then
            GrappleSystem.Connections.activate:Disconnect()
        end
    end
end)
]],
})

table.insert(SCRIPTS, {
    name="Desync Clone", icon="🔀", desc="DESYNC • CLONE • QUANTUM", isNew=true, kind="embed",
    code=[[
-- Borralho test Script - Quantum Cloner Desync REAL (sem flags fracas)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local backpack = player:WaitForChild("Backpack")

-- Criar ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BorralhoTest"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 340, 0, 240)
mainFrame.Position = UDim2.new(0.5, -170, 0.5, -120)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Parent = screenGui

-- UICorner para bordas arredondadas
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

-- Borda branca
local border = Instance.new("UIStroke")
border.Color = Color3.fromRGB(255, 255, 255)
border.Thickness = 2
border.Parent = mainFrame

-- Header (área para arrastar)
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 15)
headerCorner.Parent = header

-- Título
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Borralho test"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Botão Test
local testButton = Instance.new("TextButton")
testButton.Name = "TestButton"
testButton.Size = UDim2.new(0, 300, 0, 50)
testButton.Position = UDim2.new(0.5, -150, 0, 70)
testButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
testButton.BorderSizePixel = 0
testButton.Text = "Test (Quantum Desync)"
testButton.TextColor3 = Color3.fromRGB(255, 255, 255)
testButton.TextSize = 16
testButton.Font = Enum.Font.GothamSemibold
testButton.Parent = mainFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 10)
buttonCorner.Parent = testButton

local buttonStroke = Instance.new("UIStroke")
buttonStroke.Color = Color3.fromRGB(255, 255, 255)
buttonStroke.Thickness = 1
buttonStroke.Parent = testButton

-- Status label
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(1, -20, 0, 70)
statusLabel.Position = UDim2.new(0, 10, 0, 140)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: Pronto\nQuantum Cloner: Procurando...\nMétodo: Physics Manipulation"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextSize = 13
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.Parent = mainFrame

-- Sistema de arrastar (compatível com mobile)
local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    local newPosition = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
    
    TweenService:Create(mainFrame, TweenInfo.new(0.1), {Position = newPosition}):Play()
end

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        update(input)
    end
end)

-- FLAGS WORLDSTEPS SEM PREFIXOS (PURAS) para Quantum Cloner Desync
local quantumDesyncFlags = {
    -- WORLDSTEPS CORE (MAIS FORTE)
    {"MaxMissedWorldStepsRemembered", "1000"},
    {"MaxMissedWorldStepsReported", "1000"},
    {"RememberedMissedWorldStepsLimit", "1000"},
    
    -- TIMESTEP MANIPULATION (CRÍTICO)
    {"TimestepArbiterThresholdCFLThou", "0"},
    {"FixedTimestep", "false"},
    {"VariableTimestep", "true"},
    
    -- TASK SCHEDULER (WORLDSTEP BASE)
    {"TaskSchedulerTargetFps", "999999"},
    {"TaskSchedulerAutoShutdownDelay", "1"},
    {"TaskSchedulerLimitTargetFpsTo2402", "false"},
    {"GameBasicSettingsFramerateCap5", "false"},
    
    -- SIMULATION STEPPING
    {"DebugSimPhysicsSteppingMethodOverride", "10000000"},
    {"DebugSimSteppingStats", "true"},
    {"DebugSimIntegrationStabilityTesting", "true"},
    
    -- PHYSICS STEPS
    {"PhysicsStepsPerRenderFrame", "1"},
    {"MaxPhysicsStepsPerFrame", "1"},
    {"MinPhysicsStepsPerFrame", "1"},
    
    -- ADAPTIVE TIMESTEP (COMBO COM WORLDSTEPS)
    {"SimAdaptiveTimesteppingDefault2", "true"},
    {"SimAdaptiveHumanoidPDControllerSubstepMultiplier", "999999"},
    {"SimHumanoidTimestepModelUpdate", "true"},
    
    -- S2 PHYSICS (COMBO WORLDSTEP)
    {"S2PhysicsSenderRate", "1"},
    
    -- NETWORK STEPS
    {"DataSenderMaxUpdatesPerCycleLimitInKB", "0"},
    {"DataSenderMaxBandwidthBps", "1"},
    {"DataSenderRate", "1"}
}

-- Função para encontrar Quantum Cloner
local function findQuantumCloner()
    local cloner = backpack:FindFirstChild("Quantum Cloner")
    if not cloner then
        cloner = character:FindFirstChild("Quantum Cloner")
    end
    return cloner
end

-- Função para equipar Quantum Cloner
local function equipQuantumCloner()
    local cloner = findQuantumCloner()
    
    if not cloner then
        statusLabel.Text = "Status: Erro\nQuantum Cloner não encontrado!\nVerifique seu inventário"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        return false
    end
    
    if cloner.Parent == backpack then
        character.Humanoid:EquipTool(cloner)
        task.wait(0.3)
    end
    
    statusLabel.Text = "Status: Quantum Cloner equipado\nPreparando desync...\nAplicando WorldSteps..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    return true
end

-- Função principal de desync
local function activateQuantumDesync()
    if desyncActive then
        statusLabel.Text = "Status: Desync já ativo!\nWorldSteps aplicado\nFlags: " .. #quantumDesyncFlags
        statusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
        return
    end
    
    -- Aplicar WorldSteps flags primeiro
    local flagCount = applyWorldStepsFlags()
    statusLabel.Text = "Status: WorldSteps aplicado\nFlags: " .. flagCount .. "/" .. #quantumDesyncFlags .. "\nEquipando..."
    statusLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    task.wait(0.3)
    
    -- Equipar Quantum Cloner
    if not equipQuantumCloner() then
        return
    end
    
    task.wait(0.5)
    
    -- Procurar remote events
    local packages = ReplicatedStorage:WaitForChild("Packages", 5)
    if not packages then
        statusLabel.Text = "Status: Erro\nPackages não encontrado!\nVerifique o jogo"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        warn("❌ Packages não encontrado")
        return
    end
    
    local netFolder = packages:WaitForChild("Net", 5)
    if not netFolder then
        statusLabel.Text = "Status: Erro\nNet folder não encontrado!\nVerifique o jogo"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        warn("❌ Net folder não encontrado")
        return
    end
    
    local useItemRemote = netFolder:WaitForChild("RE/UseItem", 5)
    local teleportRemote = netFolder:WaitForChild("RE/QuantumCloner/OnTeleport", 5)
    
    if not useItemRemote or not teleportRemote then
        statusLabel.Text = "Status: Erro\nRemotos não encontrados!\nVerifique o jogo"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        warn("❌ Remotos não encontrados")
        return
    end
    
    statusLabel.Text = "Status: Ativando desync...\nCriando clone...\nWorldSteps: " .. flagCount .. " ativo"
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    
    -- Usar Quantum Cloner MÚLTIPLAS VEZES
    task.spawn(function()
        for i = 1, 3 do
            pcall(function()
                useItemRemote:FireServer("Quantum Cloner")
            end)
            task.wait(0.05)
        end
    end)
    
    task.wait(0.2)
    
    -- Usar OnTeleport MÚLTIPLAS VEZES
    local success2 = false
    for i = 1, 5 do
        success2 = pcall(function()
            teleportRemote:FireServer()
        end)
        task.wait(0.03)
    end
    
    if success2 then
        desyncActive = true
        statusLabel.Text = "Status: DESYNC WORLDSTEPS ATIVO!\nClone + Teleport x5\nFlags: " .. flagCount .. "/" .. #quantumDesyncFlags
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        testButton.Text = "DESYNC ATIVO! (WorldSteps)"
        testButton.BackgroundColor3 = Color3.fromRGB(20, 70, 20)
        testButton.TextColor3 = Color3.fromRGB(150, 255, 150)
        
        print("[Borralho test] Quantum WorldSteps Desync ativado!")
        print("WorldSteps flags: " .. flagCount)
        print("Clone criado x3 + Teleport x5")
        print("DFIntMaxMissedWorldStepsRemembered = 1000")
        print("DFIntTaskSchedulerTargetFps = 999999")
    else
        statusLabel.Text = "Status: Erro ao usar itens\nWorldSteps: " .. flagCount .. " ativo\nVerifique remotos"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end

-- Verificar se Quantum Cloner existe
task.spawn(function()
    task.wait(2)
    local cloner = findQuantumCloner()
    if cloner then
        statusLabel.Text = "Status: Pronto\nQuantum Cloner: Encontrado ✓\nWorldSteps: Pronto (" .. #quantumDesyncFlags .. " flags)"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        statusLabel.Text = "Status: Pronto\nQuantum Cloner: NÃO encontrado ✗\nWorldSteps: Pronto (" .. #quantumDesyncFlags .. " flags)"
        statusLabel.TextColor3 = Color3.fromRGB(255, 150, 100)
    end
end)

-- Conectar botão
testButton.MouseButton1Click:Connect(function()
    if not desyncActive then
        activateQuantumDesync()
    end
end)

-- Efeito hover no botão
testButton.MouseEnter:Connect(function()
    if not desyncActive then
        TweenService:Create(testButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        }):Play()
    end
end)

testButton.MouseLeave:Connect(function()
    if not desyncActive then
        TweenService:Create(testButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        }):Play()
    end
end)

-- Atualizar character reference
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    desyncActive = false
    testButton.Text = "Test (Quantum Desync)"
    testButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    testButton.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

print("Borralho test - Quantum WorldSteps Desync carregado!")
print("Flags WorldSteps prontas: " .. #quantumDesyncFlags)
print("- DFIntMaxMissedWorldStepsRemembered: 1000")
print("- DFIntTaskSchedulerTargetFps: 999999")
print("- DFIntS2PhysicsSenderRate: 1")
print("Pronto para desync extremo!")
]],
})

table.insert(SCRIPTS, {
    name="Server Hopper", icon="🌐", desc="AUTO HOP • BEST SERVER • FAST", isNew=false, kind="embed",
    code=[[
-- This File Published By Crusty Hub
-- discord.gg/crustyhub

local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

while not Players.LocalPlayer do task.wait() end
local player = Players.LocalPlayer
local ALLOWED_PLACE_ID = 109983668079237
local RETRY_DELAY = 0.1
local SETTINGS_FILE = "ServerHopperSettings.json"
local GUI_STATE_FILE = "ServerHopperGUIState.json"
local API_STATE_FILE = "ServerHopperAPIState.json"

local settings = {
    minGeneration = 1000000,
    targetNames = {},
    blacklistNames = {},
    targetRarity = "",
    targetMutation = "",
    minPlayers = 2,
    sortOrder = "Desc",
    autoStart = true,
    customSoundId = "rbxassetid://9167433166",
    hopCount = 0,
    recentVisited = {},
    notificationDuration = 4
}

local guiState = {
    isMinimized = false,
    position = {
        XScale = 0.5,
        XOffset = -125,
        YScale = 0.6,
        YOffset = -150
    }
}

local apiState = {
    mainApiUses = 0,
    cachedServers = {},
    lastCacheUpdate = 0,
    useCachedServers = false
}

local isRunning = false
local currentConnection = nil
local foundPodiumsData = {}
local monitoringConnection = nil
local autoHopping = false

local folderExists = game.Workspace:FindFirstChild("FolderHopperCheck") ~= nil
local alreadyHereFolderExists = game.Workspace:FindFirstChild("Sigmahopper") ~= nil

local mutationColors = {
    Gold = Color3.fromRGB(255, 215, 0),
    Diamond = Color3.fromRGB(0, 255, 255),
    Lava = Color3.fromRGB(255, 100, 0),
    Bloodrot = Color3.fromRGB(255, 0, 0),
    Candy = Color3.fromRGB(255, 182, 193),
    Normal = Color3.fromRGB(255, 255, 255),
    Default = Color3.fromRGB(255, 255, 255)
}

local cachedPlots = nil
local cachedPodiums = nil
local lastPodiumCheck = 0
local PODIUM_CACHE_DURATION = 1

local function checkAPIAvailability()
    local mainAPI = "https://games.roblox.com/v1/games/" .. ALLOWED_PLACE_ID .. "/servers/Public?sortOrder=" .. settings.sortOrder .. "&limit=100&excludeFullGames=true"
    local success, response = pcall(function() return game:HttpGet(mainAPI) end)
    return success and response ~= ""
end

local function saveSettings()
    local success, error = pcall(function()
        writefile(SETTINGS_FILE, Http:JSONEncode(settings))
    end)
    if not success then
        print("Failed to save settings:", error)
    end
end

local function loadSettings()
    local success, data = pcall(function()
        return readfile(SETTINGS_FILE)
    end)
    if success then
        local loadedSettings = Http:JSONDecode(data)
        for key, value in pairs(loadedSettings) do
            if settings[key] ~= nil then
                settings[key] = value
            end
        end
    end
end

local function saveGUIState()
    local success, error = pcall(function()
        writefile(GUI_STATE_FILE, Http:JSONEncode(guiState))
    end)
    if not success then
        print("Failed to save GUI state:", error)
    end
end

local function loadGUIState()
    local success, data = pcall(function()
        return readfile(GUI_STATE_FILE)
    end)
    if success then
        local loadedState = Http:JSONDecode(data)
        for key, value in pairs(loadedState) do
            if guiState[key] ~= nil then
                guiState[key] = value
            end
        end
    end
end

local function saveAPIState()
    local success, error = pcall(function()
        writefile(API_STATE_FILE, Http:JSONEncode(apiState))
    end)
    if not success then
        print("Failed to save API state:", error)
    end
end

local function loadAPIState()
    local success, data = pcall(function()
        return readfile(API_STATE_FILE)
    end)
    if success then
        local loadedState = Http:JSONDecode(data)
        for key, value in pairs(loadedState) do
            if apiState[key] ~= nil then
                apiState[key] = value
            end
        end
    end
end

local function showNotification(title, text)
    _G.ShowInfoNotification(title, text, settings.notificationDuration or 4)
end

local function playFoundSound()
    local sound = Instance.new("Sound")
    sound.SoundId = settings.customSoundId
    sound.Volume = 1
    sound.PlayOnRemove = true
    sound.Parent = workspace
    sound:Destroy()
end

local function extractNumber(str)
    if not str then return 0 end
    local numberStr = str:match("%$(.-)/s")
    if not numberStr then return 0 end
    numberStr = numberStr:gsub("%s", "")
    local multiplier = 1
    if numberStr:lower():find("k") then
        multiplier = 1000
        numberStr = numberStr:gsub("[kK]", "")
    elseif numberStr:lower():find("m") then
        multiplier = 1000000
        numberStr = numberStr:gsub("[mM]", "")
    elseif numberStr:lower():find("b") then
        multiplier = 1000000000
        numberStr = numberStr:gsub("[bB]", "")
    end
    return (tonumber(numberStr) or 0) * multiplier
end

local function getMutationTextAndColor(mutation)
    if not mutation or mutation.Visible == false then
        return "Normal", Color3.fromRGB(255, 255, 255), false
    end
    local name = mutation.Text
    if name == "" then
        return "Normal", Color3.fromRGB(255, 255, 255), false
    end
    if name == "Rainbow" then
        return "Rainbow", Color3.new(1, 1, 1), true
    end
    local color = mutationColors[name] or Color3.fromRGB(255, 255, 255)
    return name, color, false
end

local function isPlayerBase(plot)
    local sign = plot:FindFirstChild("PlotSign")
    if sign then
        local yourBase = sign:FindFirstChild("YourBase")
        if yourBase and yourBase.Enabled then
            return true
        end
    end
    return false
end

local function getAllPodiums()
    if cachedPodiums and tick() - lastPodiumCheck < PODIUM_CACHE_DURATION then
        return cachedPodiums
    end
    
    local podiums = {}
    
    if not cachedPlots then
        cachedPlots = Workspace:FindFirstChild("Plots")
    end
    
    if not cachedPlots then 
        lastPodiumCheck = tick()
        cachedPodiums = podiums
        return podiums 
    end
    
    local plotChildren = cachedPlots:GetChildren()
    
    for i = 1, #plotChildren do
        local plot = plotChildren[i]
        
        if not isPlayerBase(plot) then
            -- Original search method
            local animalPods = plot:FindFirstChild("AnimalPodiums")
            if animalPods then
                local podChildren = animalPods:GetChildren()
                for j = 1, #podChildren do
                    local pod = podChildren[j]
                    local base = pod:FindFirstChild("Base")
                    if base then
                        local spawn = base:FindFirstChild("Spawn")
                        if spawn then
                            local attach = spawn:FindFirstChild("Attachment")
                            if attach then
                                local animalOverhead = attach:FindFirstChild("AnimalOverhead")
                                if animalOverhead and (base:IsA("BasePart") or base:IsA("Model")) then
                                    table.insert(podiums, { 
                                        overhead = animalOverhead, 
                                        base = base,
                                        pod = pod,
                                        plot = plot
                                    })
                                end
                            end
                        end
                    end
                end
            end
            
            -- Alternative search method
            if plot:IsA("Model") then
                for _, model in pairs(plot:GetChildren()) do
                    if model:IsA("Model") then
                        for _, obj in pairs(model:GetDescendants()) do
                            if obj:IsA("Attachment") and obj.Name == "OVERHEAD_ATTACHMENT" then
                                local overhead = obj:FindFirstChild("AnimalOverhead")
                                if overhead then
                                    -- Find a suitable base, perhaps the parent model or something
                                    local base = model:FindFirstChild("Base") or model
                                    if base and (base:IsA("BasePart") or base:IsA("Model")) then
                                        table.insert(podiums, { 
                                            overhead = overhead, 
                                            base = base,
                                            pod = model,
                                            plot = plot
                                        })
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    lastPodiumCheck = tick()
    cachedPodiums = podiums
    return podiums
end

local function getPrimaryPartPosition(obj)
    if not obj then return nil end
    if obj:IsA("Model") and obj.PrimaryPart then
        return obj.PrimaryPart.Position
    elseif obj:IsA("BasePart") then
        return obj.Position
    end
    return nil
end

local function getServersFromAPI(baseUrl, isMainAPI)
    local servers = {}
    local cursor = ""
    local maxPages = 3
    
    if isMainAPI then
        apiState.mainApiUses = apiState.mainApiUses + 1
        saveAPIState()
    end
    
    for page = 1, maxPages do
        local url = baseUrl
        if cursor ~= "" then url = url .. "&cursor=" .. cursor end
        
        local success, response = pcall(function() return game:HttpGet(url) end)
        if not success then break end
        
        local body = Http:JSONDecode(response)
        if not body.data then break end
        
        for _, v in body.data do
            if v.playing and v.maxPlayers and v.playing >= settings.minPlayers and v.playing < v.maxPlayers and v.id ~= game.JobId and not table.find(settings.recentVisited, v.id) then
                table.insert(servers, v.id)
                if not table.find(apiState.cachedServers, v.id) then
                    table.insert(apiState.cachedServers, v.id)
                end
            end
        end
        
        cursor = body.nextPageCursor or ""
        if cursor == "" then break end
    end
    
    while #apiState.cachedServers > 300 do
        table.remove(apiState.cachedServers, 1)
    end
    
    apiState.lastCacheUpdate = tick()
    saveAPIState()
    return servers
end

local function getCachedServers()
    local availableServers = {}
    local recentCount = math.min(#settings.recentVisited, 5)
    local recentServers = {}
    
    for i = #settings.recentVisited - recentCount + 1, #settings.recentVisited do
        if settings.recentVisited[i] then
            table.insert(recentServers, settings.recentVisited[i])
        end
    end
    
    for _, serverId in ipairs(apiState.cachedServers) do
        if not table.find(recentServers, serverId) and serverId ~= game.JobId then
            table.insert(availableServers, serverId)
        end
    end
    
    return availableServers
end

local function findClosestModel(podiumBase, models)
    if not podiumBase then return nil end
    local podiumPos = getPrimaryPartPosition(podiumBase)
    if not podiumPos then return nil end
    
    local closestModel = nil
    local minDistance = math.huge
    
    for i = 1, #models do
        local model = models[i]
        local modelPos = getPrimaryPartPosition(model)
        if modelPos then
            local distance = (podiumPos - modelPos).Magnitude
            if distance < minDistance then
                minDistance = distance
                closestModel = model
            end
        end
    end
    
    return closestModel
end

local function isStolenPodium(overhead)
    if not overhead then return false end
    local stolenLabel = overhead:FindFirstChild("Stolen")
    if stolenLabel and stolenLabel:IsA("TextLabel") then
        return string.upper(stolenLabel.Text) == "FUSING"
    end
    return false
end

local function getAvailableServers()
    if apiState.mainApiUses >= 3 or apiState.useCachedServers then
        if not checkAPIAvailability() then
            apiState.useCachedServers = true
            saveAPIState()
            return getCachedServers()
        else
            apiState.useCachedServers = false
            apiState.mainApiUses = 0
            saveAPIState()
        end
    end
    
    local mainAPI = "https://games.roblox.com/v1/games/" .. ALLOWED_PLACE_ID .. "/servers/Public?sortOrder=" .. settings.sortOrder .. "&limit=100&excludeFullGames=true"
    local servers = getServersFromAPI(mainAPI, true)
    
    if #servers > 0 then return servers end
    
    apiState.useCachedServers = true
    saveAPIState()
    return getCachedServers()
end

local function matchesFilters(labels, overhead)
    if isStolenPodium(overhead) then
        return false
    end
    
    local genValue = extractNumber(labels.Generation)
    local hasTargetName = false
    
    if #settings.targetNames > 0 then
        for i = 1, #settings.targetNames do
            local name = settings.targetNames[i]
            if name ~= "" and string.find(string.lower(labels.DisplayName), string.lower(name)) then
                hasTargetName = true
                break
            end
        end
        if not hasTargetName then return false end
    end
    
    if settings.targetMutation ~= "" then
        if string.lower(labels.Mutation) ~= string.lower(settings.targetMutation) then
            return false
        end
        return true
    end
    
    if hasTargetName then
        return true
    end
    
    if genValue < settings.minGeneration then
        return false
    end
    
    if #settings.blacklistNames > 0 then
        for i = 1, #settings.blacklistNames do
            local name = settings.blacklistNames[i]
            if name ~= "" and string.find(string.lower(labels.DisplayName), string.lower(name)) then
                return false
            end
        end
    end
    
    if settings.targetRarity ~= "" then
        if string.lower(labels.Rarity) ~= string.lower(settings.targetRarity) then
            return false
        end
    end
    
    return true
end

local function checkPodiumsForWebhooksAndFilters()
    if game.PlaceId ~= ALLOWED_PLACE_ID then
        return false, {}
    end
    
    local podiums = getAllPodiums()
    local filteredPodiums = {}
    
    local workspaceModels = {}
    for _, child in ipairs(workspace:GetChildren()) do
        if child:IsA("Model") then
            table.insert(workspaceModels, child)
        end
    end
    
    for i = 1, #podiums do
        local podium = podiums[i]
        
        if isStolenPodium(podium.overhead) then
            continue
        end
        
        local displayNameLabel = podium.overhead:FindFirstChild("DisplayName")
        local genLabel = podium.overhead:FindFirstChild("Generation")
        local rarityLabel = podium.overhead:FindFirstChild("Rarity")
        
        if displayNameLabel and genLabel and rarityLabel then
            local mutation = podium.overhead:FindFirstChild("Mutation")
            local mutText, _, _ = getMutationTextAndColor(mutation)
            
            local modelText = string.format("%s Generation: %s Mutation: %s Rarity: %s", 
                displayNameLabel.Text, 
                genLabel.Text, 
                mutText, 
                rarityLabel.Text)
            
            local genValue = extractNumber(genLabel.Text)
            local displayName = displayNameLabel.Text
            
            local labels = {
                DisplayName = displayNameLabel.Text,
                Generation = genLabel.Text,
                Mutation = mutText,
                Rarity = rarityLabel.Text
            }
            
            if matchesFilters(labels, podium.overhead) then
                local closestModel = findClosestModel(podium.base, workspaceModels)
                table.insert(filteredPodiums, { 
                    base = podium.base, 
                    labels = labels, 
                    closestModel = closestModel, 
                    overhead = podium.overhead,
                    pod = podium.pod,
                    plot = podium.plot
                })
            end
        end
    end
    
    return #filteredPodiums > 0, filteredPodiums
end

local function formatGeneration(genStr)
    local genValue = extractNumber(genStr)
    if genValue >= 1000000000 then
        return string.format("%.1fB", genValue / 1000000000)
    elseif genValue >= 1000000 then
        return string.format("%.1fM", genValue / 1000000)
    elseif genValue >= 1000 then
        return string.format("%.1fK", genValue / 1000)
    else
        return tostring(genValue)
    end
end

local function tryTeleportWithRetries()
    if not isRunning then
        return
    end

    local attempts = 0
    local maxAttempts = 5
    while attempts < maxAttempts and isRunning do
        local servers = getAvailableServers()
        if #servers == 0 then
            task.wait(RETRY_DELAY)
            attempts = attempts + 1
            continue
        end
        local randomServer = servers[math.random(1, #servers)]
        local success, err = pcall(function()
            TPS:TeleportToPlaceInstance(ALLOWED_PLACE_ID, randomServer)
        end)
        if success then
            return
        else
            if not isRunning then
                return
            end
            task.wait(RETRY_DELAY)
            attempts = attempts + 1
        end
    end
    if isRunning then
        isRunning = false
    end
end

local function monitorFoundPodiums()
    if monitoringConnection then
        monitoringConnection:Disconnect()
    end
    
    monitoringConnection = RunService.Heartbeat:Connect(function()
        if not isRunning or #foundPodiumsData == 0 then return end
        
        local lostAny = false
        local lostPodiums = {}
        
        for i = #foundPodiumsData, 1, -1 do
            local data = foundPodiumsData[i]
            if data and data.overhead and data.overhead.Parent then
                local displayNameLabel = data.overhead:FindFirstChild("DisplayName")
                if displayNameLabel and displayNameLabel.Text then
                    local currentLabels = {
                        DisplayName = displayNameLabel.Text,
                        Generation = data.labels and data.labels.Generation or "Unknown",
                        Mutation = data.labels and data.labels.Mutation or "Normal",
                        Rarity = data.labels and data.labels.Rarity or "None"
                    }
                    
                    if not matchesFilters(currentLabels, data.overhead) then
                        table.insert(lostPodiums, data.labels.DisplayName)
                        table.remove(foundPodiumsData, i)
                        lostAny = true
                    end
                else
                    table.insert(lostPodiums, data.labels.DisplayName)
                    table.remove(foundPodiumsData, i)
                    lostAny = true
                end
            else
                if data then
                    table.insert(lostPodiums, data.labels.DisplayName)
                    table.remove(foundPodiumsData, i)
                    lostAny = true
                end
            end
        end
        
        if lostAny then
            local lostText = ""
            if #lostPodiums > 0 then
                lostText = "Lost: " .. table.concat(lostPodiums, ", ")
            else
                lostText = "Lost podium(s)"
            end
            
            showNotification("Not found", lostText)
        end
    end)
end


local function runServerCheck()
    if not isRunning then return end
    
    local foundPets, results = checkPodiumsForWebhooksAndFilters()
    
    if foundPets and #results > 0 then
        foundPodiumsData = results
        local displayResults = {}
        for _, entry in ipairs(results) do
            local genValue = extractNumber(entry.labels.Generation)
            table.insert(displayResults, {entry = entry, gen = genValue})
        end
        table.sort(displayResults, function(a, b) return a.gen > b.gen end)
        local foundText = ""
        local numToShow = math.min(3, #displayResults)
        for i = 1, numToShow do
            local entry = displayResults[i].entry
            local genFormatted = formatGeneration(entry.labels.Generation)
            foundText = foundText .. entry.labels.DisplayName .. " (" .. genFormatted .. ")"
            if i < numToShow then
                foundText = foundText .. ", "
            end
        end
        if #displayResults > 3 then
            local extra = #displayResults - 3
            foundText = foundText .. " and " .. extra .. " more..."
        end
        showNotification("Found", foundText)
        playFoundSound()
        monitorFoundPodiums()
        return
    end
    
    if not isRunning then return end
    
    settings.hopCount = settings.hopCount + 1
    saveSettings()
    tryTeleportWithRetries()
end

local function createTagList(parent, list, placeholder, onAdd, onRemove)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 22)
    container.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 4)
    containerCorner.Parent = container
    
    local containerStroke = Instance.new("UIStroke")
    containerStroke.Thickness = 1
    containerStroke.Color = Color3.fromRGB(60, 60, 70)
    containerStroke.Parent = container
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -50, 1, 0)
    scrollFrame.Position = UDim2.new(0, 4, 0, 0)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 0
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.Parent = container
    
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 3)
    layout.Parent = scrollFrame
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0, 45, 1, 0)
    textBox.Position = UDim2.new(1, -46, 0, 0)
    textBox.BackgroundTransparency = 1
    textBox.Text = ""
    textBox.PlaceholderText = placeholder
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
    textBox.TextSize = 9
    textBox.Font = Enum.Font.Gotham
    textBox.Parent = container
    
    local function updateCanvas()
        local totalWidth = layout.AbsoluteContentSize.X
        scrollFrame.CanvasSize = UDim2.new(0, totalWidth, 0, 0)
    end
    
    local function createTag(text)
        local tag = Instance.new("Frame")
        tag.Size = UDim2.new(0, 0, 0, 16)
        tag.BackgroundColor3 = Color3.fromRGB(50, 100, 150)
        tag.BorderSizePixel = 0
        tag.Parent = scrollFrame
        
        local tagCorner = Instance.new("UICorner")
        tagCorner.CornerRadius = UDim.new(0, 8)
        tagCorner.Parent = tag
        
        local tagLabel = Instance.new("TextLabel")
        tagLabel.Size = UDim2.new(1, -14, 1, 0)
        tagLabel.Position = UDim2.new(0, 3, 0, 0)
        tagLabel.BackgroundTransparency = 1
        tagLabel.Text = text
        tagLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        tagLabel.TextSize = 8
        tagLabel.Font = Enum.Font.Gotham
        tagLabel.TextXAlignment = Enum.TextXAlignment.Left
        tagLabel.Parent = tag
        
        local removeButton = Instance.new("TextButton")
        removeButton.Size = UDim2.new(0, 12, 0, 12)
        removeButton.Position = UDim2.new(1, -13, 0.5, -5)
        removeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        removeButton.BorderSizePixel = 0
        removeButton.Text = "X"
        removeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        removeButton.TextSize = 6
        removeButton.Font = Enum.Font.GothamBold
        removeButton.Parent = tag
        
        local removeCorner = Instance.new("UICorner")
        removeCorner.CornerRadius = UDim.new(0, 6)
        removeCorner.Parent = removeButton
        
        local textSize = TextService:GetTextSize(text, 8, Enum.Font.Gotham, Vector2.new(math.huge, 16))
        tag.Size = UDim2.new(0, textSize.X + 18, 0, 16)
        
        removeButton.MouseButton1Click:Connect(function()
            onRemove(text)
            tag:Destroy()
            updateCanvas()
        end)
        
        updateCanvas()
        return tag
    end
    
    local function refreshTags()
        for _, child in ipairs(scrollFrame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        
        for _, item in ipairs(list) do
            createTag(item)
        end
    end
    
    textBox.FocusLost:Connect(function()
        if textBox.Text ~= "" then
            onAdd(textBox.Text:gsub("^%s*(.-)%s*$", "%1"))
            textBox.Text = ""
            refreshTags()
        end
    end)
    
    textBox.Focused:Connect(function()
        TweenService:Create(containerStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(100, 150, 255)}):Play()
    end)
    
    textBox.FocusLost:Connect(function()
        TweenService:Create(containerStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(60, 60, 70)}):Play()
    end)
    
    refreshTags()
    return refreshTags
end

local function createSettingsGUI()
    local playerGui = player:WaitForChild("PlayerGui")
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ServerHopperGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 250, 0, 300)
    mainFrame.Position = UDim2.new(guiState.position.XScale, guiState.position.XOffset, guiState.position.YScale, guiState.position.YOffset)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 8)
    mainCorner.Parent = mainFrame
    
    local mainStroke = Instance.new("UIStroke")
    mainStroke.Thickness = 1
    mainStroke.Color = Color3.fromRGB(50, 50, 60)
    mainStroke.Parent = mainFrame
    
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = titleBar
    
    local titleFix = Instance.new("Frame")
    titleFix.Size = UDim2.new(1, 0, 0, 15)
    titleFix.Position = UDim2.new(0, 0, 1, -15)
    titleFix.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    titleFix.BorderSizePixel = 0
    titleFix.Parent = titleBar
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -80, 1, 0)
    titleLabel.Position = UDim2.new(0, 8, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "Server Hopper"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 12
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar
    
    local isMinimized = guiState.isMinimized
    local originalSize = mainFrame.Size
    
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 22, 0, 22)
    minimizeButton.Position = UDim2.new(1, -54, 0, 4)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    minimizeButton.BorderSizePixel = 0
    minimizeButton.Text = isMinimized and "+" or "-"
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.TextSize = 10
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.Parent = titleBar
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 4)
    minimizeCorner.Parent = minimizeButton
    
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 22, 0, 22)
    closeButton.Position = UDim2.new(1, -28, 0, 4)
    closeButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    closeButton.BorderSizePixel = 0
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 10
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = titleBar
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 4)
    closeCorner.Parent = closeButton
    
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, 0, 1, -30)
    contentFrame.Position = UDim2.new(0, 0, 0, 30)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Visible = not isMinimized
    contentFrame.Parent = mainFrame
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -10, 1, -120)
    scrollFrame.Position = UDim2.new(0, 5, 0, 5)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 4
    scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 350)
    scrollFrame.Parent = contentFrame
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 4)
    layout.Parent = scrollFrame
    
    if isMinimized then
        mainFrame.Size = UDim2.new(0, 250, 0, 30)
    else
        mainFrame.Size = UDim2.new(0, 250, 0, 300)
    end
    
    minimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        guiState.isMinimized = isMinimized
        saveGUIState()
        
        if isMinimized then
            mainFrame.Size = UDim2.new(0, 250, 0, 30)
            minimizeButton.Text = "+"
            contentFrame.Visible = false
        else
            contentFrame.Visible = true
            mainFrame.Size = originalSize
            minimizeButton.Text = "-"
        end
    end)
    
    local function createInputField(name, placeholder, defaultValue, layoutOrder, settingKey, desc)
        local container = Instance.new("Frame")
        container.Size = UDim2.new(1, 0, 0, 35)
        container.BackgroundTransparency = 1
        container.LayoutOrder = layoutOrder
        container.Parent = scrollFrame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0, 12)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = Color3.fromRGB(200, 200, 210)
        label.TextSize = 9
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = container
        
        local inputFrame = Instance.new("Frame")
        inputFrame.Size = UDim2.new(1, -10, 0, 22)
        inputFrame.Position = UDim2.new(0, 0, 0, 13)
        inputFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        inputFrame.BorderSizePixel = 0
        inputFrame.Parent = container
        
        local inputCorner = Instance.new("UICorner")
        inputCorner.CornerRadius = UDim.new(0, 4)
        inputCorner.Parent = inputFrame
    
        local inputStroke = Instance.new("UIStroke")
        inputStroke.Thickness = 1
        inputStroke.Color = Color3.fromRGB(60, 60, 70)
        inputStroke.Parent = inputFrame
        
        local textBox = Instance.new("TextBox")
        textBox.Size = UDim2.new(1, -8, 1, 0)
        textBox.Position = UDim2.new(0, 4, 0, 0)
        textBox.BackgroundTransparency = 1
        textBox.Text = defaultValue or ""
        textBox.PlaceholderText = placeholder
        textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        textBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
        textBox.TextSize = 10
        textBox.Font = Enum.Font.Gotham
        textBox.Parent = inputFrame
        
        textBox.Focused:Connect(function()
            TweenService:Create(inputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(100, 150, 255)}):Play()
        end)
        
        textBox.FocusLost:Connect(function()
            TweenService:Create(inputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(60, 60, 70)}):Play()
            
            -- Save setting immediately when field loses focus
            if settingKey then
                if settingKey == "minGeneration" or settingKey == "minPlayers" or settingKey == "notificationDuration" then
                    settings[settingKey] = tonumber(textBox.Text) or settings[settingKey]
                else
                    settings[settingKey] = textBox.Text:gsub("^%s*(.-)%s*$", "%1")
                end
                saveSettings()
            end
        end)
        
        return textBox
    end
    
    local function createTagInputField(name, list, placeholder, layoutOrder, descAdd, descRemove)
        local container = Instance.new("Frame")
        container.Size = UDim2.new(1, 0, 0, 35)
        container.BackgroundTransparency = 1
        container.LayoutOrder = layoutOrder
        container.Parent = scrollFrame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0, 12)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = Color3.fromRGB(200, 200, 210)
        label.TextSize = 9
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = container
        
        local tagContainer = Instance.new("Frame")
        tagContainer.Size = UDim2.new(1, -10, 0, 22)
        tagContainer.Position = UDim2.new(0, 0, 0, 13)
        tagContainer.BackgroundTransparency = 1
        tagContainer.Parent = container
        
        local refreshTags = createTagList(tagContainer, list, placeholder,
            function(text)
                if text and text ~= "" and not table.find(list, text) then
                    table.insert(list, text)
                    saveSettings()
                end
            end,
            function(text)
                local index = table.find(list, text)
                if index then
                    table.remove(list, index)
                    saveSettings()
                end
            end
        )
        
        return refreshTags
    end
    
    local function createSortOrderToggle(name, defaultValue, layoutOrder, desc)
        local container = Instance.new("Frame")
        container.Size = UDim2.new(1, 0, 0, 35)
        container.BackgroundTransparency = 1
        container.LayoutOrder = layoutOrder
        container.Parent = scrollFrame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0, 12)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = Color3.fromRGB(200, 200, 210)
        label.TextSize = 9
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = container
        
        local toggleButton = Instance.new("TextButton")
        toggleButton.Size = UDim2.new(1, -10, 0, 22)
        toggleButton.Position = UDim2.new(0, 0, 0, 13)
        toggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        toggleButton.BorderSizePixel = 0
        toggleButton.Text = defaultValue
        toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.TextSize = 10
        toggleButton.Font = Enum.Font.Gotham
        toggleButton.TextXAlignment = Enum.TextXAlignment.Left
        toggleButton.Parent = container
        
        local toggleCorner = Instance.new("UICorner")
        toggleCorner.CornerRadius = UDim.new(0, 4)
        toggleCorner.Parent = toggleButton
    
        local toggleStroke = Instance.new("UIStroke")
        toggleStroke.Thickness = 1
        toggleStroke.Color = Color3.fromRGB(60, 60, 70)
        toggleStroke.Parent = toggleButton
        
        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 4)
        padding.Parent = toggleButton
        
        local currentValue = defaultValue
        toggleButton.MouseButton1Click:Connect(function()
            if currentValue == "Asc" then
                currentValue = "Desc"
            else
                currentValue = "Asc"
            end
            toggleButton.Text = currentValue
            settings.sortOrder = currentValue
            saveSettings()
        end)
        
        return toggleButton
    end
    
    local function createToggle(name, defaultValue, layoutOrder, settingKey, descOn, descOff)
        local container = Instance.new("Frame")
        container.Size = UDim2.new(1, 0, 0, 28)
        container.BackgroundTransparency = 1
        container.LayoutOrder = layoutOrder
        container.Parent = scrollFrame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -45, 1, 0)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = Color3.fromRGB(200, 200, 210)
        label.TextSize = 10
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = container
        
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Size = UDim2.new(0, 36, 0, 18)
        toggleFrame.Position = UDim2.new(1, -36, 0.5, -9)
        toggleFrame.BackgroundColor3 = defaultValue and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(60, 60, 70)
        toggleFrame.BorderSizePixel = 0
        toggleFrame.Parent = container
        
        local toggleCorner = Instance.new("UICorner")
        toggleCorner.CornerRadius = UDim.new(0, 9)
        toggleCorner.Parent = toggleFrame
        
        local toggleButton = Instance.new("Frame")
        toggleButton.Size = UDim2.new(0, 14, 0, 14)
        toggleButton.Position = defaultValue and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.BorderSizePixel = 0
        toggleButton.Parent = toggleFrame
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 7)
        buttonCorner.Parent = toggleButton
        
        local isEnabled = defaultValue
        local clickDetector = Instance.new("TextButton")
        clickDetector.Size = UDim2.new(1, 0, 1, 0)
        clickDetector.Position = UDim2.new(0, 0, 0, 0)
        clickDetector.BackgroundTransparency = 1
        clickDetector.Text = ""
        clickDetector.Parent = toggleFrame
        
        clickDetector.MouseButton1Click:Connect(function()
            isEnabled = not isEnabled
            local frameColor = isEnabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(60, 60, 70)
            local buttonPos = isEnabled and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
            
            TweenService:Create(toggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = frameColor}):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {Position = buttonPos}):Play()
            
            if settingKey and settings[settingKey] ~= nil then
                settings[settingKey] = isEnabled
                saveSettings()
            end
        end)
        
        return function() return isEnabled end
    end
    
    -- Create input fields with proper settings saving
    local minGenInput = createInputField("Min. Generation", "1000000", tostring(settings.minGeneration), 1, "minGeneration", "Minimum generation for searching pets without specified target.")
    local refreshTargetTags = createTagInputField("Target (Add)", settings.targetNames, "Name", 2, "Added target for search regardless of generation:", "Removed target:")
    local refreshBlacklistTags = createTagInputField("Blacklist (Add)", settings.blacklistNames, "Name", 3, "Added to blacklist to ignore:", "Removed from blacklist:")
    local rarityInput = createInputField("Rarity", "Secret, Mythical", settings.targetRarity, 4, "targetRarity", "Target rarity. Only pets of this rarity will be noticed.")
    local mutationInput = createInputField("Mutation", "Rainbow, Gold", settings.targetMutation, 5, "targetMutation", "Target mutation. Only pets with this mutation will be noticed.")
    local minPlayersInput = createInputField("Min. Players", "2", tostring(settings.minPlayers), 6, "minPlayers", "Minimum number of players on server for hopping.")
    local soundInput = createInputField("Sound ID", "rbxassetid://9167433166", settings.customSoundId, 7, "customSoundId", "Sound ID to play when pet is found.")
    local notificationDurationInput = createInputField("Notification Duration (sec)", "4", tostring(settings.notificationDuration), 8, "notificationDuration", "Duration of notifications in seconds.")
    
    local sortOrderToggle = createSortOrderToggle("Sort Order", settings.sortOrder, 9, "Server sort order: Asc - low to high, Desc - high to low.")
    local autoStartToggle = createToggle("Auto Start", settings.autoStart, 10, "autoStart", "Auto start script after webhook check enabled.", "Auto start script disabled.")
    
    local fixedBottomFrame = Instance.new("Frame")
    fixedBottomFrame.Name = "FixedBottomFrame"
    fixedBottomFrame.Size = UDim2.new(1, 0, 0, 110)
    fixedBottomFrame.Position = UDim2.new(0, 0, 1, -115)
    fixedBottomFrame.BackgroundTransparency = 1
    fixedBottomFrame.Parent = contentFrame
    
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Size = UDim2.new(1, -10, 0, 55)
    buttonContainer.Position = UDim2.new(0, 5, 0, 0)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Parent = fixedBottomFrame
    
    local startButton = Instance.new("TextButton")
    startButton.Size = UDim2.new(1, -5, 0, 26)
    startButton.Position = UDim2.new(0, 0, 0, 0)
    startButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    startButton.BorderSizePixel = 0
    startButton.Text = "START"
    startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    startButton.TextSize = 11
    startButton.Font = Enum.Font.GothamBold
    startButton.Parent = buttonContainer
    
    local startCorner = Instance.new("UICorner")
    startCorner.CornerRadius = UDim.new(0, 5)
    startCorner.Parent = startButton
    
    local stopButton = Instance.new("TextButton")
    stopButton.Size = UDim2.new(1, -5, 0, 26)
    stopButton.Position = UDim2.new(0, 0, 0, 29)
    stopButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    stopButton.BorderSizePixel = 0
    stopButton.Text = "STOP"
    stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    stopButton.TextSize = 11
    stopButton.Font = Enum.Font.GothamBold
    stopButton.Parent = buttonContainer
    
    local stopCorner = Instance.new("UICorner")
    stopCorner.CornerRadius = UDim.new(0, 5)
    stopCorner.Parent = stopButton
    
    local statusContainer = Instance.new("Frame")
    statusContainer.Size = UDim2.new(1, -10, 0, 45)
    statusContainer.Position = UDim2.new(0, 5, 0, 60)
    statusContainer.BackgroundTransparency = 1
    statusContainer.Parent = fixedBottomFrame
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0, 24)
    statusLabel.Position = UDim2.new(0, 0, 0, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Ready to search..."
    statusLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
    statusLabel.TextSize = 9
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.TextWrapped = true
    statusLabel.Parent = statusContainer
    
    local apiStatusLabel = Instance.new("TextLabel")
    apiStatusLabel.Size = UDim2.new(1, 0, 0, 21)
    apiStatusLabel.Position = UDim2.new(0, 0, 0, 24)
    apiStatusLabel.BackgroundTransparency = 1
    apiStatusLabel.Text = string.format("API: %d/3 | Cache: %d", apiState.mainApiUses, #apiState.cachedServers)
    apiStatusLabel.TextColor3 = Color3.fromRGB(120, 120, 130)
    apiStatusLabel.TextSize = 8
    apiStatusLabel.Font = Enum.Font.Gotham
    apiStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
    apiStatusLabel.Parent = statusContainer
    
    local function updateScrollCanvas()
        local contentHeight = layout.AbsoluteContentSize.Y + 20
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
    end
    
    updateScrollCanvas()
    
    local function addButtonHover(button, hoverColor, originalColor)
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
        end)
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = originalColor}):Play()
        end)
    end
    
    addButtonHover(startButton, Color3.fromRGB(60, 180, 60), Color3.fromRGB(50, 150, 50))
    addButtonHover(stopButton, Color3.fromRGB(180, 60, 60), Color3.fromRGB(150, 50, 50))
    addButtonHover(closeButton, Color3.fromRGB(255, 80, 80), Color3.fromRGB(220, 60, 60))
    addButtonHover(minimizeButton, Color3.fromRGB(130, 130, 130), Color3.fromRGB(100, 100, 100))
    
    local function updateAPIStatus()
        apiStatusLabel.Text = string.format("API: %d/3 | Cache: %d | %s",
            apiState.mainApiUses,
            #apiState.cachedServers,
            apiState.useCachedServers and "Cache" or "Live"
        )
    end
    
    local hopConnection = nil
    
    local function startHopping()
        if isRunning then
            statusLabel.Text = "Already running!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 150, 100)
            return
        end
        
        if not isfile("hopStarted.txt") then
            showNotification("Search started", "Looking for target pets...")
            writefile("hopStarted.txt", "true")
        end
        
        isRunning = true
        statusLabel.Text = "Searching..."
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        
        hopConnection = task.spawn(function()
            while isRunning do
                runServerCheck()
                if #foundPodiumsData > 0 then
                    break
                end
                task.wait(0.1)
                updateAPIStatus()
            end
        end)
    end
    
    startButton.MouseButton1Click:Connect(startHopping)
    
    stopButton.MouseButton1Click:Connect(function()
        isRunning = false
        foundPodiumsData = {}
        autoHopping = false
        if currentConnection then
            currentConnection:Disconnect()
            currentConnection = nil
        end
        if monitoringConnection then
            monitoringConnection:Disconnect()
            monitoringConnection = nil
        end
        if hopConnection then
            task.cancel(hopConnection)
            hopConnection = nil
        end
        statusLabel.Text = "Search stopped."
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end)
    
    closeButton.MouseButton1Click:Connect(function()
        isRunning = false
        foundPodiumsData = {}
        autoHopping = false
        if currentConnection then
            currentConnection:Disconnect()
            currentConnection = nil
        end
        if monitoringConnection then
            monitoringConnection:Disconnect()
            monitoringConnection = nil
        end
        if hopConnection then
            task.cancel(hopConnection)
            hopConnection = nil
        end
        
        screenGui:Destroy()
    end)
    
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            mainFrame.Position = newPos
            
            guiState.position = {
                XScale = newPos.X.Scale,
                XOffset = newPos.X.Offset,
                YScale = newPos.Y.Scale,
                YOffset = newPos.Y.Offset
            }
            saveGUIState()
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    spawn(function()
        while screenGui.Parent do
            updateAPIStatus()
            task.wait(5)
        end
    end)
    
    _G.CloseHop = function()
        pcall(function()
            local playerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
            if playerGui then
                local hopperGui = playerGui:FindFirstChild("ServerHopperGUI")
                if hopperGui then
                    hopperGui:Destroy()
                end
            end
        end)
    end
    
    if settings.autoStart then
        task.wait(0.5)
        startHopping()
    end
end

loadSettings()
loadGUIState()
loadAPIState()

if game.PlaceId == ALLOWED_PLACE_ID then
    createSettingsGUI()
else
    
end
]],
})

table.insert(SCRIPTS, {
    name="Lagger", icon="📡", desc="LAG • SPIKE • TOGGLE", isNew=false, kind="embed",
    code=[[
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- GUI
local gui = Instance.new("ScreenGui", playerGui)

-- 🔴 ICON (SH)
local icon = Instance.new("TextButton", gui)
icon.Size = UDim2.new(0,55,0,55)
icon.Position = UDim2.new(0,20,0.5,-27)
icon.BackgroundColor3 = Color3.fromRGB(120,0,0)
icon.Text = "SH"
icon.TextColor3 = Color3.fromRGB(255,255,255)
icon.Font = Enum.Font.GothamBlack
icon.TextScaled = true
Instance.new("UICorner", icon).CornerRadius = UDim.new(1,0)

-- glow
local glow = Instance.new("UIStroke", icon)
glow.Color = Color3.fromRGB(255,50,50)

task.spawn(function()
	while true do
		TweenService:Create(glow, TweenInfo.new(1), {Thickness = 3}):Play()
		task.wait(1)
		TweenService:Create(glow, TweenInfo.new(1), {Thickness = 0}):Play()
		task.wait(1)
	end
end)

-- 📦 FRAME
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,210,0,160)
frame.Position = UDim2.new(0.5,-105,0.5,-80)
frame.BackgroundColor3 = Color3.fromRGB(10,0,20)
frame.Visible = false
frame.ClipsDescendants = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

-- gradient
local grad = Instance.new("UIGradient", frame)
grad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(90,0,140))
}

-- ⭐ STARS
task.spawn(function()
	while true do
		task.wait(0.1)
		local star = Instance.new("Frame", frame)
		star.Size = UDim2.new(0,2,0,2)
		star.Position = UDim2.new(math.random(),0,0,0)
		star.BackgroundColor3 = Color3.fromRGB(200,150,255)
		star.BorderSizePixel = 0
		TweenService:Create(star, TweenInfo.new(1), {
			Position = UDim2.new(star.Position.X.Scale,0,1,0),
			BackgroundTransparency = 1
		}):Play()
		game.Debris:AddItem(star,1)
	end
end)

-- TITLE
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0.25,0)
title.BackgroundTransparency = 1
title.Text = "shadow hub's Lagger"
title.TextColor3 = Color3.fromRGB(200,140,255)
title.Font = Enum.Font.GothamBlack
title.TextScaled = true

-- MODE TEXT
local modeText = Instance.new("TextLabel", frame)
modeText.Size = UDim2.new(1,0,0.15,0)
modeText.Position = UDim2.new(0,0,0.25,0)
modeText.BackgroundTransparency = 1
modeText.TextColor3 = Color3.fromRGB(150,100,255)
modeText.TextScaled = true

-- 🎚️ SLIDER
local slider = Instance.new("Frame", frame)
slider.Size = UDim2.new(0.9,0,0.12,0)
slider.Position = UDim2.new(0.05,0,0.7,0)
slider.BackgroundColor3 = Color3.fromRGB(40,0,60)
Instance.new("UICorner", slider).CornerRadius = UDim.new(1,0)

local fill = Instance.new("Frame", slider)
fill.Size = UDim2.new(1,0,1,0)
fill.BackgroundColor3 = Color3.fromRGB(180,120,255)
Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)

local txt = Instance.new("TextLabel", frame)
txt.Size = UDim2.new(1,0,0.2,0)
txt.Position = UDim2.new(0,0,0.5,0)
txt.BackgroundTransparency = 1
txt.Text = "Intensity: 100%"
txt.TextColor3 = Color3.fromRGB(180,120,255)
txt.TextScaled = true

local dragging = false
local intensity = 1

slider.InputBegan:Connect(function(i)
	if i.UserInputType.Name:find("Mouse") or i.UserInputType.Name:find("Touch") then
		dragging = true
	end
end)

slider.InputEnded:Connect(function()
	dragging = false
end)

UIS.InputChanged:Connect(function(i)
	if dragging then
		local x = math.clamp((i.Position.X - slider.AbsolutePosition.X)/slider.AbsoluteSize.X,0,1)
		fill.Size = UDim2.new(x,0,1,0)
		intensity = x
		txt.Text = "Intensity: "..math.floor(x*100).."%"
	end
end)

-- 🎮 SMART MODE DETECTION
local function isDuel()
	return #game.Players:GetPlayers() <= 2
end

-- TOGGLE
local running = false

local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0.5,0,0.15,0)
toggle.Position = UDim2.new(0.25,0,0.45,0)
toggle.Text = "ON"
toggle.BackgroundColor3 = Color3.fromRGB(20,0,30)
toggle.TextColor3 = Color3.fromRGB(180,120,255)
Instance.new("UICorner", toggle).CornerRadius = UDim.new(1,0)

toggle.MouseButton1Click:Connect(function()
	running = not running
	toggle.Text = running and "ON" or "OFF"

	if running then
		task.spawn(function()
			while running do
				task.wait(0.1)

				local char = player.Character
				if char and char:FindFirstChild("Humanoid") then
					local hum = char.Humanoid

					if isDuel() then
						modeText.Text = "Mode: DUEL (Performance)"
						hum.WalkSpeed = 16 + (2 * intensity)
					else
						modeText.Text = "Mode: NORMAL (FPS Boost)"
						hum.WalkSpeed = 16
						
						-- FPS boost style
						for _,v in pairs(workspace:GetDescendants()) do
							if v:IsA("ParticleEmitter") then
								v.Enabled = false
							end
						end
					end
				end
			end
		end)
	end
end)

-- 🔘 ICON TOGGLE
icon.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

-- 📱 HOLD DRAG ICON
local draggingIcon = false
local hold = false
local startPos, dragStart

icon.InputBegan:Connect(function(input)
	if input.UserInputType.Name:find("Mouse") or input.UserInputType.Name:find("Touch") then
		hold = true
		local t = tick()

		task.delay(0.15,function()
			if hold and tick()-t>=0.15 then
				draggingIcon = true
				startPos = icon.Position
				dragStart = input.Position
			end
		end)

		input.Changed:Connect(function()
			if input.UserInputState.Name=="End" then
				hold=false
				draggingIcon=false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if draggingIcon then
		local delta = input.Position - dragStart
		icon.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
	end
end)

-- 📦 DRAG UI
local draggingUI = false
local startUI, dragUI

frame.InputBegan:Connect(function(input)
	if input.UserInputType.Name:find("Mouse") or input.UserInputType.Name:find("Touch") then
		draggingUI = true
		startUI = frame.Position
		dragUI = input.Position

		input.Changed:Connect(function()
			if input.UserInputState.Name=="End" then
				draggingUI = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if draggingUI then
		local delta = input.Position - dragUI
		frame.Position = UDim2.new(startUI.X.Scale,startUI.X.Offset+delta.X,startUI.Y.Scale,startUI.Y.Offset+delta.Y)
	end
end)
]],
})

table.insert(SCRIPTS, {
    name="Insta Reset", icon="🔄", desc="INSTANT • RESET • BUTTON", isNew=false, kind="embed",
    code=[[
local lp = game.Players.LocalPlayer
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local pos = Vector3.new(0.076, 99997.35, -0.517)

local gui = Instance.new("ScreenGui", lp.PlayerGui)
gui.Name = "ir_gui"
gui.ResetOnSpawn = false

local b = Instance.new("TextButton", gui)
b.Size = UDim2.new(0, 160, 0, 45)
b.Position = UDim2.new(0.5, -80, 0.8, 0)
b.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
b.Text = "INSTA RESET"
b.TextColor3 = Color3.new(1, 1, 1)
b.Font = "Code"
b.TextSize = 18
Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)

-- Minimalistisches Dragging (weniger "KI-Standard")
local dragging, startPos, startInput
b.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		startInput = i.Position
		startPos = b.Position
	end
end)

uis.InputChanged:Connect(function(i)
	if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
		local delta = i.Position - startInput
		b.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

uis.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

-- Main Click
b.MouseButton1Click:Connect(function()
	local char = lp.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local carpet = lp.Backpack:FindFirstChild("Flying Carpet")
	if carpet then carpet.Parent = char end
	
	-- Instant TP & Physics Reset
	for i = 1, 6 do
		hrp.CFrame = CFrame.new(pos)
		hrp.AssemblyLinearVelocity = Vector3.zero
		rs.PreSimulation:Wait()
	end
end)
]],
})

table.insert(SCRIPTS, {
    name="Ice Hub Reset", icon="🧊", desc="INSTA RESPAWN • ICE • MOBILE", isNew=false, kind="embed",
    code=[[
-- // ICE HUB (Insta Respawn) — Reconstructed from trace + source logic //

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- // 1 (HiddenUI Container) //
local hiddenUI = Instance.new("Folder", CoreGui)
hiddenUI.Name = "HiddenUI"

local gui = Instance.new("ScreenGui", hiddenUI)
gui.Name = "IceHubGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999

-- // 2 (Main Frame) //
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromOffset(200, 180)
frame.Position = UDim2.new(0.5, -100, 0.75, -90)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.6
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- // 3 (Title) //
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -40, 0, 26)
title.Position = UDim2.fromOffset(12, 5)
title.BackgroundTransparency = 1
title.Text = "ICE HUB"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.new(1, 1, 1)
title.TextXAlignment = Enum.TextXAlignment.Left

-- // 4 (Insta Respawn Button) //
local respawnBtn = Instance.new("TextButton", frame)
respawnBtn.Size = UDim2.fromOffset(180, 40)
respawnBtn.Position = UDim2.new(0.5, -90, 0, 40)
respawnBtn.BackgroundColor3 = Color3.new(0, 0, 0)
respawnBtn.BackgroundTransparency = 0.5
respawnBtn.TextColor3 = Color3.new(1, 1, 1)
respawnBtn.Text = "INSTA RESPAWN"
respawnBtn.Font = Enum.Font.GothamBold
respawnBtn.TextSize = 14
respawnBtn.BorderSizePixel = 0
respawnBtn.AutoButtonColor = false
Instance.new("UICorner", respawnBtn).CornerRadius = UDim.new(0, 7)

-- // 5 (Keybind Button) //
local keybindBtn = Instance.new("TextButton", frame)
keybindBtn.Size = UDim2.fromOffset(180, 28)
keybindBtn.Position = UDim2.new(0.5, -90, 0, 88)
keybindBtn.BackgroundColor3 = Color3.new(0, 0, 0)
keybindBtn.BackgroundTransparency = 0.5
keybindBtn.TextColor3 = Color3.new(1, 1, 1)
keybindBtn.Text = "KeyBind: R"
keybindBtn.Font = Enum.Font.GothamMedium
keybindBtn.TextSize = 12
keybindBtn.BorderSizePixel = 0
keybindBtn.AutoButtonColor = false
Instance.new("UICorner", keybindBtn).CornerRadius = UDim.new(0, 5)

-- // 6 (Reset on Balloon Button) //
local balloonBtn = Instance.new("TextButton", frame)
balloonBtn.Size = UDim2.fromOffset(180, 28)
balloonBtn.Position = UDim2.new(0.5, -90, 0, 124)
balloonBtn.BackgroundColor3 = Color3.new(0, 0, 0)
balloonBtn.BackgroundTransparency = 0.5
balloonBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
balloonBtn.Text = "Reset on Balloon: OFF"
balloonBtn.Font = Enum.Font.GothamMedium
balloonBtn.TextSize = 12
balloonBtn.BorderSizePixel = 0
balloonBtn.AutoButtonColor = false
Instance.new("UICorner", balloonBtn).CornerRadius = UDim.new(0, 5)

-- // 7 (Minimize Button) //
local minBtn = Instance.new("TextButton", frame)
minBtn.Size = UDim2.fromOffset(26, 26)
minBtn.Position = UDim2.new(1, -30, 0, 5)
minBtn.BackgroundTransparency = 1
minBtn.Text = "-"
minBtn.TextColor3 = Color3.new(1, 1, 1)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 20
minBtn.BorderSizePixel = 0
minBtn.AutoButtonColor = false

-- // 8 (State Variables) //
local keybind = Enum.KeyCode.R
local balloonReset = false
local minimized = false
local rebinding = false
local FULL_H = 180
local MIN_H = 36
local deathCoords = CFrame.new(1000003.56, 999999.69, 8.17)
local lastTrigger = 0
local COOLDOWN = 3

-- // 9 (Remove Camera Blur) //
task.spawn(function()
	local cam = workspace.CurrentCamera
	if cam then
		for _, child in cam:GetChildren() do
			if child:IsA("BlurEffect") then child:Destroy() end
		end
		cam.ChildAdded:Connect(function(child)
			if child:IsA("BlurEffect") then child:Destroy() end
		end)
	end
end)

-- // 10 (Equip Carpet Helper) //
local function equipCarpet()
	local char = player.Character
	if not char then return end
	local backpack = player:FindFirstChild("Backpack")
	if backpack then
		for _, tool in ipairs(backpack:GetChildren()) do
			if tool:IsA("Tool") and tool.Name:lower():find("carpet") then
				char:FindFirstChildOfClass("Humanoid"):EquipTool(tool)
				return
			end
		end
	end
end

-- // 11 (TP + Die — Real Reset Method) //
local function tpAndDie()
	local char = player.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChild("Humanoid")
	if not hrp or not hum then return end
	respawnBtn.Text = "RESETTING..."
	equipCarpet()
	task.wait()
	hrp.CFrame = deathCoords
	local conn
	conn = RunService.Heartbeat:Connect(function()
		if not char or not char.Parent then conn:Disconnect() return end
		local h = char:FindFirstChild("Humanoid")
		local r = char:FindFirstChild("HumanoidRootPart")
		if not h or not r then conn:Disconnect() return end
		if h.Health <= 0 then
			conn:Disconnect()
			respawnBtn.Text = "INSTA RESPAWN"
			return
		end
		r.CFrame = deathCoords
	end)
end

-- // 12 (Respawn Button Click) //
respawnBtn.MouseButton1Click:Connect(tpAndDie)

-- // 13 (Keybind Rebind) //
keybindBtn.MouseButton1Click:Connect(function()
	rebinding = true
	keybindBtn.Text = "[...]"
	keybindBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
end)

-- // 14 (Balloon Toggle) //
balloonBtn.MouseButton1Click:Connect(function()
	balloonReset = not balloonReset
	if balloonReset then
		lastTrigger = tick()
		balloonBtn.Text = "Reset on Balloon: ON"
		balloonBtn.TextColor3 = Color3.new(1, 1, 1)
	else
		balloonBtn.Text = "Reset on Balloon: OFF"
		balloonBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
	end
end)

-- // 15 (Input Handler — Keybind + Rebind) //
UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
	if rebinding then
		keybind = input.KeyCode
		keybindBtn.Text = "KeyBind: " .. keybind.Name
		keybindBtn.TextColor3 = Color3.new(1, 1, 1)
		rebinding = false
		return
	end
	if input.KeyCode == keybind then
		tpAndDie()
	end
end)

-- // 16 (Minimize) //
minBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	TweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
		Size = UDim2.fromOffset(200, minimized and MIN_H or FULL_H)
	}):Play()
	minBtn.Text = minimized and "+" or "-"
	respawnBtn.Visible = not minimized
	keybindBtn.Visible = not minimized
	balloonBtn.Visible = not minimized
end)

-- // 17 (Dragging) //
do
	local dragging, dragStart, startPos
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)
end

-- // 18 (Balloon Text Detection) //
local function hasBalloon(text)
	if typeof(text) ~= "string" then return false end
	local lower = string.lower(text)
	return lower:find("balloon") ~= nil or lower:find("ballon") ~= nil
end

local function checkText(text)
	if not balloonReset then return end
	if not hasBalloon(text) then return end
	local now = tick()
	if now - lastTrigger < COOLDOWN then return end
	lastTrigger = now
	tpAndDie()
end

-- // 19 (PlayerGui Text Scanner) //
local function scanGuiObjects(parent)
	for _, obj in ipairs(parent:GetDescendants()) do
		if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
			checkText(obj.Text)
			obj:GetPropertyChangedSignal("Text"):Connect(function()
				checkText(obj.Text)
			end)
		end
	end
end

local function setupGuiWatcher(g)
	g.DescendantAdded:Connect(function(desc)
		task.wait()
		if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
			checkText(desc.Text)
			desc:GetPropertyChangedSignal("Text"):Connect(function()
				checkText(desc.Text)
			end)
		end
	end)
end

-- // 20 (Watch CoreGui) //
pcall(function()
	scanGuiObjects(CoreGui)
	setupGuiWatcher(CoreGui)
end)

-- // 21 (Watch Existing + New PlayerGui) //
for _, g in ipairs(PlayerGui:GetChildren()) do
	scanGuiObjects(g)
	setupGuiWatcher(g)
end

PlayerGui.ChildAdded:Connect(function(g)
	setupGuiWatcher(g)
	scanGuiObjects(g)
end)
]],
})

table.insert(SCRIPTS, {
    name="Kawatan Hub", icon="🔱", desc="ALL-IN-ONE • HUB", isNew=false, kind="http",
    code="loadstring(game:HttpGet(\"https://raw.githubusercontent.com/Chiron-ux/Kawatan/27919507c04a426f982eccf82e32b49bae400ebf/Kawatan\"))()",
})

table.insert(SCRIPTS, {
    name="OG Lucky Block", icon="⭐", desc="OG BLOCK • INJECT", isNew=false, kind="http",
    code="loadstring(game:HttpGet(\"https://raw.githubusercontent.com/platinww/CrustyMain/refs/heads/main/Steal-A-Brainrot/OGBlock.lua\"))()",
})

table.insert(SCRIPTS, {
    name="AP Spammer", icon="📢", desc="ADMIN • SPAM • TOOLS", isNew=false, kind="http",
    code="loadstring(game:HttpGet(\"https://raw.githubusercontent.com/Tokinu/Admin-Spammer/refs/heads/main/Tokinu\"))()",
})

table.insert(SCRIPTS, {
    name="ZZZZ Hub V2.3", icon="💤", desc="MULTI-TOOL • V2.3", isNew=false, kind="http",
    code="loadstring(game:HttpGet(\"https://api.luarmor.net/files/v4/loaders/51903b9ad68922379ca7ea76841e0a68.lua\"))()",
})

table.insert(SCRIPTS, {
    name="FPS Booster", icon="⚡", desc="FPS • OPTIMIZE • BOOST", isNew=false, kind="http",
    code="loadstring(game:HttpGet(\"https://pastefy.app/dWahW7sK/raw\"))()",
})

table.insert(SCRIPTS, {
    name="SK Auto Joiner", icon="🔗", desc="10M-1B • AUTO JOIN", isNew=false, kind="http",
    code="loadstring(game:HttpGet(\"https://api.jnkie.com/api/v1/luascripts/public/4412bf5b03484439b54771aa1b89e7bf8dd52b12759ac2f76d92f6e759c3e333/download\"))()",
})

table.insert(SCRIPTS, {
    name="Anti Lag", icon="🛡️", desc="LAG • REDUCE • SMOOTH", isNew=false, kind="http",
    code="loadstring(game:HttpGet(\"https://pastefy.app/yT46OCAj/raw\"))()",
})

table.insert(SCRIPTS, {
    name="OP Auto Dual", icon="🔥", desc="OP • AUTO • DUAL", isNew=false, kind="http",
    code="loadstring(game:HttpGet(\"https://pastebin.com/raw/E05dV3da\", true))()",
})

table.insert(SCRIPTS, {
    name="Kurd Hub", icon="🌙", desc="MULTI • TOOL • HUB", isNew=false, kind="http",
    code="loadstring(game:HttpGet(\"https://raw.githubusercontent.com/Ninja10908/S4/refs/heads/main/Kurdhub\"))()",
})

table.insert(SCRIPTS, {
    name="Bk's Hub", icon="👑", desc="BK • HUB • TOOLS", isNew=false, kind="http",
    code="loadstring(game:HttpGet(\"https://raw.githubusercontent.com/xenji0hub/XENJI-BKS-HUB/refs/heads/main/XENJI%20BKS%20HUB\"))()",
})

table.insert(SCRIPTS, {
    name="Ajjan Hub", icon="🎯", desc="MULTI • TOOL • HUB", isNew=false, kind="http",
    code="loadstring(game:HttpGet(\"https://raw.githubusercontent.com/onliengamerop/Steal-a-brainrot/refs/heads/main/Protected_3771863424757750.lua.txt\"))()",
})

table.insert(SCRIPTS, {
    name="Lagger HttpGet", icon="📡", desc="35% SPEED • 15% INTENSITY", isNew=false, kind="http",
    code="loadstring(game:HttpGet(\"https://api.luarmor.net/files/v4/loaders/8a38a001b620d73c352fbd5ddb5cdf23.lua\"))()",
})

table.insert(SCRIPTS, {
    name="Nameless Hub", icon="🌐", desc="ALL-IN-ONE • HUB • TOOLS", isNew=false, kind="http",
    code="loadstring(game:HttpGet(\"https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr\"))()",
})

table.insert(SCRIPTS, {
    name="Mango Hub", icon="🥭", desc="AUTO • COMBAT • TOOLS", isNew=false, kind="http",
    code="loadstring(game:HttpGet(\"https://api.luarmor.net/files/v4/loaders/36b1e8d301d50234eede4210e85cb57e.lua\"))()",
})

table.insert(SCRIPTS, {
    name="Brainrot Spawner", icon="🧬", desc="SPAWN • BRAINROT • ADMIN", isNew=false, kind="http",
    code="loadstring(game:HttpGet(\"https://raw.githubusercontent.com/platinww/CrustyMain/refs/heads/main/Steal-A-Brainrot/Spawner/Spawner.lua\"))()",
})

table.insert(SCRIPTS, {
    name="Kuni Hub", icon="⚔️", desc="KUNI • HUB • TOOLS", isNew=false, kind="http",
    code="loadstring(game:HttpGet(\"https://raw.githubusercontent.com/Script-exe-rblx/KuniHub/refs/heads/main/lua\"))()",
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
