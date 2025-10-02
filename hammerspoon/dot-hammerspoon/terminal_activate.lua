-- === SETTINGS ===
local musicKeyword = "Feishin"
local terminalKeyword = "WezTerm"

local musicFilter = hs.window.filter.new(false):setAppFilter(musicKeyword)
local terminalFilter = hs.window.filter.new(false):setAppFilter(terminalKeyword)

local musicTimer = nil

-- helper: activate first matching Discord window
local function activateTerminal()
    local wins = terminalFilter:getWindows()
    if #wins > 0 then
        wins[1]:focus()
    end
end

local function startMusicWatcher(win)
    -- clear any existing timer
    if musicTimer then
        musicTimer:stop()
        musicTimer = nil
    end

    musicTimer = hs.timer.doAfter(10, function()
        local idle = hs.host.idleTime()
        if idle >= 10 then
            -- no activity ??? switch immediately
            activateTerminal()
        else
            -- user was active ??? wait 5 more seconds
            local followup = hs.timer.doAfter(5, function()
                local focused = hs.window.focusedWindow()
                if focused and focused:title():find(musicKeyword) then
                    activateTerminal()
                end
            end)
        end
    end)
end

local function stopMusicWatcher()
    if musicTimer then
        musicTimer:stop()
        musicTimer = nil
    end
end

musicFilter:subscribe(hs.window.filter.windowFocused, function(win)
    startMusicWatcher(win)
end)

musicFilter:subscribe({hs.window.filter.windowUnfocused, hs.window.filter.windowDestroyed}, function(win)
    stopMusicWatcher()
end)

