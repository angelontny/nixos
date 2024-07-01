# NixOS Installation

## Partitioning and Formatting

### Swap Considerations
- I plan to use hibernation as I often put the laptop in sleep overnight.
- Most sources recommend that I create a swap partition equal in size to the amount of RAM I have installed on the system.
- Since there is a slight performance difference in using a swapfile ( even if it's negligable ), I'm creating a swap partition.
- A swap partition also seems to be more straight forward and convenient.
- As I won't be running out of space anytime soon, I think it's fine if I create a 16Gb swap partition.
