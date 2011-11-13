/* ease-undo-actions-slide.c generated by valac 0.10.0, the Vala compiler
 * generated from ease-undo-actions-slide.vala, do not modify */

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


#define EASE_TYPE_UNDO_ITEM (ease_undo_item_get_type ())
#define EASE_UNDO_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_UNDO_ITEM, EaseUndoItem))
#define EASE_UNDO_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_UNDO_ITEM, EaseUndoItemClass))
#define EASE_IS_UNDO_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_UNDO_ITEM))
#define EASE_IS_UNDO_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_UNDO_ITEM))
#define EASE_UNDO_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_UNDO_ITEM, EaseUndoItemClass))

typedef struct _EaseUndoItem EaseUndoItem;
typedef struct _EaseUndoItemClass EaseUndoItemClass;
typedef struct _EaseUndoItemPrivate EaseUndoItemPrivate;

#define EASE_TYPE_SLIDE_ADD_UNDO_ACTION (ease_slide_add_undo_action_get_type ())
#define EASE_SLIDE_ADD_UNDO_ACTION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_SLIDE_ADD_UNDO_ACTION, EaseSlideAddUndoAction))
#define EASE_SLIDE_ADD_UNDO_ACTION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_SLIDE_ADD_UNDO_ACTION, EaseSlideAddUndoActionClass))
#define EASE_IS_SLIDE_ADD_UNDO_ACTION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_SLIDE_ADD_UNDO_ACTION))
#define EASE_IS_SLIDE_ADD_UNDO_ACTION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_SLIDE_ADD_UNDO_ACTION))
#define EASE_SLIDE_ADD_UNDO_ACTION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_SLIDE_ADD_UNDO_ACTION, EaseSlideAddUndoActionClass))

typedef struct _EaseSlideAddUndoAction EaseSlideAddUndoAction;
typedef struct _EaseSlideAddUndoActionClass EaseSlideAddUndoActionClass;
typedef struct _EaseSlideAddUndoActionPrivate EaseSlideAddUndoActionPrivate;

#define EASE_TYPE_SLIDE (ease_slide_get_type ())
#define EASE_SLIDE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_SLIDE, EaseSlide))
#define EASE_SLIDE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_SLIDE, EaseSlideClass))
#define EASE_IS_SLIDE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_SLIDE))
#define EASE_IS_SLIDE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_SLIDE))
#define EASE_SLIDE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_SLIDE, EaseSlideClass))

typedef struct _EaseSlide EaseSlide;
typedef struct _EaseSlideClass EaseSlideClass;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))

#define EASE_TYPE_SLIDE_REMOVE_UNDO_ACTION (ease_slide_remove_undo_action_get_type ())
#define EASE_SLIDE_REMOVE_UNDO_ACTION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_SLIDE_REMOVE_UNDO_ACTION, EaseSlideRemoveUndoAction))
#define EASE_SLIDE_REMOVE_UNDO_ACTION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_SLIDE_REMOVE_UNDO_ACTION, EaseSlideRemoveUndoActionClass))
#define EASE_IS_SLIDE_REMOVE_UNDO_ACTION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_SLIDE_REMOVE_UNDO_ACTION))
#define EASE_IS_SLIDE_REMOVE_UNDO_ACTION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_SLIDE_REMOVE_UNDO_ACTION))
#define EASE_SLIDE_REMOVE_UNDO_ACTION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_SLIDE_REMOVE_UNDO_ACTION, EaseSlideRemoveUndoActionClass))

typedef struct _EaseSlideRemoveUndoAction EaseSlideRemoveUndoAction;
typedef struct _EaseSlideRemoveUndoActionClass EaseSlideRemoveUndoActionClass;

#define EASE_TYPE_DOCUMENT (ease_document_get_type ())
#define EASE_DOCUMENT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_DOCUMENT, EaseDocument))
#define EASE_DOCUMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_DOCUMENT, EaseDocumentClass))
#define EASE_IS_DOCUMENT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_DOCUMENT))
#define EASE_IS_DOCUMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_DOCUMENT))
#define EASE_DOCUMENT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_DOCUMENT, EaseDocumentClass))

typedef struct _EaseDocument EaseDocument;
typedef struct _EaseDocumentClass EaseDocumentClass;
typedef struct _EaseSlideRemoveUndoActionPrivate EaseSlideRemoveUndoActionPrivate;

struct _EaseUndoItem {
	GObject parent_instance;
	EaseUndoItemPrivate * priv;
};

struct _EaseUndoItemClass {
	GObjectClass parent_class;
	EaseUndoItem* (*apply) (EaseUndoItem* self);
	gboolean (*contains) (EaseUndoItem* self, GObject* obj);
};

struct _EaseSlideAddUndoAction {
	EaseUndoItem parent_instance;
	EaseSlideAddUndoActionPrivate * priv;
};

struct _EaseSlideAddUndoActionClass {
	EaseUndoItemClass parent_class;
};

struct _EaseSlideAddUndoActionPrivate {
	EaseSlide* slide;
};

struct _EaseSlideRemoveUndoAction {
	EaseUndoItem parent_instance;
	EaseSlideRemoveUndoActionPrivate * priv;
};

struct _EaseSlideRemoveUndoActionClass {
	EaseUndoItemClass parent_class;
};

struct _EaseSlideRemoveUndoActionPrivate {
	EaseSlide* slide;
	EaseDocument* document;
	gint index;
};


static gpointer ease_slide_add_undo_action_parent_class = NULL;
static gpointer ease_slide_remove_undo_action_parent_class = NULL;

GType ease_undo_item_get_type (void) G_GNUC_CONST;
GType ease_slide_add_undo_action_get_type (void) G_GNUC_CONST;
GType ease_slide_get_type (void) G_GNUC_CONST;
#define EASE_SLIDE_ADD_UNDO_ACTION_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), EASE_TYPE_SLIDE_ADD_UNDO_ACTION, EaseSlideAddUndoActionPrivate))
enum  {
	EASE_SLIDE_ADD_UNDO_ACTION_DUMMY_PROPERTY
};
EaseSlideAddUndoAction* ease_slide_add_undo_action_new (EaseSlide* s);
EaseSlideAddUndoAction* ease_slide_add_undo_action_construct (GType object_type, EaseSlide* s);
EaseUndoItem* ease_undo_item_construct (GType object_type);
static EaseUndoItem* ease_slide_add_undo_action_real_apply (EaseUndoItem* base);
EaseSlideRemoveUndoAction* ease_slide_remove_undo_action_new (EaseSlide* s);
EaseSlideRemoveUndoAction* ease_slide_remove_undo_action_construct (GType object_type, EaseSlide* s);
GType ease_slide_remove_undo_action_get_type (void) G_GNUC_CONST;
GType ease_document_get_type (void) G_GNUC_CONST;
EaseDocument* ease_slide_get_parent (EaseSlide* self);
EaseSlide* ease_document_remove_slide_actual (EaseDocument* self, EaseSlide* slide, gboolean emit_undo);
static void ease_slide_add_undo_action_finalize (GObject* obj);
#define EASE_SLIDE_REMOVE_UNDO_ACTION_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), EASE_TYPE_SLIDE_REMOVE_UNDO_ACTION, EaseSlideRemoveUndoActionPrivate))
enum  {
	EASE_SLIDE_REMOVE_UNDO_ACTION_DUMMY_PROPERTY
};
gint ease_document_index_of (EaseDocument* self, EaseSlide* slide);
static EaseUndoItem* ease_slide_remove_undo_action_real_apply (EaseUndoItem* base);
void ease_document_add_slide_actual (EaseDocument* self, gint index, EaseSlide* slide, gboolean emit_undo);
static void ease_slide_remove_undo_action_finalize (GObject* obj);



/**
 * Creates an SlideAddUndoAction.
 *
 * @param s The slide that was added.
 */
static gpointer _g_object_ref0 (gpointer self) {
	return self ? g_object_ref (self) : NULL;
}


#line 33 "ease-undo-actions-slide.vala"
EaseSlideAddUndoAction* ease_slide_add_undo_action_construct (GType object_type, EaseSlide* s) {
#line 164 "ease-undo-actions-slide.c"
	EaseSlideAddUndoAction * self;
	EaseSlide* _tmp0_;
#line 33 "ease-undo-actions-slide.vala"
	g_return_val_if_fail (s != NULL, NULL);
#line 33 "ease-undo-actions-slide.vala"
	self = (EaseSlideAddUndoAction*) ease_undo_item_construct (object_type);
#line 35 "ease-undo-actions-slide.vala"
	self->priv->slide = (_tmp0_ = _g_object_ref0 (s), _g_object_unref0 (self->priv->slide), _tmp0_);
#line 173 "ease-undo-actions-slide.c"
	return self;
}


#line 33 "ease-undo-actions-slide.vala"
EaseSlideAddUndoAction* ease_slide_add_undo_action_new (EaseSlide* s) {
#line 33 "ease-undo-actions-slide.vala"
	return ease_slide_add_undo_action_construct (EASE_TYPE_SLIDE_ADD_UNDO_ACTION, s);
#line 182 "ease-undo-actions-slide.c"
}


/**
 * Applies the action, removing the {@link Slide}.
 */
#line 41 "ease-undo-actions-slide.vala"
static EaseUndoItem* ease_slide_add_undo_action_real_apply (EaseUndoItem* base) {
#line 191 "ease-undo-actions-slide.c"
	EaseSlideAddUndoAction * self;
	EaseUndoItem* result = NULL;
	EaseSlideRemoveUndoAction* action;
	EaseSlide* _tmp0_;
	self = (EaseSlideAddUndoAction*) base;
#line 43 "ease-undo-actions-slide.vala"
	action = ease_slide_remove_undo_action_new (self->priv->slide);
#line 44 "ease-undo-actions-slide.vala"
	_tmp0_ = ease_document_remove_slide_actual (ease_slide_get_parent (self->priv->slide), self->priv->slide, FALSE);
#line 201 "ease-undo-actions-slide.c"
	_g_object_unref0 (_tmp0_);
	result = (EaseUndoItem*) action;
#line 45 "ease-undo-actions-slide.vala"
	return result;
#line 206 "ease-undo-actions-slide.c"
}


static void ease_slide_add_undo_action_class_init (EaseSlideAddUndoActionClass * klass) {
	ease_slide_add_undo_action_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (EaseSlideAddUndoActionPrivate));
	EASE_UNDO_ITEM_CLASS (klass)->apply = ease_slide_add_undo_action_real_apply;
	G_OBJECT_CLASS (klass)->finalize = ease_slide_add_undo_action_finalize;
}


static void ease_slide_add_undo_action_instance_init (EaseSlideAddUndoAction * self) {
	self->priv = EASE_SLIDE_ADD_UNDO_ACTION_GET_PRIVATE (self);
}


static void ease_slide_add_undo_action_finalize (GObject* obj) {
	EaseSlideAddUndoAction * self;
	self = EASE_SLIDE_ADD_UNDO_ACTION (obj);
	_g_object_unref0 (self->priv->slide);
	G_OBJECT_CLASS (ease_slide_add_undo_action_parent_class)->finalize (obj);
}


/**
 * Undos the addition of an {@link Slide} to a {@link Document}.
 */
GType ease_slide_add_undo_action_get_type (void) {
	static volatile gsize ease_slide_add_undo_action_type_id__volatile = 0;
	if (g_once_init_enter (&ease_slide_add_undo_action_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (EaseSlideAddUndoActionClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) ease_slide_add_undo_action_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (EaseSlideAddUndoAction), 0, (GInstanceInitFunc) ease_slide_add_undo_action_instance_init, NULL };
		GType ease_slide_add_undo_action_type_id;
		ease_slide_add_undo_action_type_id = g_type_register_static (EASE_TYPE_UNDO_ITEM, "EaseSlideAddUndoAction", &g_define_type_info, 0);
		g_once_init_leave (&ease_slide_add_undo_action_type_id__volatile, ease_slide_add_undo_action_type_id);
	}
	return ease_slide_add_undo_action_type_id__volatile;
}


/**
 * Creates an SlideRemoveUndoAction. Note that this method references
 * {@link Slide.parent}. Therefore, the action must be constructed
 * before the Slide is actually removed.
 *
 * @param s The slide that was added.
 */
#line 76 "ease-undo-actions-slide.vala"
EaseSlideRemoveUndoAction* ease_slide_remove_undo_action_construct (GType object_type, EaseSlide* s) {
#line 255 "ease-undo-actions-slide.c"
	EaseSlideRemoveUndoAction * self;
	EaseSlide* _tmp0_;
	EaseDocument* _tmp1_;
#line 76 "ease-undo-actions-slide.vala"
	g_return_val_if_fail (s != NULL, NULL);
#line 76 "ease-undo-actions-slide.vala"
	self = (EaseSlideRemoveUndoAction*) ease_undo_item_construct (object_type);
#line 78 "ease-undo-actions-slide.vala"
	self->priv->slide = (_tmp0_ = _g_object_ref0 (s), _g_object_unref0 (self->priv->slide), _tmp0_);
#line 79 "ease-undo-actions-slide.vala"
	self->priv->document = (_tmp1_ = _g_object_ref0 (ease_slide_get_parent (s)), _g_object_unref0 (self->priv->document), _tmp1_);
#line 80 "ease-undo-actions-slide.vala"
	self->priv->index = ease_document_index_of (ease_slide_get_parent (s), s);
#line 269 "ease-undo-actions-slide.c"
	return self;
}


#line 76 "ease-undo-actions-slide.vala"
EaseSlideRemoveUndoAction* ease_slide_remove_undo_action_new (EaseSlide* s) {
#line 76 "ease-undo-actions-slide.vala"
	return ease_slide_remove_undo_action_construct (EASE_TYPE_SLIDE_REMOVE_UNDO_ACTION, s);
#line 278 "ease-undo-actions-slide.c"
}


/**
 * Applies the action, restoring the {@link Slide}.
 */
#line 86 "ease-undo-actions-slide.vala"
static EaseUndoItem* ease_slide_remove_undo_action_real_apply (EaseUndoItem* base) {
#line 287 "ease-undo-actions-slide.c"
	EaseSlideRemoveUndoAction * self;
	EaseUndoItem* result = NULL;
	self = (EaseSlideRemoveUndoAction*) base;
#line 88 "ease-undo-actions-slide.vala"
	ease_document_add_slide_actual (self->priv->document, self->priv->index, self->priv->slide, FALSE);
#line 293 "ease-undo-actions-slide.c"
	result = (EaseUndoItem*) ease_slide_add_undo_action_new (self->priv->slide);
#line 89 "ease-undo-actions-slide.vala"
	return result;
#line 297 "ease-undo-actions-slide.c"
}


static void ease_slide_remove_undo_action_class_init (EaseSlideRemoveUndoActionClass * klass) {
	ease_slide_remove_undo_action_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (EaseSlideRemoveUndoActionPrivate));
	EASE_UNDO_ITEM_CLASS (klass)->apply = ease_slide_remove_undo_action_real_apply;
	G_OBJECT_CLASS (klass)->finalize = ease_slide_remove_undo_action_finalize;
}


static void ease_slide_remove_undo_action_instance_init (EaseSlideRemoveUndoAction * self) {
	self->priv = EASE_SLIDE_REMOVE_UNDO_ACTION_GET_PRIVATE (self);
}


static void ease_slide_remove_undo_action_finalize (GObject* obj) {
	EaseSlideRemoveUndoAction * self;
	self = EASE_SLIDE_REMOVE_UNDO_ACTION (obj);
	_g_object_unref0 (self->priv->slide);
	_g_object_unref0 (self->priv->document);
	G_OBJECT_CLASS (ease_slide_remove_undo_action_parent_class)->finalize (obj);
}


/**
 * Undos the removal of an {@link Slide} from a {@link Document}.
 */
GType ease_slide_remove_undo_action_get_type (void) {
	static volatile gsize ease_slide_remove_undo_action_type_id__volatile = 0;
	if (g_once_init_enter (&ease_slide_remove_undo_action_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (EaseSlideRemoveUndoActionClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) ease_slide_remove_undo_action_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (EaseSlideRemoveUndoAction), 0, (GInstanceInitFunc) ease_slide_remove_undo_action_instance_init, NULL };
		GType ease_slide_remove_undo_action_type_id;
		ease_slide_remove_undo_action_type_id = g_type_register_static (EASE_TYPE_UNDO_ITEM, "EaseSlideRemoveUndoAction", &g_define_type_info, 0);
		g_once_init_leave (&ease_slide_remove_undo_action_type_id__volatile, ease_slide_remove_undo_action_type_id);
	}
	return ease_slide_remove_undo_action_type_id__volatile;
}



