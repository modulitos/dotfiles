# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# AWS Environmental Variables for Auto-Scaling commandline tools
# export JAVA_HOME=/usr/local/jre1.7.0_51
# export AWS_AUTO_SCALING_HOME=/usr/local/AutoScaling-1.0.61.4/
# export PATH=$PATH:$AWS_AUTO_SCALING_HOME/bin
# export AWS_AUTO_SCALING_URL=https://autoscaling.us-west-2b.amazonaws.com  

# TeX Live PATHS
# export PATH=$PATH:/usr/local/texlive/2013/bin/x86_64-linux
# export INFOPATH=$INFOPATH:/usr/local/texlive/2013/texmf-dist/doc/info
# export MANPATH=$MANPATH:/usr/local/texlive/2013/texmf-dist/doc/man
TEXDIR="/usr/local/texlive/2014"
# export PATH=$TEXDIR/bin/i386-linux:$PATH    # for 32-bit installation
# export PATH=$TEXDIR/bin/x86_64-linux:$PATH  # for 64-bit installation
# export PATH=$PATH:/opt/texbin # added this to our "/etc/environment"
export INFOPATH=$INFOPATH:$TEXDIR/texmf-dist/doc/info
export MANPATH=$MANPATH:$TEXDIR/texmf-dist/doc/man
# set path for tlmgr:
PATH=/usr/local/texlive/2014/bin/x86_64-linux:$PATH


# Android Development Tools / SDK
# export PATH=$PATH:/home/lucas/Development/android-sdk-linux/tools:/home/lucas/Development/android-sdk-linux/platform-tools

# Set colorful prompt 
# export PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
# export PROMPT_DIRTRIM=2
export MYPS='$(echo -n "${PWD/#$HOME/~}" | awk -F "/" '"'"'{if (length($0) > 20) { if (NF>4) print $1 "/" $2 "/.../" $(NF-1) "/" $NF; else if (NF>3) print $1 "/" $2 "/.../" $NF; else print $1 "/.../" $NF; } else print $0;}'"'"')'
# export MYPS='$(echo -n "${PWD/#$HOME/~}" | awk -F "/" '"'"'{if (length($0) > 20) { if (NF>4) print $1 "/" $2 "/.../" $(NF-1) "/" $NF; else if (NF>3) print $1 "/" $2 "/.../" $NF; else print $1 "/.../" $NF; } else print $0;}'"'"')'
PS1='\[\e[1;32m\][\h]$(eval "echo ${MYPS}")$\[\e[0m\] '
#PS1='\[\e[1;32m\][\u@\h]$(eval "echo ${MYPS}")$\[\e[0m\] '

# Google Cloud SDK - update PATH and Python 2 version
source /home/lucas/Development/google-cloud-sdk/path.bash.inc
export CLOUDSDK_PYTHON=/usr/bin/python2

# The next line enables bash completion for gcloud.
source /home/lucas/Development/google-cloud-sdk/completion.bash.inc

# alias tmux-session="/home/lucas/bin/tmux-session"
alias tmux='tmux -2'

# Python virtual environment and wrapper
# export WORKON_HOME=$HOME/.virtualenvs
# source /usr/local/bin/virtualenvwrapper_lazy.sh
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh
# Python virtual environment aliases
#alias v='workon'
#alias v.deactivate='deactivate'
#alias v.mk='mkvirtualenv'
#alias v.rm='rmvirtualenv'
#alias v.switch='workon'
#alias v.add2virtualenv='add2virtualenv'
#alias v.cdsitepackages='cdsitepackages'
#alias v.cd='cdvirtualenv'
#alias v.lssitepackages='lssitepackages'

export NLTK_DATA=/home/lucas/Development/nltk_data

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
# export PATH="$PATH:/home/lucas/Development/clion-138.2344.14/bin"
export PATH="$PATH:/home/lucas/Development/activator-1.2.10"
export SCALA_HOME="/home/lucas/Applications/scala-2.11.2"
export PATH="$PATH:$SCALA_HOME/bin"

export CLASSPATH=$CLASSPATH:~/class/algorithms/assignments/algorithms/stdlib.jar:~/class/algorithms/assignments/algorithms/algs4.jar:~/class/algorithms/assignments/out/production/algorithms-princeton

export NVM_DIR="/home/lucas/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
## Node: Allow NPM to install global command-line tools that are not in ~/npm:
export PATH=~/npm/bin:$PATH
export PATH=./node_modules/.bin:$PATH
export NODE_ENV="development"

test -f ~/.git-completion.bash && . $_

PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
export GEM_HOME=$(ruby -e 'print Gem.user_dir')

# Docker autocompletion
. ~/.docker-completion.sh

