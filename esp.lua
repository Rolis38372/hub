-- Получаем Main из глобала
local Main = _G.RolisHub
if not Main then
    warn("[ESP] _G.RolisHub not found, waiting...")
    
    -- Ждем пока загрузится main
    local start = tick()
    while tick() - start < 5 do
        Main = _G.RolisHub
        if Main then break end
        task.wait(0.1)
    end
    
    if not Main then
        warn("[ESP] Failed to get Main after 5 seconds")
        return
    end
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
    MaxDistance = 1000,
    Objects = {}
}

-- Drawing API
local Drawing = Drawing or {}
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Создаем тоглы в UI
Main.Groupboxes.ESPLeft:AddToggle("ESPEnabled", {
    Text = "Enable ESP",
    Default = false,
    Callback = function(Value)
        ESP.Enabled = Value
        if not Value then
            ESP:Clear()
        end
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

-- Функции ESP
function ESP:CreateDrawing(type, properties)
    local drawing = Drawing.new(type)
    for prop, val in pairs(properties) do
        drawing[prop] = val
    end
    return drawing
end

function ESP:GetCharacter(player)
    return player.Character
end

function ESP:IsTeammate(player)
    if not ESP.TeamCheck then return false end
    return player.Team == LocalPlayer.Team
end

function ESP:GetDistance(pos)
    return (Camera.CFrame.Position - pos).Magnitude
end

function ESP:CreatePlayerObject(player)
    local obj = {
        Player = player,
        Box = self:CreateDrawing("Square", {
            Visible = false,
            Color = Options.ESPColor and Options.ESPColor.Value or Color3.new(1, 0, 0),
            Thickness = 1,
            Filled = false,
            Transparency = 1
        }),
        Name = self:CreateDrawing("Text", {
            Visible = false,
            Color = Color3.new(1, 1, 1),
            Size = 14,
            Center = true,
            Outline = true,
            OutlineColor = Color3.new(0, 0, 0),
            Text = player.Name
        }),
        Tracer = self:CreateDrawing("Line", {
            Visible = false,
            Color = Options.ESPColor and Options.ESPColor.Value or Color3.new(1, 0, 0),
            Thickness = 1
        })
    }
    return obj
end

function ESP:UpdatePlayer(obj)
    local player = obj.Player
    local char = self:GetCharacter(player)
    
    if not char then
        obj.Box.Visible = false
        obj.Name.Visible = false
        obj.Tracer.Visible = false
        return
    end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local head = char:FindFirstChild("Head")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    
    if not hrp or not head or not humanoid or humanoid.Health <= 0 then
        obj.Box.Visible = false
        obj.Name.Visible = false
        obj.Tracer.Visible = false
        return
    end
    
    local pos = hrp.Position
    local dist = self:GetDistance(pos)
    
    if dist > self.MaxDistance then
        obj.Box.Visible = false
        obj.Name.Visible = false
        obj.Tracer.Visible = false
        return
    end
    
    -- Проекция на экран
    local screenPos, onScreen = Camera:WorldToViewportPoint(pos)
    if not onScreen then
        obj.Box.Visible = false
        obj.Name.Visible = false
        obj.Tracer.Visible = false
        return
    end
    
    local headPos = Camera:WorldToViewportPoint(head.Position)
    local legPos = Camera:WorldToViewportPoint(pos - Vector3.new(0, 3, 0))
    
    local boxHeight = math.abs(headPos.Y - legPos.Y)
    local boxWidth = boxHeight * 0.6
    
    local color = Options.ESPColor and Options.ESPColor.Value or Color3.new(1, 0, 0)
    
    -- Box
    if self.Boxes then
        obj.Box.Visible = true
        obj.Box.Color = color
        obj.Box.Size = Vector2.new(boxWidth, boxHeight)
        obj.Box.Position = Vector2.new(screenPos.X - boxWidth/2, screenPos.Y - boxHeight/2)
    else
        obj.Box.Visible = false
    end
    
    -- Name
    if self.Names then
        obj.Name.Visible = true
        obj.Name.Text = player.Name .. " [" .. math.floor(dist) .. "m]"
        obj.Name.Position = Vector2.new(screenPos.X, screenPos.Y - boxHeight/2 - 15)
        obj.Name.Color = color
    else
        obj.Name.Visible = false
    end
    
    -- Tracer
    if self.Tracers then
        obj.Tracer.Visible = true
        obj.Tracer.Color = color
        obj.Tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
        obj.Tracer.To = Vector2.new(screenPos.X, screenPos.Y + boxHeight/2)
    else
        obj.Tracer.Visible = false
    end
end

function ESP:Clear()
    for _, obj in pairs(self.Objects) do
        obj.Box.Visible = false
        obj.Name.Visible = false
        obj.Tracer.Visible = false
    end
end

function ESP:RemovePlayer(player)
    if self.Objects[player] then
        self.Objects[player].Box:Remove()
        self.Objects[player].Name:Remove()
        self.Objects[player].Tracer:Remove()
        self.Objects[player] = nil
    end
end

-- Инициализация
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        ESP.Objects[player] = ESP:CreatePlayerObject(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    ESP.Objects[player] = ESP:CreatePlayerObject(player)
end)

Players.PlayerRemoving:Connect(function(player)
    ESP:RemovePlayer(player)
end)

-- Рендер
RunService.RenderStepped:Connect(function()
    if not ESP.Enabled then
        ESP:Clear()
        return
    end
    
    for player, obj in pairs(ESP.Objects) do
        if ESP:IsTeammate(player) then
            obj.Box.Visible = false
            obj.Name.Visible = false
            obj.Tracer.Visible = false
        else
            ESP:UpdatePlayer(obj)
        end
    end
end)

print("[ESP] Module loaded successfully")
