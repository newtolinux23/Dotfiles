{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
   let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    sddm-chili = import ./sddm-chili.nix { inherit pkgs; };
   in {
    nixosConfigurations = {  
        nixos = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./configuration.nix 
          {
            nixpkgs.overlays = [
              (final: prev: {
                sddm-chili = sddm-chili;
              })
            ];
            environment.systemPackages = [ pkgs.sddm-chili ];
            services.displayManager.sddm.theme = "chili";
            services.displayManager.sddm.settings.ThemeDir = "/run/current-system/sw/share/sddm/themes";
          }
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
