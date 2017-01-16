AM_CPPFLAGS =  \
	@FREETYPE_CFLAGS@ \
	-I$(top_srcdir)/include

noinst_PROGRAMS = shellexec

shellexec_SOURCES = \
	shellexec.c \
	text.c \
	gfx.c \
	io.c \
	fb_display.c \
	resize.c \
	pngw.cpp \
	png_helper.cpp

shellexec_LDADD = \
	@FREETYPE_LIBS@ \
	@PNG_LIBS@

install-exec-local:
	install -d $(DESTDIR)$(PLUGINDIR)
	install -d $(DESTDIR)$(CONFIGDIR)
	install -d $(DESTDIR)/bin
	install -m 0755 shellexec $(DESTDIR)$(PLUGINDIR)/shellexec.so
	install -m 0644 $(srcdir)/shellexec.conf $(DESTDIR)$(CONFIGDIR)
	install -m 0644 $(srcdir)/shellexec.cfg $(DESTDIR)$(PLUGINDIR)
	ln -sf $(PLUGINDIR)/shellexec.so $(DESTDIR)/bin/shellexec
