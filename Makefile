VERSION    := 0.1

LIB_FILES  := libusralpine.sh

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

.PHONY: all clean install uninstall
all: $(SCRIPTS) 

install:  $(SETUP_FILES) $(LIB_FILES)
	install -m 755 -d /usr/bin
	install -m 755 $(SETUP_FILES) /usr/bin
	install -m 755 -d /lib
	install -m 755 $(LIB_FILES) /lib

uninstall:
	for i in $(SETUP_FILES); do \
		rm -f "/usr/bin/$$i";\
	done
	for i in $(LIB_FILES); do \
		rm -f "/lib/$$i";\
	done

clean:
	rm -rf $(SCRIPTS)
