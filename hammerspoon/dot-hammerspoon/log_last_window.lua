local lastTitle = ""

hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function(win)
    if win then
        local app = win:application():name()
        local title = win:title()
        if title ~= lastTitle then
            hs.printf("App: %s | Title: %s", app, title)
            lastTitle = title
        end
    end
end)
