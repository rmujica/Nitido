@INTLTOOL_DESKTOP_RULE@

desktopdir = $(datadir)/applications
desktop_in_files = ease.desktop.in
desktop_DATA = $(desktop_in_files:.desktop.in=.desktop)

# install an icon for the app
appicondir = $(datadir)/icons/hicolor/scalable/apps
appicon_DATA = icons/hicolor/scalable/apps/ease.svg

# mime type and icon
mimedir = $(datadir)/mime/packages
mime_DATA = ease-mime.xml

mimeicondir = $(datadir)/icons/gnome/scalable/mimetypes
mimeicon_DATA = gnome-mime-application-x-ease.svg

# svg images
svgdir = $(datadir)/ease/svg
svg_DATA = $(wildcard $(top_srcdir)/data/svg/*.svg)

# gtkbuilder files
uidir = $(datadir)/ease/ui
ui_DATA = $(wildcard $(top_srcdir)/data/ui/*.ui)

# theme defaults
jsondir = $(datadir)/ease
json_DATA = theme-defaults.json

# themes
blackdir = $(datadir)/ease/themes/Black
black_DATA = themes/Black/Theme.json

bluedir = $(datadir)/ease/themes/Blue
blue_DATA = themes/Blue/Theme.json

goddarddir = $(datadir)/ease/themes/Goddard
goddard_DATA = themes/Goddard/Theme.json

goddardmediadir = $(datadir)/ease/themes/Goddard/Media
goddardmedia_DATA = themes/Goddard/Media/default.jpg

greendir = $(datadir)/ease/themes/Green
green_DATA = themes/Green/Theme.json

reddir = $(datadir)/ease/themes/Red
red_DATA = themes/Red/Theme.json

whitedir = $(datadir)/ease/themes/White
white_DATA = themes/White/Theme.json

EXTRA_DIST = \
    $(appicon_DATA) \
    $(ui_DATA) \
    $(svg_DATA) \
    $(desktop_in_files) \
    $(json_DATA) \
    $(black_DATA) \
    $(blue_DATA) \
    $(goddard_DATA) \
    $(goddardmedia_DATA) \
    $(green_DATA) \
    $(red_DATA) \
    $(white_DATA) \
    $(mime_DATA) \
    $(mimeicon_DATA)

# installing mime type
install-data-local: install-mimeDATA
	if [ -f $(DESTDIR)$(datadir)/mime/packages/freedesktop.org.xml ] ; then \
	  if which update-mime-database>/dev/null 2>&1; then \
	    update-mime-database $(DESTDIR)$(datadir)/mime; \
	  fi \
	fi

uninstall-local:
	if [ -f $(DESTDIR)$(datadir)/mime/packages/freedesktop.org.xml ] ; then \
	  if which update-mime-database>/dev/null 2>&1; then \
	    update-mime-database $(DESTDIR)$(datadir)/mime; \
	  fi \
	fi

