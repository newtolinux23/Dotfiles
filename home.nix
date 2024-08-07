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
      ga = "git add .";
      gc = "git commit -m 'Cleaning up things'";
      gs = "git stash";
      gp = "git push -u origin main";
    };
    initExtra = ''
      export PATH="$HOME/.config/emacs/bin:$PATH"
      neofetch
      eval "$(starship init bash)"
    '';
  };

  programs.home-manager.enable = true;

}
