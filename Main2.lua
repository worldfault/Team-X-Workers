local t1 = {}
local unpack_ = unpack or table.unpack
local t2 = {
	value1 = game:GetService("CoreGui"),
	value2 = game:GetService("Players")
}
local UserInputService = game:GetService("UserInputService")

t2.value3 = game:GetService("MarketplaceService")
t2.value4 = game:GetService("HttpService")
t2.value5 = t2.value2.LocalPlayer

if t2.value1:FindFirstChild("TeamXStudioHub") then
	t2.value1.TeamXStudioHub:Destroy()
end

pcall(function()
	local _ = t2.value3:GetProductInfo(game.PlaceId).Name
end)

t2.value7 = Instance.new("ScreenGui")
t2.value7.Name = "TeamXStudioHub"
t2.value7.ResetOnSpawn = false
pcall(function()
	t2.value7.Parent = t2.value1
end)

if not t2.value7.Parent then
	local value7 = t2.value7

	t1.value2 = t2.value5:WaitForChild("PlayerGui")
	value7.Parent = t1.value2
end

t2.value8 = Instance.new("Frame")
t2.value8.Size = UDim2.new(0, 400, 0, 180)
t2.value8.Position = UDim2.new(0.5, -200, 0.5, -90)
t2.value8.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
t2.value8.BorderSizePixel = 0
t2.value8.Parent = t2.value7

local UICorner = Instance.new("UICorner")

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = t2.value8
t1.value2 = Instance.new("UIStroke")
t1.value2.Color = Color3.fromRGB(255, 215, 0)
t1.value2.Thickness = 1.5
t1.value2.Parent = t2.value8

local TextLabel = Instance.new("TextLabel")

TextLabel.Size = UDim2.new(1, 0, 0, 40)
TextLabel.Position = UDim2.new(0, 0, 0, 30)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "TEAM X STUDIO"
TextLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextSize = 18
TextLabel.Parent = t2.value8

local TextLabel2 = Instance.new("TextLabel")

TextLabel2.Size = UDim2.new(1, 0, 0, 30)
TextLabel2.Position = UDim2.new(0, 0, 0, 70)
t1.value4 = 1159796408860
t1.value3 = "\130\5\155\0075\2518q\5\239٬\220ҕ\247\201ǰ<y\n"
TextLabel2.BackgroundTransparency = 1
TextLabel2.Text = "Keyless Avatar Changer"
TextLabel2.TextColor3 = Color3.fromRGB(200, 200, 200)
TextLabel2.Font = Enum.Font.GothamMedium
TextLabel2.TextSize = 13
TextLabel2.Parent = t2.value8
t2.value9 = Instance.new("TextLabel")
t2.value9.Size = UDim2.new(1, 0, 0, 30)
t2.value9.Position = UDim2.new(0, 0, 0, 115)
t2.value9.BackgroundTransparency = 1
t2.value9.Text = "Loading System..."
t2.value9.TextColor3 = Color3.fromRGB(150, 150, 150)
t2.value9.Font = Enum.Font.GothamMedium
t2.value9.TextSize = 11

local value9 = t2.value9

function t1.value3()
	local function v20()
		local Character = t2.value5.Character

		if not Character then
			return
		end

		for _, v in ipairs({
			"Right Leg",
			"RightLowerLeg",
			"RightUpperLeg",
			"RightFoot"
		}) do
			local v24 = Character:FindFirstChild(v)

			if v24 then
				v24.Transparency = 1
				v24.CanCollide = false

				local ipairs_ = ipairs

				for _, child in ipairs_(v24.GetChildren(v24)) do
					if child:IsA("SpecialMesh") or (child:IsA("FileMesh") or child:IsA("SurfaceAppearance")) then
						child.Transparency = 1
						ipairs_ = "Transparency"
					end
				end
			end
		end
	end

	pcall(v20)
end

value9.Parent = t2.value8

function t2.value10(p1)
	local v37 = nil

	local function v38()
		local value5 = t2.value5
		local Character = value5.Character or value5.CharacterAdded:Wait()

		Character:WaitForChild("Humanoid")

		local userIdFromNameAsync = t2.value2:GetUserIdFromNameAsync(v37)
		local humanoidDescriptionFromUserIdAsy = t2.value2:GetHumanoidDescriptionFromUserIdAsync(userIdFromNameAsync)
		local v43 = t2.value2:CreateHumanoidModelFromDescriptionAsync(humanoidDescriptionFromUserIdAsy, Enum.HumanoidRigType.R6)
		local GetChildren = Character.GetChildren
		local ipairs_ = ipairs

		for _, v in ipairs_(GetChildren(Character)) do
			if v:IsA("Accessory") or (v:IsA("Shirt") or (v:IsA("Pants") or (v:IsA("ShirtGraphic") or (v:IsA("BodyColors") or v:IsA("CharacterMesh"))))) then
				ipairs_ = v:Destroy()
			end
		end

		local t7 = {
			Head = Character:FindFirstChild("Head"),
			Torso = Character:FindFirstChild("Torso"),
			["Left Arm"] = Character:FindFirstChild("Left Arm"),
			["Right Arm"] = Character:FindFirstChild("Right Arm"),
			["Left Leg"] = Character:FindFirstChild("Left Leg"),
			["Right Leg"] = Character:FindFirstChild("Right Leg")
		}
		local GetChildren2 = v43.GetChildren
		local v50, v51, v52 = ipairs(GetChildren2(v43))

		while true do
			local v53

			v52, v53 = v50(v51, v52)

			if not v52 then
				break
			end

			if v53:IsA("Accessory") then
				local clone = v53:Clone()
				local Handle = clone:FindFirstChild("Handle")

				if Handle then
					Handle.Anchored = false
					Handle.CanCollide = false
					Handle.CanTouch = false
					Handle.CanQuery = false
					Handle.Massless = true

					local Attachment = Handle:FindFirstChildWhichIsA("Attachment")
					local AttachmentName

					if Attachment then
						AttachmentName = Character:FindFirstChild(Attachment.Name, true)
					else
						AttachmentName = Attachment
					end

					local isBasePart

					if AttachmentName then
						isBasePart = AttachmentName.Parent:IsA("BasePart")

						if isBasePart then
							isBasePart = AttachmentName.Parent
						end
					else
						isBasePart = AttachmentName
					end

					local Head = isBasePart or (t7.Head or t7.Torso)
					local isBasePart2

					if AttachmentName then
						isBasePart2 = AttachmentName.Parent:IsA("BasePart")
					else
						isBasePart2 = AttachmentName
					end

					if isBasePart2 then
						Handle.CFrame = AttachmentName.WorldCFrame * Attachment.CFrame:Inverse()
					elseif Attachment then
						Handle.CFrame = Head.CFrame * CFrame.new(Attachment.Position)
					else
						Handle.CFrame = Head.CFrame
					end

					local WeldConstraint = Instance.new("WeldConstraint", Handle)

					WeldConstraint.Part0 = Handle
					WeldConstraint.Part1 = Head

					for _, descendant in ipairs(clone.GetDescendants(clone)) do
						local isBasePart3 = descendant:IsA("BasePart")

						if isBasePart3 then
							isBasePart3 = descendant ~= Handle
						end

						if isBasePart3 then
							descendant.CanCollide = false
							descendant.CanTouch = false
							descendant.CanQuery = false
							descendant.Massless = true

							local WeldConstraint2 = Instance.new("WeldConstraint", descendant)

							WeldConstraint2.Part0 = descendant
							WeldConstraint2.Part1 = Handle
						end
					end

					clone.Parent = Character
				end
			elseif v53:IsA("Shirt") or (v53:IsA("Pants") or (v53:IsA("ShirtGraphic") or (v53:IsA("BodyColors") or v53:IsA("CharacterMesh")))) then
				v53:Clone().Parent = Character
			end
		end

		for _, v in ipairs({
			"Head",
			"Torso",
			"Left Arm",
			"Right Arm",
			"Left Leg",
			"Right Leg"
		}) do
			local v68 = v43:FindFirstChild(v)
			local v69 = Character:FindFirstChild(v)

			if v68 and v69 then
				v69.Color = v68.Color
				v69.Material = v68.Material
			end
		end

		local Head = v43:FindFirstChild("Head")
		local Head2 = Character:FindFirstChild("Head")

		if Head and Head2 then
			local GetChildren3 = Head2.GetChildren

			for _, v in ipairs(GetChildren3(Head2)) do
				if v:IsA("SpecialMesh") or v:IsA("Mesh") then
					v:Destroy()
				end
			end

			local GetChildren4 = Head.GetChildren
			local v76, v77, v78 = ipairs(GetChildren4(Head))

			while true do
				local v79

				v78, v79 = v76(v77, v78)

				if not v78 then
					break
				end

				if v79:IsA("SpecialMesh") or v79:IsA("Mesh") then
					v79:Clone().Parent = Head2
				end
			end

			local face = Head:FindFirstChild("face")
			local face2 = Head2:FindFirstChild("face")

			if face then
				if face2 then
					face2.Texture = face.Texture
				else
					face:Clone().Parent = Head2
				end
			end
		end

		v43:Destroy()
	end

	v37 = p1
	pcall(v38)
end

function t2.value11()
	local function v91()
		local Character = t2.value5.Character
		local Head = Character and Character:FindFirstChild("Head")

		if not Head then
			return
		end

		Head.Transparency = 1
		Head.Size = Vector3.new(0.1, 0.1, 0.1)

		local GetChildren = Head.GetChildren

		for _, v in ipairs(GetChildren(Head)) do
			if v:IsA("Decal") or v:IsA("SpecialMesh") then
				v.Transparency = 1
			end
		end
	end

	pcall(v91)
end

t2.value12 = t1.value3
t2.value13 = Instance.new("Frame")
t2.value13.Size = UDim2.new(0, 520, 0, 360)
t2.value13.Position = UDim2.new(0.5, -260, 0.5, -180)
t2.value13.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
t2.value13.BorderSizePixel = 0
t2.value13.Visible = false
t2.value13.Active = true
t2.value13.Draggable = true
t2.value13.Parent = t2.value7

local UICorner2 = Instance.new("UICorner")

UICorner2.CornerRadius = UDim.new(0, 10)
UICorner2.Parent = t2.value13

local UIStroke = Instance.new("UIStroke")

UIStroke.Color = Color3.fromRGB(35, 35, 45)
UIStroke.Thickness = 1
UIStroke.Parent = t2.value13

local Frame = Instance.new("Frame")

Frame.Size = UDim2.new(1, 0, 0, 40)
Frame.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
Frame.BorderSizePixel = 0
Frame.Parent = t2.value13

local UICorner3 = Instance.new("UICorner")

UICorner3.CornerRadius = UDim.new(0, 10)
UICorner3.Parent = Frame

local TextLabel3 = Instance.new("TextLabel")

TextLabel3.Size = UDim2.new(1, -20, 1, 0)
TextLabel3.Position = UDim2.new(0, 15, 0, 0)
TextLabel3.BackgroundTransparency = 1
TextLabel3.Text = "TEAM X STUDIO — Keyless Avatar Changer"
TextLabel3.TextColor3 = Color3.fromRGB(255, 215, 0)
TextLabel3.Font = Enum.Font.GothamBold
TextLabel3.TextSize = 11
TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
TextLabel3.Parent = Frame

local TextButton = Instance.new("TextButton")

TextButton.Size = UDim2.new(0, 24, 0, 24)
TextButton.Position = UDim2.new(1, -32, 0.5, -12)
TextButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
TextButton.Text = "X"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.Font = Enum.Font.GothamBold
TextButton.TextSize = 12
TextButton.Parent = Frame

local UICorner4 = Instance.new("UICorner")

UICorner4.CornerRadius = UDim.new(0, 4)
UICorner4.Parent = TextButton
TextButton.MouseButton1Click:Connect(function()
	t2.value7:Destroy()
end)

t2.value14 = Instance.new("ScrollingFrame")
t2.value14.Size = UDim2.new(0, 140, 1, -40)
t2.value14.Position = UDim2.new(0, 0, 0, 40)
t2.value14.BackgroundColor3 = Color3.fromRGB(10, 10, 13)
t2.value14.BorderSizePixel = 0
t2.value14.CanvasSize = UDim2.new(0, 0, 0, 0)
t2.value14.ScrollBarThickness = 2
t2.value14.Parent = t2.value13

local UIListLayout = Instance.new("UIListLayout")

UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.Parent = t2.value14

local UIPadding = Instance.new("UIPadding")

UIPadding.PaddingTop = UDim.new(0, 12)
UIPadding.Parent = t2.value14

t2.value15 = Instance.new("Frame")
t2.value15.Size = UDim2.new(1, -140, 1, -40)
t2.value15.Position = UDim2.new(0, 140, 0, 40)
t2.value15.BackgroundTransparency = 1
t2.value15.Parent = t2.value13
t2.value16 = {}

local function createScrollingFrame()
	local ScrollingFrame = Instance.new("ScrollingFrame")

	ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
	ScrollingFrame.BackgroundTransparency = 1
	ScrollingFrame.Visible = false
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 300)
	ScrollingFrame.ScrollBarThickness = 3
	ScrollingFrame.Parent = t2.value15

	local UIListLayout2 = Instance.new("UIListLayout")

	UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout2.Padding = UDim.new(0, 8)
	UIListLayout2.Parent = ScrollingFrame

	local UIPadding2 = Instance.new("UIPadding")

	UIPadding2.PaddingTop = UDim.new(0, 15)
	UIPadding2.Parent = ScrollingFrame

	return ScrollingFrame
end

t2.value17 = createScrollingFrame()
local v119 = createScrollingFrame()
t2.value18 = createScrollingFrame()
local v120 = createScrollingFrame()

t2.value16 = {
	t2.value17,
	v119,
	t2.value18,
	v120
}

local value17 = t2.value17

for _, v in ipairs(t2.value16) do
	v.Visible = v == value17
end

local function v124(p2, p3)
	local TextButton2 = Instance.new("TextButton")

	TextButton2.Size = UDim2.new(0, 125, 0, 32)
	TextButton2.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	TextButton2.Text = p2
	TextButton2.TextColor3 = Color3.fromRGB(170, 170, 170)
	TextButton2.Font = Enum.Font.GothamMedium
	TextButton2.TextSize = 11
	TextButton2.Parent = t2.value14

	local UICorner5 = Instance.new("UICorner")

	UICorner5.CornerRadius = UDim.new(0, 6)
	UICorner5.Parent = TextButton2

	local function v127()
		local v128 = p3

		for _, v in ipairs(t2.value16) do
			v.Visible = v == v128
		end
	end

	TextButton2.MouseButton1Click:Connect(v127)
end

v124("Home", t2.value17)
v124("Changer", v119)
v124("Limiteds", t2.value18)
v124("Info", v120)

local function v131(p4, p5)
	local TextButton2 = Instance.new("TextButton")

	TextButton2.Size = UDim2.new(0, 320, 0, 35)
	TextButton2.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	TextButton2.Text = p4
	TextButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextButton2.Font = Enum.Font.GothamBold
	TextButton2.TextSize = 12
	TextButton2.Parent = t2.value18

	local UICorner5 = Instance.new("UICorner")

	UICorner5.CornerRadius = UDim.new(0, 6)
	UICorner5.Parent = TextButton2
	TextButton2.MouseButton1Click:Connect(function()
		p5(TextButton2)
	end)
end

v131("EQUIP HEADLESS", function(p6)
	t2.value11()
	p6.Text = "HEADLESS [APPLIED]"
	task.wait(1)
	p6.Text = "EQUIP HEADLESS"
end)
v131("EQUIP KORBLOX", function(p7)
	t2.value12()
	p7.Text = "KORBLOX [APPLIED]"
	task.wait(1)
	p7.Text = "EQUIP KORBLOX"
end)

local TextLabel4 = Instance.new("TextLabel")

TextLabel4.Size = UDim2.new(0, 320, 0, 25)
TextLabel4.BackgroundTransparency = 1
TextLabel4.Text = "Enter Target Username:"
TextLabel4.TextColor3 = Color3.fromRGB(210, 210, 210)
TextLabel4.Font = Enum.Font.GothamBold
TextLabel4.TextSize = 12
TextLabel4.TextXAlignment = Enum.TextXAlignment.Left
TextLabel4.Parent = v119

t2.value19 = Instance.new("TextBox")
t2.value19.Size = UDim2.new(0, 320, 0, 35)
t2.value19.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
t2.value19.Text = ""
t2.value19.PlaceholderText = "Type username here..."
t2.value19.TextColor3 = Color3.fromRGB(255, 215, 0)
t2.value19.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
t2.value19.Font = Enum.Font.GothamMedium
t2.value19.TextSize = 12
t2.value19.Parent = v119

local UICorner5 = Instance.new("UICorner")

UICorner5.CornerRadius = UDim.new(0, 6)
UICorner5.Parent = t2.value19

t2.value20 = Instance.new("TextButton")
t2.value20.Size = UDim2.new(0, 320, 0, 35)
t2.value20.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
t2.value20.Text = "APPLY SKIN"
t2.value20.TextColor3 = Color3.fromRGB(255, 255, 255)
t2.value20.Font = Enum.Font.GothamBold
t2.value20.TextSize = 12
t2.value20.Parent = v119

local UICorner6 = Instance.new("UICorner")

UICorner6.CornerRadius = UDim.new(0, 6)
UICorner6.Parent = t2.value20

t2.value21 = Instance.new("TextButton")
t2.value21.Size = UDim2.new(0, 320, 0, 30)
t2.value21.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
t2.value21.Text = "⭐ SAVE CURRENT USERNAME"
t2.value21.TextColor3 = Color3.fromRGB(255, 215, 0)
t2.value21.Font = Enum.Font.GothamBold
t2.value21.TextSize = 11
t2.value21.Parent = v119

local UICorner7 = Instance.new("UICorner")

UICorner7.CornerRadius = UDim.new(0, 6)
UICorner7.Parent = t2.value21

local TextLabel5 = Instance.new("TextLabel")

TextLabel5.Size = UDim2.new(0, 320, 0, 20)
TextLabel5.BackgroundTransparency = 1
TextLabel5.Text = "Saved Skins (Click to Load / Unsave):"
TextLabel5.TextColor3 = Color3.fromRGB(170, 170, 170)
TextLabel5.Font = Enum.Font.GothamBold
TextLabel5.TextSize = 11
TextLabel5.TextXAlignment = Enum.TextXAlignment.Left
TextLabel5.Parent = v119

t2.value22 = Instance.new("Frame")
t2.value22.Size = UDim2.new(0, 320, 0, 120)
t2.value22.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
t2.value22.Parent = v119

local UICorner8 = Instance.new("UICorner")

UICorner8.CornerRadius = UDim.new(0, 6)
UICorner8.Parent = t2.value22

local UIListLayout2 = Instance.new("UIListLayout")

UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout2.Padding = UDim.new(0, 4)
UIListLayout2.Parent = t2.value22

local UIPadding2 = Instance.new("UIPadding")

UIPadding2.PaddingTop = UDim.new(0, 5)
UIPadding2.Parent = t2.value22

t2.value23 = {}
t2.value24 = "TeamXStudio_SavedSkins.json"

function t2.value25()
	if not writefile then
		return
	end

	local function v142()
		writefile(t2.value24, t2.value4:JSONEncode(t2.value23))
	end

	pcall(v142)
end

(function()
	local writefile_ = writefile

	if writefile_ then
		writefile_ = readfile

		if writefile_ then
			writefile_ = isfile

			if writefile_ then
				writefile_ = isfile(t2.value24)
			end
		end
	end

	if not writefile_ then
		return
	end

	local function v144()
		return t2.value4:JSONDecode(unpack_({ readfile(t2.value24) }))
	end

	local ok, value23 = pcall(v144)

	if ok then
		ok = type(value23) == "table"
	end

	if not ok then
		return
	end

	t2.value23 = value23
end)()

t2.value26 = nil

function t2.value26()
	local ipairs_ = ipairs
	local value22 = t2.value22
	local v149, v150, v151 = ipairs_(value22.GetChildren(value22))

	while true do
		local v152

		v151, v152 = v149(v150, v151)

		if not v151 then
			break
		end

		if v152:IsA("Frame") then
			v152:Destroy()
		end
	end

	for _, v in ipairs(t2.value23) do
		local Frame2 = Instance.new("Frame")

		Frame2.Size = UDim2.new(0, 300, 0, 26)
		Frame2.BackgroundTransparency = 1
		Frame2.Parent = t2.value22

		local TextButton2 = Instance.new("TextButton")

		TextButton2.Size = UDim2.new(0, 220, 1, 0)
		TextButton2.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
		TextButton2.Text = "👤 " .. v
		TextButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton2.Font = Enum.Font.GothamMedium
		TextButton2.TextSize = 11
		TextButton2.Parent = Frame2

		local UICorner9 = Instance.new("UICorner")

		UICorner9.CornerRadius = UDim.new(0, 4)
		UICorner9.Parent = TextButton2
		TextButton2.MouseButton1Click:Connect(function()
			t2.value19.Text = v
			t2.value10(v)
		end)

		local TextButton3 = Instance.new("TextButton")

		TextButton3.Size = UDim2.new(0, 75, 1, 0)
		TextButton3.Position = UDim2.new(1, -75, 0, 0)
		TextButton3.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
		TextButton3.Text = "UNSAVE"
		TextButton3.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton3.Font = Enum.Font.GothamBold
		TextButton3.TextSize = 10
		TextButton3.Parent = Frame2

		local UICorner10 = Instance.new("UICorner")

		UICorner10.CornerRadius = UDim.new(0, 4)
		UICorner10.Parent = TextButton3

		local function v160()
			for i, v2 in ipairs(t2.value23) do
				if v2 == v then
					table.remove(t2.value23, i)
					break
				end
			end

			t2.value25()
			t2.value26()
		end

		local MouseButton1Click = TextButton3.MouseButton1Click
		MouseButton1Click.Connect(MouseButton1Click, v160)
	end
end

t2.value26()

local MouseButton1Click = t2.value21.MouseButton1Click
t1.value4 = MouseButton1Click.Connect
t1.value5 = "\164\253\2436-\f\251\1387\227/U`$ߤ\29"
t1.value4(MouseButton1Click, function()
	local Text = t2.value19.Text

	if Text == "" then
		return
	end

	local v166, v167, v168 = ipairs(t2.value23)
	local v169 = false

	while true do
		local v170

		v168, v170 = v166(v167, v168)

		if not v168 then
			break
		end

		v169 = v170 == Text and true or v169
	end

	if not v169 then
		local value23 = t2.value23

		table.insert(value23, Text)
		t2.value25()
		t2.value26()
		t2.value21.Text = "SAVED SUCCESSFULLY!"
		task.wait(1)
		t2.value21.Text = "⭐ SAVE CURRENT USERNAME"

		return
	end

	t2.value21.Text = "ALREADY SAVED!"
	task.wait(1)
	t2.value21.Text = "⭐ SAVE CURRENT USERNAME"
end)

t2.value20.MouseButton1Click:Connect(function()
	local Text = t2.value19.Text

	if Text == "" then
		t2.value20.Text = "ENTER NAME FIRST!"
		task.wait(1)
		t2.value20.Text = "APPLY SKIN"

		return
	end

	t2.value20.Text = "LOADING..."
	t2.value20.BackgroundColor3 = Color3.fromRGB(180, 130, 0)
	task.spawn(function()
		t2.value10(Text)
		task.wait(0.5)
		t2.value20.Text = "APPLY SKIN"
		t2.value20.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
	end)
end)

t1.value4 = Instance.new("ImageLabel")
t2.value27 = t1.value4
t2.value27.Size = UDim2.new(0, 80, 0, 80)
t1.value4 = t2.value27

local color3 = Color3.fromRGB
t1.value6 = 15
t1.value5 = 15

local color32 = color3(t1.value6, t1.value5, 20)
t1.value4.BackgroundColor3 = color32

pcall(function()
	t2.value27.Image = t2.value2:GetUserThumbnailAsync(t2.value5.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
end)
t2.value27.Parent = t2.value17

local UICorner9 = Instance.new("UICorner")
local uDimNew = UDim.new

t1.value5 = 0
t1.value6 = 1
UICorner9.CornerRadius = uDimNew(t1.value6, t1.value5)
UICorner9.Parent = t2.value27

local UIStroke2 = Instance.new("UIStroke")

UIStroke2.Color = Color3.fromRGB(255, 215, 0)
UIStroke2.Thickness = 2
UIStroke2.Parent = t2.value27

function t1.value4(p8, p9)
	local Frame2 = Instance.new("Frame")

	Frame2.Size = UDim2.new(0, 320, 0, 28)
	Frame2.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
	Frame2.Parent = t2.value17

	local UICorner10 = Instance.new("UICorner")

	UICorner10.CornerRadius = UDim.new(0, 6)
	UICorner10.Parent = Frame2

	local TextLabel6 = Instance.new("TextLabel")

	TextLabel6.Size = UDim2.new(1, -15, 1, 0)
	TextLabel6.Position = UDim2.new(0, 10, 0, 0)
	TextLabel6.BackgroundTransparency = 1
	TextLabel6.Text = p8 .. ": " .. tostring(p9)
	TextLabel6.TextColor3 = Color3.fromRGB(210, 210, 210)
	TextLabel6.Font = Enum.Font.GothamMedium
	TextLabel6.TextSize = 11
	TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel6.Parent = Frame2
end

local TouchEnabled = UserInputService.TouchEnabled
t1.value5 = TouchEnabled

if TouchEnabled then
	t1.value7 = t1.value1

	local value5 = not UserInputService.KeyboardEnabled and "Mobile"
	local value7 = t1.value7

	t1.value5 = value5
	t1.value1 = value7
end

local value5 = t1.value5 or "PC / Chromebook"
t2.value28 = "Loading..."

task.spawn(function()
	local function v185()
		t2.value28 = t2.value3:GetProductInfo(game.PlaceId).Name
	end

	pcall(v185)
end)

task.wait(0.5)
t1.value4("Username", t2.value5.Name)
t1.value4("Display Name", t2.value5.DisplayName)
t1.value4("User ID", t2.value5.UserId)
t1.value4("Device", value5)
t1.value4("Game Name", t2.value28)

local TextLabel6 = Instance.new("TextLabel")

TextLabel6.Size = UDim2.new(1, -20, 1, -20)
TextLabel6.Position = UDim2.new(0, 10, 0, 10)
TextLabel6.BackgroundTransparency = 1
TextLabel6.Text = "Studio : TEAM X\nCreator : Marwan :D\n\nUPDATES:\n- Korblox Leg Transparency Fixed.\n- 3s Intro Added.\n- Persistent Save/Unsave System."
TextLabel6.TextColor3 = Color3.fromRGB(180, 180, 180)
TextLabel6.Font = Enum.Font.GothamMedium
TextLabel6.TextSize = 12
TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
TextLabel6.TextYAlignment = Enum.TextYAlignment.Top
TextLabel6.TextWrapped = true
TextLabel6.Parent = v120

task.spawn(function()
	t2.value9.Text = "Welcome, " .. t2.value5.Name .. "!"
	task.wait(3)
	t2.value8:Destroy()
	t2.value13.Visible = true
end)
