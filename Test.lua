ConfigLib = {}
local ConfigList = {}
function ConfigLib.New(Name)
    local ConfigurationPath = "config\\".. Name .. ".config.json"
    if not isfile(ConfigurationPath) then
        writefile(ConfigurationPath, "{}")
    else
        return {Status = "Error", ErrorCode = 1, Message = "Configuration already exists"}
    end
    ConfigList[Name] = {}
    function ConfigList[Name].AddConfigurationValue(default, name: string, description: string)
        name = string.gsub(name, " ", "") 
        local type = typeof(value)
        if (not type == typeof(default)) then
            return {Status = "Error", ErrorCode = 2, Message = "Make sure the default value is a ".. typeof(value)}
        end
        ConfigList[Name][name] = {}
        ConfigList[Name][name]["Default"] = default
        ConfigList[Name][name]["Description"] = description
        ConfigList[Name][name]["Value"] = default
        writefile(ConfigurationPath, game:GetService("HttpService"):JSONEncode(ConfigList[Name]))
        return {Status = "Success", ErrorCode = 0, Message = "The configuration was saved"}
    end
    function ConfigList[Name].AddConfigurationTable(Table: table)
        for _, v in pairs(Table) do
            for _, v2 in pairs(v) do
                ConfigList[Name]["Add"](v2["Default"], v2["Name"], v2["Description"])
            end
        end
    end
    return ConfigList[Name]
end
function ConfigLib.LoadSavedConfiguration(Name)
    local ConfigurationPath = "config\\".. Name .. ".config.json"
    if (not isfile(ConfigurationPath)) then
        return {Status = "Error", ErrorCode = 3, Message = "Configuration does not exist"}
    end
    loadstring(Name .. "Config = ".. game:GetService("HttpService"):JSONDecode(readfile(ConfigurationPath)))()
end
function ConfigLib.GetConfigByName(Name)
    return ConfigList[Name]
end
local Configuration = ConfigLib.New("CatWare")
local h = Configuration.AddConfigurationValue(UDim2.new(5,3), 
"GuiSize", 
"Basically if you resized the gui you can have the same gui size when you re-execute")
if (h["ErrorCode"] == 1) then
    ConfigLib.LoadSavedConfiguration("CatWare")
    local guisize = CatWareConfig["GuiSize"]
end
