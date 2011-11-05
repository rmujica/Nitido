# build ease executable
bin_PROGRAMS = ease

# source files
ease_SOURCES = \
	ease-about-dialog.vala \
	ease-close-confirm-dialog.vala \
	ease-editor-embed.vala \
	ease-editor-window.vala \
	ease-handle.vala \
	ease-import-dialog.vala \
	ease-import-flickr-media.vala \
	ease-import-flickr-service.vala \
	ease-import-oca-media.vala \
	ease-import-oca-service.vala \
	ease-import-widget.vala \
	ease-inspector-element-pane.vala \
	ease-inspector-pane.vala \
	ease-inspector-slide-pane.vala \
	ease-inspector-transition-pane.vala \
	ease-inspector.vala \
	ease-main.vala \
	ease-player.vala \
	ease-selection-rectangle.vala \
	ease-slide-actor.vala \
	ease-slide-button-panel.vala \
	ease-slide-sorter.vala \
	ease-welcome-actor.vala \
	ease-welcome-window.vala

# compiler flags
ease_VALAFLAGS = \
	--pkg ease-core-@EASE_CORE_VERSION@ \
	--pkg flutter-@FLUTTER_VERSION@ \
	--disable-warnings \
	$(EASE_PACKAGES) \
	--vapidir $(top_srcdir)/vapi \
	--thread \
	-g

ease_CFLAGS = \
	$(EASE_CFLAGS) \
	-w \
	-DEASE_DATA_DIR=\"$(datadir)\" \
	-I$(top_srcdir)/ease-core \
	-I$(top_srcdir)/flutter \
	-include $(top_srcdir)/config.h

ease_LDFLAGS = $(EASE_LIBS) --export-dynamic

ease_LDADD = \
	$(top_builddir)/ease-core/libease-core-@EASE_CORE_VERSION@.la \
	$(top_builddir)/flutter/libflutter-@FLUTTER_VERSION@.la \
	-lm \
	$(NULL)

CLEANFILES = $(subst .vala,.c,$(ease_SOURCES))

