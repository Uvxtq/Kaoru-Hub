textbs:Textbox("County to buy from...", "Type here!", true, function(val)
    _G.County = val
end)

local drop = drops:Dropdown("Resource To Buy...",{"Aircraft Parts", "Aluminum", "Chromium", "Consumer Goods", "Copper", "Diamonds", "Electronics", "Enriched Uranium", "Fertilizer", "Gold", "Iron", "Motor Pats", "Oil", "Prosphate", "Steel", "Titanium", "Tungsten", "Uranium"}, function(val)
    _G.Resource = val
end)

local drop = drops:Dropdown("Resource To Buy...",{1, 5, 10, 50, 100, 125, 150, 175, 200, 300, 400, 500, 1000, 1500, 2500, 3000, 4000, 5000, 10000}, function(val)
    _G.Amount = val
end)

btns:Button("Buy from selcted county", function()
    local args = {
        [1] = _G.County,[2] = "ResourceTrade",[3] = {[1] = _G.Resource,[2] = "Buy",[3] = _G.Amount,[4] = 1,[5] = "Trade"}
    }

    workspace.GameManager.ManageAlliance:FireServer(unpack(args))
    DiscordLib:Notification("Notification", "Bought!", "Okay!")
end)