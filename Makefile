VERSION    := 0.1
PREFIX     ?= 
LIB_FILES  := libusralpine.sh\
			  libtest.sh

SBIN_FILES := setup-consolefont\
	      setup-networking\
	      setup-networking-with-wifi\
	      setup-networking-with-wifi-only\
	      setup-alsa\
	      setup-alsa-pulseaudio\
	      setup-pipewire\
	      setup-doas\
	      setup-bluetooth-pipewire\
	      setup-udevil\
		  setup-test

SCRIPTS    := $(LIB_FILES) $(SBIN_FILES)

DESC="Alpine user configuration scripts inspired by alpine-conf by SirMetathyst"
WWW="https://github.com/SirMetathyst/alpine-user-conf"

SED         := sed
SED_REPLACE := -e 's:@VERSION@:$(VERSION):g' \
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
