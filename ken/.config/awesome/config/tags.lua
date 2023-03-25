-- Grab environment we need
-- Everything related to window managment
local awful    = require("awful")
-- our variables
local vars     = require("config.vars")
-- global c variable
local client   = client

-- these are function to operate on tags which will be binded to key maps
local tags_ops = {
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
                      { screen = awful.screen.focused(), gap = vars.client_gap }):view_only()
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
        local t = awful.tag.add(c.class, { screen = c.screen, gap = vars.client_gap })
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
}

-- this is the tags (workspaces) list that will show on each screen
return {
    { name = "1", props = { gap = vars.client_gap, layout = awful.layout.suit.tile, selected = true } },
    { name = "2", props = { gap = vars.client_gap, layout = awful.layout.suit.tile } },
    { name = "3", props = { gap = vars.client_gap, layout = awful.layout.suit.tile } },
    { name = "4", props = { gap = vars.client_gap, layout = awful.layout.suit.tile } },
    { name = "5", props = { gap = vars.client_gap, layout = awful.layout.suit.tile } },
    { name = "6", props = { gap = vars.client_gap, layout = awful.layout.suit.tile } },
}
