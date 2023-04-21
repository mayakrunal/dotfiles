-- Grab environment we need
-- Everything related to window managment
local awful = require("awful")
-- superscript
-- ¹²³⁴⁵⁶⁷⁸⁹
--  ₁₂₃₄₅₆₇₈₉
-- this is the tags (workspaces) list that will show on each screen
return {
    { name = "",  props = { layout = awful.layout.suit.tile, selected = true } }, -- browsers
    { name = "",  props = { layout = awful.layout.suit.tile } },                -- terminals and linux stuff
    { name = "",  props = { layout = awful.layout.suit.tile } },                -- IDE & Codes
    { name = "󱧷", props = { layout = awful.layout.suit.tile } },                -- File Browsers
    { name = "󰺵", props = { layout = awful.layout.suit.tile } },                -- Games
    { name = "󰎈", props = { layout = awful.layout.suit.tile } },                -- Music
    { name = "",  props = { layout = awful.layout.suit.tile } },                -- Videos & Record
    { name = "󰝇", props = { layout = awful.layout.suit.tile } },                -- notes & office
    { name = "󰭹", props = { layout = awful.layout.suit.tile } },                -- chats
}
