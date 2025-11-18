{ config, pkgs, lib, ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;

    # The wg-quick configuration has been commented out because it depends on a
    # hardcoded private key file (`/home/rob/private.key`). This is a security risk
    # and makes the configuration non-portable.
    # It is highly recommended to use a secret management tool like sops-nix or agenix
    # to handle sensitive files like private keys.
    #
    # wg-quick.interfaces = {
    #   wg0 = {
    #     address = [ "10.72.1.2/24" ];
    #     dns = [ "10.72.1.1" ];
    #     privateKeyFile = "/home/rob/private.key";
    #
    #     peers = [
    #       {
    #         publicKey = "HYrJHiCFn5+dzDzr1RSHWHsbc0Cv8RhRaABNDl5Xd0A=";
    #         allowedIPs = [ "0.0.0.0/0" ];
    #         endpoint = "104.236.1.118:51820";
    #         persistentKeepalive = 25;
    #       }
    #     ];
    #
    #     # Add routes for specific IPs to bypass the VPN (go directly to your local gateway)
    #     postUp = ''
    #       ip route add 104.18.145.100/32 via 76.184.68.199
    #       ip route add 104.18.144.100/32 via 76.184.68.199
    #       ip route add 184.50.205.91/32 via 76.184.68.199
    #     '';
    #     postDown = ''
    #       ip route del 104.18.145.100/32 via 76.184.68.199
    #       ip route del 104.18.144.100/32 via 76.184.68.199
    #       ip route del 184.50.205.91/32 via 76.184.68.199
    #     '';
    #   };
    # };

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 8443 51820 9050 53 ];  # Open TCP ports
      allowedUDPPorts = [ 123 ];  # Open UDP port 123
      interfaces = {
        "eth0" = { allowedTCPPorts = [ 8080 51820 9050 ]; };  # Open additional ports on eth0
      };
    };
  };

  # Enable systemd-resolved service
  services.resolved.enable = true;
}
