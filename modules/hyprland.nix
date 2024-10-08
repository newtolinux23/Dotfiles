# ~/.dotfiles/modules/hyprland.nix
{ config, pkgs, lib, ... }:

let
  # Import the configuration modules
  keybindings = import ./keybindings.nix { inherit lib config; };
  windowrules = import ./windowrules.nix { inherit lib config; };
  animations = import ./animations.nix { inherit lib config; };
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;

    extraConfig = ''
      monitor=,preferred,auto,1.50

      # Set wallpaper
      exec-once = swaybg -i ~/.dotfiles/wallpapers/Staircase.png 
      # Set programs
      $terminal = alacritty
      $fileManager = dolphin
      $menu = wofi --show drun

      # Autostart applications
      exec-once = waybar &
      exec-once = nm-applet &

      # Input settings
      input {
        kb_layout = us
        kb_options = grp:alt_shift_toggle
        kb_options = caps:super
        follow_mouse = 1
        touchpad {
          natural_scroll = true
          disable_while_typing = true
          scroll_factor = 0.8
        }
        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
        accel_profile = flat
      }

      # Miscellaneous settings
      misc {
        force_default_wallpaper = 0
        disable_hyprland_logo = true
      }

      # General settings
      general {
        gaps_in = 6
        gaps_out = 6
        border_size = 2
        layout = dwindle
        resize_on_border = true
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)
      }
    ''
      + keybindings.extraConfig
      + windowrules.extraConfig
      + animations.extraConfig;
  };
}
