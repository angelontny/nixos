{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  networking = {
    hostName = "katana";
    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          EnableNetworkConfiguration = true;
        };
        Network = {
          EnableIPv6 = true;
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
      alsa.enable = true;
    };
    libinput.enable = true;
  };

  # services = {
  #   printing = {
  #     enable = true;
  #     drivers = with pkgs; [ hplip gutenprint splix ];
  #   };
  # };

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
      export EDITOR=nvim

      if [[ "$(tty)" == "/dev/tty1" ]]; then
        exec sway
      fi
    '';
  };

  # networking.wg-quick.interfaces =
  #   {
  #     wg0 = {
  #       address = [
  #         "10.0.0.3/24"
  #       ];
  #       peers = [
  #         {
  #           allowedIPs = [
  #             "10.0.0.1/24"
  #           ];
  #           endpoint = "vpn.angeloantony.com:51820";
  #           publicKey = "RHAuwe7MUQyrEw9sCckSqxseFrG1NDxyQBiyKhzRnzQ=";
  #           persistentKeepalive = 25;
  #         }
  #       ];
  #       privateKey = "aL16ajJdgbNIsPz32lg6QkVassNxLDHpcwCa65ktGFg=";
  #     };
  #   };

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

  # List services that you want to enable:
  services.resolved.enable = true;
  services.dbus.implementation = "broker";
  services.blueman.enable = true;

  services.openssh = {
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

  networking.firewall.enable = true;
  # networking.firewall.interfaces.wg0.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  system.stateVersion = "24.11";
}

