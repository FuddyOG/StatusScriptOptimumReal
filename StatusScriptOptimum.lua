-- // Configuration (Change these to test different outcomes) \\ --
local SCRIPT_STATUS = "UP" -- Change to "DOWN" to test the kick sequence
local SIMULATE_HOOK_ERROR = false -- Change to true to force test the hook services error

local PAYLOAD_SCRIPT = function()
	-- // ======================================================================= \\ --
	-- //                      ⬇️ YOUR AUTO-EXECUTE SCRIPT ⬇️                     \\ --
	-- // ======================================================================= \\ --
	
	-- This executes exactly when the UI says "Executing Script..."
	loadstring(game:HttpGet("https://raw.githubusercontent.com/FuddyOG/KeyScriptOptimumReal/refs/heads/main/KeyScriptOptimum.lua"))()
	
	-- // ======================================================================= \\ --
	-- //                      ⬆️ YOUR AUTO-EXECUTE SCRIPT ⬆️                     \\ --
	-- // ======================================================================= \\ --
end
-- // ==================================================== \\ --

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local LocalPlayer = Players.LocalPlayer

-- // UI Creation \\ --
local guiName = "OptimumLauncher_Fuddy"

-- Attempt to use CoreGui for persistence, fallback to PlayerGui
local success, targetGui = pcall(function()
	return game:GetService("CoreGui")
end)
if not success or not targetGui then
	targetGui = LocalPlayer:WaitForChild("PlayerGui")
end

-- Clean up old instances
if targetGui:FindFirstChild(guiName) then
	targetGui[guiName]:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = guiName
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = targetGui

-- Main Container
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 260)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundTransparency = 1 -- Start transparent for fade in
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- UI Gradient (Dark to slightly lighter dark)
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 10, 15)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25))
}
UIGradient.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(5, 5, 20)
TopBar.BorderSizePixel = 0
TopBar.BackgroundTransparency = 1
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

-- Fix bottom corners of TopBar to be square so it connects to MainFrame
local TopBarExtension = Instance.new("Frame")
TopBarExtension.Size = UDim2.new(1, 0, 0, 10)
TopBarExtension.Position = UDim2.new(0, 0, 1, -10)
TopBarExtension.BackgroundColor3 = Color3.fromRGB(5, 5, 20)
TopBarExtension.BorderSizePixel = 0
TopBarExtension.BackgroundTransparency = 1
TopBarExtension.Parent = TopBar

-- Fixed Image Icon
local TitleIcon = Instance.new("ImageLabel")
TitleIcon.Size = UDim2.new(0, 20, 0, 20)
TitleIcon.Position = UDim2.new(0, 10, 0.5, -10)
TitleIcon.BackgroundTransparency = 1
TitleIcon.ImageTransparency = 1
TitleIcon.Image = "rbxassetid://122306902443641" -- Updated to your exact specific ID
TitleIcon.Parent = TopBar

local TopBarTitle = Instance.new("TextLabel")
TopBarTitle.Size = UDim2.new(0, 200, 1, 0)
TopBarTitle.Position = UDim2.new(0, 40, 0, 0)
TopBarTitle.BackgroundTransparency = 1
TopBarTitle.TextTransparency = 1
TopBarTitle.Text = "RealOptimum Luncher"
TopBarTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
TopBarTitle.Font = Enum.Font.Code
TopBarTitle.TextSize = 14
TopBarTitle.TextXAlignment = Enum.TextXAlignment.Left
TopBarTitle.Parent = TopBar

-- Window Buttons (Green, Blue, Red)
local function createWindowButton(color, posOffset)
	local btn = Instance.new("Frame")
	btn.Size = UDim2.new(0, 12, 0, 12)
	btn.Position = UDim2.new(1, posOffset, 0.5, -6)
	btn.BackgroundColor3 = color
	btn.BackgroundTransparency = 1
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = btn
	btn.Parent = TopBar
	return btn
end

local GreenBtn = createWindowButton(Color3.fromRGB(100, 180, 100), -80)
local BlueBtn = createWindowButton(Color3.fromRGB(80, 150, 220), -55)
local RedBtn = createWindowButton(Color3.fromRGB(200, 50, 50), -30)

-- Main Title
local MainTitle = Instance.new("TextLabel")
MainTitle.Name = "MainTitle"
MainTitle.Size = UDim2.new(1, -40, 0, 50)
MainTitle.Position = UDim2.new(0, 20, 0, 40)
MainTitle.BackgroundTransparency = 1
MainTitle.TextTransparency = 1
MainTitle.Text = "OPTIMUM-REAL"
MainTitle.TextColor3 = Color3.fromRGB(0, 120, 0)
MainTitle.Font = Enum.Font.SourceSansBold
MainTitle.TextSize = 36
MainTitle.TextXAlignment = Enum.TextXAlignment.Left
MainTitle.Parent = MainFrame

-- Console Container
local ConsoleFrame = Instance.new("Frame")
ConsoleFrame.Name = "ConsoleFrame"
ConsoleFrame.Size = UDim2.new(1, -40, 0, 100)
ConsoleFrame.Position = UDim2.new(0, 20, 0, 100)
ConsoleFrame.BackgroundTransparency = 1
ConsoleFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = ConsoleFrame

-- Watermark
local Watermark = Instance.new("TextLabel")
Watermark.Name = "Watermark"
Watermark.Size = UDim2.new(1, 0, 0, 30)
Watermark.Position = UDim2.new(0, 0, 1, -40)
Watermark.BackgroundTransparency = 1
Watermark.TextTransparency = 1
Watermark.Text = "UI Made By Fuddy"
Watermark.TextColor3 = Color3.fromRGB(40, 40, 40)
Watermark.Font = Enum.Font.FredokaOne
Watermark.TextSize = 28
Watermark.Parent = MainFrame

-- // Draggable Functionality \\ --
local dragging = false
local dragInput, mousePos, framePos

TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		mousePos = input.Position
		framePos = MainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

TopBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - mousePos
		MainFrame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
	end
end)

-- // Helper Functions \\ --

local function fadeElements(elements, transparency, duration)
	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	for _, element in pairs(elements) do
		local goal = {}
		if element:IsA("TextLabel") then
			goal.TextTransparency = transparency
		elseif element:IsA("ImageLabel") then
			goal.ImageTransparency = transparency
		elseif element:IsA("Frame") then
			goal.BackgroundTransparency = transparency
		end
		TweenService:Create(element, tweenInfo, goal):Play()
	end
	task.wait(duration)
end

local function createConsoleLine(order)
	local line = Instance.new("TextLabel")
	line.Size = UDim2.new(1, 0, 0, 20)
	line.BackgroundTransparency = 1
	line.Text = ""
	line.RichText = true
	line.TextColor3 = Color3.fromRGB(255, 255, 255)
	line.Font = Enum.Font.Code
	line.TextSize = 14
	line.TextXAlignment = Enum.TextXAlignment.Left
	line.LayoutOrder = order
	line.Parent = ConsoleFrame
	return line
end

-- // Boot Sequence Logic \\ --

local function startSequence()
	-- 1. Fade in UI
	fadeElements({MainFrame, TopBar, TopBarExtension, TitleIcon, TopBarTitle, GreenBtn, BlueBtn, RedBtn, Watermark}, 0, 0.5)
	task.wait(2)
	
	-- 2. Reveal OPTIMUM Main Title
	fadeElements({MainTitle}, 0, 0.5)
	task.wait(1)
	
	-- 3. Game Check Sequence
	local line1 = createConsoleLine(1)
	line1.Text = '[ GAME ] Checking...'
	task.wait(math.random(30, 40) / 10) -- Wait 3-4 seconds
	
	-- Fetch game name
	local gameName = "Unknown Game"
	pcall(function()
		local productInfo = MarketplaceService:GetProductInfo(game.PlaceId)
		gameName = productInfo.Name
	end)
	-- REPLACES the text entirely instead of keeping "Checking..."
	line1.Text = '[ GAME ] <font color="rgb(0,255,0)">'..gameName..'</font>'
	task.wait(1)
	
	-- 4. Status Check Sequence
	local line2 = createConsoleLine(2)
	line2.Text = '<font color="rgb(255,255,0)">[ STATUS ]</font> Checking...'
	task.wait(2)
	
	if SCRIPT_STATUS == "UP" then
		-- REPLACES the text entirely
		line2.Text = '<font color="rgb(255,255,0)">[ STATUS ]</font> <font color="rgb(0,255,0)">UP</font>'
		task.wait(1)
		
		-- 5. Boot / Execute Sequence
		local line3 = createConsoleLine(3)
		line3.Text = '<font color="rgb(0,255,0)">[ Boot ]</font> Executing Script...'
		task.wait(1.5)
		
		-- Hook/Webhook Services Check
		-- This checks if the executor lacks HTTP/Webhook request capabilities
		local executorLacksWebhook = (request == nil and http_request == nil and syn == nil)
		if SIMULATE_HOOK_ERROR or executorLacksWebhook then
			local line4 = createConsoleLine(4)
			line4.Text = '<font color="rgb(255,0,0)">HOOKSERVICES ERROR (NO WEBHOOK SUPPORT)</font>'
			task.wait(2.5)
			
			-- Unload UI
			fadeElements({MainFrame, TopBar, TopBarExtension, TitleIcon, TopBarTitle, GreenBtn, BlueBtn, RedBtn, Watermark, MainTitle, line1, line2, line3, line4}, 1, 0.5)
			ScreenGui:Destroy()
			return
		end
		
		-- Execute your payload exactly while it says "Executing Script..."
		task.spawn(PAYLOAD_SCRIPT)
		
		-- Wait a brief moment to simulate the execution process finishing
		task.wait(0.5)
		
		-- Replaces text with "Completed Successfully"
		line3.Text = '<font color="rgb(0,255,0)">[ Boot ]</font> Completed Successfully'
		task.wait(1.5)
		
		-- Unload UI smoothly (Fade out)
		fadeElements({MainFrame, TopBar, TopBarExtension, TitleIcon, TopBarTitle, GreenBtn, BlueBtn, RedBtn, Watermark, MainTitle, line1, line2, line3}, 1, 0.5)
		ScreenGui:Destroy()
		
	else
		-- Script is DOWN
		-- REPLACES the text entirely
		line2.Text = '<font color="rgb(255,255,0)">[ STATUS ]</font> <font color="rgb(255,0,0)">DOWN</font>'
		task.wait(1.5)
		LocalPlayer:Kick('🔴OPTIMUM SCRIPT IS DOWN🔴\n\nREASON: "SHUTDOWN BY OWNER - IN MAINTAINANCE"')
	end
end

-- Start the sequence
task.spawn(startSequence)
