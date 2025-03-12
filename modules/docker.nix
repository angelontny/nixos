{ ... }: {

  virtualisation.docker.enable = true;
  users.users.angelo.extraGroups = [ "docker" ];
}
