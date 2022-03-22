VERSION    := 0.1
PREFIX     ?= 
LIB_FILES  := libusralpine.sh
SBIN_FILES := setup-consolefont\
	      setup-networking\
	      setup-networking-with-wifi\
	      setup-networking-with-wifi-only\
	      setup-alsa\
	      setup-alsa-pulseaudio\
	      setup-pipewire

SCRIPTS    := $(LIB_FILES) $(SBIN_FILES)



GET_REV := $(shell test -d .git && git describe || echo exported)
ifneq ($(GIT_REV), exported)
	FULL_VERSION := $(patsubst $(PACKAGE)-%,%,$(GET_REV))
	FULL_VERSION := $(patsubst v%,%,$(FULL_VERSION))
else
	FULL_VERSION := $(VERSION)
endif

DESC="Alpine user configuration scripts based on alpine-conf by SirMetathyst"
WWW="https://github.com/SirMetathyst/alpine-user-conf"

SED         := sed
SED_REPLACE := -e 's:@VERSION@:$(FULL_VERSION):g' \
	       -e 's:@PREFIX@:$(PREFIX):g'

.SUFFIXES: .sh.in .in
%.sh: %.sh.in
	${SED} ${SED_REPLACE} ${SED_EXTRA} $< > $@

%: %.in
	${SED} ${SED_REPLACE} ${SED_EXTRA} $< > $@

.PHONY: all clean install uninstall
all: $(SCRIPTS) $(BIN_FILES)

install: $(BIN_FILES) $(SBIN_FILES) $(LIB_FILES)
	install -m 755 -d $(DESTDIR)/$(PREFIX)/sbin
	install -m 755 $(SBIN_FILES) $(DESTDIR)/$(PREFIX)/sbin
	install -m 755 -d $(DESTDIR)/$(PREFIX)/lib
	install -m 755 $(LIB_FILES) $(DESTDIR)/$(PREFIX)/lib

uninstall:
	for i in $(SBIN_FILES); do \
		rm -f "$(DESTDIR)/$(PREFIX)/sbin/$$i";\
	done
	for i in $(LIB_FILES); do \
		rm -f "$(DESTDIR)/$(PREFIX)/lib/$$i";\
	done

clean:
	rm -rf $(SCRIPTS) $(SBIN_FILES)
