#    ____  __  _ __
#   / __ \/ /_(_) /__
#  / / / / __/ / / _ \
# / /_/ / /_/ / /  __/
# \___\_\__/_/_/\___/
#
from typing import List  # noqa: F401
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from colors import Colors

import subprocess
import os


@hook.subscribe.startup
def start():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])


mod = "mod1"
terminal = "alacritty"
browser = "google-chrome-stable"
file_manager = "nautilus"

#################################
########### SCREENS #############
#################################

def window_to_previous_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i - 1)

def window_to_next_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i + 1)


#################################
###########  KEYS  ##############
#################################

keys = [

    ######## Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),

    ######## Move windows
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Switch focus to specific monitor (out of three)
    #Key([mod], "d",lazy.to_screen(0), desc='Keyboard focus to monitor 1'),
    #Key([mod], "s",lazy.to_screen(1), desc='Keyboard focus to monitor 2'),

    ######## Switch focus of monitors
    Key([mod], "i",lazy.next_screen(), desc='Move focus to next monitor'),
    Key([mod], "o",lazy.prev_screen(), desc='Move focus to prev monitor'),

    ######## Switch active window to another screen
    Key([mod,"control"],"i",  lazy.function(window_to_next_screen, switch_screen=True)),
    Key([mod,"control"],"o", lazy.function(window_to_previous_screen, switch_screen=True)),

    ######## Resize Windows
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    ######## Toggle floating
    Key([mod], "f", lazy.window.toggle_floating()),
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),

    ######## Terminal
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    ######## Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    ######## Shutdown/Restart Qtile
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    ######## Rofi apps launcher
    Key([mod], "space", lazy.spawn("rofi -combi-modi drun -font 'Source Code Pro 20' -show drun -icon-theme 'Papirus' -show-icons")),

    ######## Volume controls
    Key([mod], "u", lazy.spawn('pactl set-sink-volume 0 +5%')),
    Key([mod], "y", lazy.spawn('pactl set-sink-volume 0 -5%')),

    # Media controls
    #Key([mod], "ç", lazy.spawn('playerctl previous')),
    #Key([mod], "à", lazy.spawn('playerctl next')),

    # Emoji Rofi launcher
    #Key([mod], "o", lazy.spawn('rofi -show emoji -modi emoji')),

    ######## Discord
    Key([mod], "d", lazy.spawn("discord")),

    ######## Nautilus
    Key([mod], "n", lazy.spawn(file_manager)),

    ######## Browser
    Key([mod], "b", lazy.spawn(browser)),
]

groups = []

######### FOR AZERTY KEYBOARDS
#group_names = ["ampersand", "eacute", "quotedbl", "apostrophe", "parenleft", "minus", "egrave", "underbar", "ccedilla", "agrave",]
#group_labels = ["1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 ", "0",]
#group_layouts = ["monadtall", "matrix", "monadtall", "bsp", "monadtall", "matrix", "monadtall", "bsp", "monadtall", "monadtall",]

group_names = ["ampersand", "eacute", "quotedbl", "apostrophe", "parenleft", "minus",]
group_labels = ["1", "2", "3", "4", "5", "6",]
group_layouts = ["monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall",]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

for i in groups:
    keys.extend([

        ######## CHANGE WORKSPACES
        Key([mod], i.name, lazy.group[i.name].toscreen()),
        Key([mod], "Tab", lazy.screen.next_group()),
        Key([mod, "shift"], "Tab", lazy.screen.prev_group()),
        Key([mod, "shift"], i.name, lazy.window.togroup(
            i.name), lazy.group[i.name].toscreen()),
    ])

###########################
######### COLORS ##########
###########################
catppuccin = {
    "flamingo": "#F2CDCD",
    "mauve": "#DDB6F2",
    "pink": "#F5C2E7",
    "maroon": "#E8A2AF",
    "red": "#F28FAD",
    "peach": "#F8BD96",
    "yellow": "#FAE3B0",
    "green": "#ABE9B3",
    "teal": "#B5E8E0",
    "blue": "92CDFB",
    "sky": "#89DCEB",
    "white": "#D9E0EE",
    "gray0": "#6E6C7E",
    "black1": "#1A1826",
    }
palette = Colors()

###########################
####### BAR LAYOUT ########
###########################

layouts = [
    layout.Columns(border_focus="B2BEB5",
        border_normal="B2BEB5",
                   border_width=0,
                   margin=[10, 10, 10, 10],
                   font="Source Code Pro",
                   fontsize=18,
                   )
]

widget_defaults = dict(
    font='Source Code Pro',
    fontsize=18,
    padding=8,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    fontsize=20,
                    padding_x=8,
                    borderwidth=0,
                    active=catppuccin["pink"],
                    #active=palette.WHITE,
                    inactive=catppuccin["pink"],
                    #inactive=palette.WHITE,
                    rounded=True,
                    font="Source Code Pro",
                    highlight_method="block",
                    highlight_color=catppuccin["black1"],
                    #highlight_color=palette.DARK,
                    block_highlight_text_color=palette.WHITE,
                    this_current_screen_border=palette.SECONDARY,
                    foreground=catppuccin["black1"],
                    #foreground=palette.DARK,
                    background=catppuccin["black1"],
                    #background=palette.DARK,
                    #hide_unused=True
                    hide_unused=False
                ),
                widget.Spacer(),
                widget.WindowName(
                    format='{name}'
                ),
                widget.Systray(),
                widget.CPU(
                    format = "CPU:{load_percent}%"
                ),
                widget.Memory(
                    format = "RAM:{MemUsed:.0f}M",
                ),
                widget.DF(
                    format = "SPACE:{uf}{m}",
                    measure = "G",
                    visible_on_warn=False
                ),
                widget.Volume(
                ),
                widget.Clock(format='%H:%M',
                    padding=10,
                ),
            ],
            35,
            margin=[10, 10, 0, 10],
            background=catppuccin["black1"],
            #background=palette.DARK,
            opacity=1,
        ),
    ),
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,

    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(wm_class='zoom'),  # Zoom selector
    Match(wm_class='coreshot'),  # gitk
    Match(title='coreshot'),  # gitk
    Match(title='Screenshot'),  # screenshor
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(title='Emoji Selector'),  # Emoji selector
    Match(title='Zoom'),  # Emoji selector

],
    border_width=0,
)
auto_fullscreen = True
focus_on_window_activation = "smart"

wmname = "LG3D"
reconfigure_screens = True
