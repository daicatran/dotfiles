#!/usr/bin/bash
# My *nix config files

USER="sakat"
UHOME="/home/$USER"
dotfiles=$/root/.dotfiles
DE="KDE"
alias sln="sudo ln " # make hard link for file as root user
alias lnd="ln -s " # make hard link for directory
alias slnd="sudo ln -s " # ... as root user

test -e /etc/debian_version && DIST="Debian" && grep Ubuntu /etc/lsb-release &> /dev/null && DIST="Ubuntu"
if [ "$DIST" = "Ubuntu" ]  || [ "$DIST" = "Debian" ]; then
                # Truly non interactive some command
                alias update="sudo apt-get update"
                alias upgrade="sudo apt-get upgrade"
                alias install="sudo apt-get install"
                alias uninstall="sudo apt-get remove"
else
				DIST="ARCH"
                # For Arch Linux
                alias update="sudo pacman -Suy --noconfirm"
                alias install="sudo pacman -S --noconfirm"
                alias app-list="pacman -Qe"

				# Disable kwallet
				ln $dotfiles/config/kwalletrc $UHOME/.config/kwalletrc	
fi

$update # update

if [ "$DIST"="ARCH" ];then
	### PACKER
	echo -e "---> Install Packer for Arch Linux!"
	$install wget git expac jshon
	mkdir packer 
	cd packer 
	wget https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=packer
	mv PKGBUILD?h=packer PKGBUILD
	makepkg
	sudo pacman -U packer-20150808-1-any.pkg.tar.xz
	cd ..
	sudo rm -dR packer 
fi

### ZSH
$install zsh # A very advanced and programmable command interpreter (shell) for UNIX
lnd $dotfiles/zsh $UHOME/.zsh
slnd $dotfiles/zsh /root/.zsh
ln $dotfiles/zsh/zshrc $UHOME/.zshrc
sln $dotfiles/zsh/zshrc /root/.zshrc
chsh -s /usr/bin/zsh # make zsh like default shell # "exec zsh" on .bashrc will make some problem during login
sudo chsh -s /usr/bin/zsh 

### VIM
$install vim # vi improvced, a hight configurable, improved version of the vi text editor
lnd $dotfiles/vim $UHOME/.vim 
slnd $dotfiles/vim /root/.vim

### POWERLINE
$install powerline # Statusline plugin for vim, and provides statuslines and prompts for several other applications, including zsh,bash, tmux, IPython, Awesome, i3 and Qtile
git clone https://github.com/powerline/fonts.git # Inconsolata font
./fonts/install.sh
rm -rf fonts

### WIRESHARK
$install wireshark-gtk 
# Make Wireshark able to access interface without privile mode
# Ref : https://wiki.wireshark.org/CaptureSetup/CapturePrivileges
sudo chown sakat /usr/bin/dumpcap
sudo chmod u+s /usr/bin/dumpcap
sudo setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' /usr/sbin/dumpcap
sudo gpasswd -a $(id -un) wireshark # Add yourself to the wireshark group
lnd $dotfiles/config/wireshark $UHOME/.config/wireshark
slnd $dotfiles/config/wireshark /root/.config/wireshark

### Other App
test -e /etc/debian_version && DIST="Debian" && grep Ubuntu /etc/lsb-release &> /dev/null && DIST="Ubuntu"
if [ "$DIST" = "Ubuntu" ]  || [ "$DIST" = "Debian" ]; then
    echo "Install for Ubuntu !" 
	$instal openssh-server # 
	sudo systemctl restart sshd.service
else
	echo "Install for archlinux ! "
   	$install openssh # Free version of the SSH connectivity tools
	sudo systemctl disable sshd.service # disable ssh server after intstall ssh
	sudo systemctl stop sshd.service # stop ssh server after instal ssh
	### ssh without password 
	# Client generate key
	# ssh-keygen -r -rsa # don't use any passphare
	# and then upload file id_rsa.pub to server on /home/sakat/.ssh
	### Server configuration
	# Create .ssh directory 
	# mkdir ~/.ssh
	# Finally append a's new public key (id_rsa.pub) to b@B:.ssh/authorized_keys and enter b's password one last time
	$install nm-connection-editor # NetworkManager GUI connection editor and widgets
	$install networkmanager-vpnc # NetworkManager VPN plugin for VPNC
	$install networkmanager-pptp # NetworkManager VPN plugin for PPTP
	$install networkmanager-openvpn # NetworkManager VPN plugin for OpenVPN
	$install networkmanager-openconnect # NetworkManager VPN plugin for OpenConnect
	$install networkmanager-dispatcher-ntpd # Dispatcher Script for ntpd
	$install bind-tools # nslookup command - The ISC DNS tools
	$install libreoffice-fresh # LibreOffice branch which contains new features and program enhancements
	# $install virtualbox-guest-utils # VirtualBox Guest userspace utilities
	$install virtualbox-ext-oracle # Oracle VM VirtualBox Extension Pack 
	$install virtualbox-guest-iso # The official VirtualBox Guest Additions ISO image
	$install usb_modeswitch usbutils modemmanager mobile-broadband-provider-info # For Dcom 3G support
	$install ack # A Perl-based grep replacement, aimed at programmers with large trees of heterogeneous source code
	$install python2-pip python-pip # The PyPA recommended tool for installing Python packages
	$install mactelnet # A linux console tool for connecting to MikroTik RouterOS devices via their ethernet address
	$install net-snmp # A suite of applications used to implement SNMPv1, SNMPv2c and SNMPv3 using both IPv4 and IPv6
	$install teamviewer # All-In-One Software for Remote Support and Online Meetings
	$install spectacle # KDE screenshot capture utility
	$install dropbox # A free service that lets you bring your photos, docs, and videos anywhere and share them easily.
fi

echo "Install for both Debian and Archlinux !"
$install firefox # Standalone web browser from mozilla.org
$install fping # A utility to ping multiple hosts at once
$install vlc # A multi-platform MPEG, VCD/DVD, and DivX player
$install iperf iperf3 # A tool to measure maximum TCP bandwidth
$install nmap # Utility for network discovery and security auditing
$install konsole # konsole terminal
$install xfce4-terminal # xfce4-terminal alternative with zyxel or raisecom device config 
$install tree # A directory listing program displaying a depth indented list of files
$install whois # Ipblock lookup -  The whois client by Marco d'Itri
$install net-tools # ifconfig command -  Configuration tools for Linux networking
$install thunderbird # Mail clinet
$install okular # Document Viewer
$install picocom # Minimal dump-terminal emulation program, very much like minicom

### Config touchpad 
synclient TapButton1=1 # Enable Tap To Click
synclient HorizTwoFingerScroll=1 # Enable Horizon Finger Scroll

ln $dotfiles/config/touchpadrc $UHOME/.config/touchpadrc
sln $dotfiles/config/touchpadrc /root/.config/touchpadrc

### config visudo 
# sudo visudo or vim /etc/sudoer and add the folloing line
# sakat ALL=(ALL) NOPASSWORD: ALL # Allow username=sakat excute any command without password

### ibus setup 
if [ "$DE"="KDE"]; then
	$install ibus # Next Generation Input Bus for Linux
	$install ibus-qt # IBus qt library and IBus qt input method plugin
	# to start : ibus-daemon --xim -xd
fi
$install ibus-bogo # Vietnamese input method for IBus with Bogo engine
# may be need to add ppa on ubuntu or debian btu already with packer archlinux
$install ibus-unikey # IBus module for Vietnamese Keyboard
