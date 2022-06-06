local function service(...) return game:GetService(...) end

local Players = service("Players")
local MarketplaceService = service("MarketplaceService")
local ReplicatedStorage = service("ReplicatedStorage")
local HttpService = service("HttpService")
local GameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Kaoru Hub Free: " .. GameName})

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

local Credits = Window:MakeTab({
	Name = "Credits",
	Icon = "rbxassetid://8950218710",
	PremiumOnly = false
})

local Discord = Window:MakeTab({
	Name = "Discord",
	Icon = "rbxassetid://8950218710",
	PremiumOnly = false
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

local function CedDiscord()
    local Settings = {
        InviteCode = "9MgWH5RDFs" --add your invite code here (without the "https://discord.gg/" part)
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

local function discordMain()
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

local NotificationBindable = Instance.new("BindableFunction")
local Msgreq = function(Title,Text,Duration,Button1Text,Button2Text)
	game.StarterGui:SetCore("SendNotification", {
		Title = Title;
		Text = Text;
		Icon = "http://www.roblox.com/asset/?id=7041671720";
		Duration = Duration;
		Button1 = Button1Text;
		Button2 = nil;
		Callback = NotificationBindable;
	})
end

local farmon = false
local running = false

local farmonv2 = false
local running2 = false

local deletingparts = false
function deleteParts(noLogs)
	if deletingparts == false then
		spawn(function()
			deletingparts = true
			if noLogs == true then else
				Msgreq("Info.","Please wait...",2,"Ok")
			end
			repeat wait() until running2 == false and running == false and farmonv2 == false and farmon == false
			for _,v in pairs(workspace:GetDescendants()) do
				if v.Name=="zhwzuehwugewfzewzgefwzfewewew" then
					v:Destroy()
				end
			end
			deletingparts = false
			if noLogs == true then else
				Msgreq("Info.","Parts were destroyed!",5,"Ok")
			end
			return
		end)
	end
end

spawn(function()
	while wait() do
		if farmon == true and running == true and farmonv2 == true then
			repeat wait() until	farmonv2 == true and farmon == false and running == false
		end
		if farmonv2 == true and farmon == false then
			local vu2 = game:GetService("VirtualUser")
			game:GetService("Players").LocalPlayer.Idled:connect(function()
				vu2:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
				wait(1)
				vu2:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
			end)

			while wait() do
				if farmon == true and running == true and farmonv2 == true then
					repeat wait() until	farmonv2 == true and farmon == false and running == false
				end
				if farmonv2 == true and farmon == false then  
					running2 = true
					spawn(function()
						game:getService("RunService"):BindToRenderStep("NoClip",0,function()
							pcall(function()
								if not game.Players.LocalPlayer.Character:findFirstChildOfClass("Humanoid") then return end
								if not running2 == true then return end
								game.Players.LocalPlayer.Character:findFirstChildOfClass("Humanoid"):ChangeState(11)
							end)
						end)
					end)

					local parttotween = Instance.new("Part",game.Workspace)
					parttotween.Anchored = true
					parttotween.CFrame = CFrame.new(-62.0472336, 63, 8708.96191)
					parttotween.Size = Vector3.new(2.5,2.5,2.5)
					parttotween.Name = "zhwzuehwugewfzewzgefwzfewewew"
					local parttotweenfirst = Instance.new("Part",game.Workspace)
					parttotweenfirst.Anchored = true
					parttotweenfirst.CFrame = CFrame.new(-62.0472336, 63, 366.74804)
					parttotweenfirst.Size = Vector3.new(2.5,2.5,2.5)
					parttotweenfirst.Name = "zhwzuehwugewfzewzgefwzfewewew"
					parttotween.CanCollide= false
					parttotweenfirst.CanCollide = false

					local checks = workspace.BoatStages:GetDescendants()
					for i=1,#checks do
						if checks[i].Name == "DarknessPart" or checks[i].Name == "GatePart" then
							pcall(function()
								local float = Instance.new("Part",game.Workspace)
								float.Name = "zhwzuehwugewfzewzgefwzfewewew"
								float.Anchored = true
								float.Size = Vector3.new(9999,1,9999)
								float.CFrame = CFrame.new(checks[i].Position.X, 60, checks[i].Position.Z)
							end)
						end
					end

					local character = game.Players.LocalPlayer.Character 
					local hrp = character:WaitForChild("HumanoidRootPart")

                    repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

					local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
					local Animation = game:GetService("TweenService"):Create(game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(parttotweenfirst.Position)})
					Animation:Play()
					repeat wait() until Animation.Completed:Wait()
					wait()

					local tweenInfo2 = TweenInfo.new(15, Enum.EasingStyle.Linear)
					local Animation2 = game:GetService("TweenService"):Create(game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart, tweenInfo2, {CFrame = CFrame.new(parttotween.Position)})
					Animation2:Play()
					repeat wait() until Animation2.Completed:Wait()
					wait()

					repeat wait() until game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger.CFrame
					local waitingtpchest = 0
					spawn(function()
						for i=12,0,-1 do
							waitingtpchest = waitingtpchest + 1
							wait(1)
						end
					end)
					repeat
						if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
							game.Players.LocalPlayer.Character.Humanoid.Jump = true
							wait()
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger.CFrame
						end
						wait()
					until waitingtpchest == 13
					wait(2.75)
					running2 = false
					waitingtpchest = 0
					wait()
					deleteParts(true)
				else
					wait()
				end
			end
		end
	end
end)

spawn(function()
	while wait() do
		if farmonv2 == true and running2 == true and farmon == true then
			repeat wait() until	farmonv2 == false and farmon == true and running2 == false
		end
		if farmon == true and farmonv2 == false then
			local vu = game:GetService("VirtualUser")
			game:GetService("Players").LocalPlayer.Idled:connect(function()
				vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
				wait(1)
				vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
			end)

			while wait() do
				if farmonv2 == true and running2 == true and farmon == true then
					repeat wait() until	farmonv2 == false and farmon == true and running2 == false
				end
				if farmon == true and farmonv2 == false then 			
					running = true
					spawn(function()
						game:getService("RunService"):BindToRenderStep("NoClip",0,function()
							pcall(function()
								if not game.Players.LocalPlayer.Character:findFirstChildOfClass("Humanoid") then return end
								if not running == true then return end
								game.Players.LocalPlayer.Character:findFirstChildOfClass("Humanoid"):ChangeState(11)
							end)
						end)
					end)

					local checks = workspace.BoatStages:GetDescendants()
					for i=1,#checks do
						running = true
						if checks[i].Name == "DarknessPart" or checks[i].Name == "GatePart" then
							checks[i].Transparency = 0
							if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = checks[i].CFrame
								local float = Instance.new("Part",game.Workspace)
								float.Name = "zhwzuehwugewfzewzgefwzfewewew"
								float.Anchored = true
								float.Size = Vector3.new(9999,1,9999)
								float.CFrame = CFrame.new(checks[i].Position.X, 60, checks[i].Position.Z)
							end
							wait(0.24)
							pcall(function()game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = checks[i].CFrame;end)
						end
					end
					repeat wait() until game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger.CFrame
					repeat
						if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
							game.Players.LocalPlayer.Character.Humanoid.Jump = true
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger.CFrame
						end
						wait()
					until not game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
					running = false
					wait()
					deleteParts(true)
				else
					wait()
				end
			end	
		end
	end
end)

--[[
Main:AddButton({
	Name = "Delete Anti-Cheat.",
	Callback = function(v)
        _G.ExploitCheckRemote = v
        if _G.ExploitCheckRemote == true then
            game:GetService("Workspace").ExploitCheckRemote:Destroy()
            wait(1)
            Msgreq("Info.","Anti-Cheat Disabled",2,"Nice!")
        else
            Msgreq("Info.","Anti-Cheat Already Disabled Silly!",2,"Ok, Faggot >:(")
        end
    end
})
]]

Main:AddButton({
	Name = "Delete Parts.",
	Callback = function()
        deleteParts()
    end
})

function deleteParts(noLogs)
	if deletingparts == false then
		spawn(function()
			deletingparts = true
			if noLogs == true then else
				Msgreq("Info.","Please wait...",2,"Ok")
			end
			repeat wait() until running2 == false and running == false and farmonv2 == false and farmon == false
			for _,v in pairs(workspace:GetDescendants()) do
				if v.Name=="zhwzuehwugewfzewzgefwzfewewew" then
					v:Destroy()
				end
			end
			deletingparts = false
			if noLogs == true then else
				Msgreq("Info.","Parts were destroyed!",5,"Ok")
			end
			return
		end)
	end
end

if game.CoreGui:FindFirstChild("ScriptYes") then
	OrionLib:MakeNotification({
        Name = "Success!",
        Content = "The script has been successfully Re-Executed, If there are any errors please report them to the discord.",
        Time = 5
    })
else
	Instance.new("ScreenGui",game.CoreGui).Name = "ScriptYes"
	OrionLib:MakeNotification({
        Name = "Success!",
        Content = "The script has been successfully executed, If there are any errors please report them to the discord.",
        Time = 5
    })
end

Credits:AddButton({
	Name = "Thanks mstudio45: Helped Code the script," .. " His discord below.",
	Callback = function()
        Msgreq("Info.","Joining discord...",1.5,"Ok")
        wait(1)
        CedDiscord()
    end
})

Main:AddToggle({
	Name = "Auto Farm: Tween," .. " (Recommended)",
	Default = false,
	Callback = function(bool)
        farmonv2 = bool
        if bool == true then
            Msgreq("Info.","Auto Farm (Tween) Toggled On!",3,"Ok")
        end
        if bool == false then
            repeat wait() until running2 == false
            wait(0.25)
            Msgreq("Info.","Auto Farm (Tween) Toggled Off!",3,"Ok")
        end
    end
})

--[[
Main:AddToggle({
	Name = "Auto Farm: TP," .. " (Not Recommended)",
	Default = false,
	Callback = function(bool)
        farmon = bool
        if bool == true then
            Msgreq("Info.","Auto Farm (TP) Toggled On!",3,"Ok")
        end
        if bool == false then
            repeat wait() until running2 == false
            wait(0.25)
            Msgreq("Info.","Auto Farm (TP) Toggled Off!",3,"Ok")
        end
    end
})
]]

Discord:AddButton({
	Name = "Join Our Discord Server",
	Callback = function()
        Msgreq("Info.","Joining discord...",1.5,"Ok")
        wait(1)
        discordMain()
    end
})

OrionLib:Init()