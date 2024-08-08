{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; 
  # networking.wireless.enable = true;  

  # Experimental Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.desktopManager.plasma5.enable = true;
  programs.dconf.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    theme = "breeze";
    settings = {
      Theme = {
        Current = "breeze";
        ThemeDir = "/run/current-system/sw/share/sddm/themes";
        FacesDir = "/run/current-system/sw/share/sddm/faces";
      };
      X11 = {
        ServerArguments = "-nolisten tcp -dpi 125";
      };
    };
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

  };

   boot.kernelParams = [
    "intel_iommu=on"
    "iommu=pt"
    "zswap.enabled=1"
    "zswap.compressor=lz4"
    "zswap.max_pool_percent=20"
    "usbcore.autosuspend=-1"
  ];

  # Systemd Services Configuration
  services.timesyncd.enable = true;

  # CPU Frequency Scaling
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  # TLP Configuration
  services.tlp.enable = true;
  powerManagement.powertop.enable = true;
  services.power-profiles-daemon.enable = false;

  # Hardware Acceleration
  hardware.opengl.enable = true;

  # Define a user account.  
  users.users.rob = {
    isNormalUser = true;
    home = "/home/rob";
    description = "rob";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      #kate
    thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Flatpak Configuration
  services.flatpak.enable = true;
  xdg.portal.config.common.default = "gtk";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pkgs.libsForQt5.bismuth
    pkgs.freetube
    pkgs.flatpak
    pkgs.ispell 
    pkgs.discount
    pkgs.google-chrome
    pkgs.tlp
    pkgs.neofetch
    pkgs.texliveFull
    pkgs.whatsapp-for-linux
    pkgs.wget
    pkgs.starship
    pkgs.cmake
    pkgs.shellcheck
    pkgs.ripgrep
    pkgs.nerdfonts
    pkgs.wireguard-tools
    pkgs.source-code-pro
    pkgs.fd
    pkgs.wineWow64Packages.fonts
    pkgs.git
    pkgs.sudo
    pkgs.hugo
    pkgs.emacs
  ];

  fonts.packages = with pkgs; [
  fira-code
  source-code-pro
  (pkgs.fetchurl {
    url = "https://downloads.sourceforge.net/project/corefonts/the%20fonts/final/arial32.exe";
    sha256 = "85297a4d146e9c87ac6f74822734bdee5f4b2a722d7eaa584b7f2cbf76f478f6"; # Replace with the actual hash
   })
  ];

  # Enable systemd-resolved for DNS resolution
  services.resolved = {
    enable = true;
  };

  networking = {
    wg-quick.interfaces = {
      wg0 = {
        address = [ "10.72.1.2/24" ];
        dns = [ "10.72.1.1" ];
        privateKeyFile = "/home/rob/wireguard-keys/private";
        
        peers = [
          {
            publicKey = "HYrJHiCFn5+dzDzr1RSHWHsbc0Cv8RhRaABNDl5Xd0A=";
            allowedIPs = [ "0.0.0.0/0" ]; # "::/0" ];
            endpoint = "104.236.1.118:51820";
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };

  # Firewall Configuration
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 8443 51820 ];
    allowedUDPPorts = [ 123 ];
    interfaces = {
      "eth0" = { allowedTCPPorts = [ 8080 51820 ]; };
    };
  };

  # Disable NetworkManager-wait-online.service
  systemd.services."NetworkManager-wait-online".enable = false;

  system.stateVersion = "24.05"; 

}
