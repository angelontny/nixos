# To Do after Installation

## Before GUI
- symlink the nixos configuration dir to the github repo in the home folder so that it can be easily tracked
- copy ssh keys from the old computer
- setup autologin for the user ( can't get to the login prompt without knowing the luks password )
- reduce loglevel to reduce output during boot
- Fix hibernation ( "systemctl hibernate" shuts down the computer )
- enable XDG directory spec and clean up the home directory ( i don't want all programs to have their own independent dotfile )
- Tried to configure git using nix, but it affects the "system configuration" not the "global configuration"

## GUI
