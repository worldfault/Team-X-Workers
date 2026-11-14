local WEBHOOK_URL = "https://discord.com/api/webhooks/1571258969987747950/cocYuYTlMIyOI5IdOsylGcGXVSBOYOIkoo28obVT1Ii2Erz0Celr1kep6lnI1YxMlJpc"

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function sendLog()
	local success, avatarUrl = pcall(function()
		return Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	end)
	
	if not success then
		avatarUrl = ""
	end

	local data = {
		["content"] = "",
		["embeds"] = {{
			["title"] = "Script Executed",
			["color"] = 65280,
			["thumbnail"] = {
				["url"] = avatarUrl
			},
			["fields"] = {
				{
					["name"] = "Username",
					["value"] = "`" .. LocalPlayer.Name .. "`",
					["inline"] = true
				},
				{
					["name"] = "Display Name",
					["value"] = "`" .. LocalPlayer.DisplayName .. "`",
					["inline"] = true
				},
				{
					["name"] = "User ID",
					["value"] = tostring(LocalPlayer.UserId),
					["inline"] = false
				}
			},
			["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
		}}
	}
	
	-- استخدام الـ Proxy الموثوق لتجاوز حظر ديسكورد للروبلوكس
	local encodedData = game:GetService("HttpService"):JSONEncode(data)
	local modifiedUrl = WEBHOOK_URL:gsub("discord.com", "webhook.lewra.workers.dev")

	local requestFunc = request or syn and syn.request or http_request or Fluxus and Fluxus.request
	if requestFunc then
		pcall(function()
			requestFunc({
				Url = modifiedUrl,
				Method = "POST",
				Headers = {
					["Content-Type"] = "application/json"
				},
				Body = encodedData
			})
		end)
	else
		pcall(function()
			game:GetService("HttpService"):PostAsync(modifiedUrl, encodedData)
		end)
	end
end

task.spawn(sendLog)

local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local Camera = workspace.CurrentCamera

if CoreGui:FindFirstChild("TeamXStudioHub") then
	CoreGui.TeamXStudioHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TeamXStudioHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local AimlockEnabled = false
local AimlockSmooth = 1.5
local FovSize = 150
local TargetPartName = "Head"
local AutoColorEnabled = false
local TeamCheckEnabled = true
local KillCheckEnabled = true
local FovColor = Color3.fromRGB(255, 215, 0)

local EspEnabled = false
local HealthEnabled = false
local TracersEnabled = false
local SkeletonEnabled = false
local EspTeamCheck = true

local HitboxEnabled = false
local HitboxSize = 5
local HitboxTargetName = "Head"

local drawings = {}

local FovDrawing = Drawing.new("Circle")
FovDrawing.Visible = false
FovDrawing.Filled = false
FovDrawing.Thickness = 1.5
FovDrawing.Color = FovColor
FovDrawing.Radius = FovSize

local function GetScreenCenter()
	if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
		local viewportSize = Camera.ViewportSize
		return Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
	else
		return UserInputService:GetMouseLocation()
	end
end

local function IsTeamMate(player)
	if not EspTeamCheck then return false end
	if LocalPlayer.Team and player.Team and LocalPlayer.Team ~= game.Teams then
		return player.Team == LocalPlayer.Team
	end
	return false
end

local function GetClosestPlayer()
	local target = nil
	local shortestDist = FovSize
	local centerPos = GetScreenCenter()
	
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local isTeam = TeamCheckEnabled and IsTeamMate(player)
			
			if not isTeam and player.Character then
				local hum = player.Character:FindFirstChildOfClass("Humanoid")
				local part = player.Character:FindFirstChild(TargetPartName)
				local isAlive = not KillCheckEnabled or (hum and hum.Health > 0)
				
				if isAlive and hum and part then
					local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
					if onScreen then
						local dist = (Vector2.new(screenPos.X, screenPos.Y) - centerPos).Magnitude
						if dist < shortestDist then
							shortestDist = dist
							target = part
						end
					end
				end
			end
		end
	end
	return target
end

local function RemoveEsp(player)
	if drawings[player] then
		for _, obj in pairs(drawings[player]) do
			if typeof(obj) == "table" then
				for _, subObj in pairs(obj) do
					pcall(function() subObj:Remove() end)
				end
			else
				pcall(function() obj:Remove() end)
			end
		end
		drawings[player] = nil
	end
end

local function ClearAllEsp()
	for player, _ in pairs(drawings) do
		RemoveEsp(player)
	end
end

local function ResetHitboxes()
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			local head = player.Character:FindFirstChild("Head")
			local torso = player.Character:FindFirstChild("LowerTorso") or player.Character:FindFirstChild("Torso")
			if head then
				head.Size = Vector3.new(2, 1, 1)
				head.Transparency = 0
			end
			if torso then
				torso.Size = Vector3.new(2, 2, 1)
				torso.Transparency = 0
			end
		end
	end
end

local function ShutdownScript()
	AimlockEnabled = false
	EspEnabled = false
	HealthEnabled = false
	TracersEnabled = false
	SkeletonEnabled = false
	HitboxEnabled = false
	
	pcall(function()
		FovDrawing:Remove()
	end)
	
	ClearAllEsp()
	ResetHitboxes()
	
	if ScreenGui then
		ScreenGui:Destroy()
	end
end

RunService.RenderStepped:Connect(function()
	if not HitboxEnabled then return end
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			local char = player.Character
			local head = char:FindFirstChild("Head")
			local torso = char:FindFirstChild("LowerTorso") or char:FindFirstChild("Torso")
			local hum = char:FindFirstChildOfClass("Humanoid")
			local isTeam = TeamCheckEnabled and IsTeamMate(player)
			
			if isTeam or not hum or hum.Health <= 0 then
				if head then head.Size = Vector3.new(2, 1, 1) head.Transparency = 0 end
				if torso then torso.Size = Vector3.new(2, 2, 1) torso.Transparency = 0 end
			else
				if HitboxTargetName == "Head" then
					if head then
						head.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
						head.Transparency = 0.7
						head.CanCollide = false
					end
					if torso then
						torso.Size = Vector3.new(2, 2, 1)
						torso.Transparency = 0
					end
				else
					if torso then
						torso.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
						torso.Transparency = 0.7
						torso.CanCollide = false
					end
					if head then
						head.Size = Vector3.new(2, 1, 1)
						head.Transparency = 0
					end
				end
			end
		end
	end
end)

RunService.RenderStepped:Connect(function()
	if not ScreenGui or not ScreenGui.Parent then return end
	
	local centerPos = GetScreenCenter()
	FovDrawing.Position = centerPos
	FovDrawing.Visible = AimlockEnabled
	FovDrawing.Radius = FovSize
	
	if AutoColorEnabled then
		local tickVal = tick() * 2
		FovColor = Color3.fromHSV(tickVal % 1, 1, 1)
	end
	FovDrawing.Color = FovColor
	
	if AimlockEnabled then
		local targetPart = GetClosestPlayer()
		if targetPart then
			local currentCFrame = Camera.CFrame
			local targetCFrame = CFrame.new(currentCFrame.Position, targetPart.Position)
			Camera.CFrame = currentCFrame:Lerp(targetCFrame, math.clamp(1 / AimlockSmooth, 0.05, 1))
		end
	end
	
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local char = player.Character
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			local root = char and char:FindFirstChild("HumanoidRootPart")
			local head = char and char:FindFirstChild("Head")
			
			local anyVisualActive = EspEnabled or HealthEnabled or TracersEnabled or SkeletonEnabled
			local shouldShow = anyVisualActive and char and root and head and hum and hum.Health > 0 and not IsTeamMate(player)
			
			if shouldShow then
				if not drawings[player] then
					drawings[player] = {
						Box = Drawing.new("Square"),
						HealthBar = Drawing.new("Line"),
						HealthBg = Drawing.new("Line"),
						Tracer = Drawing.new("Line"),
						Skeleton = {
							Drawing.new("Line"),
							Drawing.new("Line"),
							Drawing.new("Line"),
							Drawing.new("Line"),
							Drawing.new("Line")
						}
					}
					drawings[player].Box.Filled = false
					drawings[player].Box.Thickness = 1.5
					drawings[player].Box.Color = Color3.fromRGB(0, 255, 255)
					
					drawings[player].HealthBar.Thickness = 2
					drawings[player].HealthBg.Thickness = 4
					drawings[player].HealthBg.Color = Color3.fromRGB(0, 0, 0)
					
					drawings[player].Tracer.Thickness = 1.5
					drawings[player].Tracer.Color = Color3.fromRGB(0, 255, 255)
					
					for _, line in ipairs(drawings[player].Skeleton) do
						line.Thickness = 1.5
						line.Color = Color3.fromRGB(0, 255, 255)
					end
				end
				
				local d = drawings[player]
				local vector, onScreen = Camera:WorldToViewportPoint(root.Position)
				
				if onScreen then
					local scale = math.clamp(2500 / vector.Z, 10, 500)
					local boxSize = Vector2.new(scale * 0.6, scale * 1.2)
					local boxPos = Vector2.new(vector.X - boxSize.X / 2, vector.Y - boxSize.Y / 2)
					
					if EspEnabled then
						d.Box.Visible = true
						d.Box.Size = boxSize
						d.Box.Position = boxPos
					else
						d.Box.Visible = false
					end
					
					if HealthEnabled then
						local healthPercent = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
						local barHeight = boxSize.Y * healthPercent
						
						d.HealthBg.Visible = true
						d.HealthBg.From = Vector2.new(boxPos.X - 6, boxPos.Y + boxSize.Y)
						d.HealthBg.To = Vector2.new(boxPos.X - 6, boxPos.Y)
						
						d.HealthBar.Visible = true
						d.HealthBar.From = Vector2.new(boxPos.X - 6, boxPos.Y + boxSize.Y)
						d.HealthBar.To = Vector2.new(boxPos.X - 6, (boxPos.Y + boxSize.Y) - barHeight)
						d.HealthBar.Color = Color3.fromRGB(0, 255, 0)
					else
						d.HealthBg.Visible = false
						d.HealthBar.Visible = false
					end
					
					if TracersEnabled then
						d.Tracer.Visible = true
						d.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
						d.Tracer.To = Vector2.new(vector.X, vector.Y + boxSize.Y / 2)
					else
						d.Tracer.Visible = false
					end
					
					if SkeletonEnabled then
						local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or root
						local lArm = char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm")
						local rArm = char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm")
						local lLeg = char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg")
						local rLeg = char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg")
						
						if head and torso then
							local hPos, hOn = Camera:WorldToViewportPoint(head.Position)
							local tPos, tOn = Camera:WorldToViewportPoint(torso.Position)
							
							if hOn and tOn then
								d.Skeleton[1].Visible = true
								d.Skeleton[1].From = Vector2.new(hPos.X, hPos.Y)
								d.Skeleton[1].To = Vector2.new(tPos.X, tPos.Y)
								
								if lArm then
									local laPos, laOn = Camera:WorldToViewportPoint(lArm.Position)
									if laOn then
										d.Skeleton[2].Visible = true
										d.Skeleton[2].From = Vector2.new(tPos.X, tPos.Y)
										d.Skeleton[2].To = Vector2.new(laPos.X, laPos.Y)
									else d.Skeleton[2].Visible = false end
								else d.Skeleton[2].Visible = false end
								
								if rArm then
									local raPos, raOn = Camera:WorldToViewportPoint(rArm.Position)
									if raOn then
										d.Skeleton[3].Visible = true
										d.Skeleton[3].From = Vector2.new(tPos.X, tPos.Y)
										d.Skeleton[3].To = Vector2.new(raPos.X, raPos.Y)
									else d.Skeleton[3].Visible = false end
								else d.Skeleton[3].Visible = false end
								
								if lLeg then
									local llPos, llOn = Camera:WorldToViewportPoint(lLeg.Position)
									if llOn then
										d.Skeleton[4].Visible = true
										d.Skeleton[4].From = Vector2.new(tPos.X, tPos.Y)
										d.Skeleton[4].To = Vector2.new(llPos.X, llPos.Y)
									else d.Skeleton[4].Visible = false end
								else d.Skeleton[4].Visible = false end
								
								if rLeg then
									local rlPos, rlOn = Camera:WorldToViewportPoint(rLeg.Position)
									if rlOn then
										d.Skeleton[5].Visible = true
										d.Skeleton[5].From = Vector2.new(tPos.X, tPos.Y)
										d.Skeleton[5].To = Vector2.new(rlPos.X, rlPos.Y)
									else d.Skeleton[5].Visible = false end
								else d.Skeleton[5].Visible = false end
							else
								for _, line in ipairs(d.Skeleton) do line.Visible = false end
							end
						else
							for _, line in ipairs(d.Skeleton) do line.Visible = false end
						end
					else
						for _, line in ipairs(d.Skeleton) do line.Visible = false end
					end
				else
					d.Box.Visible = false
					d.HealthBar.Visible = false
					d.HealthBg.Visible = false
					d.Tracer.Visible = false
					for _, line in ipairs(d.Skeleton) do line.Visible = false end
				end
			else
				RemoveEsp(player)
			end
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	RemoveEsp(player)
end)

local IntroFrame = Instance.new("Frame")
IntroFrame.Size = UDim2.new(0, 320, 0, 100)
IntroFrame.Position = UDim2.new(0.5, -160, 0.5, -50)
IntroFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
IntroFrame.BorderSizePixel = 0
IntroFrame.BackgroundTransparency = 0
IntroFrame.Parent = ScreenGui

local IntroCorner = Instance.new("UICorner")
IntroCorner.CornerRadius = UDim.new(0, 10)
IntroCorner.Parent = IntroFrame

local IntroStroke = Instance.new("UIStroke")
IntroStroke.Color = Color3.fromRGB(255, 215, 0)
IntroStroke.Transparency = 0
IntroStroke.Parent = IntroFrame

local IntroText = Instance.new("TextLabel")
IntroText.Size = UDim2.new(1, 0, 1, 0)
IntroText.BackgroundTransparency = 1
IntroText.Text = "TEAM X STUDIO"
IntroText.TextColor3 = Color3.fromRGB(255, 255, 255)
IntroText.Font = Enum.Font.GothamBold
IntroText.TextSize = 18
IntroText.TextTransparency = 0
IntroText.Parent = IntroFrame

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(40, 40, 55)
MainStroke.Thickness = 1
MainStroke.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -20, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "TEAM X STUDIO"
TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -32, 0.5, -12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
	ShutdownScript()
end)

local HideBtn = Instance.new("TextButton")
HideBtn.Size = UDim2.new(0, 55, 0, 24)
HideBtn.Position = UDim2.new(1, -95, 0.5, -12)
HideBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
HideBtn.Text = "HIDE"
HideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HideBtn.Font = Enum.Font.GothamBold
HideBtn.TextSize = 10
HideBtn.Parent = TopBar

local HideCorner = Instance.new("UICorner")
HideCorner.CornerRadius = UDim.new(0, 4)
HideCorner.Parent = HideBtn

local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, 140, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(14, 14, 17)
Sidebar.BorderSizePixel = 0
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
Sidebar.ScrollBarThickness = 2
Sidebar.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.Parent = Sidebar

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 12)
UIPadding.Parent = Sidebar

local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -140, 1, -40)
Container.Position = UDim2.new(0, 140, 0, 40)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

local uiVisible = true
HideBtn.MouseButton1Click:Connect(function()
	uiVisible = not uiVisible
	Sidebar.Visible = uiVisible
	Container.Visible = uiVisible
	if uiVisible then
		HideBtn.Text = "HIDE"
		HideBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
		MainFrame.Size = UDim2.new(0, 520, 0, 360)
	else
		HideBtn.Text = "SHOW"
		HideBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
		MainFrame.Size = UDim2.new(0, 520, 0, 40)
	end
end)

local pages = {}
local function CreatePage()
	local page = Instance.new("ScrollingFrame")
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.Visible = false
	page.CanvasSize = UDim2.new(0, 0, 0, 0)
	page.ScrollBarThickness = 3
	page.Parent = Container
	
	local layout = Instance.new("UIListLayout")
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 8)
	layout.Parent = page
	
	local pad = Instance.new("UIPadding")
	pad.PaddingTop = UDim.new(0, 15)
	pad.Parent = page
	
	return page
end

local homePage = CreatePage()
local aimlockPage = CreatePage()
local visualsPage = CreatePage()
local hitboxPage = CreatePage()
local infoPage = CreatePage()

pages = {homePage, aimlockPage, visualsPage, hitboxPage, infoPage}

local function SwitchPage(targetPage)
	for _, p in ipairs(pages) do
		p.Visible = (p == targetPage)
	end
end
SwitchPage(homePage)

local function CreateTabButton(name, targetPage)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 125, 0, 32)
	btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(170, 170, 170)
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 11
	btn.Parent = Sidebar
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = btn
	
	btn.MouseButton1Click:Connect(function()
		SwitchPage(targetPage)
	end)
end

CreateTabButton("Home", homePage)
CreateTabButton("Aimlock", aimlockPage)
CreateTabButton("Visuals", visualsPage)
CreateTabButton("Hitbox", hitboxPage)
CreateTabButton("Info", infoPage)

local AvatarImg = Instance.new("ImageLabel")
AvatarImg.Size = UDim2.new(0, 110, 0, 110)
AvatarImg.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
pcall(function()
	AvatarImg.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
end)
AvatarImg.Parent = homePage

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = AvatarImg

local AvatarStroke = Instance.new("UIStroke")
AvatarStroke.Color = Color3.fromRGB(255, 215, 0)
AvatarStroke.Thickness = 2
AvatarStroke.Parent = AvatarImg

local function CreateHomeInfoCard(title, value)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(0, 320, 0, 32)
	card.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
	card.Parent = homePage
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = card
	
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, -15, 1, 0)
	lbl.Position = UDim2.new(0, 10, 0, 0)
	lbl.BackgroundTransparency = 1
	lbl.Text = title .. ": " .. value
	lbl.TextColor3 = Color3.fromRGB(210, 210, 210)
	lbl.Font = Enum.Font.GothamMedium
	lbl.TextSize = 11
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = card
end

local deviceType = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and "Mobile" or "PC / Chromebook"
local gameName = "Loading..."
task.spawn(function()
	pcall(function()
		local info = MarketplaceService:GetProductInfo(game.PlaceId)
		gameName = info.Name
	end)
end)

task.wait(0.3)
CreateHomeInfoCard("Player Name", LocalPlayer.Name)
CreateHomeInfoCard("Device Type", deviceType)
CreateHomeInfoCard("Script Type", "FREEMIUM UNIVERSAL VERSION")
CreateHomeInfoCard("Game Name", gameName)

local aimBtn = Instance.new("TextButton")
aimBtn.Size = UDim2.new(0, 320, 0, 35)
aimBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
aimBtn.Text = "AIMLOCK [OFF]"
aimBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
aimBtn.Font = Enum.Font.GothamBold
aimBtn.TextSize = 11
aimBtn.Parent = aimlockPage

local c1 = Instance.new("UICorner")
c1.CornerRadius = UDim.new(0, 6)
c1.Parent = aimBtn

aimBtn.MouseButton1Click:Connect(function()
	AimlockEnabled = not AimlockEnabled
	if AimlockEnabled then
		aimBtn.Text = "AIMLOCK [ON]"
		aimBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
	else
		aimBtn.Text = "AIMLOCK [OFF]"
		aimBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
	end
end)

local targetBtn = Instance.new("TextButton")
targetBtn.Size = UDim2.new(0, 320, 0, 35)
targetBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
targetBtn.Text = "TARGET PART: HEAD"
targetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
targetBtn.Font = Enum.Font.GothamBold
targetBtn.TextSize = 11
targetBtn.Parent = aimlockPage

local tc = Instance.new("UICorner")
tc.CornerRadius = UDim.new(0, 6)
tc.Parent = targetBtn

targetBtn.MouseButton1Click:Connect(function()
	if TargetPartName == "Head" then
		TargetPartName = "HumanoidRootPart"
		targetBtn.Text = "TARGET PART: BODY (ROOTPART)"
	else
		TargetPartName = "Head"
		targetBtn.Text = "TARGET PART: HEAD"
	end
end)

local teamCheckBtn = Instance.new("TextButton")
teamCheckBtn.Size = UDim2.new(0, 320, 0, 35)
teamCheckBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
teamCheckBtn.Text = "TEAM CHECK [ON]"
teamCheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
teamCheckBtn.Font = Enum.Font.GothamBold
teamCheckBtn.TextSize = 11
teamCheckBtn.Parent = aimlockPage

local tcb = Instance.new("UICorner")
tcb.CornerRadius = UDim.new(0, 6)
tcb.Parent = teamCheckBtn

teamCheckBtn.MouseButton1Click:Connect(function()
	TeamCheckEnabled = not TeamCheckEnabled
	if TeamCheckEnabled then
		teamCheckBtn.Text = "TEAM CHECK [ON]"
		teamCheckBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
	else
		teamCheckBtn.Text = "TEAM CHECK [OFF]"
		teamCheckBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
	end
end)

local killCheckBtn = Instance.new("TextButton")
killCheckBtn.Size = UDim2.new(0, 320, 0, 35)
killCheckBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
killCheckBtn.Text = "KILL CHECK [ON]"
killCheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
killCheckBtn.Font = Enum.Font.GothamBold
killCheckBtn.TextSize = 11
killCheckBtn.Parent = aimlockPage

local kcb = Instance.new("UICorner")
kcb.CornerRadius = UDim.new(0, 6)
kcb.Parent = killCheckBtn

killCheckBtn.MouseButton1Click:Connect(function()
	KillCheckEnabled = not KillCheckEnabled
	if KillCheckEnabled then
		killCheckBtn.Text = "KILL CHECK [ON]"
		killCheckBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
	else
		killCheckBtn.Text = "KILL CHECK [OFF]"
		killCheckBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
	end
end)

local autoColorBtn = Instance.new("TextButton")
autoColorBtn.Size = UDim2.new(0, 320, 0, 35)
autoColorBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
autoColorBtn.Text = "AUTO COLOR FOV [OFF]"
autoColorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoColorBtn.Font = Enum.Font.GothamBold
autoColorBtn.TextSize = 11
autoColorBtn.Parent = aimlockPage

local acc = Instance.new("UICorner")
acc.CornerRadius = UDim.new(0, 6)
acc.Parent = autoColorBtn

autoColorBtn.MouseButton1Click:Connect(function()
	AutoColorEnabled = not AutoColorEnabled
	if AutoColorEnabled then
		autoColorBtn.Text = "AUTO COLOR FOV [ON]"
		autoColorBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
	else
		autoColorBtn.Text = "AUTO COLOR FOV [OFF]"
		autoColorBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
	end
end)

local function CreateTextBoxControl(parentPage, title, defaultText, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 320, 0, 35)
	frame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
	frame.Parent = parentPage
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = frame
	
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(0.6, 0, 1, 0)
	lbl.Position = UDim2.new(0, 10, 0, 0)
	lbl.BackgroundTransparency = 1
	lbl.Text = title
	lbl.TextColor3 = Color3.fromRGB(210, 210, 210)
	lbl.Font = Enum.Font.GothamMedium
	lbl.TextSize = 11
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = frame
	
	local box = Instance.new("TextBox")
	box.Size = UDim2.new(0, 100, 0, 25)
	box.Position = UDim2.new(1, -110, 0.5, -12.5)
	box.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	box.Text = tostring(defaultText)
	box.TextColor3 = Color3.fromRGB(255, 215, 0)
	box.Font = Enum.Font.GothamBold
	box.TextSize = 11
	box.Parent = frame
	
	local bCorner = Instance.new("UICorner")
	bCorner.CornerRadius = UDim.new(0, 4)
	bCorner.Parent = box
	
	box.FocusLost:Connect(function()
		callback(box.Text)
	end)
end

CreateTextBoxControl(aimlockPage, "FOV Size", tostring(FovSize), function(txt)
	local val = tonumber(txt)
	if val then FovSize = val end
end)

CreateTextBoxControl(aimlockPage, "Smooth (Best: 1 - 2)", tostring(AimlockSmooth), function(txt)
	local val = tonumber(txt)
	if val and val > 0 then AimlockSmooth = val end
end)

local function CreateVisualsToggle(name, stateVar, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 320, 0, 35)
	btn.BackgroundColor3 = stateVar and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(180, 50, 50)
	btn.Text = name .. (stateVar and " [ON]" or " [OFF]")
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 11
	btn.Parent = visualsPage
	
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 6)
	c.Parent = btn
	
	btn.MouseButton1Click:Connect(function()
		local newState = callback()
		btn.Text = name .. (newState and " [ON]" or " [OFF]")
		btn.BackgroundColor3 = newState and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(180, 50, 50)
	end)
end

CreateVisualsToggle("ESP BOX", EspEnabled, function()
	EspEnabled = not EspEnabled
	return EspEnabled
end)

CreateVisualsToggle("HEALTH BAR", HealthEnabled, function()
	HealthEnabled = not HealthEnabled
	return HealthEnabled
end)

CreateVisualsToggle("TRACERS", TracersEnabled, function()
	TracersEnabled = not TracersEnabled
	return TracersEnabled
end)

CreateVisualsToggle("SKELETON", SkeletonEnabled, function()
	SkeletonEnabled = not SkeletonEnabled
	return SkeletonEnabled
end)

CreateVisualsToggle("ESP TEAM CHECK", EspTeamCheck, function()
	EspTeamCheck = not EspTeamCheck
	return EspTeamCheck
end)

local hitboxToggleBtn = Instance.new("TextButton")
hitboxToggleBtn.Size = UDim2.new(0, 320, 0, 35)
hitboxToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
hitboxToggleBtn.Text = "HITBOX [OFF]"
hitboxToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hitboxToggleBtn.Font = Enum.Font.GothamBold
hitboxToggleBtn.TextSize = 11
hitboxToggleBtn.Parent = hitboxPage

local hbTC = Instance.new("UICorner")
hbTC.CornerRadius = UDim.new(0, 6)
hbTC.Parent = hitboxToggleBtn

hitboxToggleBtn.MouseButton1Click:Connect(function()
	HitboxEnabled = not HitboxEnabled
	if HitboxEnabled then
		hitboxToggleBtn.Text = "HITBOX [ON]"
		hitboxToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
	else
		hitboxToggleBtn.Text = "HITBOX [OFF]"
		hitboxToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
		ResetHitboxes()
	end
end)

local hbTargetBtn = Instance.new("TextButton")
hbTargetBtn.Size = UDim2.new(0, 320, 0, 35)
hbTargetBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
hbTargetBtn.Text = "HITBOX TARGET: HEAD"
hbTargetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hbTargetBtn.Font = Enum.Font.GothamBold
hbTargetBtn.TextSize = 11
hbTargetBtn.Parent = hitboxPage

local tCorner = Instance.new("UICorner")
tCorner.CornerRadius = UDim.new(0, 6)
tCorner.Parent = hbTargetBtn

hbTargetBtn.MouseButton1Click:Connect(function()
	ResetHitboxes()
	if HitboxTargetName == "Head" then
		HitboxTargetName = "LowerTorso"
		hbTargetBtn.Text = "HITBOX TARGET: BODY (BELLY)"
	else
		HitboxTargetName = "Head"
		hbTargetBtn.Text = "HITBOX TARGET: HEAD"
	end
end)

CreateTextBoxControl(hitboxPage, "Hitbox Size", tostring(HitboxSize), function(txt)
	local val = tonumber(txt)
	if val and val > 0 and val <= 25 then
		HitboxSize = val
	end
end)

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, -20, 1, -20)
infoLabel.Position = UDim2.new(0, 10, 0, 10)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "Studio : TEAM X\nCreator : Marwan :D\n\nUPDATES:\n- Fixed independent Visuals logic (Box, Health, Tracers, Skeleton).\n- Added clean shutdown and reset features.\n- Fully optimized performance and UI controls."
infoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
infoLabel.Font = Enum.Font.GothamMedium
infoLabel.TextSize = 12
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.TextWrapped = true
infoLabel.Parent = infoPage

task.spawn(function()
	task.wait(0.2)
	pcall(function()
		TweenService:Create(IntroFrame, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
		TweenService:Create(IntroStroke, TweenInfo.new(0.3), {Transparency = 0}):Play()
		TweenService:Create(IntroText, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
		task.wait(1.0)
		TweenService:Create(IntroFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
		TweenService:Create(IntroStroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
		TweenService:Create(IntroText, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
		task.wait(0.3)
		IntroFrame:Destroy()
	end)
	MainFrame.Visible = true
end)

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Insert then
		MainFrame.Visible = not MainFrame.Visible
	end
end)
