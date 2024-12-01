{
  description = "NixOS configuration with Home Manager and Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11"; # Corrected the nixpkgs URL
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
   let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
   in {
    nixosConfigurations = {  
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./configuration.nix 
          home-manager.nixosModules.home-manager # Integrate Home Manager with NixOS
        ];
      };
    };  
    homeConfigurations = { 
      rob = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    }; 
  };
}
