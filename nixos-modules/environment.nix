# ~/.dotfiles/nixos-modules/environment.nix
{ config, pkgs, lib, ... }:

let
  # Define Wayland variables for reuse
  waylandVars = {
    QT_QPA_PLATFORM = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };
  # Custom font for additional use
  customFont = pkgs.fetchurl {
    url = "https://downloads.sourceforge.net/project/corefonts/the%20fonts/final/times32.exe";
    sha256 = "1aq7z3l46vwgqljvq9zfgkii6aivy00z1529qbjkspggqrg5jmnv";
  };
in
{
  # Set timezone and locale
  time.timeZone = "America/Chicago";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Environment variables, optimized for Wayland, Qt, and VAAPI
  environment.variables = waylandVars // {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    XDG_SESSION_TYPE = "wayland";
    XDG_ICON_THEME = "breeze";
    LIBVA_DRIVER_NAME = "iHD";  # Intel VAAPI driver for newer Intel GPUs
    LIBVA_DRIVERS_PATH = "/nix/store/3rihr4l4xlggcczsbzqcjm1mmpvlzvq8-intel-media-driver-24.2.1/lib/dri";  # Path to iHD driver
  };

  # System packages
  environment.systemPackages = with pkgs; [
    cmake gnumake git emacs tmux konsole docker docker-compose preload
    dejavu_fonts fira-code nerdfonts meslo-lgs-nf jetbrains-mono open-sans source-code-pro
    brightnessctl bubblewrap bleachbit fd htop lm_sensors shellcheck starship ispell
    swaybg waybar wayland-protocols wayland-utils wl-clipboard hyprland hyprpaper hyprcursor
    vlc mpv udevil udisks2
    tor tor-browser-bundle-bin wireguard-tools networkmanager networkmanagerapplet
    firefox-wayland flatpak keepassxc kdeconnect kwin okular pavucontrol proxychains-ng pulseaudio
    python3 python311Packages.pip python312Packages.pip ripgrep sudo texliveFull unzip usbutils webcamoid wget wineWow64Packages.fonts
    xdg-desktop-portal-gtk xdg-desktop-portal-hyprland xdg-utils xfce.thunar xorg.xf86inputsynaptics
    xorg.xrandr xorg.xdpyinfo zoom-us
    kdePackages.breeze-icons papirus-icon-theme material-design-icons kdePackages.qtstyleplugin-kvantum
    libsForQt5.qt5ct libsForQt5.bismuth
    intel-media-driver libva-utils mesa libva libdrm intel-vaapi-driver
    vulkan-loader vulkan-tools mesa.drivers
    firmwareLinuxNonfree
  ];

  # Fonts configuration
  fonts = {
    packages = with pkgs; [
      font-awesome udev-gothic-nf fira-code source-code-pro customFont
    ];
  };

  # Swap and kernel tweaks
  swapDevices = [ { device = "/swapfile"; size = 4096; options = [ "sw" "pri=5" ]; } ];
  boot.kernel.sysctl = {
    "vm.swappiness" = 5;
    "vm.vfs_cache_pressure" = 50;
    "fs.inotify.max_user_watches" = 524288;
  };

  # Enable Flatpak and experimental Nix features
  services.flatpak.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Automount USB drives with a custom service
  services.udisks2.enable = true;
  systemd.user.services.automount-usb = {
    description = "Automount USB drives";
    serviceConfig = {
      ExecStart = "${pkgs.udiskie}/bin/udiskie --no-tray --automount";
    };
    wantedBy = [ "default.target" ];
  };

  # Configure SDDM and apply a theme
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.theme = "chili";  # Replace 'chili' with your desired theme

  system.stateVersion = "24.05";

  # Overlay to remove duplicate files from Papirus icon theme to avoid collisions
  nixpkgs.overlays = [
    (self: super: {
      papirus-icon-theme = super.papirus-icon-theme.overrideAttrs (oldAttrs: {
        postInstall = ''
          # Remove conflicting icons shared with breeze-icons
          rm -rf $out/share/icons/breeze/devices/22@3x/*.svg
          rm -rf $out/share/icons/breeze/index.theme
        '';
      });
    })
  ];

  virtualisation.docker.enable = true;

  # Allow unfree packages if necessary
  nixpkgs.config.allowUnfree = true;
}
