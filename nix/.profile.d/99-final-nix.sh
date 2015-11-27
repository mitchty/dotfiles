# nix/profile.d/99-final-nix.sh

nix_env_setup()
{
  # The nix installer put something like this into the .profile.
  # BAD INSTALLER NO COOKIE!
  if [ -e ${HOME}/.nix-profile/etc/profile.d/nix.sh ]; then
      . ${HOME}/.nix-profile/etc/profile.d/nix.sh;
      export NIX_PATH=${HOME}/src/github.com/NixOS/nixpkgs:nixpkgs=${HOME}/src/github.com/NixOS/nixpkgs
      export NIX_CFLAGS_COMPILE="-idirafter /usr/include"
      export NIX_CFLAGS_LINK="-L/usr/lib"

      NIX_GHC=$(type -p ghc > /dev/null 2>&1)
      if [ -n "$NIX_GHC" ]; then
          eval $(grep export "$NIX_GHC")
      fi
  fi

  nr()
  {
    nix-shell --run "$(echo $@)"
  }
}

nix_env_setup
