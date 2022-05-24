print("Report any bugs errors you see to the discord")
local function service(...) return game:GetService(...) end

local Hint = Instance.new("Hint", game.CoreGui)
Hint.Text = "KaoruHub Is Waiting for the game to load..."

repeat wait() until game:IsLoaded()
repeat wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("GUI")

Hint.Text = "KaoruHub Is Setting up environment..."

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

--Main
local SilentLegitbot = {target = nil}
local SilentRagebot = {target = nil, cooldown = false}
local LocalPlayer = game.Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local cbClient = getsenv(LocalPlayer.PlayerGui:WaitForChild("Client"))
local oldInventory = cbClient.CurrentInventory
local nocw_s = {}
local nocw_m = {}
local curVel = 16
local isBhopping = false

-- Viewmodels fix
for i,v in pairs(game.ReplicatedStorage.Viewmodels:GetChildren()) do
    if v:FindFirstChild("HumanoidRootPart") and v.HumanoidRootPart.Transparency ~= 1 then
        v.HumanoidRootPart.Transparency = 1
    end
end

game.ReplicatedStorage.Viewmodels["v_oldM4A1-S"].Silencer.Transparency = 1
local fix = game.ReplicatedStorage.Viewmodels["v_oldM4A1-S"].Silencer:Clone()
fix.Parent = game.ReplicatedStorage.Viewmodels["v_oldM4A1-S"]
fix.Name = "Silencer2"
fix.Transparency = 0

local Hitboxes = {
	["Head"] = {"Head"},
	["Chest"] = {"UpperTorso", "LowerTorso"},
	["Arms"] = {"LeftUpperArm", "LeftLowerArm", "LeftHand", "RightUpperArm", "RightLowerArm", "RightHand"},
	["Legs"] = {"LeftUpperLeg", "LeftLowerLeg", "LeftFoot", "RightUpperLeg", "RightLowerLeg", "RightFoot"}
}
local oldOsPlatform = game.Players.LocalPlayer.OsPlatform
local oldMusicT = game.Players.LocalPlayer.PlayerGui.Music.ValveT:Clone()
local oldMusicCT = game.Players.LocalPlayer.PlayerGui.Music.ValveCT:Clone()

local Weapons = {}; for i,v in pairs(game.ReplicatedStorage.Weapons:GetChildren()) do if v:FindFirstChild("Model") then table.insert(Weapons, v.Name) end end

local Sounds = {
	["TTT a"] = workspace.RoundEnd,
	["TTT b"] = workspace.RoundStart,
	["T Win"] = workspace.Sounds.T,
	["CT Win"] = workspace.Sounds.CT,
	["Planted"] = workspace.Sounds.Arm,
	["Defused"] = workspace.Sounds.Defuse,
	["Rescued"] = workspace.Sounds.Rescue,
	["Explosion"] = workspace.Sounds.Explosion,
	["Becky"] = workspace.Sounds.Becky,
	["Beep"] = workspace.Sounds.Beep
}

local FOVCircle = Drawing.new("Circle")

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pawel12d/hexagon/main/scripts/ESP.lua"))()

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local GameName = "Kaoru Hub Free: " .. MarketplaceService:GetProductInfo(game.PlaceId).Name
local Window = OrionLib:MakeWindow({Name = GameName, SaveConfig = true, ConfigFolder = GameName})

local Main = Window:MakeTab({
	Name = "ESP",
	Icon = "rbxassetid://8945416692",
	PremiumOnly = false
})

local Aimbot = Window:MakeTab({
	Name = "Aimbot",
	Icon = "rbxassetid://8945416692",
	PremiumOnly = false
})

local Visuals = Window:MakeTab({
	Name = "Visuals",
	Icon = "rbxassetid://8945416692",
	PremiumOnly = false
})

Hint.Text = "KaoruHub Is Now Loading..."

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

local function TableToNames(tbl, alt)
	local otp = {}
	if alt then
		for i,v in pairs(tbl) do
			table.insert(otp, v.weaponname)
		end
	else
		for i,v in pairs(tbl) do
			table.insert(otp, i)
		end
	end
	return otp
end

--[[
local function CharacterAdded()
	wait(0.5)
	if IsAlive(LocalPlayer) then
		LocalPlayer.Character.Humanoid.StateChanged:Connect(function(state)
			if library.pointers.MiscellaneousTabCategoryBunnyHopEnabled.value == true then
				if UserInputService:IsKeyDown(Enum.KeyCode.Space) == false then
					isBhopping = false
					curVel = library.pointers.MiscellaneousTabCategoryBunnyHopMinVelocity.value
				elseif state == Enum.HumanoidStateType.Landed and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
					LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				elseif state == Enum.HumanoidStateType.Jumping then
					isBhopping = true
					curVel = (curVel + library.pointers.MiscellaneousTabCategoryBunnyHopAcceleration.value) >= library.pointers.MiscellaneousTabCategoryBunnyHopMaxVelocity.value and library.pointers.MiscellaneousTabCategoryBunnyHopMaxVelocity.value or curVel + library.pointers.MiscellaneousTabCategoryBunnyHopAcceleration.value
				end
			end
		end)
	end
end
]]
local function GetLegitbotTarget()
	local target,oldval = nil,math.huge
	for i,v in pairs(game.Players:GetPlayers()) do
		if IsAlive(v) and v ~= LocalPlayer and not v.Character:FindFirstChild("ForceField") then
			if _G.TeamCheck == false or GetTeam(v) ~= GetTeam(LocalPlayer) then
				if _G.VisibilityCheck == false or IsVisible(v.Character.Head.Position, {v.Character, LocalPlayer.Character, HexagonFolder, workspace.CurrentCamera}) == true then
					local Vector, onScreen = workspace.CurrentCamera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
					local FOV = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(Vector.X, Vector.Y)).magnitude
					
					if FOV < _G.FieldofView or _G.FieldofView == 0 then
						if math.floor((LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude) < _G.Distance or _G.Distance == 0 then
							if _G.TargetPriority == "FOV" then
								local Vector, onScreen = workspace.CurrentCamera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
								local FOV = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(Vector.X, Vector.Y)).magnitude
									
								if FOV < oldval then
									target = v
									oldval = FOV
								end
							elseif _G.TargetPriority == "Distance" then
								local Distance = math.floor((v.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude)
								
								if Distance < oldval then
									target = v
									oldval = Distance
								end
							end
						end
					end
				end
			end
		end
	end
	if target ~= nil then
		return target
	end
	return nil
end

local function GetLegitbotHitbox(plr)
	local target,oldval = nil,math.huge
		for i2,v2 in pairs(Hitboxes[_G.Hitbox]) do
			targetpart = plr.Character:FindFirstChild(v2)
			if targetpart then
				if _G.HitboxPriority == "FOV" then
					local Vector, onScreen = workspace.CurrentCamera:WorldToScreenPoint(targetpart.Position)
					local FOV = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(Vector.X, Vector.Y)).magnitude
					if FOV < oldval then
						target = targetpart
						oldval = FOV
					end
				elseif _G.HitboxPriority == "Distance" then
					local Distance = math.floor((targetpart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude)
					if Distance < oldval then
					target = targetpart
					oldval = Distance
				end
			end
		end
	end
	if target then
		return target
	end
	return nil
end

local function TableToNames(tbl, alt)
	local otp = {}
	
	if alt then
		for i,v in pairs(tbl) do
			table.insert(otp, v.weaponname)
		end
	else
		for i,v in pairs(tbl) do
			table.insert(otp, i)
		end
	end
	
	return otp
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

Aimbot:AddToggle({
	Name = "Enabled",
	Default = false,
	Callback = function(val)
        if val == true then
            LegitbotLoop = game:GetService("RunService").RenderStepped:Connect(function()
                if IsAlive(LocalPlayer) then
                    plr = GetLegitbotTarget()
                        if plr ~= nil then
                            hitboxpart = GetLegitbotHitbox(plr)
                            if hitboxpart ~= nil then
                                local Vector, onScreen = workspace.CurrentCamera:WorldToScreenPoint(hitboxpart.Position)
                                local PositionX = (Mouse.X-Vector.X)/(_G.Smoothness) + 1
                                local PositionY = (Mouse.Y-Vector.Y)/(_G.Smoothness) + 1
                                
                                if _G.Silent == true then
                                SilentLegitbot.target = hitboxpart
                                SilentLegitbot.aiming = true
                            else
                                mousemove(-PositionX, -PositionY)
                                if SilentLegitbot.target ~= nil then SilentLegitbot.target = nil end
                            end
                        else
                            if SilentLegitbot.target ~= nil then SilentLegitbot.target = nil end
                        end
                    else
                        if SilentLegitbot.target ~= nil then SilentLegitbot.target = nil end
                    end
                else
                    if SilentLegitbot.target ~= nil then SilentLegitbot.target = nil end
                end
            end)
        elseif val == false and LegitbotLoop then
            LegitbotLoop:Disconnect()
        end
	end
})

Aimbot:AddToggle({
	Name = "Silent",
	Default = false,
    Callback = function(val)
        _G.Silent = val
    end
})

Aimbot:AddToggle({
	Name = "Team Check",
	Default = false,
    Callback = function(val)
        _G.TeamCheck = val
    end
})

Aimbot:AddToggle({
	Name = "Visibility Check",
	Default = false,
    Callback = function(val)
        _G.VisibilityCheck = val
    end
})

Aimbot:AddBind({
	Name = "Keybind",
	Default = nil,
	Hold = false,
    Callback = function(val)
        _G.KeyCode = val
    end
})

Aimbot:AddDropdown({
    Name = "Hitbox",
    Default = "Head",
    Options = {"Head", "Chest", "Arms", "Legs"},
    Callback = function(val)
        _G.Hitbox = val
    end
})

Aimbot:AddDropdown({
    Name = "Hitbox Priority",
    Default = "FOV",
    Options = {"FOV", "Distance"},
    Callback = function(val)
        _G.HitboxPriority = val
    end
})

Aimbot:AddDropdown({
    Name = "Target Priority",
    Default = "FOV",
    Options = {"FOV", "Distance"},
    Callback = function(val)
        _G.TargetPriority = val
    end
})

Aimbot:AddSlider({
	Name = "Field of View",
	Min = 0,
	Max = 360,
	Default = 0,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "°",
    Callback = function(val)
        _G.FieldofView = val
        FOVCircle.Radius = val
    end
})

Aimbot:AddSlider({
	Name = "Hitchance",
	Min = 0,
	Max = 100,
	Default = 100,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "%",
})

Aimbot:AddSlider({
	Name = "Distance",
	Min = 0,
	Max = 2048,
	Default = 0,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = " studs",
    Callback = function(val)
        _G.Distance = val
    end
})

Aimbot:AddSlider({
	Name = "Smoothness",
	Min = 1,
	Max = 30,
	Default = 1,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "",
    Callback = function(val)
        _G.Smoothness = val
    end
})

Mouse.Move:Connect(function()
	if FOVCircle.Visible then
		FOVCircle.Position = UserInputService:GetMouseLocation()
	end
end)

for i,v in pairs({"CT", "T"}) do
	LocalPlayer.PlayerGui.GUI.Scoreboard[v].ChildAdded:Connect(function(child)
		wait(0.1)
		
		if child.Parent == LocalPlayer.PlayerGui.GUI.Scoreboard[v] and child:FindFirstChild("player") and child.player.Text ~= "PLAYER" and UserInputService:IsKeyDown(Enum.KeyCode.Tab) then
			if game.Players:FindFirstChild(child.player.Text) and game.Players[child.player.Text].OsPlatform:sub(1,1) == "|" then
				plr = game.Players[child.player.Text]
				child.player.Text = plr.OsPlatform:sub(2, 41).." "..plr.Name
				
				updater = plr:GetPropertyChangedSignal("OsPlatform"):Connect(function()
					if child and child.Parent and child:FindFirstChild("player") or UserInputService:IsKeyDown(Enum.KeyCode.Tab) and plr.OsPlatform:sub(1,1) == "|" then
						child.player.Text = plr.OsPlatform:sub(2, 41).." "..plr.Name
					else
						updater:Disconnect()
					end
				end)
			end
		end
	end)
end

Visuals:AddToggle({
	Name = "Enabled",
	Default = true,
    Callback = function(val)
        FOVCircle.Visible = val
    end
})

Visuals:AddToggle({
	Name = "Filled",
	Default = false,
    Callback = function(val)
        FOVCircle.Filled = val
    end
})

Visuals:AddSlider({
	Name = "Thickness",
	Min = 1,
	Max = 20,
	Default = 1,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "",
    Callback = function(val)
        FOVCircle.Thickness = val
    end
})

Visuals:AddSlider({
	Name = "Transparency",
	Min = 0,
	Max = 1,
	Default = 0,
	Color = Color3.fromRGB(255,255,255),
	Increment = 0.01,
	ValueName = "",
    Callback = function(val)
        FOVCircle.Transparency = 1-val
    end
})

Visuals:AddSlider({
	Name = "NumSides",
	Min = 0,
	Max = 30,
	Default = 0,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "",
    Callback = function(val)
        FOVCircle.NumSides = val >= 3 and val or 100
    end
})

Visuals:AddColorpicker({
    Name = "Color",
    Default = Color3.new(1,1,1),
    Callback = function(val)
        FOVCircle.Color = val
    end	  
})

Hint.Text = "KaoruHub's Loading Is Now Finished!"
wait(1.5)
Hint:Destroy()

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