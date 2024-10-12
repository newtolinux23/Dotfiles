{ config, pkgs, lib, ... }:

{
  # Create a normal user 'rob' with specific groups and settings
  users.users.rob = {
    isNormalUser = true;
    home = "/home/rob";
    description = "rob";
    extraGroups = [ "wheel" "networkmanager" "podman" ]; # Added 'podman' group for container privileges
    shell = pkgs.bash; # Change to your preferred shell, e.g., zsh or fish
  };

  # Define the 'podman' group
  users.groups.podman = {
    name = "podman";
    gid = 101; # You can choose an available group ID or let it be assigned automatically.
  };
}
