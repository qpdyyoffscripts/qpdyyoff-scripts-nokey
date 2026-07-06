local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Очистка старого GUI
if CoreGui:FindFirstChild("MobileScreenClicker") then
    CoreGui.MobileScreenClicker:Destroy()
end

local autoClicking = false

-- === СОЗДАНИЕ GUI ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MobileScreenClicker"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -100, 0.2, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 190)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 5)
Title.Size = UDim2.new(1, -35, 0, 25) -- Оставили место под кнопку сворачивания
Title.Font = Enum.Font.GothamBold
Title.Text = "Auto Clicker"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Center

-- Telegram подпись
local TgLabel = Instance.new("TextLabel")
TgLabel.Parent = MainFrame
TgLabel.BackgroundTransparency = 1
TgLabel.Position = UDim2.new(0, 0, 0, 28)
TgLabel.Size = UDim2.new(1, 0, 0, 15)
TgLabel.Font = Enum.Font.GothamSemibold
TgLabel.Text = "tg: @qpdyy_off_scripts"
TgLabel.TextColor3 = Color3.fromRGB(130, 170, 255)
TgLabel.TextSize = 11

-- Кнопка СВЕРНУТЬ (внутри MainFrame)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = MainFrame
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Position = UDim2.new(1, -30, 0, 5)
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
MinimizeBtn.TextSize = 16

-- Настройка CPS
local CpsLabel = Instance.new("TextLabel")
CpsLabel.Parent = MainFrame
CpsLabel.BackgroundTransparency = 1
CpsLabel.Position = UDim2.new(0.05, 0, 0.28, 0)
CpsLabel.Size = UDim2.new(0.55, 0, 0, 30)
CpsLabel.Font = Enum.Font.Gotham
CpsLabel.Text = "Clicks/sec (CPS):"
CpsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
CpsLabel.TextSize = 12
CpsLabel.TextXAlignment = Enum.TextXAlignment.Left

local CpsInput = Instance.new("TextBox")
CpsInput.Parent = MainFrame
CpsInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CpsInput.Position = UDim2.new(0.65, 0, 0.28, 0)
CpsInput.Size = UDim2.new(0.3, 0, 0, 30)
CpsInput.Font = Enum.Font.GothamBold
CpsInput.Text = "10"
CpsInput.TextColor3 = Color3.fromRGB(255, 255, 255)
CpsInput.TextSize = 14

local CpsCorner = Instance.new("UICorner")
CpsCorner.CornerRadius = UDim.new(0, 6)
CpsCorner.Parent = CpsInput

-- Кнопка Старт/Стоп
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = MainFrame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 80)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 40)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "START"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 18

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleBtn

-- Кнопка закрытия
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
CloseBtn.Position = UDim2.new(0.1, 0, 0.77, 0)
CloseBtn.Size = UDim2.new(0.8, 0, 0, 30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "CLOSE"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 13

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn


-- === КРУЖОК СВЕРНУТОГО РЕЖИМА (QP) ===
local MinimizeCircle = Instance.new("TextButton")
MinimizeCircle.Name = "MinimizeCircle"
MinimizeCircle.Parent = ScreenGui
MinimizeCircle.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MinimizeCircle.Position = UDim2.new(0.1, 0, 0.15, 0) -- Дефолтная позиция слева вверху
MinimizeCircle.Size = UDim2.new(0, 45, 0, 45)
MinimizeCircle.Font = Enum.Font.GothamBold
MinimizeCircle.Text = "QP"
MinimizeCircle.TextColor3 = Color3.fromRGB(130, 170, 255)
MinimizeCircle.TextSize = 16
MinimizeCircle.Visible = false -- Изначально скрыт
MinimizeCircle.Active = true
MinimizeCircle.Draggable = true -- Кружок можно двигать пальцем

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0) -- Делает идеальный круг
CircleCorner.Parent = MinimizeCircle

-- Слегка подсветим границы кружка для красоты
local CircleStroke = Instance.new("UIStroke")
CircleStroke.Thickness = 2
CircleStroke.Color = Color3.fromRGB(45, 45, 45)
CircleStroke.Parent = MinimizeCircle


-- === ПРИЦЕЛ (ПЕРЕКРЕСТИЕ) ===
local TargetFrame = Instance.new("Frame")
TargetFrame.Name = "Target"
TargetFrame.Parent = ScreenGui
TargetFrame.Size = UDim2.new(0, 40, 0, 40)
TargetFrame.Position = UDim2.new(0.5, -20, 0.5, -20)
TargetFrame.BackgroundTransparency = 1
TargetFrame.Active = true
TargetFrame.Draggable = true

local lineH = Instance.new("Frame", TargetFrame)
lineH.Size = UDim2.new(1, 0, 0, 2)
lineH.Position = UDim2.new(0, 0, 0.5, -1)
lineH.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
lineH.BorderSizePixel = 0
lineH.Active = false

local lineV = Instance.new("Frame", TargetFrame)
lineV.Size = UDim2.new(0, 2, 1, 0)
lineV.Position = UDim2.new(0.5, -1, 0, 0)
lineV.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
lineV.BorderSizePixel = 0
lineV.Active = false


-- === ЛОГИКА ИНТЕРФЕЙСА ===

-- Свернуть меню
MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MinimizeCircle.Visible = true
end)

-- Развернуть меню обратно
MinimizeCircle.MouseButton1Click:Connect(function()
    MinimizeCircle.Visible = false
    MainFrame.Visible = true
end)

-- Эффект смены цвета при наведении/нажатии на кнопку сворачивания
MinimizeBtn.MouseEnter:Connect(function() MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255) end)
MinimizeBtn.MouseLeave:Connect(function() MinimizeBtn.TextColor3 = Color3.fromRGB(150, 150, 150) end)

-- Старт / Стоп
ToggleBtn.MouseButton1Click:Connect(function()
    autoClicking = not autoClicking
    if autoClicking then
        ToggleBtn.Text = "STOP"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 90, 0)
        TargetFrame.Active = false
        TargetFrame.Draggable = false
    else
        ToggleBtn.Text = "START"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 80)
        TargetFrame.Active = true
        TargetFrame.Draggable = true
    end
end)

-- Закрытие скрипта полностью
CloseBtn.MouseButton1Click:Connect(function()
    autoClicking = false
    ScreenGui:Destroy()
end)


-- === ОСНОВНОЙ ЦИКЛ КЛИКЕРА ===
task.spawn(function()
    while true do
        if autoClicking then
            local cpsValue = tonumber(CpsInput.Text) or 10
            cpsValue = math.clamp(cpsValue, 1, 100)
            local waitTime = 1 / cpsValue
            
            local targetX = TargetFrame.AbsolutePosition.X + (TargetFrame.AbsoluteSize.X / 2)
            local targetY = TargetFrame.AbsolutePosition.Y + (TargetFrame.AbsoluteSize.Y / 2)
            
            local inset = GuiService:GetGuiInset()
            local finalX = targetX
            local finalY = targetY + inset.Y
            
            VirtualInputManager:SendMouseButtonEvent(finalX, finalY, 0, true, game, 1)
            VirtualInputManager:SendMouseButtonEvent(finalX, finalY, 0, false, game, 1)
            
            task.wait(waitTime)
        else
            task.wait(0.1)
        end
    end
end)
