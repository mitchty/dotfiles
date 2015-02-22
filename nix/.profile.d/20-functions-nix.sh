# nix/.profile.d/20-functions-nix.sh
mk_nix_shell()
{
  cabal2nix --sha256="0" . \
    | perl -0777 -p -e 's/{.+}:/{ haskellPackages ? (import <nixpkgs> {}).haskellPackages }:/s' \
    | sed -E -e 's/(cabal\.mkDerivation)/with haskellPackages; \1/' -e 'sXsha256 = "0";Xsrc = "./.";X' \
          > shell.nix;
}
