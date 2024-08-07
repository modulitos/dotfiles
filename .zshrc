# shellcheck shell=bash

# User configuration

# zsh bugfix with emacs tramp:
# https://github.com/sorin-ionescu/prezto/issues/1552
if [[ "$TERM" == "dumb" ]]; then
    unset zle_bracketed_paste
    unset zle
    PS1='$ '
    return
fi

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

export PATH=~/.local/bin:$PATH
export PATH=~/bin:$PATH
if [ -d "$HOME/dotfiles_misc" ]; then
  export PATH=~/dotfiles_misc/bin:$PATH
  source ~/dotfiles_misc/config/emacs/aliases.zsh
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
export N_PREFIX="$HOME/sdk/n_install"
[[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin" # Added by n-install (see http://git.io/n-install-repo).

# some helpful posix aliases:
alias ll='ls -la'

# source /usr/share/bash-completion/completions/git

# Ruby configs:
bex() { bundle exec "$@"; }

# For Emacs TimeSheet
export TEXINPUTS=.:$HOME/.emacs.d/elpa/auctex-11.88.8/latex:
export PATH=~/.config/emacs/bin:$PATH

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
  Linux*) machine=Linux ;;
  Darwin*) machine=Mac ;;
  *) machine="UNKNOWN:${unameOut}" ;;
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
  . ~/google-cloud-sdk/path.zsh.inc
fi

# The next line enables shell command completion for gcloud.
if [ -f ~/google-cloud-sdk/completion.zsh.inc ]; then
  # shellcheck source=/dev/null
  . ~/google-cloud-sdk/completion.zsh.inc
fi

# added by Nix installer
# shellcheck disable=SC1091
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then . "$HOME/.nix-profile/etc/profile.d/nix.sh"; fi

# Home Manager vars:
# shellcheck disable=SC1091
if [ -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"; fi

# # Append ~/.nix-defexpr/channels to $NIX_PATH so that <nixpkgs>
# # paths work when the user has fetched the Nixpkgs channel.
# # https://discourse.nixos.org/t/where-is-nix-path-supposed-to-be-set/16434/8
# # https://nix-community.github.io/home-manager/index.html
# export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/$USER/channels${NIX_PATH:+:$NIX_PATH}

alias diso='OVERCOMMIT_DISABLE=1'
alias vy="vim -c 'set syntax=yaml' -"
alias vimy="vim -c 'set syntax=yaml'"
alias vj="vim -c 'set syntax=json' -"
alias vimj="vim -c 'set syntax=json'"

# sdkman: https://sdkman.io/install
export SDKMAN_DIR="$HOME/.sdkman"

if [ -f "$SDKMAN_DIR/bin/sdkman-init.sh" ]; then
  # shellcheck source=/dev/null
  source "$SDKMAN_DIR/bin/sdkman-init.sh"
fi

alias tsm=transmission-remote
alias kx=kubectx
export KUBECTL_EXTERNAL_DIFF="dyff between --omit-header --set-exit-code"
alias k="kubectl"
export PATH="${PATH}:${HOME}/.krew/bin"

eval "$(direnv hook zsh)"

gitb() {
  git checkout "$(git branch | fzf | tr -d '[:space:]')"
}

if [ -n "${commands[fzf-share]}" ]; then
  # on Arch:
  # https://nixos.wiki/wiki/Fzf
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
elif [ -f ~/.fzf.zsh ]; then
  # create this by running:
  # fzf --zsh > ~/.fzf.zsh
  source ~/.fzf.zsh
fi



# https://www.atlassian.com/git/tutorials/dotfiles
# git clone --bare <git-repo-url> $HOME/.cfg
# then `config checkout` in $HOME
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'


# return info about the nix pkg owning the given command:
nixfd() {
  echo -e $(which $1) | awk '{print $NF}' | xargs file | awk '{print $NF}' | xargs file
}

# returns whether the given package is installed
nixlspkgs() {
  nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq
}

# Removing this because vim doesn't render formatting correctly:
# use vim as the default pager when viewing man pages:
# https://fedoramagazine.org/5-cool-terminal-pagers-in-fedora/
# export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

