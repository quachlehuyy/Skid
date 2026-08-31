local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local CollectionService = game:GetService("CollectionService")

local Player = Players.LocalPlayer
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local CommF = Remotes:WaitForChild("CommF_")

local WORKER_URL = "https://nf.quachlehuyy.workers.dev/notify"

local RareBosses = {
    "rip_indra True Form",
    "Dough King",
    "Soul Reaper"
}

local LastHaki
local LastMoon = 0
local LastStates = {}

local function SendNotify(data)
    task.spawn(function()
        pcall(function()
            request({
                Url = WORKER_URL,
                Method = "POST",

                Headers = {
                    ["Content-Type"] = "application/json"
                },

                Body = HttpService:JSONEncode(data)
            })
        end)
    end)
end

local function BaseData()
    local clock = math.floor(Lighting.ClockTime)

    return {
        JobId = game.JobId,
        Player = Player.Name,

        Players =
            Players.NumPlayers
            .. "/"
            .. Players.MaxPlayers,

        PlaceId = game.PlaceId,
        ClockTime = clock,

        IsNight =
            clock >= 18
            or clock < 5
    }
end

local function SendEvent(eventType, active, extra)
    local data = BaseData()

    data.Type = eventType
    data.Active = active

    if extra then
        for key, value in pairs(extra) do
            data[key] = value
        end
    end

    SendNotify(data)
end

local function GetFullMoon()
    local phase = Lighting:GetAttribute("MoonPhase")
    local clock = math.floor(Lighting.ClockTime)

    if phase == 5 and (clock >= 12 or clock < 5) then
        return "Full Moon"
    end

    if phase == 4 then
        return "Next Night"
    end

    return "Bad Moon"
end

local function GetMirage()
    return Workspace.Map:FindFirstChild("MysticIsland") ~= nil
end

local function GetElite()
    local main = Player.PlayerGui:FindFirstChild("Main")
    local quest = main and main:FindFirstChild("Quest")

    if not quest or not quest.Visible then
        return nil
    end

    local container = quest:FindFirstChild("Container")
    local questTitle = container
        and container:FindFirstChild("QuestTitle")

    local title = questTitle
        and questTitle:FindFirstChild("Title")

    if not title then
        return nil
    end

    local text = title.Text

    if not (
        text:find("Diablo")
        or text:find("Urban")
        or text:find("Deandre")
    ) then
        return nil
    end

    for _, v in ipairs(ReplicatedStorage:GetChildren()) do
        if v.Name:find("Diablo")
            or v.Name:find("Urban")
            or v.Name:find("Deandre") then

            return v.Name
        end
    end
end

local function HasCastle()
    local origin = Vector3.new(-5000, 350, -3035)

    for _, folder in ipairs({
        Workspace.Enemies,
        ReplicatedStorage
    }) do
        for _, v in ipairs(folder:GetChildren()) do
            if v:IsA("Model")
                and v.Name ~= "Blank Buddy"
                and (v:GetPivot().Position - origin).Magnitude <= 3000 then

                return true
            end
        end
    end

    return false
end

local function HasPrehistoric()
    return Workspace.Map:FindFirstChild("PrehistoricIsland") ~= nil
end

local function HasRareBoss(name)
    for _, folder in ipairs({
        ReplicatedStorage,
        Workspace.Enemies,
        Workspace._WorldOrigin.EnemySpawns
    }) do
        for _, v in ipairs(folder:GetChildren()) do
            if v.Name:find(name) then
                return true
            end
        end
    end

    return false
end

local function GetBerry()
    for _, bush in ipairs(
        CollectionService:GetTagged("BerryBush")
    ) do
        for _, berryName in pairs(
            bush:GetAttributes()
        ) do
            if (
                not BerryArray
                or table.find(BerryArray, berryName)
            ) and (
                berryName == "Red Cherry Berry"
                or berryName == "White Cloud Berry"
                or berryName == "Pink Pig Berry"
            ) then
                return berryName
            end
        end
    end
end

task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local moon = GetFullMoon()
            local mirage = GetMirage()
            local prehistoric = HasPrehistoric()

            --------------------------------------------------
            -- HAKI
            --------------------------------------------------

            local haki =
                CommF:InvokeServer(
                    "ColorsDealer",
                    "1"
                )

            if haki and haki ~= LastHaki then
                LastHaki = haki

                SendEvent(
                    "Legendary",
                    true,
                    {
                        Haki = haki
                    }
                )
            elseif not haki then
                LastHaki = nil
            end

            --------------------------------------------------
            -- RARE BOSS
            --------------------------------------------------

            for _, boss in ipairs(RareBosses) do
                local found = HasRareBoss(boss)
                local stateKey = "Boss:" .. boss

                if found then
                    if LastStates[stateKey] ~= true then
                        LastStates[stateKey] = true

                        SendEvent(
                            "Rare Boss",
                            true,
                            {
                                ["Rare Boss"] = boss
                            }
                        )
                    end
                elseif LastStates[stateKey] then
                    LastStates[stateKey] = false

                    SendEvent(
                        "Rare Boss",
                        false,
                        {
                            ["Rare Boss"] = boss
                        }
                    )
                end
            end

            --------------------------------------------------
            -- PREHISTORIC
            --------------------------------------------------

            if prehistoric then
                if LastStates.Prehistoric ~= true then
                    LastStates.Prehistoric = true

                    SendEvent(
                        "Island",
                        true,
                        {
                            ["Prehistoric Island"] = true
                        }
                    )
                end
            elseif LastStates.Prehistoric then
                LastStates.Prehistoric = false

                SendEvent(
                    "Island",
                    false
                )
            end

            --------------------------------------------------
            -- MIRAGE
            --------------------------------------------------

            if SeaIndex == 3 then
                if mirage then
                    if LastStates.Mirage ~= true then
                        LastStates.Mirage = true

                        SendEvent(
                            "Mirage",
                            true,
                            {
                                Mirage = true
                            }
                        )
                    end
                elseif LastStates.Mirage then
                    LastStates.Mirage = false

                    SendEvent(
                        "Mirage",
                        false
                    )
                end
            end

            --------------------------------------------------
            -- FULL MOON
            --------------------------------------------------

            local moonActive = moon == "Full Moon"

            if moonActive then
                if not LastStates.Moon then
                    LastStates.Moon = true

                    if os.time() - LastMoon >= 1 then
                        LastMoon = os.time()

                        SendEvent(
                            "Moon",
                            true,
                            {
                                MoonPhase = moon
                            }
                        )
                    end
                end
            elseif LastStates.Moon then
                LastStates.Moon = false

                SendEvent(
                    "Moon",
                    false,
                    {
                        MoonPhase = moon
                    }
                )
            end

            --------------------------------------------------
            -- ELITE
            --------------------------------------------------

            local elite = GetElite()

            if elite then
                local stateKey = "Elite:" .. elite

                if not LastStates[stateKey] then
                    LastStates[stateKey] = true

                    SendEvent(
                        "Elite",
                        true,
                        {
                            Elite = elite
                        }
                    )
                end
            end

            --------------------------------------------------
            -- BERRY
            --------------------------------------------------

            if SeaIndex == 3 then
                local berry = GetBerry()

                if berry then
                    local stateKey = "Berry:" .. berry

                    if not LastStates[stateKey] then
                        LastStates[stateKey] = true

                        SendEvent(
                            "Berry",
                            true,
                            {
                                Berry = berry
                            }
                        )
                    end
                end
            end

            --------------------------------------------------
            -- CASTLE
            --------------------------------------------------

            if SeaIndex == 3 then
                local castle = HasCastle()

                if castle then
                    if not LastStates.Castle then
                        LastStates.Castle = true

                        SendEvent(
                            "Castle",
                            true
                        )
                    end
                elseif LastStates.Castle then
                    LastStates.Castle = false

                    SendEvent(
                        "Castle",
                        false
                    )
                end
            end
        end)
    end
end)
