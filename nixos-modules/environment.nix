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

  # Environment variables, optimized for Wayland and Qt
  environment.variables = waylandVars // {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    XDG_SESSION_TYPE = "wayland";
    XDG_ICON_THEME = "breeze";
  };

  # Essential system packages, grouped by category
  environment.systemPackages = with pkgs; [
    # Development Tools
    cmake gnumake meson git emacs tmux konsole
    
    # Fonts
    dejavu_fonts fira-code nerdfonts meslo-lgs-nf jetbrains-mono open-sans source-code-pro
    
    # System Utilities
    brightnessctl bubblewrap bleachbit fd htop lm_sensors shellcheck starship
    
    # Wayland Tools
    swaybg waybar wayland-protocols wayland-utils wl-clipboard xwayland hyprland hyprpaper hyprcursor
    
    # Multimedia
    obs-studio vlc okular webcamoid
    
    # Networking
    tor tor-browser-bundle-bin wireguard-tools networkmanager networkmanagerapplet
    
    # Miscellaneous
    firefox-wayland flatpak keepassxc kdeconnect kwin okular pavucontrol proxychains-ng pulseaudio 
    python3 python311Packages.pip python312Packages.pip ripgrep rofi-wayland sddm sddm-chili-theme 
    steam-run sudo texliveFull tlp unzip usbutils vlc webcamoid wget whatsapp-for-linux wineWow64Packages.fonts
    xdg-desktop-portal-gtk xdg-desktop-portal-hyprland xdg-utils xfce.thunar xorg.xf86inputsynaptics 
    xorg.xrandr xorg.xdpyinfo zoom-us
    
    # Icons and Themes
    kdePackages.breeze-icons papirus-icon-theme material-design-icons kdePackages.qtstyleplugin-kvantum
    libsForQt5.qt5ct libsForQt5.bismuth
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
