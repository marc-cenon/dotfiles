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
from colors import Colors
from Xlib import display as xdisplay
import subprocess
import os

####################################
## start programs from bashscript ##
####################################
@hook.subscribe.startup

def start():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

#####################
## basic variables ##
#####################

mod = "mod1"
terminal = "kitty"
browser = "google-chrome-stable"
file_manager = "nemo"

###########################################
##    get number of monitor dynamically  ##
##       need python-xlib to work        ##
###########################################

def get_num_monitors():
    num_monitors = 0
    try:
        display = xdisplay.Display()
        screen = display.screen()
        resources = screen.root.xrandr_get_screen_resources()

        for output in resources.outputs:
            monitor = display.xrandr_get_output_info(output, resources.config_timestamp)
            preferred = False
            if hasattr(monitor, "preferred"):
                preferred = monitor.preferred
            elif hasattr(monitor, "num_preferred"):
                preferred = monitor.num_preferred
            if preferred:
                num_monitors += 1
    except Exception as e:
        # always setup at least one monitor
        return 1
    else:
        return num_monitors

num_monitors = get_num_monitors()

# alternative setup for 3 monitor& 

#def get_monitors():
#    xr = subprocess.check_output('xrandr --query | grep " connected"', shell=True).decode().split('\n')
#    monitors = len(xr) - 1 if len(xr) > 2 else len(xr)
#    return monitors
# Move window to screen with Mod, Alt and number
#for i in range(monitors):
#    keys.extend([
#        Key([mod, "space"], str(i+1), lazy.window.toscreen(i)),
#    keys.extend([Key([mod, "z"], str(i+1), lazy.window.toscreen(i))]),
#   ])

#####################################
## setup for for switching monitor ##
#####################################

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

def back_and_forth(qtile):
    qtile.current_screen.set_group(qtile.current_screen.previous_group)


##############
## bindings ##
##############

keys = [

    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),

    # Move windows
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Switch focus to specific monitor (out of three)
    #Key([mod], "d",lazy.to_screen(0), desc='Keyboard focus to monitor 1'),
    #Key([mod], "s",lazy.to_screen(1), desc='Keyboard focus to monitor 2'),

    ### Switch focus of monitors
    Key([mod], "i",lazy.next_screen(), desc='Move focus to next monitor'),
    Key([mod], "o",lazy.prev_screen(), desc='Move focus to prev monitor'),

    # Switch active window to another screen
    #Key([mod,"control"], "i",  lazy.function(window_to_next_screen)),    
    #Key([mod,"control"], "o", lazy.function(window_to_previous_screen)),
    Key([mod,"control"],"i",  lazy.function(window_to_next_screen, switch_screen=True)),
    Key([mod,"control"],"o", lazy.function(window_to_previous_screen, switch_screen=True)),

    # Back and forth
    Key([mod],"Tab", lazy.function(back_and_forth)),

    # Resize Windows
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle floating
    Key([mod, "control"], "f", lazy.window.toggle_floating()),
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),

    # Terminal
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # kill window
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),

    # Shutdown/Restart Qtile
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # Rofi apps launcher
    Key([mod], "space", lazy.spawn("rofi -show-icons -location 0 -show drun -sidebar-mode -columns")),

    # Volume controls
    Key([mod], "u", lazy.spawn('pactl set-sink-volume 0 +5%')),
    Key([mod], "y", lazy.spawn('pactl set-sink-volume 0 -5%')),

    # Media controls
    #Key([mod], "ç", lazy.spawn('playerctl previous')),
    #Key([mod], "à", lazy.spawn('playerctl next')),

    # Emoji Rofi launcher
    #Key([mod], "o", lazy.spawn('rofi -show emoji -modi emoji')),

    # Discord
    Key([mod], "d", lazy.spawn("discord")),

    # file_manager
    Key([mod], "f", lazy.spawn(file_manager)),

    # Browser
    Key([mod], "b", lazy.spawn(browser)),
]
###################
## groups config ##
###################

groups = []

# FOR AZERTY KEYBOARDS : use xdev to get the name of the key
#group_names = ["ampersand", "eacute", "quotedbl", "apostrophe", "parenleft", "minus", "egrave", "underscore", "ccedilla", "agrave",]
#group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0",]
#group_layouts = ["monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall",]

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
        # CHANGE WORKSPACES
        Key([mod], i.name, lazy.group[i.name].toscreen()),
        #Key([mod], "Tab", lazy.screen.next_group()),
        #Key([mod, "shift"], "Tab", lazy.screen.prev_group()),
        Key([mod, "shift"], i.name, lazy.window.togroup(
            i.name), lazy.group[i.name].toscreen()),
    ])


#################
## color setup ##
#################

palette = Colors()

#######################
## layout definition ##
#######################

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
                    #padding_x=8,
                    #borderwidth=0,
                    active=palette.WHITE,
                    inactive=palette.WHITE,
                    rounded=True,
                    font="Source Code Pro",
                    highlight_method="block",
                    highlight_color=palette.DARK,
                    block_highlight_text_color=palette.WHITE,
                    this_current_screen_border=palette.SECONDARY,
                    foreground=palette.DARK,
                    background=palette.DARK,
                    hide_unused=True
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
                 widget.CurrentScreen(),
            ],
            35,
            margin=[10, 10, 10, 10],
            background=palette.DARK,
            opacity=1,
        ),
    ),
]

if num_monitors > 1:
    for m in range(num_monitors -1):
        screens.append(
            Screen(
                top=bar.Bar(
                    [
                        widget.GroupBox(
                            fontsize=20,
                            padding_x=8,
                            borderwidth=0,
                            active=palette.WHITE,
                            inactive=palette.WHITE,
                            rounded=True,
                            font="Source Code Pro",
                            highlight_method="block",
                            highlight_color=palette.DARK,
                            block_highlight_text_color=palette.WHITE,
                            this_current_screen_border=palette.SECONDARY,
                            foreground=palette.DARK,
                            background=palette.DARK,
                            hide_unused=True
                        ),
                        widget.Spacer(),
                        widget.WindowName(
                            format='{name}'
                        ),
                        widget.Spacer(),
                        widget.CurrentScreen(),
                    ],
                    35,
                    margin=[10, 10, 10, 10],
                    background=palette.DARK,
                    opacity=1,

                ),
            )
        )

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

    Match(wm_class='zoom'),  # Zoom selector

],
    border_width=0,
)
auto_fullscreen = True
focus_on_window_activation = "smart"

wmname = "Qtile"
