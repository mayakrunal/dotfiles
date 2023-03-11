from libqtile import widget
from .theme import colors
from libqtile import qtile
from .user import my

# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)


# start with index 1 when using first and last are resevered
colornames = ["dark",
              "color1",
              "color2",
              "color3",
              "color4",
              "color1",
              "color2",
              "color3",
              "color4",
              "color1",
              "color2",
              "color3",
              "color4"]


def base(fg='text', bg='dark'):
    return {
        'foreground': colors[fg],
        'background': colors[bg]
    }


def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)


def icon(fg='text', bg='dark', fontsize=16, text="?"):
    return widget.TextBox(
        **base(fg, bg),
        fontsize=fontsize,
        text=text,
        padding=3
    )


def powerline(fg="light", bg="dark"):
    return widget.TextBox(
        **base(fg, bg),
        text="",  # Icon: nf-oct-triangle_left
        # text="",
        fontsize=45,
        padding=-6
    )


def workspaces():
    return [
        separator(),
        widget.GroupBox(
            **base(fg='light'),
            font='Hack Nerd Font',
            fontsize=19,
            margin_y=3,
            margin_x=0,
            padding_y=8,
            padding_x=5,
            borderwidth=1,
            active=colors['active'],
            inactive=colors['inactive'],
            rounded=True,
            hide_unused=False,
            highlight_method='block',
            urgent_alert_method='block',
            urgent_border=colors['urgent'],
            this_current_screen_border=colors['focus'],
            this_screen_border=colors['grey'],
            other_current_screen_border=colors['dark'],
            other_screen_border=colors['dark'],
            disable_drag=True
        ),
        separator(),
        # widget.WindowName(**base(fg='focus'), fontsize=14, padding=5),
        # separator(),
        widget.TaskList(**base(fg='focus'),
                        font='Hack Nerd Font',
                        fontsize=14,
                        padding=5,
                        highlight_method='block',
                        theme_mode="preferred"),
        separator(),
    ]


def updater(colorindex):
    return [
        powerline(colornames[colorindex],
                  colornames[colorindex - 1]),

        icon(bg=colornames[colorindex],
             text=' '),  # Icon: nf-fa-download

        widget.CheckUpdates(
            background=colors[colornames[colorindex]],
            colour_have_updates=colors['text'],
            colour_no_updates=colors['text'],
            no_update_string='0',
            display_format='{updates}',
            update_interval=1800,
            custom_command='checkupdates',
            padding=5,
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(
                my.terminal + ' -e yay')}
        ),
    ]


def network(colorindex):
    return [
        powerline(colornames[colorindex], colornames[colorindex - 1]),

        icon(bg=colornames[colorindex], text=' '),  # Icon: nf-fa-feed

        widget.Net(**base(bg=colornames[colorindex]),
                   format='{down} 󰜮󰜷 {up}',
                   padding=3),
    ]


def layoutIcon(colorindex):
    return [
        powerline(colornames[colorindex], colornames[colorindex - 1]),

        widget.CurrentLayoutIcon(
            **base(bg=colornames[colorindex]), scale=0.65),
        # widget.CurrentLayout(**base(bg='color2'), padding=5),
    ]


def calendar(colorindex):
    return [
        powerline(colornames[colorindex], colornames[colorindex - 1]),
        # Icon: nf-mdi-calendar_clock
        icon(bg=colornames[colorindex], fontsize=17, text=' '),

        widget.Clock(
            **base(bg=colornames[colorindex]),
            format='%d %B %I:%M %p',
            padding=5),
    ]


def systray():
    return [
        # powerline(colornames[colorindex], colornames[colorindex - 1]),

        widget.Systray(background=colors["dark"], padding=5),
    ]


def batteryicon(colorindex):
    return [
        powerline(colornames[colorindex], colornames[colorindex - 1]),

        widget.BatteryIcon(**base(bg=colornames[colorindex])),
        widget.Battery(
            **base(bg=colornames[colorindex]), format='{percent:2.0%}'),
    ]


def powermenu():
    return [
        widget.TextBox(
            **base('light', 'dark'),
            fontsize=14,
            text="    ",
            padding=3,
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(
                my.powermenu)}
        )
    ]


primary_widgets = [
    *workspaces(),

    *systray(),

    *batteryicon(1),

    *updater(2),

    *network(3),

    *calendar(4),

    *layoutIcon(5),

    *powermenu(),
]


secondary_widgets = [
    *workspaces(),
    *calendar(1),
    *layoutIcon(2),
    *powermenu(),
]

widget_defaults = {
    'font': 'Hack Nerd Font Bold',
    'fontsize': 14,
    'padding': 1,
}
extension_defaults = widget_defaults.copy()
