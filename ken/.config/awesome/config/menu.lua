-- Everything related to window managment
local awful         = require("awful")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup")
-- Theme handling library
local beautiful     = require("beautiful")
-- our variables
local vars          = require("config.vars")

local freedesktop   = require("freedesktop")
-- global c variable
local awesome       = awesome


--(This is for rare case in you use awful's menubar with mod + ctrl + shift + d) (right now we are using rofi)
-- XDG Application menu implementation
local menubar          = require("menubar")
-- Set the terminal for applications that require it
menubar.utils.terminal = vars.terminal

-- menubar binding commands
local menu_cmds        = {
    -- function to show hotkeys
    hotkeys     = function() hotkeys_popup.show_help(nil, awful.screen.focused()) end,
    -- terminal editor command
    editor_cmd  = vars.terminal .. " -e " .. vars.editor,
    -- manual pages for awesome command
    manual      = vars.terminal .. " -e man awesome",
    -- edit the awesome config file command
    edit_config = vars.terminal .. " -e " .. vars.editor .. " " .. awesome.conffile,
    -- restart awesome command
    restart     = awesome.restart,
    -- quit awesome
    quit        = function() awesome.quit() end
}


-- main menu (we put only need one instance of this)
return freedesktop.menu.build({
    before = {
        {
            -- awesome menu entries
            "awesome",
            {
                { "hotkeys",     menu_cmds.hotkeys, },
                { "manual",      menu_cmds.manual },
                { "edit config", menu_cmds.edit_config },
                { "restart",     menu_cmds.restart },
                { "quit",        menu_cmds.quit, },
            },
            beautiful.awesome_icon
        }
    },
    after = { { "open terminal", vars.terminal } },
})
