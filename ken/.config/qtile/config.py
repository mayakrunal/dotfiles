from libqtile import hook

from settings.keys import mod, keys
from settings.groups import groups
from settings.layouts import layouts, floating_layout
from settings.widgets import widget_defaults, extension_defaults
from settings.screens import screens
from settings.mouse import mouse
from settings.path import qtile_path

from os import path
import subprocess


@hook.subscribe.startup_once
def autostart():
    subprocess.call([path.join(qtile_path, 'autostart.sh')])


@hook.subscribe.startup_complete
def autostart():
    subprocess.call([path.join(qtile_path, 'startup_completed.sh')])


main = None

# A function which generates group binding hotkeys.
# It takes a single argument, the DGroups object, and can use that to set up dynamic key bindings.
dgroups_key_binder = None

# A list of Rule objects which can send windows to various groups based on matching criteria.
dgroups_app_rules = []

# Controls whether or not focus follows the mouse around as it moves across windows in a layout.
follow_mouse_focus = True

# When clicked, should the window be brought to the front or not.
# If this is set to "floating_only", only floating windows will get affected (This sets the X Stack Mode to Above.)
bring_front_click = False

# If true, the cursor follows the focus as directed by the keyboard, warping to the center of the focused window.
# When switching focus between screens, If there are no windows in the screen, the cursor will warp to the center of the screen.
cursor_warp = False

# If a window requests to be fullscreen, it is automatically fullscreened.
# Set this to false if you only want windows to be fullscreen if you ask them to be.
auto_fullscreen = True

# urgent: urgent flag is set for the window
# focus: automatically focus the window
# smart: automatically focus if the window is in the current group
# never: never automatically focus any window that requests it
focus_on_window_activation = 'smart'

# Controls whether or not to automatically reconfigure
# screens when there are changes in randr output configuration.
reconfigure_screens = True

# If things like steam games want to auto-minimize
# themselves when losing focus, should we respect this or not?
auto_minimize = True


wmname = 'LG3D'
