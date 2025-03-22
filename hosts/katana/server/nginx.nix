{
  networking.firewall.allowedTCPPorts = [ 80 ];

  services.nginx = {
    enable = true;
    virtualHosts = {
      "angeloantony.com" = {
        root = "/var/www/angeloantony";
      };
      "test.angeloantony.com" = {
        root = "/var/www/angeloantonyt";
      };
    };
  };
}
