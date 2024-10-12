# ~/.dotfiles/nixos-modules/services.nix
{ config, pkgs, lib, ... }:

{
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

  # Configure Podman containers to run as systemd services
  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      my-nginx = {
        image = "nginx";
        autoStart = true;
        ports = [ "127.0.0.1:8080:80" ];
      };
    };
  };

  # Enable PAM module for rootless Podman
  security.pam.services = {
    login = {
      extraModules = [ "pam_namespace" ];
    };
  };

  # Enable Tor service
  services.tor = {
    enable = true;
    settings = {
      SocksPort = "9050";
    };
  };

  # Enable polkit for authentication management
  security.polkit.enable = true;

  # Enable systemd service for Fanctl (fan control)
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
}
