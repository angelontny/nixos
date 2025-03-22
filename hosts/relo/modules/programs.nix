{ pkgs, ... }:
{
  programs = {
    mtr.enable = true;
    ssh.startAgent = true;
    gnupg.agent.enable = true;
  };
}
