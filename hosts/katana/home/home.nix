{ config, pkgs, ... }:

{
  imports = [
    ./config/git.nix
    ./config/foot.nix
    ./config/swaylock.nix
    ./config/wpaperd.nix
    ./config/zathura.nix
    ./config/mpv.nix
  ];
  home.username = "angelo";
  home.homeDirectory = "/home/angelo";

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
