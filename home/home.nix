{ config, pkgs, ... }:

{
  imports = [ ./config/foot.nix ./config/foot.nix ];
  home.username = "angelo";
  home.homeDirectory = "/home/angelo";

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
