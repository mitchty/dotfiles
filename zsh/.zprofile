emulate sh
source ~/.profile
emulate zsh

# zsh does this differently
login_shell()
{
  [[ -o login ]]
}
