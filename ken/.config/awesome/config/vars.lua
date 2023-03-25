-- module table
-- Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- This is used later as the default terminal and editor to run.
return {
    -- set the terminal here
    terminal   = "alacritty",
    -- set the terminal editor here
    editor     = os.getenv("EDITOR") or "nvim",
    -- Default modkey. Usually, Mod4 is the key with a logo between Control and Alt.
    modkey     = "Mod4",
    -- Alter Key
    altkey     = "Mod1",
    -- Control key
    ctrlkey    = "Control",
    -- Shift key
    shiftkey   = "Shift",
    -- Theme list
    themes     = { "default", "gtk", "sky", "xsources", "zenburn" },
    -- gaps between clients in tags
    client_gap = 5,
}
