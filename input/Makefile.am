AM_CPPFLAGS =  \
	@FREETYPE_CFLAGS@ \
	-I$(top_srcdir)/include

noinst_PROGRAMS = input

input_SOURCES = \
	input.c \
	gfx.c \
	io.c \
	inputd.c \
	text.c \
	fb_display.c \
	resize.c \
	pngw.cpp \
	png_helper.cpp

input_LDADD = \
	@FREETYPE_LIBS@ \
	@PNG_LIBS@

install-exec-local:
	install -d $(DESTDIR)/bin
	install -m 0755 input $(DESTDIR)/bin/input
