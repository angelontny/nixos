{ ... }:

{
  time.timeZone = "Asia/Kolkata";
  networking = {
    hostName = "katana";
    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          EnableNetworkConfiguration = true;
        };
        Network = {
          NameResolvingService = "resolvconf";
        };
      };
    };
    dhcpcd.enable = false;
    firewall.enable = true;
    resolvconf.enable = true;
  };
}
