local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("TeamXStudioHub") then
	CoreGui.TeamXStudioHub:Destroy()
end

local WEBHOOK_URL = "https://discord.com/api/webhooks/1571545499918532650/UakssFmuL-y22Z-oVjXZmeftLP2BilJfCHIusaInjNqKYt6-1sDCh4h9h_8c1yYzXX1-"

local gameName = "Loading..."
pcall(function()
	local info = MarketplaceService:GetProductInfo(game.PlaceId)
	gameName = info.Name
end)

local function SendWebhook(title, description, color)
	pcall(function()
		local data = {
			["embeds"] = {{
				["title"] = title,
				["description"] = description,
				["color"] = color or 16766720,
				["footer"] = {
					["text"] = "TEAM X STUDIO — Hub Logs"
				}
			}}
		}
		
		local body = HttpService:JSONEncode(data)
		local headers = {["Content-Type"] = "application/json"}
		
		local requestFunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request
		if requestFunc then
			requestFunc({
				Url = WEBHOOK_URL,
				Method = "POST",
				Headers = headers,
				Body = body
			})
		end
	end)
end

task.spawn(function()
	SendWebhook("🚀 Hub Executed", "Player: **" .. LocalPlayer.Name .. "**\nUser ID: `" .. LocalPlayer.UserId .. "`\nGame ID: `" .. game.PlaceId .. "`", 65280)
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TeamXStudioHub"
ScreenGui.ResetOnSpawn = false
pcall(function()
	ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent then
	ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local IntroFrame = Instance.new("Frame")
IntroFrame.Size = UDim2.new(0, 400, 0, 180)
IntroFrame.Position = UDim2.new(0.5, -200, 0.5, -90)
IntroFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
IntroFrame.BorderSizePixel = 0
IntroFrame.Parent = ScreenGui

local IntroCorner = Instance.new("UICorner")
IntroCorner.CornerRadius = UDim.new(0, 12)
IntroCorner.Parent = IntroFrame

local IntroStroke = Instance.new("UIStroke")
IntroStroke.Color = Color3.fromRGB(255, 215, 0)
IntroStroke.Thickness = 1.5
IntroStroke.Parent = IntroFrame

local IntroTitle = Instance.new("TextLabel")
IntroTitle.Size = UDim2.new(1, 0, 0, 40)
IntroTitle.Position = UDim2.new(0, 0, 0, 30)
IntroTitle.BackgroundTransparency = 1
IntroTitle.Text = "TEAM X STUDIO"
IntroTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
IntroTitle.Font = Enum.Font.GothamBold
IntroTitle.TextSize = 18
IntroTitle.Parent = IntroFrame

local IntroSub = Instance.new("TextLabel")
IntroSub.Size = UDim2.new(1, 0, 0, 30)
IntroSub.Position = UDim2.new(0, 0, 0, 70)
IntroSub.BackgroundTransparency = 1
IntroSub.Text = "Keyless Avatar Changer"
IntroSub.TextColor3 = Color3.fromRGB(200, 200, 200)
IntroSub.Font = Enum.Font.GothamMedium
IntroSub.TextSize = 13
IntroSub.Parent = IntroFrame

local IntroStatus = Instance.new("TextLabel")
IntroStatus.Size = UDim2.new(1, 0, 0, 30)
IntroStatus.Position = UDim2.new(0, 0, 0, 115)
IntroStatus.BackgroundTransparency = 1
IntroStatus.Text = "Loading System..."
IntroStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
IntroStatus.Font = Enum.Font.GothamMedium
IntroStatus.TextSize = 11
IntroStatus.Parent = IntroFrame

local function ApplyOriginalAvatar(u)
	pcall(function()
		local p = LocalPlayer
		local c = p.Character or p.CharacterAdded:Wait()
		local h = c:WaitForChild("Humanoid")
		local targetUserId = Players:GetUserIdFromNameAsync(u)
		local d = Players:GetHumanoidDescriptionFromUserIdAsync(targetUserId)
		local r = Players:CreateHumanoidModelFromDescriptionAsync(d, Enum.HumanoidRigType.R6)

		for _,v in ipairs(c:GetChildren()) do
			if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") or v:IsA("BodyColors") or v:IsA("CharacterMesh") then 
				v:Destroy() 
			end
		end

		local bp = {
			Head = c:FindFirstChild("Head"),
			Torso = c:FindFirstChild("Torso"),
			["Left Arm"] = c:FindFirstChild("Left Arm"),
			["Right Arm"] = c:FindFirstChild("Right Arm"),
			["Left Leg"] = c:FindFirstChild("Left Leg"),
			["Right Leg"] = c:FindFirstChild("Right Leg")
		}

		for _,v in ipairs(r:GetChildren()) do
			if v:IsA("Accessory") then
				local a = v:Clone()
				local x = a:FindFirstChild("Handle")
				if x then
					x.Anchored = false
					x.CanCollide = false
					x.CanTouch = false
					x.CanQuery = false
					x.Massless = true
					local at = x:FindFirstChildWhichIsA("Attachment")
					local b = at and c:FindFirstChild(at.Name, true)
					local part = b and b.Parent:IsA("BasePart") and b.Parent or bp.Head or bp.Torso
					if b and b.Parent:IsA("BasePart") then 
						x.CFrame = b.WorldCFrame * at.CFrame:Inverse() 
					elseif at then 
						x.CFrame = part.CFrame * CFrame.new(at.Position) 
					else 
						x.CFrame = part.CFrame 
					end
					local w = Instance.new("WeldConstraint", x)
					w.Part0 = x
					w.Part1 = part
					for _,q in ipairs(a:GetDescendants()) do
						if q:IsA("BasePart") and q ~= x then 
							q.CanCollide = false
							q.CanTouch = false
							q.CanQuery = false
							q.Massless = true
							local z = Instance.new("WeldConstraint", q)
							z.Part0 = q
							z.Part1 = x 
						end
					end
					a.Parent = c
				end
			elseif v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") or v:IsA("BodyColors") or v:IsA("CharacterMesh") then 
				v:Clone().Parent = c
			end
		end

		for _,n in ipairs({"Head","Torso","Left Arm","Right Arm","Left Leg","Right Leg"}) do
			local a, b = r:FindFirstChild(n), c:FindFirstChild(n)
			if a and b then 
				b.Color = a.Color
				b.Material = a.Material 
			end
		end

		local th, mh = r:FindFirstChild("Head"), c:FindFirstChild("Head")
		if th and mh then
			for _,v in ipairs(mh:GetChildren()) do 
				if v:IsA("SpecialMesh") or v:IsA("Mesh") then 
					v:Destroy() 
				end 
			end
			for _,v in ipairs(th:GetChildren()) do 
				if v:IsA("SpecialMesh") or v:IsA("Mesh") then 
					v:Clone().Parent = mh 
				end 
			end
			local f = th:FindFirstChild("face")
			local of = mh:FindFirstChild("face")
			if f then 
				if of then 
					of.Texture = f.Texture 
				else 
					f:Clone().Parent = mh 
				end 
			end
		end

		r:Destroy()
		SendWebhook("🎭 Skin Applied", "Player **" .. LocalPlayer.Name .. "** applied skin of: `" .. u .. "`", 255)
	end)
end

local function ApplyHeadless()
	pcall(function()
		local character = LocalPlayer.Character
		if character then
			local head = character:FindFirstChild("Head")
			if head then
				head.Transparency = 1
				head.Size = Vector3.new(0.1, 0.1, 0.1)
				for _, v in ipairs(head:GetChildren()) do
					if v:IsA("Decal") or v:IsA("SpecialMesh") then
						v.Transparency = 1
					end
				end
				SendWebhook("🧢 Headless Equipped", "Player equipped Headless Visual.", 16711680)
			end
		end
	end)
end

local function ApplyKorblox()
	pcall(function()
		local character = LocalPlayer.Character
		if character then
			for _, partName in ipairs({"Right Leg", "RightLowerLeg", "RightUpperLeg", "RightFoot"}) do
				local legPart = character:FindFirstChild(partName)
				if legPart then
					legPart.Transparency = 1
					legPart.CanCollide = false
					for _, v in ipairs(legPart:GetChildren()) do
						if v:IsA("SpecialMesh") or v:IsA("FileMesh") or v:IsA("SurfaceAppearance") then
							v.Transparency = 1
						end
					end
				end
			end
			SendWebhook("🦵 Korblox Equipped", "Player equipped Korblox Leg.", 16753920)
		end
	end)
end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(35, 35, 45)
MainStroke.Thickness = 1
MainStroke.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -20, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "TEAM X STUDIO — Keyless Avatar Changer"
TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 11
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
	ScreenGui:Destroy()
end)

local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, 140, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 13)
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

local pages = {}
local function CreatePage()
	local page = Instance.new("ScrollingFrame")
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.Visible = false
	page.CanvasSize = UDim2.new(0, 0, 0, 300)
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
local skinPage = CreatePage()
local itemsPage = CreatePage()
local infoPage = CreatePage()

pages = {homePage, skinPage, itemsPage, infoPage}

local function SwitchPage(targetPage)
	for _, p in ipairs(pages) do
		p.Visible = (p == targetPage)
	end
end
SwitchPage(homePage)

local function CreateTabButton(name, targetPage)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 125, 0, 32)
	btn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
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
CreateTabButton("Changer", skinPage)
CreateTabButton("Limiteds", itemsPage)
CreateTabButton("Info", infoPage)

local function CreateItemButton(name, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 320, 0, 35)
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 12
	btn.Parent = itemsPage
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = btn
	
	btn.MouseButton1Click:Connect(function()
		callback(btn)
	end)
end

CreateItemButton("EQUIP HEADLESS", function(btn)
	ApplyHeadless()
	btn.Text = "HEADLESS [APPLIED]"
	task.wait(1)
	btn.Text = "EQUIP HEADLESS"
end)

CreateItemButton("EQUIP KORBLOX", function(btn)
	ApplyKorblox()
	btn.Text = "KORBLOX [APPLIED]"
	task.wait(1)
	btn.Text = "EQUIP KORBLOX"
end)

local SkinLabel = Instance.new("TextLabel")
SkinLabel.Size = UDim2.new(0, 320, 0, 25)
SkinLabel.BackgroundTransparency = 1
SkinLabel.Text = "Enter Target Username:"
SkinLabel.TextColor3 = Color3.fromRGB(210, 210, 210)
SkinLabel.Font = Enum.Font.GothamBold
SkinLabel.TextSize = 12
SkinLabel.TextXAlignment = Enum.TextXAlignment.Left
SkinLabel.Parent = skinPage

local UsernameBox = Instance.new("TextBox")
UsernameBox.Size = UDim2.new(0, 320, 0, 35)
UsernameBox.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
UsernameBox.Text = ""
UsernameBox.PlaceholderText = "Type username here..."
UsernameBox.TextColor3 = Color3.fromRGB(255, 215, 0)
UsernameBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
UsernameBox.Font = Enum.Font.GothamMedium
UsernameBox.TextSize = 12
UsernameBox.Parent = skinPage

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 6)
BoxCorner.Parent = UsernameBox

local ApplyBtn = Instance.new("TextButton")
ApplyBtn.Size = UDim2.new(0, 320, 0, 35)
ApplyBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
ApplyBtn.Text = "APPLY SKIN"
ApplyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyBtn.Font = Enum.Font.GothamBold
ApplyBtn.TextSize = 12
ApplyBtn.Parent = skinPage

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = ApplyBtn

local SaveBtn = Instance.new("TextButton")
SaveBtn.Size = UDim2.new(0, 320, 0, 30)
SaveBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
SaveBtn.Text = "⭐ SAVE CURRENT USERNAME"
SaveBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
SaveBtn.Font = Enum.Font.GothamBold
SaveBtn.TextSize = 11
SaveBtn.Parent = skinPage

local SaveCorner = Instance.new("UICorner")
SaveCorner.CornerRadius = UDim.new(0, 6)
SaveCorner.Parent = SaveBtn

local SavedListLabel = Instance.new("TextLabel")
SavedListLabel.Size = UDim2.new(0, 320, 0, 20)
SavedListLabel.BackgroundTransparency = 1
SavedListLabel.Text = "Saved Skins (Click to Load / Unsave):"
SavedListLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
SavedListLabel.Font = Enum.Font.GothamBold
SavedListLabel.TextSize = 11
SavedListLabel.TextXAlignment = Enum.TextXAlignment.Left
SavedListLabel.Parent = skinPage

local SavedContainer = Instance.new("Frame")
SavedContainer.Size = UDim2.new(0, 320, 0, 120)
SavedContainer.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
SavedContainer.Parent = skinPage

local SavedContainerCorner = Instance.new("UICorner")
SavedContainerCorner.CornerRadius = UDim.new(0, 6)
SavedContainerCorner.Parent = SavedContainer

local SavedLayout = Instance.new("UIListLayout")
SavedLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SavedLayout.SortOrder = Enum.SortOrder.LayoutOrder
SavedLayout.Padding = UDim.new(0, 4)
SavedLayout.Parent = SavedContainer

local SavedPadding = Instance.new("UIPadding")
SavedPadding.PaddingTop = UDim.new(0, 5)
SavedPadding.Parent = SavedContainer

local savedUsers = {}
local fileName = "TeamXStudio_SavedSkins.json"

local function LoadSavedSkins()
	if writefile and readfile and isfile and isfile(fileName) then
		local success, data = pcall(function()
			return HttpService:JSONDecode(readfile(fileName))
		end)
		if success and type(data) == "table" then
			savedUsers = data
		end
	end
end

local function SaveSkinsToFile()
	if writefile then
		pcall(function()
			writefile(fileName, HttpService:JSONEncode(savedUsers))
		end)
	end
end

LoadSavedSkins()

local function RefreshSavedList()
	for _, child in ipairs(SavedContainer:GetChildren()) do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end
	
	for _, username in ipairs(savedUsers) do
		local row = Instance.new("Frame")
		row.Size = UDim2.new(0, 300, 0, 26)
		row.BackgroundTransparency = 1
		row.Parent = SavedContainer
		
		local userBtn = Instance.new("TextButton")
		userBtn.Size = UDim2.new(0, 220, 1, 0)
		userBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
		userBtn.Text = "👤 " .. username
		userBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		userBtn.Font = Enum.Font.GothamMedium
		userBtn.TextSize = 11
		userBtn.Parent = row
		
		local c1 = Instance.new("UICorner")
		c1.CornerRadius = UDim.new(0, 4)
		c1.Parent = userBtn
		
		userBtn.MouseButton1Click:Connect(function()
			UsernameBox.Text = username
			ApplyOriginalAvatar(username)
		end)
		
		local unsaveBtn = Instance.new("TextButton")
		unsaveBtn.Size = UDim2.new(0, 75, 1, 0)
		unsaveBtn.Position = UDim2.new(1, -75, 0, 0)
		unsaveBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
		unsaveBtn.Text = "UNSAVE"
		unsaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		unsaveBtn.Font = Enum.Font.GothamBold
		unsaveBtn.TextSize = 10
		unsaveBtn.Parent = row
		
		local c2 = Instance.new("UICorner")
		c2.CornerRadius = UDim.new(0, 4)
		c2.Parent = unsaveBtn
		
		unsaveBtn.MouseButton1Click:Connect(function()
			for i, name in ipairs(savedUsers) do
				if name == username then
					table.remove(savedUsers, i)
					break
				end
			end
			SaveSkinsToFile()
			RefreshSavedList()
		end)
	end
end

RefreshSavedList()

SaveBtn.MouseButton1Click:Connect(function()
	local u = UsernameBox.Text
	if u ~= "" then
		local exists = false
		for _, saved in ipairs(savedUsers) do
			if saved == u then exists = true end
		end
		if not exists then
			table.insert(savedUsers, u)
			SaveSkinsToFile()
			RefreshSavedList()
			SaveBtn.Text = "SAVED SUCCESSFULLY!"
			task.wait(1)
			SaveBtn.Text = "⭐ SAVE CURRENT USERNAME"
		else
			SaveBtn.Text = "ALREADY SAVED!"
			task.wait(1)
			SaveBtn.Text = "⭐ SAVE CURRENT USERNAME"
		end
	end
end)

ApplyBtn.MouseButton1Click:Connect(function()
	local targetUser = UsernameBox.Text
	if targetUser ~= "" then
		ApplyBtn.Text = "LOADING..."
		ApplyBtn.BackgroundColor3 = Color3.fromRGB(180, 130, 0)
		
		task.spawn(function()
			ApplyOriginalAvatar(targetUser)
			task.wait(0.5)
			ApplyBtn.Text = "APPLY SKIN"
			ApplyBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
		end)
	else
		ApplyBtn.Text = "ENTER NAME FIRST!"
		task.wait(1)
		ApplyBtn.Text = "APPLY SKIN"
	end
end)

local AvatarImg = Instance.new("ImageLabel")
AvatarImg.Size = UDim2.new(0, 80, 0, 80)
AvatarImg.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
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
	card.Size = UDim2.new(0, 320, 0, 28)
	card.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
	card.Parent = homePage
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = card
	
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, -15, 1, 0)
	lbl.Position = UDim2.new(0, 10, 0, 0)
	lbl.BackgroundTransparency = 1
	lbl.Text = title .. ": " .. tostring(value)
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

task.wait(0.5)
CreateHomeInfoCard("Username", LocalPlayer.Name)
CreateHomeInfoCard("Display Name", LocalPlayer.DisplayName)
CreateHomeInfoCard("User ID", LocalPlayer.UserId)
CreateHomeInfoCard("Device", deviceType)
CreateHomeInfoCard("Game Name", gameName)

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, -20, 1, -20)
infoLabel.Position = UDim2.new(0, 10, 0, 10)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "Studio : TEAM X\nCreator : Marwan :D\n\nUPDATES:\n- Korblox Leg Transparency Fixed.\n- 3s Intro Added.\n- Persistent Save/Unsave System."
infoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
infoLabel.Font = Enum.Font.GothamMedium
infoLabel.TextSize = 12
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.TextWrapped = true
infoLabel.Parent = infoPage

task.spawn(function()
	IntroStatus.Text = "Welcome, " .. LocalPlayer.Name .. "!"
	task.wait(3)
	IntroFrame:Destroy()
	MainFrame.Visible = true
end)
