-- Получаем Main из окружения (устанавливает Loader)
local Main = Main or _G.MainHub
if not Main then
    warn("[ESP] Main not found")
    return
end

local Library = Main.Library
local Toggles = Main.Toggles
local Options = Main.Options

-- ESP Логика
local ESP = {
    Enabled = false,
    Players = true,
    Boxes = false,
    Names = false,
    Tracers = false,
    TeamCheck = true,
    MaxDistance = 1000
}

-- Создаем тоглы в UI
Main.Groupboxes.ESPLeft:AddToggle("ESPEnabled", {
    Text = "Enable ESP",
    Default = false,
    Callback = function(Value)
        ESP.Enabled = Value
    end
}):AddColorPicker("ESPColor", {
    Default = Color3.new(1, 0, 0),
    Title = "ESP Color"
})

Main.Groupboxes.ESPLeft:AddToggle("ESPBoxes", {
    Text = "Boxes",
    Default = false,
    Callback = function(Value)
        ESP.Boxes = Value
    end
})

Main.Groupboxes.ESPLeft:AddToggle("ESPNames", {
    Text = "Names",
    Default = false,
    Callback = function(Value)
        ESP.Names = Value
    end
})

Main.Groupboxes.ESPLeft:AddToggle("ESPTracers", {
    Text = "Tracers",
    Default = false,
    Callback = function(Value)
        ESP.Tracers = Value
    end
})

Main.Groupboxes.ESPRight:AddToggle("ESPTeamCheck", {
    Text = "Team Check",
    Default = true,
    Callback = function(Value)
        ESP.TeamCheck = Value
    end
})

Main.Groupboxes.ESPRight:AddSlider("ESPMaxDistance", {
    Text = "Max Distance",
    Default = 1000,
    Min = 100,
    Max = 5000,
    Rounding = 0,
    Callback = function(Value)
        ESP.MaxDistance = Value
    end
})

-- Здесь будет сам ESP рендер (добавишь свою логику)
local RunService = game:GetService("RunService")

local function getCharacter(player)
    return player.Character
end

local function isTeammate(player)
    return player.Team == game.Players.LocalPlayer.Team
end

local function drawESP()
    if not ESP.Enabled then return end
    
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player == game.Players.LocalPlayer then continue end
        if ESP.TeamCheck and isTeammate(player) then continue end
        
        local char = getCharacter(player)
        if not char then continue end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        
        -- Твоя логика рисования здесь
        -- Используй Drawing API или BillboardGui
    end
end

RunService.RenderStepped:Connect(drawESP)

print("[ESP] Module loaded")
