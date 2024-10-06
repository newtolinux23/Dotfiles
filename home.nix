{ config, pkgs, lib, ... }:

let
  dotfiles = ./.;
in {
  # Importing additional modules
  imports = [
    ./modules/hyprland.nix
    ./modules/waybar.nix
    ./modules/applications.nix  # Include any additional modules as needed
  ];

  # Basic Home Manager Configuration
  home.username = "rob";
  home.homeDirectory = "/home/rob";
  home.stateVersion = "24.05";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Git Configuration
  programs.git = {
    enable = true;
    userName = "rob";
    userEmail = "corestepper@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Doom Emacs Configuration
  programs.emacs = {
    enable = true;
  };

  # Linking Doom Emacs configuration files
  home.file = {
    ".config/doom/config.el".source = "${dotfiles}/.config/doom/config.el";
    ".config/doom/init.el".source = "${dotfiles}/.config/doom/init.el";
    ".config/doom/packages.el".source = "${dotfiles}/.config/doom/packages.el";
    ".config/doom/custom.el".source = "${dotfiles}/.config/doom/custom.el";
  };

  # Nano syntax highlighting configuration
  home.file."~/.nanorc".text = ''
    include "/nix/store/$(basename $(ls -d /nix/store/*-nano*/share/nano))/share/nano/markdown.nanorc"
    include "/nix/store/$(basename $(ls -d /nix/store/*-nano*/share/nano))/share/nano/tex.nanorc"
    include "/nix/store/$(basename $(ls -d /nix/store/*-nano*/share/nano))/share/nano/html.nanorc"
  '';

 # Alacritty Configuration with Dracula Theme and Nerd Fonts
  xdg.configFile."alacritty/alacritty.toml".text = ''
    [window]
    wayland = true
    opacity = 0.9
    decorations = "full"

    [font]
    normal = { family = "FiraCode Nerd Font", style = "Regular" }
    size = 13.0
    offset = { x = 0, y = 0 }

    [colors]
    [colors.primary]
    background = "0x282a36"
    foreground = "0xf8f8f2"

    [colors.normal]
    black   = "0x282a36"
    red     = "0xff5555"
    green   = "0x50fa7b"
    yellow  = "0xf1fa8c"
    blue    = "0xbd93f9"
    magenta = "0xff79c6"
    cyan    = "0x8be9fd"
    white   = "0xbfbfbf"

    [colors.bright]
    black   = "0x4d4d4d"
    red     = "0xff6e6e"
    green   = "0x69ff94"
    yellow  = "0xffffa5"
    blue    = "0xd6acff"
    magenta = "0xff92df"
    cyan    = "0xa4ffff"
    white   = "0xffffff"
  '';

  # Setting environment variables
  home.sessionVariables = {
    EDITOR = "emacs";
    TERMINAL = "alacritty";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";
  };

  # Waydroid with Bubblewrap Integration
  home.file."~/.local/bin/waydroid-bwrap.sh".text = ''
    #!/bin/bash
    bwrap \
      --unshare-all \
      --new-session \
      --bind / / \
      --dev-bind /dev /dev \
      --proc /proc \
      --ro-bind /sys /sys \
      --tmpfs /tmp \
      --tmpfs /run \
      --dir /run/user/$(id -u) \
      --bind $HOME/.local/share/waydroid $HOME/.local/share/waydroid \
      --ro-bind /usr /usr \
      --ro-bind /lib /lib \
      --ro-bind /lib64 /lib64 \
      --symlink /lib /lib64 \
      --symlink /lib /usr/lib \
      --ro-bind /run/user/$(id -u)/wayland-0 /run/user/$(id -u)/wayland-0 \
      /usr/bin/waydroid "$@"
  '';

  # Bash Configuration
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      dt = "cd ~/.dotfiles";
      hm = "home-manager switch --flake .";
      ns = "sudo nixos-rebuild switch --flake .";
      shm = "sudo nano home.nix";
      nm = "systemctl restart NetworkManager.service";
      cn = "sudo nano configuration.nix";
      ga = "git add .";
      gc = "git commit -m 'Cleaning up things'";
      gs = "git stash";
      gp = "git push -u origin main";
      waydroid = "~/.local/bin/waydroid-bwrap.sh";
    };
    initExtra = ''
      export PATH="$HOME/.config/emacs/bin:$PATH"
      ~/myfetch.sh  # Replace neofetch with your custom script
      eval "$(starship init bash)"
    '';
  };

  # Enable Home Manager
  programs.home-manager.enable = true;

  # Doom Emacs setup
  home.activation.doom = lib.mkAfter ''
    run_hook() {
      if [ -x "$(command -v doom)" ]; then
        echo "Syncing Doom Emacs configuration..."
        doom sync
      fi
    }
    run_hook
  '';
}
