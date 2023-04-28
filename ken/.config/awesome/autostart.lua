-- Everything related to window managment
local awful = require("awful")

-- auto start applications
local autostart = {
    --restore wallpaper
    nitrogen = "nitrogen --restore",
    -- polkit agent
    polkti_agent = "/usr/lib/xfce-polkit/xfce-polkit",
    -- screen locker
    screen_locker = "xss-lock /usr/lib/kscreenlocker_greet",
    -- turn on numlock
    numlock = "numlockx on",
    -- systray volume and network manager applet
    volume = "volumeicon",
    --#network manager applet
    network_applet = "nm-applet",
    --bluetooth applet
    bluetooth_applet = "blueman-applet",
    --ime input methods
    ime = "fcitx5",
    --start picom
    compositor = "picom",
    --kwallet
    kwallet = "/usr/lib/pam_kwallet_init",
    --vpn
    vpn = "astrill",
    --discord
    discord = "discord",
    skype = "skypeforlinux"
}
-- execute each one
for key, cmd in pairs(autostart) do
    awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
end
