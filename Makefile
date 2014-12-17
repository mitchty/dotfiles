DOTDEE=update-dotdee
STOW=xstow
STOWOPTS=-f
DOTGIT=.gitconfig
DOTPRO=.profile
GITCONFIG=git/.gitconfig
GITCONFIGDOTDEE=$(GITCONFIG).d
GITCONFIGCKSUM=$(GITCONFIGDOTDEE)/.checksum
DOTPROFILE=common/.profile
DOTPROFILEDOTDEE=$(DOTPROFILE).d
DOTPROFILECKSUM=$(DOTPROFILEDOTDEE)/.checksum
PWD=$(shell pwd)

.PHONY: common emacs git ruby haskell perl tmux vim zsh list home osx linux ws

home: dotprofile
	$(DOTDEE) $(PWD)/../$(DOTPRO)


ws: common emacs git ruby haskell perl tmux vim zsh home

all: home

dotprofile: $(DOTPROFILECKSUM)

gitconfig: $(GITCONFIGCKSUM)

$(GITCONFIG):
	touch $(GITCONFIG)

$(GITCONFIGCKSUM): $(GITCONFIG)
	$(DOTDEE) $(GITCONFIG)

list:
	echo common emacs git ruby haskell perl tmux vim zsh

clean:
	$(STOW) -D common emacs git ruby haskell perl tmux vim zsh osx
	-rm $(GITCONFIG) $(GITCONFIGCKSUM) $(DOTPROFILE) $(DOTPROFILECKSUM)

gitconfig: $(GITCONFIG)

$(DOTPROFILE):
	touch $(DOTPROFILE)

$(DOTPROFILECKSUM): $(DOTPROFILE)
	$(DOTDEE) $(DOTPROFILE)

common: $(DOTPROFILECKSUM)
	$(STOW) $(STOWOPTS) common

# Specific stows, nothing special
git: gitconfig
	$(STOW) git
	$(DOTDEE) $(PWD)/../$(DOTGIT)

emacs:
	$(STOW) emacs # $@?

osx:
	$(STOW) osx

linux:
	$(STOW) linux

x:
	$(STOW) x

ruby:
	$(STOW) ruby

zsh:
	$(STOW) zsh

vim:
	$(STOW) vim

haskell:
	$(STOW) haskell

perl:
	$(STOW) perl
