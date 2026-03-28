--// Pro Fly GUI (Neon Theme)

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

local flying = false
local speed = 50

-- สีธีม
local mainColor = Color3.fromRGB(15,15,15)
local neonBlue = Color3.fromRGB(0,170,255)

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)

-- ปุ่มเปิด GUI
local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0,110,0,40)
openBtn.Position = UDim2.new(0,20,0,150)
openBtn.Text = "OPEN"
openBtn.BackgroundColor3 = neonBlue
openBtn.TextColor3 = Color3.new(1,1,1)
openBtn.Visible = false

-- Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,220,0,180)
frame.Position = UDim2.new(0,20,0,200)
frame.BackgroundColor3 = mainColor
frame.Active = true
frame.Draggable = true

-- มุมโค้ง
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

-- ขอบเรืองแสง
local stroke = Instance.new("UIStroke", frame)
stroke.Color = neonBlue
stroke.Thickness = 2

-- ปุ่มปิด
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,0,5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(255,60,60)
close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", close)

-- Toggle
local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(1,-20,0,40)
toggle.Position = UDim2.new(0,10,0,40)
toggle.Text = "Fly: OFF"
toggle.BackgroundColor3 = neonBlue
toggle.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", toggle)

-- Speed +
local speedUp = Instance.new("TextButton", frame)
speedUp.Position = UDim2.new(0,10,0,90)
speedUp.Size = UDim2.new(1,-20,0,30)
speedUp.Text = "Speed +"
speedUp.BackgroundColor3 = Color3.fromRGB(40,40,40)
speedUp.TextColor3 = neonBlue
Instance.new("UICorner", speedUp)

-- Speed -
local speedDown = Instance.new("TextButton", frame)
speedDown.Position = UDim2.new(0,10,0,125)
speedDown.Size = UDim2.new(1,-20,0,30)
speedDown.Text = "Speed -"
speedDown.BackgroundColor3 = Color3.fromRGB(40,40,40)
speedDown.TextColor3 = neonBlue
Instance.new("UICorner", speedDown)

-- Label
local label = Instance.new("TextLabel", frame)
label.Position = UDim2.new(0,10,0,155)
label.Size = UDim2.new(1,-20,0,20)
label.Text = "Speed: "..speed
label.TextColor3 = neonBlue
label.BackgroundTransparency = 1

-- Fly
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(1e5,1e5,1e5)

-- ปิด GUI
close.MouseButton1Click:Connect(function()
    frame.Visible = false
    openBtn.Visible = true
end)

-- เปิด GUI
openBtn.MouseButton1Click:Connect(function()
    frame.Visible = true
    openBtn.Visible = false
end)

-- Toggle Fly
toggle.MouseButton1Click:Connect(function()
    flying = not flying
    toggle.Text = flying and "Fly: ON" or "Fly: OFF"
end)

-- Speed
speedUp.MouseButton1Click:Connect(function()
    speed = speed + 10
    label.Text = "Speed: "..speed
end)

speedDown.MouseButton1Click:Connect(function()
    speed = math.max(10, speed - 10)
    label.Text = "Speed: "..speed
end)

-- Fly System
game:GetService("RunService").RenderStepped:Connect(function()
    if flying then
        bv.Parent = root
        local cam = workspace.CurrentCamera
        bv.Velocity = cam.CFrame.LookVector * speed
    else
        bv.Parent = nil
    end
end)
