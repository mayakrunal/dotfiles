local awesome, client, screen, root = awesome, client, screen, root


-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Everything related to window managment
local awful = require("awful")
require("awful.autofocus")

-- Theme handling library
local beautiful  = require("beautiful")


-- selected theme path
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua",
								 os.getenv("HOME"),
								 "default") --select your theme

-- initiate the theme （make sure to init the theme first) before calling config
beautiful.init(theme_path)

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys.vim")

-- start error handling
require("errors")

-- get my configuration
local config           = require("config")



-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts   = config.layouts

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", config.screen.set_wallpaper)

-- set up screen for each screen
awful.screen.connect_for_each_screen(config.screen.connect_for_each_screen)

--  assign Mouse bindings for global buttons
root.buttons(config.buttons.globals)

-- Set global keys
root.keys(config.keys.globals)

-- Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = config.rules

-- Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
-- for now all titlebars should be disabled anyways (they are ugly)
client.connect_signal("request::titlebars", function(c)
	awful.titlebar(c, { size = 20 }):setup(config
		.titlebar.new(c))
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)

-- auto start applications
require("autostart")
