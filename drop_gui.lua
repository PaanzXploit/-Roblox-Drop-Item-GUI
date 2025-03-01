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
local backpack = player:FindFirstChild("Backpack")

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.3, 0, 0.4, 0)
Frame.Position = UDim2.new(0.35, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Parent = ScreenGui

local ItemList = Instance.new("ScrollingFrame")
ItemList.Size = UDim2.new(1, 0, 0.8, 0)
ItemList.Parent = Frame

local DropButton = Instance.new("TextButton")
DropButton.Size = UDim2.new(1, 0, 0.2, 0)
DropButton.Position = UDim2.new(0, 0, 0.8, 0)
DropButton.Text = "Drop Item"
DropButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
DropButton.Parent = Frame

local selectedItem = nil

-- Fungsi untuk memperbarui daftar item
local function UpdateItemList()
    for _, child in pairs(ItemList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            local ItemButton = Instance.new("TextButton")
            ItemButton.Size = UDim2.new(1, 0, 0.1, 0)
            ItemButton.Text = tool.Name
            ItemButton.Parent = ItemList
            
            ItemButton.MouseButton1Click:Connect(function()
                selectedItem = tool.Name
            end)
        end
    end
end

UpdateItemList()

DropButton.MouseButton1Click:Connect(function()
    if selectedItem then
        ReplicatedStorage.DropItemEvent:FireServer(selectedItem)
        selectedItem = nil
        UpdateItemList()
    end
end)
