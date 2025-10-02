Version=18.0

PREFIX = /usr/local

CFG = $(wildcard cfg/*.cfg)

MTHEME = \
	$(wildcard kamarada-live/*.png) \
	kamarada-live/theme.txt \
	kamarada-live/*.pf2

MICONS= $(wildcard kamarada-live/icons/*.png)

TZ = $(wildcard tz/*)

LOCALES = $(wildcard locales/*)

install_common:
	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/cfg
	install -m0644 ${CFG} $(DESTDIR)$(PREFIX)/share/grub/cfg

	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/tz
	install -m0644 ${TZ} $(DESTDIR)$(PREFIX)/share/grub/tz

	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/locales
	install -m0644 ${LOCALES} $(DESTDIR)$(PREFIX)/share/grub/locales

uninstall_common:
	for f in ${CFG}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/cfg/$$f; done
	for f in ${TZ}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/tz/$$f; done
	for f in ${LOCALES}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/locales/$$f; done

install_kamarada:
	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/themes/kamarada-live
	install -m0644 ${MTHEME} $(DESTDIR)$(PREFIX)/share/grub/themes/kamarada-live

	install -dm0755 $(DESTDIR)$(PREFIX)/share/grub/themes/kamarada-live/icons
	install -m0644 ${MICONS} $(DESTDIR)$(PREFIX)/share/grub/themes/kamarada-live/icons

uninstall_kamarada:
	for f in ${MTHEME}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/theme/kamarada-live/$$f; done
	for f in ${MICONS}; do rm -f $(DESTDIR)$(PREFIX)/share/grub/theme/kamarada-live/icons/$$f; done

install: install_common install_kamarada

uninstall: uninstall_common uninstall_kamarada

dist:
	git archive --format=tar --prefix=grub-theme-$(Version)/ $(Version) | gzip -9 > grub-theme-$(Version).tar.gz
	gpg --detach-sign --use-agent grub-theme-$(Version).tar.gz

.PHONY: install uninstall dist
