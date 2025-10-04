-- === SETTINGS ===
local screenName = "ASUS"
local discordFrame = { x = 920, y = 620, w = 1000, h = 580 }
local musicFrame = { x = 850, y = 0, w = 939, h = 588 }

local windowFrames = {
	["Discord"] = discordFrame,
	["Feishin"] = musicFrame,
}

-- === HELPERS ===
local function targetScreen()
	return hs.screen.find(screenName) or hs.screen.allScreens()[2]
end

local function absFrame(frame)
	local s = targetScreen()
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
	local f = absFrame(frame)
	for i = 0, 3 do
		hs.timer.doAfter(0.2 * i, function()
			if win:isStandard() then
				win:setFrame(f)
			end
		end)
	end
end

-- Subscribe to Chrome windows and place based on title
local chromeFilter = hs.window.filter.new(false):setAppFilter("Google Chrome")

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
