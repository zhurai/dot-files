local slackKeyword = "Slack"
local discordKeyword = "Discord"

local slackFilter = hs.window.filter.new(false):setAppFilter(slackKeyword)
local discordFilter = hs.window.filter.new(false):setAppFilter(discordKeyword)

local slackTimer = nil
local lastLocalActivity = hs.timer.secondsSinceEpoch()
local localActivityThreshold = 10 -- seconds

-- helper: activate first matching Discord window
local function activateDiscord()
    local wins = discordFilter:getWindows()
    if #wins > 0 then
        wins[1]:focus()
    end
end

-- periodic idle check instead of one-shot timer
local function startSlackWatcher()
    if slackTimer then
        slackTimer:stop()
        slackTimer = nil
    end

    slackTimer = hs.timer.doEvery(1, function()
        local now = hs.timer.secondsSinceEpoch()
        local idle = now - lastLocalActivity
        local focused = hs.window.focusedWindow()

        if focused
            and focused:application():title():find(slackKeyword)
            and idle >= localActivityThreshold then
            activateDiscord()
            slackTimer:stop()
            slackTimer = nil
        end
    end)
end

local function stopSlackWatcher()
    if slackTimer then
        slackTimer:stop()
        slackTimer = nil
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

-- start/stop Slack watcher based on focus
slackFilter:subscribe(hs.window.filter.windowFocused, function(win)
    lastLocalActivity = hs.timer.secondsSinceEpoch()
    startSlackWatcher()
end)

slackFilter:subscribe(
    {hs.window.filter.windowUnfocused, hs.window.filter.windowDestroyed},
    function(win)
        stopSlackWatcher()
    end
)
