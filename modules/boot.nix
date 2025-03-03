{config, pkgs, ...}:

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
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "splash" "quiet" ];
    initrd.systemd.enable = true;
  };
}
