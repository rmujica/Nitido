AC_PREREQ([2.59])

m4_define(ease_version, 0.5)
m4_define(ease_core_version, 0.5)
m4_define(flutter_version, 0.5)

AC_INIT([Ease],
        [ease_version],
        [https://bugzilla.gnome.org/enter_bug.cgi?product=ease],
        [ease],
        [http://live.gnome.org/Ease])

AC_CONFIG_FILES([
	Makefile
	po/Makefile.in
	data/Makefile
	ease-core/Makefile
	flutter/Makefile
	ease/Makefile
	pkgconfig/ease-core-0.5.pc
	pkgconfig/flutter-0.5.pc])

AC_CONFIG_SRCDIR([Makefile.am])
AC_CONFIG_HEADERS([config.h])

AM_INIT_AUTOMAKE([no-dist-gzip dist-bzip2 subdir-objects -Wno-portability])
AM_MAINTAINER_MODE()

# Enable silent rules is available
m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])

AC_PROG_CC
AC_PROG_CC_STDC

if test "x$USE_MAINTAINER_MODE" = "xyes" ; then
  AM_PROG_VALAC([0.9.1])
fi

AM_PROG_CC_C_O
AC_PROG_INSTALL
AC_PROG_INTLTOOL([0.35])
AM_PROG_LIBTOOL

# GObject introspection
AC_CONFIG_MACRO_DIR([m4])
GOBJECT_INTROSPECTION_CHECK([0.6.7])

dnl this is preferred, but doesn't work for me :
dnl LT_PREREQ([2.2.6])

GNOME_COMPILE_WARNINGS([maximum])
GNOME_MAINTAINER_MODE_DEFINES

dnl packages
pkg_modules="\
 clutter-gst-1.0\
 clutter-gtk-0.10 >= 0.10\
 gee-1.0\
 gmodule-2.0\
 json-glib-1.0 >= 0.7.6\
 libarchive\
 poppler-glib\
 rest-0.6 \
 rest-extras-0.6\
 unique-1.0"
 
PKG_CHECK_MODULES(EASE, [$pkg_modules])

EASE_PACKAGES="\
 --pkg clutter-gst-1.0\
 --pkg clutter-gtk-0.10\
 --pkg gee-1.0\
 --pkg gmodule-2.0\
 --pkg json-glib-1.0\
 --pkg libarchive\
 --pkg poppler-glib\
 --pkg rest-extras-0.6\
 --pkg unique-1.0"

AC_SUBST(EASE_CFLAGS)
AC_SUBST(EASE_LIBS)
AC_SUBST(EASE_PACKAGES)

AC_DEFINE(EASE_VERSION, ease_version, [Ease Version])
AC_SUBST(EASE_VERSION, ease_version)
AC_DEFINE(EASE_CORE_VERSION, ease_core_version, [Ease Core Version])
AC_SUBST(EASE_CORE_VERSION, ease_core_version)
AC_DEFINE(FLUTTER_VERSION, flutter_version, [Flutter Version])
AC_SUBST(FLUTTER_VERSION, flutter_version)

dnl internationalization
GETTEXT_PACKAGE=ease
AC_DEFINE_UNQUOTED([GETTEXT_PACKAGE], ["$GETTEXT_PACKAGE"], [Gettext Package])
AC_SUBST(GETTEXT_PACKAGE)
AM_GLIB_GNU_GETTEXT

AC_OUTPUT
