{config, pkgs, ...}:

{
  networking = {
    hostName = "katana";
    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          EnableNetworkConfiguration = true;
        };
        Network = {
          EnableIPv6 = true;
        };
      };
    };
    dhcpcd.enable = false;
    firewall.enable = true;
  };

  # networking.wg-quick.interfaces =
  #   {
  #     wg0 = {
  #       address = [
  #         "10.0.0.3/24"
  #       ];
  #       peers = [
  #         {
  #           allowedIPs = [
  #             "10.0.0.1/24"
  #           ];
  #           endpoint = "vpn.angeloantony.com:51820";
  #           publicKey = "RHAuwe7MUQyrEw9sCckSqxseFrG1NDxyQBiyKhzRnzQ=";
  #           persistentKeepalive = 25;
  #         }
  #       ];
  #       privateKey = "aL16ajJdgbNIsPz32lg6QkVassNxLDHpcwCa65ktGFg=";
  #     };
  #   };
  # networking.firewall.interfaces.wg0.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];

}
