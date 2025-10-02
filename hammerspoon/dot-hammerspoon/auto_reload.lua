function reloadConfig(files)
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            hs.reload() 
            return
        end
    end
end
myWatcher = hs.pathwatcher.new(hs.fs.pathToAbsolute(os.getenv("HOME") .. "/.hammerspoon/"), reloadConfig):start()
hs.alert.show("Config loaded")
local term = hs.application.find("WezTerm")
if term then term:activate() end
