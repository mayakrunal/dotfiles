-- Theme handling library
local beautiful  = require("beautiful")
-- Standard awesome library
-- Utilities such as color parsing and objects
local gears      = require("gears")
-- Everything related to window managment
local awful      = require("awful")
-- Widget and layout library
local wibox      = require("wibox")

-- widgets
local wi         = require("config.widgets")
local tags       = require("config.tags")
local scratchpad = require("config.scratchpad")

-- module table
local screen     = {}


-- function to draw the wallpaper to the screen
function screen.set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

function screen.connect_for_each_screen(s)
    -- Wallpaper
    screen.set_wallpaper(s)

    -- add the tags
    -- Each screen has its own tag table.
    for index, value in ipairs(tags) do
        value.props.screen = s --set the current screen
        awful.tag.add(value.name, value.props)
    end

    -- attach to screen so we can get it later for each screen
    s.mypromptbox = wi.promptbox()
    s.mytaglist = wi.taglist(s)
    s.mytasklist = wi.tasklist(s)
    s.mylayoutbox = wi.layoutbox(s)

    -- Create the wibar
    s.mywibar = wi.wibar(s)

    --dropdown terminal
    s.dropdown_terminal = scratchpad.terminal("dd_terminal_" .. s.index, s)

    -- Add widgets to the wibar
    s.mywibar:setup({
        layout = wibox.layout.align.horizontal,
        {
            -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --config.widgets.launcher(),
            wi.sep(5, ""),
            s.mytaglist,
            s.mypromptbox,
            wi.sep(5, "|"),
        },
        -- Middle widget
        s.mytasklist,
        {
            -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wi.primary_sep(5, "|"),
            wi.systray,
            wi.sep(5, "|"),
            wi.pacman,
            -- wi.sep(3, ""),
            -- wi.fs,
            -- wi.sep(3, ""),
            -- wi.cpu,
            -- wi.sep(3, ""),
            -- wi.mem,
            wi.sep(3, ""),
            wi.brightness,
            wi.sep(3, ""),
            wi.bat,
            wi.sep(3, ""),
            --config.widgets.keyboardlayout,
            wi.calendar,
            wi.sep(3, ""),
            s.mylayoutbox,
            wi.sep(5, ""),
        },
    })
end

return screen
