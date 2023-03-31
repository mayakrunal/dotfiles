local awesome, client, screen, root = awesome, client, screen, root


-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
-- Utilities such as color parsing and objects
local gears = require("gears")

-- Everything related to window managment
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox      = require("wibox")

-- Theme handling library
local beautiful  = require("beautiful")

-- XDG Application menu implementation
local menubar    = require("menubar")

-- selected theme path
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua",
								 os.getenv("HOME"),
								 "default") --select your theme

-- initiate the theme （make sure to init the theme first) before calling config
beautiful.init(theme_path)

local config = require("config")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- start error handling
require("errors")



-- Set the terminal for applications that require it
menubar.utils.terminal = config.vars.terminal

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts   = config.layouts

-- function to draw the wallpaper to the screen
local set_wallpaper    = function(s)
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

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- add the tags
	-- Each screen has its own tag table.
	for index, value in ipairs(config.tags) do
		value.props.screen = s --set the current screen
		awful.tag.add(value.name, value.props)
	end
	local wi = config.widgets

	-- attach to screen so we can get it later for each screen
	s.mypromptbox = wi.promptbox()
	s.mytaglist = wi.taglist(s)
	s.mytasklist = wi.tasklist(s)
	s.mylayoutbox = wi.layoutbox(s)

	-- Create the wibar
	s.mywibar = config.widgets.wibar(s)

	local function primary_sep()
		if s == screen.primary then return wi.sep(5, "|") else return wi.sep(0, "") end
	end

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
			primary_sep(),
			wi.systray,
			wi.sep(5, "|"),
			wi.pacman,
			wi.sep(3, ""),
			wi.fs,
			wi.sep(3, ""),
			wi.cpu,
			wi.sep(3, ""),
			wi.mem,
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
end)

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
