local startTick = tick();
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/zunzw/zynixdev/main/resources/sexyocto'))({cheatname = 'ReaperHub', gamename = 'universal'}); library:init()();
local utility = library.utility;
local signal  = library.signal;
-- // UI \\ --
local menu       = library.NewWindow({title = library.cheatname .. ' | ' .. library.gamename,size = newUDim2(0,525,0,650)})
local legitTab   = menu:AddTab('Legit')
local visualTab  = menu:AddTab('Visuals')
local miscTab    = menu:AddTab('Misc')
local settingTab = library:CreateSettingsTab(menu)
