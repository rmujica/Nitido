/* ease-actor.c generated by valac 0.10.0, the Vala compiler
 * generated from ease-actor.vala, do not modify */

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
#include <clutter/clutter.h>
#include <gtk/gtk.h>
#include <float.h>
#include <math.h>


#define EASE_TYPE_ACTOR (ease_actor_get_type ())
#define EASE_ACTOR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_ACTOR, EaseActor))
#define EASE_ACTOR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_ACTOR, EaseActorClass))
#define EASE_IS_ACTOR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_ACTOR))
#define EASE_IS_ACTOR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_ACTOR))
#define EASE_ACTOR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_ACTOR, EaseActorClass))

typedef struct _EaseActor EaseActor;
typedef struct _EaseActorClass EaseActorClass;
typedef struct _EaseActorPrivate EaseActorPrivate;

#define EASE_TYPE_ELEMENT (ease_element_get_type ())
#define EASE_ELEMENT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_ELEMENT, EaseElement))
#define EASE_ELEMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_ELEMENT, EaseElementClass))
#define EASE_IS_ELEMENT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_ELEMENT))
#define EASE_IS_ELEMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_ELEMENT))
#define EASE_ELEMENT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_ELEMENT, EaseElementClass))

typedef struct _EaseElement EaseElement;
typedef struct _EaseElementClass EaseElementClass;

#define EASE_TYPE_ACTOR_CONTEXT (ease_actor_context_get_type ())
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))
typedef struct _Block1Data Block1Data;

typedef enum  {
	EASE_ACTOR_CONTEXT_PRESENTATION,
	EASE_ACTOR_CONTEXT_EDITOR,
	EASE_ACTOR_CONTEXT_INSPECTOR
} EaseActorContext;

struct _EaseActor {
	ClutterGroup parent_instance;
	EaseActorPrivate * priv;
	ClutterActor* contents;
	EaseElement* element;
	EaseActorContext context;
	gboolean is_background;
};

struct _EaseActorClass {
	ClutterGroupClass parent_class;
	void (*edit) (EaseActor* self, GtkWidget* sender);
	void (*end_edit) (EaseActor* self, GtkWidget* sender);
};

struct _EaseActorPrivate {
	ClutterRectangle* editor_rect;
};

struct _Block1Data {
	int _ref_count_;
	EaseActor * self;
	ClutterActor* actor;
};


static gpointer ease_actor_parent_class = NULL;

GType ease_actor_get_type (void) G_GNUC_CONST;
GType ease_element_get_type (void) G_GNUC_CONST;
GType ease_actor_context_get_type (void) G_GNUC_CONST;
#define EASE_ACTOR_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), EASE_TYPE_ACTOR, EaseActorPrivate))
enum  {
	EASE_ACTOR_DUMMY_PROPERTY
};
#define EASE_ACTOR_RECT_WIDTH ((guint) 1)
EaseActor* ease_actor_construct (GType object_type, EaseElement* e, EaseActorContext c);
float ease_element_get_width (EaseElement* self);
float ease_element_get_height (EaseElement* self);
static void _lambda66_ (GObject* o, GParamSpec* p, EaseActor* self);
float ease_element_get_x (EaseElement* self);
static void __lambda66__g_object_notify (GObject* _sender, GParamSpec* pspec, gpointer self);
static void _lambda67_ (GObject* o, GParamSpec* p, EaseActor* self);
float ease_element_get_y (EaseElement* self);
static void __lambda67__g_object_notify (GObject* _sender, GParamSpec* pspec, gpointer self);
static void _lambda68_ (GObject* o, GParamSpec* p, EaseActor* self);
static void __lambda68__g_object_notify (GObject* _sender, GParamSpec* pspec, gpointer self);
static void _lambda69_ (GObject* o, GParamSpec* p, EaseActor* self);
static void __lambda69__g_object_notify (GObject* _sender, GParamSpec* pspec, gpointer self);
void ease_actor_autosize (EaseActor* self, ClutterActor* actor);
static void _lambda43_ (Block1Data* _data1_);
static void __lambda43__g_object_notify (GObject* _sender, GParamSpec* pspec, gpointer self);
static void _lambda44_ (Block1Data* _data1_);
static void __lambda44__g_object_notify (GObject* _sender, GParamSpec* pspec, gpointer self);
static Block1Data* block1_data_ref (Block1Data* _data1_);
static void block1_data_unref (Block1Data* _data1_);
void ease_actor_reposition (EaseActor* self);
void ease_actor_translate (EaseActor* self, float x_change, float y_change);
void ease_element_set_x (EaseElement* self, float value);
void ease_element_set_y (EaseElement* self, float value);
void ease_actor_resize (EaseActor* self, float w_change, float h_change, gboolean proportional);
void ease_element_set_width (EaseElement* self, float value);
void ease_element_set_height (EaseElement* self, float value);
void ease_actor_edit (EaseActor* self, GtkWidget* sender);
static void ease_actor_real_edit (EaseActor* self, GtkWidget* sender);
void ease_actor_end_edit (EaseActor* self, GtkWidget* sender);
static void ease_actor_real_end_edit (EaseActor* self, GtkWidget* sender);
static void ease_actor_finalize (GObject* obj);

static const ClutterColor EASE_ACTOR_RECT_COLOR = {(guchar) 0, (guchar) 0, (guchar) 0, (guchar) 0};
static const ClutterColor EASE_ACTOR_RECT_BORDER = {(guchar) 100, (guchar) 100, (guchar) 100, (guchar) 255};


/**
 * Instantiate a new Actor
 * 
 * Instantiates the Actor base class. In general, this should only be
 * called by subclasses.
 *
 * @param e The {@link Element} this Actor represents.
 * @param c The context of this Actor - sidebar, presentation, editor.
 */
#line 93 "ease-actor.vala"
static void _lambda66_ (GObject* o, GParamSpec* p, EaseActor* self) {
#line 93 "ease-actor.vala"
	g_return_if_fail (o != NULL);
#line 93 "ease-actor.vala"
	g_return_if_fail (p != NULL);
#line 93 "ease-actor.vala"
	clutter_actor_set_x ((ClutterActor*) self, ease_element_get_x (self->element));
#line 151 "ease-actor.c"
}


#line 93 "ease-actor.vala"
static void __lambda66__g_object_notify (GObject* _sender, GParamSpec* pspec, gpointer self) {
#line 157 "ease-actor.c"
	_lambda66_ (_sender, pspec, self);
}


#line 94 "ease-actor.vala"
static void _lambda67_ (GObject* o, GParamSpec* p, EaseActor* self) {
#line 94 "ease-actor.vala"
	g_return_if_fail (o != NULL);
#line 94 "ease-actor.vala"
	g_return_if_fail (p != NULL);
#line 94 "ease-actor.vala"
	clutter_actor_set_y ((ClutterActor*) self, ease_element_get_y (self->element));
#line 170 "ease-actor.c"
}


#line 94 "ease-actor.vala"
static void __lambda67__g_object_notify (GObject* _sender, GParamSpec* pspec, gpointer self) {
#line 176 "ease-actor.c"
	_lambda67_ (_sender, pspec, self);
}


#line 95 "ease-actor.vala"
static void _lambda68_ (GObject* o, GParamSpec* p, EaseActor* self) {
#line 95 "ease-actor.vala"
	g_return_if_fail (o != NULL);
#line 95 "ease-actor.vala"
	g_return_if_fail (p != NULL);
#line 96 "ease-actor.vala"
	clutter_actor_set_width ((ClutterActor*) self, ease_element_get_width (self->element));
#line 97 "ease-actor.vala"
	clutter_actor_set_width (self->contents, ease_element_get_width (self->element));
#line 98 "ease-actor.vala"
	if (self->priv->editor_rect != NULL) {
#line 98 "ease-actor.vala"
		clutter_actor_set_width ((ClutterActor*) self->priv->editor_rect, clutter_actor_get_width ((ClutterActor*) self));
#line 195 "ease-actor.c"
	}
}


#line 95 "ease-actor.vala"
static void __lambda68__g_object_notify (GObject* _sender, GParamSpec* pspec, gpointer self) {
#line 202 "ease-actor.c"
	_lambda68_ (_sender, pspec, self);
}


#line 100 "ease-actor.vala"
static void _lambda69_ (GObject* o, GParamSpec* p, EaseActor* self) {
#line 100 "ease-actor.vala"
	g_return_if_fail (o != NULL);
#line 100 "ease-actor.vala"
	g_return_if_fail (p != NULL);
#line 101 "ease-actor.vala"
	clutter_actor_set_height ((ClutterActor*) self, ease_element_get_height (self->element));
#line 102 "ease-actor.vala"
	clutter_actor_set_height (self->contents, ease_element_get_height (self->element));
#line 103 "ease-actor.vala"
	if (self->priv->editor_rect != NULL) {
#line 103 "ease-actor.vala"
		clutter_actor_set_height ((ClutterActor*) self->priv->editor_rect, clutter_actor_get_height ((ClutterActor*) self));
#line 221 "ease-actor.c"
	}
}


#line 100 "ease-actor.vala"
static void __lambda69__g_object_notify (GObject* _sender, GParamSpec* pspec, gpointer self) {
#line 228 "ease-actor.c"
	_lambda69_ (_sender, pspec, self);
}


#line 75 "ease-actor.vala"
EaseActor* ease_actor_construct (GType object_type, EaseElement* e, EaseActorContext c) {
#line 235 "ease-actor.c"
	EaseActor * self;
#line 75 "ease-actor.vala"
	g_return_val_if_fail (e != NULL, NULL);
#line 239 "ease-actor.c"
	self = g_object_newv (object_type, 0, NULL);
#line 77 "ease-actor.vala"
	self->element = e;
#line 78 "ease-actor.vala"
	self->context = c;
#line 79 "ease-actor.vala"
	self->is_background = FALSE;
#line 82 "ease-actor.vala"
	if (c == EASE_ACTOR_CONTEXT_EDITOR) {
#line 249 "ease-actor.c"
		ClutterRectangle* _tmp0_;
		ClutterColor _tmp1_;
#line 84 "ease-actor.vala"
		self->priv->editor_rect = (_tmp0_ = g_object_ref_sink ((ClutterRectangle*) clutter_rectangle_new_with_color (&EASE_ACTOR_RECT_COLOR)), _g_object_unref0 (self->priv->editor_rect), _tmp0_);
#line 85 "ease-actor.vala"
		clutter_rectangle_set_border_color (self->priv->editor_rect, (_tmp1_ = EASE_ACTOR_RECT_BORDER, &_tmp1_));
#line 86 "ease-actor.vala"
		clutter_rectangle_set_border_width (self->priv->editor_rect, EASE_ACTOR_RECT_WIDTH);
#line 87 "ease-actor.vala"
		clutter_actor_set_width ((ClutterActor*) self->priv->editor_rect, ease_element_get_width (e));
#line 88 "ease-actor.vala"
		clutter_actor_set_height ((ClutterActor*) self->priv->editor_rect, ease_element_get_height (e));
#line 89 "ease-actor.vala"
		clutter_container_add_actor ((ClutterContainer*) self, (ClutterActor*) self->priv->editor_rect);
#line 264 "ease-actor.c"
	}
#line 93 "ease-actor.vala"
	g_signal_connect_object ((GObject*) e, "notify::x", (GCallback) __lambda66__g_object_notify, self, 0);
#line 94 "ease-actor.vala"
	g_signal_connect_object ((GObject*) e, "notify::y", (GCallback) __lambda67__g_object_notify, self, 0);
#line 95 "ease-actor.vala"
	g_signal_connect_object ((GObject*) e, "notify::width", (GCallback) __lambda68__g_object_notify, self, 0);
#line 100 "ease-actor.vala"
	g_signal_connect_object ((GObject*) e, "notify::height", (GCallback) __lambda69__g_object_notify, self, 0);
#line 274 "ease-actor.c"
	return self;
}


/**
 * Automatically resizes an actor to fit within this Actor's bounds.
 *
 * @param actor The actor to automatically scale.
 */
#line 114 "ease-actor.vala"
static void _lambda43_ (Block1Data* _data1_) {
#line 286 "ease-actor.c"
	EaseActor * self;
	self = _data1_->self;
#line 115 "ease-actor.vala"
	clutter_actor_set_width (_data1_->actor, clutter_actor_get_width ((ClutterActor*) self));
#line 291 "ease-actor.c"
}


#line 114 "ease-actor.vala"
static void __lambda43__g_object_notify (GObject* _sender, GParamSpec* pspec, gpointer self) {
#line 297 "ease-actor.c"
	_lambda43_ (self);
}


#line 118 "ease-actor.vala"
static void _lambda44_ (Block1Data* _data1_) {
#line 304 "ease-actor.c"
	EaseActor * self;
	self = _data1_->self;
#line 119 "ease-actor.vala"
	clutter_actor_set_height (_data1_->actor, clutter_actor_get_height ((ClutterActor*) self));
#line 309 "ease-actor.c"
}


#line 118 "ease-actor.vala"
static void __lambda44__g_object_notify (GObject* _sender, GParamSpec* pspec, gpointer self) {
#line 315 "ease-actor.c"
	_lambda44_ (self);
}


static gpointer _g_object_ref0 (gpointer self) {
	return self ? g_object_ref (self) : NULL;
}


static Block1Data* block1_data_ref (Block1Data* _data1_) {
	g_atomic_int_inc (&_data1_->_ref_count_);
	return _data1_;
}


static void block1_data_unref (Block1Data* _data1_) {
	if (g_atomic_int_dec_and_test (&_data1_->_ref_count_)) {
		_g_object_unref0 (_data1_->self);
		_g_object_unref0 (_data1_->actor);
		g_slice_free (Block1Data, _data1_);
	}
}


#line 112 "ease-actor.vala"
void ease_actor_autosize (EaseActor* self, ClutterActor* actor) {
#line 342 "ease-actor.c"
	Block1Data* _data1_;
#line 112 "ease-actor.vala"
	g_return_if_fail (self != NULL);
#line 112 "ease-actor.vala"
	g_return_if_fail (actor != NULL);
#line 348 "ease-actor.c"
	_data1_ = g_slice_new0 (Block1Data);
	_data1_->_ref_count_ = 1;
	_data1_->self = g_object_ref (self);
	_data1_->actor = _g_object_ref0 (actor);
#line 114 "ease-actor.vala"
	g_signal_connect_data ((GObject*) self->contents, "notify::width", (GCallback) __lambda43__g_object_notify, block1_data_ref (_data1_), (GClosureNotify) block1_data_unref, 0);
#line 118 "ease-actor.vala"
	g_signal_connect_data ((GObject*) self->contents, "notify::height", (GCallback) __lambda44__g_object_notify, block1_data_ref (_data1_), (GClosureNotify) block1_data_unref, 0);
#line 357 "ease-actor.c"
	block1_data_unref (_data1_);
}


/**
 * Rereads the Actor's {@link Element} to position it properly.
 *
 * Used after reverting an action.
 */
#line 128 "ease-actor.vala"
void ease_actor_reposition (EaseActor* self) {
#line 128 "ease-actor.vala"
	g_return_if_fail (self != NULL);
#line 130 "ease-actor.vala"
	clutter_actor_set_x ((ClutterActor*) self, ease_element_get_x (self->element));
#line 131 "ease-actor.vala"
	clutter_actor_set_y ((ClutterActor*) self, ease_element_get_y (self->element));
#line 132 "ease-actor.vala"
	clutter_actor_set_width ((ClutterActor*) self, ease_element_get_width (self->element));
#line 133 "ease-actor.vala"
	clutter_actor_set_height ((ClutterActor*) self, ease_element_get_height (self->element));
#line 134 "ease-actor.vala"
	clutter_actor_set_width (self->contents, clutter_actor_get_width ((ClutterActor*) self));
#line 135 "ease-actor.vala"
	clutter_actor_set_height (self->contents, clutter_actor_get_height ((ClutterActor*) self));
#line 137 "ease-actor.vala"
	if (self->priv->editor_rect != NULL) {
#line 139 "ease-actor.vala"
		clutter_actor_set_width ((ClutterActor*) self->priv->editor_rect, clutter_actor_get_width ((ClutterActor*) self));
#line 140 "ease-actor.vala"
		clutter_actor_set_height ((ClutterActor*) self->priv->editor_rect, clutter_actor_get_height ((ClutterActor*) self));
#line 389 "ease-actor.c"
	}
}


/**
 * Move this Actor and update its {@link Element}
 * 
 * Used in the editor and tied to Clutter MotionEvents.
 *
 * @param x_change The amount of X motion.
 * @param y_change The amount of Y motion.
 */
#line 152 "ease-actor.vala"
void ease_actor_translate (EaseActor* self, float x_change, float y_change) {
#line 152 "ease-actor.vala"
	g_return_if_fail (self != NULL);
#line 154 "ease-actor.vala"
	clutter_actor_set_x ((ClutterActor*) self, clutter_actor_get_x ((ClutterActor*) self) + x_change);
#line 155 "ease-actor.vala"
	clutter_actor_set_y ((ClutterActor*) self, clutter_actor_get_y ((ClutterActor*) self) + y_change);
#line 157 "ease-actor.vala"
	ease_element_set_x (self->element, clutter_actor_get_x ((ClutterActor*) self));
#line 158 "ease-actor.vala"
	ease_element_set_y (self->element, clutter_actor_get_y ((ClutterActor*) self));
#line 414 "ease-actor.c"
}


/**
 * Resize this Actor and update its {@link Element}
 * 
 * Used in the editor and tied to Clutter MotionEvents on handles.
 *
 * @param w_change The amount of width change.
 * @param h_change The amount of height change.
 * @param proportional If the resize should be proportional only
 */
#line 170 "ease-actor.vala"
void ease_actor_resize (EaseActor* self, float w_change, float h_change, gboolean proportional) {
#line 170 "ease-actor.vala"
	g_return_if_fail (self != NULL);
#line 172 "ease-actor.vala"
	if (proportional) {
#line 174 "ease-actor.vala"
		if ((w_change / h_change) > (clutter_actor_get_width ((ClutterActor*) self) / clutter_actor_get_height ((ClutterActor*) self))) {
#line 176 "ease-actor.vala"
			w_change = h_change * (clutter_actor_get_width ((ClutterActor*) self) / clutter_actor_get_height ((ClutterActor*) self));
#line 437 "ease-actor.c"
		} else {
#line 178 "ease-actor.vala"
			if ((w_change / h_change) < (clutter_actor_get_width ((ClutterActor*) self) / clutter_actor_get_height ((ClutterActor*) self))) {
#line 180 "ease-actor.vala"
				h_change = w_change * (clutter_actor_get_height ((ClutterActor*) self) / clutter_actor_get_width ((ClutterActor*) self));
#line 443 "ease-actor.c"
			}
		}
	}
#line 184 "ease-actor.vala"
	if ((clutter_actor_get_width ((ClutterActor*) self) + w_change) > 1) {
#line 186 "ease-actor.vala"
		clutter_actor_set_width ((ClutterActor*) self, clutter_actor_get_width ((ClutterActor*) self) + w_change);
#line 187 "ease-actor.vala"
		clutter_actor_set_width (self->contents, clutter_actor_get_width (self->contents) + w_change);
#line 453 "ease-actor.c"
	}
#line 189 "ease-actor.vala"
	if ((clutter_actor_get_height ((ClutterActor*) self) + h_change) > 1) {
#line 191 "ease-actor.vala"
		clutter_actor_set_height ((ClutterActor*) self, clutter_actor_get_height ((ClutterActor*) self) + h_change);
#line 192 "ease-actor.vala"
		clutter_actor_set_height (self->contents, clutter_actor_get_height (self->contents) + h_change);
#line 461 "ease-actor.c"
	}
#line 195 "ease-actor.vala"
	ease_element_set_width (self->element, clutter_actor_get_width ((ClutterActor*) self));
#line 196 "ease-actor.vala"
	ease_element_set_height (self->element, clutter_actor_get_height ((ClutterActor*) self));
#line 467 "ease-actor.c"
}


/**
 * Called when the actor should be edited. Subclasses should override this.
 *
 * @param sender The widget this Actor is on.
 */
#line 204 "ease-actor.vala"
static void ease_actor_real_edit (EaseActor* self, GtkWidget* sender) {
#line 204 "ease-actor.vala"
	g_return_if_fail (self != NULL);
#line 204 "ease-actor.vala"
	g_return_if_fail (sender != NULL);
#line 482 "ease-actor.c"
}


void ease_actor_edit (EaseActor* self, GtkWidget* sender) {
	EASE_ACTOR_GET_CLASS (self)->edit (self, sender);
}


/**
 * Called when the actor end editing. Subclasses with editing that is not
 * instant (popping up a dialog box) should override this.
 *
 * @param sender The widget this Actor is on.
 */
#line 212 "ease-actor.vala"
static void ease_actor_real_end_edit (EaseActor* self, GtkWidget* sender) {
#line 212 "ease-actor.vala"
	g_return_if_fail (self != NULL);
#line 212 "ease-actor.vala"
	g_return_if_fail (sender != NULL);
#line 503 "ease-actor.c"
}


void ease_actor_end_edit (EaseActor* self, GtkWidget* sender) {
	EASE_ACTOR_GET_CLASS (self)->end_edit (self, sender);
}


static void ease_actor_class_init (EaseActorClass * klass) {
	ease_actor_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (EaseActorPrivate));
	EASE_ACTOR_CLASS (klass)->edit = ease_actor_real_edit;
	EASE_ACTOR_CLASS (klass)->end_edit = ease_actor_real_end_edit;
	G_OBJECT_CLASS (klass)->finalize = ease_actor_finalize;
}


static void ease_actor_instance_init (EaseActor * self) {
	self->priv = EASE_ACTOR_GET_PRIVATE (self);
}


static void ease_actor_finalize (GObject* obj) {
	EaseActor * self;
	self = EASE_ACTOR (obj);
	_g_object_unref0 (self->contents);
	_g_object_unref0 (self->priv->editor_rect);
	G_OBJECT_CLASS (ease_actor_parent_class)->finalize (obj);
}


/**
 * The basic Ease actor, subclassed for different types of
 * {@link Element}.
 *
 * The Actor class should never be instantiated - instead,
 * subclasses such as {@link TextActor} and {@link ImageActor}
 * are placed on a SlideActor to form Ease presentations.
 */
GType ease_actor_get_type (void) {
	static volatile gsize ease_actor_type_id__volatile = 0;
	if (g_once_init_enter (&ease_actor_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (EaseActorClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) ease_actor_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (EaseActor), 0, (GInstanceInitFunc) ease_actor_instance_init, NULL };
		GType ease_actor_type_id;
		ease_actor_type_id = g_type_register_static (CLUTTER_TYPE_GROUP, "EaseActor", &g_define_type_info, G_TYPE_FLAG_ABSTRACT);
		g_once_init_leave (&ease_actor_type_id__volatile, ease_actor_type_id);
	}
	return ease_actor_type_id__volatile;
}




