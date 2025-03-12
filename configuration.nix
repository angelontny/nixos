{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/network.nix
    ./modules/fonts.nix
    ./modules/hw_cfg.nix
    ./modules/programs.nix
    ./modules/bash.nix
    ./modules/services.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  swapDevices = [{
    device = "/swapfile";
    size = 8 * 1024;
  }];

  users.users.angelo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    packages = with pkgs; [ git neovim tmux nil firefox zathura mpv gcc ];
  };

  system.stateVersion = "25.05";
}

