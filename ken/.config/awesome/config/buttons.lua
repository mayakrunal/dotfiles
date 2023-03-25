-- Utilities such as color parsing and objects
local gears   = require("gears")
-- Everything related to window managment
local awful   = require("awful")
-- aw-menu
local awmenu  = require("config.menu")
-- our variables
local vars    = require("config.vars")
-- global c variable
local client  = client

-- module table
local buttons = {}

--internal won't be exposed
local fns     = {
    g_mouse         = {
        -- show main menu
        toggle_mainmenu = function() awmenu:toggle() end,
        -- view previous tag
        tag_prev        = awful.tag.viewprev,
        -- view next tag
        tag_next        = awful.tag.viewnext,
    },
    -- client mouse bind functions
    c_mouse         = {
        -- activate and raise client
        raise_client  = function(c)
            c:emit_signal("request::activate", "mouse_click",
                          { raise = true })
        end,
        -- move client
        move_client   = function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.move(c)
        end,
        -- resize client
        resize_client = function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.resize(c)
        end
    },
    -- function to map the mouse buttons to layoutbox
    layoutbox_mouse = {
        -- switch to next layout
        layout_next = function() awful.layout.inc(1) end,
        -- switch to prev layout
        layout_prv = function() awful.layout.inc(-1) end
    },
    -- functions which will bind to the tag mouse button events on
    tags_mouse      = {
        -- click to view the tag
        view_only   = function(t) t:view_only() end,
        -- move client window to tag
        move_to_tag = function(t) if client.focus then client.focus:move_to_tag(t) end end,
        --- toggle the tag view / not view
        toggle_tag  = function(t) if client.focus then client.focus:toggle_tag(t) end end,
        -- toggle the tag view
        viewtoggle  = awful.tag.viewtoggle,
        -- next tag on screen
        viewnext    = function(t) awful.tag.viewnext(t.screen) end,
        -- prev tag on screen
        viewprev    = function(t) awful.tag.viewprev(t.screen) end,
    },
    -- fuctions which will be binded to the tasklist mouse buttons
    tasklist_mouse  = {
        -- minimize or raise the client window
        min_or_raise      = function(c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", { raise = true })
            end
        end,
        -- right click show the menu client list
        menu_client_list  = function() awful.menu.client_list({ theme = { width = 250 } }) end,
        -- focus next client window
        client_focus_next = function() awful.client.focus.byidx(1) end,
        -- focus prev client window
        client_focus_prev = function() awful.client.focus.byidx(-1) end
    }
}



-- global mouse buttons
buttons.globals = gears.table.join(
    awful.button({}, 3, fns.g_mouse.toggle_mainmenu),
    awful.button({}, 8, fns.g_mouse.tag_next),
    awful.button({}, 9, fns.g_mouse.tag_prev)
)

-- client mouse buttons
buttons.client = gears.table.join(
    awful.button({}, 1, fns.c_mouse.raise_client),
    awful.button({ vars.modkey }, 1, fns.c_mouse.move_client),
    awful.button({ vars.modkey }, 3, fns.c_mouse.resize_client)
)

-- make title bar buttons for each client (new ones for each instance)
buttons.titlebar = function(c)
    return gears.table.join(
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.resize(c)
        end)
    )
end

-- get mouse button mappings for the layout box
buttons.layoutbox_buttons = gears.table.join(
    awful.button({}, 1, fns.layoutbox_mouse.layout_next),
    awful.button({}, 3, fns.layoutbox_mouse.layout_prv),
    awful.button({}, 8, fns.layoutbox_mouse.layout_next),
    awful.button({}, 9, fns.layoutbox_mouse.layout_prv)
)


-- Mouse button mappings for the tag list
buttons.taglist_buttons = gears.table.join(
    awful.button({}, 1, fns.tags_mouse.view_only),
    awful.button({ vars.modkey }, 1, fns.tags_mouse.move_to_tag),
    awful.button({}, 3, fns.tags_mouse.viewtoggle),
    awful.button({ vars.modkey }, 3, fns.tags_mouse.toggle_tag),
    awful.button({}, 8, fns.tags_mouse.viewnext),
    awful.button({}, 9, fns.tags_mouse.viewprev)
)

-- mouse button mappings for the tasklist
buttons.tasklist_buttons = gears.table.join(
    awful.button({}, 1, fns.tasklist_mouse.min_or_raise),
    awful.button({}, 3, fns.tasklist_mouse.menu_client_list),
    awful.button({}, 8, fns.tasklist_mouse.client_focus_next),
    awful.button({}, 9, fns.tasklist_mouse.client_focus_prev)
)
return buttons
