-- Settings
local applications = { "Google Chrome" }
local discordFrame = { screen = "Built", x = 0, y = 557, w = 695, h = 515 }
local fbMessengerFrame = { screen = "ASUS", x = -65, y = 0, w = 541, h = 409 }
local windowFrames = {
	["Discord"] = discordFrame,
	["Messenger"] = fbMessengerFrame,
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
local chromeFilter = hs.window.filter.new(false)
for _, app in ipairs(applications) do
    chromeFilter:setAppFilter(app)
end

chromeFilter:subscribe(hs.window.filter.windowCreated, function(win)
	for titleKeyword, frame in pairs(windowFrames) do
		if win:title():find(titleKeyword, 1, true) then
			enforceFrame(win, frame)
		end
	end
end)

chromeFilter:subscribe(hs.window.filter.windowFocused, function(win)
	for titleKeyword, frame in pairs(windowFrames) do
		if win:title():find(titleKeyword, 1, true) then
			enforceFrame(win, frame)
		end
	end
end)

chromeFilter:subscribe(hs.window.filter.windowMoved, function(win)
	for titleKeyword, frame in pairs(windowFrames) do
		if win:title():find(titleKeyword, 1, true) then
			enforceFrame(win, frame)
		end
	end
end)
