========== ReplicatedStorage.Modules.Client.TradeController ==========

local v_u_1 = {}
local v_u_2 = game:GetService("Players").LocalPlayer
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = v_u_2:WaitForChild("TradingID")
local v6 = v3:WaitForChild("Events"):WaitForChild("TradeEvents")
local v_u_7 = v6:WaitForChild("SendTrade")
v6:WaitForChild("OpenTrade")
local v_u_8 = v6:WaitForChild("CancelTrade")
v3:WaitForChild("TradesOpened")
local v_u_9 = v_u_2:WaitForChild("PlayerGui"):WaitForChild("TradeUI")
local v_u_10 = TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
function v_u_1.Init(p_u_11)
-- upvalues: (copy) v_u_9, (copy) v_u_4, (copy) v_u_10, (copy) v_u_1, (copy) v_u_2, (copy) v_u_5, (copy) v_u_7, (copy) v_u_8
local v_u_12 = p_u_11.TradeShared
function v_u_1.OpenFrame(, p13)
-- upvalues: (ref) v_u_9, (ref) v_u_4, (ref) v_u_10
local v14 = v_u_9:FindFirstChild(p13)
if v14 and v14.Visible == false then
local v15 = v14:WaitForChild("UIScale")
v15.Scale = 0
v14.Visible = true
v_u_4:Create(v15, v_u_10, {
["Scale"] = 1
}):Play()
end
end
function v_u_1.CloseFrame(, p16)
-- upvalues: (ref) v_u_9, (ref) v_u_4, (ref) v_u_10
local v17 = v_u_9:FindFirstChild(p16)
if v17 and v17.Visible == true then
v_u_4:Create(v17:WaitForChild("UIScale"), v_u_10, {
["Scale"] = 0
}):Play()
task.wait(v_u_10.Time)
v17.Visible = false
end
end
function v_u_1.ReceiveTrade(, p18)
-- upvalues: (ref) v_u_2, (ref) v_u_5, (copy) p_u_11
if p18 and (p18.Name ~= v_u_2.Name and v_u_5.Value == "") then
p_u_11.ReceiveTradeUI:Update(p18)
end
end
function v_u_1.OpenTrade()
-- upvalues: (copy) v_u_12, (ref) v_u_2, (ref) v_u_5, (copy) p_u_11, (ref) v_u_1
local v19 = v_u_12:GetFolder(v_u_2)
if v19 and v19.Name == v_u_5.Value then
p_u_11.UIController:CloseFrame("TradeRequestFrame")
v_u_1:CloseFrame("ReceiveTrade")
p_u_11.TradingUI:OpenTrade()
end
end
v_u_7.OnClientEvent:Connect(function(p20)
-- upvalues: (ref) v_u_1
if p20 then
v_u_1:ReceiveTrade(p20)
end
end)
v_u_8.OnClientEvent:Connect(function()
-- upvalues: (copy) p_u_11
p_u_11.TradeController:CloseFrame("TradeFrame")
p_u_11.NotificationsUI:CreateText("Red", "Trade Cancelled!")
end)
end
function v_u_1.Start(_)
-- upvalues: (copy) v_u_5, (copy) v_u_1
v_u_5.Changed:Connect(function()
-- upvalues: (ref) v_u_1
v_u_1:OpenTrade()
end)
end
return v_u_1

========== ReplicatedStorage.Modules.Shared.TradeShared ==========

local v_u_1 = {}
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("ReplicatedStorage"):WaitForChild("TradesOpened")
function v_u_1.Init()
-- upvalues: (copy) v_u_3, (copy) v_u_1, (copy) v_u_2
function v_u_1.GetFolder(, p4)
-- upvalues: (ref) v_u_3
if p4 then
for , v5 in pairs(v_u_3:GetChildren()) do
for , v6 in pairs(v5:GetChildren()) do
if v6.Name == p4.Name then
return v5
end
end
end
end
end
function v_u_1.GetPlayerFolder(, p7)
-- upvalues: (ref) v_u_1
if p7 then
local v8 = v_u_1:GetFolder(p7)
local v9 = v8 and v8:FindFirstChild(p7.Name)
if v9 then
return v9
end
end
end
function v_u_1.GetPlayer_B_Object(, p10)
-- upvalues: (ref) v_u_1, (ref) v_u_2
local v11 = p10 and v_u_1:GetFolder(p10)
if v11 then
for , v12 in pairs(v11:GetChildren()) do
if v12.Name ~= p10.Name then
local v13 = v_u_2:FindFirstChild(v12.Name)
if v13 then
return v13
end
end
end
end
end
function v_u_1.GetPlayer_B_Folder(, p14)
-- upvalues: (ref) v_u_1
if p14 then
local v15 = v_u_1:GetFolder(p14)
local v16 = v_u_1:GetPlayer_B_Object(p14)
local v17 = v15 and (v16 and v15:FindFirstChild(v16.Name))
if v17 then
return v17
end
end
end
function v_u_1.CanTrade(, p18, p19)
if p18 and p19 then
local v20 = p18:FindFirstChild("TradingID")
local v21 = p19:FindFirstChild("TradingID")
return v20 and (v20.Value == "" and (v21 and v21.Value == "")) and true or false
end
end
function v_u_1.BothSet(, p22, p23)
-- upvalues: (ref) v_u_1
local v24 = p22 and (p23 and v_u_1:GetFolder(p22))
if v24 then
local v25 = 0
for _, v26 in pairs(v24:GetChildren()) do
if v26:IsA("Folder") and v26:FindFirstChild(p23).Value == true then
v25 = v25 + 1
end
end
return v25
end
end
end
return v_u_1

========== ReplicatedStorage.Dictionary.PetStats ==========

local v1 = {}
local v_u_2 = {
["Dog"] = {
["Rarity"] = "Common",
["Clicks"] = 2,
["Flying"] = false,
["Basic"] = "rbxassetid://95421770057204",
["Gold"] = "rbxassetid://114575020265636"
},
["Cat"] = {
["Rarity"] = "Common",
["Clicks"] = 2,
["Flying"] = false,
["Basic"] = "rbxassetid://84300626717444",
["Gold"] = "rbxassetid://89176099333276"
},
["Pig"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 3,
["Flying"] = false,
["Basic"] = "rbxassetid://130457611326358",
["Gold"] = "rbxassetid://112837886062551"
},
["Bull"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 5,
["Flying"] = false,
["Basic"] = "rbxassetid://92185349558338",
["Gold"] = "rbxassetid://119803998096221"
},
["Bunny"] = {
["Rarity"] = "Rare",
["Clicks"] = 8,
["Flying"] = false,
["Basic"] = "rbxassetid://115894039721339",
["Gold"] = "rbxassetid://129245372904723"
},
["Bee"] = {
["Rarity"] = "Epic",
["Clicks"] = 13,
["Flying"] = true,
["Basic"] = "rbxassetid://112599613321815",
["Gold"] = "rbxassetid://100264595563715"
},
["Mouse"] = {
["Rarity"] = "Common",
["Clicks"] = 15,
["Flying"] = false,
["Basic"] = "rbxassetid://126023772896754",
["Gold"] = "rbxassetid://79899545219490"
},
["Elephant"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 22,
["Flying"] = false,
["Basic"] = "rbxassetid://86780112792216",
["Gold"] = "rbxassetid://86754031575994"
},
["Ram"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 28,
["Flying"] = false,
["Basic"] = "rbxassetid://108840895477493",
["Gold"] = "rbxassetid://77051764279786"
},
["Rhino"] = {
["Rarity"] = "Rare",
["Clicks"] = 35,
["Flying"] = false,
["Basic"] = "rbxassetid://109661952518482",
["Gold"] = "rbxassetid://127940711772060"
},
["Tabby Cat"] = {
["Rarity"] = "Epic",
["Clicks"] = 44,
["Flying"] = false,
["Basic"] = "rbxassetid://73828892270509",
["Gold"] = "rbxassetid://72541679759551"
},
["Green Dragon"] = {
["Rarity"] = "Legendary",
["Clicks"] = 70,
["Flying"] = true,
["Basic"] = "rbxassetid://116229342917247",
["Gold"] = "rbxassetid://106315957551314"
},
["Blue Dominus"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 2000,
["Flying"] = true,
["Basic"] = "rbxassetid://130143406317044",
["Gold"] = "rbxassetid://120276706551966"
},
["Red Dominus"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 3500,
["Flying"] = true,
["Basic"] = "rbxassetid://121903433351514",
["Gold"] = "rbxassetid://97739654310737"
},
["Green Dominus"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 6000,
["Flying"] = true,
["Basic"] = "rbxassetid://76629111514075",
["Gold"] = "rbxassetid://117303984342637"
},
["Yellow Dominus"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 9000,
["Flying"] = true,
["Basic"] = "rbxassetid://72063000820172",
["Gold"] = "rbxassetid://127685400816618"
},
["Pink Dominus"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 12000,
["Flying"] = true,
["Basic"] = "rbxassetid://92222194845580",
["Gold"] = "rbxassetid://80546049746605"
},
["Dual Dominus"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 25000,
["Flying"] = true,
["Basic"] = "rbxassetid://117738590915104",
["Gold"] = "rbxassetid://120894534739712"
},
["Pink Lollipop"] = {
["Rarity"] = "Common",
["Clicks"] = 85,
["Flying"] = false,
["Basic"] = "rbxassetid://102732485093926",
["Gold"] = "rbxassetid://106463553148166"
},
["Red Lollipop"] = {
["Rarity"] = "Common",
["Clicks"] = 85,
["Flying"] = false,
["Basic"] = "rbxassetid://73464784609449",
["Gold"] = "rbxassetid://84532895872318"
},
["Gumdrop"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 100,
["Flying"] = false,
["Basic"] = "rbxassetid://109797132297160",
["Gold"] = "rbxassetid://76532488490815"
},
["Chocolate"] = {
["Rarity"] = "Rare",
["Clicks"] = 125,
["Flying"] = false,
["Basic"] = "rbxassetid://138894935869907",
["Gold"] = "rbxassetid://125242126013713"
},
["Ice Cream"] = {
["Rarity"] = "Epic",
["Clicks"] = 185,
["Flying"] = false,
["Basic"] = "rbxassetid://93043713461154",
["Gold"] = "rbxassetid://72434457656833"
},
["Unicorn"] = {
["Rarity"] = "Legendary",
["Clicks"] = 250,
["Flying"] = false,
["Basic"] = "rbxassetid://139929374531517",
["Gold"] = "rbxassetid://76672475948930"
},
["Candy Cane"] = {
["Rarity"] = "Common",
["Clicks"] = 150,
["Flying"] = false,
["Basic"] = "rbxassetid://71252523804248",
["Gold"] = "rbxassetid://84284873188820"
},
["Candy Corn"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 200,
["Flying"] = false,
["Basic"] = "rbxassetid://76647703220288",
["Gold"] = "rbxassetid://138093514560025"
},
["Gummy Bear"] = {
["Rarity"] = "Rare",
["Clicks"] = 265,
["Flying"] = false,
["Basic"] = "rbxassetid://128899544748982",
["Gold"] = "rbxassetid://114839461726461"
},
["Cake"] = {
["Rarity"] = "Epic",
["Clicks"] = 320,
["Flying"] = false,
["Basic"] = "rbxassetid://111641827666204",
["Gold"] = "rbxassetid://82203239543887"
},
["Cupcake"] = {
["Rarity"] = "Legendary",
["Clicks"] = 400,
["Flying"] = false,
["Basic"] = "rbxassetid://87775300387210",
["Gold"] = "rbxassetid://94178466927056"
},
["Candy Demon"] = {
["Rarity"] = "Mythical",
["Clicks"] = 600,
["Flying"] = true,
["Basic"] = "rbxassetid://87956800872801",
["Gold"] = "rbxassetid://124480687075384"
},
["Cactus"] = {
["Rarity"] = "Common",
["Clicks"] = 500,
["Flying"] = false,
["Basic"] = "rbxassetid://70381577840258",
["Gold"] = "rbxassetid://84076618655314"
},
["Pyramid"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 625,
["Flying"] = false,
["Basic"] = "rbxassetid://77866010133220",
["Gold"] = "rbxassetid://118268958522390"
},
["Tiger"] = {
["Rarity"] = "Rare",
["Clicks"] = 750,
["Flying"] = false,
["Basic"] = "rbxassetid://74613307935352",
["Gold"] = "rbxassetid://70434392638516"
},
["Lion"] = {
["Rarity"] = "Epic",
["Clicks"] = 825,
["Flying"] = false,
["Basic"] = "rbxassetid://124443355129582",
["Gold"] = "rbxassetid://104667786228564"
},
["Scorpion"] = {
["Rarity"] = "Legendary",
["Clicks"] = 950,
["Flying"] = false,
["Basic"] = "rbxassetid://87147052056862",
["Gold"] = "rbxassetid://115462599944225"
},
["Eagle"] = {
["Rarity"] = "Mythical",
["Clicks"] = 1250,
["Flying"] = true,
["Basic"] = "rbxassetid://119287338038695",
["Gold"] = "rbxassetid://89200514053859"
},
["Mummy"] = {
["Rarity"] = "Common",
["Clicks"] = 875,
["Flying"] = false,
["Basic"] = "rbxassetid://96462805466548",
["Gold"] = "rbxassetid://132175166070770"
},
["Snake"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 950,
["Flying"] = false,
["Basic"] = "rbxassetid://114923182163830",
["Gold"] = "rbxassetid://134703681092828"
},
["Dynamite"] = {
["Rarity"] = "Rare",
["Clicks"] = 1100,
["Flying"] = false,
["Basic"] = "rbxassetid://137763876260668",
["Gold"] = "rbxassetid://132427396053093"
},
["Camel"] = {
["Rarity"] = "Epic",
["Clicks"] = 1400,
["Flying"] = false,
["Basic"] = "rbxassetid://70466696050779",
["Gold"] = "rbxassetid://70725892986051"
},
["Blue Cowboy"] = {
["Rarity"] = "Legendary",
["Clicks"] = 2000,
["Flying"] = false,
["Basic"] = "rbxassetid://93677730464943",
["Gold"] = "rbxassetid://122511706449249"
},
["Pharoah"] = {
["Rarity"] = "Mythical",
["Clicks"] = 2750,
["Flying"] = false,
["Basic"] = "rbxassetid://121767619567554",
["Gold"] = "rbxassetid://98206098322111"
},
["Sand King"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 15000,
["Flying"] = true,
["Basic"] = "rbxassetid://87487715294200",
["Gold"] = "rbxassetid://108400390568748"
},
["Magma Rock"] = {
["Rarity"] = "Common",
["Clicks"] = 1250,
["Flying"] = false,
["Basic"] = "rbxassetid://104013709326586",
["Gold"] = "rbxassetid://75920189286754"
},
["Magma Dog"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 1750,
["Flying"] = false,
["Basic"] = "rbxassetid://83039117576774",
["Gold"] = "rbxassetid://116627112865842"
},
["Magma Lion"] = {
["Rarity"] = "Rare",
["Clicks"] = 2250,
["Flying"] = false,
["Basic"] = "rbxassetid://116236547403310",
["Gold"] = "rbxassetid://115435200236143"
},
["Magma Ghost"] = {
["Rarity"] = "Epic",
["Clicks"] = 3000,
["Flying"] = true,
["Basic"] = "rbxassetid://92178607599278",
["Gold"] = "rbxassetid://100312917237410"
},
["Magma Dragon"] = {
["Rarity"] = "Legendary",
["Clicks"] = 4500,
["Flying"] = true,
["Basic"] = "rbxassetid://124491076046046",
["Gold"] = "rbxassetid://94216207048803"
},
["Magma King"] = {
["Rarity"] = "Mythical",
["Clicks"] = 6000,
["Flying"] = true,
["Basic"] = "rbxassetid://95767895953398",
["Gold"] = "rbxassetid://80647127422827"
},
["Volcano"] = {
["Rarity"] = "Common",
["Clicks"] = 2650,
["Flying"] = false,
["Basic"] = "rbxassetid://76293089562106",
["Gold"] = "rbxassetid://101121057043231"
},
["Inferno Bear"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 3300,
["Flying"] = false,
["Basic"] = "rbxassetid://116538427299545",
["Gold"] = "rbxassetid://85971721400329"
},
["Inferno Ghost"] = {
["Rarity"] = "Rare",
["Clicks"] = 4250,
["Flying"] = true,
["Basic"] = "rbxassetid://128092150935147",
["Gold"] = "rbxassetid://130555894408356"
},
["Inferno Dominus"] = {
["Rarity"] = "Epic",
["Clicks"] = 5500,
["Flying"] = true,
["Basic"] = "rbxassetid://78284077508710",
["Gold"] = "rbxassetid://130014524042980"
},
["Inferno Hydra"] = {
["Rarity"] = "Legendary",
["Clicks"] = 6650,
["Flying"] = true,
["Basic"] = "rbxassetid://123273222846383",
["Gold"] = "rbxassetid://130717485260406"
},
["Inferno King Dominus"] = {
["Rarity"] = "Mythical",
["Clicks"] = 7750,
["Flying"] = true,
["Basic"] = "rbxassetid://138296243797321",
["Gold"] = "rbxassetid://78691216990744"
},
["Inferno Angel"] = {
["Rarity"] = "Secret",
["Clicks"] = 100000,
["Flying"] = true,
["Basic"] = "rbxassetid://126064956166043",
["Gold"] = "rbxassetid://134723669440797"
},
["Inferno King"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 5000,
["Flying"] = true,
["Basic"] = "rbxassetid://115835496951772",
["Gold"] = "rbxassetid://127993831054122"
},
["Inferno Golem"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 25000,
["Flying"] = false,
["Basic"] = "rbxassetid://99298849507362",
["Gold"] = "rbxassetid://110606531275303"
},
["Inferno Dragon"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 3000,
["Flying"] = true,
["Basic"] = "rbxassetid://105981522360160",
["Gold"] = "rbxassetid://71966333619442"
},
["Inferno Demon"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 3000,
["Flying"] = true,
["Basic"] = "rbxassetid://72760986598750",
["Gold"] = "rbxassetid://104228996809511"
},
["Magma Titan"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 50000,
["Flying"] = true,
["Basic"] = "rbxassetid://94921285914266",
["Gold"] = "rbxassetid://94089105529002"
},
["Anchor"] = {
["Rarity"] = "Common",
["Clicks"] = 17500,
["Flying"] = false,
["Basic"] = "rbxassetid://121445806573825",
["Gold"] = "rbxassetid://91216698728888"
},
["Star"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 25000,
["Flying"] = false,
["Basic"] = "rbxassetid://81219943376342",
["Gold"] = "rbxassetid://101244840262528"
},
["Shell"] = {
["Rarity"] = "Rare",
["Clicks"] = 33000,
["Flying"] = false,
["Basic"] = "rbxassetid://125043693853317",
["Gold"] = "rbxassetid://113640833612743"
},
["Dolphin"] = {
["Rarity"] = "Epic",
["Clicks"] = 42500,
["Flying"] = false,
["Basic"] = "rbxassetid://80293796757989",
["Gold"] = "rbxassetid://119474931206643"
},
["Octopus"] = {
["Rarity"] = "Legendary",
["Clicks"] = 55000,
["Flying"] = false,
["Basic"] = "rbxassetid://103686442680544",
["Gold"] = "rbxassetid://72900172145549"
},
["Neptune"] = {
["Rarity"] = "Mythical",
["Clicks"] = 70000,
["Flying"] = false,
["Basic"] = "rbxassetid://118678731178345",
["Gold"] = "rbxassetid://113518991944630"
},
["Pearl"] = {
["Rarity"] = "Common",
["Clicks"] = 40000,
["Flying"] = false,
["Basic"] = "rbxassetid://137156691540472",
["Gold"] = "rbxassetid://75694400490484"
},
["Crab"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 52500,
["Flying"] = false,
["Basic"] = "rbxassetid://76860616315069",
["Gold"] = "rbxassetid://98510772533073"
},
["Kraken"] = {
["Rarity"] = "Rare",
["Clicks"] = 66500,
["Flying"] = false,
["Basic"] = "rbxassetid://123968648260427",
["Gold"] = "rbxassetid://135434531211126"
},
["Shark"] = {
["Rarity"] = "Epic",
["Clicks"] = 75000,
["Flying"] = false,
["Basic"] = "rbxassetid://85120964176095",
["Gold"] = "rbxassetid://136344373081746"
},
["Scuba Diver"] = {
["Rarity"] = "Legendary",
["Clicks"] = 85000,
["Flying"] = false,
["Basic"] = "rbxassetid://112103721753910",
["Gold"] = "rbxassetid://94046424090185"
},
["Cthulu"] = {
["Rarity"] = "Mythical",
["Clicks"] = 100000,
["Flying"] = true,
["Basic"] = "rbxassetid://86811910081538",
["Gold"] = "rbxassetid://113008406706940"
},
["Sea Serpent"] = {
["Rarity"] = "Secret",
["Clicks"] = 1000000,
["Flying"] = true,
["Basic"] = "rbxassetid://109157802861313",
["Gold"] = "rbxassetid://135972682083101"
},
["Trident"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 500000,
["Flying"] = true,
["Basic"] = "rbxassetid://124331766595862",
["Gold"] = "rbxassetid://132510775165009"
},
["Ship"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 500000,
["Flying"] = true,
["Basic"] = "rbxassetid://103260315589342",
["Gold"] = "rbxassetid://121857803235439"
},
["Pirate"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 10000000,
["Flying"] = true,
["Basic"] = "rbxassetid://113513781730789",
["Gold"] = "rbxassetid://129258068316749"
},
["Sea Horse"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 500000,
["Flying"] = true,
["Basic"] = "rbxassetid://77039773318991",
["Gold"] = "rbxassetid://71417577179274"
},
["Watermelon"] = {
["Rarity"] = "Common",
["Clicks"] = 245000,
["Flying"] = false,
["Basic"] = "rbxassetid://71085376846718",
["Gold"] = "rbxassetid://105264629613992"
},
["Apple"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 350000,
["Flying"] = false,
["Basic"] = "rbxassetid://115741304365227",
["Gold"] = "rbxassetid://81928379239630"
},
["Cookie"] = {
["Rarity"] = "Rare",
["Clicks"] = 475000,
["Flying"] = false,
["Basic"] = "rbxassetid://115061226266121",
["Gold"] = "rbxassetid://123152323029583"
},
["Pancake"] = {
["Rarity"] = "Epic",
["Clicks"] = 600000,
["Flying"] = false,
["Basic"] = "rbxassetid://110896441566695",
["Gold"] = "rbxassetid://115122967471012"
},
["Pizza"] = {
["Rarity"] = "Legendary",
["Clicks"] = 825000,
["Flying"] = false,
["Basic"] = "rbxassetid://75588469661497",
["Gold"] = "rbxassetid://109046796781243"
},
["Gummy Dragon"] = {
["Rarity"] = "Mythical",
["Clicks"] = 1000000,
["Flying"] = true,
["Basic"] = "rbxassetid://100600475880275",
["Gold"] = "rbxassetid://130796576269280"
},
["Burger"] = {
["Rarity"] = "Common",
["Clicks"] = 525000,
["Flying"] = false,
["Basic"] = "rbxassetid://76548431208410",
["Gold"] = "rbxassetid://102588058451070"
},
["Soda"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 650000,
["Flying"] = false,
["Basic"] = "rbxassetid://110290648081078",
["Gold"] = "rbxassetid://123036831035732"
},
["Sauce"] = {
["Rarity"] = "Rare",
["Clicks"] = 775000,
["Flying"] = false,
["Basic"] = "rbxassetid://137176688125725",
["Gold"] = "rbxassetid://70757172423705"
},
["Turkey Leg"] = {
["Rarity"] = "Epic",
["Clicks"] = 900000,
["Flying"] = false,
["Basic"] = "rbxassetid://106715037458429",
["Gold"] = "rbxassetid://123549567710181"
},
["Fries"] = {
["Rarity"] = "Legendary",
["Clicks"] = 1450000,
["Flying"] = false,
["Basic"] = "rbxassetid://109310221054501",
["Gold"] = "rbxassetid://82903495017446"
},
["Chef"] = {
["Rarity"] = "Mythical",
["Clicks"] = 2200000,
["Flying"] = false,
["Basic"] = "rbxassetid://90009547223258",
["Gold"] = "rbxassetid://81634252215718"
},
["Strawberry Overlord"] = {
["Rarity"] = "Secret",
["Clicks"] = 10000000,
["Flying"] = true,
["Basic"] = "rbxassetid://71825245723597",
["Gold"] = "rbxassetid://125252564943422"
},
["Spatula"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 10000000,
["Flying"] = false,
["Basic"] = "rbxassetid://99415237529101",
["Gold"] = "rbxassetid://110607585961374"
},
["Brick"] = {
["Rarity"] = "Common",
["Clicks"] = 2500000,
["Flying"] = false,
["Basic"] = "rbxassetid://112750686820388",
["Gold"] = "rbxassetid://96570847627763"
},
["Rubik Cube"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 3300000,
["Flying"] = false,
["Basic"] = "rbxassetid://101963858717366",
["Gold"] = "rbxassetid://70828437117774"
},
["Fidget Spinner"] = {
["Rarity"] = "Rare",
["Clicks"] = 4750000,
["Flying"] = false,
["Basic"] = "rbxassetid://133572896448934",
["Gold"] = "rbxassetid://80301501979068"
},
["Soccer Ball"] = {
["Rarity"] = "Epic",
["Clicks"] = 6500000,
["Flying"] = false,
["Basic"] = "rbxassetid://78027322924931",
["Gold"] = "rbxassetid://82994524362714"
},
["Robot"] = {
["Rarity"] = "Legendary",
["Clicks"] = 8500000,
["Flying"] = false,
["Basic"] = "rbxassetid://136309381170002",
["Gold"] = "rbxassetid://108352891878740"
},
["Teddy Bear"] = {
["Rarity"] = "Mythical",
["Clicks"] = 10000000,
["Flying"] = false,
["Basic"] = "rbxassetid://115253251555201",
["Gold"] = "rbxassetid://81211391317704"
},
["Balloon"] = {
["Rarity"] = "Common",
["Clicks"] = 6000000,
["Flying"] = false,
["Basic"] = "rbxassetid://95880505190325",
["Gold"] = "rbxassetid://79806060261563"
},
["Football"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 8250000,
["Flying"] = false,
["Basic"] = "rbxassetid://139588494674305",
["Gold"] = "rbxassetid://95509066013661"
},
["Toy Train"] = {
["Rarity"] = "Rare",
["Clicks"] = 9500000,
["Flying"] = false,
["Basic"] = "rbxassetid://129806988548419",
["Gold"] = "rbxassetid://102213496116762"
},
["Toy Car"] = {
["Rarity"] = "Epic",
["Clicks"] = 12000000,
["Flying"] = false,
["Basic"] = "rbxassetid://89357108667427",
["Gold"] = "rbxassetid://119113201426382"
},
["Brick Hydra"] = {
["Rarity"] = "Legendary",
["Clicks"] = 20000000,
["Flying"] = true,
["Basic"] = "rbxassetid://131429736593442",
["Gold"] = "rbxassetid://130001847526822"
},
["Dragon Plushie"] = {
["Rarity"] = "Mythical",
["Clicks"] = 28000000,
["Flying"] = false,
["Basic"] = "rbxassetid://81966001639693",
["Gold"] = "rbxassetid://82598064248855"
},
["Brick God"] = {
["Rarity"] = "Secret",
["Clicks"] = 250000000,
["Flying"] = true,
["Basic"] = "rbxassetid://110285543575021",
["Gold"] = "rbxassetid://76150666557473"
},
["Bomb"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 100000000,
["Flying"] = false,
["Basic"] = "rbxassetid://140657537897070",
["Gold"] = "rbxassetid://88939877133794"
},
["Magic Dog"] = {
["Rarity"] = "Common",
["Clicks"] = 50000000,
["Flying"] = false,
["Basic"] = "rbxassetid://78333298007510",
["Gold"] = "rbxassetid://140250163464177"
},
["Magic Cat"] = {
["Rarity"] = "Common",
["Clicks"] = 50000000,
["Flying"] = false,
["Basic"] = "rbxassetid://123300489331066",
["Gold"] = "rbxassetid://112996746374316"
},
["Bunny Magician Hat"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 75000000,
["Flying"] = false,
["Basic"] = "rbxassetid://96214725455179",
["Gold"] = "rbxassetid://122866271315329"
},
["Magic Book"] = {
["Rarity"] = "Rare",
["Clicks"] = 82500000,
["Flying"] = false,
["Basic"] = "rbxassetid://94763803567381",
["Gold"] = "rbxassetid://71026927788676"
},
["Magical Potion"] = {
["Rarity"] = "Epic",
["Clicks"] = 95000000,
["Flying"] = false,
["Basic"] = "rbxassetid://71701622164142",
["Gold"] = "rbxassetid://87822486004498"
},
["Magical Golem"] = {
["Rarity"] = "Legendary",
["Clicks"] = 125000000,
["Flying"] = false,
["Basic"] = "rbxassetid://85644859854922",
["Gold"] = "rbxassetid://110258277967237"
},
["Mushroom"] = {
["Rarity"] = "Common",
["Clicks"] = 100000000,
["Flying"] = false,
["Basic"] = "rbxassetid://84243302968086",
["Gold"] = "rbxassetid://115876819099283"
},
["Wizard"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 150000000,
["Flying"] = false,
["Basic"] = "rbxassetid://96298800380571",
["Gold"] = "rbxassetid://136916759667441"
},
["Witch"] = {
["Rarity"] = "Rare",
["Clicks"] = 250000000,
["Flying"] = false,
["Basic"] = "rbxassetid://84652073605906",
["Gold"] = "rbxassetid://127252868705453"
},
["Magic Wand"] = {
["Rarity"] = "Epic",
["Clicks"] = 400000000,
["Flying"] = false,
["Basic"] = "rbxassetid://76019030055812",
["Gold"] = "rbxassetid://72146838154610"
},
["Magic Hydra"] = {
["Rarity"] = "Legendary",
["Clicks"] = 650000000,
["Flying"] = true,
["Basic"] = "rbxassetid://98976360237355",
["Gold"] = "rbxassetid://113023813420495"
},
["Magic Spell"] = {
["Rarity"] = "Mythical",
["Clicks"] = 900000000,
["Flying"] = true,
["Basic"] = "rbxassetid://80309766629824",
["Gold"] = "rbxassetid://133091214173066"
},
["Magic Hat"] = {
["Rarity"] = "Secret",
["Clicks"] = 10000000000,
["Flying"] = true,
["Basic"] = "rbxassetid://114190644708909",
["Gold"] = "rbxassetid://74082677755165"
},
["Magic Broom"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 50000000,
["Flying"] = true,
["Basic"] = "rbxassetid://90026056518007",
["Gold"] = "rbxassetid://91860566516975"
},
["Magic King"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 50000000,
["Flying"] = true,
["Basic"] = "rbxassetid://129124350510706",
["Gold"] = "rbxassetid://112440451265484"
},
["The Curse"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 5000000000,
["Flying"] = true,
["Basic"] = "rbxassetid://138352768643566",
["Gold"] = "rbxassetid://98972540563262"
},
["Magic Titan"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 2500000000,
["Flying"] = true,
["Basic"] = "rbxassetid://138926957574230",
["Gold"] = "rbxassetid://133429669379742"
},
["Ninja Dog"] = {
["Rarity"] = "Common",
["Clicks"] = 2500000000,
["Flying"] = false,
["Basic"] = "rbxassetid://118192342906311",
["Gold"] = "rbxassetid://95033817569219"
},
["Bamboo"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 3300000000,
["Flying"] = false,
["Basic"] = "rbxassetid://89930674067388",
["Gold"] = "rbxassetid://132543478337367"
},
["Panda"] = {
["Rarity"] = "Rare",
["Clicks"] = 4500000000,
["Flying"] = false,
["Basic"] = "rbxassetid://137346830695321",
["Gold"] = "rbxassetid://104945444196969"
},
["Ninja"] = {
["Rarity"] = "Epic",
["Clicks"] = 6000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://94528655992558",
["Gold"] = "rbxassetid://70476535615264"
},
["Shuriken"] = {
["Rarity"] = "Legendary",
["Clicks"] = 8000000000,
["Flying"] = true,
["Basic"] = "rbxassetid://113194277500076",
["Gold"] = "rbxassetid://78654328039247"
},
["Yin Yang"] = {
["Rarity"] = "Mythical",
["Clicks"] = 10000000000,
["Flying"] = true,
["Basic"] = "rbxassetid://77872786185323",
["Gold"] = "rbxassetid://71329132435109"
},
["Scroll"] = {
["Rarity"] = "Common",
["Clicks"] = 5000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://119424849319234",
["Gold"] = "rbxassetid://120940740503226"
},
["Katana"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 6250000000,
["Flying"] = false,
["Basic"] = "rbxassetid://127239755921270",
["Gold"] = "rbxassetid://105187018633855"
},
["Oni"] = {
["Rarity"] = "Rare",
["Clicks"] = 7500000000,
["Flying"] = false,
["Basic"] = "rbxassetid://99997894027318",
["Gold"] = "rbxassetid://72781271564004"
},
["Sensei"] = {
["Rarity"] = "Epic",
["Clicks"] = 8850000000,
["Flying"] = false,
["Basic"] = "rbxassetid://117835499482033",
["Gold"] = "rbxassetid://96566969997230"
},
["Samurai"] = {
["Rarity"] = "Legendary",
["Clicks"] = 12000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://97107706788881",
["Gold"] = "rbxassetid://97516403971709"
},
["Ninja Dragon"] = {
["Rarity"] = "Mythical",
["Clicks"] = 25000000000,
["Flying"] = true,
["Basic"] = "rbxassetid://96368851286280",
["Gold"] = "rbxassetid://140087698385379"
},
["Ninjitsu Master"] = {
["Rarity"] = "Secret",
["Clicks"] = 50000000000,
["Flying"] = true,
["Basic"] = "rbxassetid://121273512841268",
["Gold"] = "rbxassetid://138700759731565"
},
["Samurai Sword"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 50000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://73982205761709",
["Gold"] = "rbxassetid://76436199654548"
},
["Snowball"] = {
["Rarity"] = "Common",
["Clicks"] = 30000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://140623840018200",
["Gold"] = "rbxassetid://84188371637084"
},
["Seal"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 42500000000,
["Flying"] = false,
["Basic"] = "rbxassetid://76226447773116",
["Gold"] = "rbxassetid://117654000750585"
},
["Snowman"] = {
["Rarity"] = "Rare",
["Clicks"] = 55000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://91031990151101",
["Gold"] = "rbxassetid://92038395676614"
},
["Snowflake"] = {
["Rarity"] = "Epic",
["Clicks"] = 72500000000,
["Flying"] = true,
["Basic"] = "rbxassetid://136508710691514",
["Gold"] = "rbxassetid://73939163773903"
},
["Ice Dragon"] = {
["Rarity"] = "Legendary",
["Clicks"] = 85000000000,
["Flying"] = true,
["Basic"] = "rbxassetid://76324179608670",
["Gold"] = "rbxassetid://92698515014364"
},
["Ice Hydra"] = {
["Rarity"] = "Mythical",
["Clicks"] = 110000000000,
["Flying"] = true,
["Basic"] = "rbxassetid://124707426577309",
["Gold"] = "rbxassetid://120301198982311"
},
["Arctic Fox"] = {
["Rarity"] = "Common",
["Clicks"] = 60000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://128085155990509",
["Gold"] = "rbxassetid://96359524292553"
},
["Polar Bear"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 72500000000,
["Flying"] = false,
["Basic"] = "rbxassetid://109464197601082",
["Gold"] = "rbxassetid://102584835148905"
},
["Penguin"] = {
["Rarity"] = "Rare",
["Clicks"] = 80000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://130579053332277",
["Gold"] = "rbxassetid://95858492463017"
},
["Narwhal"] = {
["Rarity"] = "Epic",
["Clicks"] = 100000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://133122719194959",
["Gold"] = "rbxassetid://88943851024371"
},
["Gingerbread"] = {
["Rarity"] = "Legendary",
["Clicks"] = 150000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://114259157919190",
["Gold"] = "rbxassetid://119761741232683"
},
["Frost Demon"] = {
["Rarity"] = "Mythical",
["Clicks"] = 250000000000,
["Flying"] = true,
["Basic"] = "rbxassetid://98248046694400",
["Gold"] = "rbxassetid://113670450873575"
},
["Ice Crystal"] = {
["Rarity"] = "Secret",
["Clicks"] = 2000000000000,
["Flying"] = true,
["Basic"] = "rbxassetid://106563830329524",
["Gold"] = "rbxassetid://140734205980921"
},
["Yeti"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 300000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://82237275246802",
["Gold"] = "rbxassetid://79410939313524"
},
["Coconut"] = {
["Rarity"] = "Common",
["Clicks"] = 82500000000,
["Flying"] = false,
["Basic"] = "rbxassetid://120162011304000",
["Gold"] = "rbxassetid://102205865704634"
},
["Fish"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 120000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://121182126476631",
["Gold"] = "rbxassetid://109178971615501"
},
["Beach Ball"] = {
["Rarity"] = "Rare",
["Clicks"] = 200000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://96269984013247",
["Gold"] = "rbxassetid://105924873511180"
},
["Angler Fish"] = {
["Rarity"] = "Epic",
["Clicks"] = 280000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://81822613373113",
["Gold"] = "rbxassetid://100138853079097"
},
["Surfboard"] = {
["Rarity"] = "Legendary",
["Clicks"] = 350000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://78573384895850",
["Gold"] = "rbxassetid://126411615660970"
},
["Flamingo"] = {
["Rarity"] = "Mythical",
["Clicks"] = 600000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://127120524167521",
["Gold"] = "rbxassetid://72836604340231"
},
["Sand Bucket"] = {
["Rarity"] = "Common",
["Clicks"] = 220000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://79145747781114",
["Gold"] = "rbxassetid://121264811839001"
},
["Sand"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 300000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://84842671851622",
["Gold"] = "rbxassetid://136069041139557"
},
["Stingray"] = {
["Rarity"] = "Rare",
["Clicks"] = 450000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://95944010277317",
["Gold"] = "rbxassetid://122383049908711"
},
["Sand Castle"] = {
["Rarity"] = "Epic",
["Clicks"] = 625000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://93384274183768",
["Gold"] = "rbxassetid://129118979229316"
},
["Orc"] = {
["Rarity"] = "Legendary",
["Clicks"] = 750000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://111348474677250",
["Gold"] = "rbxassetid://115401524122826"
},
["Speedboat"] = {
["Rarity"] = "Mythical",
["Clicks"] = 900000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://97318237522475",
["Gold"] = "rbxassetid://96729811477391"
},
["Dice Lord"] = {
["Rarity"] = "Secret",
["Clicks"] = 2500000000000,
["Flying"] = true,
["Basic"] = "rbxassetid://128764513440974",
["Gold"] = "rbxassetid://92706138587375"
},
["Beach Hydra"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 1000000000000,
["Flying"] = true,
["Basic"] = "rbxassetid://135491100952017",
["Gold"] = "rbxassetid://77607927039669"
},
["Banana"] = {
["Rarity"] = "Common",
["Clicks"] = 50000000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://87563838599798",
["Gold"] = "rbxassetid://111118413991815"
},
["Frog"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 72500000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://123855416815641",
["Gold"] = "rbxassetid://95096141962328"
},
["Monkey"] = {
["Rarity"] = "Rare",
["Clicks"] = 130000000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://72000826515297",
["Gold"] = "rbxassetid://117412349783262"
},
["Spider"] = {
["Rarity"] = "Epic",
["Clicks"] = 250000000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://77057157332273",
["Gold"] = "rbxassetid://104415745257476"
},
["Gorilla"] = {
["Rarity"] = "Legendary",
["Clicks"] = 600000000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://116337326628263",
["Gold"] = "rbxassetid://124586617817091"
},
["Jungle Demon"] = {
["Rarity"] = "Mythical",
["Clicks"] = 900000000000000,
["Flying"] = true,
["Basic"] = "rbxassetid://118136708142202",
["Gold"] = "rbxassetid://140148838712847"
},
["Dino Skeley"] = {
["Rarity"] = "Secret",
["Clicks"] = 2500000000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://126440479673322",
["Gold"] = "rbxassetid://133231909202743"
},
["Globe"] = {
["Rarity"] = "Common",
["Clicks"] = 900000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://136333389252849",
["Gold"] = "rbxassetid://82722409099455"
},
["Tree"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 1800000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://123679825267363",
["Gold"] = "rbxassetid://130527395791773"
},
["Present"] = {
["Rarity"] = "Rare",
["Clicks"] = 3500000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://104664101652279",
["Gold"] = "rbxassetid://101772668377971"
},
["Reindeer"] = {
["Rarity"] = "Epic",
["Clicks"] = 7250000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://78054144602933",
["Gold"] = "rbxassetid://97716937237188"
},
["Elf"] = {
["Rarity"] = "Legendary",
["Clicks"] = 10000000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://123996101595578",
["Gold"] = "rbxassetid://90323783427812"
},
["Santa"] = {
["Rarity"] = "Mythical",
["Clicks"] = 22500000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://130380690725081",
["Gold"] = "rbxassetid://120189620186029"
},
["Massive SANTA"] = {
["Rarity"] = "Secret",
["Clicks"] = 80000000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://135910029895028",
["Gold"] = "rbxassetid://115718804249753"
},
["Astronaut"] = {
["Rarity"] = "Common",
["Clicks"] = 8000000000000000,
["Flying"] = false,
["Basic"] = "rbxassetid://71076703935888",
["Gold"] = "rbxassetid://103768831880879"
},
["Alien"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 1.2e16,
["Flying"] = false,
["Basic"] = "rbxassetid://138727732080991",
["Gold"] = "rbxassetid://129769567267919"
},
["Spaceship"] = {
["Rarity"] = "Rare",
["Clicks"] = 2e16,
["Flying"] = false,
["Basic"] = "rbxassetid://75981425235173",
["Gold"] = "rbxassetid://109968954252125"
},
["UFO"] = {
["Rarity"] = "Epic",
["Clicks"] = 3.5e16,
["Flying"] = true,
["Basic"] = "rbxassetid://74590906758394",
["Gold"] = "rbxassetid://105229586708053"
},
["Satellite"] = {
["Rarity"] = "Legendary",
["Clicks"] = 8e16,
["Flying"] = true,
["Basic"] = "rbxassetid://93945668832070",
["Gold"] = "rbxassetid://118266664792073"
},
["Sun"] = {
["Rarity"] = "Mythical",
["Clicks"] = 1.2e17,
["Flying"] = true,
["Basic"] = "rbxassetid://75559668925334",
["Gold"] = "rbxassetid://111398708436126"
},
["Starry Angel"] = {
["Rarity"] = "Secret",
["Clicks"] = 3.5e17,
["Flying"] = true,
["Basic"] = "rbxassetid://133444105155048",
["Gold"] = "rbxassetid://91685832435256"
},
["Dark Matter"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 1e16,
["Flying"] = false,
["Basic"] = "rbxassetid://113075714496125",
["Gold"] = "rbxassetid://136824204825293"
},
["Black Hole"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 2.5e16,
["Flying"] = true,
["Basic"] = "rbxassetid://75493473033287",
["Gold"] = "rbxassetid://84098186693998"
},
["Lost Galaxy"] = {
["Rarity"] = "Exclusive",
["Clicks"] = 5e16,
["Flying"] = true,
["Basic"] = "rbxassetid://134736170308304",
["Gold"] = "rbxassetid://129040265039983"
},
["Angelic Cat"] = {
["Rarity"] = "Common",
["Clicks"] = 2e16,
["Flying"] = false,
["Basic"] = "rbxassetid://90775143033996",
["Gold"] = "rbxassetid://104342727044953"
},
["Angelic Dog"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 3.5e16,
["Flying"] = false,
["Basic"] = "rbxassetid://84046377221135",
["Gold"] = "rbxassetid://109575991876267"
},
["Angelic Hydra"] = {
["Rarity"] = "Rare",
["Clicks"] = 6e16,
["Flying"] = true,
["Basic"] = "rbxassetid://130741132745835",
["Gold"] = "rbxassetid://126705783087713"
},
["Angelic Emperor"] = {
["Rarity"] = "Epic",
["Clicks"] = 1e17,
["Flying"] = true,
["Basic"] = "rbxassetid://94367302473144",
["Gold"] = "rbxassetid://71281929689438"
},
["Angelic Augustus"] = {
["Rarity"] = "Legendary",
["Clicks"] = 2.5e17,
["Flying"] = true,
["Basic"] = "rbxassetid://97831215469484",
["Gold"] = "rbxassetid://112019552089449"
},
["Angelic Wyvern"] = {
["Rarity"] = "Mythical",
["Clicks"] = 4e17,
["Flying"] = false,
["Basic"] = "rbxassetid://81012102496225",
["Gold"] = "rbxassetid://106454202759451"
},
["Heaven Gates"] = {
["Rarity"] = "Secret",
["Clicks"] = 1e18,
["Flying"] = true,
["Basic"] = "rbxassetid://131499286095922",
["Gold"] = "rbxassetid://117474019816242"
},
["Goat"] = {
["Rarity"] = "Common",
["Clicks"] = 4.5e17,
["Flying"] = false,
["Basic"] = "rbxassetid://125563990825622",
["Gold"] = "rbxassetid://73217871561680"
},
["Underlord"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 7e17,
["Flying"] = false,
["Basic"] = "rbxassetid://131433480719953",
["Gold"] = "rbxassetid://96492192594613"
},
["Hellbound"] = {
["Rarity"] = "Rare",
["Clicks"] = 1e18,
["Flying"] = true,
["Basic"] = "rbxassetid://86174937398785",
["Gold"] = "rbxassetid://97615213452172"
},
["Obsidrax"] = {
["Rarity"] = "Epic",
["Clicks"] = 1.8e18,
["Flying"] = true,
["Basic"] = "rbxassetid://120223957101977",
["Gold"] = "rbxassetid://74429626632277"
},
["Infernum"] = {
["Rarity"] = "Legendary",
["Clicks"] = 3e18,
["Flying"] = true,
["Basic"] = "rbxassetid://100375180842792",
["Gold"] = "rbxassetid://111048584821534"
},
["Hades"] = {
["Rarity"] = "Mythical",
["Clicks"] = 5e18,
["Flying"] = true,
["Basic"] = "rbxassetid://74458222774868",
["Gold"] = "rbxassetid://111329859812149"
},
["Star of Infernum"] = {
["Rarity"] = "Secret",
["Clicks"] = 1.5e19,
["Flying"] = true,
["Basic"] = "rbxassetid://92624869840281",
["Gold"] = "rbxassetid://111832032973131"
},
["1M Balloon"] = {
["Rarity"] = "Common",
["Clicks"] = 4e18,
["Flying"] = true,
["Basic"] = "rbxassetid://139121747655379",
["Gold"] = "rbxassetid://87143192384986"
},
["1M Cupcake"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 5.2e18,
["Flying"] = false,
["Basic"] = "rbxassetid://126157556038064",
["Gold"] = "rbxassetid://97242951383831"
},
["1M Cake"] = {
["Rarity"] = "Rare",
["Clicks"] = 6.5e18,
["Flying"] = false,
["Basic"] = "rbxassetid://81777323401030",
["Gold"] = "rbxassetid://139375994387988"
},
["1M Patriot"] = {
["Rarity"] = "Epic",
["Clicks"] = 8.2e18,
["Flying"] = true,
["Basic"] = "rbxassetid://86004079057436",
["Gold"] = "rbxassetid://119458694070575"
},
["1M Overlord"] = {
["Rarity"] = "Legendary",
["Clicks"] = 1e19,
["Flying"] = true,
["Basic"] = "rbxassetid://126384787993739",
["Gold"] = "rbxassetid://106573857665322"
},
["1M Trophy"] = {
["Rarity"] = "Mythical",
["Clicks"] = 2e19,
["Flying"] = false,
["Basic"] = "rbxassetid://130856576008883",
["Gold"] = "rbxassetid://124770796548841"
},
["1M Emperor"] = {
["Rarity"] = "Secret",
["Clicks"] = 5e19,
["Flying"] = true,
["Basic"] = "rbxassetid://122368689920566",
["Gold"] = "rbxassetid://108525167889099"
},
["Steamphunk Cat"] = {
["Rarity"] = "Common",
["Clicks"] = 2.5e20,
["Flying"] = false,
["Basic"] = "rbxassetid://111447444106543",
["Gold"] = "rbxassetid://136968646888576"
},
["Steamphunk Dog"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 4e20,
["Flying"] = false,
["Basic"] = "rbxassetid://97886355870939",
["Gold"] = "rbxassetid://118372324168397"
},
["Steamphunk Robot"] = {
["Rarity"] = "Rare",
["Clicks"] = 6.5e20,
["Flying"] = false,
["Basic"] = "rbxassetid://125468763887191",
["Gold"] = "rbxassetid://96574071987713"
},
["Steamphunk Balloon"] = {
["Rarity"] = "Epic",
["Clicks"] = 9e20,
["Flying"] = true,
["Basic"] = "rbxassetid://117626605520575",
["Gold"] = "rbxassetid://114991188652991"
},
["Steam Furnace"] = {
["Rarity"] = "Legendary",
["Clicks"] = 1.25e21,
["Flying"] = false,
["Basic"] = "rbxassetid://128513651290744",
["Gold"] = "rbxassetid://127132632443809"
},
["Mechanical God"] = {
["Rarity"] = "Mythical",
["Clicks"] = 1.8e21,
["Flying"] = true,
["Basic"] = "rbxassetid://100821906663275",
["Gold"] = "rbxassetid://138745477875648"
},
["Steamphunk Clock"] = {
["Rarity"] = "Secret",
["Clicks"] = 5e21,
["Flying"] = true,
["Basic"] = "rbxassetid://91723602031320",
["Gold"] = "rbxassetid://114063036808924"
},
["Circus Bunny"] = {
["Rarity"] = "Common",
["Clicks"] = 1e21,
["Flying"] = false,
["Basic"] = "rbxassetid://133136135102996",
["Gold"] = "rbxassetid://122437038493077"
},
["Circus Elephant"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 2e21,
["Flying"] = false,
["Basic"] = "rbxassetid://113139014464648",
["Gold"] = "rbxassetid://91914571172104"
},
["Popcorn"] = {
["Rarity"] = "Rare",
["Clicks"] = 3.3e21,
["Flying"] = false,
["Basic"] = "rbxassetid://79285043404508",
["Gold"] = "rbxassetid://138551448028842"
},
["Clown"] = {
["Rarity"] = "Epic",
["Clicks"] = 4.6e21,
["Flying"] = false,
["Basic"] = "rbxassetid://92923015081887",
["Gold"] = "rbxassetid://90245110817710"
},
["Hexroll"] = {
["Rarity"] = "Legendary",
["Clicks"] = 7e21,
["Flying"] = true,
["Basic"] = "rbxassetid://119465802927045",
["Gold"] = "rbxassetid://109295309172696"
},
["Popplewing"] = {
["Rarity"] = "Mythical",
["Clicks"] = 9e21,
["Flying"] = true,
["Basic"] = "rbxassetid://121412001132976",
["Gold"] = "rbxassetid://113853552251619"
},
["Nightjester"] = {
["Rarity"] = "Secret",
["Clicks"] = 5e22,
["Flying"] = true,
["Basic"] = "rbxassetid://111444033161587",
["Gold"] = "rbxassetid://136604810633989"
},
["Safe"] = {
["Rarity"] = "Common",
["Clicks"] = 8.5e21,
["Flying"] = false,
["Basic"] = "rbxassetid://73707604286330",
["Gold"] = "rbxassetid://139003516465672"
},
["Police Dog"] = {
["Rarity"] = "Uncommon",
["Clicks"] = 1.25e22,
["Flying"] = false,
["Basic"] = "rbxassetid://81497734110903",
["Gold"] = "rbxassetid://99014420756625"
},
["Money Roll"] = {
["Rarity"] = "Rare",
["Clicks"] = 1.85e22,
["Flying"] = false,
["Basic"] = "rbxassetid://126128954833328",
["Gold"] = "rbxassetid://104793047888375"
},
["Money Bag"] = {
["Rarity"] = "Epic",
["Clicks"] = 2.5e22,
["Flying"] = false,
["Basic"] = "rbxassetid://88342273712196",
["Gold"] = "rbxassetid://81534446447194"
},
["Piggy Bank"] = {
["Rarity"] = "Legendary",
["Clicks"] = 3.3e22,
["Flying"] = false,
["Basic"] = "rbxassetid://137883403926323",
["Gold"] = "rbxassetid://135763780064514"
},
["Corrupt CCTV"] = {
["Rarity"] = "Mythical",
["Clicks"] = 5e22,
["Flying"] = true,
["Basic"] = "rbxassetid://112376810311341",
["Gold"] = "rbxassetid://133632434394763"
},
["Bank Hacker"] = {
["Rarity"] = "Secret",
["Clicks"] = 2e23,
["Flying"] = true,
["Basic"] = "rbxassetid://136065314820014",
["Gold"] = "rbxassetid://101250416829960"
}
}
function v1.GetByName(, p3)
-- upvalues: (copy) v_u_2
local v4 = p3 and v_u_2[p3]
if v4 then
return v4
end
end
function v1.GetRarity(, p5)
-- upvalues: (copy) v_u_2
if p5 then
local v6 = v_u_2[p5]
local v7 = v6 and v6.Rarity
if v7 then
return v7
end
end
end
function v1.GetImage(, p8, p9)
-- upvalues: (copy) v_u_2
if p8 and p9 then
local v10 = v_u_2[p8]
local v11 = v10 and v10[p9]
if v11 then
return v11
end
end
end
function v1.GetTable()
-- upvalues: (copy) v_u_2
return v_u_2
end
return v1

========== ReplicatedStorage.Modules.Client.EggController.HatchController ==========

local v_u_1 = {}
local v_u_2 = game:GetService("Players").LocalPlayer
game:GetService("ReplicatedStorage")
game:GetService("RunService")
game:GetService("TweenService")
local v_u_3 = game:GetService("Lighting"):WaitForChild("DepthOfField")
v_u_2:WaitForChild("ClientData"):WaitForChild("UpgradesOwned")
local v_u_4 = v_u_2:WaitForChild("PlayerGui"):WaitForChild("HatchUI")
local v_u_5 = v_u_4:WaitForChild("FramesHolder")
v_u_4:WaitForChild("FlashFrame")
v_u_4:WaitForChild("AutoPetsFrame")
v_u_4:WaitForChild("Stop")
local v_u_6 = v_u_4:WaitForChild("Template")
local v_u_7 = false
function v_u_1.Init(p_u_8)
-- upvalues: (ref) v_u_7, (copy) v_u_1, (copy) v_u_2, (copy) v_u_4, (copy) v_u_3, (copy) v_u_6, (copy) v_u_5
local _ = p_u_8.Module3D
local v_u_9 = p_u_8.PetStats
local v_u_10 = p_u_8.PlayerMultiplier
local v_u_11 = p_u_8.RegionModule
function v_u_1.GetOpening()
-- upvalues: (ref) v_u_7
return v_u_7
end
function v_u_1.GetTime()
return 2
end
function v_u_1.GetTweens()
-- upvalues: (copy) v_u_10, (ref) v_u_2
local v12 = {}
local v13 = v_u_10:GetHatchSpeed(v_u_2)
v12.DropTween = TweenInfo.new(v13 / 2.25, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
v12.RotateTween = TweenInfo.new(v13 / 10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
v12.SizeTween = TweenInfo.new(v13 / 8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
v12.FadeTween = TweenInfo.new(v13 / 15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
return v12
end
function v_u_1.UpdateUI(, p14)
-- upvalues: (ref) v_u_4, (copy) p_u_8, (ref) v_u_3
v_u_4.Enabled = p14
p_u_8.UIController:HideUI(p14)
v_u_3.Enabled = p14
end
function v_u_1.Create(_, p_u_15)
-- upvalues: (ref) v_u_7, (ref) v_u_1, (copy) p_u_8, (ref) v_u_2, (ref) v_u_6, (ref) v_u_5, (copy) v_u_9, (copy) v_u_11
if p_u_15 and v_u_7 == false then
v_u_7 = true
v_u_1:UpdateUI(true)
if p_u_8.AutoHatchController:GetAuto() then
p_u_8.AutoHatchPetsUI:Generate()
end
v_u_2.CameraMinZoomDistance = 10
local v_u_16 = 0
for v_u_17, v_u_18 in ipairs(p_u_15) do
task.spawn(function()
-- upvalues: (ref) v_u_6, (copy) v_u_17, (ref) v_u_5, (copy) v_u_18, (ref) v_u_9, (ref) p_u_8, (ref) v_u_16, (copy) p_u_15, (ref) v_u_7, (ref) v_u_1, (ref) v_u_2, (ref) v_u_11
local v19 = v_u_6:Clone()
v19.Name = v_u_17
v19.LayoutOrder = v_u_17
v19.Visible = true
v19.Parent = v_u_5
v19:WaitForChild("Display"):WaitForChild("UIScale")
local v20 = v_u_18.PetName
local v21 = v_u_18.EggName
local v22 = v_u_9:GetRarity(v20)
if p_u_8.HatchEggDisplay:Create(v21, v22, v19) == true and p_u_8.HatchPetDisplay:Create(v20, v22, v19) == true then
v19:Destroy()
v_u_16 = v_u_16 + 1
if v_u_16 >= #p_u_15 then
local v23 = p_u_8.AutoHatchController:GetAuto()
v_u_7 = false
if v23 == false then
v_u_1:UpdateUI(false)
p_u_8.AutoHatchPetsUI:Clear()
v_u_2.CameraMinZoomDistance = 0.5
local v24 = v_u_11:GetClosestObject()
if v24 then
p_u_8.EggDisplay:OpenFrame(v24)
end
end
end
end
end)
end
end
end
end
return v_u_1

========== ReplicatedStorage.Dictionary.Market.DevProducts ==========

local v_u_1 = {}
local v_u_2 = game:GetService("MarketplaceService")
local v_u_3 = {
{
["Name"] = "Reset Gifts",
["ImageID"] = "rbxassetid://118219513764463",
["ID"] = 3452469827
},
{
["Name"] = "Skip Daily",
["ImageID"] = "rbxassetid://85138948546358",
["ID"] = 3461521880
},
{
["Name"] = "AutoClicker",
["ImageID"] = "",
["ID"] = 3525997166
}
}
function v_u_1.Init(p_u_4)
-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_3
function v_u_1.GetPrice(, p_u_5)
-- upvalues: (ref) v_u_2
local v_u_6 = nil
local v7, v8 = pcall(function()
-- upvalues: (ref) v_u_6, (ref) v_u_2, (copy) p_u_5
v_u_6 = v_u_2:GetProductInfoAsync(p_u_5, Enum.InfoType.Product)
end)
if v7 == true then
return v_u_6.PriceInRobux
end
if v8 then
print(p_u_5)
print("Failed to Fetch " .. v8)
return nil
end
end
function v_u_1.GetImage(, p9)
-- upvalues: (ref) v_u_1
local v10 = v_u_1:GetByName(p9)
if v10 then
return v10.ImageID
end
end
function v_u_1.Prompt(, p11, p12)
-- upvalues: (ref) v_u_1, (ref) v_u_2, (copy) p_u_4
local v13 = p11 and (p12 and v_u_1:GetByName(p12))
if v13 then
v_u_2:PromptGamePassPurchase(p11, v13.ID)
p_u_4.MarketPurchaseUI:Open()
end
end
function v_u_1.GetByID(, p14)
-- upvalues: (ref) v_u_3
for , v15 in pairs(v_u_3) do
if v15.ID == p14 then
return v15
end
end
end
function v_u_1.GetByName(, p16)
-- upvalues: (ref) v_u_3
for , v17 in pairs(v_u_3) do
if v17.Name == p16 then
return v17
end
end
end
function v_u_1.GetTable()
-- upvalues: (ref) v_u_3
return v_u_3
end
end
return v_u_1

========== ReplicatedStorage.Modules.Client.UIScripts.StoreUI ==========

local v_u_1 = {}
local v2 = game:GetService("Players").LocalPlayer
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("TweenService")
local v5 = v2:WaitForChild("ClientData")
v5:WaitForChild("GamePassesOwned")
v5:WaitForChild("BoostsOwned")
v3:WaitForChild("Events"):WaitForChild("Boost")
local v_u_6 = v3:WaitForChild("ServerTimer")
local v7 = v2:WaitForChild("PlayerGui")
local v8 = v7:WaitForChild("PagesUI")
local v_u_9 = v7:WaitForChild("RightUI"):WaitForChild("RightUIFrame"):WaitForChild("ButtonsFrame"):WaitForChild("Store")
local v_u_10 = v8:WaitForChild("StoreFrame")
local v_u_11 = v_u_10:WaitForChild("List")
local v_u_12 = v_u_10:WaitForChild("ButtonsFrame")
local v_u_13 = false
TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v_u_14 = TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
function v_u_1.Init(p_u_15)
-- upvalues: (copy) v_u_11, (copy) v_u_10, (copy) v_u_1, (copy) v_u_12, (ref) v_u_13
local _ = p_u_15.NumberFormatter
function v_u_1.SendTo(, p16)
-- upvalues: (ref) v_u_11, (ref) v_u_10, (copy) p_u_15
local v17 = v_u_11:FindFirstChild(p16)
if v17 then
local v18 = v17.AbsolutePosition.Y - v_u_11.AbsolutePosition.Y + v_u_11.CanvasPosition.Y
v_u_11.CanvasPosition = Vector2.new(v_u_11.CanvasPosition.X, v18)
if v_u_10.Visible == false then
p_u_15.UIController:OpenFrame("StoreFrame")
end
end
end
function v_u_1.CreateButtons()
-- upvalues: (ref) v_u_12, (copy) p_u_15, (ref) v_u_13, (ref) v_u_1
for _, v_u_19 in pairs(v_u_12:GetChildren()) do
if v_u_19:IsA("ImageButton") then
local v_u_20 = v_u_19:WaitForChild("Icon")
v_u_19.MouseEnter:Connect(function()
-- upvalues: (ref) p_u_15, (copy) v_u_20
p_u_15.TweenModule:MouseEnter(v_u_20)
end)
v_u_19.MouseLeave:Connect(function()
-- upvalues: (ref) p_u_15, (copy) v_u_20
p_u_15.TweenModule:MouseLeave(v_u_20)
end)
v_u_19.Activated:Connect(function()
-- upvalues: (ref) v_u_13, (ref) p_u_15, (copy) v_u_19, (ref) v_u_1
if v_u_13 == false then
v_u_13 = true
p_u_15.TweenModule:Activated(v_u_19)
v_u_1:SendTo(v_u_19.Name)
task.wait(0.1)
v_u_13 = false
end
end)
end
end
end
end
function v_u_1.Start(p21)
-- upvalues: (copy) v_u_10, (copy) v_u_1, (copy) v_u_6, (copy) v_u_9, (copy) v_u_4, (copy) v_u_14
p21.CustomScrollUI:Create(v_u_10)
v_u_1:CreateButtons()
local v_u_22 = 0
v_u_6.Changed:Connect(function()
-- upvalues: (ref) v_u_22, (ref) v_u_9, (ref) v_u_4, (ref) v_u_14
if time() - v_u_22 >= 5 then
v_u_22 = time()
local v23 = v_u_9:WaitForChild("Icon"):FindFirstChildOfClass("UIScale")
if v23 == nil then
v23 = Instance.new("UIScale", v_u_9:WaitForChild("Icon"))
end
for v24 = 1, 5 do
local v25 = v24 % 2 == 0 and 8 or -8
v_u_4:Create(v_u_9:WaitForChild("Icon"), v_u_14, {
["Rotation"] = v25
}):Play()
v_u_4:Create(v23, v_u_14, {
["Scale"] = 1.1
}):Play()
task.wait(v_u_14.Time + 0.1)
end
v_u_4:Create(v_u_9:WaitForChild("Icon"), v_u_14, {
["Rotation"] = 0
}):Play()
v_u_4:Create(v23, v_u_14, {
["Scale"] = 1
}):Play()
end
end)
end
return v_u_1

========== ReplicatedStorage.Modules.Client.AdminController ==========

local v_u_1 = {}
local v_u_2 = game:GetService("Players").LocalPlayer
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("TweenService")
local v5 = v3:WaitForChild("AdminFolder")
local v_u_6 = v5:WaitForChild("Luck")
local v_u_7 = v5:WaitForChild("Party")
local v_u_8 = v5:WaitForChild("Messages")
local v_u_9 = v_u_2:WaitForChild("PlayerGui"):WaitForChild("AdminChatUI"):WaitForChild("Frame")
local v_u_10 = v_u_9:WaitForChild("Template")
local v_u_11 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
function v_u_1.Init(p_u_12)
-- upvalues: (copy) v_u_6, (copy) v_u_1, (copy) v_u_2, (copy) v_u_7, (copy) v_u_10, (copy) v_u_9, (copy) v_u_4, (copy) v_u_11
function v_u_1.UpdateLuck()
-- upvalues: (ref) v_u_6, (copy) p_u_12
if v_u_6.Value == true then
p_u_12.PopUpUI:CreateRain("Luck", (1 / 0))
elseif v_u_6.Value == false then
p_u_12.PopUpUI:RemoveRain("Luck")
end
end
function v_u_1.UpdateParty()
-- upvalues: (ref) v_u_2, (ref) v_u_7, (copy) p_u_12
local v13 = v_u_2.Character
if v13 then
local v14 = v13:WaitForChild("Humanoid")
local v15 = v13:WaitForChild("DanceAnimation")
if v14 and v15 then
local v16 = v14:LoadAnimation(v15)
if v_u_7.Value == true then
v16:Play()
p_u_12.GlowUI:Create("Party", (1 / 0))
return
end
if v_u_7.Value == false then
for , v17 in v14:GetPlayingAnimationTracks() do
v17:Stop()
end
p_u_12.GlowUI:Remove("Party")
end
end
end
end
function v_u_1.TypeText(, p18, p19)
p18.Text = ""
for v20 = 1, #p19 do
p18.Text = string.sub(p19, 1, v20)
task.wait(0.05)
end
end
function v_u_1.CreateText(, p21)
-- upvalues: (ref) v_u_10, (ref) v_u_9, (ref) v_u_4, (ref) v_u_11, (ref) v_u_1
local v22 = v_u_10:Clone()
v22.Visible = true
v22.Parent = v_u_9
v_u_4:Create(v22, v_u_11, {
["BackgroundTransparency"] = 0.75
}):Play()
v_u_1:TypeText(v22:WaitForChild("Text"), p21.Value)
wait(7)
v22:Destroy()
end
end
function v_u_1.Start()
-- upvalues: (copy) v_u_1, (copy) v_u_6, (copy) v_u_7, (copy) v_u_8
v_u_1:UpdateLuck()
v_u_1:UpdateParty()
v_u_6.Changed:Connect(function()
-- upvalues: (ref) v_u_1
v_u_1:UpdateLuck()
end)
v_u_7.Changed:Connect(function()
-- upvalues: (ref) v_u_1
v_u_1:UpdateParty()
end)
v_u_8.ChildAdded:Connect(function(p23)
-- upvalues: (ref) v_u_1
v_u_1:CreateText(p23)
end)
end
return v_u_1

========== ReplicatedStorage.Modules.Client.AutoClickController ==========

local v1 = {}
local v_u_2 = game:GetService("Players").LocalPlayer
local v3 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v_u_4 = v_u_2:WaitForChild("ClientData"):WaitForChild("ActiveBoosts")
v3:WaitForChild("Assets")
local v_u_5 = v3:WaitForChild("Events"):WaitForChild("AutoClick")
local v_u_6 = v3:WaitForChild("ServerTimer")
function v1.Start(_)
-- upvalues: (copy) v_u_6, (copy) v_u_4, (copy) v_u_5, (copy) v_u_2
v_u_6.Changed:Connect(function()
-- upvalues: (ref) v_u_4, (ref) v_u_5, (ref) v_u_2
if v_u_4:FindFirstChild("Auto Click Boost") then
v_u_5:FireServer(v_u_2)
end
end)
end
return v1

========== ReplicatedStorage.Modules.Client.OrbController ==========

local v_u_1 = {}
local _ = game:GetService("Players").LocalPlayer
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("PhysicsService")
local v_u_4 = game:GetService("Debris")
local v_u_5 = v2:WaitForChild("Events"):WaitForChild("Orb")
local v_u_6 = workspace:WaitForChild("MapFunctions"):WaitForChild("Orbs")
local v_u_7 = Random.new()
function v_u_1.Init(p8)
-- upvalues: (copy) v_u_6, (copy) v_u_3, (copy) v_u_7, (copy) v_u_4, (copy) v_u_1, (copy) v_u_5
local v_u_9 = p8.ImageModule
function v_u_1.Create(_, p10, p11, p12, p13)
-- upvalues: (ref) v_u_6, (ref) v_u_3, (ref) v_u_7, (copy) v_u_9, (ref) v_u_4
if p10 and (p11 and (p12 and p13)) then
local v14 = Instance.new("Part")
v14.Transparency = 1
v14.Name = p12
v14.Position = p13
v14.Size = Vector3.new(1, 1, 1)
v14.Anchored = false
v14.CanCollide = true
v14.Parent = v_u_6
v_u_3:SetPartCollisionGroup(v14, "Players")
local v15 = v_u_7:NextNumber(-20, 20)
local v16 = v_u_7:NextNumber(25, 50)
local v17 = v_u_7
v14.Velocity = Vector3.new(v15, v16, v17:NextNumber(-20, 20))
local v18 = v_u_7:NextNumber(-20, 20)
local v19 = v_u_7:NextNumber(25, 50)
local v20 = v_u_7
v14.RotVelocity = Vector3.new(v18, v19, v20:NextNumber(-20, 20))
local v21 = Instance.new("BillboardGui", v14)
v21.AlwaysOnTop = true
v21.Enabled = true
v21.MaxDistance = 500
v21.Size = UDim2.fromScale(1.5, 1.5)
local v22 = Instance.new("ImageLabel", v21)
v22.BackgroundTransparency = 1
v22.Size = UDim2.fromScale(1, 1)
v22.ScaleType = Enum.ScaleType.Fit
local v23 = v_u_9:GetImage(p10, p11)
if v23 then
v22.Image = v23
end
local v24 = Instance.new("BodyPosition", v14)
v24.D = 50
v24.P = 0
v24.MaxForce = Vector3.new(0, 0, 0)
v_u_4:AddItem(v14, 100)
end
end
v_u_5.OnClientEvent:Connect(function(p25)
-- upvalues: (ref) v_u_1
for _, v26 in ipairs(p25) do
v_u_1:Create(v26.Type, v26.Name, v26.OrbID, v26.OriginPosition)
end
end)
end
return v_u_1

========== ReplicatedStorage.Modules.Client.RebirthController ==========

local v_u_1 = {}
local v2 = game:GetService("Players").LocalPlayer
local v_u_3 = game:GetService("CollectionService")
v2:WaitForChild("PlayerGui"):WaitForChild("RebirthUI")
local v_u_4 = true
function v_u_1.Init(p_u_5)
-- upvalues: (copy) v_u_1, (ref) v_u_4, (copy) v_u_3
local v_u_6 = p_u_5.RegionModule
function v_u_1.Remove(, p7)
-- upvalues: (copy) v_u_6
v_u_6:Remove(p7)
end
function v_u_1.Create(, p_u_8)
-- upvalues: (copy) v_u_6, (ref) v_u_4, (copy) p_u_5
if not v_u_6:Has(p_u_8) then
v_u_6:Create(p_u_8)
local v_u_9 = p_u_8:GetAttribute("RebirthID")
v_u_6.Entered.Event:Connect(function(p10)
-- upvalues: (copy) p_u_8, (ref) v_u_4, (ref) p_u_5, (copy) v_u_9
if p_u_8 == p10 and v_u_4 == true then
v_u_4 = false
p_u_5.UIController:HideUI(true)
local v11 = v_u_9
p_u_5.RebirthUI:OpenFrame((tostring(v11)))
end
end)
v_u_6.Exited.Event:Connect(function(p12)
-- upvalues: (copy) p_u_8, (ref) v_u_4
if p_u_8 == p12 then
v_u_4 = true
end
end)
end
end
function v_u_1.Generate(_)
-- upvalues: (ref) v_u_3, (ref) v_u_1
for , v13 in pairs(v_u_3:GetTagged("Rebirth")) do
v_u_1:Create(v13)
end
end
end
function v_u_1.Start()
-- upvalues: (copy) v_u_1, (copy) v_u_3
v_u_1:Generate()
v_u_3:GetInstanceAddedSignal("Rebirth"):Connect(function(p14)
-- upvalues: (ref) v_u_1
v_u_1:Create(p14)
end)
v_u_3:GetInstanceRemovedSignal("Rebirth"):Connect(function(p15)
-- upvalues: (ref) v_u_1
v_u_1:Remove(p15)
end)
end
return v_u_1

========== ReplicatedStorage.Dictionary.UpgradeStats ==========

local v1 = {}
local v_u_2 = {}
local v3 = {
["Name"] = "Hatch Speed",
["ImageID"] = "rbxassetid://113564702528017",
["Description"] = "Increases your Hatch Speed"
}
local v4 = {
{
["Amount"] = 1.1,
["Price"] = 25,
["Text"] = "Increased Hatch Speed by 10%"
},
{
["Amount"] = 1.25,
["Price"] = 50,
["Text"] = "Increased Hatch Speed by 25%"
},
{
["Amount"] = 1.5,
["Price"] = 100,
["Text"] = "Increased Hatch Speed by 50%"
},
{
["Amount"] = 1.75,
["Price"] = 250,
["Text"] = "Increased Hatch Speed by 75%"
},
{
["Amount"] = 2,
["Price"] = 500,
["Text"] = "Increased Hatch Speed by 100%"
}
}
v3.Upgrades = v4
v_u_2[1] = v3
local v5 = {
["Name"] = "Egg Luck",
["ImageID"] = "rbxassetid://138104645941803",
["Description"] = "Increases your Egg Luck"
}
local v6 = {
{
["Amount"] = 1.1,
["Price"] = 50,
["Text"] = "Increased Egg Luck by 10%"
},
{
["Amount"] = 1.25,
["Price"] = 100,
["Text"] = "Increased Egg Luck by 25%"
},
{
["Amount"] = 1.5,
["Price"] = 250,
["Text"] = "Increased Egg Luck by 50%"
},
{
["Amount"] = 1.75,
["Price"] = 500,
["Text"] = "Increased Egg Luck by 75%"
},
{
["Amount"] = 2,
["Price"] = 1000,
["Text"] = "Increased Egg Luck by 100%"
}
}
v5.Upgrades = v6
v_u_2[2] = v5
local v7 = {
["Name"] = "Pets Storage",
["ImageID"] = "rbxassetid://135996897302796",
["Description"] = "Increases your Pet Storage"
}
local v8 = {
{
["Amount"] = 25,
["Price"] = 50,
["Text"] = "Increased Pet Storage by +25"
},
{
["Amount"] = 75,
["Price"] = 100,
["Text"] = "Increased Pet Storage by +50"
},
{
["Amount"] = 175,
["Price"] = 250,
["Text"] = "Increased Pet Storage by +100"
},
{
["Amount"] = 425,
["Price"] = 500,
["Text"] = "Increased Pet Storage by +250"
}
}
v7.Upgrades = v8
v_u_2[3] = v7
local v9 = {
["Name"] = "Pets Equips",
["ImageID"] = "rbxassetid://100095605454016",
["Description"] = "Increases your Pet Equip"
}
local v10 = {
{
["Amount"] = 1,
["Price"] = 500,
["Text"] = "Increased Pet Equip by +1"
},
{
["Amount"] = 2,
["Price"] = 1000,
["Text"] = "Increased Pet Equip by +1"
},
{
["Amount"] = 3,
["Price"] = 2500,
["Text"] = "Increased Pet Equip by +1"
}
}
v9.Upgrades = v10
v_u_2[4] = v9
function v1.GetByName(_, p11)
-- upvalues: (copy) v_u_2
for , v12 in ipairs(v_u_2) do
if v12.Name == p11 then
return v12
end
end
end
function v1.GetTable()
-- upvalues: (copy) v_u_2
return v_u_2
end
return v1

========== ReplicatedStorage.Modules.Shared.PlayerMultiplier ==========

local v_u_1 = {}
local v_u_2 = game:GetService("CollectionService")
local v_u_3 = game:GetService("ReplicatedStorage"):WaitForChild("AdminFolder"):WaitForChild("Luck")
function v_u_1.Init(p_u_4)
-- upvalues: (copy) v_u_1, (copy) v_u_3, (copy) v_u_2
local v_u_5 = p_u_4.PlayerPetStats
local v6 = p_u_4.UpgradeStats
local v7 = p_u_4.MultiplierStats
local v_u_8 = p_u_4.FriendMultiplier
local v_u_9 = p_u_4.SkinStats
local v_u_10 = v6:GetByName("Egg Luck")
local v_u_11 = v6:GetByName("Hatch Speed")
local v_u_12 = v7:GetData("Clicks")
local v_u_13 = v7:GetData("Coins")
local v_u_14 = v7:GetData("Hatch Speed")
local v_u_15 = v7:GetData("Hatch Luck")
function v_u_1.GetHatchSpeed(, p16)
-- upvalues: (copy) v_u_11, (copy) v_u_14
if p16 then
local v17 = p16:WaitForChild("ClientData")
local v18 = v17:WaitForChild("ActiveBoosts")
local v19 = v17:WaitForChild("UpgradesOwned")
local v20 = v17:WaitForChild("MultipliersOwned")
local v21 = v18:FindFirstChild("Hatch Boost")
local v22 = 2
if v21 and v21:GetAttribute("TimeLeft") > 0 then
v22 = v22 / 1.15
end
local v23 = v_u_11.Upgrades
local v24 = v19:FindFirstChild("Hatch Speed")
if v24 then
local v25 = v23[v24:GetAttribute("Value")]
if v25 then
v22 = v22 / v25.Amount
end
end
local v26 = 0
for v27, v28 in pairs(v_u_14) do
if v20:FindFirstChild(v27) then
v26 = v26 + (v28.Multiplier - 1)
end
end
local v29 = v22 / (v26 + 1)
return v29 <= 0 and 0.5 or v29
end
end
function v_u_1.GetLuck(, p30)
-- upvalues: (copy) v_u_8, (ref) v_u_3, (copy) v_u_10, (copy) v_u_15
if p30 then
local v31 = p30:WaitForChild("ClientData")
local v32 = v31:WaitForChild("ActiveBoosts")
local v33 = v31:WaitForChild("GamePassesOwned")
local v34 = v31:WaitForChild("UpgradesOwned")
local v35 = v31:WaitForChild("MultipliersOwned")
local v36 = v32:FindFirstChild("Lucky Boost")
local v37 = v32:FindFirstChild("Super Lucky Boost")
local v38 = v32:FindFirstChild("Ultra Lucky Boost")
local v39 = v32:FindFirstChild("Donut")
local v40 = v_u_8:GetCount(p30)
local v41 = {
["Rare"] = 1,
["Epic"] = 1,
["Legendary"] = 1,
["Mythical"] = 1,
["Secret"] = 1
}
if v40 > 0 then
local v42 = 1 + v40 * 0.05
local v43 = 1 + v40 * 0.025
v41.Rare = v41.Rare * v42
v41.Epic = v41.Epic * v42
v41.Legendary = v41.Legendary * v43
end
if p30.MembershipType ~= Enum.MembershipType.None then
v41.Rare = v41.Rare * 1.25
v41.Epic = v41.Epic * 1.15
v41.Legendary = v41.Legendary * 1.1
end
if v_u_3.Value == true then
v41.Legendary = v41.Legendary * 4
v41.Mythical = v41.Mythical * 8
v41.Secret = v41.Secret * 10
end
if v33:FindFirstChild("Lucky") then
v41.Legendary = v41.Legendary * 1.5
v41.Mythical = v41.Mythical * 2
end
if v33:FindFirstChild("Super Lucky") then
v41.Legendary = v41.Legendary * 2
v41.Mythical = v41.Mythical * 3
end
if v33:FindFirstChild("Secret Hatcher") then
v41.Secret = v41.Secret * 1.3
end
if v36 and (v36:GetAttribute("TimeLeft") or 0) > 0 then
v41.Epic = v41.Epic * 1.25
v41.Legendary = v41.Legendary * 1.5
v41.Mythical = v41.Mythical * 2
end
if v37 and (v37:GetAttribute("TimeLeft") or 0) > 0 then
v41.Legendary = v41.Legendary * 2
v41.Mythical = v41.Mythical * 3
end
if v38 and (v38:GetAttribute("TimeLeft") or 0) > 0 then
v41.Legendary = v41.Legendary * 2
v41.Mythical = v41.Mythical * 3
v41.Secret = v41.Secret * 1.3
end
if v39 and (v39:GetAttribute("TimeLeft") or 0) > 0 then
local v44 = 1 + (v39:GetAttribute("Applied") or 0) * 0.1
v41.Legendary = v41.Legendary * v44
v41.Mythical = v41.Mythical * v44
end
local v45 = v_u_10.Upgrades
local v46 = v34:FindFirstChild("Hatch Luck")
local v47 = v46 and v45[v46:GetAttribute("Value")]
if v47 then
local v48 = v47.Amount
v41.Epic = v41.Epic * v48
v41.Legendary = v41.Legendary * v48
v41.Mythical = v41.Mythical * v48
end
local v49 = 0
for v50, v51 in pairs(v_u_15) do
if v35:FindFirstChild(v50) then
v49 = v49 + (v51.Multiplier - 1)
end
end
if v49 > 0 then
local v52 = v49 + 1
v41.Legendary = v41.Legendary * v52
v41.Mythical = v41.Mythical * v52
end
return v41
end
end
function v_u_1.GetClicks(, p53)
-- upvalues: (copy) v_u_9, (copy) v_u_12
if p53 then
local v54 = p53:WaitForChild("ClientData")
local v55 = v54:WaitForChild("ActiveBoosts")
local v56 = v54:WaitForChild("GamePassesOwned")
local v57 = v54:WaitForChild("MultipliersOwned")
local v58 = v55:FindFirstChild("Clicks Boost")
local v59 = v55:FindFirstChild("Pizza")
local v60 = v_u_9:GetByName(v54:WaitForChild("SkinEquipped").Value)
local v61 = not v60 and 1 or v60.Multiplier
if p53.MembershipType ~= Enum.MembershipType.None then
v61 = v61 * 1.1
end
if v58 and v58:GetAttribute("TimeLeft") > 0 then
v61 = v61 * 1.5
end
if v56:FindFirstChild("2x YoYo") then
v61 = v61 * 2
end
if v59 and v59:GetAttribute("TimeLeft") > 0 then
v61 = v61 * (1 + v59:GetAttribute("Applied") * 0.1)
end
local v62 = 0
for v63, v64 in pairs(v_u_12) do
if v57:FindFirstChild(v63) then
v62 = v62 + (v64.Multiplier - 1)
end
end
return v61 * (v62 + 1)
end
end
function v_u_1.GetCoins(, p65)
-- upvalues: (copy) p_u_4, (copy) v_u_13
if p65 then
local v66 = p65:WaitForChild("ClientData")
local v67 = v66:WaitForChild("ActiveBoosts")
local v68 = v66:WaitForChild("GamePassesOwned")
v66:WaitForChild("UpgradesOwned")
local v69 = v66:WaitForChild("MultipliersOwned")
local v70 = v67:FindFirstChild("Coins Boost")
local v71 = v67:FindFirstChild("Burger")
local v72 = p_u_4.RankStats:GetMultiplier(p65)
if v70 and v70:GetAttribute("TimeLeft") > 0 then
v72 = v72 * 1.5
end
if v68:FindFirstChild("2x Coins") then
v72 = v72 * 2
end
if v71 and v71:GetAttribute("TimeLeft") > 0 then
v72 = v72 * (1 + (v71:GetAttribute("Applied") or 0) * 0.1)
end
local v73 = 0
for v74, v75 in pairs(v_u_13) do
if v69:FindFirstChild(v74) then
v73 = v73 + (v75.Multiplier - 1)
end
end
return v72 * (v73 + 1)
end
end
function v_u_1.GetGems(, p76)
if p76 then
local v77 = p76:WaitForChild("ClientData")
local v78 = v77:WaitForChild("ActiveBoosts")
local v79 = v77:WaitForChild("GamePassesOwned")
local v80 = v78:FindFirstChild("2x Gems")
local v81 = v78:FindFirstChild("Hot Dog")
local v82 = 1
if v80 and v80:GetAttribute("TimeLeft") > 0 then
v82 = v82 * 1.5
end
if v79:FindFirstChild("2x Gems") then
v82 = v82 * 2
end
if v81 and v81:GetAttribute("TimeLeft") > 0 then
v82 = v82 * (1 + v81:GetAttribute("Applied") * 0.1)
end
return v82
end
end
function v_u_1.GetPetMultiplier(, p83, p84)
-- upvalues: (ref) v_u_2, (copy) v_u_5
if p83 and p84 then
local v85 = p83:WaitForChild("ClientData"):WaitForChild("PetsOwned")
local v86 = {}
local v87 = 0
for _, v88 in pairs(v_u_2:GetTagged("Pet")) do
local v89 = v88.Name
if v85:FindFirstChild(v89) then
table.insert(v86, v89)
end
end
for _, v90 in ipairs(v86) do
v87 = v87 + v_u_5:GetPetMultiplier(p83, v90)
end
return v87
end
end
end
return v_u_1
