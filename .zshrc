# Generic .zshrc file for zsh 5
#
# MASUDA A
# for windows cygwin zsh

# Search path for the cd command
#cdpath=(.. ~ ~/src ~/zsh)

## get hostname
function gethost(){
  hostname=`hostname`
  case ${hostname} in
  '5a-c08-b5.data-hotel.net') # ASHIBA
    host='zero'
    ;;
  '5a-c04-c3.data-hotel.net')
    host='dev05'
    ;;
  '5a-c08-a5.data-hotel.net')
    host='dev06'
    ;;
  '5a-c08-a6.data-hotel.net')
    host='dev07'
    ;;
  *)
    host=${hostname}
    ;;
  esac
  echo ${host}
}
host=`gethost`

POSREN_HOSTNAME=${host}

umask 002

OS=`uname`
case ${OS} in
  'FreeBSD')
    alias ls='ls -aFG'
    ;;
  *)
    alias ls='ls -aF --color=auto'
    ;;
esac

alias pu=pushd
alias po=popd
alias d='dirs -v'
alias h=history
alias sc='screen -U -s zsh'
#alias sc='screen -U -S mas -s zsh'
#alias scu='~/local/bin/screen -S utf8 -U -s zsh'
#alias vsc='~/local/bin/vscreen -S zero -s zsh'
alias nie='~/bin/screenie'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
#
alias psx='ps ax -fl'
#alias vless='/usr/local/share/vim/vim73/macros/less.sh'

alias diff=colordiff

# 開発サーバー
alias d5='sudo ssh masuda@dev05.posren-new'
alias d6='sudo ssh masuda@dev06.posren-new'
alias d7='sudo ssh masuda@dev07.posren-new'

# cvs
alias cvsupdate='sudo -u edge-dev cvs up -dP'
alias cvscommit='sudo -u edge-dev cvs commit'
alias cvsstatus='sudo -u edge-dev cvs status'
alias cvsdiff='sudo -u edge-dev cvs diff'

#svn
alias svnstatus='sudo -u edge-dev svn status'
alias svnupdate='sudo -u edge-dev svn up'

# emacs key
bindkey -e

# Hosts to use for completion
hosts=(`hostname` tigris anjyu lsheep )

# Set prompts
    #PROMPT="%{${fg[red]}%}[%n@${host}]%(!.#.$) %{${reset_color}%}"
    #PROMPT2="%{${fg[red]}%}%_> %{${reset_color}%}"
    #SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
    #RPROMPT="%{${fg[red]}%}[%~]%{${reset_color}%}"

autoload colors
colors

case ${host} in
  'zero')
    PROMPT="%{${fg[blue]}%}[%n@${host}:%/]%{${reset_color}%}
%{${fg[red]}%}(!%!)-(jobs:%j)%{${reset_color}%}%(!.#.$) "
    PROMPT2="%{${fg[red]}%}%_> %{${reset_color}%}"
    SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
    RPROMPT=""
    ;;
  'dev07')
    PROMPT="%{${fg[cyan]}%}[%n@${host}:%/]%{${reset_color}%}
%{${fg[red]}%}(!%!)-(jobs:%j)%{${reset_color}%}%(!.#.$) "
    PROMPT2="%{${fg[red]}%}%_> %{${reset_color}%}"
    SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
    RPROMPT=""
    ;;
  *)
    PROMPT="%{${fg[cyan]}%}[%n@${host}:%/]%{${reset_color}%}
%{${fg[yellow]}%}(!%!)-(jobs:%j)%{${reset_color}%}%(!.#.$) "
    PROMPT2="%{${fg[red]}%}%_> %{${reset_color}%}"
    SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
    RPROMPT=""
    ;;
esac

DIRSTACKSIZE=20

##
HISTFILE=$HOME/.zsh-history           # 履歴をファイルに保存する
HISTSIZE=1000                         # メモリ内の履歴の数
SAVEHIST=1000                         # 保存される履歴の数
setopt extended_history               # 履歴ファイルに時刻を記録
function history-all { history -E 1 } # 全履歴の一覧を出力する
setopt share_history                  # すべての zsh のプロセスで履歴を共有

LD_LIBRARY_PATH=$HOME/local/lib

case ${host} in
  'dev07')
    #LANG="ja_JP.UTF-8"
    LANG="ja_JP.utf8"
    ;;
  'PD021')
    LANG="ja_JP.utf8"
    ;;
  *)
    LANG="ja_JP.utf8"
    ;;
esac

## % history-all | grep find | grep tr

# cdでpushdする。
setopt auto_pushd

# pushdで同じディレクトリを重複してpushしない。
setopt pushd_ignore_dups

## PROMPT内で変数展開・コマンド置換・算術演算を実行する。
setopt prompt_subst
## PROMPT内で「%」文字から始まる置換機能を有効にする。
setopt prompt_percent
## コピペしやすいようにコマンド実行後は右プロンプトを消す。
setopt transient_rprompt

## cdr 
autoload -Uz compinit && compinit -u
# load at incr*.zsh
#zstyle ':completion:*' menu select
#zstyle ':completion:*:cd:*' ignore-parents parent pwd
#zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'

typeset -ga chpwd_functions

#if is-at-least 4.3.11; then
  autoload -U chpwd_recent_dirs cdr
  chpwd_functions+=chpwd_recent_dirs
  zstyle ":chpwd:*" recent-dirs-max 500
  zstyle ":chpwd:*" recent-dirs-default true
  zstyle ":completion:*" recent-dirs-insert always
#fi

# load other files
#if [ -f $HOME/incr*.zsh ]; then
#  source $HOME/incr*.zsh &&  echo 'load ...incr*.zsh'
#fi

if [ -f $HOME/hosts.zsh ]; then
  source $HOME/hosts.zsh &&  echo 'load ...hosts.zsh'
fi

#if [ -f $HOME/prompt.zsh ]; then
#  source $HOME/prompt.zsh
#fi

if [ -f $HOME/db.zsh ]; then
  source $HOME/db.zsh &&  echo 'load ...db.zsh'
fi

## for tramp
case "${TERM}" in
dump | emacs)
    PROMPT="%n@%~%(!.#.$)"
    RPROMPT=""
    unsetopt zle
    ;;
esac

## 2013-11
# TAB で順に補完候補を切り替える
setopt auto_menu
# 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
# KILL
zstyle ':completion:*:processes' menu yes select=2
# 色つきの補完
#zstyle ':completion:*' list-colors di=34 fi=0

## end of .zshrc


## 13.11.15(fri)-10:51
## zaw
## when exit if no source
if [ -f $HOME/zaw/zaw.zsh ]; then

source $HOME/zaw/zaw.zsh || { echo '...skip(source error)'; return 1; }

## Basic settings
zstyle ':filter-select' case-insensitive yes
zstyle ':filter-select' max-lines $(($LINES / 2))

bindkey '^@' zaw-cdr # zaw-cdrをbindkey
bindkey '^R' zaw-history

## bindkey
bindkey -r '^Q' #remove
bindkey '^X^q' zaw-history
bindkey '^Xq' zaw-history

#bindkey '^Qh' zaw-history
bindkey '^Xd' zaw-cdr # r
bindkey '^Xt' zaw-cdd
bindkey '^Xr' zaw-dirstack # d
bindkey '^Xp' zaw-process

## zaw-src-cdd
# http://blog.kentarok.org/entry/2012/03/24/221522
if (( $+functions[cdd] )); then
    function zaw-src-cdd () {
        if [ -r "$CDD_PWD_FILE" ]; then
            for window in `cat $CDD_PWD_FILE | sed '/^$/d'`; do
                candidates+=("${window}")
            done
 
            actions=(zaw-src-cdd-cd)
            act_descriptions=("cdd for zaw")
        fi
    }
    function zaw-src-cdd-cd () {
        BUFFER="cd `echo $1 | cut -d ':' -f 2`"
        zle accept-line
    }
    zaw-register-src -n cdd zaw-src-cdd
fi
 
## zaw-src-dirstack
# http://d.hatena.ne.jp/hchbaw/20110224/zawzsh
zmodload zsh/parameter
function zaw-src-dirstack() {
    : ${(A)candidates::=$dirstack}
    actions=("zaw-callback-execute" "zaw-callback-replace-buffer" "zaw-callback-append-to-buffer")
    act_descriptions=("execute" "replace edit buffer" "append to edit buffer")
}
zaw-register-src -n dirstack zaw-src-dirstack
 
fi ## -f zaw.zsh

####
##function powerline_precmd() {
##  export PS1="$(~/powerline-bash/powerline-bash.py $? --shell zsh)"
##}
## 
##function install_powerline_precmd() {
##  for s in "${precmd_functions[@]}"; do
##    if [ "$s" = "powerline_precmd" ]; then
##      return
##    fi
##  done
##  precmd_functions+=(powerline_precmd)
##}
## 
##install_powerline_precmd
