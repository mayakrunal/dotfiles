-- module table
-- Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- This is used later as the default terminal and editor to run.
return {
    -- set the terminal here
    terminal          = "alacritty",
    -- set the terminal editor here
    editor            = os.getenv("EDITOR") or "nvim",
    -- Default modkey. Usually, Mod4 is the key with a logo between Control and Alt.
    modkey            = "Mod4",
    -- Alter Key
    altkey            = "Mod1",
    -- Control key
    ctrlkey           = "Control",
    -- Shift key
    shiftkey          = "Shift",
    -- rofi launcher
    rofi_drun         = "rofi -show drun",
    -- gaps between clients in tags
    client_gap        = 2,
    -- rofi window nav
    rofi_wnav         = "rofi -show",
    -- browser
    browser           = "firefox",
    -- file browser
    filexplorer       = "thunar",
    -- code editor
    vscode            = "code",
    -- my power menu
    powermenu         = "rofi -show powermenu -modi powermenu:~/.config/rofi/scripts/rofi-power-menu",
    -- screen layout
    screenlayout      =
    "rofi -show screenlayout -modi screenlayout:~/.config/rofi/scripts/rofi-screen-layout",
    -- screen shot
    screenshot        = "spectacle",
    screenshot_region = "spectacle -r",
    vpn               = "astrill",
    lockscreen        = "loginctl lock-session",
    audiomixer        = "pavucontrol",
    muteaudio         = "pactl set-sink-mute @DEFAULT_SINK@ toggle",
    increaseaudio     = "pactl set-sink-volume @DEFAULT_SINK@ +5%",
    decreaseaudio     = "pactl set-sink-volume @DEFAULT_SINK@ -5%",
    brightnessup      = "brightnessctl set +5%",
    brightnessdown    = "brightnessctl set 5%-",
}
