local function service(...) return game:GetService(...) end

local Players = service("Players")
local MarketplaceService = service("MarketplaceService")
local ReplicatedStorage = service("ReplicatedStorage")
local HttpService = service("HttpService")

local library = loadstring(game:HttpGet( "https://pastebin.pl/view/raw/2b708ac0" , true))() 
-- https://pastebin.com/raw/SjcYQ23F
local guiname = " " .. MarketplaceService:GetProductInfo(game.PlaceId).Name .. " | CREATED BY mstudio45#5590"

local uiSettings = {
	main_color = Color3.fromRGB(228, 0, 224),
	min_size = Vector2.new(550, 600),
	toggle_key = Enum.KeyCode.RightShift,
	can_resize = false
}
local Window,frame = library:AddWindow(guiname, uiSettings)

local AutoFarm = Window:AddTab("AutoFarm")
local Logs = Window:AddTab("Logs")
local Settings = Window:AddTab("Settings")
local Credits = Window:AddTab("Credits")

Credits:AddLabel("Script was maded by: mstudio45#5590")
Credits:AddLabel("UI Library: Elerium by Singularity")

Logs:AddLabel("Tween Farm Logs:")
local v2farmLogs = Logs:AddConsole({
	["readonly"] = true,
	["source"] = "Logs",
	["full"] = false,
	["y"] = 75
})

Logs:AddLabel("TP Farm Logs:")
local v1farmLogs = Logs:AddConsole({
	["readonly"] = true,
	["source"] = "Logs",
	["full"] = false,
	["y"] = 75
})

Logs:AddLabel("Script Logs:")
local scriptLogConsole = Logs:AddConsole({
	["readonly"] = true,
	["source"] = "Logs",
	["full"] = false,
	["y"] = 225
})

local v1autofarmFold = AutoFarm:AddFolder("TP AutoFarm - OLD")
local v2autofarmFold = AutoFarm:AddFolder("Tween AutoFarm - NEW (recommended)")

local logscriptcount = 0
function ScriptLog(Text,console)
	if console then else console = scriptLogConsole end;if console == nil then console = scriptLogConsole end
	if logscriptcount == 14 then pcall(function() console:Set("") logscriptcount = 0 end) end
	pcall(function() console:Log(Text) logscriptcount = logscriptcount + 1 end)
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

local autofarmv1ShowLogs = true
local autofarmv2ShowLogs = true

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
			v2farmLogs:Set("")
			v2farmLogs:Log("Wating for TP AutoFarm to finish...")
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
					v2farmLogs:Set("")
					v2farmLogs:Log("Wating for TP AutoFarm to finish...")
					repeat wait() until	farmonv2 == true and farmon == false and running == false
				end
				if farmonv2 == true and farmon == false then  
					if autofarmv2ShowLogs then
						Logs:Show()
					end
					v2farmLogs:Set("")
					v2farmLogs:Log("Tween AutoFarm activated")
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

					v2farmLogs:Log("Tweening to end...")

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
					v2farmLogs:Log("Trying to claim the chest...")
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
			v1farmLogs:Set("")
			v1farmLogs:Log("Wating for Tween AutoFarm to finish...")
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
					v1farmLogs:Set("")
					v1farmLogs:Log("Wating for Tween AutoFarm to finish...")
					repeat wait() until	farmonv2 == false and farmon == true and running2 == false
				end
				if farmon == true and farmonv2 == false then 
					if autofarmv1ShowLogs then
						Logs:Show()
					end
					v1farmLogs:Set("")
					v1farmLogs:Log("TP AutoFarm activated")					
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
					v1farmLogs:Log("TPing to end...")
					repeat wait() until game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger.CFrame
					v1farmLogs:Log("Trying to claim the chest...")
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


local autofarmv1switch = v1autofarmFold:AddSwitch("Toggle",function(bool)
	farmon = bool
	if bool == false then
		repeat wait() until running == false
		wait(0.25)
		v1farmLogs:Set("")
		v1farmLogs:Log("Finished.")
	end
end)
local autofarmv1ShowLogBut = v1autofarmFold:AddSwitch("Show Logs after start",function(bool)
	autofarmv1ShowLogs = bool
end)
autofarmv1ShowLogBut:Set(autofarmv1ShowLogs)
autofarmv1switch:Set(false)
v1farmLogs:Set("")

local autofarmv2switch = v2autofarmFold:AddSwitch("Toggle",function(bool)
	farmonv2 = bool
	if bool == false then
		repeat wait() until running2 == false
		wait(0.25)
		v2farmLogs:Set("")
		v2farmLogs:Log("Finished.")
	end
end)
local autofarmv2ShowLogBut = v2autofarmFold:AddSwitch("Show Logs after start",function(bool)
	autofarmv2ShowLogs = bool
end)
autofarmv2ShowLogBut:Set(autofarmv2ShowLogs)
autofarmv2switch:Set(false)
v2farmLogs:Set("")

AutoFarm:AddButton("Destroy Parts",function()
	deleteParts()
end)

Settings:AddButton("Destroy GUI", function()
	local imgui = game:GetService("CoreGui"):FindFirstChild("imgui")
	if imgui then 
		imgui:Destroy() 
		return Msgreq("Info.","Gui was destroyed!",5,"Ok")
	end
end)
local guiColorFolder = Settings:AddFolder("Gui Color")
local guiColor = guiColorFolder:AddColorPicker(function(color)
	uiSettings.main_color = color
end)
local customBrickColors = guiColorFolder:AddDropdown("BrickColors", function(text)
	if text == "Default" then
		uiSettings.main_color = Color3.fromRGB(255, 0, 0)
	else
		uiSettings.main_color = BrickColor.new(text).Color
	end
end)
customBrickColors:Add("Default")
for i = 0, 127 do
	customBrickColors:Add(BrickColor.palette(i))
end
pcall(function()game:GetService("Workspace").ExploitCheckRemote:Destroy()end)
ScriptLog("AntiCheat deleted.") 
if game.CoreGui:FindFirstChild("b'a'b'f't'by'mstudio45") then
	ScriptLog("Script was reloaded!")
else
	Instance.new("ScreenGui",game.CoreGui).Name = "b'a'b'f't'by'mstudio45"
	ScriptLog("Script loaded!")
end
Credits:Show()
library:FormatWindows()