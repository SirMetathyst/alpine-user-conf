VERSION    := 0.1

LIB_FILES  := libusralpine.sh

DEST := /usr/bin

SETUP_FILES := setup-consolefont\
	      setup-pipewire\
	      setup-doas\
	      setup-udevil\
		  setup-dbus\
		  setup-sway\
		  setup-flatpak\
		  setup-seatd\
		  setup-desktop

SCRIPTS    := $(LIB_FILES) $(SETUP_FILES)

DESC="Alpine user configuration scripts inspired by alpine-conf by SirMetathyst"
WWW="https://github.com/SirMetathyst/alpine-user-conf"

SED         := sed
SED_REPLACE := -e 's:@VERSION@:$(VERSION):g' \
				-e 's:@PROGRAM_DIR@:/$(DEST):g'\
				-e 's:@LIB_DIR@:/lib:g'\

.SUFFIXES: .sh.in .in
%.sh: %.sh.in
	${SED} ${SED_REPLACE} ${SED_EXTRA} $< > $@

%: %.in
	${SED} ${SED_REPLACE} ${SED_EXTRA} $< > $@

.PHONY: all clean install uninstall
all: $(SCRIPTS) 

install:  $(SETUP_FILES) $(LIB_FILES)
	install -m 755 -d /$(DEST)
	install -m 755 $(SETUP_FILES) /$(DEST)
	install -m 755 -d /lib
	install -m 755 $(LIB_FILES) /lib

uninstall:
	for i in $(SETUP_FILES); do \
		rm -f "/$(DEST)/$$i";\
	done
	for i in $(LIB_FILES); do \
		rm -f "/lib/$$i";\
	done

clean:
	rm -rf $(SCRIPTS)
