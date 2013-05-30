##-*- coding: utf-8-unix -*-
#

#source notfound.zsh

##users generic .zshrc file for zsh(1)
#
export PATH=~/bin:/opt/local:$PATH

##For Ghostscript
#
export PATH=/Applications/Ghostscript.app:/Applications/Ghostscript.app/bin:$PATH

##For homebrew PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

##For rbenv PATH
PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"


#alias lynx="/Applications/Lynxlet.app/Contents/Resources/lynx/bin/lynx"

## use alc with w3m
#
function alc() {
    if [ $# != 0 ]; then
        lynx -dump -nonumbers "http://eow.alc.co.jp/$*/UTF-8/?ref=sa" | less +38
    else
        lynx -dump -nonumbers "http://www.alc.co.jp/"
    fi
}


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

###ブランチ名を状態によって色変え
autoload -U colors; colors
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function rprompt-git-current-branch {
    local name st color gitdir action
    if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
        return
    fi
    name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
    if [[ -z $name ]]; then
        return
    fi

    gitdir=`git rev-parse --git-dir 2> /dev/null`
    action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

    st=`git status 2> /dev/null`
    if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
        color=%F{green}
    elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
        color=%F{yellow}
    elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
        color=%B%F{red}
    else
        color=%F{red}
    fi

    echo "(%{$color%}$name%{$reset_color%})"
}

setopt PROMPT_SUBST


## Default shell configuration
#
# set prompt
#

colors
#PROMPT="%m:%n%%%{${reset_color}%} "
PROMPT="%{${fg[grew]}%}☁  %{${reset_color}%}"
PROMPT2="%{${fg[yellow]}%}%_%%%{${reset_color}%} "
SPROMPT="%{${fg[yellow]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"

#RPROMPT='`rprompt-git-current-branch` [%~]'
RPROMPT='`rprompt-git-current-branch` %{${fg[cyan]}%}[%~]%{${reset_color}%}'

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


## Completion configuration
#
fpath=(${HOME}/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit


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
    freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
    linux*)
    alias ls="ls --color"
    ;;
esac

case "${OSTYPE}" in
    cygwin*)
        alias open='cygstart'
        alias emacs='/cygdrive/c/cygwin/app/emacs24.2/bin/emacs.exe -rv'
        ;;
    darwin*)
        alias 'emacs=/Applications/Emacs.app/Contents/MacOS/emacs'
esac


alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
alias lla="ls -la"
alias lal="ls -la"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias g='git'

## terminal configuration
#
case "${TERM}" in
    screen)
    TERM=xterm
    ;;
esac

case "${TERM}" in
    xterm|xterm-color)
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
    kterm-color)
    stty erase '^H'
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
    kterm)
    stty erase '^H'
    ;;
    cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
    jfbterm-color)
    export LSCOLORS=gxFxCxdxBxegedabagacad
    export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
    xterm|xterm-color|kterm|kterm-color)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac


## load user .zshrc configuration file
#
[ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine
