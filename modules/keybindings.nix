{ lib, config, ... }:

let
  modifier = "SUPER";
in
{
  extraConfig = ''
    # Launch applications
    bind = ${modifier},Q,exec,alacritty
    bind = ${modifier},E,exec,dolphin
    bind = ${modifier},R,exec,wofi --show drun
    bind = ${modifier},Z,exec,rofi -show run

    # Window management
    bind = ${modifier},V,togglefloating            # Toggle floating mode
    bind = ${modifier},C,killactive                # Close active window
    bind = ${modifier},M,exit                      # Exit Hyprland
    bind = ${modifier},J,togglesplit               # Toggle between horizontal/vertical tiling
    bindm = ${modifier},mouse:272,movewindow       # Move window with SUPER + Left Click
    bindm = ${modifier},mouse:273,resizewindow     # Resize window with SUPER + Right Click

    # Workspace management
    bind = ${modifier},1,exec,hyprctl dispatch workspace 1; hyprctl dispatch layout master
    bind = ${modifier},2,exec,hyprctl dispatch workspace 2; hyprctl dispatch layout dwindle
    bind = ${modifier},3,exec,hyprctl dispatch workspace 3; hyprctl dispatch layout master
    bind = ${modifier},4,exec,hyprctl dispatch workspace 4; hyprctl dispatch layout master
    bind = ${modifier},5,workspace,5
    bind = ${modifier},6,workspace,6
    bind = ${modifier},7,workspace,7
    bind = ${modifier},8,workspace,8
    bind = ${modifier},9,workspace,9
    bind = ${modifier},0,workspace,10

    # Move focused window to another workspace
    bind = ${modifier} SHIFT,1,exec,hyprctl dispatch movetoworkspace 1; hyprctl dispatch workspace 1; hyprctl dispatch layout master
    bind = ${modifier} SHIFT,2,exec,hyprctl dispatch movetoworkspace 2; hyprctl dispatch workspace 2; hyprctl dispatch layout dwindle
    bind = ${modifier} SHIFT,3,exec,hyprctl dispatch movetoworkspace 3; hyprctl dispatch workspace 3; hyprctl dispatch layout master
    bind = ${modifier} SHIFT,4,exec,hyprctl dispatch movetoworkspace 4; hyprctl dispatch workspace 4
    bind = ${modifier} SHIFT,5,exec,hyprctl dispatch movetoworkspace 5; hyprctl dispatch workspace 5
    bind = ${modifier} SHIFT,6,exec,hyprctl dispatch movetoworkspace 6; hyprctl dispatch workspace 6
    bind = ${modifier} SHIFT,7,exec,hyprctl dispatch movetoworkspace 7; hyprctl dispatch workspace 7
    bind = ${modifier} SHIFT,8,exec,hyprctl dispatch movetoworkspace 8; hyprctl dispatch workspace 8
    bind = ${modifier} SHIFT,9,exec,hyprctl dispatch movetoworkspace 9; hyprctl dispatch workspace 9
    bind = ${modifier} SHIFT,0,exec,hyprctl dispatch movetoworkspace 10; hyprctl dispatch workspace 10

    bind = ${modifier},V,togglefloating            # Toggle floating mode
    bind = ${modifier} SHIFT,T,exec,hyprctl dispatch togglefloating; hyprctl dispatch resizeactive auto


    # Focus management
    bind = ${modifier},left,movefocus,l            # Focus left
    bind = ${modifier},right,movefocus,r           # Focus right
    bind = ${modifier},up,movefocus,u              # Focus up
    bind = ${modifier},down,movefocus,d            # Focus down

    # Workspace scrolling
    bind = ${modifier},mouse_down,workspace, e+1   # Move to next workspace
    bind = ${modifier},mouse_up,workspace, e-1     # Move to previous workspace
  '';
}

