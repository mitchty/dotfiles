# nix.profile.d/99-final-nix.sh

# The nix installer put something like this into the .profile.
# BAD INSTALLER NO COOKIE!
if [ -e ${HOME}/.nix-profile/etc/profile.d/nix.sh ]; then
    . ${HOME}/.nix-profile/etc/profile.d/nix.sh;
    export NIX_PATH=${HOME}/Developer/github.com/NixOS/nixpkgs:nixpkgs=${HOME}/Developer/github.com/NixOS/nixpkgs
fi