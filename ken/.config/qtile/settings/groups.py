# Antonio Sarosi
# https://youtube.com/c/antoniosarosi
# https://github.com/antoniosarosi/dotfiles

# Qtile workspaces

from libqtile.config import Key, Group, Match, ScratchPad, DropDown
from libqtile.command import lazy
from .keys import mod, keys
from .user import my

# Alternative keynames for the Numpad keys. Needed for easy synchronization
# between the regular group names as letters.
KP = {
    '1': 'End',
    '2': 'Down',
    '3': 'Next',
    '4': 'Left',
    '5': 'Begin',
    '6': 'Right',
    '7': 'Home',
    '8': 'Up',
    '9': 'Prior',
    '0': 'Insert',
}

# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)

# groups = [Group(i) for i in [
#     "   ", "   ", "   ", "   ", "  ", "   ", "   ", "   ", "   ",
# ]]

# superscript
# ¹²³⁴⁵⁶⁷⁸⁹
# subscript
# ₁₂₃₄₅₆₇₈₉
groups = [
    Group(name="1",
          label="󰖟¹",
          matches=[Match(wm_class=["firefox"])]),
    Group(name="2",
          label="²",
          matches=[Match(wm_class=["Alacritty"])]),
    Group(name="3",
          label="³",
          matches=[Match(wm_class=["code"])]),
    Group(name="4",
          label="󰪶⁴",
          matches=[Match(wm_class=["thunar", "dolphin"])]),
    Group(name="5",
          label="󱎓⁵",
          matches=[Match(wm_class=["Steam"])]),
    Group(name="6",
          label="󰎈⁶",
          matches=[Match(wm_class=["spotify", "vlc"])]),
    # Group(name="⁷"),
]


for i in groups:
    groupname = i.name
    keys.extend([
        # Switch to workspace N
        Key([mod], groupname, lazy.group[groupname].toscreen()),
        # Send window to workspace N
        Key([mod, "control"], groupname, lazy.window.togroup(groupname)),
        # Send window to workspace N & Switch to it
        Key([mod, "shift"], groupname, lazy.window.togroup(
            groupname, switch_group=True)),
    ])
    numkey = "KP_" + KP[groupname]
    keys.extend([
        # Switch to workspace N
        Key([mod], numkey, lazy.group[groupname].toscreen()),
        # Send window to workspace N
        Key([mod, "control"], numkey, lazy.window.togroup(groupname)),
        # Send window to workspace N & Switch to it
        Key([mod, "shift"], numkey, lazy.window.togroup(
            groupname, switch_group=True)),
    ])

groups.extend([
    ScratchPad("SPD",
               dropdowns=[
                   DropDown("term",
                            my.terminal,
                            opacity=0.9,
                            height=0.6),
                   DropDown("browser",
                            my.browser,
                            opacity=0.9,
                            height=0.6),
               ])
])

keys.extend([
    Key([mod], "period", lazy.group['SPD'].dropdown_toggle('term')),
    Key([mod], "comma", lazy.group['SPD'].dropdown_toggle('browser')),
])
