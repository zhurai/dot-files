-- === SETTINGS ===
local slackKeyword = "Slack"
local discordKeyword = "Discord"

local slackFilter = hs.window.filter.new(false):setAppFilter(slackKeyword)
local discordFilter = hs.window.filter.new(false):setAppFilter("Google Chrome", { allowTitles = { discordKeyword } })

local slackTimer = nil

-- helper: activate first matching Discord window
local function activateDiscord()
    local wins = discordFilter:getWindows()
    if #wins > 0 then
        wins[1]:focus()
    end
end

local function startSlackWatcher(win)
    -- clear any existing timer
    if slackTimer then
        slackTimer:stop()
        slackTimer = nil
    end

    slackTimer = hs.timer.doAfter(10, function()
        local idle = hs.host.idleTime()
        if idle >= 10 then
            -- no activity ??? switch immediately
            activateDiscord()
        else
            -- user was active ??? wait 5 more seconds
            local followup = hs.timer.doAfter(5, function()
                -- check still focused on Slack before switching
                local focused = hs.window.focusedWindow()
                if focused and focused:title():find(slackKeyword) then
                    activateDiscord()
                end
            end)
        end
    end)
end

local function stopSlackWatcher()
    if slackTimer then
        slackTimer:stop()
        slackTimer = nil
    end
end

-- subscribe to Slack focus/loss events
slackFilter:subscribe(hs.window.filter.windowFocused, function(win)
    startSlackWatcher(win)
end)

slackFilter:subscribe({hs.window.filter.windowUnfocused, hs.window.filter.windowDestroyed}, function(win)
    stopSlackWatcher()
end)

