local function shellOpenInFirefox(url)
    -- escape quotes so open command works
    local u = url:gsub('"', '\\"')
    local cmd = string.format('open -a "Firefox" "%s"', u)
    hs.task.new("/bin/sh", nil, { "-c", cmd }):start()
end

local function getChromeTabURLsAsync(callback)
    local jxa = [[
        (function() {
            var chrome = Application("Google Chrome");
	    var excluded = [
		"discord.com",
		"messenger.com",
		"twitch.tv/popout",
		"steamcommunity.com/chat"
	    ];
            var urls = [];
            if (chrome.running()) {
                chrome.windows().forEach(function(window) {
                    window.tabs().forEach(function(tab) {
                        var url = tab.url();
 	                if (!excluded.some(ex => url.includes(ex))) {
        	            urls.push(url);
                	}
                    });
                });
                chrome.windows().forEach(function(window) {
                    window.tabs().forEach(function(tab) {
                        var url = tab.url();
                	if (!excluded.some(ex => url.includes(ex))) {
           	             tab.close();
   	                }
                    });
                });
            }
            return JSON.stringify(urls);
        })();
    ]]

    local task = hs.task.new(
        "/usr/bin/osascript",
        function(exitCode, stdOut, stdErr)
            if exitCode ~= 0 or not stdOut then
                callback({})
                return
            end
            local ok, decoded = pcall(hs.json.decode, stdOut)
            if not ok or not decoded then
                callback({})
                return
            end
            callback(decoded)
        end,
        { "-l", "JavaScript", "-e", jxa }
    )
    task:start()
end

local debounce = false
local function forwardNewChromeWindows()
    if debounce then return end
    debounce = true
    hs.timer.doAfter(1, function() debounce = false end)

    getChromeTabURLsAsync(function(urls)
        for _, url in ipairs(urls) do
            pcall(shellOpenInFirefox, url)
        end
    end)
end

local wf = hs.window.filter.new("Google Chrome")
wf:subscribe(hs.window.filter.windowCreated, forwardNewChromeWindows)
