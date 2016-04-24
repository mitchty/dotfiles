# Makefile is here to make it possible to use this whole shebang
# outside of emacs.
.PHONY: tangle tangle-next
DEST:=$(HOME)
LAST:=$(shell cat .last || echo 0)
NEXT:=$(shell l=$(LAST); ((l=l+1)); echo $$l)
NEXTGEN:=$(PWD)/generation/$(NEXT)
LASTGEN:=$(PWD)/generation/$(LAST)
CUSTOM:=
TANGLERS:=$(CUSTOM) readme.org emacs.org tmux.org git.org x.org nix.org
GEN:=$(LAST)
OPTIONS:=

INSTALLDIRS=tmp $(NEXTGEN) $(LASTGEN) generation/$(GEN)

all: clean tangle-next

$(INSTALLDIRS):
	install -dm755 $@

generation: $(NEXTGEN) $(LASTGEN) tmp
	cd tmp && cp -av . $(NEXTGEN)

check:

diff: generation/$(GEN)
	./ddiff $(PWD)/generation/$(GEN) $(DEST)

next: diff

tangle-next:
	$(MAKE) tangle
	$(MAKE) generation
	$(MAKE) next
	$(MAKE) copy GEN=$(NEXT)
	@echo $(NEXT) > .last

copy:
	cd $(PWD)/generation/$(GEN) && find . -type f -exec rm -f $(DEST)/{} \;
	cd $(PWD)/generation/$(GEN) && cp -r . $(DEST)

tangle: tmp
	/usr/bin/env emacs --script ./etangle $(TANGLERS)
	@echo

clean:
	-rm -fr tmp

nuke: clean
	-rm -fr .last generation
