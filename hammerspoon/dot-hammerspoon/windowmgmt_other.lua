-- Settings
local applications = { "WezTerm", "Slack", "Feishin", "Element", "Discord" }
local discordFrame = { screen = "Built", x = 0, y = 0, w = 800, h = 500 }
local weztermFrame = { screen = "Built", x = 800, y = 0, w = 910, h = 500 }
local musicFrame = { screen = "ASUS", x = 0, y = 409, w = 992, h = 640 }
local slackFrame = { screen = "ASUS", x = 992, y = 0, w = 930, h = 525 }
local matrixFrame = { screen = "ASUS", x = 992, y = 525, w = 930, h = 523 }
local windowFrames = {
        ["Discord"] = discordFrame,
        ["WezTerm"] = weztermFrame,
        ["Slack"] = slackFrame,
        ["Feishin"] = musicFrame,
        ["Element"] = matrixFrame,
}


-- Local Functions
local function targetScreen(screenName)
	return hs.screen.find(screenName)
end

local function absFrame(frame)
	local s = targetScreen(frame.screen)
	if not s then
		return frame
	end
	local sf = s:frame()
	return { x = sf.x + frame.x, y = sf.y + frame.y, w = frame.w, h = frame.h }
end

local function enforceFrame(win, frame)
	if not win or not win:isStandard() then
		return
	end
        local screens = hs.screen.allScreens()
        if #screens <= 1 then
                return
        end
	local f = absFrame(frame)
	for i = 0, 3 do
		hs.timer.doAfter(0.2 * i, function()
			if win:isStandard() then
				win:setFrame(f)
			end
		end)
	end
end

-- Event subscription
local otherFilter = hs.window.filter.new(false)
for _, app in ipairs(applications) do
    otherFilter:setAppFilter(app)
end

otherFilter:subscribe(hs.window.filter.windowCreated, function(win)
        local app = win:application():name()
        local frame = windowFrames[app]

        enforceFrame(win, frame)
end)

otherFilter:subscribe(hs.window.filter.windowFocused, function(win)
        local app = win:application():name()
        local frame = windowFrames[app]
        print(app)

        enforceFrame(win, frame)
end)

otherFilter:subscribe(hs.window.filter.windowMoved, function(win)
        local app = win:application():name()
        local frame = windowFrames[app]

        enforceFrame(win, frame)
end)
