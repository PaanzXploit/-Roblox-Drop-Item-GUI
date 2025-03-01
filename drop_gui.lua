-- Pastikan skrip ini dimasukkan dalam StarterGui sebagai LocalScript
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Buat RemoteEvent jika belum ada
if not ReplicatedStorage:FindFirstChild("DropItemEvent") then
    local DropItemEvent = Instance.new("RemoteEvent")
    DropItemEvent.Name = "DropItemEvent"
    DropItemEvent.Parent = ReplicatedStorage
end

local player = Players.LocalPlayer

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.3, 0, 0.2, 0)
Frame.Position = UDim2.new(0.35, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Parent = ScreenGui

local DropButton = Instance.new("TextButton")
DropButton.Size = UDim2.new(1, 0, 1, 0)
DropButton.Text = "Drop Held Item"
DropButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
DropButton.Parent = Frame

-- Fungsi untuk drop item yang sedang dipegang
DropButton.MouseButton1Click:Connect(function()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            local heldItem = humanoid:FindFirstChildOfClass("Tool")
            if heldItem then
                ReplicatedStorage.DropItemEvent:FireServer(heldItem.Name)
            end
        end
    end
end)

-- Fungsi untuk toggle (minimize/maximize) GUI saat menekan tombol "Q"
local UserInputService = game:GetService("UserInputService")
local isMinimized = false

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Q then
        isMinimized = not isMinimized
        Frame.Visible = not isMinimized
    end
end)
