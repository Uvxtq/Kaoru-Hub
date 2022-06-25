
local webhookcheck = 
    is_sirhurt_closure and "Sirhurt" or 
    pebc_execute and "ProtoSmasher" or 
    syn and "Synapse X" or
    secure_load and "Sentinel" or
    KRNL_LOADED and "Krnl" or
    identifyexecutor() and "ScriptWare" or
    "Kid with shit exploit"
    if webhookcheck == "Kid with shit exploit" then
        game.Players.LocalPlayer:Kick("Your executer is not supported, try using: Synapse X; Sentinel; Krnl; or ScriptWare.")
    end
local url = "https://websec.services/send/629e6cb58b8ee4dd4549d0fc" 
local data = {
    ["content"] = "Kaoru Hub Has Been Executed!",
    ["embeds"] = {
        {
            ["title"] = "**Someone Executed Kaoru Hub!** in: "   .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. " :)",
            ["description"] = "Username: " .. game.Players.LocalPlayer.Name.." with **"..webhookcheck.."**",
            ["type"] = "rich",
            ["color"] = tonumber(0x7269da),
        }
    }
}

local newdata = game:GetService("HttpService"):JSONEncode(data)
request = http_request or request or HttpPost or syn.request or http.request
request({Url = url, Body = newdata, Method = "POST", Headers = {["content-type"] = "application/json"}})

local dummy = Instance.new("BindableFunction")
function dummy.OnInvoke(response)
    if response == "Okay!" then
        setclipboard('https://discord.gg/zkvPrg89jD')
    end
end

local bindable = Instance.new("BindableFunction")
function bindable.OnInvoke(response)
    if response == "Okay!" then
        local Settings = {
            InviteCode = "zkvPrg89jD"
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
            return game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "your executor does not support http requests.",
                Text = "Wanna copy the discord link instead?",
                Duration = 7,
                Callback = dummy,
                Button1 = "Okay!",
                Button2 = "No"
            })
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
end

local Link = "https://raw.githubusercontent.com/Uvxtq/Kaoru-Hub/main/games/"
if game.PlaceId or game.GameId == "537413528" then
    loadstring(game:HttpGet((Link.."537413528.BuildABoatForTreasure.lua"),true))()
elseif game.PlaceId or game.GameId == "4483381587" then
    loadstring(game:HttpGet((Link.."4483381587.WeaponFightingSimulator.lua"),true))()
elseif game.PlaceId or game.GameId == "8739926633" then
    loadstring(game:HttpGet((Link.."8739926633.MagicWoodcuttingSimulator.lua"),true))()
elseif game.PlaceId or game.GameId == "8750997647" then
    loadstring(game:HttpGet((Link.."8750997647.TappingLegendsX.lua"),true))()
else
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Hi, This game is not supported!",
        Text = "Wanna Join My Discord?",
        Duration = 7,
        Callback = bindable,
        Button1 = "Okay!",
        Button2 = "No"
    })
end