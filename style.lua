local lookingforStyle = "Kunigami"
local rollSlot = "Slot2"
local rollLuckySpin = false

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local plr = Players.LocalPlayer

repeat wait() until game:IsLoaded() and game:FindFirstChild("CoreGui") and pcall(function() return game.CoreGui end)

spawn(function()
repeat wait() until game.CoreGui:FindFirstChild("RobloxPromptGui") and game.CoreGui.RobloxPromptGui:FindFirstChild("promptOverlay")
while wait(2) do
    local prompt = game.CoreGui.RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt")
    if prompt then
        local msg = prompt.MessageArea.ErrorFrame.ErrorMessage.Text
        if not msg:find("Error Code: 268") then
            if msg:find("There has been a data issue") then
                prompt.MessageArea.ErrorFrame.ErrorMessage.Text = "Script will rejoin in 10 seconds"
                wait(10)
            end
            TeleportService:Teleport(game.PlaceId, plr)
            wait(10)
        end
    end
end
end)
local Data
repeat wait() Data = ReplicatedStorage.Data:InvokeServer() until Data and Data.Spins and Data.LuckySpins

local spinAmount = rollLuckySpin and Data.LuckySpins or Data.Spins
if spinAmount == 0 then return print("out of spin") end

ReplicatedStorage.Loaded:FireServer()
wait(1)
if plr.PlayerStats.Style.Value == lookingforStyle then return print("matched") end

ReplicatedStorage.Packages.Knit.Services.StyleService.RE.Slot:FireServer(rollSlot)
wait(1)
print("Freezing data")
ReplicatedStorage.Packages.Knit.Services.CustomizationService.RE.Customize:FireServer("Emotes", "Default\255", "1")
wait(2)
ReplicatedStorage.Packages.Knit.Services.StyleService.RF.SetTargetRollStyle:InvokeServer(lookingforStyle)

for i = 1, spinAmount do
	ReplicatedStorage.Packages.Knit.Services.StyleService.RE.Spin:FireServer(rollLuckySpin)
	wait(1)
	local currentStyle = plr.PlayerStats.Style.Value
	print("Rolled: " .. currentStyle)
	if currentStyle == lookingforStyle then break end
end

local finalStyle = plr.PlayerStats.Style.Value
if finalStyle == lookingforStyle then
	print("Style matched (" .. finalStyle .. "), saving data")
	ReplicatedStorage.Packages.Knit.Services.CustomizationService.RE.Customize:FireServer("Emotes", "Default", "1")
else
	print("rejoining")
end
TeleportService:Teleport(game.PlaceId, plr)
