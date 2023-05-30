from dataclasses import dataclass


@dataclass
class UserValue:
    mod: str = "mod4"
    alt: str = "mod1"
    applauncher: str = "rofi -show drun"
    appmenu: str = "jgmenu_run"
    audiomixer: str = "pavucontrol"
    windownav: str = "rofi -show"
    browser: str = "firefox"
    fileexplorer: str = "dolphin"
    vscode: str = "code"
    terminal: str = "alacritty"
    terminal_fish: str = "alacritty -e /bin/fish"
    powermenu: str = "rofi -show powermenu -modi powermenu:~/.config/rofi/scripts/rofi-power-menu"
    screenlayout: str = "rofi -show screenlayout -modi screenlayout:~/.config/rofi/scripts/rofi-screen-layout"
    screenshot: str = "spectacle"
    screenshot_region: str = "spectacle -r"
    vpn: str = "astrill"
    lockscreen: str = "loginctl lock-session"


my = UserValue()
