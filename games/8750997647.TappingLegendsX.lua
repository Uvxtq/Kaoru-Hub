local function service(...) return game:GetService(...) end

--[[Services]]--
local Players = service("Players")
local LocalPlayer = Players["LocalPlayer"]
local Workspace = service("Workspace")
local Character = game.Players.LocalPlayer.Character
local Humanoid = game.Players.LocalPlayer.Character.Humanoid
local HumanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
local JumpPower = service("JumpPower")
local WalkSpeed = service("WalkSpeed")
local MarketplaceService = service("MarketplaceService")
local ReplicatedStorage = service("ReplicatedStorage")
local HttpService = service("HttpService")
local VirtualUser = service("VirtualUser")
local RunService = service("RunService")
local TweenService = service("TweenService")
local GameName = MarketplaceService:GetProductInfo(game.PlaceId).Name

pcall(function()
	for i,v in pairs(getconnections(Players.Idled)) do
		v:Disable()
	end
end)

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Kaoru Hub: " .. GameName})

local Main = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://8945416692",
})

local Eggs = Window:MakeTab({
	Name = "Eggs",
	Icon = "rbxassetid://8945455556",
})

local LocalPlayer = Window:MakeTab({
	Name = "LocalPlayer",
	Icon = "rbxassetid://8945470040",
})

local Credits = Window:MakeTab({
	Name = "Credits",
	Icon = "rbxassetid://8950218710",
})

local Discord = Window:MakeTab({
	Name = "Discord",
	Icon = "rbxassetid://8950218710",
})

Main:AddToggle({
    Name = "Auto Clicker",
    Callback = function()
        _G.Clicker = not _G.Clicker
        while (_G.Clicker and wait()) do
            ReplicatedStorage.Remotes.Tap:FireServer()
        end
    end
})

local function getEggs()
    local Eggs = {}
        for _, v in next, Workspace.Eggs:GetChildren() do
            table.insert(Eggs, v.Name)
        end
    return Eggs
end
--[[
Eggs:AddDropdown({
	Name = "Select the Egg you want to Auto",
	Default = "Select an egg...",
	Options = getEggs(),
	Callback = function(arg)
		_G.Egg = arg
	end    
})
]]
Eggs:AddToggle({
    Name = "Auto Egg [1]",
    Callback = function()
        _G.AutoEgg = not _G.AutoEgg
        while (_G.AutoEgg and wait(0.1)) do
            ReplicatedStorage.Remotes.BuyEgg:InvokeServer(_G.Egg, 1)
        end
    end
})

Eggs:AddToggle({
    Name = "Auto Egg [3]",
    Callback = function()
        _G.AutoEgg = not _G.AutoEgg
        while (_G.AutoEgg and wait(0.1)) do
            ReplicatedStorage.Remotes.BuyEgg:InvokeServer(_G.Egg, 3)
        end
    end
})

local function HttpsError()
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Error!",
		Text = "Your executer does not support HTTPS. Please download Krnl (Free), Script-Ware (Paid; 20$), or SynapseX (Paid, 20$).",
		Duration = 10,
		Callback = nil,
		Button1 = "Okay.",
	})
end

local function discordMain()
    local Settings = {
        InviteCode = "zkvPrg89jD" --add your invite code here (without the "https://discord.gg/" part)
    }
    
    -- Objects
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
        return HttpsError()
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

local Executer_Check = 
is_sirhurt_closure and "Sirhurt" or 
pebc_execute and "ProtoSmasher" or 
syn and "Synapse X" or 
secure_load and "Sentinel" or
KRNL_LOADED and "Krnl" or
identifyexecutor() and "ScriptWare" or
"Possible unsupported executer"

local function Synapse()
	OrionLib:MakeNotification({
        Name = "Hello!",
        Content = "You are using Synapse!, this is the best executer to use this script with..., have fun!",
        Time = 10
    })
end

local function Sentinel()
	OrionLib:MakeNotification({
        Name = "Hello!",
        Content = "You are using Sentinel!, this is a supported executer..., have fun!",
        Time = 10
    })
end

local function Krnl()
	OrionLib:MakeNotification({
        Name = "Hello!",
        Content = "You are using Krnl!, this is a supported executer..., have fun!",
        Time = 10
    })
end

local function ScriptWare()
	OrionLib:MakeNotification({
        Name = "Hello!",
        Content = "You are using ScriptWare!, this is a supported executer..., have fun!",
        Time = 10
    })
end

local function Sirhurt()
	OrionLib:MakeNotification({
        Name = "Hello!",
        Content = "You are using Sirhurt!, this is a supported executer..., have fun!",
        Time = 10
    })
end

local function ProtoSmasher()
	OrionLib:MakeNotification({
        Name = "Hello!",
        Content = "You are using ProtoSmasher!, this is a supported executer..., have fun!",
        Time = 10
    })
end

local function PUSE()
	OrionLib:MakeNotification({
        Name = "Hello!",
        Content = "You are using a unsupported executer, that could mean you cant join the discord, so we've copied it to your clipboard..., have fun!",
        Time = 10
    })
	setclipboard("https://discord.gg/zkvPrg89jD")
end

pcall(function()
	if syn and "Synapse X" then
		Synapse()
	elseif secure_load and "Sentinel" then
		Sentinel()
	elseif KRNL_LOADED and "Krnl" then
		Krnl()
	elseif identifyexecutor() and "ScriptWare" then
		ScriptWare()
	elseif is_sirhurt_closure and "Sirhurt" then
		Sirhurt()
	elseif pebc_execute and "ProtoSmasher" then
		ProtoSmasher()
	elseif Executer_Check == "Possible unsupported executer" then
		PUSE()
	end
end)

if game.CoreGui:FindFirstChild("Tapping Legends X") then
	OrionLib:MakeNotification({
        Name = "Success!",
        Content = "The script has been successfully Re-Executed, If there are any errors please report them to the discord.",
        Time = 5
    })
else
	Instance.new("ScreenGui",game.CoreGui).Name = "Tapping Legends X"
	OrionLib:MakeNotification({
        Name = "Success!",
        Content = "The script has been successfully Executed, If there are any errors please report them to the discord.",
        Time = 5
    })
end

local function DiscordNotification()
    OrionLib:MakeNotification({
        Name = "Info...",
        Content = "Joining Discord Server..!",
        Time = 2.5
    })
end

Discord:AddButton({
	Name = "Join Our Discord Server",
	Callback = function()
        DiscordNotification()
        wait(1)
        discordMain()
    end
})

OrionLib:Init()