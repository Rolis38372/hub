-- Создает UI и возвращает таблицу с Library и Window
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Window = Library:CreateWindow({
    Title = "Rolis Hub",
    Footer = "version: beta",
    Icon = 95816097006870,
    NotifySide = "Right",
})

local MainTab = Window:AddTab("Main", "user")
local ESPTab = Window:AddTab("ESP", "eye")
local SettingsTab = Window:AddTab("Settings", "settings")

-- Группы для ESP модуля
local ESPLeft = ESPTab:AddLeftGroupbox("ESP Settings", "eye")
local ESPRight = ESPTab:AddRightGroupbox("ESP Filters", "filter")

-- UI Settings
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({"MenuKeybind"})

ThemeManager:SetFolder("RolisHub")
SaveManager:SetFolder("RolisHub/main")

ThemeManager:ApplyToTab(SettingsTab)
SaveManager:BuildConfigSection(SettingsTab)

SaveManager:LoadAutoloadConfig()

-- Возвращаем таблицу для других модулей
return {
    Library = Library,
    Window = Window,
    Tabs = {
        Main = MainTab,
        ESP = ESPTab,
        Settings = SettingsTab
    },
    Groupboxes = {
        ESPLeft = ESPLeft,
        ESPRight = ESPRight
    },
    Options = Library.Options,
    Toggles = Library.Toggles
}
