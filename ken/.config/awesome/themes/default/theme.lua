---------------------------
-- Default awesome theme --
---------------------------

local theme_assets  = require("beautiful.theme_assets")
local xresources    = require("beautiful.xresources")
local dpi           = xresources.apply_dpi

local gfs           = require("gears.filesystem")
local gears         = require("gears")
local themes_path   = gfs.get_themes_dir()

local theme         = {}

theme.font          = "Nerd Hack Font 10"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#ABB2BF"
theme.fg_focus      = "#46d9ff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(3)
theme.border_width  = dpi(1.5)
theme.border_normal = "#000000"
theme.border_focus  = "#61AFEF"
theme.border_marked = "#91231c"


-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:

-- theme.taglist_squares_sel   = theme_assets.taglist_squares_sel(
--         taglist_square_size, theme.fg_normal

-- )

theme.taglist_squares_sel   = gears.surface.load_from_shape(27, 2, gears.shape.rounded_rect,
                                                            theme.border_focus)

theme.taglist_squares_unsel = gears.surface.load_from_shape(27, 2, gears.shape.rounded_rect,
                                                            theme.fg_normal)



theme.systray_icon_spacing = 2

theme.hotkeys_group_margin = 3


-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon                         = themes_path .. "default/submenu.png"
theme.menu_height                               = dpi(15)
theme.menu_width                                = dpi(200)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

local titlebar_path                             = "default/titlebar"

-- Define the image to load
theme.titlebar_close_button_normal              = themes_path .. titlebar_path .. "/close_normal.png"
theme.titlebar_close_button_focus               = themes_path .. titlebar_path .. "/close_focus.png"

theme.titlebar_minimize_button_normal           = themes_path .. titlebar_path .. "/minimize_normal.png"
theme.titlebar_minimize_button_focus            = themes_path .. titlebar_path .. "/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive     = themes_path .. titlebar_path .. "/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = themes_path .. titlebar_path .. "/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = themes_path .. titlebar_path .. "/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = themes_path .. titlebar_path .. "/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive    = themes_path .. titlebar_path .. "/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = themes_path .. titlebar_path .. "/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = themes_path .. titlebar_path .. "/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = themes_path .. titlebar_path .. "/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive  = themes_path .. titlebar_path .. "/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = themes_path .. titlebar_path .. "/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = themes_path .. titlebar_path .. "/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = themes_path .. titlebar_path .. "/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. titlebar_path .. "/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. titlebar_path .. "/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = themes_path .. titlebar_path .. "/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = themes_path .. titlebar_path .. "/maximized_focus_active.png"

-- we disabled the wallpaper to let nitrogen handle it
--theme.wallpaper = themes_path.."default/background.png"

-- You can use your own layout icons like this:
theme.layout_fairh                              = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv                              = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating                           = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier                          = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max                                = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen                         = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom                         = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft                           = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile                               = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop                            = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral                             = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle                            = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw                           = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne                           = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw                           = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse                           = themes_path .. "default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon                              = theme_assets.awesome_icon(
        theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme                                = nil

--theme.taglist_font                              = "CaskaydiaCove Nerd Font Mono, Extra Light 15"
theme.taglist_font                              = "Nerd Hack Font Mono, Regular 20"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
