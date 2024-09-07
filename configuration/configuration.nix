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
    kernelParams = [ "i915.enable_psr=0" ];
  };

  hardware = {
    pulseaudio.enable = true;
    # bluetooth = {
    #   enable = true;
    #   powerOnBoot = true;
    # };
  };

  networking.hostName = "kry";
  networking.wireless.iwd.enable = true;

  time.timeZone = "Asia/Kolkata";

  #sound.enable = false;

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
    # blueman.enable = true;
  };
  xdg = {
    portal = {
      wlr = {
        enable = true;
          settings = {
           screencast = {
             output_name = "eDP-1";
             max_fps = 30;
           };
          };
        };
      config = {
        common.default = [ "wlr" ];
      };
    };
  };

  users.users.angelo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      git
      firefox
      mpv
      zathura
      python312
      gcc
    ];
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    wget
    unzip
    neovim
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
       bemenu
       wl-clipboard
       slurp
       grim
       alsa-utils
     ];
    };
    bash.shellInit = ''
      export XDG_CONFIG_HOME="$HOME/.config"
      export XDG_DATA_HOME="$HOME/.local/share"
      export XDG_DOWNLOAD_DIR="$HOME/dwl"

      if [[ "$(tty)" == "/dev/tty1" ]]; then
        exec sway
      fi
    '';
  };

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
    fontconfig = {
      hinting.enable = false;
      defaultFonts = {
        monospace = [
	  "JetBrainsMono Nerd Font"
        ];
      };
    };
  };

  system.stateVersion = "24.05";
}
