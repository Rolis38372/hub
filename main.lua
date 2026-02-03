-- Rolis Hub - All in One
-- Key: nikothebest
-- URL: https://raw.githubusercontent.com/Rolis38372/hub/refs/heads/main/main.lua

local KEY = "nikothebest"
local XenoFolder = "Xeno"
local KeyFile = "rolis_key.txt"

-- Создаем папку если нет
if not isfolder(XenoFolder) then
    makefolder(XenoFolder)
end

-- Функции сохранения/загрузки ключа
local function saveKey(key)
    writefile(XenoFolder .. "/" .. KeyFile, key)
end

local function loadKey()
    if isfile(XenoFolder .. "/" .. KeyFile) then
        return readfile(XenoFolder .. "/" .. KeyFile)
    end
    return nil
end

local savedKey = loadKey()

-- Загружаем Obsidian
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Window = Library:CreateWindow({
    Title = "Rolis Hub",
    Footer = "version: 1.0",
    Icon = 95816097006870,
    NotifySide = "Right",
})

-- Переменные для переключения между экранами
local KeyTab = nil
local MainTab = nil
local ESPTab = nil
local WorldTab = nil
local CharacterTab = nil
local SettingsTab = nil

-- Проверка ключа и создание интерфейса
local function createMainUI()
    -- Удаляем Key Tab если есть
    if KeyTab then
        KeyTab:SetVisible(false)
    end
    
    -- Создаем основные табы
    MainTab = Window:AddTab("Main", "user")
    ESPTab = Window:AddTab("ESP", "eye")
    WorldTab = Window:AddTab("World", "globe")
    CharacterTab = Window:AddTab("Character", "user")
    SettingsTab = Window:AddTab("Settings", "settings")
    
    --========== MAIN TAB ==========
    local MainLeft = MainTab:AddLeftGroupbox("Information", "info")
    local MainRight = MainTab:AddRightGroupbox("Quick Actions", "zap")
    
    MainLeft:AddLabel("Welcome to Rolis Hub!", true)
    MainLeft:AddLabel("Version: 1.0", true)
    MainLeft:AddLabel("Game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name, true)
    
    MainRight:AddButton("Rejoin Server", function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end)
    
    --========== ESP TAB ==========
    local ESP = {
        Enabled = false,
        Boxes = false,
        Names = false,
        Tracers = false,
        TeamCheck = true,
        MaxDistance = 1000,
        Color = Color3.new(1, 0, 0),
        Objects = {}
    }
    
    local ESPSettings = ESPTab:AddLeftGroupbox("ESP Settings", "eye")
    local ESPFilters = ESPTab:AddRightGroupbox("Filters", "filter")
    
    ESPSettings:AddToggle("ESPEnabled", {
        Text = "Enable ESP",
        Default = false,
        Callback = function(Value)
            ESP.Enabled = Value
            if not Value then ESP:Clear() end
        end
    }):AddColorPicker("ESPColor", {
        Default = Color3.new(1, 0, 0),
        Title = "ESP Color",
        Callback = function(Value)
            ESP.Color = Value
        end
    })
    
    ESPSettings:AddToggle("ESPBoxes", {
        Text = "Boxes",
        Default = false,
        Callback = function(Value) ESP.Boxes = Value end
    })
    
    ESPSettings:AddToggle("ESPNames", {
        Text = "Names",
        Default = false,
        Callback = function(Value) ESP.Names = Value end
    })
    
    ESPSettings:AddToggle("ESPTracers", {
        Text = "Tracers",
        Default = false,
        Callback = function(Value) ESP.Tracers = Value end
    })
    
    ESPFilters:AddToggle("ESPTeamCheck", {
        Text = "Team Check",
        Default = true,
        Callback = function(Value) ESP.TeamCheck = Value end
    })
    
    ESPFilters:AddSlider("ESPMaxDistance", {
        Text = "Max Distance",
        Default = 1000,
        Min = 100,
        Max = 5000,
        Rounding = 0,
        Callback = function(Value) ESP.MaxDistance = Value end
    })
    
    -- ESP Logic
    local Drawing = Drawing
    local Camera = workspace.CurrentCamera
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    function ESP:CreateDrawing(type, properties)
        local drawing = Drawing.new(type)
        for prop, val in pairs(properties) do
            drawing[prop] = val
        end
        return drawing
    end
    
    function ESP:CreateObject(player)
        return {
            Player = player,
            Box = self:CreateDrawing("Square", {Visible = false, Color = self.Color, Thickness = 1, Filled = false}),
            Name = self:CreateDrawing("Text", {Visible = false, Color = Color3.new(1,1,1), Size = 14, Center = true, Outline = true, OutlineColor = Color3.new(0,0,0)}),
            Tracer = self:CreateDrawing("Line", {Visible = false, Color = self.Color, Thickness = 1})
        }
    end
    
    function ESP:Update(obj)
        local player = obj.Player
        local char = player.Character
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
        
        if self.TeamCheck and player.Team == LocalPlayer.Team then
            obj.Box.Visible = false
            obj.Name.Visible = false
            obj.Tracer.Visible = false
            return
        end
        
        local pos = hrp.Position
        local dist = (Camera.CFrame.Position - pos).Magnitude
        if dist > self.MaxDistance then
            obj.Box.Visible = false
            obj.Name.Visible = false
            obj.Tracer.Visible = false
            return
        end
        
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
        
        if self.Boxes then
            obj.Box.Visible = true
            obj.Box.Color = self.Color
            obj.Box.Size = Vector2.new(boxWidth, boxHeight)
            obj.Box.Position = Vector2.new(screenPos.X - boxWidth/2, screenPos.Y - boxHeight/2)
        else
            obj.Box.Visible = false
        end
        
        if self.Names then
            obj.Name.Visible = true
            obj.Name.Text = player.Name .. " [" .. math.floor(dist) .. "m]"
            obj.Name.Position = Vector2.new(screenPos.X, screenPos.Y - boxHeight/2 - 15)
            obj.Name.Color = self.Color
        else
            obj.Name.Visible = false
        end
        
        if self.Tracers then
            obj.Tracer.Visible = true
            obj.Tracer.Color = self.Color
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
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            ESP.Objects[player] = ESP:CreateObject(player)
        end
    end
    
    Players.PlayerAdded:Connect(function(player)
        ESP.Objects[player] = ESP:CreateObject(player)
    end)
    
    Players.PlayerRemoving:Connect(function(player)
        if ESP.Objects[player] then
            ESP.Objects[player].Box:Remove()
            ESP.Objects[player].Name:Remove()
            ESP.Objects[player].Tracer:Remove()
            ESP.Objects[player] = nil
        end
    end)
    
    RunService.RenderStepped:Connect(function()
        if not ESP.Enabled then
            ESP:Clear()
            return
        end
        for _, obj in pairs(ESP.Objects) do
            ESP:Update(obj)
        end
    end)
    
    --========== WORLD TAB ==========
    local WorldLeft = WorldTab:AddLeftGroupbox("World", "globe")
    local WorldRight = WorldTab:AddRightGroupbox("Lighting", "sun")
    
    local FullBright = false
    WorldLeft:AddToggle("FullBright", {
        Text = "Full Bright",
        Default = false,
        Callback = function(Value)
            FullBright = Value
            if Value then
                game.Lighting.Brightness = 10
                game.Lighting.ClockTime = 14
                game.Lighting.FogEnd = 100000
            else
                game.Lighting.Brightness = 2
            end
        end
    })
    
    WorldLeft:AddToggle("NoFog", {
        Text = "No Fog",
        Default = false,
        Callback = function(Value)
            if Value then
                game.Lighting.FogEnd = 100000
            else
                game.Lighting.FogEnd = 1000
            end
        end
    })
    
    --========== CHARACTER TAB ==========
    local CharLeft = CharacterTab:AddLeftGroupbox("Movement", "move")
    local CharRight = CharacterTab:AddRightGroupbox("Mods", "zap")
    
    local WalkSpeed = 16
    local JumpPower = 50
    local SpeedHack = false
    
    CharLeft:AddSlider("WalkSpeed", {
        Text = "Walk Speed",
        Default = 16,
        Min = 16,
        Max = 200,
        Rounding = 0,
        Callback = function(Value)
            WalkSpeed = Value
        end
    })
    
    CharLeft:AddSlider("JumpPower", {
        Text = "Jump Power",
        Default = 50,
        Min = 50,
        Max = 200,
        Rounding = 0,
        Callback = function(Value)
            JumpPower = Value
        end
    })
    
    CharLeft:AddToggle("SpeedHack", {
        Text = "Speed Hack",
        Default = false,
        Callback = function(Value)
            SpeedHack = Value
        end
    })
    
    CharRight:AddToggle("Fly", {
        Text = "Fly (E)",
        Default = false
    }):AddKeyPicker("FlyKey", {
        Default = "E",
        Mode = "Toggle",
        Text = "Fly Key"
    })
    
    -- Character loop
    RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                if SpeedHack then
                    humanoid.WalkSpeed = WalkSpeed
                else
                    humanoid.WalkSpeed = 16
                end
                humanoid.JumpPower = JumpPower
            end
        end
    end)
    
    --========== SETTINGS TAB ==========
    local MenuGroup = SettingsTab:AddLeftGroupbox("Menu", "wrench")
    local ConfigGroup = SettingsTab:AddRightGroupbox("Config", "save")
    
    MenuGroup:AddButton("Unload", function()
        Library:Unload()
    end)
    
    MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {
        Default = "RightShift",
        NoUI = true,
        Text = "Menu keybind"
    })
    
    Library.ToggleKeybind = Library.Options.MenuKeybind
    
    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({"MenuKeybind"})
    ThemeManager:SetFolder("RolisHub")
    SaveManager:SetFolder("RolisHub/main")
    ThemeManager:ApplyToTab(SettingsTab)
    SaveManager:BuildConfigSection(SettingsTab)
    SaveManager:LoadAutoloadConfig()
    
    Library:Notify({
        Title = "Rolis Hub",
        Description = "Successfully loaded!",
        Time = 3
    })
end

-- Проверка ключа
if savedKey == KEY then
    -- Ключ сохранён и верен — грузим UI
    createMainUI()
else
    -- Нет ключа или неверный — показываем Key Tab
    KeyTab = Window:AddKeyTab("Key System", "key")
    
    KeyTab:AddLabel({
        Text = "Enter Key: nikothebest",
        DoesWrap = true,
        Size = 16
    })
    
    KeyTab:AddKeyBox(function(Success, ReceivedKey)
        if ReceivedKey == KEY then
            saveKey(ReceivedKey)
            Library:Notify({
                Title = "Success",
                Description = "Key accepted! Loading...",
                Time = 2
            })
            task.wait(0.5)
            createMainUI()
        else
            Library:Notify({
                Title = "Error",
                Description = "Invalid key: " .. ReceivedKey,
                Time = 3
            })
        end
    end)
end
