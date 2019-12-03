AUTOMAKE_OPTIONS = gnu

SUBDIRS = \
	include tuxwetter input getrc shellexec fx2
#	include tuxcom tuxwetter msgbox input getrc shellexec fx2
#	include tuxmail tuxtxt tuxcom tuxcal tuxclock fx2 vncviewer enigma shellexec tuxwetter sysinfo clock logomask blockads links

if BOXTYPE_ARMBOX
if BOXMODEL_VUPLUS_ARM
SUBDIRS += \
	stb-startup-vu
else
SUBDIRS += \
	stb-startup \
	stb-backup
endif
endif

#if BOXTYPE_ARMBOX
#SUBDIRS += \
#	stb-startup-tuxbox
#endif

#if BOXTYPE_DREAMBOX
#SUBDIRS += pip mosaic
#else
#SUBDIRS += pluginx
#endif

#pkgconfigdir = $(libdir)/pkgconfig
#pkgconfig_DATA = \
#	tuxbox-plugins.pc

