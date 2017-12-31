# Makefile is here to make it possible to use this whole shebang
# outside of emacs.
DEST:=$(HOME)
LAST:=$(shell cat .last || echo 0)
NEXT:=$(shell l=$(LAST); ((l=l+1)); echo $$l)
NEXTGEN:=$(PWD)/generation/$(NEXT)
LASTGEN:=$(PWD)/generation/$(LAST)
TANGLERS:=$(shell ls -d *.org)
GEN:=$(LAST)
OPTS:=
# OSX uses scutil --get ComputerName
# uname -n && hostname -s can return dhcp addresses
# which aren't stable.
HOST=$(shell echo "$$(scutil --get ComputerName || uname -n)")
USEROPTS:=$(OPTS):$(HOST)
NAME:=default

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

.PHONY: tangle-next
tangle-next:
	@echo Tangling for hostname $(HOST)
	$(MAKE) tangle
	$(MAKE) generation
	$(MAKE) next
	$(MAKE) copy GEN=$(NEXT)
	@echo $(NEXT) > .last
	@echo Tangled for hostname $(HOST)

copy:
	cd $(PWD)/generation/$(GEN) && find . -type f -exec rm -f $(DEST)/{} \;
	cd $(PWD)/generation/$(GEN) && cp -r . $(DEST)

.PHONY: tangle
tangle: tmp
	USEROPTS=$(USEROPTS) /usr/bin/env emacs --script ./etangle $(TANGLERS)

clean:
	-rm -fr tmp

nuke: clean
	-rm -fr .last generation

.PHONY: option
option:
	echo "(setq $(NAME)-p t)" > options/$(NAME).el
	echo "(setq $(NAME)-p nil)" > options/no-$(NAME).el
