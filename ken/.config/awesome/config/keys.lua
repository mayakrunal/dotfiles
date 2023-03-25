-- Utilities such as color parsing and objects
local gears           = require("gears")
-- Everything related to window managment
local awful           = require("awful")
local hotkeys_popup   = require("awful.hotkeys_popup")
-- XDG Application menu implementation
local menubar         = require("menubar")

-- require vars
local vars            = require("config.vars")
-- aw-menu
local awmenu          = require("config.menu")
-- our tags
local tags            = require("config.tags")
-- global c variables
local awesome, client = awesome, client


-- module table
local keys = {}

-- varible to hold binding functions for keys ( will not expose outside)
local fns  = {}

-- global key binding functions
fns.g_keys = {
    -- show hotkeys help
    hotkeys = hotkeys_popup.show_help,
    -- view previous tag
    tag_prev = awful.tag.viewprev,
    -- view next tag
    tag_next = awful.tag.viewnext,
    -- go back (history tag)
    tag_go_back = awful.tag.history.restore,
    -- focus next client window
    client_focus_next = function() awful.client.focus.byidx(1) end,
    -- focus prev client window
    client_focus_prev = function() awful.client.focus.byidx(-1) end,
    -- client jumpto urgent
    client_jumpto_urgent = awful.client.urgent.jumpto,
    -- client go back
    client_go_back = function()
        awful.client.focus.history.previous()
        if client.focus then client.focus:raise() end
    end,
    -- client restore minimized
    client_restore = function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:emit_signal("request::activate", "key.unminimize",
                          { raise = true })
        end
    end,
    -- show main menu
    toggle_mainmenu = function() awmenu:toggle() end,
    -- swap with next client
    swap_client_next = function() awful.client.swap.byidx(1) end,
    -- swap with prev client
    swap_client_prev = function() awful.client.swap.byidx(-1) end,
    -- focus next screen
    focus_screen_next = function() awful.screen.focus_relative(1) end,
    -- focus prev screen
    focus_screen_prev = function() awful.screen.focus_relative(-1) end,
    -- open terminal
    open_terminal = function() awful.spawn(vars.terminal) end,
    -- restart awesome
    awesome_restart = awesome.restart,
    -- quit awesome
    awesome_quit = awesome.quit,
    -- master width factor increase
    master_width_inc = function() awful.tag.incmwfact(0.05) end,
    -- master width factor decrease
    master_width_dec = function() awful.tag.incmwfact(-0.05) end,
    -- master client increase
    master_client_inc = function() awful.tag.incnmaster(1, nil, true) end,
    -- master client decrease
    master_client_dec = function() awful.tag.incnmaster(-1, nil, true) end,
    -- increase num of column
    column_inc = function() awful.tag.incncol(1, nil, true) end,
    -- decrease num of column
    column_dec = function() awful.tag.incncol(-1, nil, true) end,
    -- switch to next layout
    layout_next = function() awful.layout.inc(1) end,
    -- switch to prev layout
    layout_prv = function() awful.layout.inc(-1) end,
    -- run prompt
    run_prompt = function() awful.screen.focused().mypromptbox:run() end,
    -- lua execute prompt
    lua_exec_prompt = function()
        awful.prompt.run({
            prompt = "Run Lua code: ",
            textbox = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() ..
                    "/history_eval",
        })
    end,
    -- show the menubar
    show_menubar = function() menubar.show() end
}


-- clint key binding functions
fns.c_keys = {
    -- toggle fullscreen
    toggle_fullscreen = function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end,
    -- kill window
    close = function(c) c:kill() end,
    -- toggle floating
    toggle_floating = awful.client.floating.toggle,
    -- move to master
    move_to_master = function(c) c.swap(awful.client.getmaster()) end,
    -- move to screen
    move_to_screen = function(c) c:move_to_screen() end,
    -- keep on top
    keep_on_top = function(c) c.ontop = not c.ontop end,
    -- minimize client
    minimize = function(c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
    end,
    -- (un)maximize client
    maximize = function(c)
        c.maximized = not c.maximized
        c:raise()
    end,
    -- (un)maximize vertical client
    maximize_vertical = function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
    end,
    -- (un)maximize horizontal client
    maximize_horizontal = function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
    end
}


-- create table for global keys bindings
keys.globals = gears.table.join(
    awful.key({ vars.modkey },
              "s",
              fns.g_keys.hotkeys,
              { description = "show help", group = "awesome", }),
    awful.key({ vars.modkey },
              "Left",
              fns.g_keys.tag_prev,
              { description = "view previous", group = "tag" }),
    awful.key({ vars.modkey },
              "Right",
              fns.g_keys.tag_next,
              { description = "view next", group = "tag", }),
    awful.key({ vars.modkey },
              "Escape",
              fns.g_keys.tag_go_back,
              { description = "go back", group = "tag" }),
    awful.key({ vars.modkey },
              "j",
              fns.g_keys.client_focus_next,
              { description = "focus next by index", group = "client" }),
    awful.key({ vars.modkey },
              "k",
              fns.g_keys.client_focus_prev,
              { description = "focus previous by index", group = "client" }),
    awful.key({ vars.modkey },
              "w",
              fns.g_keys.toggle_mainmenu,
              { description = "show main menu", group = "awesome", }),
    -- Layout manipulation
    awful.key({ vars.modkey, vars.shiftkey },
              "j",
              fns.g_keys.swap_client_next,
              { description = "swap with next client by index", group = "client" }),
    awful.key({ vars.modkey, vars.shiftkey },
              "k",
              fns.g_keys.swap_client_prev,
              { description = "swap with previous client by index", group = "client" }),
    awful.key({ vars.modkey, vars.ctrlkey },
              "j",
              fns.g_keys.focus_screen_next,
              { description = "focus the next screen", group = "screen" }),
    awful.key({ vars.modkey, vars.ctrlkey },
              "k",
              fns.g_keys.focus_screen_prev,
              { description = "focus the previous screen", group = "screen" }),
    awful.key({ vars.modkey },
              "u",
              fns.g_keys.client_jumpto_urgent,
              { description = "jump to urgent client", group = "client", }),
    awful.key({ vars.modkey },
              "Tab",
              fns.g_keys.client_go_back,
              { description = "go back", group = "client" }),
    -- Standard program
    awful.key({ vars.modkey },
              "Return",
              fns.g_keys.open_terminal,
              { description = "open a terminal", group = "launcher" }),
    awful.key({ vars.modkey, vars.ctrlkey },
              "r",
              fns.g_keys.awesome_restart,
              { description = "reload awesome", group = "awesome", }),
    awful.key({ vars.modkey, "Shift" },
              "q",
              fns.g_keys.awesome_quit,
              { description = "quit awesome", group = "awesome" }),
    awful.key({ vars.modkey },
              "l",
              fns.g_keys.master_width_inc,
              { description = "increase master width factor", group = "layout" }),
    awful.key({ vars.modkey },
              "h",
              fns.g_keys.master_width_dec,
              { description = "decrease master width factor", group = "layout" }),
    awful.key({ vars.modkey, vars.shiftkey },
              "h",
              fns.g_keys.master_client_inc,
              { description = "increase the number of master clients", group = "layout" }),
    awful.key({ vars.modkey, vars.shiftkey },
              "l",
              fns.g_keys.master_client_dec,
              { description = "decrease the number of master clients", group = "layout" }),
    awful.key({ vars.modkey, vars.ctrlkey },
              "h",
              fns.g_keys.column_inc,
              { description = "increase the number of columns", group = "layout" }),
    awful.key({ vars.modkey, vars.ctrlkey },
              "l",
              fns.g_keys.column_dec,
              { description = "decrease the number of columns", group = "layout" }),
    awful.key({ vars.modkey },
              "space",
              fns.g_keys.layout_next,
              { description = "select next", group = "layout", }),
    awful.key({ vars.modkey, vars.shiftkey },
              "space",
              fns.g_keys.layout_prv,
              { description = "select previous", group = "layout" }),
    awful.key({ vars.modkey, vars.ctrlkey },
              "n",
              fns.g_keys.client_restore,
              { description = "restore minimized", group = "client" }),
    -- Prompt
    awful.key({ vars.modkey },
              "r",
              fns.g_keys.run_prompt,
              { description = "run prompt", group = "launcher" }),
    awful.key({ vars.modkey },
              "x",
              fns.g_keys.lua_exec_prompt,
              { description = "lua execute prompt", group = "awesome" }),
    -- Menubar
    awful.key({ vars.modkey },
              "p",
              fns.g_keys.show_menubar,
              { description = "show the menubar", group = "launcher" })
)



-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9. (here we are limiting it to the num of tags)
-- we can not define function separately due to we needing the i in the iterate within function
-- basically we need to define function for each iteration (can not make it common)
for i = 1, #tags do
    local viewonly = function()
        local s = awful.screen.focused()
        local t = s.tags[i]
        if t then
            t:view_only()
        end
    end

    local toggletag = function()
        local s = awful.screen.focused()
        local t = s.tags[i]
        if t then
            awful.tag.viewtoggle(t)
        end
    end

    local move_to_tag = function()
        if client.focus then
            local t = client.focus.screen.tags[i]
            if t then
                client.focus:move_to_tag(t)
            end
        end
    end

    local toggle_tag_focused_client = function()
        if client.focus then
            local t = client.focus.screen.tags[i]
            if t then
                client.focus:toggle_tag(t)
            end
        end
    end
    keys.globals = gears.table.join(
        keys.globals,
        -- View tag only.
        awful.key({ vars.modkey },
                  "#" .. i + 9,
                  viewonly,
                  { description = "view tag #" .. i, group = "tag" }),
        awful.key({ vars.modkey },
                  "KP_" .. i,
                  viewonly,
                  { description = "view tag #" .. i, group = "tag" }),
        -- Toggle tag display.
        awful.key({ vars.modkey, vars.ctrlkey },
                  "#" .. i + 9,
                  toggletag,
                  { description = "toggle tag #" .. i, group = "tag" }),
        awful.key({ vars.modkey, vars.ctrlkey },
                  "KP_" .. i,
                  toggletag,
                  { description = "toggle tag #" .. i, group = "tag" }),
        -- Move client to tag.
        awful.key({ vars.modkey, vars.shiftkey },
                  "#" .. i + 9,
                  move_to_tag,
                  { description = "move focused client to tag #" .. i, group = "tag" }),
        awful.key({ vars.modkey, vars.shiftkey },
                  "KP_" .. i,
                  move_to_tag,
                  { description = "move focused client to tag #" .. i, group = "tag" }),
        -- Toggle tag on focused client.
        awful.key({ vars.modkey, vars.ctrlkey, vars.shiftkey },
                  "#" .. i + 9,
                  toggle_tag_focused_client,
                  { description = "toggle focused client on tag #" .. i, group = "tag" }),
        awful.key({ vars.modkey, vars.ctrlkey, vars.shiftkey },
                  "KP_" .. i,
                  toggle_tag_focused_client,
                  { description = "toggle focused client on tag #" .. i, group = "tag" })
    )
end



-- client windows keys mapping table
keys.client = gears.table.join(
    awful.key({ vars.modkey },
              "f",
              fns.c_keys.toggle_fullscreen,
              { description = "toggle fullscreen", group = "client" }),
    awful.key({ vars.modkey, vars.shiftkey },
              "c",
              fns.c_keys.close,
              { description = "close", group = "client", }),
    awful.key({ vars.modkey, vars.ctrlkey },
              "space",
              fns.c_keys.toggle_floating,
              { description = "toggle floating", group = "client" }),
    awful.key({ vars.modkey, vars.ctrlkey },
              "Return",
              fns.c_keys.move_to_master,
              { description = "move to master", group = "client" }),
    awful.key({ vars.modkey },
              "o",
              fns.c_keys.move_to_screen,
              { description = "move to screen", group = "client", }),
    awful.key({ vars.modkey },
              "t",
              fns.c_keys.keep_on_top,
              { description = "toggle keep on top", group = "client" }),
    awful.key({ vars.modkey },
              "n",
              fns.c_keys.minimize,
              { description = "minimize", group = "client" }),
    awful.key({ vars.modkey },
              "m",
              fns.c_keys.maximize,
              { description = "(un)maximize", group = "client" }),
    awful.key({ vars.modkey, vars.ctrlkey },
              "m",
              fns.c_keys.maximize_vertical,
              { description = "(un)maximize vertically", group = "client" }),
    awful.key({ vars.modkey, vars.shiftkey },
              "m",
              fns.c_keys.maximize_horizontal,
              { description = "(un)maximize horizontally", group = "client" })
)

return keys
