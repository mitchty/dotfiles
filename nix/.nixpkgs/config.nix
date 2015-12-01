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
        clang-analyzer
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
        pinentry
        pbzip2
        pigz
        pv
        postgresql
        readline
        rsync
        sqlite
        texLiveFull
        tmux
        tree
        wget
        wakelan
        unzip
        upx
        xz
        zip
        nox
#        xhyve        compiles normally, figure out hypervisor framework issue
#        lastpass-cli no worky on osx TODO fix this it works on homebrew
        pylint
        python27Packages.howdoi
#        python27Packages.youtube-dl
        python27Packages.pyflakes
        python27Packages.flake8
        python27Packages.virtualenv
        python27Packages.pip
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
