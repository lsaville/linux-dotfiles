function hi()
    hs.alert.show('hello world')
end
hi()

local hyper = {'shift', 'cmd', 'ctrl', 'alt'}
-- hs.hotkey.bind(hyper, 'r', hi)
hs.hotkey.bind(hyper, 'l', function()
    hs.alert.show('hello world')
    -- Save old clipboard, then copy
    -- local old = hs.pasteboard.getContents()

    -- -- Wait for the clipboard to update
    -- local clipboardCount = hs.pasteboard.changeCount()
    -- hs.eventtap.keyStroke({'cmd'}, 'c', 0)
    -- hs.timer.waitWhile(
    --     function()
    --         return hs.pasteboard.changeCount() == clipboardCount
    --     end,
    --     function()
    --         -- Retrieve clipboard, restore old clipboard
    --         local query = hs.pasteboard.getContents()
    --         hs.pasteboard.setContents(old)

    --         -- Open link
    --         CMD = 'open https://livegrep.corp.stripe.com/search/stripe?q='
    --         hs.execute(CMD .. hs.http.encodeForQuery(query))
    --     end,
    --     0.1
    -- )
end)
