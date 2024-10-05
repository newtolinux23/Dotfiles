{ config, pkgs, ... }:
let
  dotfiles = ./.;
in
{
  xdg.configFile."waybar/config".source = "${dotfiles}/catppuccin/themes/default/config";
  xdg.configFile."waybar/style.css".source = "${dotfiles}/catppuccin/themes/default/style.css";
}
