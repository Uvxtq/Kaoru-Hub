---@diagnostic disable: undefined-global


local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Weapon Fighting Simulator", SaveConfig = true, ConfigFolder = "Weapon Fighting Simulator"})

local Main = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://8945416692",
	PremiumOnly = false
})

local LocalPlayer = Window:MakeTab({
	Name = "LocalPlayer",
	Icon = "rbxassetid://8945470040",
	PremiumOnly = false
})

local Egg = Window:MakeTab({
	Name = "Egg",
	Icon = "rbxassetid://8945455556",
	PremiumOnly = false
})

local Teleport = Window:MakeTab({
	Name = "Teleport",
	Icon = "rbxassetid://8945517811",
	PremiumOnly = false
})

local Extra = Window:MakeTab({
	Name = "Extra",
	Icon = "rbxassetid://8950218710",
	PremiumOnly = false
})

local Discord = Window:MakeTab({
	Name = "Discord",
	Icon = "rbxassetid://8950218710",
	PremiumOnly = false
})

--[[
local function eggs()
    eggs = {}
    for i,v in pairs(wrk.Fight["FightArea_1_300"].Gamble:GetChildren()) do
        if v:IsA("Part") and not table.find(eggs,v.Name) then
            table.insert(eggs,v.Name)
        end
    end
    return eggs
end
]]

local ts = game:GetService("TweenService")
local hum = game.Players.LocalPlayer.Character.HumanoidRootPart
local plr = game:GetService("Players").LocalPlayer
local rep = game:GetService("ReplicatedStorage")
local wrk = game:GetService("Workspace")
local rs = game:GetService("RunService")
local vu = game:GetService("VirtualUser")

pcall(function()
	for i,v in pairs(getconnections(plr.Idled)) do
		v:Disable()
	end
end)

Extra:AddToggle({
	Name = "Auto Spin Weel",
	Default = false,
	Callback = function()
    getgenv().spin = not getgenv().spin;
    while (getgenv().spin and wait(5)) do
        spinn = {1, 2, 3, 4, 5};
        for i,v in pairs(spinn) do
            rep.CommonLibrary.Tool.RemoteManager.Funcs.DataPullFunc:InvokeServer("WheelRollChannel",v)
        end
    end
end;
})

Main:AddToggle({
	Name = "Auto Farm 'Nearest' HP (Recommended)",
	Default = false,
	Callback = function(v)
        _G.Farm = v
        local plsr = hum
        -- // Gets the nearest thing
        function getNear()
            local near;
            local nearr = math.huge
        
            for i, v in pairs(wrk.Fight.ClientChests:GetChildren()) do
                if (plrs.Position - v.Root.Position).Magnitude < nearr then
                    near = v
                    nearr = (plrs.Position - v.Root.Position).Magnitude
                end
            end
            return near
        end
        -- // Attacks and tps to it
        while task.wait() do
            if not _G.Farm then break end;
        pcall(function()
            local nearest = getNear()
            
            plrs.CFrame = nearest.Root.CFrame * CFrame.new(0,0,10)
            wait(.2)

            workspace.Fight.Events.FightAttack:InvokeServer(0,nearest.Name)   
            
            repeat task.wait()
                plrs.CFrame = nearest.Root.CFrame * CFrame.new(0,0,10)
            until nearest.Root == nil or not _G.Farm
        end)
    end
end;
})

Main:AddToggle({
	Name = "Auto Farm 'Highest' HP",
	Default = false,
	Callback = function(v)
    _G.Farm = v
    local plrs = hum
    function getHighest()
        local high = {}
        for i, v in pairs(wrk.Fight.Chests:GetChildren()) do
            for a, b in pairs(wrk.Fight.ClientChests:GetChildren()) do
                if v.Name == b.Name then
                    table.insert(high,v.ChestHp.Value)
                    table.sort(high, function(a,b) return a > b end)
                end
            end
        end

        for a, b in pairs(wrk.Fight.Chests:GetChildren()) do
            if high[1] == b.ChestHp.Value then
                return b.Name
            end
        end    
    end
    while task.wait() do
        if not _G.Farm then break end
        pcall(function()
            local highest = getHighest()

            plrs.CFrame = wrk.Fight.ClientChests[highest].Root.CFrame * CFrame.new(0,0,10)
            wait(.2)

            workspace.Fight.Events.FightAttack:InvokeServer(0,highest)

            repeat task.wait()
                    plrs.CFrame = wrk.Fight.ClientChests[highest].Root.CFrame * CFrame.new(0,0,10)
            until not wrk.Fight.ClientChests[highest] or not _G.Farm
        end)
    end
end;
})

Main:AddToggle({
	Name = "Auto Farm 'Lowest' HP",
	Default = false,
	Callback = function(v)
    _G.Farm = v
    local plrs = hum
    function getLowest()
        local low = {}
        for i, v in pairs(wrk.Fight.Chests:GetChildren()) do
            for a, b in pairs(wrk.Fight.ClientChests:GetChildren()) do
                if v.Name == b.Name then
                    table.insert(low,v.ChestHp.Value)
                    table.sort(low, function(a,b) return a < b end)
                end
            end
        end
        for a, b in pairs(wrk.Fight.Chests:GetChildren()) do
            if low[1] == b.ChestHp.Value then
                return b.Name
            end
        end    
    end
    while task.wait() do
        if not _G.Farm then break end
        pcall(function()
            local lowest = getLowest()

            plrs.CFrame = wrk.Fight.ClientChests[lowest].Root.CFrame * CFrame.new(0,0,10)
                wait(.2)

            workspace.Fight.Events.FightAttack:InvokeServer(0,lowest)

            repeat task.wait()
                    plrs.CFrame = wrk.Fight.ClientChests[lowest].Root.CFrame * CFrame.new(0,0,10)
            until not wrk.Fight.ClientChests[lowest] or not _G.Farm
        end)
    end
end;
})

Main:AddButton({
	Name = "Auto Fight Against Boss (Only Toggle this when you are in a boss arena)",
	Callback = function(v)
        _G.Farm = v
        local plrs = hum
        -- // Gets the nearest thing
        function getNear()
            local near;
            local nearr = 500
        
            for i, v in pairs(wrk.Fight.ClientChests:GetChildren()) do
                if (plrs.Position - v.Root.Position).Magnitude < nearr then
                    near = v
                    nearr = (plr.Position - v.Root.Position).Magnitude
                end
            end
            return near
        end
        -- // Attacks and tps to it
        pcall(function()
            local nearest = getNear()
            
            plrs.CFrame = nearest.Root.CFrame * CFrame.new(0,35,10)
            wait(.2)

            workspace.Fight.Events.FightAttack:InvokeServer(0,nearest.Name)
            
        repeat task.wait()
            plrs.CFrame = nearest.Root.CFrame * CFrame.new(0,35,10)
        until nearest.Root == nil or not _G.Farm
    end)
end;
})

Main:AddToggle({
	Name = "Auto Collect",
	Default = false,
	Callback = function()
        getgenv().collect = not getgenv().collect
        local plrs = hum
        while (getgenv().collect and wait(0.1)) do
        for i, v in pairs(wrk.Rewards:GetChildren()) do
            if v ~= nil then
                v.CFrame = plrs.CFrame
            end
        end
    end
end;
})

Main:AddToggle({
	Name = "Auto Equip Best",
	Default = false,
	Callback = function()
    getgenv().best = not getgenv().best
    while (getgenv().best and wait(15)) do
        local ohString1 = "ArtifactUnequipAllChannel"
        rep.CommonLibrary.Tool.RemoteManager.Funcs.DataPullFunc:InvokeServer(ohString1)
    wait()
        local ohString1 = "ArtifactEquipBestsChannel"
        rep.CommonLibrary.Tool.RemoteManager.Funcs.DataPullFunc:InvokeServer(ohString1)
    end
end;
})
--[[
Egg:AddDropdown({
	Name = "Select the zone you want to tp to",
	Default = "Select a zone...",
	Options = eggs(),
	Callback = function(arg)
		_G.Egg = arg
	end   
})

Egg:AddToggle({
	Name = "Auto Buy Pets",
	Default = false,
	Callback = function(v)
    _G.Farm = v
    
    if not _G.Farm then return end;

    local plrs = hum

    plrs.CFrame = wrk.Fight["FightArea_1_300"].Gamble[_G.Egg].CFrame * CFrame.new(5,5,0)
    wait(0.5)
    pcall(function()
        while wait() do
            if not _G.Farm then break end;
            plrs.CFrame = wrk.Fight["FightArea_1_300"].Gamble[_G.Egg].CFrame * CFrame.new(5,5,0)
            keypress(0x45)
            keyrelease(0x45)
        end
    end)
end;
})
]]
Teleport:AddButton({
	Name = "Teleport GUI",
	Callback = function()
    myplaye = hum;
    myplaye.CFrame = CFrame.new(0.00299099996, 316.210327, 57.6519775, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end;
})

Teleport:AddButton({
	Name = "Teleport To Inner Soul",
	Callback = function()
    myplaye = hum;
    myplaye.CFrame = CFrame.new(59.6230011, 243.141983, 143.257965, -1, 0, 0, 0, 1, 0, 0, 0, -1)
end;
})

LocalPlayer:AddSlider({
	Name = "WalkSpeed",
	Min = 16,
	Max = 500,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "WalkSpeed",
	Callback = function(s)
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
})

LocalPlayer:AddSlider({
	Name = "Jump Power",
	Min = 50,
	Max = 500,
	Default = 50,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Jump Power",
	Callback = function(j)
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
})

Discord:AddButton({
	Name = "Join Our Discord Server",
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
})

Extra:AddButton({
	Name = "Make Rainbow CoreGui",
	Callback = function()
    local h,changecolors,seperatechangecolors = 0,{},{}
    function add(a)
        table.insert(changecolors,a)
    end
    function remove(a)
        for i,v in pairs(changecolors) do
            if v == a then 
                table.remove(changecolors,i)
            end
        end
    end
    game:GetService("CoreGui").RobloxGui.SettingsShield.SettingsShield.MenuContainer.BottomButtonFrame.DescendantAdded:Connect(add)
    game:GetService("CoreGui").RobloxGui.SettingsShield.SettingsShield.MenuContainer.BottomButtonFrame.DescendantRemoving:Connect(remove)
    game:GetService("CoreGui").RobloxGui.SettingsShield.SettingsShield.MenuContainer.HubBar.DescendantAdded:Connect(add)
    game:GetService("CoreGui").RobloxGui.SettingsShield.SettingsShield.MenuContainer.HubBar.DescendantRemoving:Connect(remove)
    game:GetService("CoreGui").RobloxGui.SettingsShield.SettingsShield.MenuContainer.PageViewClipper.DescendantAdded:Connect(function(a)
        table.insert(seperatechangecolors,a)
    end)
    game:GetService("CoreGui").RobloxGui.SettingsShield.SettingsShield.MenuContainer.PageViewClipper.DescendantRemoving:Connect(function(a)
        for i,v in pairs(seperatechangecolors) do
            if v == a then
                table.remove(seperatechangecolors,i)
            end
        end
    end)
    for i,v in pairs(game:GetService("CoreGui").RobloxGui.SettingsShield.SettingsShield.MenuContainer.PageViewClipper:GetDescendants()) do
        table.insert(seperatechangecolors,v)
    end
    for i,v in pairs(game:GetService("CoreGui").RobloxGui.SettingsShield.SettingsShield.MenuContainer.HubBar:GetDescendants()) do
        add(v)
    end
    for i,v in pairs(game:GetService("CoreGui").RobloxGui.SettingsShield.SettingsShield.MenuContainer.BottomButtonFrame:GetDescendants()) do
        add(v)
    end
    game:GetService("RunService").RenderStepped:Connect(function()
        h = h + 0.001
        if h > 1 then
            h = h - 1
        end
        for _,inst in pairs(seperatechangecolors) do
            pcall(function() inst.TextColor3 = Color3.fromHSV(h,1,1) end)
            pcall(function() inst.ImageColor3 = Color3.fromHSV(h,1,1) end)
        end
        for _,inst in pairs(changecolors) do
            pcall(function() inst.TextColor3 = Color3.fromHSV(h,1,1) end)
            pcall(function() inst.ImageColor3 = Color3.fromHSV(h,1,1) end)
            pcall(function() inst.BackgroundColor3 = Color3.fromHSV(h,1,1) end)
        end
    end)
end;
})