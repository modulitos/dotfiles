# shellcheck shell=bash
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf kubectl)

# shellcheck disable=SC1091
source "$ZSH/oh-my-zsh.sh"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

# for vim?
# bindkey -v

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
# path=('~/bin' $path)
# export PATH

# Pyenv:
export PATH=~/.pyenv/versions/:$PATH

eval "$(pyenv init -)"

# mkdir -p "$WORKON_HOME"

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

eval "$(direnv hook zsh)"


gitb() {
  git checkout "$(git branch | fzf| tr -d '[:space:]')"
}
