DOTDEE=update-dotdee
STOW=xstow
PWD=$(shell pwd)
STOWOPTS=-target $(HOME) -d $(PWD)
DOTGITCONFIG=~/.gitconfig
DOTPROFILE=~/.profile

.PHONY: common emacs git ruby haskell perl tmux vim zsh list home osx linux ws

home: $(DOTGITCONFIG) $(DOTPROFILE)
	$(DOTDEE) $(DOTPROFILE)

ws: common git ruby haskell perl tmux vim zsh home

all: home

$(DOTGITCONFIG):
	touch $(DOTGITCONFIG)
	$(DOTDEE) $(DOTGITCONFIG)

clean:
	$(STOW) $(STOWOPTS) -D common emacs git ruby haskell perl tmux vim zsh osx

$(DOTPROFILE):
	touch $(DOTPROFILE)
	$(DOTDEE) $(DOTPROFILE)

common:
	$(STOW) $(STOWOPTS) common

# Specific stows, nothing special
git:
	$(STOW) $(STOWOPTS) git

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
