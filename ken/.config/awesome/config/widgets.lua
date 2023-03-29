-- Everything related to window managment
local awful     = require("awful")
-- Theme handling library
local beautiful = require("beautiful")
-- Utilities such as color parsing and objects
local gears     = require("gears")
-- Widget and layout library
local wibox     = require("wibox")
-- our aw-menu
local awmenu    = require("config.menu")
-- lain widgets
local lain      = require("lain")
--buttons
local buttons   = require("config.buttons")


--  widgets
return {
    -- main launcher (single instance)
    launcher = function()
        return awful.widget.launcher({ image = beautiful.awesome_icon, menu = awmenu })
    end,
    -- promptbox for each screen
    promptbox = function() return awful.widget.prompt() end,
    -- an imagebox widget which will contain an icon indicating which layout we're using.
    -- pass current screen as a parameter
    layoutbox = function(s)
        local layout_box = awful.widget.layoutbox(s)
        --set mouse button mappings
        layout_box:buttons(buttons.layoutbox_buttons)
        return layout_box
    end,
    -- tag list widget
    taglist = function(s)
        -- Create a taglist widget
        return awful.widget.taglist({
            screen = s,
            filter = awful.widget.taglist.filter.all,
            buttons = buttons.taglist_buttons,
        })
    end,
    --tasklist widget
    tasklist = function(s)
        -- Create a tasklist widget
        return awful.widget.tasklist({
            screen  = s,
            filter  = awful.widget.tasklist.filter.currenttags,
            buttons = buttons.tasklist_buttons,
        })
    end,
    -- Keyboard map indicator and switcher (single instance)
    keyboardlayout = awful.widget.keyboardlayout(),
    -- the system tray (single instance)
    systray = wibox.widget.systray(),
    -- a textclock widget (single instance)
    textclock = wibox.widget.textclock(),
    -- wibox (bar) all widgets needs to be setup on this
    wibar = function(s) return awful.wibar({ position = "top", screen = s }) end,
}
