# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.zsh/oh-my-zsh

ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git colored-man-pages)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export EDITOR='vim'

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
USER='sakat'
DROPBOX=/home/$USER/Dropbox
dotfiles=$DROPBOX/dotfiles
Account=$DROPBOX/.Access/Access
mkt=$DROPBOX/mkt

# for fast access and edit file
alias known_hosts="vim ~/.ssh/known_hosts"
alias initrc="vim $dotfiles/init.sh"
alias vimrc="vim ~/.vim/vimrc"
alias zshrc="vim $dotfiles/zshrc"
alias mkt="cd $DROPBOX/Mkt/Conf"
alias Py="cd $DROPBOX/Python"
alias log="/var/log"
alias cacti_inst="vim $DROPBOX/Linux/sh-Scri/cacti/cacti_inst.sh"
alias g='grep -C5 --color=auto'
alias vi="vim"
alias svi="sudo vim"
alias svim="sudo vim"
alias tel="telnet "
alias smv="sudo mv -f "
alias smkdir="sudo mkdir "
alias s_cp="sudo cp -r "
alias winb="sudo wine $mkt/tool/winbox.exe"
alias ping="sudo ping -i 0.1 -M do"
alias fping="fping -g -c 1 "
alias tracepath="tracepath -n"
alias console="sudo picocom /dev/ttyUSB0 || sudo picocom /dev/ttyUSB1"
alias rm="rm -rf"
alias lnd="ln -sf"
alias slnd="sudo ln -sf"
alias sln="sudo ln"

test -e /etc/debian_version && DIST="Debian" && grep Ubuntu /etc/lsb-release &> /dev/null && DIST="Ubuntu"
if [ "$DIST" = "Ubuntu" ]  || [ "$DIST" = "Debian" ]; then
		# Truly non interactive some command
		alias update="sudo apt-get update "
		alias upgrade="sudo apt-get upgrade "
		alias install="sudo apt-get install "
		alias uninstall="sudo apt-get remove "
else
		# For Arch Linux
		alias update="sudo pacman -Suy"
		alias install="sudo pacman -S"
		alias app-list="pacman -Qe"
		alias service-list="systemd-analyze blame" # list all loader service
fi

extract () {
if [ -f $1 ] ; then
   case $1 in
        *.tar.bz2)   tar xvjf $1    ;;
        *.tar.gz)    tar xvzf $1    ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar x $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xvf $1     ;;
        *.tbz2)      tar xvjf $1    ;;
        *.tgz)       tar xvzf $1    ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)           echo "don't know how to extract '$1'..." ;;
   esac
else
        echo "'$1' is not a valid file!"
fi
}

loss () {
if [ -f $2 ]; then
   while :; do ping -f -c 100 $1 ; sleep 3; done
else
   while :; do ping -f -c 100 $1 -s $2 ; sleep 3; done
fi
}

# some ssh example in case require algorithm 
# ssh -oHostKeyAlgorithms=+ssh-dss user@legacyhost
# ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 admin@IP
# ssh -C -D 8080 admin@ IP  # dynamic port forwarding

pg (){
# edit ping command	
   if [ -f $2 ]; then
		   ping $1 
   else
		   ping -s $2 $1
   fi
 }

# private acount
alias account="vim $Account"
source $Account

