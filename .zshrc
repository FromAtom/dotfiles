##-*- coding: utf-8-unix -*-
#

## zplu
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "marzocchi/zsh-notify"

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

##For rbenv PATH
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

##For gibo
alias gignore='gibo -l | sed "/=/d" | tr "\t", "\n" | sed "/^$/d" | sort | peco | xargs gibo'

##For npm
export PATH=/usr/local/share/npm/bin:$PATH

##For adb
export PATH=/Users/fromatom/Library/Android/sdk/platform-tools:$PATH
## For MySQL v5.7
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export DYLD_LIBRARY_PATH="/usr/local/opt/mysql@5.7/:$DYLD_LIBRARY_PATH"

## for Go-lang
if [ -x "`which go`" ]; then
  export GOPATH=$HOME/.go
  export PATH=$PATH:$GOPATH/bin
fi

## for nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

##For perlbrew
#export PERL5LIB=$HOME/perl5/lib/perl5
#export PERLBREW_ROOT=$HOME/.perlbrew
#source ~/.perlbrew/etc/bashrc
#source ~/perl5/perlbrew/etc/bashrc

##For zsh-highlighting
export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight

##For cpanminus
# if which cpanm > /dev/null 2>&1 && [ -n $PERLBREW_ROOT ]; then
#     export PERL_CPANM_OPT=--local-lib=$PERLBREW_ROOT
#     export PERL5LIB=$PERLBREW_ROOT/lib/perl5:$PERL5LIB
# fi

##For less code-highlight
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh  %s'
export LESS='-R'

#For cabal
PATH=${HOME}/.cabal/bin:$PATH

##For zsh-completions
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
autoload -U compinit
compinit -u

##For less
alias lessc=”~/node_modules/less/bin/lessc”

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

###ブランチ名を状態によって色変え
#autoload vcs_info
autoload -Uz is-at-least
autoload -Uz vcs_info
autoload -Uz colors; colors

zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:*' enable git
if is-at-least 4.3.10; then
  zstyle ':vcs_info:git:*' formats '%{${reset_color}%}(%F{green}%c%u%b%{${reset_color}%})' '%m'
  zstyle ':vcs_info:git:*' actionformats '%{${reset_color}%}(%c%u%b%{${reset_color}%})' '%m' '<!%a>'
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "%F{yellow}"
  zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}"
fi

function _update_vcs_info_msg() {
  local -a messages
  local prompt
  LANG=C vcs_info
  if [[ -z ${vcs_info_msg_0_} ]]; then
    prompt=""
  else
    [[ -n "$vcs_info_msg_0_" ]] && messages+=("%F{green}${vcs_info_msg_0_}%f")
    [[ -n "$vcs_info_msg_1_" ]] && messages+=("%F{yellow}${vcs_info_msg_1_}%f")
    [[ -n "$vcs_info_msg_2_" ]] && messages+=("%F{red}${vcs_info_msg_2_}%f")
    prompt="${(j: :)messages}"
  fi
  RPROMPT="$prompt %{${fg[blue]}%}[`pwd | sed "s:$HOME:~:"`]%{${reset_color}%}"
}
add-zsh-hook precmd _update_vcs_info_msg


setopt PROMPT_SUBST


## Default shell configuration
#
# set prompt
#

colors
#PROMPT="%m:%n%%%{${reset_color}%} "
PROMPT="%{${fg[green]}%}>%{${fg[yellow]}%}>%{${fg[red]}%}> %{${reset_color}%}"
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
        alias e='/usr/local/bin/emacsclient -n'
#        alias emacs='/cygdrive/c/cygwin/app/emacs24.2/bin/emacs.exe -rv'
        alias emacs='/usr/local/bin/emacsclient -n'
        ;;
    darwin*)
        alias e='/usr/local/bin/emacsclient -n'
        alias emacs='/Applications/Emacs.app/Contents/MacOS/emacs'
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
function open-xcode-project() {
    open *.xcworkspace || open *.xcodeproj || echo 'fatal: Not a Xcode repository'
}
alias xc='open-xcode-project'

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

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

[[ -d /usr/local/opt/nvm ]] && export NVM_DIR=/usr/local/opt/nvm
[[ -f $NVM_DIR/nvm.sh ]] && source $NVM_DIR/nvm.sh
