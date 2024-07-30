{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  boot = {
    consoleLogLevel = 3;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "i915.enable_psr=0" ];
  };

  networking.hostName = "katana";
  networking.wireless.iwd.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  ...
  time.timeZone = "Asia/Kolkata";

  #sound.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

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
    blueman.enable = true;
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
    extraGroups = [ "wheel" "wireshark" ];
    packages = with pkgs; [
      git
      firefox
      google-chrome
      mpv
      telegram-desktop
      zathura
      ltex-ls
      pipewire_0_2
      python312
    ];
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    wget
    unzip
    pass
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
     ];
    };
    wireshark.enable = true;
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
