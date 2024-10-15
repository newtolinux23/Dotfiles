# ~/.dotfiles/nixos-modules/environment.nix
{ config, pkgs, lib, ... }:

let
  # Define Wayland variables for reuse
  waylandVars = {
    QT_QPA_PLATFORM = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };
  # Custom font
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
    LIBVA_DRIVERS_PATH = "/nix/store/3rihr4l4xlggcczsbzqcjm1mmpvlzvq8-intel-media-driver-24.2.1/lib/dri";  # Exact path to iHD driver
  };

  # Essential system packages, grouped by category
  environment.systemPackages = with pkgs; [
    # Development Tools
    cmake gnumake git emacs tmux konsole

    # Fonts
    dejavu_fonts fira-code nerdfonts meslo-lgs-nf jetbrains-mono open-sans source-code-pro

    # System Utilities
    brightnessctl bubblewrap bleachbit fd htop lm_sensors shellcheck starship

    # Wayland Tools
    swaybg waybar wayland-protocols wayland-utils wl-clipboard xwayland hyprland hyprpaper hyprcursor

    # Multimedia
    vlc mpv obs-studio

    # Networking
    tor tor-browser-bundle-bin wireguard-tools networkmanager networkmanagerapplet

    # Miscellaneous
    firefox-wayland flatpak keepassxc kdeconnect kwin okular pavucontrol proxychains-ng pulseaudio
    python3 python311Packages.pip python312Packages.pip ripgrep rofi-wayland sddm sddm-chili-theme
    sudo texliveFull tlp unzip usbutils vlc webcamoid wget whatsapp-for-linux wineWow64Packages.fonts
    xdg-desktop-portal-gtk xdg-desktop-portal-hyprland xdg-utils xfce.thunar xorg.xf86inputsynaptics
    xorg.xrandr xorg.xdpyinfo zoom-us

    # Icons and Themes
    kdePackages.breeze-icons papirus-icon-theme material-design-icons kdePackages.qtstyleplugin-kvantum
    libsForQt5.qt5ct libsForQt5.bismuth

    # VAAPI for Intel GPU hardware acceleration
    intel-media-driver  # Intel VAAPI driver for video decoding/encoding
    libva-utils         # Utility for VAAPI diagnostics
    mesa                # Required for OpenGL acceleration
    libva               # VAAPI library for video acceleration
    libdrm              # Direct Rendering Manager

    # Vulkan for 3D acceleration (optional, but recommended for gaming and multimedia)
    vulkan-loader
    vulkan-tools
    mesa.drivers        # Corrected package for Intel Vulkan drivers

    # Nonfree firmware
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

  system.stateVersion = "24.05";

  # Overlay for enabling Waybar experimental features
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];

  # Allow unfree packages if necessary
  nixpkgs.config.allowUnfree = true;
}
