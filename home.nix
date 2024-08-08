{ config, pkgs, ... }:

let
  dotfiles = ./.;
  kmod = pkgs.kmod;  # This package provides the lsmod and modprobe commands
in
{
  home.username = "rob";
  home.homeDirectory = "/home/rob";
  home.stateVersion = "24.05";

  programs.git = {
     enable = true;
     userName = "rob";
     userEmail = "corestepper@gmail.com";
     extraConfig = {
        init.defaultBranch = "main";
    };
  };

  home.packages = with pkgs; [
    pkgs.nano
    pkgs.dejavu_fonts
    pkgs.liberation_ttf
    pkgs.fira-code
    pkgs.obs-studio
    # Add any other packages you might need
  ];

  # Linking Doom Emacs configuration files using relative paths
  home.file = {
    ".config/doom/config.el".source = "${dotfiles}/.config/doom/config.el";
    ".config/doom/init.el".source = "${dotfiles}/.config/doom/init.el";
    ".config/doom/packages.el".source = "${dotfiles}/.config/doom/packages.el";
    ".config/doom/custom.el".source = "${dotfiles}/.config/doom/custom.el";

    # Nano syntax highlighting configuration
    ".nanorc".text = ''
      include "/nix/store/$(basename $(ls -d /nix/store/*-nano*/share/nano))/share/nano/markdown.nanorc"
      include "/nix/store/$(basename $(ls -d /nix/store/*-nano*/share/nano))/share/nano/tex.nanorc"
      include "/nix/store/$(basename $(ls -d /nix/store/*-nano*/share/nano))/share/nano/html.nanorc"
    '';

    # Systemd service for v4l2loopback
    ".config/systemd/user/obs-virtualcam.service".text = ''
      [Unit]
      Description=Load v4l2loopback for OBS Virtual Camera

      [Service]
      Type=oneshot
      ExecStart=${kmod}/bin/modprobe v4l2loopback devices=1 card_label="OBS Virtual Camera" exclusive_caps=1
      RemainAfterExit=true

      [Install]
      WantedBy=default.target
    '';

  };

  home.sessionVariables = {
    EDITOR = "emacs";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      dt = "cd ~/.dotfiles";
      hm = "home-manager switch --flake .";
      ns = "sudo nixos-rebuild switch --flake .";
      cn = "sudo nano configuration.nix";
    };
    initExtra = ''
      export PATH="$HOME/.config/emacs/bin:$PATH"
      neofetch
      eval "$(starship init bash)"
    '';
  };

  programs.home-manager.enable = true;

}
