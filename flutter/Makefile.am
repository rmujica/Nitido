lib_LTLIBRARIES = libflutter-@FLUTTER_VERSION@.la

INCLUDES = \
	$(EASE_CFLAGS)

EASE_CFLAGS += -w

AM_CPPFLAGS = \
	$(EASE_CFLAGS) \
	-include $(CONFIG_HEADER) \
	$(NULL)

# source files
libflutter_@FLUTTER_VERSION@_la_SOURCES = flutter.vala

# compiler flags
libflutter_@FLUTTER_VERSION@_la_VALAFLAGS = \
	--pkg clutter-1.0 \
	--vapi=$(top_srcdir)/vapi/flutter-@FLUTTER_VERSION@.vapi \
	--header=flutter.h \
	--thread \
	-g \
	$(NULL)

libflutter_@FLUTTER_VERSION@_la_CFLAGS = $(EASE_CFLAGS)
libflutter_@FLUTTER_VERSION@_la_LDFLAGS = $(EASE_LDFLAGS)

# header installation
flutter_includedir=$(includedir)/flutter/
flutter_include_HEADERS = flutter.h

# vapi installation
vapidir = $(datadir)/vala/vapi
vapi_DATA = \
	$(top_srcdir)/vapi/flutter-@FLUTTER_VERSION@.vapi \
	$(top_srcdir)/vapi/flutter-@FLUTTER_VERSION@.deps

$(top_srcdir)/vapi/flutter-@FLUTTER_VERSION@.vapi: libflutter-@FLUTTER_VERSION@.la

flutter.h: libflutter-@FLUTTER_VERSION@.la

# remove generated files on `make clean`
CLEANFILES = \
	flutter.c \
	$(top_srcdir)/vapi/flutter-@FLUTTER_VERSION@.vapi \
	flutter.h \
	libflutter_@FLUTTER_VERSION@_la-flutter.lo

EXTRA_DIST = \
	$(top_srcdir)/vapi/flutter-@FLUTTER_VERSION@.vapi \
	$(top_srcdir)/vapi/flutter-@FLUTTER_VERSION@.deps

