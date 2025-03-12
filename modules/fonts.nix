{ pkgs, ... }: {
  fonts = {
    packages = [ pkgs.nerd-fonts.jetbrains-mono ];
    fontconfig = {
      hinting.enable = false;
      defaultFonts = { monospace = [ "JetBrainsMono Nerd Font" ]; };
    };
  };
}
