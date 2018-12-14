# $Revision: 117 $
VERSION=2.8

DEBUG=-g -W -pedantic #-pg #-fprofile-arcs
LDFLAGS=$(DEBUG)
CXXFLAGS+=-O2 -Wall -DVERSION=\"$(VERSION)\" $(DEBUG)

OBJS=main.o USBaccessBasic.o USBaccess.o error.o

all: clewarecontrol

clewarecontrol: $(OBJS)
	$(CXX) -Wall -W $(OBJS) $(LDFLAGS) -o clewarecontrol

install: clewarecontrol
	cp clewarecontrol $(DESTDIR)/usr/bin

uninstall: clean
	rm -f $(DESTDIR)/usr/bin/clewarecontrol
	rm -f $(DESTDIR)/usr/share/man/man1/clewarecontrol.1.gz

clean:
	rm -rf $(OBJS) clewarecontrol core gmon.out *.da build cleware_wrap.cxx _cleware.so *.o cleware.so

package: clean
	# source package
	rm -rf clewarecontrol-$(VERSION)*
	mkdir clewarecontrol-$(VERSION)
	cp -a *.c* *.h Makefile clewarecontrol-$(VERSION)
	tar czf clewarecontrol-$(VERSION).tgz clewarecontrol-$(VERSION)
	rm -rf clewarecontrol-$(VERSION)

check:
	cppcheck -v --enable=all --inconclusive -I. . 2> err.txt
