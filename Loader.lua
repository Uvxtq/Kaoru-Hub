local Owner,Rname = "Uvxtq","Kaoru-Hub"
local MainPage,SickoMode = "https://raw.githubusercontent.com/"..Owner.."/"..Rname.."/main/games/"
SickoMode = game:GetService("HttpService"):JSONDecode(request({Url = "https://api.github.com/repos/"..Owner.."/"..Rname.."/git/trees/main?recursive=1",Method = "GET"}).Body)
for i,v in pairs(SickoMode.tree) do
    if v.path == "games" then
        SickoMode = v.sha
        break
    end
end

local Games = game:GetService("HttpService"):JSONDecode(request({Url = "https://api.github.com/repos/"..Owner.."/"..Rname.."/git/trees/"..SickoMode,Method = "GET"}).Body)
for i,v in pairs(Games.tree) do
    if tonumber(string.split(v.path,".")[1]) == tonumber(game.PlaceId) or tonumber(string.split(v.path,".")[1]) == tonumber(game.GameId) then
        local loading = os.date("*t",os.time())
        loadstring(game:HttpGet(MainPage..v.path))()
        local endedloading = os.date("*t",os.time())
        warn("\nkaoru hub started loading at "..tostring(loading["hour"])..":"..tostring(loading["min"])..":"..tostring(loading["sec"]).."\nkaoru hub ended loading at "..tostring(endedloading["hour"])..":"..tostring(endedloading["min"])..":"..tostring(endedloading["sec"]))
        return
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
end

-- // Send the notification 
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Hi, This game is not supported!",
    Text = "Wanna Join My Discord?",
    Duration = 7,
    Callback = bindable,
    Button1 = "Okay!",
    Button2 = "No"
})