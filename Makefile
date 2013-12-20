PACKAGE=gsport
VERSION=0.3.0
DIST=$(PACKAGE)-$(VERSION)
DISTDIR=./$(DIST)

gsport:
	-rm src/vars
	ln -s vars_pi src/vars
	$(MAKE) -C src
	-rm src/vars
	ln -s vars_fbrpilinux src/vars
	$(MAKE) -C src

clean:
	-rm $(PACKAGE)_*
	-rm *.deb
	-rm -rf $(DISTDIR)
	-rm *.tar.gz
	-rm src/vars

install:
	cp gsportx $(DESTDIR)/usr/bin
	cp gsportfb $(DESTDIR)/usr/bin
	cp -R ./files/* $(DESTDIR)

dist:
	$(MAKE) clean
	mkdir $(DISTDIR)
	-chmod 777 $(DISTDIR)
	cp COPYING.txt $(DISTDIR)
	cp config.template $(DISTDIR)
	cp GSport.html $(DISTDIR)
	cp Makefile $(DISTDIR)
	cp -R ./debian $(DISTDIR)
	cp -R ./doc $(DISTDIR)
	cp -R ./files $(DISTDIR)
	cp -R ./src $(DISTDIR)
	cp -R ./lib $(DISTDIR)
	-chmod -R a+r $(DISTDIR)
	tar czf $(DIST).tar.gz $(DISTDIR)

deb:
	$(MAKE) dist
	mv $(DIST).tar.gz $(PACKAGE)_$(VERSION).orig.tar.gz
	cd $(DIST); debuild -us -uc
	rm $(PACKAGE)_$(VERSION).orig.tar.gz
