{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "katana";
  networking.wireless.iwd.enable = true;

  time.timeZone = "Asia/Kolkata";

  sound.enable = true;

  services = {
    libinput.enable = true;
    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0=0;
        STOP_CHARGE_THRESH_BAT0=1;
      };
    };
  };


  users.users.angelo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      git
      neovim
    ];
  };

  environment.systemPackages = with pkgs; [
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "24.05";
}
