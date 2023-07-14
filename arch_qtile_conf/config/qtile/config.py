#    ____  __  _ __
#   / __ \/ /_(_) /__
#  / / / / __/ / / _ \
# / /_/ / /_/ / /  __/
# \___\_\__/_/_/\___/
#
from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook, extension
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from colors import Colors
# this import requires python-xlib to be installed
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
file_manager = "thunar"

###########################################
##    get number of monitor dynamically  ##
##       need python-xlib to work        ##
###########################################
# https://github.com/qtile/qtile/wiki/screens

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

#####################################
## setup for for switching monitor ##
#####################################
def cycle_workspaces(direction, move_window):
    def _inner(qtile):
        current = qtile.groups.index(qtile.current_group)
        destination = (current + direction) % len(groups)
        if move_window:
            qtile.current_window.togroup(qtile.groups[destination].name)
        qtile.groups[destination].cmd_toscreen()
    return _inner


next_workspace = lazy.function(cycle_workspaces(direction=1, move_window=False))
previous_workspace = lazy.function(cycle_workspaces(direction=-1, move_window=False))
to_next_workspace = lazy.function(cycle_workspaces(direction=1, move_window=True))
to_previous_workspace = lazy.function(cycle_workspaces(direction=-1, move_window=True))

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

    ### Switch focus of monitors
    Key([mod], "i",lazy.next_screen(), desc='Move focus to next monitor'),
    Key([mod], "o",lazy.prev_screen(), desc='Move focus to prev monitor'),

    # Switch active window to another screen
    #Key([mod,"control"], "i",  lazy.function(window_to_next_screen)),    
    #Key([mod,"control"], "o", lazy.function(window_to_previous_screen)),

    Key(["control", mod], "l", next_workspace),
    Key(["control", mod], "h", previous_workspace),
    Key(["control", mod, "shift"], "l", to_next_workspace),
    Key(["control", mod, "shift"], "h", to_previous_workspace),

#    Key([mod,"control"],"i",  lazy.function(window_to_next_screen, switch_screen=False)),
#    Key([mod,"control"],"o", lazy.function(window_to_previous_screen, switch_screen=False)),

    # Back and forth
    Key([mod],"Tab", lazy.function(back_and_forth)),

    # Resize Windows
    #Key([mod, "ISO_Level3_Shift"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    #Key([mod, "ISO_Level3_Shift"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    #Key([mod, "ISO_Level3_Shift"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    #Key([mod, "ISO_Level3_Shift"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    #Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

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

    # Rofi power menu
    Key([mod], "x", lazy.spawn("rofi -show power-menu -modi power-menu:rofi-power-menu")),

    # Volume controls
    Key([mod], "u", lazy.spawn('pactl set-sink-volume 0 +5%')),
    Key([mod], "y", lazy.spawn('pactl set-sink-volume 0 -5%')),


    # dmenu
    Key([mod], "d", lazy.spawn("dmenu_run")),

    # file_manager
    Key([mod], "f", lazy.spawn(file_manager)),

    # Browser
    Key([mod], "b", lazy.spawn(browser)),

    # ------------ Hardware Configs ------------
    # Volume
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),

    # Brightness
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +5%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%-")),
    # power menu
    Key([mod, 'control'], 'x', lazy.run_extension(extension.CommandSet(
    commands={
        'suspend': 'systemctl suspend',
        'shutdown': 'systemctl poweroff',
        'reboot': 'systemctl reboot',
        'logout': 'loginctl terminate-session $XDG_SESSION_ID',
        'lock': 'loginctl lock-session',
    },
    dmenu_prompt='session>',
    )), desc='List options to quit the session.'),
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
        # switch to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name), lazy.group[i.name].toscreen()),
        # do not switch to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name))
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
    padding=4,
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
                #widget.Spacer(),
                widget.WindowName(
                    format='{name}'
                ),
                widget.Systray(),
                widget.Volume(
                    fmt = "[VOL:{}]"
                ),
                widget.CPU(
                    format = "[CPU:{load_percent}%]"
                ),
                widget.Memory(
                    format = "[RAM:{MemUsed:.0f}M]",
                ),
                widget.DF(
                    format = "[SPACE:{uf}{m}]",
                    partition = "/home",
                    measure = "G",
                    visible_on_warn=False
                ),
                widget.Backlight(
                    brightness_file = "/sys/class/backlight/intel_backlight/brightness",
                    max_brightness_file = "/sys/class/backlight/intel_backlight/max_brightness",
                    fmt = "[SCREEN:{}]"
                ),
                widget.Battery(
                    format = "[BATT:{percent:2.0%}]"
                ),
                widget.Clock(
                    format='[TIME:%H:%M]'
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
                        #widget.Spacer(),
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
