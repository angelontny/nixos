{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot = {
    plymouth = {
      enable = true;
      themePackages = with pkgs; [ (adi1090x-plymouth-themes.override { selected_themes = [ "infinite_seal" ]; }) ];
      theme = "infinite_seal";
    };
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

  networking = {
    hostName = "katana";
    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          EnableNetworkConfiguration = true;
        };
      };
    };
    dhcpcd.enable = false;
  };

  swapDevices = [{
    device = "/swapfile";
    size = 8 * 1024;
  }];


  time.timeZone = "Asia/Kolkata";

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
    };
  };

  services.libinput.enable = true;
  services.pipewire.alsa.enable = true;
  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [ hplip gutenprint splix];
    };
  };

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

    bash.shellInit = ''
      export XDG_CONFIG_HOME="$HOME/.config"
      export XDG_DATA_HOME="$HOME/.local/share"
      export XDG_DOWNLOAD_DIR="$HOME/dwl"

      if [[ "$(tty)" == "/dev/tty1" ]]; then
        exec sway
      fi
    '';
  };

  # Video Acceleration
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
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

  # List services that you want to enable:
  services.resolved.enable = true;
  services.dbus.implementation = "broker";

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  system.stateVersion = "24.11";
}

