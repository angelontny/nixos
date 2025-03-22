{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/network.nix
    ./modules/fonts.nix
    ./modules/hw_cfg.nix
    ./modules/programs.nix
    ./modules/bash.nix
    ./modules/services.nix
    ./modules/boot.nix
    # ./modules/docker.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  swapDevices = [
    {
      device = "/swapfile";
      size = 8 * 1024;
    }
  ];

  users.users.angelo = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
    ];
    packages = with pkgs; [
      pass
      element-desktop
      neovim
      tmux
      nil
      firefox
      acpi
      gcc
    ];
  };

  specialisation = {
    server.configuration = {
      system.nixos.tags = [ "server" ];
      imports = [
        # ./server/nginx.nix
        ./server/wireguard.nix
        # ./server/services.nix
        ./server/synapse.nix
      ];
    };
  };

  system.stateVersion = "25.05";
}
