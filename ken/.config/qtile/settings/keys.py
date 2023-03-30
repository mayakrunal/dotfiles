# Qtile keybindings

from libqtile.config import Key
from libqtile.command import lazy
from .user import my

mod = my.mod
alt = my.alt
keys = [Key(key[0], key[1], *key[2:]) for key in [
    # ------------ Window Configs ------------

    # Switch focus between windows in current stack pane
    ([mod], "Down", lazy.layout.down()),
    ([mod], "Up", lazy.layout.up()),
    ([mod], "Left", lazy.layout.left()),
    ([mod], "Right", lazy.layout.right()),

    # Move windows up or down in current stack
    ([mod, "control"], "Down", lazy.layout.shuffle_down()),
    ([mod, "control"], "Up", lazy.layout.shuffle_up()),
    ([mod, "control"], "Left", lazy.layout.swap_left(), lazy.layout.shuffle_left()),
    ([mod, "control"], "Right", lazy.layout.swap_right(), lazy.layout.shuffle_right()),

    # Change window sizes (MonadTall)
    ([mod], "KP_Add", lazy.layout.grow()),
    ([mod], "KP_Subtract", lazy.layout.shrink()),

    # Switch focus of monitors
    ([mod], "Prior", lazy.next_screen()),
    ([mod], "Next", lazy.prev_screen()),

    # Toggle between different layouts
    ([mod], "Tab", lazy.next_layout()),
    ([mod, "shift"], "Tab", lazy.prev_layout()),


    # Flip the layout
    ([mod, "shift"], "space", lazy.layout.flip()),


    # Full screen , minimize & normalize
    ([mod], "f", lazy.window.toggle_fullscreen()),
    ([mod], "m", lazy.window.toggle_maximize()),
    ([mod], "n", lazy.window.toggle_minimize()),
    ([mod, "control"], "n", lazy.layout.normalize()),


    # Toggle floating
    ([mod, "control"], "f", lazy.window.toggle_floating()),

    # Kill window
    ([mod], "q", lazy.window.kill()),

    # Restart Qtile
    ([mod, "control"], "r", lazy.restart()),

    ([mod, "shift"], "q", lazy.shutdown()),
    ([mod], "r", lazy.spawncmd()),
    [[mod], "l", lazy.spawn(my.lockscreen)],

    # ------------ App Configs ------------

    # Dmenu & X11 Menu
    ([mod], "d", lazy.spawn(my.applauncher)),

    # Window Nav
    ([mod, "shift"], "d", lazy.spawn(my.windownav)),

    # Terminal
    ([mod], "Return", lazy.spawn(my.terminal)),
    ([mod], "KP_Enter", lazy.spawn(my.terminal)),

    # PowerMenu
    ([mod], "Escape", lazy.spawn(my.powermenu)),

    # Screen Layout
    ([mod], "p", lazy.spawn(my.screenlayout)),

    # Browser
    ([mod, alt], "f", lazy.spawn(my.browser)),

    # File Explorer
    ([mod, alt], "e", lazy.spawn(my.fileexplorer)),

    # VS Code
    ([mod, alt], "c", lazy.spawn(my.vscode)),

    # Astrill
    ([mod, alt], "v", lazy.spawn(my.vpn)),

    # Audio Mixer
    ([mod, alt], "a", lazy.spawn(my.audiomixer)),

    # Redshift
    # ([mod], "r", lazy.spawn("redshift -O 2400")),
    # ([mod, "shift"], "r", lazy.spawn("redshift -x")),

    # Screenshot
    ([], "Print", lazy.spawn(my.screenshot)),
    (["shift"], "Print", lazy.spawn(my.screenshot_region)),

    # ------------ Hardware Configs ------------

    # Volume
    ([], "XF86AudioLowerVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ -5%")),
    ([], "XF86AudioRaiseVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ +5%")),
    ([], "XF86AudioMute", lazy.spawn(
        "pactl set-sink-mute @DEFAULT_SINK@ toggle")),

    # Brightness
    ([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +5%")),
    ([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%-")),
]]
