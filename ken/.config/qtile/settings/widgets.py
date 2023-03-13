from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration
from .theme import colors
from libqtile import qtile
from .user import my

# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)


# powerline alternating colors
colornames = ["color1",
              "color2",
              "color3",
              "color4"]

colorindex = 0


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


def appmenu():
    return [
        widget.TextBox(
            **base('focus', 'dark'),
            fontsize=18,
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
            **base(fg='light'),
            font='Hack Nerd Font',
            fontsize=18,
            margin_y=3,
            margin_x=0,
            padding_y=2,
            padding_x=5,
            borderwidth=2,
            active=colors['active'],
            inactive=colors['inactive'],
            rounded=True,
            hide_unused=False,
            highlight_method='text',
            urgent_alert_method='text',
            urgent_border=colors['urgent'],
            this_current_screen_border=colors['focus'],
            this_screen_border=colors['grey'],
            other_current_screen_border=colors['dark'],
            other_screen_border=colors['dark'],
            disable_drag=True
        ),
        separator(1),
        widget.TaskList(**base(fg='light'),
                        font='Hack Nerd Font',
                        fontsize=14,
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
        widget.Sep(**base(fg="dark"),
                   **powerline(),
                   linewidth=1,
                   padding=7),
    ]


def updater():
    bgcolor = nextcolorname()
    return [
        widget.CheckUpdates(
            **powerline(),
            background=colors[bgcolor],
            colour_have_updates=colors['text'],
            colour_no_updates=colors['text'],
            no_update_string='0',
            display_format='  {updates}',
            update_interval=1800,
            custom_command='checkupdates',
            padding=5,
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(
                my.terminal + ' -e yay')}
        ),
    ]


def network():
    bgcolor = nextcolorname()
    return [
        widget.Net(**base(bg=bgcolor),
                   **powerline(),
                   format='󰜮 {down:.2f}{down_suffix} 󰜷 {up:.2f}{up_suffix}',
                   prefix='M',
                   padding=3),
    ]


def layoutIcon():
    bgcolor = nextcolorname()
    return [
        widget.CurrentLayoutIcon(
            **base(bg=bgcolor),
            **powerline(),
            use_mask=True,
            padding=5,
            scale=0.65),
    ]


def calendar():
    bgcolor = nextcolorname()
    return [
        widget.Clock(
            **base(bg=bgcolor),
            **powerline(),
            format=' %d %B %I:%M %p',
            padding=5),
    ]


def systray():
    return [
        separator(),
        widget.Systray(background=colors["dark"],
                       padding=5),
    ]


def batteryicon():
    bgcolor = nextcolorname()
    return [
        widget.UPowerWidget(**base(bg=bgcolor),
                            **powerline(),
                            margin=5),
    ]


def powermenu():
    return [
        separator(1),
        widget.TextBox(
            **base('light', 'dark'),
            fontsize=14,
            text="   ",
            padding=3,
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(
                my.powermenu)}
        )
    ]


def memory():
    bgcolor = nextcolorname()
    return [
        widget.TextBox(**base(bg=bgcolor),
                       text="󰍛",
                       fontsize=24,
                       padding=3,
                       ),
        widget.Memory(**base(bg=bgcolor),
                      **powerline(),
                      measure_mem="G",
                      format='{MemUsed:.2f}{mm}/{MemTotal:.2f}{mm}',
                      mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(
                          my.terminal + ' -e htop')},
                      padding=5),
    ]


def cpu():
    bgcolor = nextcolorname()
    return [
        widget.TextBox(**base(bg=bgcolor),
                       text="󰻠",
                       fontsize=24,
                       padding=3,
                       ),
        widget.CPU(**base(bg=bgcolor),
                   **powerline(),
                   measure_mem="G",
                   format='{load_percent}%',
                   mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(
                       my.terminal + ' -e htop')},
                   padding=5),
    ]


def sensors_groupbox():
    bgcolor = nextcolorname()
    return [
        widget.WidgetBox(**base(bg=bgcolor),
                         **powerline(),
                         text_closed="  ",
                         text_open="  ",
                         fontsize=20,
                         widgets=[
            *updater(),

            *cpu(),

            *memory(),

            *network(),
        ]),
    ]


primary_widgets = [
    *workspaces(),

    *sensors_groupbox(),

    *batteryicon(),

    *calendar(),

    *layoutIcon(),

    *systray(),

    *powermenu(),
]

# reset colorindex
colorindex = 0

secondary_widgets = [
    *workspaces(),

    *batteryicon(),

    *calendar(),

    *layoutIcon(),

    *powermenu(),
]

widget_defaults = {
    'font': 'Hack Nerd Font Bold',
    'fontsize': 14,
    'padding': 1,
}
extension_defaults = widget_defaults.copy()
