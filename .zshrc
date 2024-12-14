##-*- coding: utf-8-unix -*-
#

## zplug
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "marzocchi/zsh-notify"
zplug "zsh-users/zsh-completions"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load
## zplug ^

## import ENV
if [ -f ~/.env.zsh ]; then
  source ~/.env.zsh
fi

##users generic .zshrc file for zsh(1)
#
export PATH=~/bin:/opt/local:$PATH

##For Ghostscript
#
export PATH=/Applications/Ghostscript.app:/Applications/Ghostscript.app/bin:$PATH

##For homebrew PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH

##For rbenv PATH
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

##For pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

##For gibo
alias gignore='gibo -l | sed "/=/d" | tr "\t", "\n" | sed "/^$/d" | sort | peco | xargs gibo'

##For npm
export PATH=/usr/local/share/npm/bin:$PATH

##For adb
export PATH=/Users/fromatom/Library/Android/sdk/platform-tools:$PATH

## for Go-lang
if [ -x "`which go`" ]; then
  export GOPATH=$HOME/.go
  export PATH=$PATH:$GOPATH/bin
fi

## for nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

##For git diff-highlight
export PATH=$PATH:/opt/homebrew/share/git-core/contrib/diff-highlight

##For less code-highlight
export LESS='-R'
export LESSOPEN='| /opt/homebrew/bin/src-hilite-lesspipe.sh  %s'

## cd git repo top
#
function groot() {
    cd ./$(git rev-parse --show-cdup)
    if [ $# = 1 ]; then
        cd $1
    fi
}

## setting for peco
for f (~/.zsh/peco-sources/*) source "${f}" # load peco sources
bindkey '^r' peco-select-history
bindkey '^u' peco-cdr
bindkey "^g^a" peco-select-git-add
bindkey "^g^b" peco-git-recent-branches
bindkey "^g^b^a" peco-git-recent-all-branches
bindkey "^h" peco-select-ssh
bindkey "^x^o" peco-cdr-and-open-xcode
bindkey "^g^p" peco-checkout-pull-request
bindkey "^g^g" ghq-select-repository

## setting for cdr
#
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8
case ${UID} in
    0)
        LANG=C
        ;;
esac

## Default shell configuration
#
# set prompt
#

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a gets to line head and Ctrl-e gets
#   to end) and something additions
#
bindkey -e
bindkey "^[[1~" beginning-of-line # Home gets to line head
bindkey "^[[4~" end-of-line # End gets to line end
bindkey "^[[3~" delete-char # Del

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# reverse menu completion binded to Shift-Tab
#
bindkey "\e[Z" reverse-menu-complete


## Command history configuration
#
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data


## zsh editor
#
autoload zed

## Prediction configuration
#
#autoload predict-on
#predict-off


## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
    freebsd*)
    alias ls="ls -G -w"
    ;;
    darwin*)
    alias ls="eza --icons"
    ;;
    linux*)
    alias ls="ls --color"
    ;;
esac

alias ks="ls"
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
alias lla="ls -la"
alias lal="ls -la"
alias du="du -h"
alias df="df -h"
alias su="su -l"
alias g='git'
alias be='bundle exec'
alias gpull='git pull origin $(git rev-parse --abbrev-ref HEAD)'

## Xcodeのプロジェクトを簡単に開けるようにする
alias xc='xed .'

## load user .zshrc configuration file
#
[ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/fromatom/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/fromatom/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/fromatom/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/fromatom/google-cloud-sdk/completion.zsh.inc'; fi

# zsh-completion
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

## starship
eval "$(starship init zsh)"

## OpenJDK
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
