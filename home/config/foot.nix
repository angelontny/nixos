{ ... }: {
  programs.foot.enable = true;
  programs.foot.settings = {
    main = {
      term = "xterm-256color";
      underline-offset = 3;
      underline-thickness = 1;
      font = "monospace:size=14";
      resize-delay-ms = 0; # don't know what this is supposed to do.

      bold-text-in-bright = "palette-based";
    };
    cursor = {
      style = "underline";

      blink = "yes";
      underline-thickness = 2;
    };
    scrollback = {

      multiplier = 1.5;
      indicator-position = "relative";
      indicator-format = "percentage";
    };
    colors = {

      background = "000000";
    };
  };
}
