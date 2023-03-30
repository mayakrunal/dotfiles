-- Everything related to window managment
local awful    = require("awful")
-- Widget and layout library
local wibox    = require("wibox")
--buttons
local buttons  = require("config.buttons")

--module table
local titlebar = {}

-- my title bar
titlebar.new   = function(c)
    -- buttons for the titlebar
    local btns = buttons.titlebar(c)

    return {
        {
            -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = btns,
            layout  = wibox.layout.fixed.horizontal,
        },
        {
            -- Middle
            {
                -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c),
            },
            buttons = btns,
            layout  = wibox.layout.flex.horizontal,
        },
        {
            -- Right
            --awful.titlebar.widget.floatingbutton(c),
            --awful.titlebar.widget.maximizedbutton(c),
            --awful.titlebar.widget.stickybutton(c),
            --awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal(),
        },
        layout = wibox.layout.align.horizontal,
    }
end

return titlebar
