{pkgs}: {
  allowUnfree = true;
  allowBroken = true;

  packageOverrides = pkgs: with pkgs; {
    pinentry = pkgs.pinentry.override {
      gtk2 = null;
      qt4 = null;
      ncurses = null;
    };
    gnupg = pkgs.gnupg.override {
      x11Support = false;
      pinentry = true;
    };
    youtube-dl = pkgs.youtube-dl.override {
      pandoc = null;
    };

    # haskellPackages = haskellPackages.override {
    #   extension = self : super : {
    #     cabal = pkgs.haskellPackages.cabalNoTest;
    #   };
    # };

    default = with pkgs; buildEnv {

      name = "default";

      paths = [
        ansible
        ack
        aria
        iperf
        cacert
        curl
        clang
        clang-analyzer
        diffutils
        patchutils
        gitAndTools.gitFull
        gitAndTools.git-extras
        bazaarTools
        mercurial
        subversionClient
        gist
        mercurial
        docbook5
        entr
        emacs
        gnupg1compat
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
        imagemagick
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
        p7zip
        unrar
        watch
        nox
        mutt
        duply
        zsh
        pylint
        python27Packages.howdoi
        python27Packages.youtube-dl
        python27Packages.pyflakes
        python27Packages.flake8
        python27Packages.virtualenv
        python27Packages.pip
#        xhyve        compiles normally, figure out hypervisor framework issue
#        lastpass-cli no worky on osx TODO fix this it works on homebrew
      ];
    };
    env_hs =
      pkgs.haskell.packages.ghc7102.ghcWithPackages
          (haskellPackages: with haskellPackages; [
              alex
              happy
              bake
              cabal-dependency-licenses
              cabal-install
              cabal-meta
              ghc-core
              ghc-mod
              hasktags
              hindent
              hoogle
              hspec
              idris
              pandoc
              shake
              ShellCheck
              stack
              stylish-haskell
              nats
              transformers-compat
              ]
          );
  };
}
