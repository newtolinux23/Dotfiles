{ config, pkgs, lib, ... }:

{
  options = {
    services.wireguard = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable WireGuard service.";
      };
      interfaces = lib.mkOption {
        type = lib.types.attrsOf (lib.types.attrs);
        default = {};
        description = "Configuration for WireGuard interfaces.";
      };
    };
  };

  config = lib.mkIf config.services.wireguard.enable {
    networking.wg-quick.interfaces = config.services.wireguard.interfaces;
  };
}
