# ~/.dotfiles/modules/windowrules.nix
{ lib, config, ... }:

{
  extraConfig = ''
    windowrulev2 = suppressevent maximize, class:.*
    windowrule = float, class:^(Spotify|Gimp)$
    windowrule = fullscreen, class:^(mpv)$
    windowrule = noborder,^(wofi)$
    windowrule = center,^(wofi)$
    windowrule = center,^(steam)$
    windowrule = float, nm-connection-editor|blueman-manager
    windowrule = float, swayimg|vlc|Viewnior|pavucontrol
    windowrule = float, nwg-look|qt5ct|mpv
    windowrule = float, zoom
    windowrulev2 = stayfocused, title:^()$,class:^(steam)$
    windowrulev2 = minsize 1 1, title:^()$,class:^(steam)$
    windowrulev2 = opacity 0.9 0.7, class:^(Brave)$
    windowrulev2 = opacity 0.9 0.7, class:^(thunar)$
  '';
}
