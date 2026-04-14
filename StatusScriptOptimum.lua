-- // Configuration (Change these to test different outcomes) \\ --
local SCRIPT_STATUS = "UP" -- Change to "DOWN" to test the kick sequence
local SIMULATE_HOOK_ERROR = false -- Change to true to force test the hook services error

local PAYLOAD_SCRIPT = function()
	-- // ======================================================================= \\ --
	-- //                      ⬇️ YOUR AUTO-EXECUTE SCRIPT ⬇️                      \\ --
	-- // ======================================================================= \\ --
	
	-- This executes exactly when the UI says "Executing Script..."
	loadstring(game:HttpGet("https://raw.githubusercontent.com/FuddyOG/KeyScriptOptimumReal/refs/heads/main/KeyScriptOptimum.lua"))()
	
	-- // ======================================================================= \\ --
	-- //                      ⬆️ YOUR AUTO-EXECUTE SCRIPT ⬆️                      \\ --
	-- // ======================================================================= \\ --
end
-- // ==================================================== \\ --

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local Lighting = game:GetService("Lighting")
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
TitleIcon.Image = "rbxassetid://88212715268907" 
TitleIcon.Parent = TopBar

local TopBarTitle = Instance.new("TextLabel")
TopBarTitle.Size = UDim2.new(0, 200, 1, 0)
TopBarTitle.Position = UDim2.new(0, 40, 0, 0)
TopBarTitle.BackgroundTransparency = 1
TopBarTitle.TextTransparency = 1
TopBarTitle.Text = "RealOptimum Luncher|OUR DISCORD (discord.gg/yv9GpfEzkC)"
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

-- UI Overlay for YES/NO Focus
local UIDimOverlay = Instance.new("Frame")
UIDimOverlay.Name = "UIDimOverlay"
UIDimOverlay.Size = UDim2.new(1, 0, 1, 0)
UIDimOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
UIDimOverlay.BackgroundTransparency = 1
UIDimOverlay.ZIndex = 8
UIDimOverlay.Parent = MainFrame
local OverlayCorner = Instance.new("UICorner")
OverlayCorner.CornerRadius = UDim.new(0, 8)
OverlayCorner.Parent = UIDimOverlay

-- // YES / NO Prompt UI Creation \\ --
local PromptFrame = Instance.new("Frame")
PromptFrame.Name = "PromptFrame"
PromptFrame.Size = UDim2.new(0, 300, 0, 130)
PromptFrame.Position = UDim2.new(0.5, -150, 0.5, -65) 
PromptFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
PromptFrame.ZIndex = 10
PromptFrame.Visible = false
PromptFrame.Parent = ScreenGui

local PromptCorner = Instance.new("UICorner")
PromptCorner.CornerRadius = UDim.new(0, 10)
PromptCorner.Parent = PromptFrame

local PromptStroke = Instance.new("UIStroke")
PromptStroke.Color = Color3.fromRGB(50, 50, 60)
PromptStroke.Thickness = 2
PromptStroke.Parent = PromptFrame

local PromptText = Instance.new("TextLabel")
PromptText.Size = UDim2.new(1, -20, 0, 50)
PromptText.Position = UDim2.new(0, 10, 0, 15)
PromptText.BackgroundTransparency = 1
PromptText.Text = "Did you want to execute this script?"
PromptText.TextColor3 = Color3.fromRGB(255, 255, 255)
PromptText.Font = Enum.Font.GothamMedium
PromptText.TextSize = 17
PromptText.TextWrapped = true
PromptText.ZIndex = 11
PromptText.Parent = PromptFrame

local YesBtn = Instance.new("TextButton")
YesBtn.Size = UDim2.new(0, 90, 0, 35)
YesBtn.Position = UDim2.new(0, 40, 0, 75)
YesBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
YesBtn.Text = "YES"
YesBtn.TextColor3 = Color3.fromRGB(0, 255, 0)
YesBtn.Font = Enum.Font.GothamBold
YesBtn.TextSize = 18
YesBtn.ZIndex = 11
YesBtn.Parent = PromptFrame

local YesCorner = Instance.new("UICorner")
YesCorner.CornerRadius = UDim.new(0, 6)
YesCorner.Parent = YesBtn

local YesStroke = Instance.new("UIStroke")
YesStroke.Color = Color3.fromRGB(0, 200, 0)
YesStroke.Thickness = 1
YesStroke.Parent = YesBtn

local NoBtn = Instance.new("TextButton")
NoBtn.Size = UDim2.new(0, 90, 0, 35)
NoBtn.Position = UDim2.new(1, -130, 0, 75)
NoBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
NoBtn.Text = "NO"
NoBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
NoBtn.Font = Enum.Font.GothamBold
NoBtn.TextSize = 18
NoBtn.ZIndex = 11
NoBtn.Parent = PromptFrame

local NoCorner = Instance.new("UICorner")
NoCorner.CornerRadius = UDim.new(0, 6)
NoCorner.Parent = NoBtn

local NoStroke = Instance.new("UIStroke")
NoStroke.Color = Color3.fromRGB(200, 0, 0)
NoStroke.Thickness = 1
NoStroke.Parent = NoBtn

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
		if element:IsA("TextLabel") or element:IsA("TextButton") then
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
	line.ZIndex = 5
	line.Parent = ConsoleFrame
	return line
end

-- Asynchronous dot animation function
local function animateCheckingDots(textLabel, prefix)
	local isAnimating = true
	
	task.spawn(function()
		local dots = 0
		while isAnimating do
			-- Failsafe to prevent errors if the UI is destroyed mid-animation
			if not textLabel or not textLabel.Parent then
				isAnimating = false
				break
			end
			
			dots = (dots % 3) + 1
			textLabel.Text = prefix .. "Checking" .. string.rep(".", dots)
			task.wait(0.33) -- Speed of the dots
		end
	end)
	
	-- Return a function that we can call to stop the animation loop
	return function()
		isAnimating = false
	end
end

-- Blur Control (World Blur + UI Darkening)
local currentBlur = nil
local function toggleBlur(state)
	if state then
		if not currentBlur then
			currentBlur = Instance.new("BlurEffect")
			currentBlur.Size = 0
			currentBlur.Parent = Lighting
			TweenService:Create(currentBlur, TweenInfo.new(0.3), {Size = 15}):Play()
		end
		-- Darken the main UI to put focus entirely on YES/NO prompt
		TweenService:Create(UIDimOverlay, TweenInfo.new(0.3), {BackgroundTransparency = 0.4}):Play()
	else
		if currentBlur then
			local blurOut = TweenService:Create(currentBlur, TweenInfo.new(0.3), {Size = 0})
			blurOut:Play()
			blurOut.Completed:Connect(function()
				if currentBlur then
					currentBlur:Destroy()
					currentBlur = nil
				end
			end)
		end
		TweenService:Create(UIDimOverlay, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
	end
end


-- // Boot Sequence Logic \\ --

local function startSequence()
	-- 1. Fade in UI
	fadeElements({MainFrame, TopBar, TopBarExtension, TitleIcon, TopBarTitle, GreenBtn, BlueBtn, RedBtn, Watermark}, 0, 0.5)
	task.wait(1)
	
	-- 2. Reveal OPTIMUM Main Title
	fadeElements({MainTitle}, 0, 0.5)
	task.wait(1)
	
	-- 3. Executor Check Sequence (NEW)
	local line1 = createConsoleLine(1)
	local stopExecutorCheckAnim = animateCheckingDots(line1, '<font color="rgb(200,100,255)">[ Executor ]</font> ')
	task.wait(math.random(10, 20) / 10) 
	
	local execName = "Unknown Executor"
	pcall(function()
		-- identifyexecutor is the modern standard for identifying the client (Delta, Xeno, etc.)
		if type(identifyexecutor) == "function" then
			local name, version = identifyexecutor()
			if name then
				execName = tostring(name)
			end
		end
	end)
	
	stopExecutorCheckAnim()
	line1.Text = '<font color="rgb(200,100,255)">[ Executor ]</font> <font color="rgb(0,255,0)">'..execName..'</font>'
	task.wait(1)
	
	-- 4. Game Check Sequence
	local line2 = createConsoleLine(2)
	local stopGameCheckAnim = animateCheckingDots(line2, '<font color="rgb(255,255,255)">[ GAME ]</font> ')
	task.wait(math.random(15, 25) / 10) 
	
	local gameName = "Unknown Game"
	pcall(function()
		local productInfo = MarketplaceService:GetProductInfo(game.PlaceId)
		gameName = productInfo.Name
	end)
	
	stopGameCheckAnim()
	line2.Text = '<font color="rgb(255,255,255)">[ GAME ]</font> <font color="rgb(0,255,0)">'..gameName..'</font>'
	task.wait(1)
	
	-- 5. Status Check Sequence
	local line3 = createConsoleLine(3)
	local stopStatusCheckAnim = animateCheckingDots(line3, '<font color="rgb(255,255,0)">[ STATUS ]</font> ')
	task.wait(1.5)
	
	stopStatusCheckAnim()
	
	if SCRIPT_STATUS == "UP" then
		line3.Text = '<font color="rgb(255,255,0)">[ STATUS ]</font> <font color="rgb(0,255,0)">UP</font>'
		task.wait(1)
		
		-- 6. Prompt YES/NO Sequence
		local lineCheckUp = createConsoleLine(4)
		lineCheckUp.Text = '<font color="rgb(0,255,255)">[ CheckUP ]</font> Waiting For Answer'
		
		-- Trigger visual beautification and wait for user
		toggleBlur(true)
		PromptFrame.Visible = true
		
		local userChoice = nil
		local connYes = YesBtn.MouseButton1Click:Connect(function() userChoice = "YES" end)
		local connNo = NoBtn.MouseButton1Click:Connect(function() userChoice = "NO" end)
		
		-- Yield/Wait until the user makes a choice
		repeat task.wait() until userChoice ~= nil
		
		-- Cleanup connections and remove blur/UI focus
		connYes:Disconnect()
		connNo:Disconnect()
		toggleBlur(false)
		PromptFrame:Destroy()
		
		-- Handle Choice
		if userChoice == "NO" then
			lineCheckUp.Text = '<font color="rgb(0,255,255)">[ CheckUP ]</font> <font color="rgb(255,0,0)">NO</font>'
			
			local lineNo = createConsoleLine(5)
			lineNo.Text = '<font color="rgb(255,0,0)">[ Boot ]</font> Unloading UI'
			task.wait(1) 
			
			ScreenGui:Destroy()
			return
		end
		
		-- If YES, continue smoothly:
		lineCheckUp.Text = '<font color="rgb(0,255,255)">[ CheckUP ]</font> <font color="rgb(0,255,0)">YES</font>'
		
		local line4 = createConsoleLine(5)
		line4.Text = '<font color="rgb(0,255,0)">[ Boot ]</font> Executing Script'
		task.wait(1.5)
		
		local executorLacksWebhook = (request == nil and http_request == nil and syn == nil)
		if SIMULATE_HOOK_ERROR or executorLacksWebhook then
			local line5 = createConsoleLine(6)
			line5.Text = '<font color="rgb(255,0,0)">HOOKSERVICES ERROR (YOUR EXECUTER DOES NOT HAVE A WEBHOOK SUPPORT)</font>'
			task.wait(2.5)
			
			fadeElements({MainFrame, TopBar, TopBarExtension, TitleIcon, TopBarTitle, GreenBtn, BlueBtn, RedBtn, Watermark, MainTitle, line1, line2, line3, lineCheckUp, line4, line5}, 1, 0.5)
			ScreenGui:Destroy()
			return
		end
		
		task.spawn(PAYLOAD_SCRIPT)
		task.wait(0.3)
		
		line4.Text = '<font color="rgb(0,255,0)">[ Boot ]</font> Completed Successfully'
		task.wait(1.5)
		
		fadeElements({MainFrame, TopBar, TopBarExtension, TitleIcon, TopBarTitle, GreenBtn, BlueBtn, RedBtn, Watermark, MainTitle, line1, line2, line3, lineCheckUp, line4}, 1, 0.5)
		ScreenGui:Destroy()
		
	else
		-- Script is DOWN
		line3.Text = '<font color="rgb(255,255,0)">[ STATUS ]</font> <font color="rgb(255,0,0)">DOWN</font>'
		task.wait(1.5)
		
		LocalPlayer:Kick('[🔴 OPTIMUM SCRIPT IS DOWN 🔴] - REASON: SHUTDOWN BY OWNER / IN MAINTENANCE')
	end
end

-- Start the sequence
task.spawn(startSequence)
