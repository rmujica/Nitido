/* ease-plugin-import-media.c generated by valac 0.10.0, the Vala compiler
 * generated from ease-plugin-import-media.vala, do not modify */

/*  Ease, a GTK presentation application
    Copyright (C) 2010 Nate Stedman

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <glib.h>
#include <glib-object.h>
#include <stdlib.h>
#include <string.h>


#define EASE_PLUGIN_TYPE_IMPORT_MEDIA (ease_plugin_import_media_get_type ())
#define EASE_PLUGIN_IMPORT_MEDIA(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_PLUGIN_TYPE_IMPORT_MEDIA, EasePluginImportMedia))
#define EASE_PLUGIN_IMPORT_MEDIA_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_PLUGIN_TYPE_IMPORT_MEDIA, EasePluginImportMediaClass))
#define EASE_PLUGIN_IS_IMPORT_MEDIA(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_PLUGIN_TYPE_IMPORT_MEDIA))
#define EASE_PLUGIN_IS_IMPORT_MEDIA_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_PLUGIN_TYPE_IMPORT_MEDIA))
#define EASE_PLUGIN_IMPORT_MEDIA_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_PLUGIN_TYPE_IMPORT_MEDIA, EasePluginImportMediaClass))

typedef struct _EasePluginImportMedia EasePluginImportMedia;
typedef struct _EasePluginImportMediaClass EasePluginImportMediaClass;
typedef struct _EasePluginImportMediaPrivate EasePluginImportMediaPrivate;
#define _g_free0(var) (var = (g_free (var), NULL))

struct _EasePluginImportMedia {
	GObject parent_instance;
	EasePluginImportMediaPrivate * priv;
	char* title;
	char* file_link;
	char* thumb_link;
};

struct _EasePluginImportMediaClass {
	GObjectClass parent_class;
};


static gpointer ease_plugin_import_media_parent_class = NULL;

GType ease_plugin_import_media_get_type (void) G_GNUC_CONST;
enum  {
	EASE_PLUGIN_IMPORT_MEDIA_DUMMY_PROPERTY
};
EasePluginImportMedia* ease_plugin_import_media_new (void);
EasePluginImportMedia* ease_plugin_import_media_construct (GType object_type);
static void ease_plugin_import_media_finalize (GObject* obj);



#line 22 "ease-plugin-import-media.vala"
EasePluginImportMedia* ease_plugin_import_media_construct (GType object_type) {
#line 67 "ease-plugin-import-media.c"
	EasePluginImportMedia * self;
#line 22 "ease-plugin-import-media.vala"
	self = (EasePluginImportMedia*) g_object_new (object_type, NULL);
#line 71 "ease-plugin-import-media.c"
	return self;
}


#line 22 "ease-plugin-import-media.vala"
EasePluginImportMedia* ease_plugin_import_media_new (void) {
#line 22 "ease-plugin-import-media.vala"
	return ease_plugin_import_media_construct (EASE_PLUGIN_TYPE_IMPORT_MEDIA);
#line 80 "ease-plugin-import-media.c"
}


static void ease_plugin_import_media_class_init (EasePluginImportMediaClass * klass) {
	ease_plugin_import_media_parent_class = g_type_class_peek_parent (klass);
	G_OBJECT_CLASS (klass)->finalize = ease_plugin_import_media_finalize;
}


static void ease_plugin_import_media_instance_init (EasePluginImportMedia * self) {
}


static void ease_plugin_import_media_finalize (GObject* obj) {
	EasePluginImportMedia * self;
	self = EASE_PLUGIN_IMPORT_MEDIA (obj);
	_g_free0 (self->title);
	_g_free0 (self->file_link);
	_g_free0 (self->thumb_link);
	G_OBJECT_CLASS (ease_plugin_import_media_parent_class)->finalize (obj);
}


/**
 * Base class for an image on a website that an {@link ImportService}
 * searches.
 */
GType ease_plugin_import_media_get_type (void) {
	static volatile gsize ease_plugin_import_media_type_id__volatile = 0;
	if (g_once_init_enter (&ease_plugin_import_media_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (EasePluginImportMediaClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) ease_plugin_import_media_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (EasePluginImportMedia), 0, (GInstanceInitFunc) ease_plugin_import_media_instance_init, NULL };
		GType ease_plugin_import_media_type_id;
		ease_plugin_import_media_type_id = g_type_register_static (G_TYPE_OBJECT, "EasePluginImportMedia", &g_define_type_info, 0);
		g_once_init_leave (&ease_plugin_import_media_type_id__volatile, ease_plugin_import_media_type_id);
	}
	return ease_plugin_import_media_type_id__volatile;
}




