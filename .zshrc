# shellcheck shell=bash

# User configuration

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# Ignore duplicates:
setopt HIST_IGNORE_ALL_DUPS
# Ignore commands that start with ' ' (good for commands with creds if you don't want those on disk)
setopt HIST_IGNORE_SPACE
# All sessions get all history
setopt SHARE_HISTORY
bindkey -e

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

export AWS_DEFAULT_PROFILE=default


# TeX Live PATHS
TEXDIR="/usr/local/texlive/2014"
export INFOPATH=$INFOPATH:$TEXDIR/texmf-dist/doc/info
export MANPATH=$MANPATH:$TEXDIR/texmf-dist/doc/man
# set path for tlmgr:
PATH=/usr/local/texlive/2014/bin/x86_64-linux:$PATH

export PATH=~/.local/bin:$PATH
export PATH=~/bin:$PATH
if [ -d "$HOME/dotfiles/bin" ]; then
  export PATH=~/dotfiles/bin:$PATH
fi

# Pyenv:
export PATH=~/.pyenv/versions/:$PATH

eval "$(pyenv init -)"

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
# for n package node version manager: https://github.com/tj/n
export N_PREFIX="$HOME/sdk/n_install"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# some helpful posix aliases:
alias ll='ls -la'

# source /usr/share/bash-completion/completions/git

# Ruby configs:
bex() { bundle exec "$@"; }

# For Emacs TimeSheet
export TEXINPUTS=.:$HOME/.emacs.d/elpa/auctex-11.88.8/latex:

export EDITOR="vim"
export BROWSER="firefox"

export MAILDIR=~/.mail/gmail
export INFOPATH=$INFOPATH:/usr/share/info


# rust
export PATH=~/.cargo/bin:$PATH
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# Golang
export GOPATH=~/go
export GOBIN=$(go env GOPATH)/bin
export PATH=$GOPATH:$PATH
export PATH=$GOBIN:$PATH

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
  # shellcheck disable=SC1091
  source "$HOME/.macosrc"
elif [[ $machine == Linux ]]; then
  # shellcheck disable=SC1091
  source "$HOME/.linuxsrc"
else
  echo "machine not recognized: $machine"
fi


# Overrides config
if [ -f "$HOME/.localrc" ]; then
  # shellcheck disable=SC1091
  source "$HOME/.localrc"
fi

# Functions config
if [ -f "$HOME/.functions" ]; then
  # shellcheck disable=SC1091
  source "$HOME/.functions"
fi

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

# added by Nix installer
# shellcheck disable=SC1091
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then . "$HOME/.nix-profile/etc/profile.d/nix.sh"; fi

# Home Manager vars:
# shellcheck disable=SC1091
if [ -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"; fi

# Append ~/.nix-defexpr/channels to $NIX_PATH so that <nixpkgs>
# paths work when the user has fetched the Nixpkgs channel.
# https://discourse.nixos.org/t/where-is-nix-path-supposed-to-be-set/16434/8
# https://nix-community.github.io/home-manager/index.html
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/lucas/channels${NIX_PATH:+:$NIX_PATH}

alias diso='OVERCOMMIT_DISABLE=1'
alias vy="vim -c 'set syntax=yaml' -"
alias vimy="vim -c 'set syntax=yaml'"
alias vj="vim -c 'set syntax=json' -"
alias vimj="vim -c 'set syntax=json'"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"

if [ -f "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
  # shellcheck source=/dev/null
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

alias tsm=transmission-remote
alias kx=kubectx
export KUBECTL_EXTERNAL_DIFF="dyff between --omit-header --set-exit-code"
alias k="kubectl"
export PATH="${PATH}:${HOME}/.krew/bin"

eval "$(direnv hook zsh)"


gitb() {
  git checkout "$(git branch | fzf| tr -d '[:space:]')"
}

# on Arch:
# cp /usr/share/fzf/key-bindings.zsh ~/.fzf.zsh
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

