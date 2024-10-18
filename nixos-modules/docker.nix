# ~/.dotfiles/nixos-modules/docker.nix
{ config, pkgs, ... }:

{
  services.docker = {
    enable = true;
    extraOptions = "--log-driver=journald";
  };
}
