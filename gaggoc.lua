local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local backpack = lp:WaitForChild("Backpack")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local character = lp.Character or lp.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- // Config
local configFileName = "gag_config.json"
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
    PlayerPosition = nil,
    InfinityJump = false,
    NoClip = false,
    AutoBuySeed = false,
    AutoBuyAllSeed = false,
    AutoBuyAllGear = false,
    AutoBuyAllEgg = false,
    AutoBuyGear = false,
    AutoBuyEgg = false,
    AutoBuyItem = false,
    AutoPlant = false,
    AutoHarvest = false,
    AutoSellFruit = false,
    AutoSellWhenMax = false,
    AutoSellInventory = false,
    OpenGardenGui = false,
    OpenGoliathShop = false,
}

-- // Save + Load
local function SaveConfig()
    if isfile and writefile then
        writefile(configFileName, HttpService:JSONEncode(config))
    end
end
local function LoadConfig()
    if isfile and readfile and isfile(configFileName) then
        local decoded = HttpService:JSONDecode(readfile(configFileName))
        for k, v in pairs(decoded) do config[k] = v end
    end
end
LoadConfig()

-- // Game Data
local Seeds = { "Carrot","Strawberry","Blueberry","Orange Tulip","Tomato","Corn","Daffodil","Watermelon","Pumpkin","Apple","Bamboo","Coconut","Cactus","Dragon Fruit","Mango","Grape","Mushroom","Pepper","Cacao","Beanstalk","Ember Lily","Sugar Apple","Buring Bud","Giant Pinecone","Elder Strawberry" }
local Gears = { "Watering Can","Trading Ticket","Trowel","Recall Wrench","Basic Sprinkler","Advanced Sprinkler","Medium Toy","Medium Treat","Godly Sprinkler","Magnifying Glass","Master Sprinkler","Cleaning Spray","Favorite Tool","Harvest Tool","Friendship Pot","Grandmaster Sprinkler","Levelup Lollipop" }
local Eggs = { "Common Egg","Common Summer Egg","Rare Summer Egg","Mythical Egg","Paradise Egg","Bug Egg" }
local Goliathshop = { "Sprout Seed Pack","Sprout Egg","Mandrake","Sprout Crate","Silver Fertilizer","Canary Melon","Amberheart","Spriggan" }

-- // Runtime Vars
local seeddachon, geardachon, eggdachon, itemdachon, fruitharvest, fruitdachon = {}, {}, {}, {}, {}, {}
local autosellfruit_running = false
local delaySellValue, DelayHarvestValue = config.DelaySell, config.DelayHarvest
local sellfruit = CFrame.new(86.58,2.76,0.42,0,0,-1,0,1,0,1,0,0)

-- // Helpers
local function isInventoryFull() return #backpack:GetChildren() >= 200 end
local function GetMyFarm()
    for _, f in ipairs(workspace.Farm:GetChildren()) do
        local data = f:FindFirstChild("Important") and f.Important:FindFirstChild("Data")
        if data and data:FindFirstChild("Owner") and data.Owner.Value == lp.Name then return f end
    end
end
local function EquipTool(seed)
    local tool
    for _, t in pairs(backpack:GetChildren()) do
        if t.Name:find(seed) and t.Name:find("Seed") then tool = t break end
    end
    if not tool then return nil end
    local cur = lp.Character:FindFirstChildWhichIsA("Tool")
    if cur then humanoid:UnequipTools() task.wait(0.1) end
    humanoid:EquipTool(tool) task.wait(0.1)
    return tool
end

-- // Shop
local function buyseed() for _, s in ipairs(seeddachon) do ReplicatedStorage.GameEvents.BuySeedStock:FireServer(s) end end
local function buyallseed() for _, s in ipairs(Seeds) do ReplicatedStorage.GameEvents.BuySeedStock:FireServer(s) task.wait(0.01) end end
local function buygear() for _, g in ipairs(geardachon) do ReplicatedStorage.GameEvents.BuyGearStock:FireServer(g) end end
local function buyallgear() for _, g in ipairs(Gears) do ReplicatedStorage.GameEvents.BuyGearStock:FireServer(g) task.wait(0.01) end end
local function buyegg() for _, e in ipairs(eggdachon) do ReplicatedStorage.GameEvents.BuyPetEgg:FireServer(e) end end
local function buyallegg() for _, e in ipairs(Eggs) do ReplicatedStorage.GameEvents.BuyPetEgg:FireServer(e) task.wait(0.01) end end
local function buygoliathshop() for _, i in ipairs(itemdachon) do ReplicatedStorage.GameEvents.BuyEventShopStock:FireServer(i) end end


-- // Plant
function autoplant()
    local myfarm=GetMyFarm() if not myfarm then return end
    local land=myfarm.Important:FindFirstChild("Land") if not land then return end
    for _, s in ipairs(seeddachon) do
        local tool=EquipTool(s) if tool then
            for _,plot in ipairs(land:GetChildren()) do
                if not Options.AutoPlant.Value then return end
                if plot:IsA("BasePart") then
                    ReplicatedStorage.GameEvents.Crops.Plant:FireServer(plot)
                    task.wait(0.1)
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
                local chosen = slots[math.random(1, #slots)]
                return GetRandomPointInSlot(chosen), chosen
            end
        end
    end
end


function autoplantrandom()
    local pos, slot = GetRandomPlantSlot()
    if not pos or not slot then return end
    for _, seed in ipairs(seeddachon) do
        if not Options.AutoPlant.Value then return end
        local tool = EquipTool(seed)
        if tool then
            ReplicatedStorage.GameEvents.Crops.Plant:FireServer(slot)
            task.wait(0.2)
        end
    end
end


function AutoCollect()
    local myfarm=GetMyFarm() if not myfarm then return end
    local plants=myfarm.Important:FindFirstChild("Plants_Physical") if not plants then return end
    local harvestSet={} for _,f in ipairs(fruitharvest) do harvestSet[f]=true end
    for _,plant in ipairs(plants:GetDescendants()) do
        if not Options.AutoHarvest.Value then return end
        if harvestSet[plant.Name] then
            local prompt=plant:FindFirstChildWhichIsA("ProximityPrompt",true)
            if prompt and prompt.Enabled then
                ReplicatedStorage.GameEvents.Crops.Collect:FireServer({plant})
                task.wait(DelayHarvestValue)
            end
        end
    end
end



-- // Sell
local function autosellfruit()
    if not autosellfruit_running then return end
    local originalCFrame = hrp.CFrame
    while Options.AutoSellFruit.Value do
        if not Options.AutoSellFruit.Value then break end
        local sold = false
        for _, tool in pairs(backpack:GetChildren()) do
            for _, f in ipairs(fruitdachon) do
                if tool.Name:find(f) and not tool.Name:find("Seed") then
                    humanoid:EquipTool(tool) task.wait(0.1)
                    hrp.CFrame = sellfruit task.wait(delaySellValue)
                    ReplicatedStorage.GameEvents.Sell_Item:FireServer()
                    sold = true break
                end
            end
            if sold then break end
        end
        if not sold then break end
    end
    hrp.CFrame = originalCFrame
end


local function sellallinventory()
    if not isInventoryFull() then return end
    local original = hrp.CFrame
    hrp.CFrame = sellfruit
    ReplicatedStorage.GameEvents.Sell_Inventory:FireServer()
    task.wait(0.2) hrp.CFrame = original
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

local Options = Fluent.Options

Tabs.Shop:AddToggle("AutoBuySeed",{Title="Auto Buy Seed",Default=config.AutoBuySeed})
:OnChanged(function(v)
    config.AutoBuySeed=v SaveConfig()
    task.spawn(function()
        while Options.AutoBuySeed.Value do
            if not Options.AutoBuySeed.Value then break end
            if #seeddachon>0 then buyseed() end
            task.wait(0.05)
        end
    end)
end)

Tabs.Shop:AddToggle("AutoBuyAllSeed",{Title="Auto Buy All Seed",Default=config.AutoBuyAllSeed})
:OnChanged(function(v)
    config.AutoBuyAllSeed=v SaveConfig()
    task.spawn(function()
        while Options.AutoBuyAllSeed.Value do
            if not Options.AutoBuyAllSeed.Value then break end
            buyallseed()
            task.wait(0.05)
        end
    end)
end)

Tabs.Shop:AddToggle("AutoBuyGear",{Title="Auto Buy Gear",Default=config.AutoBuyGear})
:OnChanged(function(v)
    config.AutoBuyGear=v SaveConfig()
    task.spawn(function()
        while Options.AutoBuyGear.Value do
            if not Options.AutoBuyGear.Value then break end
            if #geardachon>0 then buygear() end
            task.wait(0.05)
        end
    end)
end)

Tabs.Shop:AddToggle("AutoBuyAllGear",{Title="Auto Buy All Gear",Default=config.AutoBuyAllGear})
:OnChanged(function(v)
    config.AutoBuyAllGear=v SaveConfig()
    task.spawn(function()
        while Options.AutoBuyAllGear.Value do
            if not Options.AutoBuyAllGear.Value then break end
            buyallgear()
            task.wait(0.05)
        end
    end)
end)

Tabs.Shop:AddToggle("AutoBuyEgg",{Title="Auto Buy Egg",Default=config.AutoBuyEgg})
:OnChanged(function(v)
    config.AutoBuyEgg=v SaveConfig()
    task.spawn(function()
        while Options.AutoBuyEgg.Value do
            if not Options.AutoBuyEgg.Value then break end
            if #eggdachon>0 then buyegg() end
            task.wait(0.05)
        end
    end)
end)

Tabs.Shop:AddToggle("AutoBuyAllEgg",{Title="Auto Buy All Egg",Default=config.AutoBuyAllEgg})
:OnChanged(function(v)
    config.AutoBuyAllEgg=v SaveConfig()
    task.spawn(function()
        while Options.AutoBuyAllEgg.Value do
            if not Options.AutoBuyAllEgg.Value then break end
            buyallegg()
            task.wait(0.05)
        end
    end)
end)

Tabs.Shop:AddToggle("AutoBuyItem",{Title="Auto Buy Goliath Shop Item",Default=config.AutoBuyItem})
:OnChanged(function(v)
    config.AutoBuyItem=v SaveConfig()
    task.spawn(function()
        while Options.AutoBuyItem.Value do
            if not Options.AutoBuyItem.Value then break end
            if #itemdachon>0 then buygoliathshop() end
            task.wait(0.05)
        end
    end)
end)

-- Farm

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

Tabs.Farm:AddDropdown("TypePlant",{Title="Plant Type",Values={"Save Position","Random Position","Random Slot"},Default=config.TypePlant,Multi=false})
:OnChanged(function(v) config.TypePlant=v SaveConfig() end)

Tabs.Farm:AddToggle("AutoPlant",{Title="Auto Plant",Default=config.AutoPlant})
:OnChanged(function(v)
    config.AutoPlant=v SaveConfig()
    task.spawn(function()
        while Options.AutoPlant.Value do
            if not Options.AutoPlant.Value then break end
            if config.TypePlant=="Save Position" then
                autoplant()
            elseif config.TypePlant=="Random Position" then
                autoplantrandom()
            elseif config.TypePlant=="Random Slot" then
                autoplantrandom_slot()
            end
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

Tabs.Farm:AddToggle("AutoHarvest",{Title="Auto Harvest",Default=config.AutoHarvest})
:OnChanged(function(v)
    config.AutoHarvest=v SaveConfig()
    task.spawn(function()
        while Options.AutoHarvest.Value do
            if not Options.AutoHarvest.Value then break end
            AutoCollect()
            task.wait(0.1)
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

-- Auto Sell Fruit
Tabs.Farm:AddToggle("AutoSellFruit", {
    Title="Auto Sell Fruit", 
    Default=config.AutoSellFruit
}):OnChanged(function(Value)
    config.AutoSellFruit = Value
    SaveConfig()
    task.spawn(function()
        while Options.AutoSellFruit.Value do
            if not Options.AutoSellFruit.Value then break end

            if (not Options.AutoSellWhenMax.Value) or isInventoryFull() then
                autosellfruit()
                task.wait(delaySellValue)
            else
                task.wait(0.1) 
            end
        end
    end)
end)

Tabs.Farm:AddToggle("AutoSellWhenMax", {
    Title="Only Sell When Inventory Full", 
    Default=config.AutoSellWhenMax
}):OnChanged(function(Value)
    config.AutoSellWhenMax = Value
    SaveConfig()
end)

 --- PLAYER --- ]]--
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
