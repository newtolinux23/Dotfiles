# ~/.dotfiles/nixos-modules/environment.nix
{ config, pkgs, ... }:

{
  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  
  virtualisation.podman = {
    enable = true;

    # Create a `docker` alias for podman, to use it as a drop-in replacement
    dockerCompat = true;

    # Allow containers under podman-compose to communicate
    defaultNetwork.settings.dns_enabled = true;
  };

  # Enable OCI containers using Podman as the backend
  virtualisation.oci-containers.backend = "podman";
  virtualisation.oci-containers.containers = {
    my-container = {
      image = "nginx";
      autoStart = true;
      ports = [ "127.0.0.1:8080:80" ];
    };
  };

  # Useful development tools
  environment.systemPackages = with pkgs; [
    podman
    dive             # Tool to inspect Docker image layers
    podman-tui       # Podman terminal UI
    podman-compose   # Compose tool for Podman
    docker-compose   # Docker Compose compatibility
  ];

  # Optional: Allow rootless containers for user 'rob'
  users.users.rob = {
    subUidRanges = [{ start = 100000; count = 65536; }];
    subGidRanges = [{ start = 100000; count = 65536; }];
  };

  # Allow unfree packages if necessary
  nixpkgs.config.allowUnfree = true;

  # Swap and kernel tweaks
  swapDevices = [ { device = "/swapfile"; size = 4096; options = [ "sw" "pri=5" ]; } ];
  boot.kernel.sysctl = {
    "vm.swappiness" = 5;
    "vm.vfs_cache_pressure" = 50;
    "fs.inotify.max_user_watches" = 524288;
  };
}
