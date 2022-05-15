local function service(...) return game:GetService(...) end

--Main
local runser = game:GetService("RunService")
local lplr = game.Players.LocalPlayer
local mouse = lplr:GetMouse()
local plrs = game:GetService("Players")
local uis = game:GetService("UserInputService")
local bhop = false
local mouse = game.Players.LocalPlayer:GetMouse()

local LegitAimbotBool = false
local LegitAimAt

-- Services
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = service("Players")
local MarketplaceService = service("MarketplaceService")
local ReplicatedStorage = service("ReplicatedStorage")
local HttpService = service("HttpService")

-- Environment 
local getrawmetatable = getrawmetatable or false
local mousemove = mousemove or mousemoverel or mouse_move or false
local getsenv = getsenv or false
local listfiles = listfiles or listdir or syn_io_listdir or false
local isfolder = isfolder or false
local hookfunc = hookfunc or hookfunction or replaceclosure or false

if (getrawmetatable == false) then return game.Players.LocalPlayer:Kick("Exploit not supported!") end
if (mousemove == false) then return game.Players.LocalPlayer:Kick("Exploit not supported!") end
if (getsenv == false) then return game.Players.LocalPlayer:Kick("Exploit not supported!") end
if (listfiles == false) then return game.Players.LocalPlayer:Kick("Exploit not supported!") end
if (isfolder == false) then return game.Players.LocalPlayer:Kick("Exploit not supported!") end
if (hookfunc == false) then return game.Players.LocalPlayer:Kick("Exploit not supported!") end

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pawel12d/hexagon/main/scripts/ESP.lua"))()

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local GameName = "Kaoru Hub Free: " .. MarketplaceService:GetProductInfo(game.PlaceId).Name
local Window = OrionLib:MakeWindow({Name = GameName, SaveConfig = true, ConfigFolder = GameName})

local Main = Window:MakeTab({
	Name = "ESP",
	Icon = "rbxassetid://8945416692",
	PremiumOnly = false
})

-- Functions
local function RandomString(length, strings)
	local strings = strings or {
		"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
		"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
		"0","1","2","3","4","5","6","7","8","9",
	}
	local output = ""
	for i = 1,length do
		output = tostring(output..""..strings[math.random(1,#strings)])
		if i == length then
			return output
		end
	end
end

local function IsAlive(plr)
	if plr and plr.Character and plr.Character.FindFirstChild(plr.Character, "Humanoid") and plr.Character.Humanoid.Health > 0 then
		return true
	end

	return false
end

local function IsVisible(pos, ignoreList)
	return #workspace.CurrentCamera:GetPartsObscuringTarget({LocalPlayer.Character.Head.Position, pos}, ignoreList) == 0 and true or false
end

local function GetTeam(plr)
	return game.Teams[plr.Team.Name]
end

Main:AddToggle({
	Name = "Enabled",
	Default = false,
	Callback = function(val)
        ESP.Enabled = val
    end
})

Main:AddToggle({
	Name = "Info",
	Default = false,
	Callback = function(val)
	    ESP.ShowInfo = val
    end
})

Main:AddToggle({
	Name = "Tracers",
	Default = false,
	Callback = function(val)
	    ESP.Tracers = val
    end
})

Main:AddToggle({
	Name = "Boxes",
	Default = false,
	Callback = function(val)
        ESP.Boxes = val
    end
})

Main:AddToggle({
	Name = "Show Team",
	Default = false,
	Callback = function(val)
        ESP.ShowTeam = val
    end
})

Main:AddToggle({
	Name = "Use Team Color",
	Default = false,
	Callback = function(val)
        ESP.UseTeamColor = val
    end
})

Main:AddColorpicker({
    Name = "Team Color",
    Default = Color3.new(0,1,0),
    Callback = function(val)
        ESP.TeamColor = val
    end	  
})

Main:AddColorpicker({
    Name = "Enemy Color",
    Default = Color3.new(1,0,0),
    Callback = function(val)
        ESP.EnemyColor = val
    end	  
})

OrionLib:Init()

--[[
Main:AddToggle({
	Name = "Info Settings: Name",
	Default = false,
	Callback = function(val)
        ESP.Info.Name = (table.find(val, "Name") and true) or false
    end
})

Main:AddToggle({
	Name = "Info Settings: Health",
	Default = false,
	Callback = function(val)
        ESP.Info.Health = (table.find(val, "Health") and true) or false
    end
})

Main:AddToggle({
	Name = "Info Settings: Weapons",
	Default = false,
	Callback = function(val)
        ESP.Info.Weapons = (table.find(val, "Weapons") and true) or false
    end
})

Main:AddToggle({
	Name = "Info Settings: Distance",
	Default = false,
	Callback = function(val)
        ESP.Info.Distance = (table.find(val, "Distance") and true) or false
    end
})
]]