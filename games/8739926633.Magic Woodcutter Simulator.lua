
-- // WAITS FOR GAME TO BE LOADED THEN EXECUTES

repeat wait() until game:IsLoaded()

-- // MERCURY LOADSTRING

local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/Uvxtq/lua/main/Updated%20UI%20Library.lua"))()

-- // GUI
local GUI = Mercury:Create{
    Name = "Kaoru Hub",
    Size = UDim2.fromOffset(600, 400),
    Theme = Mercury.Themes.Dark,
    Link = "https://raw.githubusercontent.com/Uvxtq/lua/main/games/Anime%20Battle%20Tycoon.lua"
}

-- // TABS
local Main = GUI:Tab{
	Name = "Main",
	Icon = "rbxassetid://8945416692"
}
 
local Egg = GUI:Tab{
	Name = "Egg",
	Icon = "rbxassetid://8945455556"
}

local LocalPlayer = GUI:Tab{
	Name = "LocalPlayer",
	Icon = "rbxassetid://8945470040"
}

local Teleport = GUI:Tab{
	Name = "Teleport",
	Icon = "rbxassetid://8945517811"
}

local Extra = GUI:Tab{
	Name = "Extra",
	Icon = "rbxassetid://8950218710"
}

Main:button{
	Name = "Open Shop GUI",
	StartingState = false,
	Description = nil,
	Callback = function()
    for _,v in pairs(game:GetService("Workspace").Map["Upgrade_Part"]:GetDescendants()) do
        if v:IsA("TouchTransmitter") then
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
        wait()
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
        end
    end
end;
}

Extra:Toggle{
	Name = "Auto Claim Daily Rewards",
	StartingState = false,
	Description = nil,
	Callback = function()
    getgenv().daily = not getgenv().daily
    while (getgenv().daily and wait()) do
        for _,v in pairs(game:GetService("Workspace").Map["DailyReward_Part"]:GetDescendants()) do
            if v:IsA("TouchTransmitter") then
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
            wait()
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
            end
        end
    end
end;
}

Main:Toggle{
	Name = "Auto Farm",
	StartingState = false,
	Description = nil,
	Callback = function()
        getgenv().farmer = not getgenv().farmer
        while (getgenv().farmer and wait()) do
            local player = game.Players.LocalPlayer
            local nearest = nil
            for i,v in pairs(game:GetService("Workspace").TargetStorage:GetDescendants()) do
                if v:IsA("ClickDetector") then
                    if nearest == nil or (player.Character:WaitForChild("HumanoidRootPart").Position - v.TargetPos.Value).Magnitude < (player.Character:WaitForChild("HumanoidRootPart").Position - nearest.Value).Magnitude then
                        nearest = v.TargetPos
                    end
                end
            end
        fireclickdetector(nearest.Parent) 
        repeat wait() until not v or not getgenv().farmer
        wait(0.5)
    end
end
}

Main:Toggle{
	Name = "Auto Sell",
	StartingState = false,
	Description = nil,
	Callback = function()
    getgenv().sell = not getgenv().sell
    while (getgenv().sell and wait()) do
        for _,v in pairs(game:GetService("Workspace").Map["Sell_Part"]:GetDescendants()) do
            if v:IsA("TouchTransmitter") then
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
            wait()
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
            end
        end
    end
end 
}

Main:Toggle{
	Name = "Auto Buy Upgrades",
	StartingState = false,
	Description = nil,
	Callback = function()
    getgenv().upgrades = not getgenv().upgrades
    while (getgenv().upgrades and wait()) do
    upgrades = {"Rank_Upgrade_Request", "Capacity_Upgrade_Request", };
        for i,v in pairs(upgrades) do
            local args = {[1] = {[1] = v}}
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
        end
    end
end 
}

Main:Toggle{
	Name = "Auto Unlock Islands",
	StartingState = false,
	Description = nil,
	Callback = function()
        getgenv().unlock = not getgenv().unlock
        while (getgenv().unlock and wait()) do
        local args = {[1] = {[1] = "UnlockMapStage_Request",[2] = 10}}
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
    end
end
}

-- // SLIDERS
LocalPlayer:Slider{
	Name = "WalkSpeed",
	Default = 16, -- // DEFAULT WALKSPEED YOU START WITH
	Min = 16, -- // MIN WALKSPEED YOU CAN SET
	Max = 500, -- // MAX WALKSPEED YOU CAN SET
	Callback = function(s) -- // THE CALLBACK FUNCTION 
        local gmt = getrawmetatable(game)
        setreadonly(gmt, false)
        local oldindex = gmt.__index
        gmt.__index = newcclosure(function(self,s)
            if s == "WalkSpeed" then
                return 16
            end
            return oldindex(self,s)
        end)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
        setreadonly(gmt, true)
    end
}

LocalPlayer:Slider{
	Name = "JumpPower",
	Default = 50, -- // DEFAULT JUMPPOWER YOU START WITH
	Min = 50, -- // MIN JUMPPOWER YOU CAN SET
	Max = 500, -- // MAX JUMPPOWER YOU CAN SET
	Callback = function(j) -- // THE CALLBACK FUNCTION
        local gmt = getrawmetatable(game)
        setreadonly(gmt, false)
        local oldindex = gmt.__index
        gmt.__index = newcclosure(function(self,j)
            if j == "JumpPower" then
                return 50
            end
            return oldindex(self,j)
        end)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = j
        setreadonly(gmt, true)
    end
}

tele = {"Start_Map_1_Portal", "Start_Map_2_Portal", "Start_Map_3_Portal", "Start_Map_4_Portal",
"Start_Map_5_Portal", "Start_Map_6_Portal", "Start_Map_7_Portal", "Start_Map_8_Portal",
"Start_Map_9_Portal", "Start_Map_10_Portal"}
for _,v in pairs(tele) do
    if not table.find(tele,v.Name) then
        table.insert(tele,v.Name)
    end
end

_G.Tele = "False"
local MyDropdown = Teleport:Dropdown{
    Name = "Select what world you want to teleport...",
    StartingText = "Select...",
    Description = nil,
    Items = tele,
    Callback = function(arg)
        _G.Tele = arg
    end
}

Teleport:button{
	Name = "Teleport To Selected World",
	StartingState = false,
	Description = nil,
	Callback = function()
    for _,v in pairs(game:GetService("Workspace").Map.Portals[_G.Tele]:GetDescendants()) do
        if v:IsA("TouchTransmitter") then
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
        wait()
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
        end
    end
end
}

Teleport:button{
	Name = "Teleport To Spawn",
	StartingState = false,
	Description = nil,
	Callback = function()
    local Cframe = game.Players.LocalPlayer.Character.HumanoidRootPart
    Cframe.CFrame = CFrame.new(367.915863, 209.387207, 648.329773, 0.77303499, -0, -0.634363413, 0, 1, -0, 0.634363413, 0, 0.77303499)
end
}

-- // NOTIFICATIONS
GUI:Notification{
	Title = "Press Right Ctrl to hide the script", -- // THE NOTIFICATION TITLE
	Text = "Please give me a thumbs up on script blox!", -- // THE NOTIFICATION TEXT
	Duration = 7, -- // HOW LONG THE NOTIFICATION LASTS FOR
	Callback = function() -- // THE CALLBACK FUNCTION
        -- // CALLBACK FUNCTION (ANTI-AFK)
        local vu = game:GetService("VirtualUser") -- // GETS YOUR LOCAL VIRTUALUSER
        game:GetService("Players").LocalPlayer.Idled:connect(function() -- // FINDS AND GETS THE IDLED CONNECTIONS
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) -- // MOVES YOUR CAMERA DOWN
                wait(1) -- // WAITS 1 SECOND
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame) -- // MOVES YOUR CAMERA UP
        end)
    end
}

-- // CREDITS 
GUI:Credit{
	Name = "Kaoru~",
	Description = "Im working really hard on these scripts. Please support them!",
	V3rm = nil,
	Discord = "Kaoru~#0069"
}

Extra:Button{
	Name = "Join Our Discord Server",
	Description = nil,
	Callback = function()
        local Settings = {
            InviteCode = "zkvPrg89jD" --add your invite code here (without the "https://discord.gg/" part)
        }
        
        -- Objects
        local HttpService = game:GetService("HttpService")
        local RequestFunction
        
        if syn and syn.request then
            RequestFunction = syn.request
        elseif request then
            RequestFunction = request
        elseif http and http.request then
            RequestFunction = http.request
        elseif http_request then
            RequestFunction = http_request
        end
        
        local DiscordApiUrl = "http://127.0.0.1:%s/rpc?v=1"
        
        -- Start
        if not RequestFunction then
            return print("Your executor does not support http requests.")
        end
        
        for i = 6453, 6464 do
            local DiscordInviteRequest = function()
                local Request = RequestFunction({
                    Url = string.format(DiscordApiUrl, tostring(i)),
                    Method = "POST",
                    Body = HttpService:JSONEncode({
                        nonce = HttpService:GenerateGUID(false),
                        args = {
                            invite = {code = Settings.InviteCode},
                            code = Settings.InviteCode
                        },
                        cmd = "INVITE_BROWSER"
                    }),
                    Headers = {
                        ["Origin"] = "https://discord.com",
                        ["Content-Type"] = "application/json"
                    }
                })
            end
            spawn(DiscordInviteRequest)
        end
    end
}
