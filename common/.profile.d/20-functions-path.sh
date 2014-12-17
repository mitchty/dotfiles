# common/.profile.d/20-functions-path.sh
# cat out a : separated env variable
# variable is the parameter
cat_env()
{
  set | grep '^'"$1"'=' > /dev/null 2>&1 && eval "echo \$$1" | tr ':' '
' | awk '!/^\s+$/' | awk '!/^$/'
}

# Convert a line delimited input to : delimited
to_env()
{
  awk '!a[$0]++' < /dev/stdin | tr -s '
' ':' | sed -e 's/\:$//' | awk 'NF > 0'
}

# Unshift a new value onto the env var
# first arg is ENV second is value to unshift
# basically prepend value to the ENV variable
unshift_env()
{
  new=$(eval "echo $2; echo \$$1" | to_env)
  eval "$1=${new}; export $1"
}

# Opposite of above, but echos what was shifted off
shift_env()
{
  first=$(cat_env "$1" | head -n 1)
  rest=$(cat_env "$1" | awk '{if (NR!=1) {print}}' | to_env)
  eval "$1=$rest; export $1"
  echo "${first}"
}

# push $2 to $1 on the variable
push_env()
{
  have=$(cat_env "$1")
  new=$(printf "%s
%s" "$have" "$2" | to_env)
  eval "$1=$new; export $1"
}
