repeat
    task.wait()
until game:IsLoaded()
    and game.Players.LocalPlayer
    and game.Players.LocalPlayer:FindFirstChild("DataLoaded")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")

local Player = Players.LocalPlayer
local CommF = ReplicatedStorage
    :WaitForChild("Remotes")
    :WaitForChild("CommF_")

local WorkerURL = "https://nf.quachlehuyy.workers.dev/notify"

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
        PlaceId = game.PlaceId,
        Player = Player.Name,
        Players = Players.NumPlayers .. "/" .. Players.MaxPlayers,
        ClockTime = clock,
        IsNight = clock >= 18 or clock < 6
    }
end

local function SendState(eventType, active, extra)
    local data = BaseData()

    data.Type = eventType
    data.Active = active

    if extra then
        for k, v in pairs(extra) do
            data[k] = v
        end
    end

    SendNotify(data)
end

local function FindMob(name)
    return Workspace.Enemies:FindFirstChild(name)
        or ReplicatedStorage:FindFirstChild(name)
end

local function HasRareBoss(name)
    return FindMob(name) ~= nil
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

local function HasMirage()
    return Workspace.Map:FindFirstChild("MysticIsland") ~= nil
end

local function HasPrehistoric()
    return Workspace.Map:FindFirstChild("PrehistoricIsland") ~= nil
end

-- Full Moon = ban đêm + texture 8/8
local function GetFullMoon()
    local sky = Lighting:FindFirstChild("Sky")

    if not sky then
        return false
    end

    local clock = Lighting.ClockTime
    local night = clock >= 18 or clock < 6
    local moonId = tostring(sky.MoonTextureId):match("%d+")

    return night and moonId == "9709149431"
end

local function GetBerry()
    for _, bush in ipairs(
        CollectionService:GetTagged("BerryBush")
    ) do
        for _, berry in pairs(
            bush:GetAttributes()
        ) do
            if (
                not BerryArray
                or table.find(BerryArray, berry)
            ) and (
                berry == "Red Cherry Berry"
                or berry == "White Cloud Berry"
                or berry == "Pink Pig Berry"
            ) then

                return berry
            end
        end
    end
end

task.spawn(function()
    while task.wait(1) do
        pcall(function()

            -- =========================
            -- HAKI
            -- =========================

            local haki = CommF:InvokeServer(
                "ColorsDealer",
                "1"
            )

            if haki and haki ~= LastHaki then
                LastHaki = haki

                SendState("Legendary", true, {
                    Haki = haki
                })
            end

            -- =========================
            -- RARE BOSS
            -- =========================

            for _, boss in ipairs(RareBosses) do
                local active = HasRareBoss(boss)
                local key = "Boss:" .. boss

                if active ~= LastState[key] then
                    LastState[key] = active

                    SendState("Rare Boss", active, {
                        ["Rare Boss"] = boss
                    })
                end
            end

            -- =========================
            -- MIRAGE
            -- =========================

            do
                local active = HasMirage()

                if active ~= LastState.Mirage then
                    LastState.Mirage = active

                    SendState("Mirage", active)
                end
            end

            -- =========================
            -- FULL MOON
            -- =========================

            do
                local active = GetFullMoon()

                if active ~= LastState.Moon then
                    LastState.Moon = active

                    SendState(
                        "Moon",
                        active,
                        {
                            MoonPhase =
                                active
                                and "Full Moon"
                                or "Normal"
                        }
                    )
                end
            end

            -- =========================
            -- PREHISTORIC
            -- =========================

            do
                local active = HasPrehistoric()

                if active ~= LastState.Prehistoric then
                    LastState.Prehistoric = active

                    SendState(
                        "Island",
                        active,
                        {
                            ["Prehistoric Island"] =
                                active
                        }
                    )
                end
            end

            -- =========================
            -- BERRY
            -- =========================

            do
                local berry = GetBerry()

                if berry then
                    local key = "Berry:" .. berry

                    if not LastState[key] then
                        LastState[key] = true

                        SendState(
                            "Berry",
                            true,
                            {
                                Berry = berry
                            }
                        )
                    end

                    -- reset berry cũ
                    for stateKey in pairs(LastState) do
                        if stateKey:sub(1, 6) == "Berry:"
                            and stateKey ~= key then

                            local oldBerry =
                                stateKey:sub(7)

                            LastState[stateKey] = nil

                            SendState(
                                "Berry",
                                false,
                                {
                                    Berry = oldBerry
                                }
                            )
                        end
                    end

                else
                    -- Không còn berry
                    for stateKey in pairs(LastState) do
                        if stateKey:sub(1, 6) == "Berry:" then
                            local oldBerry =
                                stateKey:sub(7)

                            LastState[stateKey] = nil

                            SendState(
                                "Berry",
                                false,
                                {
                                    Berry = oldBerry
                                }
                            )
                        end
                    end
                end
            end

            -- =========================
            -- CASTLE
            -- =========================

            do
                local active = HasCastle()

                if active ~= LastState.Castle then
                    LastState.Castle = active

                    SendState(
                        "Castle",
                        active
                    )
                end
            end
        end)
    end
end)
