{ config, pkgs, ... }:

let
  dotfiles = ./.;
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

  home.packages = [
    # pkgs.emacs
  ];

  # Linking Doom Emacs configuration files using relative paths
  home.file = {
    ".config/doom/config.el".source = "${dotfiles}/.config/doom/config.el";
    ".config/doom/init.el".source = "${dotfiles}/.config/doom/init.el";
    ".config/doom/packages.el".source = "${dotfiles}/.config/doom/packages.el";
    ".config/doom/custom.el".source = "${dotfiles}/.config/doom/custom.el";
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
    };
    initExtra = ''
      export PATH="$HOME/.config/emacs/bin:$PATH"
      neofetch
    '';
  };


  programs.home-manager.enable = true;
}
