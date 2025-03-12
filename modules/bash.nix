{...}:
{
    bash.shellInit = ''
      export XDG_CONFIG_HOME="$HOME/.config"
      export XDG_DATA_HOME="$HOME/.local/share"
      export XDG_DOWNLOAD_DIR="$HOME/dwl"
      export EDITOR=nvim

      if [[ "$(tty)" == "/dev/tty1" ]]; then
        exec sway
      fi
    '';
}
