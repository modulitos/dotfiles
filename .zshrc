# shellcheck shell=bash

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

# for vim?
# bindkey -v

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/lucas/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# AWS Environmental Variables for Auto-Scaling commandline tools
# export JAVA_HOME=/usr/local/jre1.7.0_51
# export AWS_AUTO_SCALING_HOME=/usr/local/AutoScaling-1.0.61.4/
# export PATH=$PATH:$AWS_AUTO_SCALING_HOME/bin
# export AWS_AUTO_SCALING_URL=https://autoscaling.us-west-2b.amazonaws.com
# awscli auto command completion:
# complete -C '/usr/bin/aws_completer' aws
export AWS_DEFAULT_PROFILE=default


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

export PATH=~/.local/bin:$PATH
# Updating path in zsh:
# https://stackoverflow.com/a/18077919/1884158
export PATH=~/bin:$PATH
# path=('~/bin' $path)
# export PATH

# Pyenv:
export PATH=~/.pyenv/versions/:$PATH

eval "$(pyenv init -)"


# Overrides config
if [ -f "$HOME/.pyenv/versions/3.8.0/bin/virtualenvwrapper.sh" ]; then
  # shellcheck source=/dev/null
  source "$HOME/.pyenv/versions/3.8.0/bin/virtualenvwrapper.sh"
fi

# Ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc


# Python virtual environment and wrapper
# export WORKON_HOME=$HOME/.virtualenvs
# source /usr/local/bin/virtualenvwrapper_lazy.sh
export VIRTUALENVWRAPPER_PYTHON=~/.pyenv/shims/python
export WORKON_HOME=~/.virtualenvs


## Note: Allow NPM to install global command-line tools that are not in ~/npm:
export PATH=~/npm/bin:$PATH
export PATH=./node_modules/.bin:$PATH

# some helpful posix aliases:
alias ll='ls -la'
alias rm="rm -I"

# source /usr/share/bash-completion/completions/git

# Ruby configs:
bex() { bundle exec "$@"; }

# PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
# export GEM_HOME=$(ruby -e 'print Gem.user_dir')

# Docker autocompletion
# . ~/.docker-completion.sh

# Pandoc
export PATH=~/.cabal/bin:$PATH

# For Emacs TimeSheet
export TEXINPUTS=.:$HOME/.emacs.d/elpa/auctex-11.88.8/latex:

export EDITOR="vim"
export BROWSER="firefox"

export MAILDIR=~/.mail/gmail
export INFOPATH=$INFOPATH:/usr/share/info


# added by travis gem

# # source autojump (installed via pacman):
# source /etc/profile.d/autojump.sh

# . $HOME/.asdf/asdf.sh
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  # shellcheck source=/dev/null
  source ~/.asdf/asdf.sh
fi

# . $HOME/.asdf/completions/asdf.bash

# rust
export PATH=~/.cargo/bin:$PATH
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# https://starship.rs/
eval "$(starship init zsh)"

# OS specifics:

unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*) machine=Linux;;
  Darwin*) machine=Mac;;
  *) machine="UNKNOWN:${unameOut}"
esac

if [[ $machine == Mac ]]; then
  # shellcheck disable=SC1090
  source "$HOME/.macosrc"
elif [[ $machine == Linux ]]; then
  # shellcheck disable=SC1090
  source "$HOME/.linuxsrc"
else
  echo "machine not recognized: $machine"
fi


# Overrides config
if [ -f "$HOME/.localrc" ]; then
  # shellcheck disable=SC1090
  source "$HOME/.localrc"
fi

# Yarn:
export PATH=~/.yarn/bin:~/.config/yarn/global/node_modules/.bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f ~/google-cloud-sdk/path.zsh.inc ]; then
  # shellcheck source=/dev/null
  . ~/google-cloud-sdk/path.zsh.inc;
fi

# The next line enables shell command completion for gcloud.
if [ -f ~/google-cloud-sdk/completion.zsh.inc ]; then
  # shellcheck source=/dev/null
  . ~/google-cloud-sdk/completion.zsh.inc;
fi

alias diso='OVERCOMMIT_DISABLE=1'
alias k='kubectl'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/lucas/.sdkman"

if [ -f "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
  # shellcheck source=/dev/null
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

alias tsm=transmission-remote

eval "$(direnv hook zsh)"
