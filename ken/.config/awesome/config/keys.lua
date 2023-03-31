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
    -- focus client window
    client_focus_up = function() awful.client.focus.bydirection("up") end,
    client_focus_down = function() awful.client.focus.bydirection("down") end,
    client_focus_left = function() awful.client.focus.bydirection("left") end,
    client_focus_right = function() awful.client.focus.bydirection("right") end,
    -- swap with  client
    client_swap_up = function() awful.client.swap.bydirection("up") end,
    client_swap_down = function() awful.client.swap.bydirection("down") end,
    client_swap_left = function() awful.client.swap.bydirection("left") end,
    client_swap_right = function() awful.client.swap.bydirection("right") end,
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
    -- focus next screen
    focus_screen_next = function() awful.screen.focus_relative(1) end,
    -- focus prev screen
    focus_screen_prev = function() awful.screen.focus_relative(-1) end,
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
    show_menubar = function() menubar.show() end,
    -- generic function which returns a spawn func
    spawn_fun = function(cmd)
        return function() return awful.spawn(cmd) end
    end,
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
    move_to_master = function(c) c:swap(awful.client.getmaster()) end,
    -- move to screen
    move_to_screen = function(c)
        local index = c.first_tag.index
        c:move_to_screen()
        local tag = c.screen.tags[index]
        c:move_to_tag(tag)
        --if tag then tag:view_only() end
    end,
    -- keep on top
    keep_on_top = function(c) c.ontop = not c.ontop end,
    -- keep on top
    sticky = function(c) c.sticky = not c.sticky end,
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
-- Awesome specific keys
    awful.key({ vars.modkey },
              "F1",
              fns.g_keys.hotkeys,
              { description = "show help", group = "awesome", }),
    awful.key({ vars.modkey },
              "w",
              fns.g_keys.toggle_mainmenu,
              { description = "show main menu", group = "awesome", }),
    awful.key({ vars.modkey, vars.ctrlkey },
              "r",
              fns.g_keys.awesome_restart,
              { description = "reload awesome", group = "awesome", }),
    awful.key({ vars.modkey, "Shift" },
              "q",
              fns.g_keys.awesome_quit,
              { description = "quit awesome", group = "awesome" }),
    awful.key({ vars.modkey },
              "x",
              fns.g_keys.lua_exec_prompt,
              { description = "lua execute prompt", group = "awesome" }),

    -- Switch focus between windows in current stack pane
    awful.key({ vars.modkey },
              "Up",
              fns.g_keys.client_focus_up,
              { description = "focus client up", group = "client" }),
    awful.key({ vars.modkey },
              "Down",
              fns.g_keys.client_focus_down,
              { description = "focus client down", group = "client" }),
    awful.key({ vars.modkey },
              "Left",
              fns.g_keys.client_focus_left,
              { description = "focus client left", group = "client" }),
    awful.key({ vars.modkey },
              "Right",
              fns.g_keys.client_focus_right,
              { description = "focus client right", group = "client" }),

    -- Move windows up or down in current stack
    awful.key({ vars.modkey, vars.ctrlkey },
              "Up",
              fns.g_keys.client_swap_up,
              { description = "swap client up", group = "client" }),
    awful.key({ vars.modkey, vars.ctrlkey },
              "Down",
              fns.g_keys.client_swap_down,
              { description = "swap client down", group = "client" }),
    awful.key({ vars.modkey, vars.ctrlkey },
              "Left",
              fns.g_keys.client_swap_left,
              { description = "swap client left", group = "client" }),
    awful.key({ vars.modkey, vars.ctrlkey },
              "Right",
              fns.g_keys.client_swap_right,
              { description = "swap client right", group = "client" }),

    -- Change window sizes (master size , num and columns)
    awful.key({ vars.modkey },
              "KP_Add",
              fns.g_keys.master_width_inc,
              { description = "increase master width factor", group = "layout" }),
    awful.key({ vars.modkey },
              "KP_Subtract",
              fns.g_keys.master_width_dec,
              { description = "decrease master width factor", group = "layout" }),
    awful.key({ vars.modkey, vars.shiftkey },
              "KP_Add",
              fns.g_keys.master_client_inc,
              { description = "increase the number of master clients", group = "layout" }),
    awful.key({ vars.modkey, vars.shiftkey },
              "KP_Subtract",
              fns.g_keys.master_client_dec,
              { description = "decrease the number of master clients", group = "layout" }),
    awful.key({ vars.modkey, vars.ctrlkey },
              "KP_Add",
              fns.g_keys.column_inc,
              { description = "increase the number of columns", group = "layout" }),
    awful.key({ vars.modkey, vars.ctrlkey },
              "KP_Subtract",
              fns.g_keys.column_dec,
              { description = "decrease the number of columns", group = "layout" }),

    -- Switch focus of monitors
    awful.key({ vars.modkey },
              "Prior",
              fns.g_keys.focus_screen_next,
              { description = "focus the next screen", group = "screen" }),
    awful.key({ vars.modkey },
              "Next",
              fns.g_keys.focus_screen_prev,
              { description = "focus the previous screen", group = "screen" }),

    -- Toggle between different layouts
    awful.key({ vars.modkey },
              "Tab",
              fns.g_keys.layout_next,
              { description = "select next", group = "layout", }),
    awful.key({ vars.modkey, vars.shiftkey },
              "Tab",
              fns.g_keys.layout_prv,
              { description = "select previous", group = "layout" }),

    -- jump to urgent
    awful.key({ vars.modkey },
              "u",
              fns.g_keys.client_jumpto_urgent,
              { description = "jump to urgent client", group = "client", }),

    -- restore minimized
    awful.key({ vars.modkey, vars.ctrlkey },
              "n",
              fns.g_keys.client_restore,
              { description = "restore minimized", group = "client" }),

    -- Hardware keys
    awful.key({},
              "XF86AudioMute",
              fns.g_keys.spawn_fun(vars.muteaudio),
              { description = "mute audio", group = "hardware" }),
    awful.key({},
              "XF86AudioLowerVolume",
              fns.g_keys.spawn_fun(vars.decreaseaudio),
              { description = "decrease audio", group = "hardware" }),
    awful.key({},
              "XF86AudioRaiseVolume",
              fns.g_keys.spawn_fun(vars.increaseaudio),
              { description = "increase audio", group = "hardware" }),
    awful.key({},
              "XF86MonBrightnessUp",
              fns.g_keys.spawn_fun(vars.brightnessup),
              { description = "incrase brightness", group = "hardware" }),
    awful.key({},
              "XF86MonBrightnessDown",
              fns.g_keys.spawn_fun(vars.brightnessdown),
              { description = "decrease brightness", group = "hardware" }),
    awful.key({},
              "Print",
              fns.g_keys.spawn_fun(vars.screenshot),
              { description = "Take a ScreenShot", group = "hardware" }),

    -- Standard program (Launchers)
    awful.key({ vars.modkey },
              "r",
              fns.g_keys.run_prompt, -- prompt
              { description = "run prompt", group = "launcher" }),
    awful.key({ vars.modkey },
              "d",
              fns.g_keys.spawn_fun(vars.rofi_drun), -- rofi launcher
              { description = "Rofi Drun", group = "launcher" }),
    awful.key({ vars.modkey, vars.shiftkey },
              "d",
              fns.g_keys.spawn_fun(vars.rofi_wnav), -- rofi window nav
              { description = "Rofi Switch Window", group = "launcher" }),
    awful.key({ vars.modkey, vars.ctrlkey, vars.shiftkey },
              "d",
              fns.g_keys.show_menubar, -- Menubar
              { description = "show the menubar (awesome lib) (a bit ugly)", group = "launcher" }),
    awful.key({ vars.modkey },
              "Escape",
              fns.g_keys.spawn_fun(vars.powermenu), -- rofi powermenu
              { description = "Rofi powermenu", group = "launcher" }),
    awful.key({ vars.modkey },
              "p",
              fns.g_keys.spawn_fun(vars.screenlayout), -- rofi screen layout
              { description = "Rofi screenlayout", group = "launcher" }),
    awful.key({ vars.modkey },
              "Return",
              fns.g_keys.spawn_fun(vars.terminal), --terminal
              { description = "open a terminal", group = "launcher" }),
    awful.key({ vars.modkey },
              "KP_Enter",
              fns.g_keys.spawn_fun(vars.terminal), --terminal
              { description = "open a terminal", group = "launcher" }),
    -- Apps
    awful.key({ vars.modkey, vars.altkey },
              "f",
              fns.g_keys.spawn_fun(vars.browser), --firefox
              { description = "open a Browser", group = "launcher" }),
    awful.key({ vars.modkey, vars.altkey },
              "e",
              fns.g_keys.spawn_fun(vars.filexplorer), -- thunar file manager
              { description = "open a file explorer", group = "launcher" }),
    awful.key({ vars.modkey, vars.altkey },
              "c",
              fns.g_keys.spawn_fun(vars.vscode), -- vs code
              { description = "open vs code", group = "launcher" }),
    awful.key({ vars.modkey, vars.altkey },
              "v",
              fns.g_keys.spawn_fun(vars.vpn), --vpn
              { description = "open vpn", group = "launcher" }),
    awful.key({ vars.modkey, vars.altkey },
              "a",
              fns.g_keys.spawn_fun(vars.audiomixer), -- pavucontrol
              { description = "open audio mixer", group = "launcher" })

-- dont need this i find it better to use mod + num to switch to tag
-- awful.key({ vars.modkey },
--           "Left",
--           fns.g_keys.tag_prev,
--           { description = "view previous", group = "tag" }),
-- awful.key({ vars.modkey },
--           "Right",
--           fns.g_keys.tag_next,
--           { description = "view next", group = "tag", }),
-- this one as well i'll bind it to the rofi power menu
-- awful.key({ vars.modkey },
--           "Escape",
--           fns.g_keys.tag_go_back,
--           { description = "go back", group = "tag" }),
-- no need (i use mod tab for layout switching)
-- awful.key({ vars.modkey },
--           "Tab",
--           fns.g_keys.client_go_back,
--           { description = "go back", group = "client" })
)


local np_map = { 87, 88, 89, 83, 84, 85, 79, 80, 81 }

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
                --move to tag and switch to it
                client.focus:move_to_tag(t)
                t:view_only()
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
                  "#" .. np_map[i],
                  viewonly,
                  { description = "view tag #" .. i, group = "tag" }),
        -- Toggle tag display.
        awful.key({ vars.modkey, vars.ctrlkey },
                  "#" .. i + 9,
                  toggletag,
                  { description = "toggle tag #" .. i, group = "tag" }),
        awful.key({ vars.modkey, vars.ctrlkey },
                  "#" .. np_map[i],
                  toggletag,
                  { description = "toggle tag #" .. i, group = "tag" }),
        -- Move client to tag.
        awful.key({ vars.modkey, vars.shiftkey },
                  "#" .. i + 9,
                  move_to_tag,
                  { description = "move focused client to tag #" .. i, group = "tag" }),
        awful.key({ vars.modkey, vars.shiftkey },
                  "#" .. np_map[i],
                  move_to_tag,
                  { description = "move focused client to tag #" .. i, group = "tag" })
    -- Toggle tag on focused client. (not gonna use this can just move the window to there)
    -- awful.key({ vars.modkey, vars.ctrlkey, vars.shiftkey },
    --           "#" .. i + 9,
    --           toggle_tag_focused_client,
    --           { description = "toggle focused client on tag #" .. i, group = "tag" }),
    -- awful.key({ vars.modkey, vars.ctrlkey, vars.shiftkey },
    --           "#" .. np_map[i],
    --           toggle_tag_focused_client,
    --           { description = "toggle focused client on tag #" .. i, group = "tag" })
    )
end



-- client windows keys mapping table
keys.client = gears.table.join(
    awful.key({ vars.modkey },
              "f",
              fns.c_keys.toggle_fullscreen,
              { description = "toggle fullscreen", group = "client" }),
    awful.key({ vars.modkey },
              "q",
              fns.c_keys.close,
              { description = "close", group = "client", }),
    awful.key({ vars.modkey, vars.ctrlkey },
              "f",
              fns.c_keys.toggle_floating,
              { description = "toggle floating", group = "client" }),

    -- awful.key({ vars.modkey, vars.ctrlkey },
    --           "Return",
    --           fns.c_keys.move_to_master,
    --           { description = "move to master", group = "client" }),
    awful.key({ vars.modkey, vars.ctrlkey },
              "Prior",
              fns.c_keys.move_to_screen,
              { description = "move to screen", group = "client", }),
    awful.key({ vars.modkey, vars.ctrlkey },
              "Next",
              fns.c_keys.move_to_screen,
              { description = "move to screen", group = "client", }),
    awful.key({ vars.modkey },
              "t",
              fns.c_keys.keep_on_top,
              { description = "toggle keep on top", group = "client" }),
    awful.key({ vars.modkey },
              "s",
              fns.c_keys.sticky,
              { description = "make client sticky", group = "client" }),
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
