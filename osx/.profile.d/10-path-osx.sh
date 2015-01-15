# osx/.profile.d/10-path-osx.sh
osx_release=$(sw_vers -productVersion | sed -e 's/\.[0-9]\{1\}//2')
brew_home=/usr/local/brew/${osx_release}
PATH="${brew_home}/bin:/usr/local/bin:${PATH}"
export PATH
