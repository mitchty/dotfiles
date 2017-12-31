# Makefile is here to make it possible to use this whole shebang
# outside of emacs.
#
# TODO: wrap this stuff into a script maybe?
DEST:=$(HOME)
LAST!=cat .last || echo 0
NEXT!=l=$(LAST); ((l=l+1)); echo $$l
NEXTGEN:=$(PWD)/generation/$(NEXT)
LASTGEN:=$(PWD)/generation/$(LAST)
TANGLERS:=$(wildcard *.org)
GEN:=$(LAST)
OPTS:=
# OSX uses scutil --get ComputerName
# uname -n && hostname -s can return dhcp addresses
# which aren't stable.
HOST!=scutil --get ComputerName || uname -n
USEROPTS:=$(OPTS):$(HOST)

# Make it easier to check if a variable is defined or not
# params:
# variable name
# optional message to print if variable is not set
check_defined = \
    $(strip $(foreach 1,$1, \
        $(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
    $(if $(value $1),, \
      $(error Undefined variable $1$(if $2, ($2))))

INSTALLDIRS=tmp $(NEXTGEN) $(LASTGEN) generation/$(GEN)

all: clean tangle-next

$(INSTALLDIRS):
	install -dm755 $@

generation: $(NEXTGEN) $(LASTGEN) tmp
	cd tmp && cp -av . $(NEXTGEN)

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

# TODO: is this gnu diff output... only or not? note: wip until i've
# tested on bsd make etc...

.PHONY: removed
removed:
	$(call check_defined, OLD, generation to compare removed files against)
	$(call check_defined, NEW, generation to compare removed files to)
	@diff -bur generation/$(OLD) generation/$(NEW) 2>&1 | grep 'Only in generation/'$(OLD) | sed -e 's|Only in ||' -e 's|.*[:] ||'

clean:
	-rm -fr tmp

nuke: clean
	-rm -fr .last generation

.PHONY: option
option:
	$(call check_defined, NAME, predicate NAME to define in option files. Note: without -p i.e. NAME-p = t and no-NAME-p = nil)
	echo "(setq $(NAME)-p t)" > options/$(NAME).el
	echo "(setq $(NAME)-p nil)" > options/no-$(NAME).el
