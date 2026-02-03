-- ОБФУСЦИРУЙ ЭТО ЧЕРЕЗ WEAREDEVS.NET
-- Ключ вшит сюда, не трогай строку ниже при обфускации или обфусцируй вместе с ней
local KEY = "nikothebest"
local BASE_URL = "https://raw.githubusercontent.com/Rolis38372/hub/refs/heads/main/"
local MODULES_JSON = BASE_URL .. "modules.json"

local function get(url)
    return game:HttpGet(url, true)
end

local function loadModule(name, mainTable)
    local url = BASE_URL .. name .. ".lua"
    local success, code = pcall(get, url)
    if not success then
        warn("[Loader] Failed to load " .. name .. ": " .. tostring(code))
        return nil
    end
    
    local fn, err = loadstring(code, name)
    if not fn then
        warn("[Loader] Failed to parse " .. name .. ": " .. tostring(err))
        return nil
    end
    
    -- Передаем mainTable если есть
    if mainTable then
        setfenv(fn, setmetatable({Main = mainTable}, {__index = getfenv()}))
    end
    
    local success, result = pcall(fn)
    if not success then
        warn("[Loader] Failed to execute " .. name .. ": " .. tostring(result))
        return nil
    end
    
    return result
end

-- Проверка ключа (ввод через UI или вшитый - тут упрощенно для обфускации)
local userKey = "nikothebest" -- В реальности: InputBox или вшитый при генерации
if userKey ~= KEY then
    game.Players.LocalPlayer:Kick("Invalid Key")
    return
end

-- Грузим modules.json
local success, jsonData = pcall(get, MODULES_JSON)
if not success then
    error("[Loader] Failed to load modules.json: " .. tostring(jsonData))
end

-- Парсим JSON (простой вариант)
local modules = {}
for name in jsonData:gmatch('"modules"%s*:%s*%[([^%]]+)%]') do
    for mod in name:gmatch('"([^"]+)"') do
        table.insert(modules, mod)
    end
end

if #modules == 0 then
    -- Fallback если парсинг не сработал
    modules = {"main", "esp"}
end

local Main = nil

for i, modName in ipairs(modules) do
    if modName == "main" then
        Main = loadModule(modName)
        if not Main then error("[Loader] Main module failed to load") end
        _G.MainHub = Main
    else
        loadModule(modName, Main)
    end
    task.wait(0.1)
end

print("[Loader] All modules loaded successfully")
