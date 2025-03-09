{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;
  services = {
    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 0;
        STOP_CHARGE_THRESH_BAT0 = 1;
      };
    };
    getty = {
      autologinOnce = true;
      autologinUser = "angelo";
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
    libinput.enable = true;
    dbus.implementation = "broker";
    blueman.enable = true;
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = false;
        AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };
  };
}
