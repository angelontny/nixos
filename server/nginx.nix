{
  services.nginx = {
    enable = true;
    virtualHosts."localhost" = {
    # addSSL = true;
    # enableACME = true;
    root = "/var/www/angeloantony";
    };
  };

# security.acme = {
#   acceptTerms = true;
#   defaults.email = "foo@bar.com";
# };
}
