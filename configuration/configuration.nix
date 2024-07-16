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

  networking.hostName = "katana";
  networking.wireless.iwd.enable = true;

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
  };

  users.users.angelo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      git
      firefox
      gcc
      gnumake
      ripgrep
      go
      mpv
      telegram-desktop
      zathura
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
       mako
       libnotify
       wl-clipboard
       slurp
       grim
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
