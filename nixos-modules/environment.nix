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
    kdePackages.dolphin-plugins
    bubblewrap
    cmake
    dejavu_fonts
    discount
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
    okular
    libsForQt5.dolphin
    libsForQt5.bismuth
    libsForQt5.kamoso
    libinput
    libxkbcommon
    linuxKernel.packages.linux_zen.facetimehd
    lm_sensors
    meson
    meslo-lgs-nf
    nerdfonts
    networkmanagerapplet
    networkmanager
    obs-studio
    pavucontrol
    proxychains-ng
    pulseaudio
    python3Packages.openai
    python3Packages.click
    python3Packages.requests
    python3
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
    tor-browser
    unzip
    usbutils
    vlc
    waybar
    wayland
    wayland-protocols
    wayland-utils
    wl-clipboard
    webcamoid
    wget
    wineWowPackages.full
    wireguard-tools
    wlroots
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-utils
    xorg.xf86inputsynaptics
    xorg.xrandr
    xorg.xdpyinfo
    xwayland
    zoom-us
    # Networking and Proxy Tools
    papirus-icon-theme
    material-design-icons
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qt5ct

    # VAAPI for Intel GPU hardware acceleration
    intel-media-driver
    libva-utils
    mesa
    libva
    libdrm

    # Vulkan for 3D acceleration (optional, but recommended for gaming and multimedia)
    vulkan-loader
    vulkan-tools

    # Nonfree firmware
    firmwareLinuxNonfree
  ];

  # Swap and kernel tweaks
  swapDevices = [ { device = "/swapfile"; size = 4096; } ];
  boot.kernel.sysctl."vm.swappiness" = 10;
  
  # Enable Flatpak and experimental Nix features
  services.flatpak.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11";

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
