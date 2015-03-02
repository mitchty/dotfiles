# common/.profile.d/20-functions.sh
# Remove a line matched in $HOME/.ssh/known_hosts for when there are legit
# host key changes.
nukehost()
{
  if [ -z "$1" ]; then
    echo "Usage: nukehost <hostname>"
    echo "       Removes <hostname> from ssh known_host file."
  else
    sed -i -e "/$1/d" ~/.ssh/known_hosts
  fi
}

# Cheap copy function to make copying a file via ssh from one host
# to another less painful, use pipeviewer to give some idea as to progress.
ssh-copyfile()
{
  if [ -z "$1" -o -z "$2" ]; then
    echo "Usage: copy source:/file/location destination:/file/location"
  else
    srchost="$(echo "$1" | awk -F: '{print $1}')"
    src="$(echo "$1" | awk -F: '{print $2}')"
    dsthost="$(echo "$2" | awk -F: '{print $1}')"
    dst="$(echo "$2" | awk -F: '{print $2}')"
    size=$(ssh "$srchost" du -hs "$src" 2> /dev/null)
    size=$(echo "${size}" | awk '{print $1}')
    echo "Copying $size to $dst"
    ssh "$srchost" "/bin/cat \$src" 2> /dev/null | pv -cb -N copied - | ssh "$dsthost" "/bin/cat - > \$dst" 2> /dev/null
  fi
}

# extract function to automate being lazy at extracting archives.
extract()
{
  if [ -f "$1" ]; then
    case ${1} in
      *.tar.bz2|*.tbz2|*.tbz)  bunzip2 -c "$1" | tar xvf -;;
      *.tar.gz|*.tgz)          gunzip -c "$1" | tar xvf -;;
      *.tz|*.tar.z)            zcat "$1" | tar xvf -;;
      *.tar.xz|*.txz|*.tpxz)   xz -d -c "$1" | tar xvf -;;
      *.bz2)                   bunzip2 "$1";;
      *.gz)                    gunzip "$1";;
      *.jar|*.zip)             unzip "$1";;
      *.rar)                   unrar x "$1";;
      *.tar)                   tar -xvf "$1";;
      *.z)                     uncompress "$1";;
      *.rpm)                   rpm2cpio "$1" | cpio -idv;;
      *)                       echo "Unable to extract <$1> Unknown extension."
    esac
  else
    print "File <$1> does not exist."
  fi
}

# Tcsh compatibility so I can be a lazy bastard and paste things directly
# if/when I need to.
setenv()
{
  export "$1=$2"
}

# Just to be lazy, set/unset the DEBUG env variable used in my scripts
debug()
{
  if [ -z "$DEBUG" ]; then
    if [ -z "$1" ]; then
      echo Setting DEBUG to "$1"
      setenv DEBUG "$1"
    else
      echo Setting DEBUG to default
      setenv DEBUG default
    fi
  else
    echo Unsetting DEBUG
    unset DEBUG
  fi
}

login_shell()
{
  [ "$-" = "*i*" ]
}

# Yeah, sick of using the web browser for this crap
# Use is NUM FROM TO and boom get the currency converted from goggle.
cconv()
{
  curl -L --silent\
       "https://www.google.com/finance/converter?a=$1&from=$2&to=$3"
         | grep converter_result\
             | perl -pe 's|[<]\w+ \w+[=]\w+[>]||g;' -e 's|[<][/]span[>]||'
}
