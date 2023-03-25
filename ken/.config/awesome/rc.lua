local awesome, client, mouse, screen, tag, root = awesome, client, mouse, screen, tag, root
-- local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring,
-- 		tonumber, type

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
local wibox         = require("wibox")

-- Theme handling library
local beautiful     = require("beautiful")

-- Notification library
local naughty       = require("naughty")

-- XDG Application menu implementation
local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- gaps between clients in tags
local client_gap = 5

-- Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- This is used later as the default terminal and editor to run.
local vars       = {
	-- set the terminal here
	terminal             = "alacritty",
	-- set the terminal editor here
	editor               = os.getenv("EDITOR") or "nvim",
	-- Default modkey. Usually, Mod4 is the key with a logo between Control and Alt.
	modkey               = "Mod4",
	-- Alter Key
	altkey               = "Mod1",
	-- Control key
	ctrlkey              = "Control",
	-- Shift key
	shiftkey             = "Shift",
	-- Theme list
	themes               = { "default", "gtk", "sky", "xsources", "zenburn" },
	-- this is popup data which will show if any error during awesome startup
	startup_error_notify = {
		preset = naughty.config.presets.critical,
		title  = "Oops, there were errors during startup!",
		text   = awesome.startup_errors,
	},
	-- this is the tags (workspaces) list that will show on each screen
	tags                 =
	{
		{ name = "1", props = { gap = client_gap, layout = awful.layout.suit.tile, selected = true } },
		{ name = "2", props = { gap = client_gap, layout = awful.layout.suit.tile } },
		{ name = "3", props = { gap = client_gap, layout = awful.layout.suit.tile } },
		{ name = "4", props = { gap = client_gap, layout = awful.layout.suit.tile } },
		{ name = "5", props = { gap = client_gap, layout = awful.layout.suit.tile } },
		{ name = "6", props = { gap = client_gap, layout = awful.layout.suit.tile } },
	}
}

local fns        = {
	-- menubar binding commands
	menu_cmds       = {
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
	},
	-- functions which will bind to the tag mouse button events on
	tags_mouse      = {
		-- click to view the tag
		view_only   = function(t) t:view_only() end,
		-- move client window to tag
		move_to_tag = function(t) if client.focus then client.focus:move_to_tag(t) end end,
		toggle_tag  = function(t) if client.focus then client.focus:toggle_tag(t) end end,
		viewtoggle  = awful.tag.viewtoggle,
		-- next tag on screen
		viewnext    = function(t) awful.tag.viewnext(t.screen) end,
		-- prev tag on screen
		viewprev    = function(t) awful.tag.viewprev(t.screen) end,
	},
	-- these are function to operate on tags which will be binded to key maps
	tags_ops        = {
		-- fucntion to delete the focused tag
		delete_tag      = function()
			local t = awful.screen.focused().selected_tag
			if not t then return end
			t:delete()
		end,
		-- function to add a new tag
		add_tag         = function()
			--get current number of the tags
			local num_tags = #awful.screen.focused().tags
			awful.tag.add(tostring(num_tags + 1),
						  { screen = awful.screen.focused(), gap = client_gap }):view_only()
		end,
		-- to rename a tag
		rename_tag      = function()
			awful.prompt.run {
				prompt       = "New tag name: ",
				textbox      = awful.screen.focused().mypromptbox.widget,
				exe_callback = function(new_name)
					if not new_name or #new_name == 0 then return end
					local t = awful.screen.focused().selected_tag
					if t then t.name = new_name end
				end
			}
		end,
		-- add new tag and move the client window to it
		move_to_new_tag = function()
			local c = client.focus
			if not c then return end
			local t = awful.tag.add(c.class, { screen = c.screen, gap = client_gap })
			c:tags({ t })
			t:view_only()
		end,
		-- copy tag to new one and move to it
		copy_tag        = function()
			local t = awful.screen.focused().selected_tag
			if not t then return end
			local clients = t:clients()
			local t2      = awful.tag.add(t.name, awful.tag.getdata(t))
			t2:clients(clients)
			t2:view_only()
		end
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
	},
	-- function to map the mouse buttons to layoutbox
	layoutbox_mouse = {
		-- switch to next layout
		layout_next = function() awful.layout.inc(1) end,
		-- switch to prev layout
		layout_prv = function() awful.layout.inc(-1) end
	},
	-- global key binding functions
	g_keys          = {
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
		toggle_mainmenu = function() vars.menu:toggle() end,
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
	},
	-- clint key binding functions
	c_keys          = {
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
	},
	-- client mouse bind functions
	c_mouse         = {
		-- activate and raise client
		raise_client = function(c) c:emit_signal("request::activate", "mouse_click", { raise = true }) end,
		-- move client
		move_client = function(c)
			c:emit_signal("request::activate", "mouse_click", { raise = true })
			awful.mouse.client.move(c)
		end,
		-- resize client
		resize_client = function(c)
			c:emit_signal("request::activate", "mouse_click", { raise = true })
			awful.mouse.client.resize(c)
		end
	},
	-- function to draw the wallpaper to the screen
	set_wallpaper   = function(s)
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
}


-- main menu (we put this in vars because we only need one instance of this)
vars.menu = awful.menu({
	items = {
		{
			-- awesome menu entries
			"awesome",
			{
				{ "hotkeys",     fns.menu_cmds.hotkeys, },
				{ "manual",      fns.menu_cmds.manual },
				{ "edit config", fns.menu_cmds.edit_config },
				{ "restart",     fns.menu_cmds.restart },
				{ "quit",        fns.menu_cmds.quit, },
			},
			beautiful.awesome_icon
		},
		{ "open terminal", vars.terminal },
	}
})




-- selected theme path
local selected_theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua",
										  os.getenv("HOME"),
										  vars.themes[1]) --select your theme

-- Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then naughty.notify(vars.startup_error_notify) end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err)
		})
		in_error = false
	end)
end

-- initiate the theme
beautiful.init(selected_theme_path)

-- Set the terminal for applications that require it
menubar.utils.terminal = vars.terminal

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts   = {
	awful.layout.suit.tile,
	--awful.layout.suit.floating,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	--awful.layout.suit.fair,
	--awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	--awful.layout.suit.max,
	--awful.layout.suit.max.fullscreen,
	--awful.layout.suit.magnifier,
	-- awful.layout.suit.corner.nw,
	-- awful.layout.suit.corner.ne,
	-- awful.layout.suit.corner.sw,
	-- awful.layout.suit.corner.se,
}


-- My widgets
local mywidgets = {
	-- main launcher (single instance)
	launcher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = vars.menu }),
	-- promptbox for each screen
	promptbox = function() return awful.widget.prompt() end,
	-- an imagebox widget which will contain an icon indicating which layout we're using.
	-- pass current screen as a parameter
	layoutbox = function(s)
		local layout_box = awful.widget.layoutbox(s)
		--set mouse button mappings
		layout_box:buttons(gears.table.join(
			awful.button({}, 1, fns.layoutbox_mouse.layout_next),
			awful.button({}, 3, fns.layoutbox_mouse.layout_prv),
			awful.button({}, 4, fns.layoutbox_mouse.layout_next),
			awful.button({}, 5, fns.layoutbox_mouse.layout_prv)
		))
		return layout_box
	end,
	-- tag list widget
	taglist = function(s)
		-- Mouse button mappings for the tag list
		local taglist_buttons = gears.table.join(
			awful.button({}, 1, fns.tags_mouse.view_only),
			awful.button({ vars.modkey }, 1, fns.tags_mouse.move_to_tag),
			awful.button({}, 3, fns.tags_mouse.viewtoggle),
			awful.button({ vars.modkey }, 3, fns.tags_mouse.toggle_tag),
			awful.button({}, 4, fns.tags_mouse.viewnext),
			awful.button({}, 5, fns.tags_mouse.viewprev)
		)
		-- Create a taglist widget
		return awful.widget.taglist({
			screen = s,
			filter = awful.widget.taglist.filter.all,
			buttons = taglist_buttons,
		})
	end,
	--tasklist widget
	tasklist = function(s)
		-- mouse button mappings for the tasklist
		local tasklist_buttons = gears.table.join(
			awful.button({}, 1, fns.tasklist_mouse.min_or_raise),
			awful.button({}, 3, fns.tasklist_mouse.menu_client_list),
			awful.button({}, 4, fns.tasklist_mouse.client_focus_next),
			awful.button({}, 5, fns.tasklist_mouse.client_focus_prev)
		)
		-- Create a tasklist widget
		return awful.widget.tasklist({
			screen  = s,
			filter  = awful.widget.tasklist.filter.currenttags,
			buttons = tasklist_buttons,
		})
	end,
	-- Keyboard map indicator and switcher (single instance)
	keyboardlayout = awful.widget.keyboardlayout(),
	-- the system tray (single instance)
	systray = wibox.widget.systray(),
	-- a textclock widget (single instance)
	textclock = wibox.widget.textclock(),
	-- wibox (bar) all widgets needs to be setup on this
	wibar = function(s) return awful.wibar({ position = "top", screen = s }) end
}


-- my title bar
local mytitlebar = function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	return {
		{
			-- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout  = wibox.layout.fixed.horizontal,
		},
		{
			-- Middle
			{
				-- Title
				align  = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout  = wibox.layout.flex.horizontal,
		},
		{
			-- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	}
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", fns.set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	fns.set_wallpaper(s)

	-- add the tags
	-- Each screen has its own tag table.
	for index, value in ipairs(vars.tags) do
		value.props.screen = s --set the current screen
		awful.tag.add(value.name, value.props)
	end

	-- attach to screen so we can get it later for each screen
	s.mypromptbox = mywidgets.promptbox()
	s.mytaglist = mywidgets.taglist(s)
	s.mytasklist = mywidgets.tasklist(s)
	s.mylayoutbox = mywidgets.layoutbox(s)

	-- Create the wibar
	s.mywibar = mywidgets.wibar(s)

	-- Add widgets to the wibar
	s.mywibar:setup({
		layout = wibox.layout.align.horizontal,
		{
			-- Left widgets
			layout = wibox.layout.fixed.horizontal,
			mywidgets.launcher,
			s.mytaglist,
			s.mypromptbox,
		},
		-- Middle widget
		s.mytasklist,
		{
			-- Right widgets
			layout = wibox.layout.fixed.horizontal,
			mywidgets.keyboardlayout,
			mywidgets.systray,
			mywidgets.textclock,
			s.mylayoutbox,
		},
	})
end)

-- global mouse buttons
vars.globalbuttons = gears.table.join(
	awful.button({}, 3, fns.g_keys.toggle_mainmenu),
	awful.button({}, 4, fns.g_keys.tag_next),
	awful.button({}, 5, fns.g_keys.tag_prev)
)

--  assign Mouse bindings for global buttons
root.buttons(vars.globalbuttons)

-- create table for global keys bindings
vars.globalkeys = gears.table.join(
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

vars.clientkeys = gears.table.join(
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

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
-- we can not define function separately due to we needing the i in the iterate within function
-- basically we need to define function for each iteration (can not make it common)
for i = 1, 9 do
	vars.globalkeys = gears.table.join(
		vars.globalkeys,
		-- View tag only.
		awful.key({ vars.modkey },
				  "#" .. i + 9,
				  function()
					  local s = awful.screen.focused()
					  local t = s.tags[i]
					  if t then
						  t:view_only()
					  end
				  end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		awful.key({ vars.modkey, vars.ctrlkey },
				  "#" .. i + 9,
				  function()
					  local s = awful.screen.focused()
					  local t = s.tags[i]
					  if t then
						  awful.tag.viewtoggle(t)
					  end
				  end,
				  { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ vars.modkey, vars.shiftkey },
				  "#" .. i + 9,
				  function()
					  if client.focus then
						  local t = client.focus.screen.tags[i]
						  if t then
							  client.focus:move_to_tag(t)
						  end
					  end
				  end,
				  { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ vars.modkey, vars.ctrlkey, vars.shiftkey },
				  "#" .. i + 9,
				  function()
					  if client.focus then
						  local t = client.focus.screen.tags[i]
						  if t then
							  client.focus:toggle_tag(t)
						  end
					  end
				  end,
				  { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

-- client mouse buttons
vars.clientbuttons = gears.table.join(
	awful.button({}, 1, fns.c_mouse.raise_client),
	awful.button({ vars.modkey }, 1, fns.c_mouse.move_client),
	awful.button({ vars.modkey }, 3, fns.c_mouse.resize_client)
)

-- Set keys
root.keys(vars.globalkeys)

-- Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = vars.clientkeys,
			buttons = vars.clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement
					.no_offscreen,
		},
	}, -- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},
			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = { "Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	}, -- Add titlebars to normal clients and dialogs
	{ rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = true }, },
	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- { rule = { class = "Firefox" },
	--   properties = { screen = 1, tag = "2" } },
}

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
	awful.titlebar(c):setup(mytitlebar(c))
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
