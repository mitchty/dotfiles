# common/.profile.d/20-functions-ps1.sh

# Get user name of current user even if
# $USER isn't set
# Use id if we don't have $USER
user_name()
{
  if [ -z $USER ]; then
    echo $(id | awk -F\( '{print $2}' | sed -e 's/[)].*//g')
  else
    echo $USER
  fi
}

# duh
am_i_root()
{
  [ "$(user_name)" = 'root' ]
}

userps1name=
hostps1name=

host_name()
{
  name=''
  case $(os_type) in
    osx) name=$(hostname -s) ;;
    *) name=$(uname -n) ;;
  esac

  echo $name
}
host_ps1name()
{
  if [[ ${hostps1name:+1} != 1 ]]; then
    hostps1name=$(host_name)
    if [[ ${pscolors:+1} == 1 ]]; then
       hostps1name="%{$fg[blue]%}$hostps1name%{$reset_color%}"
    fi
  fi
  echo $hostps1name
}

user_ps1name()
{
  if [[ ${userps1name:+1} != 1 ]]; then
    case $(user_name) in
      mitch)
        userps1name='me'
        if [[ ${pscolors:+1} == 1 ]]; then
          userps1name="%{$fg[blue]%}$userps1name%{$reset_color%}"
        fi
        ;;
      root)
        userps1name='root'
        if [[ ${pscolors:+1} == 1 ]]; then
          userps1name="%{$fg[red]%}$userps1name%{$reset_color%}"
        fi
        ;;
      *)
        userps1name=$(user_name)
        if [[ ${pscolors:+1} == 1 ]]; then
          userps1name="%{$fg[cyan]%}$userps1name%{$reset_color%}"
        fi
        ;;
    esac
  fi
  echo $userps1name
}

# using who am i, see if our pty is owned by someone else.
user_ptyname()
{
  name=$(who am i | sed -e "s/[ ].*//1")
  [ ${name} == '' ] && name=$LOGNAME
  echo $name
}

ps1_user_host()
{
  echo "$(user_ps1name)@$(host_ps1name)"
}

ps1_special()
{
  am_i_root
  [ $? -eq 0 ] && echo '# ' || echo '$ '
}

ps1()
{
  echo "$(ps1_user_host) $(ps1_special)"
}

ostype=''
oskernel=''
osarch=''
osmajor=''
osminor=''
osversion=''
osuname_s=''
osrelease=''
osprefix=''
osreleasefile=''

# where /etc/*release files exist
archreleasefile='/etc/arch-release'
debianreleasefile='/etc/debian_version'
susereleasefile='/etc/SuSE-release'
redhatreleasefile='/etc/Redhat-release'
solarisreleasefile='/etc/release'
freebsdreleasefile='/etc/freebsd-update.conf'

os_release()
{
  case $(os_uname_s) in
    Linux) osrelease=$(cat $osreleasefile) ;;
    Darwin) osrelease=$(sw_vers -productVersion) ;;
    bsd) osrelease=$(uname -r) ;;
    *) osrelease='' ;;
  esac
  echo $osrelease
}

os_kernel()
{
  if [[ ${oskernel:+1} != 1 ]]; then
    oskernel=$(uname -r)
  fi
  echo $oskernel
}

os_arch()
{
  if [[ ${osarch:+1} != 1 ]]; then
    osarch=$(uname -m)
  fi
  echo $osarch
}

os_uname_s()
{
  if [[ ${os_uname_s:+1} != 1 ]]; then
    osuname_s=$(uname -s)
  fi
  echo $osuname_s
}

function os_type {
  if [[ ${ostype:+1} != 1 ]]; then
    if [[ -f $archreleasefile ]]; then
      ostype='arch'
      osreleasefile=$archreleasefile
    elif [[ -f $debianreleasefile ]]; then
      ostype='debian'
      osreleasefile=$debianreleasefile
    elif [[ -f $susereleasefile ]]; then
      ostype='suse'
      osreleasefile=$susereleasefile
    elif [[ -f $redhatreleasefile ]]; then
      ostype='redhat'
      osreleasefile=$redhatreleasefile
    elif [[ $(os_uname_s) == 'SunOS' ]]; then
      ostype='sun'
    elif [[ $(os_uname_s) == 'Darwin' ]]; then
      ostype='osx'
    elif [[ -f $freebsdreleasefile ]]; then
      ostype='bsd'
    else
      echo "No idea what os type this is."
    fi
  fi
  echo $ostype
}

os_major()
{
  if [[ ${osmajor:+1} != 1 ]]; then
    case $(os_type) in
      arch) osmajor='arch' ;;
      debian) osmajor=$(os_release | sed -e 's/\.[0-9]\{1\}//2') ;;
      suse)
        osmajor=$(os_release | grep 'VER' | sed -e 's/.*\=\ //g') ;;
      redhat) osmajor='zomg' ;;
      sun) osmajor=$(uname -r) ;;
      osx) osmajor=$(os_release | sed -e 's/\.[0-9]\{1\}//2') ;;
      bsd) osmajor=$(os_release | sed -e 's/\.*//') ;;
      *) osmajor='?'
    esac
  fi
  echo $osmajor
}

os_minor()
{
  if [[ ${osminor:+1} != 1 ]]; then
    case $(os_type) in
      arch) osminor='zomg' ;;
      debian) osminor=$(os_release | sed -e 's/[0-9]\.[0-9]\{1\}\.//1') ;;
      suse)
        osminor=$(os_release | grep 'PATCH' | sed -e 's/.*\=\ //g') ;;
      redhat) osminor='zomg' ;;
      sun) osminor=$(uname -r) ;;
      osx) osminor=$(os_release | sed -e 's/10\.[0-9]\{1\}\.//1') ;;
      bsd) osminor=$(os_release | sed -e 's/\d+\.[0-9]\{1\}\-//1') ;;
      *) osminor='?'
    esac
  fi
  echo $osminor
}

os_version()
{
  if [[ ${osversion:+1} != 1 ]]; then
    case $(os_type) in
      arch) osversion='zomg' ;;
      debian) osversion=$(os_release) ;;
      suse) osversion="${osmajor}u${osminor}" ;;
      redhat) osversion='zomg' ;;
      sun) osversion=$osmajor ;;
      osx) osversion=$(os_release) ;;
      bsd) osversion="${osmajor}.${osminor}" ;;
      *) osversion='wtf?' ;;
    esac
  fi
  echo $osversion
}

os_prefix()
{
  if [[ ${osprefix:+1} != 1 ]]; then
    case $(os_type) in
      osx) osprefix="$(os_major)-$(os_uname_s)-$(os_arch)" ;;
      *) osprefix="$(os_type)-$(os_uname_s)-$(os_arch)" ;;
    esac
  fi
  echo $osprefix
}

# setup the one thing we need for all of the functions.
os_type > /dev/null 2>&1
