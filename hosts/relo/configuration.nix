{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/network.nix
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

  users.users.angelo = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
    packages = with pkgs; [
      pass
      neovim
      tmux
      nil
      gcc
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKLzb+D/e+4uH9STMN2L0m0lbtlrqp8+DvRmiPeWM8tO angelo"
    ];
  };
  system.stateVersion = "25.05";
}
