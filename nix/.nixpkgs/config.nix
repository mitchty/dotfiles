{
  packageOverrides = super: let self = super.pkgs; in {
    myHaskellEnv =
      self.haskell.packages.ghc7102.ghcWithPackages
          (haskellPackages: with haskellPackages; [
              aeson
              arrows
              async
              bake
              cabal-install
              case-insensitive
              ghc-mod
              hindent
              hoogle
              hspec
              inline-c
              pandoc
              shake
              ShellCheck
              Spock
              stack
              stylish-haskell
              regex-posix
              wreq
              ]
          );
  };
}
