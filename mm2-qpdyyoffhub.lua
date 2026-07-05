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
    ESP = false,
    HG = false,
    Fly = false,
    Noclip = false,
    InfJump = false,
    Fling = false,
    SpdOn = false,
    FovOn = false,
    Fog = false,
    Psy = false
}

local flySpeed = 45
local walkSpeedValue = 16
local fovValue = 70
local timeOfDayValue = 14
local brightnessValue = 2

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
if PlayerGui:FindFirstChild("QPHub") then 
    PlayerGui.QPHub:Destroy() 
end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "QPHub"
ScreenGui.ResetOnSpawn = false

-- АНИМИРОВАННОЕ ПОЛУПРОЗРАЧНОЕ ИНТРО
local IntroFrame = Instance.new("Frame", ScreenGui)
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.Position = UDim2.new(0, 0, 0, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
IntroFrame.BackgroundTransparency = 1
IntroFrame.BorderSizePixel = 0
IntroFrame.ZIndex = 100

local IntroTitle = Instance.new("TextLabel", IntroFrame)
IntroTitle.Size = UDim2.new(1, 0, 0, 50)
IntroTitle.Position = UDim2.new(0, 0, 0.4, 0)
IntroTitle.Text = "MM2 QPDYYHUB"
IntroTitle.TextColor3 = Color3.fromRGB(255, 50, 50)
IntroTitle.Font = Enum.Font.SourceSansBold
IntroTitle.TextSize = 36
IntroTitle.BackgroundTransparency = 1
IntroTitle.ZIndex = 101
IntroTitle.TextTransparency = 1

local IntroSub = Instance.new("TextLabel", IntroFrame)
IntroSub.Size = UDim2.new(1, 0, 0, 30)
IntroSub.Position = UDim2.new(0, 0, 0.5, 0)
IntroSub.Text = "tg: @qpdyy_off_scripts"
IntroSub.TextColor3 = Color3.fromRGB(200, 200, 200)
IntroSub.Font = Enum.Font.SourceSansBold
IntroSub.TextSize = 18
IntroSub.BackgroundTransparency = 1
IntroSub.ZIndex = 101
IntroSub.TextTransparency = 1

TweenService:Create(IntroFrame, TweenInfo.new(0.5), {BackgroundTransparency = 0.35}):Play()
TweenService:Create(IntroTitle, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
TweenService:Create(IntroSub, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

task.spawn(function()
    task.wait(2.5)
    TweenService:Create(IntroFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(IntroTitle, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(IntroSub, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    task.wait(0.5)
    IntroFrame:Destroy()
end)

-- ГЛАВНОЕ МЕНЮ
local MainFrame = Instance.new("Frame", ScreenGui)
local defaultSize = UDim2.new(0, 440, 0, 320)
MainFrame.Size = defaultSize
MainFrame.Position = UDim2.new(0.5, -220, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local TitleBar = Instance.new("TextLabel", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.Text = "tg: @qpdyy_off_scripts"
TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.Font = Enum.Font.SourceSansBold
TitleBar.TextSize = 14
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 14)

-- СТИЛЬНАЯ ЧЕРНО-БЕЛАЯ КНОПКА-НОЖИК (ЗАМЕНА QP)
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 55, 0, 55)
OpenBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Глубокий черный
OpenBtn.Text = "🔪"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255) -- Белый нож
OpenBtn.Font = Enum.Font.SourceSansBold
OpenBtn.TextSize = 24
OpenBtn.Visible = false
OpenBtn.Active = true
OpenBtn.Draggable = true
OpenBtn.ZIndex = 500
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 50)
local OpenBorder = Instance.new("UIStroke", OpenBtn)
OpenBorder.Color = Color3.fromRGB(240, 240, 240) -- Белая аккуратная обводка
OpenBorder.Width = 2

local MinimizeBtn = Instance.new("TextButton", MainFrame)
MinimizeBtn.Size = UDim2.new(0, 26, 0, 26)
MinimizeBtn.Position = UDim2.new(1, -62, 0, 9)
MinimizeBtn.Text = "-"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.TextSize = 18
MinimizeBtn.BorderSizePixel = 0
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 50)

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -32, 0, 9)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(90, 35, 35)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 14
CloseBtn.BorderSizePixel = 0
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 50)

-- УСТОЙЧИВАЯ ЛОГИКА АНИМАЦИИ ОКНА
local isTweening = false

local function toggleUI(open)
    if isTweening then return end
    isTweening = true
    
    if not open then
        local targetPos = OpenBtn.Position
        local tweenMain = TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(targetPos.X.Scale, targetPos.X.Offset + 27, targetPos.Y.Scale, targetPos.Y.Offset + 27)
        })
        tweenMain:Play()
        tweenMain.Completed:Connect(function()
            MainFrame.Visible = false
            OpenBtn.BackgroundTransparency = 1
            OpenBtn.TextTransparency = 1
            OpenBorder.Transparency = 1
            OpenBtn.Visible = true
            
            TweenService:Create(OpenBtn, TweenInfo.new(0.25), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
            TweenService:Create(OpenBorder, TweenInfo.new(0.25), {Transparency = 0}):Play()
            isTweening = false
        end)
    else
        local startPos = OpenBtn.Position
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + 27, startPos.Y.Scale, startPos.Y.Offset + 27)
        MainFrame.Visible = true
        
        TweenService:Create(OpenBtn, TweenInfo.new(0.2), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        TweenService:Create(OpenBorder, TweenInfo.new(0.2), {Transparency = 1}):Play()
        
        local tweenMain = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = defaultSize,
            Position = UDim2.new(0.5, -defaultSize.X.Offset/2, 0.5, -defaultSize.Y.Offset/2)
        })
        tweenMain:Play()
        tweenMain.Completed:Connect(function()
            OpenBtn.Visible = false
            isTweening = false
        end)
    end
end

MinimizeBtn.MouseButton1Click:Connect(function()
    toggleUI(false)
end)

local function onOpenTriggered()
    if OpenBtn.Visible and not isTweening then
        toggleUI(true)
    end
end

OpenBtn.MouseButton1Click:Connect(onOpenTriggered)
OpenBtn.TouchTap:Connect(onOpenTriggered)

CloseBtn.MouseButton1Click:Connect(function()
    if isTweening then return end
    isTweening = true
    local tweenClose = TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    })
    tweenClose:Play()
    tweenClose.Completed:Connect(function()
        ScreenGui:Destroy()
    end)
end)

-- ВКЛАДКИ С ИКОНКАМИ
local tabs = {
    {Name = "Player", Icon = "👤"},
    {Name = "ESP", Icon = "🎯"},
    {Name = "Teleport", Icon = "🌀"},
    {Name = "Effects", Icon = "✨"}
}
local pages = {}

local TabFrame = Instance.new("Frame", MainFrame)
TabFrame.Size = UDim2.new(0, 110, 1, -55)
TabFrame.Position = UDim2.new(0, 5, 0, 50)
TabFrame.BackgroundTransparency = 1

for i, tabData in ipairs(tabs) do
    local tName = tabData.Name
    local TabBtn = Instance.new("TextButton", TabFrame)
    TabBtn.Size = UDim2.new(1, -5, 0, 35)
    TabBtn.Position = UDim2.new(0, 0, 0, (i - 1) * 40)
    TabBtn.Text = tabData.Icon .. " " .. tName
    TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    TabBtn.Font = Enum.Font.SourceSansBold
    TabBtn.TextSize = 13
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

    local PageContainer = Instance.new("ScrollingFrame", MainFrame)
    PageContainer.Size = UDim2.new(1, -130, 1, -60)
    PageContainer.Position = UDim2.new(0, 120, 0, 50)
    PageContainer.BackgroundTransparency = 1
    PageContainer.BorderSizePixel = 0
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

-- КОНСТРУКТОР КНОПОК
local function createButton(tab, name, y, flag)
    local b = Instance.new("TextButton", pages[tab])
    b.Size = UDim2.new(1, -10, 0, 38)
    b.Position = UDim2.new(0, 5, 0, y)
    b.Text = name
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    b.TextColor3 = Color3.fromRGB(200, 200, 200)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 14
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)

    b.MouseButton1Click:Connect(function()
        Flags[flag] = not Flags[flag]
        local targetColor = Flags[flag] and Color3.fromRGB(46, 117, 89) or Color3.fromRGB(35, 35, 35)
        TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
    end)
    return b
end

createButton("Player", "Fly Control", 5, "Fly")
createButton("Player", "Noclip Walls", 50, "Noclip")
createButton("Player", "Infinite Jump", 95, "InfJump")
createButton("Player", "Fling Mode", 140, "Fling")

createButton("ESP", "Activate ESP", 5, "ESP")
createButton("ESP", "Highlight Gun", 50, "HG")

-- КОНСТРУКТОР ПОЛЗУНКОВ
local function createSlider(tab, name, y, min, max, def, flag)
    local lab = Instance.new("TextLabel", pages[tab])
    lab.Size = UDim2.new(1, -10, 0, 20)
    lab.Position = UDim2.new(0, 5, 0, y)
    lab.Text = name .. ": " .. def
    lab.BackgroundTransparency = 1
    lab.TextColor3 = Color3.fromRGB(200, 200, 200)
    lab.Font = Enum.Font.SourceSansBold
    lab.TextSize = 12

    local bg = Instance.new("Frame", pages[tab])
    bg.Size = UDim2.new(1, -20, 0, 8)
    bg.Position = UDim2.new(0, 10, 0, y + 22)
    bg.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    bg.BorderSizePixel = 0
    Instance.new("UICorner", bg)

    local fil = Instance.new("Frame", bg)
    fil.Size = UDim2.new((def - min) / (max - min), 0, 1, 0)
    fil.BackgroundColor3 = Color3.fromRGB(0, 160, 100)
    fil.BorderSizePixel = 0
    Instance.new("UICorner", fil)

    local btn = Instance.new("TextButton", bg)
    btn.Size = UDim2.new(0, 14, 0, 14)
    btn.Position = UDim2.new((def - min) / (max - min), -7, 0, -3)
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = ""
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 50)

    local drag = false
    btn.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then 
            drag = true 
        end
    end)

    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then 
            drag = false 
        end
    end)

    UserInputService.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local cp = i.Position.X
            local gp = bg.AbsolutePosition.X
            local gw = bg.AbsoluteSize.X
            local pct = math.clamp((cp - gp) / gw, 0, 1)
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

    local ab = Instance.new("TextButton", pages[tab])
    ab.Size = UDim2.new(1, -10, 0, 30)
    ab.Position = UDim2.new(0, 5, 0, y + 35)
    ab.Text = "Apply " .. name
    ab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ab.TextColor3 = Color3.fromRGB(255, 255, 255)
    ab.Font = Enum.Font.SourceSansBold
    ab.TextSize = 13
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
        local targetC = act and Color3.fromRGB(46, 117, 89) or Color3.fromRGB(50, 50, 50)
        TweenService:Create(ab, TweenInfo.new(0.2), {BackgroundColor3 = targetC}):Play()
    end)
end

createSlider("Player", "Speedhack", 185, 5, 100, 16, "S")
createSlider("Player", "FOV Config", 255, 70, 120, 70, "F")

-- ЛОГИКА ТЕЛЕПОРТА
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
    local b = Instance.new("TextButton", pages["Teleport"])
    b.Size = UDim2.new(1, -10, 0, 38)
    b.Position = UDim2.new(0, 5, 0, y)
    b.Text = name
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    b.TextColor3 = Color3.fromRGB(230, 230, 230)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 14
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)

    b.MouseButton1Click:Connect(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if targetMode == "R" then
                local allPlrs = Players:GetPlayers()
                if #allPlrs > 1 then
                    local randomPlr = allPlrs[math.random(1, #allPlrs)]
                    while randomPlr == LocalPlayer do
                        randomPlr = allPlrs[math.random(1, #allPlrs)]
                    end
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

-- Вкладка Эффектов
createButton("Effects", "Psycho Sky", 5, "Psy")
createButton("Effects", "Colored Fog", 50, "Fog")
createSlider("Effects", "Time of Day", 95, 0, 23, 14, "T")
createSlider("Effects", "Brightness", 165, 0, 10, 2, "B")

-- РЕСАЙЗ МЕНЮ
local ResizeArea = Instance.new("Frame", MainFrame)
ResizeArea.Size = UDim2.new(0, 16, 0, 16)
ResizeArea.Position = UDim2.new(1, -16, 1, -16)
ResizeArea.BackgroundTransparency = 1
ResizeArea.ZIndex = 100

local isResizing = false
local startSize, startPos

ResizeArea.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isResizing = true
        startSize = MainFrame.Size
        startPos = input.Position
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isResizing = false
        defaultSize = MainFrame.Size
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isResizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - startPos
        local nextWidth = math.clamp(startSize.X.Offset + delta.X, 300, 600)
        local nextHeight = math.clamp(startSize.Y.Offset + delta.Y, 250, 500)
        MainFrame.Size = UDim2.new(0, nextWidth, 0, nextHeight)
        TabFrame.Size = UDim2.new(0, 110, 1, -55)
        for _, p in pairs(pages) do
            p.Size = UDim2.new(1, -130, 1, -60)
        end
    end
end)

-- ИСПРАВЛЕННЫЙ ЦИКЛ ESP (БЕЗ МИГАНИЙ)
local function applyESP(player)
    if player == LocalPlayer then return end
    
    local function setupHighlight(character)
        if not character then return end
        local root = character:WaitForChild("HumanoidRootPart", 5)
        if not root then return end

        local highlight = character:FindFirstChild("ESPH") or Instance.new("Highlight")
        highlight.Name = "ESPH"
        highlight.FillTransparency = 0.4
        highlight.OutlineTransparency = 0
        highlight.Parent = character

        local role = getPlayerRole(player)
        local clr = Colors[role]
        
        if Flags.ESP or (Flags.HG and role == "S") then
            highlight.Enabled = true
            highlight.FillColor = clr
            highlight.OutlineColor = clr
        else
            highlight.Enabled = false
        end
    end

    if player.Character then setupHighlight(player.Character) end
    player.CharacterAdded:Connect(setupHighlight)
end

for _, p in ipairs(Players:GetPlayers()) do applyESP(p) end
Players.PlayerAdded:Connect(applyESP)

-- Динамическое обновление состояния ESP без пересоздания объектов
task.spawn(function()
    while task.wait(0.3) do
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local highlight = p.Character:FindFirstChild("ESPH")
                local role = getPlayerRole(p)
                local clr = Colors[role]

                if highlight then
                    if Flags.ESP or (Flags.HG and role == "S") then
                        highlight.Enabled = true
                        highlight.FillColor = clr
                        highlight.OutlineColor = clr
                    else
                        highlight.Enabled = false
                    end
                end
            end
        end
    end
end)

-- ОСТАЛЬНЫЕ ИГРОВЫЕ ЦИКЛЫ
task.spawn(function()
    while task.wait(0.1) do
        if Flags.InfJump and LocalPlayer.Character then
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Jump then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

local bodyVel, bodyGyro
RunService.Stepped:Connect(function()
    local character = LocalPlayer.Character
    if not character then return end

    if Flags.Noclip then
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
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
        
        if hum.MoveDirection.Magnitude > 0 then
            local camCFrame = workspace.CurrentCamera.CFrame
            local direction = camCFrame:VectorToWorldSpace(Vector3.new(hum.MoveDirection.X, 0, hum.MoveDirection.Z))
            
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                direction = direction + Vector3.new(0, 1, 0)
            end
            
            bodyVel.Velocity = direction.Unit * flySpeed
        else
            bodyVel.Velocity = Vector3.new(0, 0, 0)
        end
    else
        if bodyVel then bodyVel:Destroy(); bodyVel = nil end
        if bodyGyro then bodyGyro:Destroy(); bodyGyro = nil end
        if hum and hum.PlatformStand then hum.PlatformStand = false end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if Flags.Fog then
            Lighting.FogEnd = 150
            Lighting.FogColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        else
            Lighting.FogEnd = 100000
        end
        if Flags.Psy then
            Lighting.Ambient = Color3.fromHSV(tick() % 3 / 3, 1, 1)
        else
            Lighting.Ambient = Color3.fromRGB(128, 128, 128)
        end
    end
end)
