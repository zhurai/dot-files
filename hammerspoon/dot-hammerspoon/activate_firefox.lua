local deactivateKeyword = "Feishin"
local activateKeyword = "Firefox"

local deactivateFilter = hs.window.filter.new(false):setAppFilter(deactivateKeyword)
local activateFilter = hs.window.filter.new(false):setAppFilter(activateKeyword)

local deactivateTimer = nil
local lastLocalActivity = hs.timer.secondsSinceEpoch()
local localActivityThreshold = 10 -- seconds

local function activateWindow()
    local wins = activateFilter:getWindows()
    if #wins > 0 then
        wins[1]:focus()
    end
end

-- periodic idle check instead of one-shot timer
local function startDeactivateWatcher()
    if deactivateTimer then
        deactivateTimer:stop()
        deactivateTimer = nil
    end

    deactivateTimer = hs.timer.doEvery(1, function()
        local now = hs.timer.secondsSinceEpoch()
        local idle = now - lastLocalActivity
        local focused = hs.window.focusedWindow()

        if focused
            and focused:application():title():find(deactivateKeyword)
            and idle >= localActivityThreshold then
            activateWindow()
            deactivateTimer:stop()
            deactivateTimer = nil
        end
    end)
end

local function stopDeactivateWatcher()
    if deactivateTimer then
        deactivateTimer:stop()
        deactivateTimer = nil
    end
end

-- event tap for local input
local activityTap = hs.eventtap.new(
    {
        hs.eventtap.event.types.keyDown,
        hs.eventtap.event.types.flagsChanged,
        hs.eventtap.event.types.mouseMoved,
        hs.eventtap.event.types.leftMouseDown,
        hs.eventtap.event.types.rightMouseDown,
        hs.eventtap.event.types.otherMouseDown
    },
    function(e)
        lastLocalActivity = hs.timer.secondsSinceEpoch()
        return false
    end
)
activityTap:start()

deactivateFilter:subscribe(hs.window.filter.windowFocused, function(win)
    lastLocalActivity = hs.timer.secondsSinceEpoch()
    startDeactivateWatcher()
end)

deactivateFilter:subscribe(
    {hs.window.filter.windowUnfocused, hs.window.filter.windowDestroyed},
    function(win)
        stopDeactivateWatcher()
    end
)
