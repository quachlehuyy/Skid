--[[
    GAG Script by quachlehuy
    Optimized Version
]]

--// SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

--// LOCAL PLAYER
local lp = Players.LocalPlayer
local character = lp.Character or lp.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")
local backpack = lp:WaitForChild("Backpack")

--// CONFIG
local configFileName = "gag_config.json"
local config = {
    Seeds = {}, SeedToPlant = {}, Gears = {}, Eggs = {}, Items = {}, FruitsToHarvest = {}, FruitsToSell = {},
    TypePlant = "Random", DelaySell = 0.2, DelayHarvest = 0.2, SpeedValue = 20,
    PlayerPosition = nil, Speed = false, InfinityJump = false, NoClip = false,
    AutoBuySeed = false, AutoBuyAllSeed = false, AutoBuyGear = false, AutoBuyAllGear = false,
    AutoBuyEgg = false, AutoBuyAllEgg = false, AutoBuyItem = false, AutoPlant = false,
    AutoHarvest = false, AutoSellFruit = false, AutoSellWhenMax = false, AutoSellInventory = false,
    OpenGoliathShop = false, OpenGardenGui = false
}

--// FUNCTIONS: CONFIG
local function SaveConfig()
    if writefile then writefile(configFileName, HttpService:JSONEncode(config)) end
end

local function LoadConfig()
    if isfile and readfile and isfile(configFileName) then
        local success, decoded = pcall(HttpService.JSONDecode, readfile(configFileName))
        if success and type(decoded) == "table" then
            for k, v in pairs(decoded) do config[k] = v end
        end
    end
end
LoadConfig()

--// GAME DATA
local GameData = {
    Seeds = { "Carrot", "Strawberry", "Blueberry", "Orange Tulip", "Tomato", "Corn", "Daffodil", "Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut", "Cactus", "Dragon Fruit", "Mango", "Grape", "Mushroom", "Pepper", "Cacao", "Beanstalk", "Ember Lily", "Sugar Apple", "Buring Bud", "Giant Pinecone", "Elder Strawberry" },
    Gears = { "Watering Can", "Trading Ticket", "Trowel", "Recall Wrench", "Basic Sprinkler", "Advanced Sprinkler", "Medium Toy", "Medium Treat", "Godly Sprinkler", "Magnifying Glass", "Master Sprinkler", "Cleaning Spray", "Favorite Tool", "Harvest Tool", "Friendship Pot", "Grandmaster Sprinkler", "Levelup Lollipop" },
    Eggs = { "Common Egg", "Common Summer Egg", "Rare Summer Egg", "Mythical Egg", "Paradise Egg", "Bug Egg" },
    Goliathshop = { "Sprout Seed Pack", "Sprout Egg", "Mandrake", "Sprout Crate", "Silver Fertilizer", "Canary Melon", "Amberheart", "Spriggan" }
}

--// RUNTIME VARIABLES
local myFarmCache = nil
local isHarvesting = false
local sellFruitLocation = CFrame.new(86.5854721, 2.76619363, 0.426784277, 0, 0, -1, 0, 1, 0, 1, 0, 0)

--// HELPER FUNCTIONS
local function GetMyFarm()
    if myFarmCache and myFarmCache.Parent then return myFarmCache end
    for _, farm in ipairs(workspace.Farm:GetChildren()) do
        if farm:FindFirstChild("Important.Data.Owner") and farm.Important.Data.Owner.Value == lp.Name then
            myFarmCache = farm
            return farm
        end
    end
end

local function EquipTool(seedName)
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name:find(seedName) and tool.Name:find("Seed") then
            humanoid:EquipTool(tool)
            return tool
        end
    end
end

--// CORE FUNCTIONS
local function AutoCollect()
    local myFarm = GetMyFarm()
    if not myFarm then return end
    local plantsPhysical = myFarm.Important:WaitForChild("Plants_Physical")
    if not plantsPhysical then return end

    for _, plant in ipairs(plantsPhysical:GetDescendants()) do
        if not config.AutoHarvest then return end
        local isTargetPlant = table.find(config.FruitsToHarvest, plant.Name)
        if isTargetPlant then
            local prompt = plant:FindFirstChildWhichIsA("ProximityPrompt", true)
            if prompt and prompt.Enabled then
                ReplicatedStorage.GameEvents.Crops.Collect:FireServer({plant})
                task.wait(config.DelayHarvest)
            end
        end
        task.wait()
    end
end

--// UI LIBRARY
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "GAG Script", SubTitle = "by quachlehuy (Optimized)", TabWidth = 120,
    Size = UDim2.fromOffset(485, 370), Acrylic = true, Theme = "Dark", MinimizeKey = Enum.KeyCode.LeftControl
})
local Tabs = {
    Shop = Window:AddTab({ Title = "Shop", Icon = "" }),
    Farm = Window:AddTab({ Title = "Farm", Icon = "" }),
    Player = Window:AddTab({ Title = "Player", Icon = "" })
}

--- HÀM TỐI ƯU: Tạo một khu vực mua sắm hoàn chỉnh ---
local function CreateShopSection(tab, options)
    local title = options.Title
    local items = options.Items
    local selectedKey = options.SelectedKey
    local autoBuyKey = options.AutoBuyKey
    local autoBuyAllKey = options.AutoBuyAllKey
    local remoteEvent = options.RemoteEvent
    local selectedItems = {}

    tab:AddDropdown("Select" .. title, {Title = "Select " .. title, Values = items, Multi = true, Default = config[selectedKey]}):OnChanged(function(value)
        config[selectedKey] = value
        selectedItems = {}
        for item, _ in pairs(value) do table.insert(selectedItems, item) end
        SaveConfig()
    end)

    tab:AddToggle(autoBuyKey, {Title = "Auto Buy " .. title, Default = config[autoBuyKey]}):OnChanged(function(value)
        config[autoBuyKey] = value
        SaveConfig()
    end)
    task.spawn(function()
        while true do
            if config[autoBuyKey] then
                for _, item in ipairs(selectedItems) do remoteEvent:FireServer(item) end
            end
            task.wait(0.1)
        end
    end)

    tab:AddToggle(autoBuyAllKey, {Title = "Auto Buy All " .. title, Default = config[autoBuyAllKey]}):OnChanged(function(value)
        config[autoBuyAllKey] = value
        SaveConfig()
    end)
    task.spawn(function()
        while true do
            if config[autoBuyAllKey] then
                for _, item in ipairs(items) do remoteEvent:FireServer(item); task.wait() end
            end
            task.wait(0.1)
        end
    end)
end

--[[ --- SHOP TAB --- ]]
CreateShopSection(Tabs.Shop, {
    Title = "Seed", Items = GameData.Seeds, SelectedKey = "Seeds", AutoBuyKey = "AutoBuySeed",
    AutoBuyAllKey = "AutoBuyAllSeed", RemoteEvent = ReplicatedStorage.GameEvents.BuySeedStock
})
CreateShopSection(Tabs.Shop, {
    Title = "Gear", Items = GameData.Gears, SelectedKey = "Gears", AutoBuyKey = "AutoBuyGear",
    AutoBuyAllKey = "AutoBuyAllGear", RemoteEvent = ReplicatedStorage.GameEvents.BuyGearStock
})
CreateShopSection(Tabs.Shop, {
    Title = "Egg", Items = GameData.Eggs, SelectedKey = "Eggs", AutoBuyKey = "AutoBuyEgg",
    AutoBuyAllKey = "AutoBuyAllEgg", RemoteEvent = ReplicatedStorage.GameEvents.BuyPetEgg
})
CreateShopSection(Tabs.Shop, {
    Title = "Item", Items = GameData.Goliathshop, SelectedKey = "Items", AutoBuyKey = "AutoBuyItem",
    AutoBuyAllKey = "AutoBuyAllItem", RemoteEvent = ReplicatedStorage.GameEvents.BuyEventShopStock
})
Tabs.Shop:AddToggle("OpenGoliathShop", {Title="Open Goliath Shop", Default=config.OpenGoliathShop}):OnChanged(function(v) config.OpenGoliathShop = v; SaveConfig(); lp.PlayerGui.EventShop_UI.Enabled = v end)

--[[ --- FARM TAB --- ]]
Tabs.Farm:AddParagraph({ Title = "Automatic Plant Seeds" })
Tabs.Farm:AddDropdown("Select Seed To Plant", {Title="Select Seed", Values=GameData.Seeds, Multi=true, Default=config.SeedToPlant}):OnChanged(function(v) config.SeedToPlant = v; SaveConfig() end)
Tabs.Farm:AddDropdown("Select Type Plant", {Title="Select Type Plant", Values={"Random", "Saved Position"}, Multi=false, Default=config.TypePlant}):OnChanged(function(v) config.TypePlant = v; SaveConfig() end)
local savedPosParagraph = Tabs.Farm:AddParagraph({ Title = "Saved Position", Content = config.PlayerPosition or "None" })
Tabs.Farm:AddButton({ Title = "Save Position", Callback = function()
    config.PlayerPosition = tostring(hrp.Position)
    savedPosParagraph:SetDesc(config.PlayerPosition)
    SaveConfig()
end})
Tabs.Farm:AddToggle("AutoPlant", {Title="Auto Plant", Default=config.AutoPlant}):OnChanged(function(v) config.AutoPlant = v; SaveConfig() end)

Tabs.Farm:AddParagraph({ Title = "Automatic Harvest Fruits" })
Tabs.Farm:AddDropdown("Select Fruit To Harvest", {Title="Select Fruit To Harvest", Values=GameData.Seeds, Multi=true, Default=config.FruitsToHarvest}):OnChanged(function(v) config.FruitsToHarvest = {}; for val,_ in pairs(v) do table.insert(config.FruitsToHarvest, val) end; SaveConfig() end)
Tabs.Farm:AddInput("DelayHarvest", {Title="Delay Harvest (s)", Default=tostring(config.DelayHarvest), Numeric=true, Finished=true, Callback=function(v) config.DelayHarvest = tonumber(v) or 0.2; SaveConfig() end})
Tabs.Farm:AddToggle("AutoHarvest", {Title="Auto Harvest", Default=config.AutoHarvest}):OnChanged(function(v) config.AutoHarvest = v; SaveConfig() end)

Tabs.Farm:AddParagraph({ Title = "Automatic Sell Fruits" })
Tabs.Farm:AddDropdown("Select Fruit", {Title="Select Fruit", Values=GameData.Seeds, Multi=true, Default=config.FruitsToSell}):OnChanged(function(v) config.FruitsToSell = {}; for val,_ in pairs(v) do table.insert(config.FruitsToSell,val) end; SaveConfig() end)
Tabs.Farm:AddInput("DelaySell", {Title="Delay Sell (s)", Default=tostring(config.DelaySell), Numeric=true, Finished=true, Callback=function(v) config.DelaySell = tonumber(v) or 0.2; SaveConfig() end})
Tabs.Farm:AddToggle("AutoSellFruit", {Title="Auto Sell Fruit", Default=config.AutoSellFruit}):OnChanged(function(v) config.AutoSellFruit = v; SaveConfig() end)
Tabs.Farm:AddToggle("AutoSellWhenMax", {Title="Sell only when inventory is full", Default=config.AutoSellWhenMax}):OnChanged(function(v) config.AutoSellWhenMax = v; SaveConfig() end)

--[[ --- PLAYER TAB --- ]]
Tabs.Player:AddInput("Speed", {Title="Speed", Default=tostring(config.SpeedValue), Numeric=true, Finished=true, Callback=function(v)
    config.SpeedValue = tonumber(v) or 20; SaveConfig(); if config.Speed then humanoid.WalkSpeed = config.SpeedValue end
end})
Tabs.Player:AddToggle("SpeedToggle", {Title="Speed", Default=config.Speed}):OnChanged(function(v)
    config.Speed = v; SaveConfig(); humanoid.WalkSpeed = v and config.SpeedValue or 20
end)
Tabs.Player:AddToggle("InfinityJump", {Title="Infinity Jump", Default=config.InfinityJump}):OnChanged(function(v) config.InfinityJump = v; SaveConfig() end)
local noclipConnection
Tabs.Player:AddToggle("NoClip", {Title="No Clip", Default=config.NoClip}):OnChanged(function(v)
    config.NoClip = v; SaveConfig()
    if v and not noclipConnection then
        noclipConnection = RunService.Stepped:Connect(function()
            for _, part in ipairs(character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end
        end)
    elseif not v and noclipConnection then
        noclipConnection:Disconnect(); noclipConnection = nil
    end
end)
Tabs.Player:AddButton({ Title = "Destroy Other Farms", Description = "Improve FPS", Callback = function() for _, farm in ipairs(workspace.Farm:GetChildren()) do if farm ~= GetMyFarm() then farm:Destroy() end end end})
Tabs.Player:AddButton({ Title = "Destroy Fences", Description = "Improve FPS", Callback = function() local myFarm = GetMyFarm() if myFarm then for _, child in ipairs(myFarm:GetDescendants()) do if child.Name == "Fences" then child:Destroy() end end end end})

--[[ --- BACKGROUND LOOPS --- ]]
-- Infinity Jump Handler
UserInputService.JumpRequest:Connect(function()
    if config.InfinityJump then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

--- CÁC VÒNG LẶP TỰ ĐỘNG ĐÃ ĐƯỢC CHUẨN HÓA ---
task.spawn(function()
    while true do
        if config.AutoHarvest and not isHarvesting then
            isHarvesting = true
            pcall(AutoCollect)
            isHarvesting = false
        end
        task.wait(0.1)
    end
end)

task.spawn(function()
    while true do
        if config.AutoPlant then
            local myFarm = GetMyFarm()
            if myFarm then
                local plantLocations = myFarm.Important:FindFirstChild("Plant_Locations")
                if plantLocations then
                    for _, seedName in pairs(config.SeedToPlant) do
                        local tool = EquipTool(seedName)
                        if tool then
                            if config.TypePlant == "Saved Position" and config.PlayerPosition then
                                local pos = Vector3.new(config.PlayerPosition:match("([^,]+), ([^,]+), ([^,]+)"))
                                ReplicatedStorage.GameEvents.Plant_RE:FireServer(pos, seedName)
                            else -- Random
                                local slots = plantLocations:GetChildren()
                                local randomSlot = slots[math.random(#slots)]
                                if randomSlot.Name == "Can_Plant" then
                                    local randomPoint = (randomSlot.CFrame * CFrame.new((math.random() - 0.5) * randomSlot.Size.X, 0, (math.random() - 0.5) * randomSlot.Size.Z)).Position
                                    ReplicatedStorage.GameEvents.Plant_RE:FireServer(randomPoint, seedName)
                                end
                            end
                            task.wait(0.1)
                        end
                    end
                end
            end
        end
        task.wait(0.1)
    end
end)

task.spawn(function()
    while true do
        local isInventoryFull = #backpack:GetChildren() >= 200
        if config.AutoSellFruit and (not config.AutoSellWhenMax or isInventoryFull) then
            local originalCFrame = hrp.CFrame
            hrp.CFrame = sellFruitLocation
            for _, tool in ipairs(backpack:GetChildren()) do
                if not config.AutoSellFruit then break end -- Stop if toggled off mid-sell
                if table.find(config.FruitsToSell, tool.Name:gsub(" Seed", "")) then
                    humanoid:EquipTool(tool)
                    ReplicatedStorage.GameEvents.Sell_Item:FireServer()
                    task.wait(config.DelaySell)
                end
            end
            hrp.CFrame = originalCFrame
        end
        task.wait(0.5) -- Check to sell every 0.5s
    end
end)
