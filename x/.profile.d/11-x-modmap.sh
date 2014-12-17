# x/.profile.d/11-x-modmap.sh
# x/.profile.d/11-x-modmap.sh
modmap
{
	[ -f "${HOME}/.Xmodmap" ] && xmodmap "${HOME}/.Xmodmap"
}
