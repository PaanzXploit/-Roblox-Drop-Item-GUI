-- Server Script (Tambahkan ke ServerScriptService)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvent = Instance.new("RemoteEvent")
RemoteEvent.Name = "BroadcastMessage"
RemoteEvent.Parent = ReplicatedStorage

RemoteEvent.OnServerEvent:Connect(function(player, message)
    if message and message ~= "" then
        for _, p in pairs(game.Players:GetPlayers()) do
            RemoteEvent:FireClient(p, player.Name .. ": " .. message)
        end
    end
end)

-- Local Script (Tambahkan ke StarterGui)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local RemoteEvent = ReplicatedStorage:WaitForChild("BroadcastMessage")

-- Membuat GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.3, 0, 0.15, 0)
Frame.Position = UDim2.new(0, 10, 1, -100)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Parent = ScreenGui

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0.8, 0, 0.5, 0)
TextBox.Position = UDim2.new(0.1, 0, 0.1, 0)
TextBox.PlaceholderText = "Masukkan pesan..."
TextBox.Parent = Frame

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0.8, 0, 0.3, 0)
Button.Position = UDim2.new(0.1, 0, 0.7, 0)
Button.Text = "Kirim"
Button.Parent = Frame

Button.MouseButton1Click:Connect(function()
    local message = TextBox.Text
    if message and message ~= "" then
        RemoteEvent:FireServer(message)
        TextBox.Text = ""
    end
end)

-- Terima pesan dari server dan tampilkan di chat
RemoteEvent.OnClientEvent:Connect(function(message)
    game.StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = message,
        Color = Color3.fromRGB(255, 255, 0),
        Font = Enum.Font.SourceSansBold,
        TextSize = 18,
    })
end)
