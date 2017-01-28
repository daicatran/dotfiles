#!/usr/bin/bash
# My *nix config files
pacu="sudo pacman -Suy --noconfirm" # short command for pacman update
paci="sudo pacman -S --noconfirm"   # short command for pacman install package with auto "yes"

$pacu # update  

echo -e "---> Install Packer for Arch Linux!"
$ paci wget git expac jshon
mkdir packer 
cd packer 
wget https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=packer
mv PKGBUILD?h=packer PKGBUILD
makepkg
sudo pacman -U packer-20150808-1-any.pkg.tar.xz
cd ..
sudo rm -dR packer 

# 
$paci zsh # A very advanced and programmable command interpreter (shell) for UNIX
# cd ~/
# git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
# cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
cd zsh
cp -rf oh-my-zsh ~/.oh-my-zsh
cp -rf zshrc ~/.zshrc
chsh -l # list all shell 
sh -s /usr/bin/zsh # make zsh like default shell # not recommend : "exec zsh" on .bashrc
sudo ln /home/sakat/.zshrc /root/.zshrc # make hard link for root access 
sudo cp -r /home/sakat/.oh-my-zsh /root # make hard link for root access 
cd ~/
#

# Install Inconsolata font
git clone https://github.com/powerline/fonts.git
./fonts/install.sh
rm -rf fonts

$paci vim # Vi Improved, a highly configurable, improved version of the vi text editor
# mkdir .vim ; touch .vim/vimrc
cp -rf vim ~/.vim
sudo ln /home/sakat/.vim/vimrc /root/.vim/vimrc # make hard link for root access 
# git clone https://github.com/altercation/vim-colors-solarized.git # precision colorscheme for the vim text editor 

# 
$paci wireshark-gtk 
# Make Wireshark able to access interface without privile mode
# Link : https://wiki.wireshark.org/CaptureSetup/CapturePrivileges
sudo chown sakat /usr/bin/dumpcap
sudo chmod u+s /usr/bin/dumpcap
sudo setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' /usr/sbin/dumpcap
# add yourself to the 'wireshark' group
sudo gpasswd -a $(id -un) wireshark
#

$paci xfce4-terminal # xfce4-terminal alternative with zyxel or raisecom device config 

$paci konsole # konsole terminal

$paci whois # Ipblock lookup -  The whois client by Marco d'Itri

$paci bind-tools # nslookup command - The ISC DNS tools

$paci  net-tools # ifconfig command -  Configuration tools for Linux networking

$paci okular # Document Viewer

$paci picocom # Minimal dump-terminal emulation program, very much like minicom

$paci nmap # Utility for network discovery and security auditing

# Config touchpad by command 
# http://unix.stackexchange.com/questions/12328/touchpads-click-isnt-working-on-arch-installation-with-gnome
# synclient TapButton1=1 # Enable Tap To Click
# synclient HorizTwoFingerScroll=1 # Enable Horizon Finger Scroll

$paci thunderbird # Mail clinet

$paci vlc

$paci libreoffice-fresh

$paci virtualbox virtualbox-guest-utils

$paci usb_modeswitch usbutils modemmanager # For Dcom 3G support

$paci firefox # Standalone web browser from mozilla.org

$paci iperf iperf3 # A tool to measure maximum TCP bandwidth

$paci tree # A directory listing program displaying a depth indented list of files

$paci ack # A Perl-based grep replacement, aimed at programmers with large trees of heterogeneous source code

$paci python2-pip python-pip # The PyPA recommended tool for installing Python packages

# some ssh example in case require algorithm 
# ssh -oHostKeyAlgorithms=+ssh-dss user@legacyhost
# ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 admin@IP
# ssh -C -D 8080 admin@ IP  # dynamic port forwarding

# "user_list host_list=effective_user_list tag_list command_list"
# user_list :  list of users or a user alias that has already been set.
# host_list – list of hosts or a host alias on which users can run sudo. 
# effective_user_list – list of users they must be running as or a run as alias.
# tag_list – list of tags such as NOPASSWD.
# command_list – list of commands or a command alias to be run by user(s) using sudo.
# add the following command on /etc/sudoers for run any command without password or an other config 
# sakat ALL=(ALL) NOPASSWORD: ALL # Allow username=sakat excute any command without password
