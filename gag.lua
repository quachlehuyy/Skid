local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local backpack = lp:WaitForChild("Backpack")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local character = lp.Character or lp.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local configFileName = "gag_config.json"



-- Default config
local config = {
    Seeds = {},
    SeedToPlant = {},
    Gears = {},
    Eggs = {},
    Items = {},
    FruitsToHarvest = {},
    FruitsToSell = {},
    TypePlant = "Player Position",
    DelaySell = 0.2,
    DelayHarvest = 0.2,
    Speed = false,
    SpeedValue = 20,
    InfinityJump = false,
    NoClip = false,
    AutoBuySeed = false,
    AutoBuyAllSeed = false,
    AutoBuyGear = false,
    AutoBuyAllGear = false,
    AutoBuyEgg = false,
    AutoBuyAllEgg = false,
    AutoBuyItem = false,
    AutoPlant = false,
    AutoHarvest = false,
    AutoSellFruit = false,
    AutoSellWhenMax = false,
    OpenGardenGui = false,
    OpenGoliathShop = false,
}

-- Save & Load Config
local function SaveConfig()
    if isfile and writefile then
        writefile(configFileName, HttpService:JSONEncode(config))
    end
end

local function LoadConfig()
    if isfile and readfile and isfile(configFileName) then
        local data = readfile(configFileName)
        local decoded = HttpService:JSONDecode(data)
        for k, v in pairs(decoded) do
            config[k] = v
        end
    end
end

LoadConfig()

-- Game Data
local Seeds = { "All", "Carrot", "Strawberry", "Blueberry", "Orange Tulip", "Tomato", "Corn", "Daffodil", "Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut", "Cactus", "Dragon Fruit", "Mango", "Grape", "Mushroom", "Pepper", "Cacao", "Beanstalk", "Ember Lily", "Sugar Apple", "Buring Bud", "Giant Pinecone", "Elder Strawberry" }
local Gears = { "All", "Watering Can", "Trading Ticket", "Trowel", "Recall Wrench", "Basic Sprinkler", "Advanced Sprinkler", "Medium Toy", "Medium Treat", "Godly Sprinkler", "Magnifying Glass", "Master Sprinkler", "Cleaning Spray", "Favorite Tool", "Harvest Tool", "Friendship Pot", "Grandmaster Sprinkler", "Levelup Lollipop" }
local Eggs = { "All", "Common Egg", "Common Summer Egg", "Rare Summer Egg", "Mythical Egg", "Paradise Egg", "Bug Egg" }
local Goliathshop = { "Sprout Seed Pack", "Sprout Egg", "Mandrake", "Sprout Crate", "Silver Fertilizer", "Canary Melon", "Amberheart", "Spriggan" }

-- Runtime tables
local fruitharvest, fruitdachon, itemdachon, eggdachon, seeddachon, geardachon = {}, {}, {}, {}, {}, {}
local Seedtoplant = {}
local autosellfruit_running = false
local delaySellValue = config.DelaySell
local DelayHarvestValue = config.DelayHarvest
local sellfruit = CFrame.new(86.5854721, 2.76619363, 0.426784277, 0, 0, -1, 0, 1, 0, 1, 0, 0)
local speedchange = config.SpeedValue
local infinityJumpEnabled = config.InfinityJump
local connection

-- Helper functions
local function isInventoryFull()
    return #backpack:GetChildren() >= 200
end

local function GetMyFarm()
    for _, Farm in ipairs(workspace.Farm:GetChildren()) do
        local Important = Farm:FindFirstChild("Important")
        if Important then
            local Data = Important:FindFirstChild("Data")
            if Data then
                local Owner = Data:FindFirstChild("Owner")
                if Owner and Owner.Value == lp.Name then
                    return Farm
                end
            end
        end
    end
end

local function EquipTool(seed)
    local tool
    for _, t in pairs(backpack:GetChildren()) do
        if string.find(t.Name, seed) and string.find(t.Name, "Seed") then
            tool = t
            break
        end
    end
    if not tool then return nil end
    local currentTool = lp.Character:FindFirstChildWhichIsA("Tool")
    if currentTool then
        lp.Character.Humanoid:UnequipTools()
        task.wait(0.2)
    end
    lp.Character.Humanoid:EquipTool(tool)
    task.wait(0.2)
    return tool
end

-- Buy / Sell Functions
local function buyseed()
    for _, seed in ipairs(seeddachon) do
        if seed ~= "All" then
        ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuySeedStock"):FireServer(seed)
        end
    end
end

local function buyallseed()
    for _, seed in ipairs(Seeds) do
        if seed ~= "All" then
        ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuySeedStock"):FireServer(seed)
        end
    end
end

local function buygear()
    for _, gear in ipairs(geardachon) do
        ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer(gear)
    end
end

local function buyegg()
    for _, egg in ipairs(eggdachon) do
        ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuyPetEgg"):FireServer(egg)
    end
end

local function buygoliathshop()
    for _, item in ipairs(itemdachon) do
        ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuyEventShopStock"):FireServer(item)
    end
end

local function autosellfruit()
    if not autosellfruit_running then return end
    local originalCFrame = hrp.CFrame
    while true do
        local hasFruit = false
        for _, tool in pairs(backpack:GetChildren()) do
            for _, fruit in ipairs(fruitdachon) do
                if string.find(tool.Name, fruit) and not string.find(tool.Name, "Seed") then
                    hasFruit = true
                    lp.Character.Humanoid:EquipTool(tool)
                    task.wait(0.1)
                    hrp.CFrame = sellfruit
                    task.wait(delaySellValue)
                    ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("Sell_Item"):FireServer()
                    break
                end
            end
            if hasFruit then break end
        end
        if not hasFruit then break end
    end
    hrp.CFrame = originalCFrame
end

local function AutoCollect()
    local myfarm = GetMyFarm()
    if myfarm then
        local plantsPhysical = myfarm.Important:WaitForChild("Plants_Physical")
        for _, item in ipairs(fruitharvest) do
            for _, plant in ipairs(plantsPhysical:GetChildren()) do
                if plant.Name == item then
                    local prompt = plant:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if prompt and prompt.Enabled then
                        ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("Crops"):WaitForChild("Collect"):FireServer({plant})
                        task.wait(DelayHarvestValue)
                    end
                end
            end
        end
    end
end

local function GetRandomPointInSlot(slot)
    if not slot or not slot:IsA("BasePart") then return nil end
    local size = slot.Size
    local cf = slot.CFrame
    local offsetX = (math.random() - 0.5) * size.X
    local offsetZ = (math.random() - 0.5) * size.Z
    return (cf * CFrame.new(offsetX, 0, offsetZ)).Position
end

local function GetRandomPlantSlot()
    local myFarm = GetMyFarm()
    if myFarm then
        local vitriplant = myFarm.Important:FindFirstChild("Plant_Locations")
        if vitriplant then
            local slots = {}
            for _, v in ipairs(vitriplant:GetChildren()) do
                if v.Name == "Can_Plant" then
                    table.insert(slots, v)
                end
            end
            if #slots > 0 then
                return GetRandomPointInSlot(slots[math.random(1, #slots)])
            end
        end
    end
end

local function autoplant()
    for _, seed in ipairs(Seedtoplant) do
        local tool = lp.Character:FindFirstChildWhichIsA("Tool")
        if not tool or not string.find(tool.Name, seed) then
            tool = EquipTool(seed)
        end
        if tool then
            ReplicatedStorage.GameEvents.Plant_RE:FireServer(hrp.Position, seed)
        end
    end
end

local function autoplantrandom()
    for _, seed in ipairs(Seedtoplant) do
        local tool = lp.Character:FindFirstChildWhichIsA("Tool")
        if not tool or not string.find(tool.Name, seed) then
            tool = EquipTool(seed)
        end
        if tool then
            local randomSlot = GetRandomPlantSlot()
            if randomSlot then
                ReplicatedStorage.GameEvents.Plant_RE:FireServer(randomSlot, seed)
                task.wait(0.1)
            end
        end
    end
end

local function destroyOtherFarms()
    local myFarm = GetMyFarm()
    if not myFarm then return end
    for _, Farm in ipairs(workspace.Farm:GetChildren()) do
        if Farm ~= myFarm then
            Farm:Destroy()
        end
    end
end


local function destroyHangRao()
    local myFarm = GetMyFarm()
    if not myFarm then return end

    local trai = myFarm:FindFirstChild("CurrentExpansion") 
        and myFarm.CurrentExpansion:FindFirstChild("Left") 
        and myFarm.CurrentExpansion.Left:FindFirstChild("Fences")

    local phai = myFarm:FindFirstChild("CurrentExpansion") 
        and myFarm.CurrentExpansion:FindFirstChild("Right") 
        and myFarm.CurrentExpansion.Right:FindFirstChild("Fences")

    if trai then trai:Destroy() end
    if phai then phai:Destroy() end
end





-- UI Library
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "GAG Script",
    SubTitle = "by quachlehuy",
    TabWidth = 160,
    Size = UDim2.fromOffset(400, 450),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})
local Tabs = {
    Shop = Window:AddTab({ Title = "Shop", Icon = "" }),
    Farm = Window:AddTab({ Title = "Farm", Icon = "" }),
    Player = Window:AddTab({ Title = "Player", Icon = "" })
}
local Options = Fluent.Options

--[[ --- SHOP --- ]]--
-- Seeds
Tabs.Shop:AddDropdown("Select Seed", {Title="Select Seed", Values=Seeds, Multi=true, Default=config.Seeds}):OnChanged(function(Value)
    seeddachon = {}
    SeedToBuy = {}
    for val, _ in pairs(Value) do
        table.insert(seeddachon, val)
        table.insert(config.Seeds, val)
    end
    SaveConfig()
end)
Tabs.Shop:AddToggle("AutoBuySeed", {Title="Auto Buy Seed", Default=config.AutoBuySeed}):OnChanged(function(Value)
    config.AutoBuySeed = Value
    SaveConfig()
    task.spawn(function()
        while Options.AutoBuySeed.Value do
            if seeddachon and #seeddachon > 0 then buyseed() end
            task.wait(0.05)
        end
    end)
end)
Tabs.Shop:AddToggle("AutoBuyAllSeed", {Title="Auto Buy All Seed", Default=config.AutoBuySeed}):OnChanged(function(Value)
    config.AutoBuyAllSeed = Value
    SaveConfig()
    task.spawn(function()
        while Options.AutoBuyAllSeed.Value do
            if seeddachon and #seeddachon > 0 then buyallseed() end
            task.wait(0.05)
        end
    end)
end)
-- Gears
Tabs.Shop:AddDropdown("Select Gear", {Title="Select Gear", Values=Gears, Multi=true, Default=config.Gears}):OnChanged(function(Value)
    geardachon = {}
    for val, _ in pairs(Value) do table.insert(geardachon, val) end
    config.Gears = Value
    SaveConfig()
end)
Tabs.Shop:AddToggle("AutoBuyGear", {Title="Auto Buy Gear", Default=config.AutoBuyGear}):OnChanged(function(Value)
    config.AutoBuyGear = Value
    SaveConfig()
    task.spawn(function()
        while Options.AutoBuyGear.Value do
            if geardachon and #geardachon > 0 then buygear() end
            task.wait(0.05)
        end
    end)
end)

-- Eggs
Tabs.Shop:AddDropdown("Select Egg", {Title="Select Egg", Values=Eggs, Multi=true, Default=config.Eggs}):OnChanged(function(Value)
    eggdachon = {}
    for val, _ in pairs(Value) do table.insert(eggdachon, val) end
    config.Eggs = Value
    SaveConfig()
end)
Tabs.Shop:AddToggle("AutoBuyEgg", {Title="Auto Buy Egg", Default=config.AutoBuyEgg}):OnChanged(function(Value)
    config.AutoBuyEgg = Value
    SaveConfig()
    task.spawn(function()
        while Options.AutoBuyEgg.Value do
            if eggdachon and #eggdachon > 0 then buyegg() end
            task.wait(0.05)
        end
    end)
end)

-- Items
Tabs.Shop:AddDropdown("Select Item", {Title="Select Item", Values=Goliathshop, Multi=true, Default=config.Items}):OnChanged(function(Value)
    itemdachon = {}
    for val, _ in pairs(Value) do table.insert(itemdachon, val) end
    config.Items = Value
    SaveConfig()
end)
Tabs.Shop:AddToggle("AutoBuyItem", {Title="Auto Buy Item", Default=config.AutoBuyItem}):OnChanged(function(Value)
    config.AutoBuyItem = Value
    SaveConfig()
    task.spawn(function()
        while Options.AutoBuyItem.Value do
            if itemdachon and #itemdachon > 0 then buygoliathshop() end
            task.wait(0.05)
        end
    end)
end)


Tabs.Shop:AddToggle("OpenGoliathShop", {Title="Open Goliath Shop", Default=config.OpenGoliathShop}):OnChanged(function(Value)
    config.OpenGoliathShop = Value
    SaveConfig()
    task.spawn(function()
        while Options.OpenGoliathShop.Value do
            lp.PlayerGui.EventShop_UI.Enabled = true
            task.wait(1)
        end
        lp.PlayerGui.EventShop_UI.Enabled = false
    end)
end)

--[[ --- FARM --- ]]--

Tabs.Farm:AddParagraph({
    Title = "Automatic Plant Seeds",
    Content = "Auto Plant"
})


Tabs.Farm:AddDropdown("Select Seed To Plant", {Title="Select Seed", Values=Seeds, Multi=true, Default=config.SeedToPlant}):OnChanged(function(Value)
    Seedtoplant = {}
    for val, _ in pairs(Value) do
        table.insert(Seedtoplant, val)
    end
    config.SeedToPlant = Value
    SaveConfig()
end)
Tabs.Farm:AddDropdown("Select Type Plant", {Title="Select Type Plant", Values={"Player Position", "Random"}, Multi=false, Default=config.TypePlant}):OnChanged(function(Value)
    config.TypePlant = Value
    SaveConfig()
end)
Tabs.Farm:AddToggle("AutoPlant", {Title="Auto Plant", Default=config.AutoPlant}):OnChanged(function(Value)
    config.AutoPlant = Value
    SaveConfig()
    task.spawn(function()
        while Options.AutoPlant.Value do
            if config.TypePlant == "Player Position" then autoplant()
            else autoplantrandom() end
            task.wait(0.1)
        end
    end)
end)

Tabs.Farm:AddParagraph({
    Title = "Automatic Harvest Fruits",
    Content = "Auto Harvest"
})


Tabs.Farm:AddDropdown("Chon Fruit", {Title="Select Fruit To Harvest", Values=Seeds, Multi=true, Default=config.FruitsToHarvest}):OnChanged(function(Value)
    fruitharvest = {}
    for val,_ in pairs(Value) do table.insert(fruitharvest,val) end
    config.FruitsToHarvest = Value
    SaveConfig()
end)
Tabs.Farm:AddInput("DelayHarvest", {Title="Delay Harvest (seconds)", Default=tostring(config.DelayHarvest), Numeric=true, Finished=true, Callback=function(Value)
    local num = tonumber(Value)
    if num then
        DelayHarvestValue = num
        config.DelayHarvest = num
        SaveConfig()
    end
end})
Tabs.Farm:AddToggle("AutoHarvest", {Title="Auto Harvest", Default=config.AutoHarvest}):OnChanged(function(Value)
    config.AutoHarvest = Value
    SaveConfig()
    task.spawn(function()
        while Options.AutoHarvest.Value do
            AutoCollect()
            task.wait(0.02)
        end
    end)
end)


Tabs.Farm:AddParagraph({
    Title = "Automatic Sell Fruits",
    Content = "Auto Sell"
})


Tabs.Farm:AddDropdown("Select Fruit", {Title="Select Fruit", Values=Seeds, Multi=true, Default=config.FruitsToSell}):OnChanged(function(Value)
    fruitdachon = {}
    for val,_ in pairs(Value) do table.insert(fruitdachon,val) end
    config.FruitsToSell = Value
    SaveConfig()
end)
Tabs.Farm:AddInput("DelaySell", {Title="Delay Sell (seconds)", Default=tostring(config.DelaySell), Numeric=true, Finished=true, Callback=function(Value)
    local num = tonumber(Value)
    if num then
        delaySellValue = num
        config.DelaySell = num
        SaveConfig()
    end
end})
Tabs.Farm:AddToggle("AutoSellFruit", {Title="Auto Sell Fruit", Default=config.AutoSellFruit}):OnChanged(function(Value)
    config.AutoSellFruit = Value
    SaveConfig()
    autosellfruit_running = Value
    task.spawn(function()
        while autosellfruit_running do
            local shouldSell = Options.AutoSellFruit.Value and (Options.AutoSellWhenMax.Value and isInventoryFull() or true)
            if shouldSell then
                autosellfruit()
                task.wait(delaySellValue)
            else
                task.wait(0.1)
            end
        end
    end)
end)
Tabs.Farm:AddToggle("AutoSellWhenMax", {Title="Auto Sell When Max Inventory", Default=config.AutoSellWhenMax}):OnChanged(function(Value)
    config.AutoSellWhenMax = Value
    SaveConfig()
end)

--[[ --- PLAYER --- ]]--
Tabs.Player:AddInput("Speed", {Title="Speed", Default=tostring(config.SpeedValue), Numeric=true, Finished=true, Callback=function(Value)
    local num = tonumber(Value)
    if num then
        speedchange = num
        config.SpeedValue = num
        SaveConfig()
        if config.Speed then humanoid.WalkSpeed = speedchange end
    end
end})
Tabs.Player:AddToggle("SpeedToggle", {Title="Speed", Default=config.Speed}):OnChanged(function(Value)
    config.Speed = Value
    SaveConfig()
    humanoid.WalkSpeed = Value and speedchange or 20
end)
Tabs.Player:AddToggle("InfinityJump", {Title="Infinity Jump", Default=config.InfinityJump}):OnChanged(function(Value)
    config.InfinityJump = Value
    SaveConfig()
    infinityJumpEnabled = Value
end)
Tabs.Player:AddToggle("NoClip", {Title="No Clip", Default=config.NoClip}):OnChanged(function(Value)
    config.NoClip = Value
    SaveConfig()
    if Value then
        connection = RunService.Stepped:Connect(function()
            local character1 = lp.Character
            if character1 then
                for _, part in pairs(character1:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if connection then connection:Disconnect() connection = nil end
    end
end)

-- Infinity Jump
UserInputService.JumpRequest:Connect(function()
    if infinityJumpEnabled then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)


Tabs.Player:AddButton({
    Title = "Destroy Other Farm",
    Description = "Improve Fps",
    Callback = function()
    destroyOtherFarms()
end})



Tabs.Player:AddButton({
    Title = "Destroy Hang Rao",
    Description = "Improve Fps",
    Callback = function()
    destroyHangRao()
end})





local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ImageLabel = Instance.new("ImageLabel")
local UICorner = Instance.new("UICorner")
local TextButton = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")  
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.AnchorPoint = Vector2.new(0.1, 0.1)
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 0
Frame.BorderColor3 = Color3.fromRGB(27, 42, 53)
Frame.BorderSizePixel = 1
Frame.Position = UDim2.new(0, 20, 0.1, -6)  
Frame.Size = UDim2.new(0, 50, 0, 50)
Frame.Name = "dut dit"

ImageLabel.Parent = Frame
ImageLabel.Name = "Banana Test"
ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel.Size = UDim2.new(0, 40, 0, 40)
ImageLabel.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
ImageLabel.BackgroundTransparency = 1
ImageLabel.BorderSizePixel = 1
ImageLabel.BorderColor3 = Color3.fromRGB(27, 42, 53)
ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.Image = "http://www.roblox.com/asset/?id=5009915795"

UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = Frame

TextButton.Name = "TextButton"
TextButton.Parent = Frame
TextButton.AnchorPoint = Vector2.new(0, 0)
TextButton.Position = UDim2.new(0, 0, 0, 0)
TextButton.Size = UDim2.new(1, 0, 1, 0)
TextButton.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
TextButton.BackgroundTransparency = 1
TextButton.BorderSizePixel = 1
TextButton.BorderColor3 = Color3.fromRGB(27, 42, 53)
TextButton.TextColor3 = Color3.fromRGB(27, 42, 53)
TextButton.Text = ""
TextButton.Font = Enum.Font.SourceSans
TextButton.TextSize = 8
TextButton.TextTransparency = 0

local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local zoomedIn = false
local originalSize = UDim2.new(0, 40, 0, 40)
local zoomedSize = UDim2.new(0, 30, 0, 30)
local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local faded = false
local fadeInTween = TweenService:Create(Frame, tweenInfo, {BackgroundTransparency = 0.25})
local fadeOutTween = TweenService:Create(Frame, tweenInfo, {BackgroundTransparency = 0})

TextButton.MouseButton1Down:Connect(function()

    if zoomedIn then
        TweenService:Create(ImageLabel, tweenInfo, {Size = originalSize}):Play()
    else
        TweenService:Create(ImageLabel, tweenInfo, {Size = zoomedSize}):Play()
    end
    zoomedIn = not zoomedIn

    if faded then
        fadeOutTween:Play()
    else
        fadeInTween:Play()
    end
    faded = not faded

    VirtualInputManager:SendKeyEvent(true, "LeftControl", false, game)
end)
