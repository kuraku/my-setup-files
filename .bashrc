##
export DEVNAME='NOMATCH'

case `hostname` in
    '5a-c08-b5.data-hotel.net') # ASHIBA
    export DEVNAME='zero'
    ;;
    '5a-c04-c3.data-hotel.net')
    export DEVNAME='dev05'
    ;;
    '5a-c08-a5.data-hotel.net')
    export DEVNAME='dev06'
    ;;
    '5a-c08-a6.data-hotel.net')
    export DEVNAME='dev07'
    ;;
    *)
    ;;
esac

_ssh_login() {
  local us=`cat ~/ssh_hosts|peco`
  local u=$(echo ${us} | awk "{print \$3}")
  local s=$(echo ${us} | awk "{print \$2}")
  echo "-> ssh ${u}@${s}"
  sudo -u ${u} ssh ${s}
}
bind -x '"\C-xs": _ssh_login'

#
echo "load .bashrc"
