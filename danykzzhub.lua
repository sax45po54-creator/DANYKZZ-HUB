-- DANYKZZ HUB PRO (ULTRA STABLE FIX)
if game.CoreGui:FindFirstChild("DanykzzUltimateHub") then
    game.CoreGui:FindFirstChild("DanykzzUltimateHub"):Destroy()
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Config = {
    ESPChams = false,
    ESPBox = false,
    ESPColor = Color3.fromRGB(0, 255, 170),
    ESPRainbow = false,
    Fly = false,
    FlySpeed = 50,
    Noclip = false,
    InfiniteJump = false,
    AntiFling = true,
    SelectedTarget = nil,
    FlingActive = false,
    ThemeColor = Color3.fromRGB(0, 255, 170)
}

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DanykzzUltimateHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- Плавающая кнопка
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.3, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
ToggleBtn.BackgroundTransparency = 0.2
ToggleBtn.Text = "⚡"
ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 170)
ToggleBtn.TextSize = 22
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui

Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local TBStroke = Instance.new("UIStroke", ToggleBtn)
TBStroke.Color = Color3.fromRGB(0, 255, 170)
TBStroke.Thickness = 2

-- Главное окно (Жидкое стекло)
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 440, 0, 310)
Main.Position = UDim2.new(0.5, -220, 0.35, -155)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
Main.BackgroundTransparency = 0.2
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local MStroke = Instance.new("UIStroke", Main)
MStroke.Color = Color3.fromRGB(0, 255, 170)
MStroke.Thickness = 2

-- Шапка
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 35)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
Header.BackgroundTransparency = 0.2
Header.Parent = Main
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ DANYKZZ HUB | MM2 PRO ⚡"
Title.TextColor3 = Color3.fromRGB(0, 255, 170)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -31, 0, 4)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- Скроллинг панель (все функции на одном экране без багов вкладок)
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -15, 1, -45)
Scroll.Position = UDim2.new(0, 8, 0, 40)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 0, 600)
Scroll.ScrollBarThickness = 3
Scroll.Parent = Main

local UIList = Instance.new("UIListLayout", Scroll)
UIList.Padding = UDim.new(0, 6)

-- Конструкторы элементов
local function AddToggle(text, default, callback)
    local F = Instance.new("Frame")
    F.Size = UDim2.new(1, -5, 0, 32)
    F.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    F.BackgroundTransparency = 0.3
    F.Parent = Scroll
    Instance.new("UICorner", F).CornerRadius = UDim.new(0, 6)

    local L = Instance.new("TextLabel", F)
    L.Size = UDim2.new(0.7, 0, 1, 0)
    L.Position = UDim2.new(0, 10, 0, 0)
    L.BackgroundTransparency = 1
    L.Text = text
    L.TextColor3 = Color3.fromRGB(220, 220, 220)
    L.Font = Enum.Font.GothamSemibold
    L.TextSize = 11
    L.TextXAlignment = Enum.TextXAlignment.Left

    local B = Instance.new("TextButton", F)
    B.Size = UDim2.new(0, 38, 0, 18)
    B.Position = UDim2.new(1, -45, 0.5, -9)
    B.BackgroundColor3 = default and Config.ThemeColor or Color3.fromRGB(45, 45, 60)
    B.Text = ""
    Instance.new("UICorner", B).CornerRadius = UDim.new(1, 0)

    local state = default
    B.MouseButton1Click:Connect(function()
        state = not state
        B.BackgroundColor3 = state and Config.ThemeColor or Color3.fromRGB(45, 45, 60)
        callback(state)
    end)
end

local function AddInput(text, default, callback)
    local F = Instance.new("Frame")
    F.Size = UDim2.new(1, -5, 0, 32)
    F.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    F.BackgroundTransparency = 0.3
    F.Parent = Scroll
    Instance.new("UICorner", F).CornerRadius = UDim.new(0, 6)

    local L = Instance.new("TextLabel", F)
    L.Size = UDim2.new(0.6, 0, 1, 0)
    L.Position = UDim2.new(0, 10, 0, 0)
    L.BackgroundTransparency = 1
    L.Text = text
    L.TextColor3 = Color3.fromRGB(220, 220, 220)
    L.Font = Enum.Font.GothamSemibold
    L.TextSize = 11
    L.TextXAlignment = Enum.TextXAlignment.Left

    local Box = Instance.new("TextBox", F)
    Box.Size = UDim2.new(0, 45, 0, 20)
    Box.Position = UDim2.new(1, -52, 0.5, -10)
    Box.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    Box.Text = tostring(default)
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.Font = Enum.Font.Gotham
    Box.TextSize = 11
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 4)

    Box.FocusLost:Connect(function()
        local val = tonumber(Box.Text)
        if val then callback(val) end
    end)
end

-- ДОБАВЛЕНИЕ ФУНКЦИЙ
AddToggle("ESP Chams (Силуэты)", false, function(v) 
    Config.ESPChams = v 
    if not v then for _,p in ipairs(Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("DanykzzChams") then p.Character.DanykzzChams:Destroy() end end end
end)
AddToggle("ESP Box (Квадратики)", false, function(v) 
    Config.ESPBox = v 
    if not v then for _,p in ipairs(Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("DanykzzBox") then p.Character.DanykzzBox:Destroy() end end end
end)
AddToggle("🌈 Радужный режим ESP", false, function(v) Config.ESPRainbow = v end)

AddToggle("Нормальный Полёт (Fly)", false, function(v) Config.Fly = v end)
AddInput("Скорость полёта", 50, function(v) Config.FlySpeed = v end)
AddToggle("Noclip (Сквозь стены)", false, function(v) Config.Noclip = v end)
AddToggle("Бесконечный прыжок", false, function(v) Config.InfiniteJump = v end)

AddToggle("Анти-Флинг", true, function(v) Config.AntiFling = v end)
AddToggle("Флинг выбранного игрока", false, function(v) Config.FlingActive = v end)

-- Выбор игрока для флинга
local FlingLbl = Instance.new("TextLabel", Scroll)
FlingLbl.Size = UDim2.new(1, -5, 0, 20)
FlingLbl.BackgroundTransparency = 1
FlingLbl.Text = "🎯 Выберите цель для флинга:"
FlingLbl.TextColor3 = Color3.fromRGB(0, 255, 170)
FlingLbl.Font = Enum.Font.GothamBold
FlingLbl.TextSize = 11
FlingLbl.TextXAlignment = Enum.TextXAlignment.Left

local PlayerScroll = Instance.new("ScrollingFrame", Scroll)
PlayerScroll.Size = UDim2.new(1, -5, 0, 100)
PlayerScroll.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
PlayerScroll.BackgroundTransparency = 0.3
PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, 300)
PlayerScroll.ScrollBarThickness = 2
Instance.new("UICorner", PlayerScroll).CornerRadius = UDim.new(0, 6)
local PSList = Instance.new("UIListLayout", PlayerScroll)
PSList.Padding = UDim.new(0, 3)

local function updatePlayerList()
    for _, child in ipairs(PlayerScroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local pBtn = Instance.new("TextButton", PlayerScroll)
            pBtn.Size = UDim2.new(1, 0, 0, 28)
            pBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            pBtn.Text = p.Name
            pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            pBtn.Font = Enum.Font.GothamSemibold
            pBtn.TextSize = 11
            Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 4)

            pBtn.MouseButton1Click:Connect(function()
                Config.SelectedTarget = p
                for _, b in ipairs(PlayerScroll:GetChildren()) do
                    if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(30, 30, 45) end
                end
                pBtn.BackgroundColor3 = Config.ThemeColor
                pBtn.TextColor3 = Color3.fromRGB(15, 15, 22)
            end)
        end
    end
end
updatePlayerList()
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

-- Кнопка выгрузки
local UnloadBtn = Instance.new("TextButton", Scroll)
UnloadBtn.Size = UDim2.new(1, -5, 0, 35)
UnloadBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
UnloadBtn.Text = "Выгрузить хаб"
UnloadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UnloadBtn.Font = Enum.Font.GothamBold
UnloadBtn.TextSize = 11
Instance.new("UICorner", UnloadBtn).CornerRadius = UDim.new(0, 6)
UnloadBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

----------------------------------------------------
-- ИГРОВОЙ ЦИКЛ
----------------------------------------------------
local bodyVel, bodyGyro

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")

    local espCol = Config.ESPRainbow and Color3.fromHSV(tick()%5/5, 1, 1) or Config.ESPColor

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            if Config.ESPChams then
                local hl = p.Character:FindFirstChild("DanykzzChams") or Instance.new("Highlight", p.Character)
                hl.Name = "DanykzzChams"
                hl.FillColor = espCol
                hl.FillTransparency = 0.4
            else
                if p.Character:FindFirstChild("DanykzzChams") then p.Character.DanykzzChams:Destroy() end
            end

            if Config.ESPBox then
                local bx = p.Character:FindFirstChild("DanykzzBox") or Instance.new("SelectionBox", p.Character)
                bx.Name = "DanykzzBox"
                bx.Adornee = p.Character
                bx.Color3 = espCol
                bx.LineThickness = 0.03
            else
                if p.Character:FindFirstChild("DanykzzBox") then p.Character.DanykzzBox:Destroy() end
            end
        end
    end

    -- Управляемый полёт (без багов со скоростью)
    if Config.Fly and root and hum then
        hum.PlatformStand = true
        if not bodyVel then
            bodyVel = Instance.new("BodyVelocity", root)
            bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodyGyro = Instance.new("BodyGyro", root)
            bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        end
        bodyGyro.CFrame = Camera.CFrame
        bodyVel.Velocity = Camera.CFrame.LookVector * Config.FlySpeed
    else
        if bodyVel then bodyVel:Destroy() bodyVel = nil end
        if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
        if hum then hum.PlatformStand = false end
    end

    if Config.Noclip and char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    -- Флинг выбранного игрока
    if Config.FlingActive and Config.SelectedTarget and Config.SelectedTarget.Character and Config.SelectedTarget.Character:FindFirstChild("HumanoidRootPart") and root then
        local tRoot = Config.SelectedTarget.Character.HumanoidRootPart
        local angle = tick() * 60
        root.CFrame = tRoot.CFrame * CFrame.Angles(math.sin(angle), math.cos(angle), math.sin(angle)) * CFrame.new(0, 0.2, 0)
        root.AssemblyLinearVelocity = Vector3.new(40000, 40000, 40000)
        root.AssemblyAngularVelocity = Vector3.new(99999, 99999, 99999)
    else
        if root and not Config.FlingActive then
            root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end
    end

    if Config.AntiFling then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                for _, part in ipairs(p.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if Config.InfiniteJump and hum then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)
ToggleBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
