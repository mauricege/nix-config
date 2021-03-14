{ config, pkgs, lib, ... }:
let
   volumeBinds = {
      "XF86AudioRaiseVolume" = "amixer -D pulse sset Master 5%+ && volnoti-show $(amixer -D pulse get Master | grep -Po '[0-9]+(?=%)' | tail -1)";
      "XF86AudioLowerVolume" = "amixer -D pulse sset Master 5%- && volnoti-show $(amixer get Master | grep -Po '[0-9]+(?=%)' | tail -1)";
      "XF86AudioMute" = "amixer -D pulse sset Master 1+ toggle; if amixer -D pulse get Master | grep -Fq '[off]'; then volnoti-show -m; else volnoti-show $(amixer get Master | grep -Po '[0-9]+(?=%)' | tail -1); fi";
};

in {
   services.sxhkd = {
      enable = true;
      keybindings = lib.mkMerge [{
         "alt + control + End" = "rofi -show p -modi p:rofi-power-menu";
         "control + alt + l" = "${pkgs.betterlockscreen}/bin/betterlockscreen --lock blur";
         "super + p" = "bwmenu";
         "super + n" = "networkmanager_dmenu";
         "super + Return" = "kitty";
         "alt + space" = "~/.config/rofi/scripts/search.sh";
         "super + w" = "rofi -show window";
         "super + space" = "~/.config/rofi/scripts/surfraw.sh";
         "super + d" = "rofi -show drun"; }
         volumeBinds];
      extraConfig = ''
# # make sxhkd reload its configuration files:
# super + Escape
# 	pkill -USR1 -x sxhkd

# volume control

/* XF86AudioLowerVolume */
/* 	amixer -D pulse sset Master 5%- */

/* XF86AudioRaiseVolume */
/* 	amixer -D pulse sset Master 5%+ */

/* XF86AudioMute */
/* 	amixer -D pulse sset Master 1+ toggle */

XF86MonBrightnessUp
   $HOME/.scripts/oled-brightness +0.1

XF86MonBrightnessDown
   $HOME/.scripts/oled-brightness -0.1
#
# bspwm hotkeys
#

# quit/restart bspwm
super + alt + {q,r}
   bspc {quit,wm -r}

# close and kill
super + {_,shift + }q
   bspc node -{c,k}

# alternate between the tiled and monocle layout
super + m
   bspc desktop -l next

# send the newest marked node to the newest preselected node
super + y
   bspc node newest.marked.local -n newest.!automatic.local

# swap the current node and the biggest node
super + g
   bspc node -s biggest

#
# state/flags
#

# set the window state
super + {t,shift + t,s,f}
   bspc node -t {tiled,pseudo_tiled,floating,fullscreen}

# set the node flags
super + ctrl + {m,x,y,z}
   bspc node -g {marked,locked,sticky,private}

#
# focus/swap 

# focus the node in the given direction
super + {_,shift + }{h,j,k,l}
   bspc node -{f,s} {west,south,north,east}

# focus the node for the given path jump
super + {p,b,comma,period}
   bspc node -f @{parent,brother,first,second}

# focus the next/previous node in the current desktop
super + {_,shift + }c
   bspc node -f {next,prev}.local

# focus the next/previous desktop in the current monitor
super + bracket{left,right}
   bspc desktop -f {prev,next}.local

# focus the last node/desktop
super + {grave,Tab}
   bspc {node,desktop} -f last

# focus the older or newer node in the focus history
super + {o,i}
   bspc wm -h off; \
   bspc node {older,newer} -f; \
   bspc wm -h on

# focus or send to the given desktop
super + {_,shift + }{1-9,0}
   bspc {desktop -f,node -d} '^{1-9,10}'

#
# preselect
#

# preselect the direction
super + ctrl + {h,j,k,l}
   bspc node -p {west,south,north,east}

# preselect the ratio
super + ctrl + {1-9}
   bspc node -o 0.{1-9}

# cancel the preselection for the focused node
super + ctrl + space
   bspc node -p cancel

# cancel the preselection for the focused desktop
super + ctrl + shift + space
   bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel

#
# move/resize
#

# expand a window by moving one of its side outward
super + alt + {h,j,k,l}
   bspc node -z {left -40 0,bottom 0 40,top 0 -40,right 40 0}

# contract a window by moving one of its side inward
super + alt + shift + {h,j,k,l}
   bspc node -z {right -40 0,top 0 40,bottom 0 -40,left 40 0}

# move a floating window
super + {Left,Down,Up,Right}
   bspc node -v {-20 0,0 20,0 -20,20 0}


Print
    scrot -e 'mv $f ~/Pictures/Screenshots'
'';
   };
}