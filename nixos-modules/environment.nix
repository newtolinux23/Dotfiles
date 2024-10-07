{ config, pkgs, lib, ... }:

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
  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_QPA_PLATFORM = "wayland"; # Switched to Wayland for better performance
    XDG_SESSION_TYPE = "wayland";
    XDG_ICON_THEME = "breeze";
    MOZ_ENABLE_WAYLAND = "1"; # For Firefox under Wayland
  };

  # Essential system packages
  environment.systemPackages = with pkgs; [
    brightnessctl
    bubblewrap
    cmake
    clipit
    dejavu_fonts
    discount
    elegant-sddm
    eww
    emacs
    fanctl
    fd
    firefox-wayland
    fira-code
    flatpak
    git
    gnumake
    gtk3
    gtk4
    htop
    hyprland
    hyprpaper
    hyprcursor
    hyprpicker
    kdePackages.breeze-icons
    kdePackages.qgpgme
    keepassxc
    konsole
    kdeconnect
    kwin
    okular
    libsForQt5.kmail
    libsForQt5.bismuth
    libsForQt5.kamoso
    libinput
    linuxKernel.packages.linux_zen.facetimehd
    lm_sensors
    meson
    meslo-lgs-nf
    nerdfonts
    jetbrains-mono
    networkmanagerapplet
    networkmanager
    obs-studio
    ollama
    open-sans
    pavucontrol
    proxychains-ng
    pulseaudio
    python3Packages.openai
    python3Packages.click
    python3Packages.requests
    python3
    python311Packages.pip
    python312Packages.pip
    qt5.qtwayland
    qt6.qmake
    qt6.qtwayland
    ripgrep
    rofi-wayland
    sddm
    sddm-chili-theme
    shellcheck
    source-code-pro
    starship
    steam-run
    sudo
    swaybg
    texliveFull
    tlp
    tmux
    tor
    tor-browser-bundle-bin
    unzip
    usbutils
    vlc
    waybar
    wayland-protocols
    wayland-utils
    wl-clipboard
    webcamoid
    wget
    whatsapp-for-linux
    wineWow64Packages.fonts
    wireguard-tools
    wlroots
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-utils
    xfce.thunar
    xorg.xf86inputsynaptics
    xorg.xrandr
    xorg.xdpyinfo
    xwayland
    zoom-us
    # Networking and Proxy Tools
    papirus-icon-theme
    material-design-icons
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qt5ct
  ];

  # Fonts configuration with correct fetchURL
  fonts = {
    packages = with pkgs; [
      font-awesome
      udev-gothic-nf
      fira-code
      source-code-pro
      (pkgs.fetchurl {
        url = "https://downloads.sourceforge.net/project/corefonts/the%20fonts/final/times32.exe";
        sha256 = "1aq7z3l46vwgqljvq9zfgkii6aivy00z1529qbjkspggqrg5jmnv"; # Corrected SHA256
     })
   ];
    
  };

  # Swap and kernel tweaks
  swapDevices = [ { device = "/swapfile"; size = 4096; } ];
  boot.kernel.sysctl."vm.swappiness" = 5;
  
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

  # Allow unfree and insecure packages if necessary
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowInsecure = true;
}
