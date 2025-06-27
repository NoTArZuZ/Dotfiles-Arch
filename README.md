# Arch Dusk Dotfiles
*with suckless software included!*

[image](./Assets/27-1751047263.png)

## Installation

1. Install required packages (including AUR): base base-devel linux linux-firmware grub efibootmgr git networkmanager dhcpcd sudo vim htop rtorrent ufw pulsemixer polkit-gnome pipewire pipewire-pulse wireplumber rtkit xorg xorg-xinit xdotool xclip libnotify dunst feh maim yazi picom nsxiv mpv cromite-bin qt5-styleplugins yay zoxide ttf-jetbrains-mono-nerd ttf-ubuntu-font-family ttf-apple-emoji ttf-noto-nerd flatpak libva helix eza conky vnstat stow fzf
2. Enable services: dhcpcd, NetworkManager, ufw, pipewire, pipewire-pulse, wireplumber, vnstat
3. Move {dusk,dmenu,st,slstatus}-sus to user's home and build them
4. cd ~/Dotfiles and stow .
5. Base installation done!

## Extra
*mostly reminders for myself*

* Move xorg.conf's into /etc/X11/xorg.conf.d/
* For Variable Refresh Rate properly paste code from drirc-mesa to /usr/share/drirc.d/00-mesa-defaults.conf
* Add Color and ILoveCandy to pacman (ParallelDownloads = 5 if not set)
* Install Microsoft fonts
* For dmenu scripts move hub-script and conky-toggle to /usr/local/bin and Scripts dir to user's home
* do sensors-detect (carefully) for conky temps
