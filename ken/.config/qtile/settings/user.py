from dataclasses import dataclass


@dataclass
class UserValue:
    mod: str = "mod4"
    applauncher: str = "rofi -show drun"
    windownav: str = "rofi -show"
    browser: str = "firefox"
    fileexplorer: str = "thunar"
    vscode: str = "code"
    terminal: str = "alacritty"
    powermenu: str = "rofi -show powermenu -modi powermenu:~/.config/rofi/scripts/rofi-power-menu"
    screenshot: str = "spectacle"
    screenshot_region: str = "spectacle -r"


my = UserValue()
