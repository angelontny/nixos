{
  programs.git = {
    enable = true;
    userName = "Angelo Antony";
    userEmail = "83206032+angelontny@users.noreply.github.com";
    extraConfig = {
      init.defaultbranch = "main";
      core.editor = "nvim";
      merge.tool = "nvimdiff3";
    };
  };
}
