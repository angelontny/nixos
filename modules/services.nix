{ ... }:

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
  };
}
