#!/usr/bin/bash
# My *nix config files

USER="sakat"
UHOME="/home/$USER"
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
fi

$update # update
cd $UHOME

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
lnd zsh $UHOME/.zsh
slnd zsh /root/.zsh
ln zsh/zshrc $UHOME/.zshrc
sln zsh/zshrc /root/.zshrc
chsh -s /usr/bin/zsh # make zsh like default shell # "exec zsh" on .bashrc will make some problem during login
sudo chsh -s /usr/bin/zsh 
### VIM
$install vim # vi improvced, a hight configurable, improved version of the vi text editor
lnd vim $UHOME/.vim 
slnd vim /root/.vim
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
###

test -e /etc/debian_version && DIST="Debian" && grep Ubuntu /etc/lsb-release &> /dev/null && DIST="Ubuntu"
if [ "$DIST" = "Ubuntu" ]  || [ "$DIST" = "Debian" ]; then
   
else
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
	$install xfce4-terminal # xfce4-terminal alternative with zyxel or raisecom device config 
	$install konsole # konsole terminal
	$install whois # Ipblock lookup -  The whois client by Marco d'Itri
	$install bind-tools # nslookup command - The ISC DNS tools
	$install net-tools # ifconfig command -  Configuration tools for Linux networking
	$install okular # Document Viewer
	$install picocom # Minimal dump-terminal emulation program, very much like minicom
	$install nmap # Utility for network discovery and security auditing
	$install thunderbird # Mail clinet
	$install vlc # A multi-platform MPEG, VCD/DVD, and DivX player
	$install libreoffice-fresh # LibreOffice branch which contains new features and program enhancements
	# $install virtualbox-guest-utils # VirtualBox Guest userspace utilities
	$install virtualbox-ext-oracle # Oracle VM VirtualBox Extension Pack 
	$install virtualbox-guest-iso # The official VirtualBox Guest Additions ISO image
	$install usb_modeswitch usbutils modemmanager mobile-broadband-provider-info # For Dcom 3G support
	$install firefox # Standalone web browser from mozilla.org
	$install iperf iperf3 # A tool to measure maximum TCP bandwidth
	$install tree # A directory listing program displaying a depth indented list of files
	$install ack # A Perl-based grep replacement, aimed at programmers with large trees of heterogeneous source code
	$install python2-pip python-pip # The PyPA recommended tool for installing Python packages
	$install mactelnet # A linux console tool for connecting to MikroTik RouterOS devices via their ethernet address
	$install net-snmp # A suite of applications used to implement SNMPv1, SNMPv2c and SNMPv3 using both IPv4 and IPv6
	$install teamviewer # All-In-One Software for Remote Support and Online Meetings
	$install spectacle # KDE screenshot capture utility
	$install fping # A utility to ping multiple hosts at once
	$install dropbox # A free service that lets you bring your photos, docs, and videos anywhere and share them easily
fi

###
# Config touchpad by command 
# http://unix.stackexchange.com/questions/12328/touchpads-click-isnt-working-on-arch-installation-with-gnome
# synclient TapButton1=1 # Enable Tap To Click
# synclient HorizTwoFingerScroll=1 # Enable Horizon Finger Scroll

###
# "user_list host_list=effective_user_list tag_list command_list"
# user_list :  list of users or a user alias that has already been set.
# host_list – list of hosts or a host alias on which users can run sudo. 
# effective_user_list – list of users they must be running as or a run as alias.
# tag_list – list of tags such as NOPASSWD.
# command_list – list of commands or a command alias to be run by user(s) using sudo.
# add the following command on /etc/sudoers for run any command without password or an other config 
# sakat ALL=(ALL) NOPASSWORD: ALL # Allow username=sakat excute any command without password
###

### 
