layout_change = function()
        local screens = hs.screen.allScreens()
        if #screens == 1 then
                hs.application.get("Google Chrome"):kill()
                hs.application.get("Discord"):kill()
                hs.application.get("Slack"):kill()
                hs.application.get("Feishin"):kill()
                hs.application.get("Elements"):kill()
                hs.application.get("Vivaldi"):kill()
        end        
        hs.execute("open -na 'Google Chrome' --args --app='https://steamcommunity.com/chat/'")
        hs.execute("open -na 'Discord'")
        hs.execute("open -na 'Slack'")
        hs.execute("open -na 'Feishin'")
        hs.execute("open -na 'Elements'")
        hs.execute("open -na 'Google Chrome' --args --app='https://www.messenger.com/'")
        hs.execute("open -na 'Google Chrome' --args --app='https://www.twitch.tv/popout/zhurai/chat'")
        hs.execute("open -na 'Vivaldi'")
end

local screenWatcher = hs.screen.watcher.new(layout_change)
screenWatcher:start()
