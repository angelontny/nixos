{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/boot.nix
      ./modules/network.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  swapDevices = [{
    device = "/swapfile";
    size = 8 * 1024;
  }];

  time.timeZone = "Asia/Kolkata";

  users.users.angelo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      git
      neovim
      tmux
      nil
      firefox
      zathura
      mpv
      gcc
    ];
  };

  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        brightnessctl
        foot
        grim
        slurp
        swaylock
        bemenu
        wpaperd
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


    bash.shellInit = ''
      export XDG_CONFIG_HOME="$HOME/.config"
      export XDG_DATA_HOME="$HOME/.local/share"
      export XDG_DOWNLOAD_DIR="$HOME/dwl"
      export EDITOR=nvim

      # if [[ "$(tty)" == "/dev/tty1" ]]; then
      #   exec sway
      # fi
    '';
  };

  # Video Acceleration
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
      ];
    };
  };

  environment = {
    systemPackages = with pkgs; [
      neovim
      git
      wget
      openssh
    ];
    sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };
  };

  fonts = {
    packages = [ pkgs.nerd-fonts.jetbrains-mono ];
    fontconfig = {
      hinting.enable = false;
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.ssh.startAgent = true;
  programs.gnupg.agent = {
    enable = true;
  };

  system.stateVersion = "24.11";
}

