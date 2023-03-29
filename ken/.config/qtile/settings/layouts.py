
from libqtile import layout
from libqtile.config import Match
from .theme import colors

# Layouts and layout rules


layout_conf = {
    'border_focus': colors['focus'][0],
    'border_width': 2,
    'margin': 5
}

layouts = [
    # layout.Max(),
    layout.MonadTall(**layout_conf),
    layout.MonadWide(**layout_conf),
    layout.Bsp(border_on_single=True, **layout_conf),
    # layout.Spiral(**layout_conf),
    # layout.Matrix(columns=2, **layout_conf),
    # layout.RatioTile(**layout_conf, fancy=False),
    # layout.Floating(**layout_conf),
    # layout.Columns(),
    # layout.Tile(),
    # layout.TreeTab(**layout_conf),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),
        Match(wm_class='astrill'),
        Match(wm_class='ssh-askpass'),
        Match(wm_class='notification'),
        Match(wm_class='blueman-manager'),
        Match(wm_class='conky'),
        Match(wm_class='pavucontrol'),
        Match(wm_class='nm-connection-editor'),
        Match(title='branchdialog'),
    ],
    border_focus=colors["color4"][0]
)
