{ config, pkgs, ... }:

{
  boot = {
    consoleLogLevel = 3;
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        configurationLimit = 5;
        #windows
      };
      efi.canTouchEfiVariables = true;
    };
    initrd.systemd.enable = true;
  };
}
