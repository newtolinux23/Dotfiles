# ~/.dotfiles/nixos-modules/services.nix
{ config, pkgs, lib, ... }:

{
  # Intel video driver configuration
  services.xserver.videoDrivers = [ "intel" ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  networking.nameservers = [ "127.0.0.1" ];

  # Disable PulseAudio as PipeWire will be used
  hardware.pulseaudio.enable = false;

  # Enable PipeWire with ALSA, PulseAudio, and JACK support
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Enable SDDM with Wayland and chili theme
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "chili";
    autoNumlock = true;
  };

  # Enable Hyprland as the Wayland compositor
  programs.hyprland.enable = true;

  # Enable Waydroid for Android emulation
  virtualisation.waydroid.enable = true;

  # Enable Docker
  services.docker = {
    enable = true;
    extraOptions = "--log-driver=journald";  # Optional: Set log driver
  };

  # Add user to the Docker group to allow running Docker without sudo
  users.groups.docker = { };
  users.users.rob = {
    isNormalUser = true;
    extraGroups = [ "docker" ];  # Add user to the Docker group
  };

  # Define systemd service for fanctl
  systemd.services.fanctl = {
    description = "Fanctl Service";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.fanctl}/bin/fanctl --config /etc/fanctl.conf";
      Restart = "always";
    };
  };

  # Enable timesyncd service for time synchronization
  services.timesyncd.enable = true;

  # Enable Tor service with SOCKS port
  services.tor = {
    enable = true;
    settings = {
      SocksPort = "9050";
    };
  };

  # Enable polkit for authentication management
  security.polkit.enable = true;

  # Define a systemd service to update SDDM avatars on boot
  systemd.services."sddm-avatar" = {
    description = "Service to copy or update user avatars at startup.";
    wantedBy = [ "multi-user.target" ];
    before = [ "sddm.service" ];
    script = ''
      set -eu
      for user in /home/*; do
          username=$(basename "$user")
          if [ -f "$user/.face.icon" ]; then
              if [ ! -f "/var/lib/AccountsService/icons/$username" ]; then
                  cp "$user/.face.icon" "/var/lib/AccountsService/icons/$username"
              else
                  if [ "$user/.face.icon" -nt "/var/lib/AccountsService/icons/$username" ]; then
                      cp "$user/.face.icon" "/var/lib/AccountsService/icons/$username"
                  fi
              fi
          fi
      done
    '';
    serviceConfig = {
      Type = "simple";
      User = "root";
      StandardOutput = "journal+console";
      StandardError = "journal+console";
    };
  };

  # Ensure SDDM starts after the avatar service
  systemd.services.sddm.after = [ "sddm-avatar.service" ];

  # Remove Podman if it's installed
  environment.systemPackages = lib.remove [ pkgs.podman ] environment.systemPackages;
}
