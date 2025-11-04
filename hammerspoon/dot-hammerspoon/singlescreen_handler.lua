layout_change = function()
        local screens = hs.screen.allScreens()
        if #screens == 1 then
                hs.application.get("Google Chrome"):hide()
        end        
        hs.application.get("Google Chrome"):unhide()
end

local screenWatcher = hs.screen.watcher.new(layout_change)
screenWatcher:start()
