AM_CPPFLAGS = -I$(srcdir)/../lib -I$(top_srcdir)/include

noinst_PROGRAMS = sokoban

sokoban_SOURCES = board.c somain.c

sokoban_LDFLAGS = -rpath $(PLUGINDIR) -R$(TARGET_PLUGINDIR)

sokoban_LDADD = -lfx2

install-exec-local:
	install -d $(DESTDIR)$(PLUGINDIR)
	install -d $(DESTDIR)$(CONFIGDIR)
	$(LIBTOOL) --mode=install install --strip-program=$(STRIP) -s -m 0755 sokoban $(DESTDIR)$(PLUGINDIR)/sokoban.so
	install -m 0644 $(srcdir)/sokoban.cfg $(DESTDIR)$(PLUGINDIR)
	install -d $(DESTDIR)$(DATADIR)/sokoban
	install -m 0644 $(srcdir)/*.xsb $(DESTDIR)$(DATADIR)/sokoban
	install -m 0644 $(srcdir)/sokoban_hint.png $(DESTDIR)$(PLUGINDIR)
