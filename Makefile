# Makefile is here to make it possible to use this whole shebang
# outside of emacs.
.PHONY: tangle tangle-next
DEST:=$(HOME)
LAST:=$(shell cat last || echo 0)
NEXT:=$(shell l=$(LAST); ((l=l+1)); echo $$l)
NEXTGEN:=$(PWD)/generation/$(NEXT)
LASTGEN:=$(PWD)/generation/$(LAST)
TANGLERS:=readme.org
GEN:=$(LAST)

all: clean tangle-next

tmp:
	install -dm755 $@
	$(MAKE) emacs

#special target to handle emacs configuration
emacs:
	install -dm755 tmp/.emacs.d
	install -m400 init.el tmp/emacs.d/init.el
	install -m400 emacs.org tmp/emacs.d/emacs.org

$(NEXTGEN):
	install -dm755 $@

$(LASTGEN):
	install -dm755 $@

generation/$(GEN):
	install -dm755 $@

generation: $(NEXTGEN) $(LASTGEN)
	cd tmp && cp -r . $(NEXTGEN)

check:

diff: generation/$(GEN)
	./ddiff $(PWD)/generation/$(GEN) $(DEST)

next: diff

tangle-next:
	$(MAKE) tangle
	$(MAKE) generation
	$(MAKE) next
	$(MAKE) copy
	@echo $(NEXT) > last

copy:
	cd $(PWD)/generation/$(GEN) && cp -r . $(DEST)

tangle: tmp
	./etangle $(TANGLERS)
	@echo

clean:
	-rm -fr tmp

nuke: clean
	-rm -fr last generation
