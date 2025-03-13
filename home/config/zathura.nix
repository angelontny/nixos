{
  programs.zathura = {
    enable = true;
    extraConfig = ''
      set default-bg "#000000"
      set default-fg "#AAAAAA"
      set font "monospace normal 14"
      set inputbar-fg "#AAAAAA"
      set inputbar-bg "#000000"
      set index-bg "#000000"
      set index-fg "#AAAAAA"
      set index-active-bg "#DDDDDD"
      set index-active-fg "#000000"
      set recolor-reverse-video true
      set recolor true
      set guioptions ""
    '';
  };
}
