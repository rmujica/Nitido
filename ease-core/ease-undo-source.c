/* ease-undo-source.c generated by valac 0.10.0, the Vala compiler
 * generated from ease-undo-source.vala, do not modify */

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


#define EASE_TYPE_UNDO_SOURCE (ease_undo_source_get_type ())
#define EASE_UNDO_SOURCE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_UNDO_SOURCE, EaseUndoSource))
#define EASE_IS_UNDO_SOURCE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_UNDO_SOURCE))
#define EASE_UNDO_SOURCE_GET_INTERFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), EASE_TYPE_UNDO_SOURCE, EaseUndoSourceIface))

typedef struct _EaseUndoSource EaseUndoSource;
typedef struct _EaseUndoSourceIface EaseUndoSourceIface;

#define EASE_TYPE_UNDO_ITEM (ease_undo_item_get_type ())
#define EASE_UNDO_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_UNDO_ITEM, EaseUndoItem))
#define EASE_UNDO_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_UNDO_ITEM, EaseUndoItemClass))
#define EASE_IS_UNDO_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_UNDO_ITEM))
#define EASE_IS_UNDO_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_UNDO_ITEM))
#define EASE_UNDO_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_UNDO_ITEM, EaseUndoItemClass))

typedef struct _EaseUndoItem EaseUndoItem;
typedef struct _EaseUndoItemClass EaseUndoItemClass;

struct _EaseUndoSourceIface {
	GTypeInterface parent_iface;
};



GType ease_undo_source_get_type (void) G_GNUC_CONST;
GType ease_undo_item_get_type (void) G_GNUC_CONST;
void ease_undo_source_forward (EaseUndoSource* self, EaseUndoItem* action);
void ease_undo_source_listen (EaseUndoSource* self, EaseUndoSource* source);
static void _ease_undo_source_forward_ease_undo_source_undo (EaseUndoSource* _sender, EaseUndoItem* action, gpointer self);
void ease_undo_source_silence (EaseUndoSource* self, EaseUndoSource* source);



/**
 * Forwards an {@link UndoItem} downwards, to any object listening to this
 * UndoSource's "undo" signal".
 */
#line 39 "ease-undo-source.vala"
void ease_undo_source_forward (EaseUndoSource* self, EaseUndoItem* action) {
#line 39 "ease-undo-source.vala"
	g_return_if_fail (action != NULL);
#line 41 "ease-undo-source.vala"
	g_signal_emit_by_name (self, "undo", action);
#line 42 "ease-undo-source.vala"
	g_signal_emit_by_name (self, "forwarded", action);
#line 71 "ease-undo-source.c"
}


/**
 * Listens for incoming UndoItems from the specified UndoSource, and
 * {@link forward}s them downwards.
 */
#line 39 "ease-undo-source.vala"
static void _ease_undo_source_forward_ease_undo_source_undo (EaseUndoSource* _sender, EaseUndoItem* action, gpointer self) {
#line 81 "ease-undo-source.c"
	ease_undo_source_forward (self, action);
}


#line 49 "ease-undo-source.vala"
void ease_undo_source_listen (EaseUndoSource* self, EaseUndoSource* source) {
#line 49 "ease-undo-source.vala"
	g_return_if_fail (source != NULL);
#line 51 "ease-undo-source.vala"
	g_signal_connect_object (source, "undo", (GCallback) _ease_undo_source_forward_ease_undo_source_undo, self, 0);
#line 92 "ease-undo-source.c"
}


/**
 * Stops listening to an UndoSource.
 */
#line 57 "ease-undo-source.vala"
void ease_undo_source_silence (EaseUndoSource* self, EaseUndoSource* source) {
#line 101 "ease-undo-source.c"
	guint _tmp0_;
#line 57 "ease-undo-source.vala"
	g_return_if_fail (source != NULL);
#line 59 "ease-undo-source.vala"
	g_signal_parse_name ("undo", EASE_TYPE_UNDO_SOURCE, &_tmp0_, NULL, FALSE);
#line 59 "ease-undo-source.vala"
	g_signal_handlers_disconnect_matched (source, G_SIGNAL_MATCH_ID | G_SIGNAL_MATCH_FUNC | G_SIGNAL_MATCH_DATA, _tmp0_, 0, NULL, (GCallback) _ease_undo_source_forward_ease_undo_source_undo, self);
#line 109 "ease-undo-source.c"
}


static void ease_undo_source_base_init (EaseUndoSourceIface * iface) {
	static gboolean initialized = FALSE;
	if (!initialized) {
		initialized = TRUE;
		/**
		 * Classes that implement the UndoSource interface should use this signal
		 * to notify a parent controller (typically an EditorWindow) of a new
		 * UndoAction.
		 */
		g_signal_new ("undo", EASE_TYPE_UNDO_SOURCE, G_SIGNAL_RUN_LAST, 0, NULL, NULL, g_cclosure_marshal_VOID__OBJECT, G_TYPE_NONE, 1, EASE_TYPE_UNDO_ITEM);
		/**
		 * Emitted when an UndoItem is forwarded.
		 */
		g_signal_new ("forwarded", EASE_TYPE_UNDO_SOURCE, G_SIGNAL_RUN_LAST, 0, NULL, NULL, g_cclosure_marshal_VOID__OBJECT, G_TYPE_NONE, 1, EASE_TYPE_UNDO_ITEM);
	}
}


/**
 * Provides a signal to notify a controller of {@link UndoItem}s.
 */
GType ease_undo_source_get_type (void) {
	static volatile gsize ease_undo_source_type_id__volatile = 0;
	if (g_once_init_enter (&ease_undo_source_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (EaseUndoSourceIface), (GBaseInitFunc) ease_undo_source_base_init, (GBaseFinalizeFunc) NULL, (GClassInitFunc) NULL, (GClassFinalizeFunc) NULL, NULL, 0, 0, (GInstanceInitFunc) NULL, NULL };
		GType ease_undo_source_type_id;
		ease_undo_source_type_id = g_type_register_static (G_TYPE_INTERFACE, "EaseUndoSource", &g_define_type_info, 0);
		g_type_interface_add_prerequisite (ease_undo_source_type_id, G_TYPE_OBJECT);
		g_once_init_leave (&ease_undo_source_type_id__volatile, ease_undo_source_type_id);
	}
	return ease_undo_source_type_id__volatile;
}



