-- Everything related to window managment
local awful     = require("awful")
-- Theme handling library
local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi
-- Widget and layout library
local wibox     = require("wibox")
local gears     = require("gears")
-- our aw-menu
local awmenu    = require("config.menu")
-- buttons
local buttons   = require("config.buttons")


-- user custom widgets
local battery_widget    = require("awesome-wm-widgets.battery-widget.battery")
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")


local function get_calendar()
    local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
    -- Create a textclock widget
    local mytextclock     = wibox.widget.textclock("%a %b %d, %I:%M %p")
    -- or customized
    local cw              = calendar_widget({
        theme = 'nord',
        placement = 'top_right',
        start_sunday = true,
        radius = 8,
        -- with customized next/previous (see table above)
        previous_month_button = 4,
        next_month_button = 5,
    })
    mytextclock:connect_signal("button::press",
                               function(_, _, _, button) if button == 1 then cw.toggle() end end)
    return mytextclock;
end

-- calendar
local mytextclock = get_calendar()

--cpu
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
-- mem
local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")
-- freespace
local fs_widget = require("awesome-wm-widgets.fs-widget.fs-widget")
-- updates
local pacman_widget = require('awesome-wm-widgets.pacman-widget.pacman')

local function margin(widget, left, right, top, bottom, border)
    return wibox.container.margin(widget,
                                  dpi(left),
                                  dpi(right),
                                  dpi(top),
                                  dpi(bottom),
                                  border)
end

local function vmargin(widget, v)
    return margin(widget, 0, 0, v, v, nil)
end

local function hmargin(widget, h)
    return margin(widget, h, h, 0, 0, nil)
end

local function underline(widget, v)
    return vmargin(margin(widget, 0, 0, 0, 1, beautiful.border_focus), v)
end



--  widgets
return {
    -- main launcher (single instance)
    launcher       = function()
        return awful.widget.launcher({ image = beautiful.awesome_icon, menu = awmenu })
    end,
    -- promptbox for each screen
    promptbox      = function() return awful.widget.prompt({ prompt = "| Run: " }) end,
    -- an imagebox widget which will contain an icon indicating which layout we're using.
    -- pass current screen as a parameter
    layoutbox      = function(s)
        local layout_box = awful.widget.layoutbox(s)
        --set mouse button mappings
        layout_box:buttons(buttons.layoutbox_buttons)
        return underline(layout_box, 5)
    end,
    -- tag list widget
    taglist        = function(s)
        -- Create a taglist widget
        return vmargin(awful.widget.taglist({
                           screen  = s,
                           filter  = awful.widget.taglist.filter.all,
                           buttons = buttons.taglist_buttons,
                           layout  = { spacing = 3, layout = wibox.layout.fixed.horizontal },
                           style   = {
                               shape = function(cr, width, height)
                                   return gears.shape.rounded_rect(cr, width, height, 3)
                               end
                           }
                       }), 5)
    end,
    --tasklist widget
    tasklist       = function(s)
        -- Create a tasklist widget
        return vmargin(awful.widget.tasklist({
                           screen          = s,
                           filter          = awful.widget.tasklist.filter.currenttags,
                           buttons         = buttons.tasklist_buttons,
                           layout          = {
                               spacing = 15,
                               layout = wibox.layout.flex.horizontal,
                               spacing_widget = {
                                   {
                                       forced_width = 5,
                                       shape        = gears.shape.circle,
                                       widget       = wibox.widget.separator
                                   },
                                   valign = 'center',
                                   halign = 'center',
                                   widget = wibox.container.place,
                               },
                           },
                           style           = {
                               shape_border_width = 0.5,
                               shape_border_color = beautiful.fg_normal,
                               shape = function(cr, width, height)
                                   return gears.shape.rounded_rect(cr, width, height, 5)
                               end
                           },
                           widget_template = {
                               {
                                   {
                                       {
                                           { id = 'icon_role', widget = wibox.widget.imagebox, },
                                           margins = 2,
                                           widget  = wibox.container.margin,
                                       },
                                       { id = 'text_role', widget = wibox.widget.textbox, },
                                       spacing = 2,
                                       layout = wibox.layout.fixed.horizontal,
                                   },
                                   left   = 10,
                                   right  = 10,
                                   widget = wibox.container.margin
                               },
                               id     = 'background_role',
                               widget = wibox.container.background,
                           }
                       }), 5)
    end,
    -- Keyboard map indicator and switcher (single instance)
    keyboardlayout = awful.widget.keyboardlayout(),
    -- the system tray (single instance)
    systray        = vmargin(wibox.widget.systray(), 5),
    -- wibox (bar) all widgets needs to be setup on this
    wibar          = function(s)
        return awful.wibar(
            {
                position = "top",
                screen = s,
                height = 35,
                opacity = 0.8,
                shape = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, 12)
                end,
                border_width = 3,
            }
        )
    end,
    -- battery
    bat            = underline(battery_widget({ show_current_level = true }), 5),
    -- brightness
    brightness     = underline(brightness_widget {
                                   program = "brightnessctl",
                                   percentage = true,
                                   type = "icon_and_text"
                               }, 5),
    -- calendar
    calendar       = underline(mytextclock, 5),
    -- cpu
    cpu            = underline(cpu_widget({ timeout = 2 }), 5),
    -- mem
    mem            = underline(ram_widget({ timeout = 2 }), 5),
    -- freespace
    fs             = underline(fs_widget({ mounts = { "/", "/home" } }), 5),
    -- pacman updates
    pacman         = underline(pacman_widget({
                                   interval = 1800, -- Refresh every 10 minutes
                                   popup_bg_color = '#222222',
                                   popup_border_width = 1,
                                   popup_border_color = '#7e7e7e',
                                   popup_height = 10, -- 10 packages shown in scrollable window
                                   popup_width = 300,
                                   --polkit_agent_path = '/usr/lib/xfce-polkit/xfce-polkit'
                               }), 5),
    sep            = function(h, text)
        return hmargin(wibox.widget {
                           widget = wibox.widget.textbox,
                           text = text,
                       }, h)
    end,
    primary_sep    = function(h, text)
        local sep = awful.widget.only_on_screen(hmargin(wibox.widget {
                                                            widget = wibox.widget.textbox,
                                                            text = text,
                                                        }, h));
        sep.screen = "primary"
        return sep
    end
}
