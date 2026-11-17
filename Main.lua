-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "IntroWarningGui"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false

-- Protect GUI if possible (Synapse/Krampus/etc.)
if syn and syn.protect_gui then
    syn.protect_gui(screenGui)
    screenGui.Parent = CoreGui
elseif CoreGui:FindFirstChild("CoreGui") then
    screenGui.Parent = CoreGui
else
    screenGui.Parent = player:WaitForChild("PlayerGui")
end

-- Main Background Frame (Pitch Black with Glassmorphism)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
mainFrame.BackgroundTransparency = 1 -- Start transparent for fade-in
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Red Accent Glow / Border
local accentLine = Instance.new("Frame")
accentLine.Size = UDim2.new(1, 0, 0, 2)
accentLine.Position = UDim2.new(0, 0, 0, 0)
accentLine.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
accentLine.BorderSizePixel = 0
accentLine.Parent = mainFrame

-- Container for text
local container = Instance.new("Frame")
container.Size = UDim2.new(0, 500, 0, 200)
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.Position = UDim2.new(0.5, 0, 0.5, 0)
container.BackgroundTransparency = 1
container.Parent = mainFrame

-- Title Text: Script Stopped Working
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "Script Stopped Working"
titleLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
titleLabel.TextSize = 28
titleLabel.TextTransparency = 1
titleLabel.Parent = container

-- Subtitle Text: you are stupid follow todior on Rscripts...
local subLabel = Instance.new("TextLabel")
subLabel.Size = UDim2.new(1, 0, 0, 80)
subLabel.Position = UDim2.new(0, 0, 0, 60)
subLabel.BackgroundTransparency = 1
subLabel.Font = Enum.Font.GothamMedium
subLabel.Text = "you are stupid follow todior on Rscripts to get it again tmrw"
subLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
subLabel.TextSize = 16
subLabel.TextWrapped = true
subLabel.TextTransparency = 1
subLabel.Parent = container

-- Heavy Snow Effect Generator
local snowHolder = Instance.new("Folder")
snowHolder.Name = "SnowParticles"
snowHolder.Parent = mainFrame

math.randomseed(tick())
local flakes = {}

for i = 1, 120 do -- ثلج كثيف (120 حبة ثلج)
    local flake = Instance.new("Frame")
    flake.Size = UDim2.new(0, math.random(3, 7), 0, math.random(3, 7))
    flake.Position = UDim2.new(math.random(), 0, -0.1, 0)
    flake.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    flake.BackgroundTransparency = math.random(10, 40) / 100
    flake.BorderSizePixel = 0
    
    -- Round snow
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = flake
    
    flake.Parent = snowHolder
    
    table.insert(flakes, {
        object = flake,
        speed = math.random(150, 350) / 100,
        drift = math.random(-50, 50) / 100
    })
end

-- Animate Snow falling
local snowConnection
snowConnection = RunService.RenderStepped:Connect(function(dt)
    for _, f in ipairs(flakes) do
        local pos = f.object.Position
        local newY = pos.Y.Scale + (f.speed * dt * 0.2)
        local newX = pos.X.Scale + (f.drift * dt * 0.05)
        
        if newY > 1.1 then
            newY = -0.1
            newX = math.random()
        end
        
        f.object.Position = UDim2.new(newX, 0, newY, 0)
    end
end)

-- Fade In Tween
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
TweenService:Create(mainFrame, tweenInfo, {BackgroundTransparency = 0.15}):Play()
TweenService:Create(titleLabel, tweenInfo, {TextTransparency = 0}):Play()
TweenService:Create(subLabel, tweenInfo, {TextTransparency = 0}):Play()

-- Wait for 5 seconds, then kick player
task.delay(5, function()
    if snowConnection then
        snowConnection:Disconnect()
    end
    
    -- Kick with the specified reason
    player:Kick("Script Stopped Working")
end)
