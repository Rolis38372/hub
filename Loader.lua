-- ОБФУСЦИРУЙ ЭТО ЧЕРЕЗ WEAREDEVS.NET
local KEY = "nikothebest"
local BASE_URL = "https://raw.githubusercontent.com/Rolis38372/hub/refs/heads/main/"
local MODULES_JSON = BASE_URL .. "modules.json"

local function get(url)
    return game:HttpGet(url, true)
end

local function loadModule(name)
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
    
    local success, result = pcall(fn)
    if not success then
        warn("[Loader] Failed to execute " .. name .. ": " .. tostring(result))
        return nil
    end
    
    return result
end

-- Проверка ключа (простая, обфусцируй весь файл)
local userKey = "nikothebest" -- Можешь заменить на Input вызов перед обфускацией
if userKey ~= KEY then
    game.Players.LocalPlayer:Kick("Invalid Key: " .. tostring(userKey))
    return
end

-- Грузим modules.json
local success, jsonData = pcall(get, MODULES_JSON)
if not success then
    error("[Loader] Failed to load modules.json: " .. tostring(jsonData))
end

-- Парсим JSON (простой)
local modules = {}
for name in jsonData:gmatch('"modules"%s*:%s*%[([^%]]+)%]') do
    for mod in name:gmatch('"([^"]+)"') do
        table.insert(modules, mod)
    end
end

if #modules == 0 then
    modules = {"main", "esp"}
end

-- Грузим main первым
local mainLoaded = false
for i, modName in ipairs(modules) do
    if modName == "main" then
        local result = loadModule(modName)
        if result then
            mainLoaded = true
            print("[Loader] Main loaded")
        else
            error("[Loader] Main failed to load")
        end
        table.remove(modules, i)
        break
    end
end

if not mainLoaded then
    error("[Loader] Main module not found in modules.json")
end

-- Ждем инициализации _G.RolisHub
local start = tick()
while tick() - start < 3 do
    if _G.RolisHub then break end
    task.wait(0.05)
end

if not _G.RolisHub then
    warn("[Loader] _G.RolisHub not initialized, continuing anyway...")
end

-- Грузим остальные модули
for _, modName in ipairs(modules) do
    loadModule(modName)
    task.wait(0.1)
end

print("[Loader] All modules loaded")
