{ config, pkgs, lib, ... }:

{
  # Create a normal user 'rob' with specific groups and settings
  users.users.rob = {
    isNormalUser = true;
    home = "/home/rob";
    description = "rob";
    extraGroups = [ "wheel" "networkmanager" ]; # Groups for sudo and network management
    shell = pkgs.bash; # Change to your preferred shell, e.g., zsh or fish
  };
}
