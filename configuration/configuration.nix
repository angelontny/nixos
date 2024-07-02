{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    consoleLogLevel = 3;
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
    getty = {
      autologinUser = "angelo";
      greetingLine = "";
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

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    sway = {
     enable = true;
     extraPackages = with pkgs; [
       swaylock
       swayidle
       foot
     ];
    };
    bash.shellInit = ''
      if [[ "$(tty)" == "/dev/tty1" ]]; then
        exec sway
      fi
    '';
  };

  system.stateVersion = "24.05";
}
