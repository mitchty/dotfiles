{ pkgs }: {
  packageOverrides = pkgs_: with pkgs_; {
    default = with pkgs; buildEnv {
      name = "default";
      paths = [
        ansible
        ack
        aria
        iperf
        curl
        clang
        git
        gist
        mercurial
        docbook5
        entr
        emacs
        gnupg1
        gnutar
        gnumake
        sloccount
        cloc
        less
        multitail
        rlwrap
        gdbm
        mosh
        htop
        keychain
        silver-searcher
        aspell
        aspellDicts.en
        openssl
        pigz
        xz
        pv
        postgresql
        python27Packages.youtube-dl
        readline
        rsync
        sqlite
        texLiveFull
        tmux
        tree
        wget
        wakelan
        unzip
        zip
        upx
      ];
    };
    myHaskellEnv =
      pkgs_.haskell.packages.ghc7102.ghcWithPackages
          (haskellPackages: with haskellPackages; [
              aeson
              arrows
              async
              bake
              cabal-dependency-licenses
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
              stack
              stylish-haskell
              wreq
              ]
          );
  };
  allowUnfree = true;
  allowBroken = true;
}
