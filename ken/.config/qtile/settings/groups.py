# Antonio Sarosi
# https://youtube.com/c/antoniosarosi
# https://github.com/antoniosarosi/dotfiles

# Qtile workspaces

from libqtile.config import Key, Group, Match, ScratchPad, DropDown
from libqtile.command import lazy
from .keys import mod, keys
from .user import my


# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)
# Icons:
# nf-fa-firefox,
# nf-fae-python,
# nf-dev-terminal,
# nf-fa-code,
# nf-oct-git_merge,
# nf-linux-docker,
# nf-mdi-image,
# nf-mdi-layers

# groups = [Group(i) for i in [
#     "   ", "   ", "   ", "   ", "  ", "   ", "   ", "   ", "   ",
# ]]

groups = [
    Group(name="  ", matches=[Match(wm_class="firefox")]),
    Group(name="  ", matches=[Match(wm_class="Alacritty")]),
    Group(name="  ", matches=[Match(wm_class="code")]),
    Group(name="  ", matches=[
          Match(wm_class="thunar"),
          Match(wm_class="dolphin")
          ]),
    Group(name="  ", matches=[Match(wm_class="Steam")]),
    Group(name="  ", matches=[Match(wm_class="spotify")]),
    Group(name="  "),
]

# groups = [Group(i) for i in [
#     " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ",
# ]]

for i, group in enumerate(groups):
    actual_key = str(i + 1)
    keys.extend([
        # Switch to workspace N
        Key([mod], actual_key, lazy.group[group.name].toscreen()),
        # Send window to workspace N
        Key([mod, "shift"], actual_key, lazy.window.togroup(group.name))
    ])

groups.extend([
    ScratchPad("SPD",
               dropdowns=[
                   DropDown("term",
                            my.terminal,
                            opacity=0.9)
               ])
])

keys.extend([
    Key([mod], "period", lazy.group['SPD'].dropdown_toggle('term')),
])
