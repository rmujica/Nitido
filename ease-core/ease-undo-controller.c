/* ease-undo-controller.c generated by valac 0.10.0, the Vala compiler
 * generated from ease-undo-controller.vala, do not modify */

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
#include <gee.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define EASE_TYPE_UNDO_CONTROLLER (ease_undo_controller_get_type ())
#define EASE_UNDO_CONTROLLER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_UNDO_CONTROLLER, EaseUndoController))
#define EASE_UNDO_CONTROLLER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_UNDO_CONTROLLER, EaseUndoControllerClass))
#define EASE_IS_UNDO_CONTROLLER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_UNDO_CONTROLLER))
#define EASE_IS_UNDO_CONTROLLER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_UNDO_CONTROLLER))
#define EASE_UNDO_CONTROLLER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_UNDO_CONTROLLER, EaseUndoControllerClass))

typedef struct _EaseUndoController EaseUndoController;
typedef struct _EaseUndoControllerClass EaseUndoControllerClass;
typedef struct _EaseUndoControllerPrivate EaseUndoControllerPrivate;

#define EASE_TYPE_UNDO_ITEM (ease_undo_item_get_type ())
#define EASE_UNDO_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_UNDO_ITEM, EaseUndoItem))
#define EASE_UNDO_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_UNDO_ITEM, EaseUndoItemClass))
#define EASE_IS_UNDO_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_UNDO_ITEM))
#define EASE_IS_UNDO_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_UNDO_ITEM))
#define EASE_UNDO_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_UNDO_ITEM, EaseUndoItemClass))

typedef struct _EaseUndoItem EaseUndoItem;
typedef struct _EaseUndoItemClass EaseUndoItemClass;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))

#define EASE_TYPE_UNDO_ACTION (ease_undo_action_get_type ())
#define EASE_UNDO_ACTION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_UNDO_ACTION, EaseUndoAction))
#define EASE_UNDO_ACTION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_UNDO_ACTION, EaseUndoActionClass))
#define EASE_IS_UNDO_ACTION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_UNDO_ACTION))
#define EASE_IS_UNDO_ACTION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_UNDO_ACTION))
#define EASE_UNDO_ACTION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_UNDO_ACTION, EaseUndoActionClass))

typedef struct _EaseUndoAction EaseUndoAction;
typedef struct _EaseUndoActionClass EaseUndoActionClass;
typedef struct _EaseUndoItemPrivate EaseUndoItemPrivate;
typedef struct _EaseUndoActionPrivate EaseUndoActionPrivate;

#define EASE_UNDO_ACTION_TYPE_UNDO_PAIR (ease_undo_action_undo_pair_get_type ())
#define EASE_UNDO_ACTION_UNDO_PAIR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_UNDO_ACTION_TYPE_UNDO_PAIR, EaseUndoActionUndoPair))
#define EASE_UNDO_ACTION_UNDO_PAIR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_UNDO_ACTION_TYPE_UNDO_PAIR, EaseUndoActionUndoPairClass))
#define EASE_UNDO_ACTION_IS_UNDO_PAIR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_UNDO_ACTION_TYPE_UNDO_PAIR))
#define EASE_UNDO_ACTION_IS_UNDO_PAIR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_UNDO_ACTION_TYPE_UNDO_PAIR))
#define EASE_UNDO_ACTION_UNDO_PAIR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_UNDO_ACTION_TYPE_UNDO_PAIR, EaseUndoActionUndoPairClass))

typedef struct _EaseUndoActionUndoPair EaseUndoActionUndoPair;
typedef struct _EaseUndoActionUndoPairClass EaseUndoActionUndoPairClass;
typedef struct _EaseUndoActionUndoPairPrivate EaseUndoActionUndoPairPrivate;
#define _ease_undo_action_undo_pair_unref0(var) ((var == NULL) ? NULL : (var = (ease_undo_action_undo_pair_unref (var), NULL)))

struct _EaseUndoController {
	GObject parent_instance;
	EaseUndoControllerPrivate * priv;
};

struct _EaseUndoControllerClass {
	GObjectClass parent_class;
};

struct _EaseUndoControllerPrivate {
	GeeLinkedList* undos;
	GeeLinkedList* redos;
};

struct _EaseUndoItem {
	GObject parent_instance;
	EaseUndoItemPrivate * priv;
};

struct _EaseUndoItemClass {
	GObjectClass parent_class;
	EaseUndoItem* (*apply) (EaseUndoItem* self);
	gboolean (*contains) (EaseUndoItem* self, GObject* obj);
};

struct _EaseUndoAction {
	EaseUndoItem parent_instance;
	EaseUndoActionPrivate * priv;
	GeeLinkedList* pairs;
};

struct _EaseUndoActionClass {
	EaseUndoItemClass parent_class;
};

struct _EaseUndoActionUndoPair {
	GTypeInstance parent_instance;
	volatile int ref_count;
	EaseUndoActionUndoPairPrivate * priv;
	char* property;
	GObject* object;
	GValue val;
	GType type;
};

struct _EaseUndoActionUndoPairClass {
	GTypeClass parent_class;
	void (*finalize) (EaseUndoActionUndoPair *self);
};


static gboolean ease_undo_controller__enable_debug;
static gboolean ease_undo_controller__enable_debug = FALSE;
static gpointer ease_undo_controller_parent_class = NULL;

GType ease_undo_controller_get_type (void) G_GNUC_CONST;
GType ease_undo_item_get_type (void) G_GNUC_CONST;
#define EASE_UNDO_CONTROLLER_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), EASE_TYPE_UNDO_CONTROLLER, EaseUndoControllerPrivate))
enum  {
	EASE_UNDO_CONTROLLER_DUMMY_PROPERTY
};
EaseUndoController* ease_undo_controller_new (void);
EaseUndoController* ease_undo_controller_construct (GType object_type);
gboolean ease_undo_controller_can_undo (EaseUndoController* self);
gboolean ease_undo_controller_can_redo (EaseUndoController* self);
void ease_undo_controller_undo (EaseUndoController* self);
static void ease_undo_controller_add_redo_action (EaseUndoController* self, EaseUndoItem* action);
EaseUndoItem* ease_undo_item_apply (EaseUndoItem* self);
void ease_undo_controller_redo (EaseUndoController* self);
void ease_undo_controller_add_action (EaseUndoController* self, EaseUndoItem* action);
void ease_undo_controller_clear_redo (EaseUndoController* self);
gboolean ease_undo_controller_get_enable_debug (void);
GType ease_undo_action_get_type (void) G_GNUC_CONST;
gpointer ease_undo_action_undo_pair_ref (gpointer instance);
void ease_undo_action_undo_pair_unref (gpointer instance);
GParamSpec* ease_undo_action_param_spec_undo_pair (const gchar* name, const gchar* nick, const gchar* blurb, GType object_type, GParamFlags flags);
void ease_undo_action_value_set_undo_pair (GValue* value, gpointer v_object);
void ease_undo_action_value_take_undo_pair (GValue* value, gpointer v_object);
gpointer ease_undo_action_value_get_undo_pair (const GValue* value);
GType ease_undo_action_undo_pair_get_type (void) G_GNUC_CONST;
void ease_undo_controller_set_enable_debug (gboolean value);
static void ease_undo_controller_finalize (GObject* obj);
static void ease_undo_controller_get_property (GObject * object, guint property_id, GValue * value, GParamSpec * pspec);
static void ease_undo_controller_set_property (GObject * object, guint property_id, const GValue * value, GParamSpec * pspec);



/**
 * Creates an UndoController. Used by EditorWindow.
 */
#line 43 "ease-undo-controller.vala"
EaseUndoController* ease_undo_controller_construct (GType object_type) {
#line 168 "ease-undo-controller.c"
	EaseUndoController * self;
#line 43 "ease-undo-controller.vala"
	self = (EaseUndoController*) g_object_new (object_type, NULL);
#line 172 "ease-undo-controller.c"
	return self;
}


#line 43 "ease-undo-controller.vala"
EaseUndoController* ease_undo_controller_new (void) {
#line 43 "ease-undo-controller.vala"
	return ease_undo_controller_construct (EASE_TYPE_UNDO_CONTROLLER);
#line 181 "ease-undo-controller.c"
}


/**
 * Returns true if there is an action available to undo.
 */
#line 48 "ease-undo-controller.vala"
gboolean ease_undo_controller_can_undo (EaseUndoController* self) {
#line 190 "ease-undo-controller.c"
	gboolean result = FALSE;
#line 48 "ease-undo-controller.vala"
	g_return_val_if_fail (self != NULL, FALSE);
#line 194 "ease-undo-controller.c"
	result = gee_collection_get_size ((GeeCollection*) self->priv->undos) > 0;
#line 50 "ease-undo-controller.vala"
	return result;
#line 198 "ease-undo-controller.c"
}


/**
 * Returns true if there is an action available to redo.
 */
#line 56 "ease-undo-controller.vala"
gboolean ease_undo_controller_can_redo (EaseUndoController* self) {
#line 207 "ease-undo-controller.c"
	gboolean result = FALSE;
#line 56 "ease-undo-controller.vala"
	g_return_val_if_fail (self != NULL, FALSE);
#line 211 "ease-undo-controller.c"
	result = gee_collection_get_size ((GeeCollection*) self->priv->redos) > 0;
#line 58 "ease-undo-controller.vala"
	return result;
#line 215 "ease-undo-controller.c"
}


/**
 * Undoes the first available {@link UndoItem} in the undo queue.
 */
#line 64 "ease-undo-controller.vala"
void ease_undo_controller_undo (EaseUndoController* self) {
#line 224 "ease-undo-controller.c"
	EaseUndoItem* _tmp0_;
	EaseUndoItem* _tmp1_;
#line 64 "ease-undo-controller.vala"
	g_return_if_fail (self != NULL);
#line 66 "ease-undo-controller.vala"
	ease_undo_controller_add_redo_action (self, _tmp1_ = ease_undo_item_apply (_tmp0_ = (EaseUndoItem*) gee_deque_poll_head ((GeeDeque*) self->priv->undos)));
#line 231 "ease-undo-controller.c"
	_g_object_unref0 (_tmp1_);
	_g_object_unref0 (_tmp0_);
}


/**
 * Redoes the first available {@link UndoItem} in the redo queue.
 */
#line 72 "ease-undo-controller.vala"
void ease_undo_controller_redo (EaseUndoController* self) {
#line 242 "ease-undo-controller.c"
	EaseUndoItem* _tmp0_;
	EaseUndoItem* _tmp1_;
#line 72 "ease-undo-controller.vala"
	g_return_if_fail (self != NULL);
#line 74 "ease-undo-controller.vala"
	ease_undo_controller_add_action (self, _tmp1_ = ease_undo_item_apply (_tmp0_ = (EaseUndoItem*) gee_deque_poll_head ((GeeDeque*) self->priv->redos)));
#line 249 "ease-undo-controller.c"
	_g_object_unref0 (_tmp1_);
	_g_object_unref0 (_tmp0_);
}


/**
 * Clears the redo queue.
 */
#line 80 "ease-undo-controller.vala"
void ease_undo_controller_clear_redo (EaseUndoController* self) {
#line 80 "ease-undo-controller.vala"
	g_return_if_fail (self != NULL);
#line 82 "ease-undo-controller.vala"
	gee_abstract_collection_clear ((GeeAbstractCollection*) self->priv->redos);
#line 264 "ease-undo-controller.c"
}


/**
 * Adds a new {@link UndoItem} as the first action.
 *
 * @param action The new {@link UndoItem}.
 */
#line 90 "ease-undo-controller.vala"
void ease_undo_controller_add_action (EaseUndoController* self, EaseUndoItem* action) {
#line 90 "ease-undo-controller.vala"
	g_return_if_fail (self != NULL);
#line 90 "ease-undo-controller.vala"
	g_return_if_fail (action != NULL);
#line 92 "ease-undo-controller.vala"
	if (ease_undo_controller_get_enable_debug ()) {
#line 94 "ease-undo-controller.vala"
		if (G_TYPE_FROM_INSTANCE ((GObject*) action) == EASE_TYPE_UNDO_ACTION) {
#line 96 "ease-undo-controller.vala"
			fprintf (stdout, "UNDO ACTION ADDED WITH THESE PROPERTIES:\n");
#line 285 "ease-undo-controller.c"
			{
				EaseUndoItem* _tmp0_;
				GeeIterator* _pair_it;
#line 97 "ease-undo-controller.vala"
				_pair_it = gee_abstract_collection_iterator ((GeeAbstractCollection*) (_tmp0_ = action, EASE_IS_UNDO_ACTION (_tmp0_) ? ((EaseUndoAction*) _tmp0_) : NULL)->pairs);
#line 97 "ease-undo-controller.vala"
				while (TRUE) {
#line 293 "ease-undo-controller.c"
					EaseUndoActionUndoPair* pair;
#line 97 "ease-undo-controller.vala"
					if (!gee_iterator_next (_pair_it)) {
#line 97 "ease-undo-controller.vala"
						break;
#line 299 "ease-undo-controller.c"
					}
#line 97 "ease-undo-controller.vala"
					pair = (EaseUndoActionUndoPair*) gee_iterator_get (_pair_it);
#line 99 "ease-undo-controller.vala"
					fprintf (stdout, "\t%s\n", pair->property);
#line 305 "ease-undo-controller.c"
					_ease_undo_action_undo_pair_unref0 (pair);
				}
				_g_object_unref0 (_pair_it);
			}
#line 101 "ease-undo-controller.vala"
			fprintf (stdout, "\n");
#line 312 "ease-undo-controller.c"
		}
	}
#line 104 "ease-undo-controller.vala"
	gee_deque_offer_head ((GeeDeque*) self->priv->undos, action);
#line 317 "ease-undo-controller.c"
}


/**
 * Adds a new {@link UndoItem} as the first action.
 *
 * @param action The new {@link UndoItem}.
 */
#line 112 "ease-undo-controller.vala"
static void ease_undo_controller_add_redo_action (EaseUndoController* self, EaseUndoItem* action) {
#line 112 "ease-undo-controller.vala"
	g_return_if_fail (self != NULL);
#line 112 "ease-undo-controller.vala"
	g_return_if_fail (action != NULL);
#line 114 "ease-undo-controller.vala"
	if (ease_undo_controller_get_enable_debug ()) {
#line 116 "ease-undo-controller.vala"
		if (G_TYPE_FROM_INSTANCE ((GObject*) action) == EASE_TYPE_UNDO_ACTION) {
#line 118 "ease-undo-controller.vala"
			fprintf (stdout, "REDO ACTION ADDED WITH THESE PROPERTIES:\n");
#line 338 "ease-undo-controller.c"
			{
				EaseUndoItem* _tmp0_;
				GeeIterator* _pair_it;
#line 119 "ease-undo-controller.vala"
				_pair_it = gee_abstract_collection_iterator ((GeeAbstractCollection*) (_tmp0_ = action, EASE_IS_UNDO_ACTION (_tmp0_) ? ((EaseUndoAction*) _tmp0_) : NULL)->pairs);
#line 119 "ease-undo-controller.vala"
				while (TRUE) {
#line 346 "ease-undo-controller.c"
					EaseUndoActionUndoPair* pair;
#line 119 "ease-undo-controller.vala"
					if (!gee_iterator_next (_pair_it)) {
#line 119 "ease-undo-controller.vala"
						break;
#line 352 "ease-undo-controller.c"
					}
#line 119 "ease-undo-controller.vala"
					pair = (EaseUndoActionUndoPair*) gee_iterator_get (_pair_it);
#line 121 "ease-undo-controller.vala"
					fprintf (stdout, "\t%s\n", pair->property);
#line 358 "ease-undo-controller.c"
					_ease_undo_action_undo_pair_unref0 (pair);
				}
				_g_object_unref0 (_pair_it);
			}
#line 123 "ease-undo-controller.vala"
			fprintf (stdout, "\n");
#line 365 "ease-undo-controller.c"
		}
	}
#line 127 "ease-undo-controller.vala"
	gee_deque_offer_head ((GeeDeque*) self->priv->redos, action);
#line 370 "ease-undo-controller.c"
}


gboolean ease_undo_controller_get_enable_debug (void) {
	gboolean result;
	result = ease_undo_controller__enable_debug;
#line 38 "ease-undo-controller.vala"
	return result;
#line 379 "ease-undo-controller.c"
}


void ease_undo_controller_set_enable_debug (gboolean value) {
	ease_undo_controller__enable_debug = value;
}


static void ease_undo_controller_class_init (EaseUndoControllerClass * klass) {
	ease_undo_controller_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (EaseUndoControllerPrivate));
	G_OBJECT_CLASS (klass)->get_property = ease_undo_controller_get_property;
	G_OBJECT_CLASS (klass)->set_property = ease_undo_controller_set_property;
	G_OBJECT_CLASS (klass)->finalize = ease_undo_controller_finalize;
}


static void ease_undo_controller_instance_init (EaseUndoController * self) {
	self->priv = EASE_UNDO_CONTROLLER_GET_PRIVATE (self);
	self->priv->undos = gee_linked_list_new (EASE_TYPE_UNDO_ITEM, (GBoxedCopyFunc) g_object_ref, g_object_unref, NULL);
	self->priv->redos = gee_linked_list_new (EASE_TYPE_UNDO_ITEM, (GBoxedCopyFunc) g_object_ref, g_object_unref, NULL);
}


static void ease_undo_controller_finalize (GObject* obj) {
	EaseUndoController * self;
	self = EASE_UNDO_CONTROLLER (obj);
	_g_object_unref0 (self->priv->undos);
	_g_object_unref0 (self->priv->redos);
	G_OBJECT_CLASS (ease_undo_controller_parent_class)->finalize (obj);
}


/**
 * Controls undo and redo actions.
 *
 * Each EditorWindow has an UndoController that manages undo actions.
 */
GType ease_undo_controller_get_type (void) {
	static volatile gsize ease_undo_controller_type_id__volatile = 0;
	if (g_once_init_enter (&ease_undo_controller_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (EaseUndoControllerClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) ease_undo_controller_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (EaseUndoController), 0, (GInstanceInitFunc) ease_undo_controller_instance_init, NULL };
		GType ease_undo_controller_type_id;
		ease_undo_controller_type_id = g_type_register_static (G_TYPE_OBJECT, "EaseUndoController", &g_define_type_info, 0);
		g_once_init_leave (&ease_undo_controller_type_id__volatile, ease_undo_controller_type_id);
	}
	return ease_undo_controller_type_id__volatile;
}


static void ease_undo_controller_get_property (GObject * object, guint property_id, GValue * value, GParamSpec * pspec) {
	EaseUndoController * self;
	self = EASE_UNDO_CONTROLLER (object);
	switch (property_id) {
		default:
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
		break;
	}
}


static void ease_undo_controller_set_property (GObject * object, guint property_id, const GValue * value, GParamSpec * pspec) {
	EaseUndoController * self;
	self = EASE_UNDO_CONTROLLER (object);
	switch (property_id) {
		default:
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
		break;
	}
}




