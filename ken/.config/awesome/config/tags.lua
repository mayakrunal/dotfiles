-- Grab environment we need
-- Everything related to window managment
local awful = require("awful")
-- superscript
-- ¹²³⁴⁵⁶⁷⁸⁹
--  ₁₂₃₄₅₆₇₈₉
-- this is the tags (workspaces) list that will show on each screen
return {
    { name = "󰖟", props = { layout = awful.layout.suit.tile, selected = true } },
    { name = "",  props = { layout = awful.layout.suit.tile } },
    { name = "",  props = { layout = awful.layout.suit.tile } },
    { name = "󰪶", props = { layout = awful.layout.suit.tile } },
    { name = "󱎓", props = { layout = awful.layout.suit.tile } }, --put games at floating avoid annoying fullscreen issues
    { name = "󰎈", props = { layout = awful.layout.suit.tile } },
    { name = "",  props = { layout = awful.layout.suit.tile } },
}
