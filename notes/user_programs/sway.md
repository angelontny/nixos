# Sway
Wayland based tiling window manager
The programs.sway.extraPackages command includes dmenu and wmenu by default ( i have decided to use fuzzel as the launcher )
Opengl is enabled by the sway module, hence no need to manually enable it

## Auto start
used the option bash.shellInit to write a shell script that starts sway if on /dev/tty1

## Brightness
Using the program brightnessctl. ( works even without a wayland or X11 session ). Has been added to the system packages

## Configuration
- [ ] Copy the old configuration from backup and track it using git

## Clipboard
Installed wl-clipboard
