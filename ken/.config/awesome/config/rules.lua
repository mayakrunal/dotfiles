-- Theme handling library
local beautiful = require("beautiful")
-- Everything related to window managment
local awful     = require("awful")

local buttons   = require("config.buttons")
local keys      = require("config.keys")
local tags      = require("config.tags")

return {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            titlebars_enabled = false,
            keys = keys.client,
            buttons = buttons.client,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement
                    .no_offscreen,
        },
        callback = function(c)
            -- open steam games as floating fullscreen (games which require fullscreen will be fullscreen this way)
            if string.find(c.class, "steam_app") or
            string.find(c.instance, "steam_app") then
                c.floating = true
                c.maximized = true
                c.fullscreen = true
            end
        end
    },
    -- Floating clients.
    {
        rule_any = {
            instance = { "DTA", -- Firefox addon DownThemAll.
                "copyq",        -- Includes session name in class.
                "pinentry", },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin",  -- kalarm.
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
                "Pavucontrol",
                "Nitrogen",
                "Astrill"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = { "Event Tester", -- xev.
                "Astrill Log" },
            role = {
                "AlarmWindow",   -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
            },
        },
        properties = { floating = true },
    },
    -- Tag 1 (All browser related things)
    {
        rule_any = { class = { "firefox", "firefoxdeveloperedition", "Chromium", "Microsoft-edge" } },
        properties = { tag = tags[1].name },
        callback = function(c)
            -- make picture in picture sticky and always on top
            if c.role and c.role == "PictureInPicture" then
                c.sticky = true
                c.ontop = true
            end
        end
    },
    -- Tag 2 (terminals)
    { rule_any = { class = { "Alacritty" } },                                         properties = { tag = tags[2].name } },
    -- Tag 3 (coding)
    { rule_any = { class = { "Code", "jetbrains-idea-ce", "jetbrains-pycharm-ce" } }, properties = { tag = tags[3].name } },
    -- Tag 4 (file browsers)
    { rule_any = { class = { "Thunar", "dolphin" } },                                 properties = { tag = tags[4].name } },
    -- Tag 5 (games)
    { rule_any = { class = { "Steam" } },                                             properties = { tag = tags[5].name } },
    -- Tag 6 (music)
    {
        rule_any = { instance = { "spotify" }, class = { "Spotify", "vlc", "Kodi" }, name = { "Spotify" } },
        properties = { tag = tags[6].name }
    },
    -- Tag 7 (video record)
    { rule_any = { class = { "obs" } }, properties = { tag = tags[7]
            .name } },
    -- Tag 8 (Notes)
    {
        rule_any = { class = { "Joplin", "libreoffice-startcenter", "libreoffice-writer" } },
        properties = { tag = tags[8].name }
    },
    -- Tag 9 (Chats)
    {
        rule_any = { class = { "discord", "Skype", "fmd.exe", "YACReaderLibrary", "YACReader" } },
        properties = { tag = tags[9].name },
        callback = function(c)
            if c.class and c.class == "fmd.exe" then
                c.floating             = true
                c.titlebars_enabled    = true
                c.requests_no_titlebar = false
            end
        end
    },
}
