# Sway
Wayland based tiling window manager
The programs.sway.extraPackages command includes dmenu and wmenu by default ( i haven't decided the program launcher yet )
Opengl is enabled by the sway module, hence no need to manually enable it

## Auto start
used the option bash.shellInit to write a shell script that starts sway if on /dev/tty1
