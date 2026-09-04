repeat
    task.wait()
until game:IsLoaded()
    and game.Players.LocalPlayer
    and game.Players.LocalPlayer:FindFirstChild("DataLoaded")

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local CollectionService = game:GetService("CollectionService")

local Player = Players.LocalPlayer
local CommF = ReplicatedStorage
    :WaitForChild("Remotes")
    :WaitForChild("CommF_")

local WorkerURL = "https://YOUR-WORKER.workers.dev/notify"

local RareBosses = {
    "rip_indra True Form",
    "Dough King",
    "Cake Prince",
    "Soul Reaper",
    "Cursed Captain"
}

local LastState = {}
local LastHaki

local function SendNotify(data)
    task.spawn(function()
        pcall(function()
            request({
                Url = WorkerURL,
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
        Players = Players.NumPlayers .. "/" .. Players.MaxPlayers,
        PlaceId = game.PlaceId,
        ClockTime = clock,
        IsNight = clock >= 18 or clock < 5
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

-- =========================================================
-- GIỮ NGUYÊN CÁC FUNC CHECK
-- =========================================================

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

-- =========================================================
-- EVENT LOOP
-- =========================================================

task.spawn(function()
    while task.wait(1) do
        pcall(function()

            -- =================================================
            -- HAKI
            -- =================================================

            local haki = CommF:InvokeServer(
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

            -- =================================================
            -- RARE BOSS
            -- =================================================

            for _, boss in ipairs(RareBosses) do
                local active = HasRareBoss(boss)
                local key = "Boss:" .. boss

                if active ~= LastState[key] then
                    LastState[key] = active

                    SendEvent(
                        "Rare Boss",
                        active,
                        {
                            ["Rare Boss"] = boss
                        }
                    )
                end
            end

            -- =================================================
            -- PREHISTORIC
            -- =================================================

            do
                local active = HasPrehistoric()

                if active ~= LastState.Prehistoric then
                    LastState.Prehistoric = active

                    SendEvent(
                        "Island",
                        active,
                        {
                            ["Prehistoric Island"] = active
                        }
                    )
                end
            end

            -- =================================================
            -- MIRAGE
            -- =================================================

            if SeaIndex == 3 then
                local active = GetMirage()

                if active ~= LastState.Mirage then
                    LastState.Mirage = active

                    SendEvent(
                        "Mirage",
                        active,
                        {
                            Mirage = active
                        }
                    )
                end
            end

            -- =================================================
            -- FULL MOON
            -- =================================================

            do
                local moon = GetFullMoon()
                local active = moon == "Full Moon"

                if active ~= LastState.Moon then
                    LastState.Moon = active

                    SendEvent(
                        "Moon",
                        active,
                        {
                            MoonPhase = moon
                        }
                    )
                end
            end

            -- =================================================
            -- ELITE
            -- =================================================

            do
                local elite = GetElite()
                local currentEliteKey =
                    elite and ("Elite:" .. elite)

                -- Elite mới xuất hiện
                if elite
                    and not LastState[currentEliteKey] then

                    LastState[currentEliteKey] = true

                    SendEvent(
                        "Elite",
                        true,
                        {
                            Elite = elite
                        }
                    )
                end

                -- Elite cũ biến mất
                for key, state in pairs(LastState) do
                    if state
                        and key:sub(1, 6) == "Elite:"
                        and key ~= currentEliteKey then

                        local oldElite = key:sub(7)

                        LastState[key] = nil

                        SendEvent(
                            "Elite",
                            false,
                            {
                                Elite = oldElite
                            }
                        )
                    end
                end
            end

            -- =================================================
            -- BERRY
            -- =================================================

            if SeaIndex == 3 then
                local berry = GetBerry()
                local currentBerryKey =
                    berry and ("Berry:" .. berry)

                -- Berry mới xuất hiện
                if berry
                    and not LastState[currentBerryKey] then

                    LastState[currentBerryKey] = true

                    SendEvent(
                        "Berry",
                        true,
                        {
                            Berry = berry
                        }
                    )
                end

                -- Berry cũ biến mất / đổi loại
                for key, state in pairs(LastState) do
                    if state
                        and key:sub(1, 6) == "Berry:"
                        and key ~= currentBerryKey then

                        local oldBerry = key:sub(7)

                        LastState[key] = nil

                        SendEvent(
                            "Berry",
                            false,
                            {
                                Berry = oldBerry
                            }
                        )
                    end
                end
            end


            if SeaIndex == 3 then
                local active = HasCastle()

                if active ~= LastState.Castle then
                    LastState.Castle = active

                    SendEvent(
                        "Castle",
                        active
                    )
                end
            end
        end)
    end
end)
