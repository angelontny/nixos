{ pkgs, ... }:
{
  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        brightnessctl
        grim
        slurp
        bemenu
        mako
        libnotify
        alsa-utils
        wl-clipboard
      ];
    };
    uwsm = {
      enable = true;
      waylandCompositors.sway = {
        prettyName = "Sway";
        comment = "Sway compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/sway";
      };
    };
    mtr.enable = true;
    ssh.startAgent = true;
    gnupg.agent.enable = true;
  };
}
