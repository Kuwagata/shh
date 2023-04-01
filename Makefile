PREFIX ?= /usr
DESTDIR ?=
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/share/man

SRC_FILES := $(wildcard src/*)
MAN_FILES := $(wildcard man/man1/*.1)

all:
	@echo "Use \"make install\"."

install:
	@install -v -d "$(DESTDIR)$(MANDIR)/man1" && \
		install -m 0644 -v -t "$(DESTDIR)$(MANDIR)/man1" $(MAN_FILES)
	@install -v -d "$(DESTDIR)$(BINDIR)/" && \
		install -m 0755 -v -t "$(DESTDIR)$(BINDIR)" $(SRC_FILES)

uninstall:
	@rm -vrf $(addprefix $(DESTDIR)$(MANDIR)/man1/,$(notdir $(MAN_FILES)))
	@rm -vrf $(addprefix $(DESTDIR)$(BINDIR)/,$(notdir $(SRC_FILES)))

.PHONY: install uninstall
