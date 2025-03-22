{ ... }:

{
  time.timeZone = "Asia/Kolkata";
  networking = {
    hostName = "katana";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 ];
    };
    resolvconf.enable = true;
  };
}
