-- === SETTINGS ===
local screenName = "ASUS"
local terminalFrame = { x = 945, y = 0, w = 974, h = 639 }
local feishinFrame = { x = 850, y = 0, w = 938, h = 639 }

local windowFrames = {
	["WezTerm"] = terminalFrame,
	["Feishin"] = feishinFrame,
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

local otherFilter = hs.window.filter.new(false):setAppFilter("Feishin"):setAppFilter("WezTerm")

otherFilter:subscribe(hs.window.filter.windowCreated, function(win)
	local app = win:application():name()
	local frame = windowFrames[app]

	enforceFrame(win, frame)
end)

otherFilter:subscribe(hs.window.filter.windowFocused, function(win)
	local app = win:application():name()
	local frame = windowFrames[app]

	enforceFrame(win, frame)
end)

otherFilter:subscribe(hs.window.filter.windowMoved, function(win)
	local app = win:application():name()
	local frame = windowFrames[app]

	enforceFrame(win, frame)
end)
