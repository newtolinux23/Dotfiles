{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # System Utilities
    neofetch
    clipman
    starship
    figlet

    # Applications
    dunst
    gtk3
    alacritty
    wofi
    xclip

    # Xorg utilities
    xorg.setxkbmap  # Correct access to setxkbmap
  ];
}
