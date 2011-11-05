NULL =

SUBDIRS = po data flutter ease-core ease

# distribution
EXTRA_DIST = data/ease.desktop.in.in  \
	$(NULL)

DISTCLEANFILES = data/ease.desktop \
	$(NULL)

ACLOCAL_AMFLAGS = -I m4

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = \
    pkgconfig/ease-core-@EASE_CORE_VERSION@.pc \
    pkgconfig/flutter-@FLUTTER_VERSION@.pc
    
run: all
	ease/ease

db: all
	libtool --mode=execute gdb ease/ease

doc: ease-core/*.vala
	rm -rf doc
	
	valadoc \
		$(EASE_PACKAGES) \
		--directory=./doc \
		./ease-core/*.vala \
		ease-core/sourcelist/*.vala \
		./flutter/*.vala
	
	gnome-open doc/doc/Ease.html

doc-internal:
	rm -rf doc
	
	valadoc \
		--private \
		--internal \
		$(EASE_PACKAGES) \
		--directory=./doc \
		./ease-core/*.vala \
		ease-core/sourcelist/*.vala \
		./flutter/*.vala
	
	gnome-open doc/doc/Ease.html

archive: examples/*
	sh examples/build.sh

potfiles:
	echo "# List of source files which contain translatable strings." > po/POTFILES.in
	echo "[encoding: UTF-8]" >> po/POTFILES.in
	echo "data/ease.desktop.in" >> po/POTFILES.in
	echo "data/ease.desktop.in.in" >> po/POTFILES.in
	ls ease-core | grep ease- | grep .vala | sed "s/ease/ease-core\/ease/g" >> po/POTFILES.in
	ls ease | grep ease- | grep .vala | sed "s/ease/ease\/ease/g" >> po/POTFILES.in
	ls data/ui | while read line; do echo "data/ui/$$line" >> po/POTFILES.in; done
	
	ls ease-core | grep ease- | grep "\.c" | sed "s/ease/ease-core\/ease/g" > po/POTFILES.skip
	ls ease | grep ease- | grep "\.c" | sed "s/ease/ease\/ease/g" >> po/POTFILES.skip
	ls flutter | while read line; do echo "flutter/$$line" >> po/POTFILES.skip; done
	echo "ease-core/libease-core.h" >> po/POTFILES.skip
	echo "flutter/libflutter.h" >> po/POTFILES.skip

