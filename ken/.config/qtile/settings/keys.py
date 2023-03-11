# Antonio Sarosi
# https://youtube.com/c/antoniosarosi
# https://github.com/antoniosarosi/dotfiles

# Qtile keybindings

from libqtile.config import Key
from libqtile.command import lazy
from .user import my

mod = my.mod
keys = [Key(key[0], key[1], *key[2:]) for key in [
    # ------------ Window Configs ------------

    # Switch between windows in current stack pane
    ([mod], "Down", lazy.layout.down()),
    ([mod], "Up", lazy.layout.up()),
    ([mod], "Left", lazy.layout.left()),
    ([mod], "Right", lazy.layout.right()),

    # Change window sizes (MonadTall)
    ([mod, "control"], "Right", lazy.layout.grow()),
    ([mod, "control"], "Left", lazy.layout.shrink()),

    # Toggle floating
    ([mod, "shift"], "f", lazy.window.toggle_floating()),

    # Full screen , minimize & normalize
    ([mod], "f", lazy.window.toggle_fullscreen()),
    ([mod], "m", lazy.window.toggle_maximize()),
    ([mod, "shift"], "m", lazy.window.toggle_minimize()),
    ([mod], "n", lazy.layout.normalize()),

    # Move windows up or down in current stack
    ([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    ([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    ([mod, "shift"], "Left", lazy.layout.swap_left()),
    ([mod, "shift"], "Right", lazy.layout.swap_right()),

    # Toggle between different layouts as defined below
    ([mod], "Tab", lazy.next_layout()),
    ([mod, "shift"], "Tab", lazy.prev_layout()),

    # Kill window
    ([mod], "q", lazy.window.kill()),

    # Switch focus of monitors
    ([mod], "period", lazy.next_screen()),
    ([mod], "comma", lazy.prev_screen()),

    # Restart Qtile
    ([mod, "control"], "r", lazy.restart()),

    ([mod, "control"], "q", lazy.shutdown()),
    ([mod], "r", lazy.spawncmd()),

    # ------------ App Configs ------------

    # Menu
    ([mod], "d", lazy.spawn(my.applauncher)),

    # Window Nav
    ([mod, "shift"], "d", lazy.spawn(my.windownav)),

    # Browser
    ([mod], "b", lazy.spawn(my.browser)),

    # File Explorer
    ([mod], "e", lazy.spawn(my.fileexplorer)),

    # VS Code
    ([mod], "c", lazy.spawn(my.vscode)),

    # Terminal
    ([mod], "Return", lazy.spawn(my.terminal)),

    # PowerMenu
    ([mod], "Escape", lazy.spawn(my.powermenu)),

    # Redshift
    # ([mod], "r", lazy.spawn("redshift -O 2400")),
    # ([mod, "shift"], "r", lazy.spawn("redshift -x")),

    # Screenshot
    ([mod], "s", lazy.spawn(my.screenshot)),
    ([mod, "shift"], "s", lazy.spawn(my.screenshot_region)),

    # ------------ Hardware Configs ------------

    # Volume
    ([], "XF86AudioLowerVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ -5%"
    )),
    ([], "XF86AudioRaiseVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ +5%"
    )),
    ([], "XF86AudioMute", lazy.spawn(
        "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    )),

    # Brightness
    ([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%")),
    ([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),
]]
