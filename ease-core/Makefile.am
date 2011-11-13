lib_LTLIBRARIES = libease-core-@EASE_CORE_VERSION@.la

# source files
libease_core_@EASE_CORE_VERSION@_la_SOURCES = \
	ease-actor.vala \
	ease-animated-zoom-slider.vala \
	ease-archiver.vala \
	ease-background.vala \
	ease-background-widget.vala \
	ease-cairo-actor.vala \
	ease-cairo-element.vala \
	ease-color.vala \
	ease-dialog-progress.vala \
	ease-dialogs.vala \
	ease-document.vala \
	ease-element.vala \
	ease-enums.vala \
	ease-gradient.vala \
	ease-html-exporter.vala \
	ease-image-actor.vala \
	ease-image-element.vala \
	ease-image.vala \
	ease-iterable-models.vala \
	ease-media-element.vala \
	ease-plugin-import-media.vala \
	ease-plugin-import-service.vala \
	ease-pdf-actor.vala \
	ease-pdf-element.vala \
	ease-shape-element.vala \
	ease-slide.vala \
	ease-temp.vala \
	ease-text-actor.vala \
	ease-text-element.vala \
	ease-theme.vala \
	ease-transformations.vala \
	ease-transitions.vala \
	ease-undo-actions-element.vala \
	ease-undo-actions-slide.vala \
	ease-undo-action.vala \
	ease-undo-controller.vala \
	ease-undo-item.vala \
	ease-undo-source.vala \
	ease-utilities.vala \
	ease-video-actor.vala \
	ease-video-element.vala \
	ease-zoom-slider.vala \
	sourcelist/source-base-group.vala \
	sourcelist/source-base-view.vala \
	sourcelist/source-expandable-group.vala \
	sourcelist/source-group.vala \
	sourcelist/source-item.vala \
	sourcelist/source-list.vala \
	sourcelist/source-number-item.vala \
	sourcelist/source-pane-view.vala \
	sourcelist/source-spinner-item.vala \
	sourcelist/source-view.vala \
	$(NULL)

# compiler flags

# I don't _want_ to --disable-warnings, but the choices appear to be:
#    - enable warnings, mark signal handlers for GtkBuilder as public
#    - disable warnings, hide functionality properly \
#    - enable warnings, hide functionality, get spammed with unused
#      function warnings
# Therefore, warnings are off.

libease_core_@EASE_CORE_VERSION@_la_VALAFLAGS = \
	$(EASE_PACKAGES) \
	--vapi=$(top_srcdir)/vapi/ease-core-@EASE_CORE_VERSION@.vapi \
	--header=ease-core.h \
	--thread \
	--disable-warnings \
	--vapidir=$(top_srcdir)/vapi \
	--pkg flutter-@FLUTTER_VERSION@ \
	-g \
	$(NULL)

libease_core_@EASE_CORE_VERSION@_la_LIBADD = \
	$(top_builddir)/flutter/libflutter-@FLUTTER_VERSION@.la

libease_core_@EASE_CORE_VERSION@_la_CFLAGS = \
	$(EASE_CFLAGS) \
	-w \
	-DEASE_DATA_DIR=\"$(datadir)\" \
	-include $(top_srcdir)/config.h \
	-I$(top_srcdir)/flutter \
	$(NULL)
	
libease_core_@EASE_CORE_VERSION@_la_LDFLAGS = \
	$(EASE_LDFLAGS) \
	--export-dynamic \
	$(NULL)

# header installation
libease_includedir=$(includedir)/ease/
libease_include_HEADERS = ease-core.h

# vapi installation
vapidir = $(datadir)/vala/vapi
vapi_DATA = \
	$(top_srcdir)/vapi/ease-core-@EASE_CORE_VERSION@.vapi \
	$(top_srcdir)/vapi/ease-core-@EASE_CORE_VERSION@.deps

# remove generated files on `make clean`
CLEANFILES = \
	$(subst .vala,.c,$(libease_core_@EASE_CORE_VERSION@_la_SOURCES)) \
	$(top_srcdir)/vapi/ease-core-@EASE_CORE_VERSION@.vapi \
	ease-core.h

EXTRA_DIST = \
	$(top_srcdir)/vapi/ease-core-@EASE_CORE_VERSION@.vapi \
	$(top_srcdir)/vapi/ease-core-@EASE_CORE_VERSION@.deps

