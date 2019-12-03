AUTOMAKE_OPTIONS = gnu

SUBDIRS = \
	include tuxwetter input getrc shellexec
#	include tuxcom tuxwetter msgbox input getrc shellexec fx2
#	include tuxmail tuxtxt tuxcom tuxcal tuxclock fx2 vncviewer enigma shellexec tuxwetter sysinfo clock logomask blockads links

if BOXTYPE_ARMBOX
if BOXMODEL_VUDUO4K
SUBDIRS += \
	stb-startup-vu
else
if BOXMODEL_VUSOLO4K
SUBDIRS += \
	stb-startup-vu
else
if BOXMODEL_VUUNO4K
SUBDIRS += \
	stb-startup-vu
else
if BOXMODEL_VUUNO4KSE
SUBDIRS += \
	stb-startup-vu
else
if BOXMODEL_VUZERO4K
SUBDIRS += \
	stb-startup-vu
else
if BOXMODEL_VUULTIMO4K
SUBDIRS += \
	stb-startup-vu
else
SUBDIRS += \
	stb-startup \
	stb-backup
endif
endif
endif
endif
endif
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

