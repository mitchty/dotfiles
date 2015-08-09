DOTDEE=update-dotdee
STOW=xstow
PWD=$(shell pwd)
STOWOPTS=-f -target $(HOME) -d $(PWD) 
DOTGITCONFIG=~/.gitconfig
DOTPROFILE=~/.profile

.PHONY: mosh common emacs git ruby haskell perl tmux vim zsh list osx linux ws nix

all: common

common: $(DOTPROFILE)

ws: emacs nix mosh git ruby haskell perl tmux vim zsh common

$(DOTGITCONFIG):
	$(STOW) $(STOWOPTS) git
	touch $(DOTGITCONFIG)
	$(DOTDEE) $(DOTGITCONFIG)

clean:
	$(STOW) $(STOWOPTS) -D mosh common emacs git ruby haskell perl tmux vim zsh osx
	-rm $(DOTGITCONFIG) $(DOTPROFILE)
	-rm -fr $(DOTCONFIG).d $(DOTPROFILE).d
	-find $(PWD) -type f -name ".checksum" -exec rm {} \;

$(DOTPROFILE):
	$(STOW) $(STOWOPTS) common
	touch $(DOTPROFILE)
	$(DOTDEE) $(DOTPROFILE)

git: $(DOTGITCONFIG)

emacs:
	$(STOW) $(STOWOPTS) emacs # $@?

osx:
	$(STOW) $(STOWOPTS) osx

linux:
	$(STOW) $(STOWOPTS) linux

x:
	$(STOW) $(STOWOPTS) x

ruby:
	$(STOW) $(STOWOPTS) ruby

mosh:
	$(STOW) $(STOWOPTS) mosh

zsh:
	$(STOW) $(STOWOPTS) zsh

tmux:
	$(STOW) $(STOWOPTS) tmux

vim:
	$(STOW) $(STOWOPTS) vim

haskell:
	$(STOW) $(STOWOPTS) haskell

perl:
	$(STOW) $(STOWOPTS) perl

nix:
	$(STOW) $(STOWOPTS) nix
