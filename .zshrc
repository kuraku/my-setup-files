# Generic .zshrc file for zsh 5
#
# MASUDA A

# Search path for the cd command
#cdpath=(.. ~ ~/src ~/zsh)

# remove /usr/games and /usr/X11R6/bin if you want
PATH=$HOME/bin:$HOME/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/usr/X11R6/bin; export PATH

LD_LIBRARY_PATH=$HOME/local/lib; export LD_LIBRARY_PATH

TERM=xterm-256color; export TERM

## get hostname
function gethost(){
  hostname=`hostname`
  dev='dev'
  case ${hostname} in
  '5a-c08-b5.data-hotel.net') # ASHIBA
    dev='zero'
    ;;
  '5a-c04-c3.data-hotel.net')
    dev='dev05'
    ;;
  '5a-c08-a5.data-hotel.net')
    dev='dev06'
    ;;
  '5a-c08-a6.data-hotel.net')
    dev='dev07'
    ;;
  '5a-c04-d2.data-hotel.net')
    dev='intra'
    ;;
   *)
    ;;
  esac
  echo ${dev}
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

#alias emacs='~/local/bin/emacs'
alias pu=pushd
alias po=popd
alias d='dirs -v'
alias h=history

alias j=jobs
alias fg1='fg %1'
alias fg2='fg %2'
alias fg3='fg %3'

alias sc='~/local/bin/screen'
#alias sc='~/local/bin/screen -s zsh'
#alias sc='~/local/bin/screen -S zero -s zsh'
alias scu='~/local/bin/screen -S utf8 -U'
alias vsc='~/local/bin/vscreen -S'
alias nie='~/bin/screenie'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias emacs='~/local/bin/emacs'
alias emacs-daemon='~/local/bin/emacs --daemon'
alias emacs-kill='~/local/bin/emacsclient -e "(kill-emacs)"'
alias emacsclient='~/local/bin/emacsclient -nw'
#
alias psx='ps ax -fl'
alias vless='/usr/local/share/vim/vim73/macros/less.sh'

alias diff=colordiff
alias M='| more'

# 開発サーバー
#alias d1='sudo ssh masuda@dev01.posren-new'
#alias d2='sudo ssh masuda@dev02.posren-new'
#alias d3='sudo ssh masuda@dev03.posren-new'
#alias d4='sudo ssh masuda@dev04.posren-new'
alias d5='sudo ssh masuda@dev05.posren-new'
alias d6='sudo ssh masuda@dev06.posren-new'
alias d7='sudo ssh masuda@dev07.posren-new'
alias d8='sudo ssh masuda@dev08.posren-new'

# cvs
alias cvsupdate='sudo -u edge-dev cvs up -dP'
alias cvscommit='sudo -u edge-dev cvs commit'
alias cvsstatus='sudo -u edge-dev cvs status'
alias cvsdiff='sudo -u edge-dev cvs diff'

#svn
alias svnstatus='sudo -u edge-dev svn -uv status'
alias svnupdate='sudo -u edge-dev svn up'
alias svndiff='sudo -u edge-dev svn diff -r COMMITTED:HEAD'

alias dstat-='dstat -tplndcm'

alias check-color='for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo'

## servers see ssh_hosts
#alias slogin='sudo ssh $(cat ~/ssh_hosts||awk "{print \$3}")'
alias slogin='sudo ssh $(cat ~/ssh_hosts|peco|awk "{print \$3}")'
alias ssh_checksize='sudo ssh $(cat ~/ssh_hosts|peco|awk "{print \$3}") "df -h" '

#alias dblogin='/usr/local/mysql/bin/mysql $(cat ~/db_hosts||awk "{printf(\"-h%s -u%s -p%s %s\",\$3,\$4,\$5,\$6,\$2)}")'
alias dblogin='/usr/local/mysql/bin/mysql $(cat ~/db_hosts|peco|awk "{printf(\"-h%s -u%s -p%s %s\",\$3,\$4,\$5,\$6,\$2)}")'

alias watch1='watch -n 1 --differences=cumulative'

alias Ymd='echo `date +%Y%m%d`'
alias Ymdt='echo `date +%Y%m%d.%H%M`'

alias sourceIP='wget -q http://www.luft.co.jp/cgi/ipcheck.php -O - |grep "name=\"IP\""'

# emacs key
bindkey -e

# Hosts to use for completion
hosts=(`hostname` tigris anjyu lsheep )

#
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
    PROMPT="%{${fg[blue]}%}[%n@${host}:%/]%{${reset_color}%}
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

case ${host} in
  'dev07')
    #LANG="ja_JP.UTF-8"
    LANG="ja_JP.utf8"
    ;;
  *)
    LANG="ja_JP.eucJP"
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

if [ -f $HOME/auto_jump.zsh ]; then
  source $HOME/auto_jump.zsh &&  echo 'load ...auto_jump.zsh'
fi

## for tramp
case "${TERM}" in
dump | emacs)
    PROMPT="%n@%~%(!.#.$)"
    RPROMPT=""
    [[ $EMACS = t ]] && unsetopt zle
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
zstyle ':completion:*' list-colors di=34 fi=0

## for 
export PYTHONPATH=~//lib/python2.6/site-packages:$PYTHONPATH
alias percol=~/percol/bin/percol

alias selkill='ps aux | peco | awk "{print \$2}" | xargs kill'
alias prockill='ps aux | peco | awk "{print \$2}" | xargs kill'
alias selproc='ps aux | peco | awk "{print \$2}" | xargs'
alias proccheck='ps aux | peco | awk "{print \$2}" | xargs'
alias procinfo='ps aux | peco | awk "{print \$2}" | xargs -i% cat /proc/%/status'

alias hist='history | peco | awk "{ gsub(/ +[0-9]+/,\"\" ); print }" | bash'

## end of .zshrc

# module version
alias pmversion='perl -le '"'"'for $module (@ARGV) { eval "use $module"; print "$module ", ${"$module\::VERSION"} || "not found" }'"'"

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
#bindkey -r '^Q' #remove
#bindkey '^Q^q' zaw-history
#bindkey '^Qq' zaw-history

bindkey '^Xb' zaw-bookmark
bindkey '^Xa' zaw-bookmark-add-buffer

#bindkey '^Qh' zaw-history
bindkey '^@' zaw-cdr
bindkey '^Xd' zaw-cdr # r
bindkey '^Xt' zaw-cdd
bindkey '^Xr' zaw-dirstack # d
bindkey '^Xp' zaw-process
# bindkey '^Qgf' zaw-git-files
# bindkey '^Qgd' zaw-git-dirs
# bindkey '^Qgl' zaw-git-log

# http://d.hatena.ne.jp/kei_q/20110308/1299594629
# http://qiita.com/items/1f2c7793944b1f6cc346
show_buffer_stack() {
  POSTDISPLAY="
stack: $LBUFFER"
  zle push-line-or-edit
}
zle -N show_buffer_stack
setopt noflowcontrol
bindkey '^Q' show_buffer_stack

# #
# function cdup() {
#   echo
#   cd ..
#   zle reset-prompt
# }
# zle -N cdup
# bindkey '^X\^' cdup

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

## ssh
function ssh-login(){
  BUFFER=$(grep -v '^#' ~/ssh_hosts|peco|awk "{print \$3}")
  #BUFFER=$(cat ~/ssh_hosts|peco|awk "{print \$3}")
  if [ -z $BUFFER ]; then
    zle reset-prompt
  else
    BUFFER='sudo ssh '$BUFFER $@
    zle accept-line
  fi
}
zle -N ssh-login
bindkey '^Xs' ssh-login
bindkey '^Xl' ssh-login

##function ssh-uptime(){
##  ssh-login
##}
##zle -N ssh-uptime

# .zshrc
function load-zshrc(){
  BUFFER="source ~/.zshrc"
  zle accept-line
}
zle -N load-zshrc
bindkey '^Xz' load-zshrc

##
. ~/z.sh
_Z_CMD=j
export _Z_CMD
#export _Z_DATA=${HOME}/gnw/masuda/.z

type peco >/dev/null 2>&1 && ccd() {
  local path=$(z -l | awk '{ print $2 }' | peco | head -n 1)
    [ -n "$path" ] && cd "$path"
}

function bkup () {
    cp $1{,.`date '+%Y%m%d.%H%M'`}
}


# EOF
