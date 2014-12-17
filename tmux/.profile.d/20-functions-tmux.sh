# tmux/.profile.d/20-functions-tmux.sh
t
{
  if [ -z "$1" ]; then
    echo "Supply a tmux session name to connect to/create"
  else
    tmux has-session -t "$1" 2>/dev/null
    [ $? != 0 ] && tmux new-session -d -s "$1"
    tmux attach-session -d -t "$1"
  fi
}
