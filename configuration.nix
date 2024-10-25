{ config, pkgs, lib, ... }:

{
  imports = [
    ./nixos-modules/hardware.nix
    ./nixos-modules/networking.nix
    ./nixos-modules/services.nix
    ./nixos-modules/environment.nix
    ./nixos-modules/users.nix
  ];
}
