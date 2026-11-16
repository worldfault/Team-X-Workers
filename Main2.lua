local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local correctKey = "TEAMXSTUDIOHUB"

local KeyScreenGui = Instance.new("ScreenGui", game.CoreGui)
KeyScreenGui.Name = "TeamXKeySystem"
KeyScreenGui.ResetOnSpawn = false

local KeyFrame = Instance.new("Frame", KeyScreenGui)
KeyFrame.Size = UDim2.new(0, 320, 0, 160)
KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -80)
KeyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
KeyFrame.BorderSizePixel = 0

local KeyUICorner = Instance.new("UICorner", KeyFrame)
KeyUICorner.CornerRadius = UDim.new(0, 12)

local KeyUIStroke = Instance.new("UIStroke", KeyFrame)
KeyUIStroke.Color = Color3.fromRGB(255, 215, 0)
KeyUIStroke.Thickness = 1.5

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.Position = UDim2.new(0, 0, 0, 10)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "TEAM X STUDIO"
KeyTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 14

local TextBox = Instance.new("TextBox", KeyFrame)
TextBox.Size = UDim2.new(0, 280, 0, 35)
TextBox.Position = UDim2.new(0.5, -140, 0, 55)
TextBox.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
TextBox.PlaceholderText = "Paste your key here..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 215, 0)
TextBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
TextBox.Font = Enum.Font.GothamMedium
TextBox.TextSize = 12

local TextBoxCorner = Instance.new("UICorner", TextBox)
TextBoxCorner.CornerRadius = UDim.new(0, 6)

local SubmitBtn = Instance.new("TextButton", KeyFrame)
SubmitBtn.Size = UDim2.new(0, 135, 0, 35)
SubmitBtn.Position = UDim2.new(0, 20, 0, 105)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
SubmitBtn.Text = "CHECK KEY"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 12

local SubmitCorner = Instance.new("UICorner", SubmitBtn)
SubmitCorner.CornerRadius = UDim.new(0, 6)

local GetKeyBtn = Instance.new("TextButton", KeyFrame)
GetKeyBtn.Size = UDim2.new(0, 135, 0, 35)
GetKeyBtn.Position = UDim2.new(0, 165, 0, 105)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
GetKeyBtn.Text = "GET KEY"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.TextSize = 12

local GetKeyCorner = Instance.new("UICorner", GetKeyBtn)
GetKeyCorner.CornerRadius = UDim.new(0, 6)

-- زر جلب المفتاح (ينسخ رابط الـ Linkvertise للحافظة)
GetKeyBtn.MouseButton1Click:Connect(function()
	local linkvertiseUrl = "https://direct-link.net/10771146/MsOqqKVoyHpI?share_origin=10771146%2FMsOqqKVoyHpI&utm_source=copy_url"
	if setclipboard then
		setclipboard(linkvertiseUrl)
		GetKeyBtn.Text = "LINK COPIED!"
		task.wait(1.5)
		GetKeyBtn.Text = "GET KEY"
	else
		print("Get Key URL: " .. linkvertiseUrl)
	end
end)

-- زر التحقق من المفتاح وتشغيل سكربتك الأساسي من جيت هب
SubmitBtn.MouseButton1Click:Connect(function()
	if TextBox.Text == correctKey then
		SubmitBtn.Text = "SUCCESS!"
		task.wait(0.8)
		KeyScreenGui:Destroy()
		
		local mainScriptUrl = "https://raw.githubusercontent.com/worldfault/Team-X-Workers/refs/heads/main/Main2.lua"
		
		pcall(function()
			loadstring(game:HttpGet(mainScriptUrl))()
		end)
	else
		SubmitBtn.Text = "WRONG KEY!"
		task.wait(1)
		SubmitBtn.Text = "CHECK KEY"
	end
end)
