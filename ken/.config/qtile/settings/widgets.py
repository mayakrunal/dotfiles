from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration, BorderDecoration
from .theme import colors
from libqtile import qtile
from .user import my

# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)


# alternating colors for widgets underline (or powerline)
colornames = ["color1",
              "color2",
              "color3",
              "color4",
              "color5",
              "color6",
              "color7",
              "color8",
              "color9",
              "color10"]

colorindex = 0

iconsize = 18


def nextcolorname():
    global colorindex
    colorindex += 1
    if colorindex < len(colornames):
        return colornames[colorindex]
    else:
        colorindex = 0
        return colornames[colorindex]


def base(fg='text', bg='dark'):
    return {
        'foreground': colors[fg],
        'background': colors[bg]
    }


def separator(lw=0):
    return widget.Sep(**base(fg="inactive"), linewidth=lw, padding=5)


def powerline():
    return {
        "decorations": [PowerLineDecoration(path="arrow_left")]
    }


def underline(line_col='dark', width=[0, 0, 2, 0]):
    return {
        "decorations": [BorderDecoration(colour=colors[line_col], border_width=width)]
    }


def appmenu():
    return [
        widget.TextBox(
            **base('focus', 'dark'),
            fontsize=iconsize,
            text="  ",
            padding=3,
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(my.appmenu)}
        )
    ]


def workspaces():
    return [
        *appmenu(),
        separator(1),
        widget.GroupBox(
            **base(fg='light', bg='dark'),
            font='Hack Nerd Font',
            fontsize=iconsize,
            margin_y=3,
            margin_x=1,
            padding_y=2,
            padding_x=3,
            borderwidth=2,
            active=colors['active'],
            inactive=colors['inactive'],
            rounded=False,
            hide_unused=False,
            highlight_method='line',
            center_aligned='true',
            urgent_alert_method='line',
            urgent_border=colors['urgent'],
            highlight_color=colors['dark'],
            this_current_screen_border=colors['focus'],
            this_screen_border=colors['grey'],
            other_current_screen_border=colors['dark'],
            other_screen_border=colors['dark'],
            disable_drag=True
        ),
        separator(1),
        widget.TaskList(**base(fg='light'),
                        font='Hack Nerd Font',
                        # fontsize=14,
                        padding=5,
                        rounded=True,
                        border=colors['focus'],
                        unfocused_border=colors['inactive'],
                        urgent_border=colors['urgent'],
                        title_width_method='uniform',
                        highlight_method='border',
                        window_name_location=True,
                        theme_mode="preferred",
                        txt_minimized="   ",
                        txt_maximized="   ",
                        txt_floating="  ",
                        markup_normal="  {}"),
        separator(1),
    ]


def updater():
    nxcolor = nextcolorname()
    return [
        separator(),
        widget.TextBox(**base(fg=nxcolor),
                       **underline(line_col=nxcolor),
                       text=" ",
                       fontsize=iconsize,
                       padding=3,
                       ),
        widget.CheckUpdates(
            **base(fg=nxcolor),
            **underline(line_col=nxcolor),
            colour_have_updates=colors[nxcolor],
            colour_no_updates=colors[nxcolor],
            no_update_string='0',
            display_format='{updates}',
            update_interval=1800,
            custom_command='checkupdates',
            padding=3,
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(
                my.terminal + ' -e yay')}
        ),
    ]


def network():
    nxcolor = nextcolorname()
    return [
        separator(),
        widget.Net(**base(fg=nxcolor),
                   **underline(line_col=nxcolor),
                   format='󰜮 {down:.2f}{down_suffix} 󰜷 {up:.2f}{up_suffix}',
                   prefix='M',
                   padding=3),
    ]


def layoutIcon():
    nxcolor = nextcolorname()
    return [
        widget.CurrentLayoutIcon(
            **base(fg=nxcolor),
            **underline(line_col=nxcolor),
            fontsize=iconsize,
            use_mask=True,
            padding=5,
            scale=0.65),
    ]


def calendar():
    nxcolor = nextcolorname()
    return [
        separator(),
        widget.TextBox(**base(fg=nxcolor),
                       **underline(line_col=nxcolor),
                       text="",
                       fontsize=iconsize,
                       padding=3,
                       ),
        widget.Clock(
            **base(fg=nxcolor),
            **underline(line_col=nxcolor),
            format='%d %B %I:%M %p',
            padding=5),
    ]


def systray():
    return [
        separator(1),
        widget.Systray(background=colors["dark"],
                       icon_size=iconsize,
                       padding=5),
    ]


def batteryicon():
    nxcolor = nextcolorname()
    return [
        separator(),
        widget.UPowerWidget(**base(fg=nxcolor),
                            **underline(line_col=nxcolor),
                            margin=5),
    ]


def powermenu():
    return [
        separator(1),
        widget.TextBox(
            **base('light', 'dark'),
            fontsize=iconsize,
            text="   ",
            padding=3,
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(
                my.powermenu)}
        )
    ]


def memory():
    nxcolor = nextcolorname()
    return [
        separator(),
        widget.TextBox(**base(fg=nxcolor),
                       **underline(line_col=nxcolor),
                       text="󰍛",
                       fontsize=iconsize,
                       padding=3,
                       ),
        widget.Memory(**base(fg=nxcolor),
                      **underline(line_col=nxcolor),
                      measure_mem="G",
                      format='{MemUsed:.2f}{mm}/{MemTotal:.2f}{mm}',
                      mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(
                          my.terminal + ' -e htop')},
                      padding=5),
    ]


def cpu():
    nxcolor = nextcolorname()
    return [
        separator(),
        widget.TextBox(**base(fg=nxcolor),
                       **underline(line_col=nxcolor),
                       text="󰻠",
                       fontsize=iconsize,
                       padding=3,
                       ),
        widget.CPU(**base(fg=nxcolor),
                   **underline(line_col=nxcolor),
                   format='{load_percent}%',
                   mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(
                       my.terminal + ' -e htop')},
                   padding=5),
    ]


def lockindicator():
    nxcolor = nextcolorname()
    return [
        separator(),
        widget.CapsNumLockIndicator(**base(fg=nxcolor),
                                    **underline(line_col=nxcolor),
                                    update_interval=1),
    ]


def thermalsensor():
    nxcolor = nextcolorname()
    nxcolor2 = nextcolorname()
    return [
        separator(),
        widget.TextBox(**base(fg=nxcolor),
                       **underline(line_col=nxcolor),
                       text="",
                       fontsize=iconsize,
                       padding=3,
                       ),
        widget.ThermalSensor(**base(fg=nxcolor),
                             **underline(line_col=nxcolor),
                             fmt='CPU: {}',
                             update_interval=2),
        separator(),
        widget.TextBox(**base(fg=nxcolor2),
                       **underline(line_col=nxcolor2),
                       text="",
                       fontsize=iconsize,
                       padding=3,
                       ),
        widget.NvidiaSensors(**base(fg=nxcolor2),
                             **underline(line_col=nxcolor2),
                             fmt='GPU: {}',
                             update_interval=2),
    ]


def sensors_groupbox():
    nxcolor = nextcolorname()
    return [
        separator(),
        widget.WidgetBox(**base(fg=nxcolor),
                         **underline(line_col=nxcolor),
                         text_closed="  ",
                         text_open="  ",
                         fontsize=iconsize,
                         close_button_location='right',
                         widgets=[
            *updater(),
            *network(),

            *cpu(),

            *memory(),

            *thermalsensor(),

            separator(),
        ]),
    ]


primary_widgets = [
    *workspaces(),

    *layoutIcon(),

    *batteryicon(),

    *calendar(),

    *sensors_groupbox(),

    *systray(),

    *powermenu(),
]

# reset colorindex
colorindex = 0

secondary_widgets = [
    *workspaces(),

    *layoutIcon(),

    *batteryicon(),

    *calendar(),

    *powermenu(),
]

widget_defaults = {
    'font': 'Hack Nerd Font Bold',
    'fontsize': 12,
    'padding': 1,
}
extension_defaults = widget_defaults.copy()
