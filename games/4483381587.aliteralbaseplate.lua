local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local function service(...) return game:GetService(...) end

local MarketplaceService = service("MarketplaceService")

local Window = OrionLib:MakeWindow({Name = "Kaoru Hub Universal: " .. MarketplaceService:GetProductInfo(game.PlaceId).Name})

local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local GetChildren = game.GetChildren
local WorldToScreen = Camera.WorldToScreenPoint
local WorldToViewportPoint = Camera.WorldToViewportPoint
local GetPartsObscuringTarget = Camera.GetPartsObscuringTarget
local FindFirstChild = game.FindFirstChild
local RenderStepped = RunService.RenderStepped
local GuiInset = GuiService.GetGuiInset

local Toggles = nil

local resume = coroutine.resume 
local create = coroutine.create

local ValidTargetParts = {"Head", "HumanoidRootPart"};

local function getPositionOnScreen(Vector)
    local Vec3, OnScreen = WorldToScreen(Camera, Vector)
    return Vector2.new(Vec3.X, Vec3.Y), OnScreen
end

local function ValidateArguments(Args, RayMethod)
    local Matches = 0
    if #Args < RayMethod.ArgCountRequired then
        return false
    end
    for Pos, Argument in next, Args do
        if typeof(Argument) == RayMethod.Args[Pos] then
            Matches = Matches + 1
        end
    end
    return Matches >= RayMethod.ArgCountRequired
end

local function getDirection(Origin, Position)
    return (Position - Origin).Unit * 1000
end

local function getMousePosition()
    return Vector2.new(Mouse.X, Mouse.Y)
end

local function IsPlayerVisible(Player)
    local PlayerCharacter = Player.Character
    local LocalPlayerCharacter = LocalPlayer.Character
    
    if not (PlayerCharacter or LocalPlayerCharacter) then return end 
    
    local PlayerRoot = FindFirstChild(PlayerCharacter, Options.TargetPart.Value) or FindFirstChild(PlayerCharacter, "HumanoidRootPart")
    
    if not PlayerRoot then return end 
    
    local CastPoints, IgnoreList = {PlayerRoot.Position, LocalPlayerCharacter, PlayerCharacter}, {LocalPlayerCharacter, PlayerCharacter}
    local ObscuringObjects = #GetPartsObscuringTarget(Camera, CastPoints, IgnoreList)
    
    return ((ObscuringObjects == 0 and true) or (ObscuringObjects > 0 and false))
end

local function getClosestPlayer()
    if not Options.TargetPart.Value then return end
    local Closest
    local DistanceToMouse
    for _, Player in next, GetChildren(Players) do
        if Player == LocalPlayer then continue end
        if Toggles.TeamCheck.Value and Player.Team == LocalPlayer.Team then continue end

        local Character = Player.Character
        if not Character then continue end
        
        if Toggles.VisibleCheck.Value and not IsPlayerVisible(Player) then continue end

        local HumanoidRootPart = FindFirstChild(Character, "HumanoidRootPart")
        local Humanoid = FindFirstChild(Character, "Humanoid")

        if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end

        local ScreenPosition, OnScreen = getPositionOnScreen(HumanoidRootPart.Position)

        if not OnScreen then continue end

        local Distance = (getMousePosition() - ScreenPosition).Magnitude
        if Distance <= (DistanceToMouse or (Toggles.fov_Enabled.Value and Options.Radius.Value) or 2000) then
            Closest = ((Options.TargetPart.Value == "Random" and Character[ValidTargetParts[math.random(1, #ValidTargetParts)]]) or Character[Options.TargetPart.Value])
            DistanceToMouse = Distance
        end
    end
    return Closest
end

local fov_circle = Drawing.new("Circle")
fov_circle.Thickness = 1
fov_circle.NumSides = 100
fov_circle.Radius = 180
fov_circle.Filled = false
fov_circle.Visible = false
fov_circle.ZIndex = 999
fov_circle.Transparency = 1
fov_circle.Color = Color3.fromRGB(255, 255, 255)

local PredictionAmount = 0.165

do
    local Main = Window:MakeTab({
        Name = "Main",
        Icon = "rbxassetid://8945416692",
        PremiumOnly = false
    })

    local FieldaOfView = Window:MakeTab({
        Name = "Field Of View",
        Icon = "rbxassetid://8945416692",
        PremiumOnly = false
    })

    local Prediction = Window:MakeTab({
        Name = "Prediction",
        Icon = "rbxassetid://8945416692",
        PremiumOnly = false
    })

    Main:AddToggle({
        Name = "Enabled",
        Default = false,
    })

    Main:AddToggle({
        Name = "Team Check",
        Default = false,
    })

    Main:AddToggle({
        Name = "Visible Check",
        Default = false,
    })
    Main:AddDropdown({
        Name = "Target Part",
        Default = "Head",
        Options = {
            "Head",
            "HumanoidRootPart",
            "Random"
        }
    }) 

    Main:AddDropdown({
        Name = "Silent Aim Method",
        Default = "Raycast",
        Options = {
            "Raycast", "FindPartOnRay",
            "FindPartOnRayWithWhitelist",
            "FindPartOnRayWithIgnoreList",
            "Mouse.Hit/Target"
        }
    })

    FieldaOfView:AddToggle({
        Name = "Enabled",
        Default = false,
    })

    FieldaOfView:AddToggle({
        Name = "Visible",
        Default = false,
        Callback = function()
            fov_circle.Visible = Toggles.Visible.Value
        end
    })

    FieldaOfView:AddColorpicker({
        Name = "Select Your Field Of View Color",
        Default = Color3.fromRGB(255, 255, 255),
        Callback = function(Value)
            fov_circle.Color = Value
        end	  
    })

    FieldaOfView:AddSlider({
        Name = "Radius",
        Min = 0,
        Max = 1000,
        Default = 180,
        Color = Color3.fromRGB(255,255,255),
        Increment = 1,
        ValueName = "Radius",
        Callback = function()
            fov_circle.Radius = Options.Radius.Value
        end
    })

    Prediction:AddToggle({
        Name = "Mouse.Hit/Target Prediction",
        Default = false
    })

    Prediction:AddSlider({
        Name = "Prediction",
        Min = 0.165,
        Max = 1,
        Default = 0.165,
        Color = Color3.fromRGB(255,255,255),
        Increment = 0.001,
        ValueName = "Prediction",
        Callback = function()
            PredictionAmount = Options.Amount.Value
        end
    })
end

resume(create(function()
    RenderStepped:Connect(function()
        if Toggles.MousePosition.Value then 
            if Toggles.aim_Enabled.Value == true and Options.Method.Value == "Mouse.Hit/Target" then
                mouse_box.Color = Options.MouseVisualizeColor.Value 
                
                mouse_box.Visible = ((getClosestPlayer() and true) or false)
                mouse_box.Position = ((getClosestPlayer() and Vector2.new(WorldToViewportPoint(Camera, getClosestPlayer().Parent.PrimaryPart.Position).X, WorldToViewportPoint(Camera, getClosestPlayer().Parent.PrimaryPart.Position).Y)) or Vector2.new(-9000, -9000)) -- I am too lazy to write this differently - xaxa
            end
        end
        
        if Toggles.Visible.Value then 
            fov_circle.Visible = Toggles.Visible.Value
            fov_circle.Color = Options.Color.Value
            fov_circle.Position = getMousePosition() + Vector2.new(0, 36)
        end
    end)
end))

local ExpectedArguments = {
    FindPartOnRayWithIgnoreList = {
        ArgCountRequired = 3,
        Args = {
            "Instance", "Ray", "table", "boolean", "boolean"
        }
    },
    FindPartOnRayWithWhitelist = {
        ArgCountRequired = 3,
        Args = {
            "Instance", "Ray", "table", "boolean"
        }
    },
    FindPartOnRay = {
        ArgCountRequired = 2,
        Args = {
            "Instance", "Ray", "Instance", "boolean", "boolean"
        }
    },
    Raycast = {
        ArgCountRequired = 3,
        Args = {
            "Instance", "Vector3", "Vector3", "RaycastParams"
        }
    }
}

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(...)
    local Method = getnamecallmethod()
    local Arguments = {...}
    local self = Arguments[1]

    if Toggles.aim_Enabled.Value and self == workspace then
        if Method == "FindPartOnRayWithIgnoreList" and Options.Method.Value == Method then
            if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRayWithIgnoreList) then
                local A_Ray = Arguments[2]

                local HitPart = getClosestPlayer()
                if HitPart then
                    local Origin = A_Ray.Origin
                    local Direction = getDirection(Origin, HitPart.Position)
                    Arguments[2] = Ray.new(Origin, Direction)

                    return oldNamecall(unpack(Arguments))
                end
            end
        elseif Method == "FindPartOnRayWithWhitelist" and Options.Method.Value == Method then
            if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRayWithWhitelist) then
                local A_Ray = Arguments[2]

                local HitPart = getClosestPlayer()
                if HitPart then
                    local Origin = A_Ray.Origin
                    local Direction = getDirection(Origin, HitPart.Position)
                    Arguments[2] = Ray.new(Origin, Direction)

                    return oldNamecall(unpack(Arguments))
                end
            end
        elseif (Method == "FindPartOnRay" or Method == "findPartOnRay") and Options.Method.Value:lower() == Method:lower() then
            if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRay) then
                local A_Ray = Arguments[2]

                local HitPart = getClosestPlayer()
                if HitPart then
                    local Origin = A_Ray.Origin
                    local Direction = getDirection(Origin, HitPart.Position)
                    Arguments[2] = Ray.new(Origin, Direction)

                    return oldNamecall(unpack(Arguments))
                end
            end
        elseif Method == "Raycast" and Options.Method.Value == Method then
            if ValidateArguments(Arguments, ExpectedArguments.Raycast) then
                local A_Origin = Arguments[2]

                local HitPart = getClosestPlayer()
                if HitPart then
                    Arguments[3] = getDirection(A_Origin, HitPart.Position)

                    return oldNamecall(unpack(Arguments))
                end
            end
        end
    end
    return oldNamecall(...)
end)

local oldIndex = nil 
oldIndex = hookmetamethod(game, "__index", function(self, Index)
    if self == Mouse and (Index == "Hit" or Index == "Target") then 
        if Toggles.aim_Enabled.Value == true and Options.Method.Value == "Mouse.Hit/Target" and getClosestPlayer() then
            local HitPart = getClosestPlayer()

            return ((Index == "Hit" and ((Toggles.Prediction.Value == false and HitPart.CFrame) or (Toggles.Prediction.Value == true and (HitPart.CFrame + (HitPart.Velocity * PredictionAmount))))) or (Index == "Target" and HitPart))
        end
    end

    return oldIndex(self, Index)
end)


