local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local Colors = {
    M = Color3.fromRGB(255, 50, 50),
    S = Color3.fromRGB(0, 200, 255),
    I = Color3.fromRGB(50, 255, 50)
}

local Flags = {
    ESP = false, HG = false, Fly = false, Noclip = false,
    InfJump = false, Fling = false, SpdOn = false, FovOn = false,
    Fog = false, Psy = false
}

local flySpeed = 45
local walkSpeedValue = 16
local fovValue = 70
local timeOfDayValue = 14
local brightnessValue = 2
local isTweening = false

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
if PlayerGui:FindFirstChild("QPHub") then 
    PlayerGui.QPHub:Destroy() 
end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "QPHub"
ScreenGui.ResetOnSpawn = false

-- Кнопка QH
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleBtn.Text = "QH"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 18
ToggleBtn.Visible = false
ToggleBtn.Active = true
ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

-- Окно
local MainFrame = Instance.new("Frame", ScreenGui)
local defaultSize = UDim2.new(0, 440, 0, 320)
MainFrame.Size = defaultSize
MainFrame.Position = UDim2.new(0.5, -220, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local TitleBar = Instance.new("TextLabel", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.Text = "tg: @qpdyy_off_scripts"
TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.Font = Enum.Font.SourceSansBold
TitleBar.TextSize = 14
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 14)

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -35, 0, 9)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(90, 35, 35)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 50)

local MinimizeBtn = Instance.new("TextButton", MainFrame)
MinimizeBtn.Size = UDim2.new(0, 26, 0, 26)
MinimizeBtn.Position = UDim2.new(1, -67, 0, 9)
MinimizeBtn.Text = "-"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 50)

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    ToggleBtn.Visible = true
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    ToggleBtn.Visible = false
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local tabs = {"Player", "ESP", "Teleport", "Effects"}
local pages = {}

local TabFrame = Instance.new("Frame", MainFrame)
TabFrame.Size = UDim2.new(0, 110, 1, -55)
TabFrame.Position = UDim2.new(0, 5, 0, 50)
TabFrame.BackgroundTransparency = 1

for i, tName in ipairs(tabs) do
    local TabBtn = Instance.new("TextButton", TabFrame)
    TabBtn.Size = UDim2.new(1, -5, 0, 35)
    TabBtn.Position = UDim2.new(0, 0, 0, (i - 1) * 40)
    TabBtn.Text = tName
    TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    TabBtn.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

    local PageContainer = Instance.new("ScrollingFrame", MainFrame)
    PageContainer.Size = UDim2.new(1, -130, 1, -60)
    PageContainer.Position = UDim2.new(0, 120, 0, 50)
    PageContainer.BackgroundTransparency = 1
    PageContainer.CanvasSize = UDim2.new(0, 0, 0, 400)
    PageContainer.Visible = false
    PageContainer.ScrollBarThickness = 2
    pages[tName] = PageContainer

    if i == 1 then
        PageContainer.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end

    TabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        PageContainer.Visible = true
        for _, b in ipairs(TabFrame:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                b.TextColor3 = Color3.fromRGB(180, 180, 180)
            end
        end
        TabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
end

local function createButton(tab, name, y, flag)
    local p = pages[tab]
    if not p then return end
    
    local b = Instance.new("TextButton", p)
    b.Size = UDim2.new(1, -10, 0, 38)
    b.Position = UDim2.new(0, 5, 0, y)
    b.Text = name
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    b.TextColor3 = Color3.fromRGB(200, 200, 200)
    b.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)

    b.MouseButton1Click:Connect(function()
        Flags[flag] = not Flags[flag]
        b.BackgroundColor3 = Flags[flag] and Color3.fromRGB(46, 117, 89) or Color3.fromRGB(35, 35, 35)
    end)
    return b
end

createButton("Player", "Fly Control", 5, "Fly")
createButton("Player", "Noclip Walls", 50, "Noclip")
createButton("Player", "Infinite Jump", 95, "InfJump")
createButton("Player", "Fling Mode", 140, "Fling")

createButton("ESP", "Activate ESP", 5, "ESP")
createButton("ESP", "Highlight Gun", 50, "HG")

local function createSlider(tab, name, y, min, max, def, flag)
    local p = pages[tab]
    if not p then return end

    local lab = Instance.new("TextLabel", p)
    lab.Size = UDim2.new(1, -10, 0, 20)
    lab.Position = UDim2.new(0, 5, 0, y)
    lab.Text = name .. ": " .. def
    lab.BackgroundTransparency = 1
    lab.TextColor3 = Color3.fromRGB(200, 200, 200)
    lab.Font = Enum.Font.SourceSansBold

    local bg = Instance.new("Frame", p)
    bg.Size = UDim2.new(1, -20, 0, 8)
    bg.Position = UDim2.new(0, 10, 0, y + 22)
    bg.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", bg)

    local fil = Instance.new("Frame", bg)
    fil.Size = UDim2.new((def - min) / (max - min), 0, 1, 0)
    fil.BackgroundColor3 = Color3.fromRGB(0, 160, 100)
    Instance.new("UICorner", fil)

    local btn = Instance.new("TextButton", bg)
    btn.Size = UDim2.new(0, 14, 0, 14)
    btn.Position = UDim2.new((def - min) / (max - min), -7, 0, -3)
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = ""
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 50)

    local drag = false
    btn.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = true end
    end)

    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = false end
    end)

    UserInputService.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local pct = math.clamp((i.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
            btn.Position = UDim2.new(pct, -7, 0, -3)
            fil.Size = UDim2.new(pct, 0, 1, 0)
            local val = math.floor(min + (max - min) * pct)
            lab.Text = name .. ": " .. val

            if flag == "S" then walkSpeedValue = val 
            elseif flag == "F" then fovValue = val 
            elseif flag == "T" then timeOfDayValue = val 
            elseif flag == "B" then brightnessValue = val end

            if Flags.SpdOn and flag == "S" and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = walkSpeedValue
            end
            if Flags.FovOn and flag == "F" then workspace.CurrentCamera.FieldOfView = fovValue end
            if flag == "T" then Lighting.TimeOfDay = timeOfDayValue .. ":00:00" end
            if flag == "B" then Lighting.Brightness = brightnessValue end
        end
    end)

    local ab = Instance.new("TextButton", p)
    ab.Size = UDim2.new(1, -10, 0, 30)
    ab.Position = UDim2.new(0, 5, 0, y + 35)
    ab.Text = "Toggle " .. name
    ab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ab.TextColor3 = Color3.fromRGB(255, 255, 255)
    ab.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", ab).CornerRadius = UDim.new(0, 6)

    ab.MouseButton1Click:Connect(function()
        local act = false
        if flag == "S" then
            Flags.SpdOn = not Flags.SpdOn
            act = Flags.SpdOn
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = act and walkSpeedValue or 16
            end
        elseif flag == "F" then
            Flags.FovOn = not Flags.FovOn
            act = Flags.FovOn
            workspace.CurrentCamera.FieldOfView = act and fovValue or 70
        end
        ab.BackgroundColor3 = act and Color3.fromRGB(46, 117, 89) or Color3.fromRGB(50, 50, 50)
    end)
end

createSlider("Player", "Speedhack", 185, 5, 100, 16, "S")
createSlider("Player", "FOV Config", 255, 70, 120, 70, "F")

local function getPlayerRole(p)
    local b = p:FindFirstChild("Backpack")
    local ch = p.Character
    if (b and b:FindFirstChild("Knife")) or (ch and ch:FindFirstChild("Knife")) then return "M" end
    if (b and b:FindFirstChild("Gun")) or (ch and ch:FindFirstChild("Gun")) then return "S" end
    return "I"
end

local function tpTo(role)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            if getPlayerRole(p) == role then
                LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
                return
            end
        end
    end
end

local function createTpButton(name, y, targetMode)
    local p = pages["Teleport"]
    if not p then return end

    local b = Instance.new("TextButton", p)
    b.Size = UDim2.new(1, -10, 0, 38)
    b.Position = UDim2.new(0, 5, 0, y)
    b.Text = name
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    b.TextColor3 = Color3.fromRGB(230, 230, 230)
    b.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)

    b.MouseButton1Click:Connect(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if targetMode == "R" then
                local allPlrs = Players:GetPlayers()
                if #allPlrs > 1 then
                    local randomPlr = allPlrs[math.random(1, #allPlrs)]
                    while randomPlr == LocalPlayer do randomPlr = allPlrs[math.random(1, #allPlrs)] end
                    if randomPlr.Character and randomPlr.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = randomPlr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
                    end
                end
            else
                tpTo(targetMode)
            end
        end
    end)
end

createTpButton("Teleport to Murderer", 5, "M")
createTpButton("Teleport to Sheriff", 50, "S")
createTpButton("Teleport to Random Player", 95, "R")

createButton("Effects", "Psycho Sky", 5, "Psy")
createButton("Effects", "Colored Fog", 50, "Fog")
createSlider("Effects", "Time of Day", 95, 0, 23, 14, "T")
createSlider("Effects", "Brightness", 165, 0, 10, 2, "B")

local function applyESP(player)
    if player == LocalPlayer then return end
    local function updateHighlight(character)
        if not character then return end
        local highlight = character:FindFirstChild("ESPH") or Instance.new("Highlight")
        highlight.Name = "ESPH"
        highlight.FillTransparency = 0.4
        highlight.OutlineTransparency = 0
        highlight.Parent = character
        local role = getPlayerRole(player)
        highlight.FillColor = Colors[role] or Colors.I
        highlight.OutlineColor = Colors[role] or Colors.I
        highlight.Enabled = (Flags.ESP or (Flags.HG and role == "S"))
    end
    player.CharacterAdded:Connect(updateHighlight)
    if player.Character then updateHighlight(player.Character) end
end

for _, p in ipairs(Players:GetPlayers()) do applyESP(p) end
Players.PlayerAdded:Connect(applyESP)

task.spawn(function()
    while task.wait(0.5) do
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local highlight = p.Character:FindFirstChild("ESPH")
                if highlight then
                    local role = getPlayerRole(p)
                    highlight.Enabled = (Flags.ESP or (Flags.HG and role == "S"))
                    highlight.FillColor = Colors[role]
                    highlight.OutlineColor = Colors[role]
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if Flags.InfJump and LocalPlayer.Character then
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Jump then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end
end)

local bodyVel, bodyGyro
RunService.Stepped:Connect(function()
    local character = LocalPlayer.Character
    if not character then return end

    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then part.CanCollide = not Flags.Noclip end
    end

    local hum = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")

    if Flags.Fling and root then
        root.RotVelocity = Vector3.new(0, 50000, 0)
        root.Velocity = Vector3.new(root.Velocity.X, 0, root.Velocity.Z) 
    end

    if Flags.Fly and root and hum then
        if not bodyVel then
            bodyVel = Instance.new("BodyVelocity", root)
            bodyVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bodyGyro = Instance.new("BodyGyro", root)
            bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        end
        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
        hum.PlatformStand = true
        local direction = hum.MoveDirection.Magnitude > 0 and workspace.CurrentCamera.CFrame.LookVector or Vector3.new(0,0,0)
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
        bodyVel.Velocity = direction.Magnitude > 0 and direction.Unit * flySpeed or Vector3.new(0,0,0)
    else
        if bodyVel then bodyVel:Destroy(); bodyVel = nil end
        if bodyGyro then bodyGyro:Destroy(); bodyGyro = nil end
        if hum and hum.PlatformStand then hum.PlatformStand = false end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        Lighting.FogEnd = Flags.Fog and 150 or 100000
        if Flags.Fog then Lighting.FogColor = Color3.fromHSV(tick() % 5 / 5, 1, 1) end
        Lighting.Ambient = Flags.Psy and Color3.fromHSV(tick() % 3 / 3, 1, 1) or Color3.fromRGB(128, 128, 128)
    end
end)
