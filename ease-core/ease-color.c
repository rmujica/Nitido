/* ease-color.c generated by valac 0.10.0, the Vala compiler
 * generated from ease-color.vala, do not modify */

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
#include <float.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <clutter/clutter.h>
#include <gdk/gdk.h>
#include <cairo.h>


#define EASE_TYPE_COLOR (ease_color_get_type ())
#define EASE_COLOR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_COLOR, EaseColor))
#define EASE_COLOR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_COLOR, EaseColorClass))
#define EASE_IS_COLOR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_COLOR))
#define EASE_IS_COLOR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_COLOR))
#define EASE_COLOR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_COLOR, EaseColorClass))

typedef struct _EaseColor EaseColor;
typedef struct _EaseColorClass EaseColorClass;
typedef struct _EaseColorPrivate EaseColorPrivate;
#define _g_free0(var) (var = (g_free (var), NULL))
#define _g_regex_unref0(var) ((var == NULL) ? NULL : (var = (g_regex_unref (var), NULL)))
#define _g_error_free0(var) ((var == NULL) ? NULL : (var = (g_error_free (var), NULL)))

#define EASE_TYPE_UNDO_ITEM (ease_undo_item_get_type ())
#define EASE_UNDO_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_UNDO_ITEM, EaseUndoItem))
#define EASE_UNDO_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_UNDO_ITEM, EaseUndoItemClass))
#define EASE_IS_UNDO_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_UNDO_ITEM))
#define EASE_IS_UNDO_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_UNDO_ITEM))
#define EASE_UNDO_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_UNDO_ITEM, EaseUndoItemClass))

typedef struct _EaseUndoItem EaseUndoItem;
typedef struct _EaseUndoItemClass EaseUndoItemClass;

#define EASE_TYPE_UNDO_ACTION (ease_undo_action_get_type ())
#define EASE_UNDO_ACTION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_UNDO_ACTION, EaseUndoAction))
#define EASE_UNDO_ACTION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_UNDO_ACTION, EaseUndoActionClass))
#define EASE_IS_UNDO_ACTION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_UNDO_ACTION))
#define EASE_IS_UNDO_ACTION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_UNDO_ACTION))
#define EASE_UNDO_ACTION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_UNDO_ACTION, EaseUndoActionClass))

typedef struct _EaseUndoAction EaseUndoAction;
typedef struct _EaseUndoActionClass EaseUndoActionClass;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))

struct _EaseColor {
	GObject parent_instance;
	EaseColorPrivate * priv;
};

struct _EaseColorClass {
	GObjectClass parent_class;
};

struct _EaseColorPrivate {
	double red_priv;
	double green_priv;
	double blue_priv;
	double alpha_priv;
};


static gpointer ease_color_parent_class = NULL;

GType ease_color_get_type (void) G_GNUC_CONST;
#define EASE_COLOR_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), EASE_TYPE_COLOR, EaseColorPrivate))
enum  {
	EASE_COLOR_DUMMY_PROPERTY,
	EASE_COLOR_RED,
	EASE_COLOR_GREEN,
	EASE_COLOR_BLUE,
	EASE_COLOR_ALPHA,
	EASE_COLOR_RED8,
	EASE_COLOR_GREEN8,
	EASE_COLOR_BLUE8,
	EASE_COLOR_ALPHA8,
	EASE_COLOR_CLUTTER,
	EASE_COLOR_GDK
};
#define EASE_COLOR_STR "%f%s %f%s %f%s %f"
#define EASE_COLOR_SPLIT ","
EaseColor* ease_color_new_rgb (double r, double g, double b);
EaseColor* ease_color_construct_rgb (GType object_type, double r, double g, double b);
EaseColor* ease_color_new_rgba (double r, double g, double b, double a);
EaseColor* ease_color_construct_rgba (GType object_type, double r, double g, double b, double a);
void ease_color_set_red (EaseColor* self, double value);
void ease_color_set_green (EaseColor* self, double value);
void ease_color_set_blue (EaseColor* self, double value);
void ease_color_set_alpha (EaseColor* self, double value);
EaseColor* ease_color_new_from_clutter (ClutterColor* color);
EaseColor* ease_color_construct_from_clutter (GType object_type, ClutterColor* color);
void ease_color_set_clutter (EaseColor* self, ClutterColor* value);
EaseColor* ease_color_new_from_gdk (GdkColor* color);
EaseColor* ease_color_construct_from_gdk (GType object_type, GdkColor* color);
void ease_color_set_gdk (EaseColor* self, GdkColor* value);
EaseColor* ease_color_new_from_string (const char* str);
EaseColor* ease_color_construct_from_string (GType object_type, const char* str);
char* ease_color_to_string (EaseColor* self);
double ease_color_get_red (EaseColor* self);
double ease_color_get_green (EaseColor* self);
double ease_color_get_blue (EaseColor* self);
double ease_color_get_alpha (EaseColor* self);
EaseColor* ease_color_copy (EaseColor* self);
void ease_color_set_cairo (EaseColor* self, cairo_t* cr);
GType ease_undo_item_get_type (void) G_GNUC_CONST;
GType ease_undo_action_get_type (void) G_GNUC_CONST;
EaseUndoAction* ease_color_undo_action (EaseColor* self);
EaseUndoAction* ease_undo_action_new (GObject* obj, const char* prop);
EaseUndoAction* ease_undo_action_construct (GType object_type, GObject* obj, const char* prop);
void ease_undo_action_add (EaseUndoAction* self, GObject* obj, const char* prop);
EaseColor* ease_color_new (void);
EaseColor* ease_color_construct (GType object_type);
EaseColor* ease_color_get_white (void);
EaseColor* ease_color_get_black (void);
guint8 ease_color_get_red8 (EaseColor* self);
void ease_color_set_red8 (EaseColor* self, guint8 value);
guint8 ease_color_get_green8 (EaseColor* self);
void ease_color_set_green8 (EaseColor* self, guint8 value);
guint8 ease_color_get_blue8 (EaseColor* self);
void ease_color_set_blue8 (EaseColor* self, guint8 value);
guint8 ease_color_get_alpha8 (EaseColor* self);
void ease_color_set_alpha8 (EaseColor* self, guint8 value);
guint16 ease_color_get_red16 (EaseColor* self);
void ease_color_set_red16 (EaseColor* self, guint16 value);
guint16 ease_color_get_green16 (EaseColor* self);
void ease_color_set_green16 (EaseColor* self, guint16 value);
guint16 ease_color_get_blue16 (EaseColor* self);
void ease_color_set_blue16 (EaseColor* self, guint16 value);
guint16 ease_color_get_alpha16 (EaseColor* self);
void ease_color_set_alpha16 (EaseColor* self, guint16 value);
void ease_color_get_clutter (EaseColor* self, ClutterColor* result);
void ease_color_get_gdk (EaseColor* self, GdkColor* result);
static void ease_color_finalize (GObject* obj);
static void ease_color_get_property (GObject * object, guint property_id, GValue * value, GParamSpec * pspec);
static void ease_color_set_property (GObject * object, guint property_id, const GValue * value, GParamSpec * pspec);
static void _vala_array_destroy (gpointer array, gint array_length, GDestroyNotify destroy_func);
static void _vala_array_free (gpointer array, gint array_length, GDestroyNotify destroy_func);
static gint _vala_array_length (gpointer array);



/**
 * Creates an opaque color.
 */
#line 361 "ease-color.vala"
EaseColor* ease_color_construct_rgb (GType object_type, double r, double g, double b) {
#line 169 "ease-color.c"
	EaseColor * self;
#line 363 "ease-color.vala"
	self = (EaseColor*) ease_color_construct_rgba (object_type, r, g, b, (double) 1);
#line 173 "ease-color.c"
	return self;
}


#line 361 "ease-color.vala"
EaseColor* ease_color_new_rgb (double r, double g, double b) {
#line 361 "ease-color.vala"
	return ease_color_construct_rgb (EASE_TYPE_COLOR, r, g, b);
#line 182 "ease-color.c"
}


/**
 * Creates a color.
 *
 * @param r The red value.
 * @param g The green value.
 * @param b The blue value.
 * @param a The alpha value.
 */
#line 374 "ease-color.vala"
EaseColor* ease_color_construct_rgba (GType object_type, double r, double g, double b, double a) {
#line 196 "ease-color.c"
	EaseColor * self;
#line 374 "ease-color.vala"
	self = (EaseColor*) g_object_new (object_type, NULL);
#line 376 "ease-color.vala"
	ease_color_set_red (self, r);
#line 377 "ease-color.vala"
	ease_color_set_green (self, g);
#line 378 "ease-color.vala"
	ease_color_set_blue (self, b);
#line 379 "ease-color.vala"
	ease_color_set_alpha (self, a);
#line 208 "ease-color.c"
	return self;
}


#line 374 "ease-color.vala"
EaseColor* ease_color_new_rgba (double r, double g, double b, double a) {
#line 374 "ease-color.vala"
	return ease_color_construct_rgba (EASE_TYPE_COLOR, r, g, b, a);
#line 217 "ease-color.c"
}


/**
 * Creates a Color from a Clutter.Color. See also: {@link clutter}.
 *
 * @param color The Clutter color to use.
 */
#line 387 "ease-color.vala"
EaseColor* ease_color_construct_from_clutter (GType object_type, ClutterColor* color) {
#line 228 "ease-color.c"
	EaseColor * self;
#line 387 "ease-color.vala"
	self = (EaseColor*) g_object_new (object_type, NULL);
#line 389 "ease-color.vala"
	ease_color_set_clutter (self, color);
#line 234 "ease-color.c"
	return self;
}


#line 387 "ease-color.vala"
EaseColor* ease_color_new_from_clutter (ClutterColor* color) {
#line 387 "ease-color.vala"
	return ease_color_construct_from_clutter (EASE_TYPE_COLOR, color);
#line 243 "ease-color.c"
}


/**
 * Creates a Color from a Gdk.Color. See also: {@link gdk}.
 *
 * @param color The Clutter color to use.
 */
#line 397 "ease-color.vala"
EaseColor* ease_color_construct_from_gdk (GType object_type, GdkColor* color) {
#line 254 "ease-color.c"
	EaseColor * self;
#line 397 "ease-color.vala"
	self = (EaseColor*) g_object_new (object_type, NULL);
#line 399 "ease-color.vala"
	ease_color_set_gdk (self, color);
#line 260 "ease-color.c"
	return self;
}


#line 397 "ease-color.vala"
EaseColor* ease_color_new_from_gdk (GdkColor* color) {
#line 397 "ease-color.vala"
	return ease_color_construct_from_gdk (EASE_TYPE_COLOR, color);
#line 269 "ease-color.c"
}


/**
 * Creates a Color from a string representation created by to_string().
 *
 * @param str The string to create a color from.
 */
#line 1157 "glib-2.0.vapi"
static char* string_replace (const char* self, const char* old, const char* replacement) {
#line 280 "ease-color.c"
	char* result = NULL;
	GError * _inner_error_ = NULL;
#line 1157 "glib-2.0.vapi"
	g_return_val_if_fail (self != NULL, NULL);
#line 1157 "glib-2.0.vapi"
	g_return_val_if_fail (old != NULL, NULL);
#line 1157 "glib-2.0.vapi"
	g_return_val_if_fail (replacement != NULL, NULL);
#line 289 "ease-color.c"
	{
		char* _tmp0_;
		GRegex* _tmp1_;
		GRegex* regex;
		char* _tmp2_;
#line 1159 "glib-2.0.vapi"
		regex = (_tmp1_ = g_regex_new (_tmp0_ = g_regex_escape_string (old, -1), 0, 0, &_inner_error_), _g_free0 (_tmp0_), _tmp1_);
#line 297 "ease-color.c"
		if (_inner_error_ != NULL) {
			if (_inner_error_->domain == G_REGEX_ERROR) {
				goto __catch7_g_regex_error;
			}
			g_critical ("file %s: line %d: unexpected error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
			g_clear_error (&_inner_error_);
			return NULL;
		}
#line 1160 "glib-2.0.vapi"
		_tmp2_ = g_regex_replace_literal (regex, self, (gssize) (-1), 0, replacement, 0, &_inner_error_);
#line 308 "ease-color.c"
		if (_inner_error_ != NULL) {
			_g_regex_unref0 (regex);
			if (_inner_error_->domain == G_REGEX_ERROR) {
				goto __catch7_g_regex_error;
			}
			_g_regex_unref0 (regex);
			g_critical ("file %s: line %d: unexpected error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
			g_clear_error (&_inner_error_);
			return NULL;
		}
		result = _tmp2_;
		_g_regex_unref0 (regex);
#line 1160 "glib-2.0.vapi"
		return result;
#line 323 "ease-color.c"
	}
	goto __finally7;
	__catch7_g_regex_error:
	{
		GError * e;
		e = _inner_error_;
		_inner_error_ = NULL;
		{
#line 1162 "glib-2.0.vapi"
			g_assert_not_reached ();
#line 334 "ease-color.c"
			_g_error_free0 (e);
		}
	}
	__finally7:
	if (_inner_error_ != NULL) {
		g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
		g_clear_error (&_inner_error_);
		return NULL;
	}
}


#line 407 "ease-color.vala"
EaseColor* ease_color_construct_from_string (GType object_type, const char* str) {
#line 349 "ease-color.c"
	EaseColor * self;
	gint split_length1;
	gint _split_size_;
	char** _tmp3_;
	char* _tmp0_;
	char** _tmp1_;
	char** _tmp2_;
	char** split;
#line 407 "ease-color.vala"
	g_return_val_if_fail (str != NULL, NULL);
#line 407 "ease-color.vala"
	self = (EaseColor*) g_object_new (object_type, NULL);
#line 362 "ease-color.c"
	split = (_tmp3_ = (_tmp2_ = _tmp1_ = g_strsplit (_tmp0_ = string_replace (str, " ", ""), EASE_COLOR_SPLIT, 0), _g_free0 (_tmp0_), _tmp2_), split_length1 = _vala_array_length (_tmp1_), _split_size_ = split_length1, _tmp3_);
#line 410 "ease-color.vala"
	ease_color_set_red (self, g_ascii_strtod (split[0], NULL));
#line 411 "ease-color.vala"
	ease_color_set_green (self, g_ascii_strtod (split[1], NULL));
#line 412 "ease-color.vala"
	ease_color_set_blue (self, g_ascii_strtod (split[2], NULL));
#line 415 "ease-color.vala"
	if (split_length1 > 3) {
#line 415 "ease-color.vala"
		ease_color_set_alpha (self, g_ascii_strtod (split[3], NULL));
#line 374 "ease-color.c"
	} else {
#line 416 "ease-color.vala"
		ease_color_set_alpha (self, (double) 1);
#line 378 "ease-color.c"
	}
	split = (_vala_array_free (split, split_length1, (GDestroyNotify) g_free), NULL);
	return self;
}


#line 407 "ease-color.vala"
EaseColor* ease_color_new_from_string (const char* str) {
#line 407 "ease-color.vala"
	return ease_color_construct_from_string (EASE_TYPE_COLOR, str);
#line 389 "ease-color.c"
}


/**
 * Creates a string representation of a color.
 */
#line 422 "ease-color.vala"
char* ease_color_to_string (EaseColor* self) {
#line 398 "ease-color.c"
	char* result = NULL;
#line 422 "ease-color.vala"
	g_return_val_if_fail (self != NULL, NULL);
#line 402 "ease-color.c"
	result = g_strdup_printf (EASE_COLOR_STR, ease_color_get_red (self), EASE_COLOR_SPLIT, ease_color_get_green (self), EASE_COLOR_SPLIT, ease_color_get_blue (self), EASE_COLOR_SPLIT, ease_color_get_alpha (self));
#line 424 "ease-color.vala"
	return result;
#line 406 "ease-color.c"
}


/**
 * Returns a copy of this Color
 */
#line 430 "ease-color.vala"
EaseColor* ease_color_copy (EaseColor* self) {
#line 415 "ease-color.c"
	EaseColor* result = NULL;
#line 430 "ease-color.vala"
	g_return_val_if_fail (self != NULL, NULL);
#line 419 "ease-color.c"
	result = ease_color_new_rgba (ease_color_get_red (self), ease_color_get_green (self), ease_color_get_blue (self), ease_color_get_alpha (self));
#line 432 "ease-color.vala"
	return result;
#line 423 "ease-color.c"
}


/**
 * Sets the given Cairo context's color to this color.
 *
 * @param cr The Cairo Context to set the color for.
 */
#line 440 "ease-color.vala"
void ease_color_set_cairo (EaseColor* self, cairo_t* cr) {
#line 440 "ease-color.vala"
	g_return_if_fail (self != NULL);
#line 440 "ease-color.vala"
	g_return_if_fail (cr != NULL);
#line 442 "ease-color.vala"
	cairo_set_source_rgba (cr, ease_color_get_red (self), ease_color_get_green (self), ease_color_get_blue (self), ease_color_get_alpha (self));
#line 440 "ease-color.c"
}


/**
 * Returns an {@link UndoAction} that will restore this Color to its current
 * state.
 */
#line 449 "ease-color.vala"
EaseUndoAction* ease_color_undo_action (EaseColor* self) {
#line 450 "ease-color.c"
	EaseUndoAction* result = NULL;
	EaseUndoAction* action;
#line 449 "ease-color.vala"
	g_return_val_if_fail (self != NULL, NULL);
#line 451 "ease-color.vala"
	action = ease_undo_action_new ((GObject*) self, "red");
#line 452 "ease-color.vala"
	ease_undo_action_add (action, (GObject*) self, "green");
#line 453 "ease-color.vala"
	ease_undo_action_add (action, (GObject*) self, "blue");
#line 454 "ease-color.vala"
	ease_undo_action_add (action, (GObject*) self, "alpha");
#line 463 "ease-color.c"
	result = action;
#line 456 "ease-color.vala"
	return result;
#line 467 "ease-color.c"
}


#line 21 "ease-color.vala"
EaseColor* ease_color_construct (GType object_type) {
#line 473 "ease-color.c"
	EaseColor * self;
#line 21 "ease-color.vala"
	self = (EaseColor*) g_object_new (object_type, NULL);
#line 477 "ease-color.c"
	return self;
}


#line 21 "ease-color.vala"
EaseColor* ease_color_new (void) {
#line 21 "ease-color.vala"
	return ease_color_construct (EASE_TYPE_COLOR);
#line 486 "ease-color.c"
}


EaseColor* ease_color_get_white (void) {
	EaseColor* result;
	result = ease_color_new_rgb ((double) 1, (double) 1, (double) 1);
#line 38 "ease-color.vala"
	return result;
#line 495 "ease-color.c"
}


EaseColor* ease_color_get_black (void) {
	EaseColor* result;
	result = ease_color_new_rgb ((double) 0, (double) 0, (double) 0);
#line 46 "ease-color.vala"
	return result;
#line 504 "ease-color.c"
}


double ease_color_get_red (EaseColor* self) {
	double result;
	g_return_val_if_fail (self != NULL, 0.0);
	result = self->priv->red_priv;
#line 54 "ease-color.vala"
	return result;
#line 514 "ease-color.c"
}


void ease_color_set_red (EaseColor* self, double value) {
	g_return_if_fail (self != NULL);
#line 57 "ease-color.vala"
	if (value < 0) {
#line 59 "ease-color.vala"
		g_warning ("ease-color.vala:59: red value must be >= 0, %f is not", value);
#line 60 "ease-color.vala"
		self->priv->red_priv = (double) 0;
#line 526 "ease-color.c"
	} else {
#line 62 "ease-color.vala"
		if (value > 1) {
#line 64 "ease-color.vala"
			g_warning ("ease-color.vala:64: red value must be <= 1, %f is not", value);
#line 65 "ease-color.vala"
			self->priv->red_priv = (double) 1;
#line 534 "ease-color.c"
		} else {
#line 67 "ease-color.vala"
			self->priv->red_priv = value;
#line 538 "ease-color.c"
		}
	}
	g_object_notify ((GObject *) self, "red");
}


double ease_color_get_green (EaseColor* self) {
	double result;
	g_return_val_if_fail (self != NULL, 0.0);
	result = self->priv->green_priv;
#line 77 "ease-color.vala"
	return result;
#line 551 "ease-color.c"
}


void ease_color_set_green (EaseColor* self, double value) {
	g_return_if_fail (self != NULL);
#line 80 "ease-color.vala"
	if (value < 0) {
#line 82 "ease-color.vala"
		g_warning ("ease-color.vala:82: green value must be >= 0, %f is not", value);
#line 83 "ease-color.vala"
		self->priv->green_priv = (double) 0;
#line 563 "ease-color.c"
	} else {
#line 85 "ease-color.vala"
		if (value > 1) {
#line 87 "ease-color.vala"
			g_warning ("ease-color.vala:87: green value must be <= 1, %f is not", value);
#line 88 "ease-color.vala"
			self->priv->green_priv = (double) 1;
#line 571 "ease-color.c"
		} else {
#line 90 "ease-color.vala"
			self->priv->green_priv = value;
#line 575 "ease-color.c"
		}
	}
	g_object_notify ((GObject *) self, "green");
}


double ease_color_get_blue (EaseColor* self) {
	double result;
	g_return_val_if_fail (self != NULL, 0.0);
	result = self->priv->blue_priv;
#line 100 "ease-color.vala"
	return result;
#line 588 "ease-color.c"
}


void ease_color_set_blue (EaseColor* self, double value) {
	g_return_if_fail (self != NULL);
#line 103 "ease-color.vala"
	if (value < 0) {
#line 105 "ease-color.vala"
		g_warning ("ease-color.vala:105: blue value must be >= 0, %f is not", value);
#line 106 "ease-color.vala"
		self->priv->blue_priv = (double) 0;
#line 600 "ease-color.c"
	} else {
#line 108 "ease-color.vala"
		if (value > 1) {
#line 110 "ease-color.vala"
			g_warning ("ease-color.vala:110: blue value must be <= 1, %f is not", value);
#line 111 "ease-color.vala"
			self->priv->blue_priv = (double) 1;
#line 608 "ease-color.c"
		} else {
#line 113 "ease-color.vala"
			self->priv->blue_priv = value;
#line 612 "ease-color.c"
		}
	}
	g_object_notify ((GObject *) self, "blue");
}


double ease_color_get_alpha (EaseColor* self) {
	double result;
	g_return_val_if_fail (self != NULL, 0.0);
	result = self->priv->alpha_priv;
#line 123 "ease-color.vala"
	return result;
#line 625 "ease-color.c"
}


void ease_color_set_alpha (EaseColor* self, double value) {
	g_return_if_fail (self != NULL);
#line 126 "ease-color.vala"
	if (value < 0) {
#line 128 "ease-color.vala"
		g_warning ("ease-color.vala:128: alpha value must be >= 0, %f is not", value);
#line 129 "ease-color.vala"
		self->priv->alpha_priv = (double) 0;
#line 637 "ease-color.c"
	} else {
#line 131 "ease-color.vala"
		if (value > 1) {
#line 133 "ease-color.vala"
			g_warning ("ease-color.vala:133: alpha value must be <= 1, %f is not", value);
#line 134 "ease-color.vala"
			self->priv->alpha_priv = (double) 1;
#line 645 "ease-color.c"
		} else {
#line 136 "ease-color.vala"
			self->priv->alpha_priv = value;
#line 649 "ease-color.c"
		}
	}
	g_object_notify ((GObject *) self, "alpha");
}


guint8 ease_color_get_red8 (EaseColor* self) {
	guint8 result;
	g_return_val_if_fail (self != NULL, 0U);
	result = (guint8) (255 * self->priv->red_priv);
#line 147 "ease-color.vala"
	return result;
#line 662 "ease-color.c"
}


void ease_color_set_red8 (EaseColor* self, guint8 value) {
	g_return_if_fail (self != NULL);
#line 150 "ease-color.vala"
	if (value < 0) {
#line 152 "ease-color.vala"
		g_warning ("ease-color.vala:152: red value must be >= 0, %f is not", (double) value);
#line 153 "ease-color.vala"
		self->priv->red_priv = (double) 0;
#line 674 "ease-color.c"
	} else {
#line 155 "ease-color.vala"
		if (value > 255) {
#line 157 "ease-color.vala"
			g_warning ("ease-color.vala:157: red value must be <= 255, %f is not", (double) value);
#line 158 "ease-color.vala"
			self->priv->red_priv = (double) 1;
#line 682 "ease-color.c"
		} else {
#line 160 "ease-color.vala"
			self->priv->red_priv = value / 255.0;
#line 686 "ease-color.c"
		}
	}
	g_object_notify ((GObject *) self, "red8");
}


guint8 ease_color_get_green8 (EaseColor* self) {
	guint8 result;
	g_return_val_if_fail (self != NULL, 0U);
	result = (guint8) (255 * self->priv->green_priv);
#line 169 "ease-color.vala"
	return result;
#line 699 "ease-color.c"
}


void ease_color_set_green8 (EaseColor* self, guint8 value) {
	g_return_if_fail (self != NULL);
#line 172 "ease-color.vala"
	if (value < 0) {
#line 174 "ease-color.vala"
		g_warning ("ease-color.vala:174: green value must be >= 0, %f is not", (double) value);
#line 175 "ease-color.vala"
		self->priv->green_priv = (double) 0;
#line 711 "ease-color.c"
	} else {
#line 177 "ease-color.vala"
		if (value > 255) {
#line 179 "ease-color.vala"
			g_warning ("ease-color.vala:179: green value must be <= 255, %f is not", (double) value);
#line 180 "ease-color.vala"
			self->priv->green_priv = (double) 1;
#line 719 "ease-color.c"
		} else {
#line 182 "ease-color.vala"
			self->priv->green_priv = value / 255.0;
#line 723 "ease-color.c"
		}
	}
	g_object_notify ((GObject *) self, "green8");
}


guint8 ease_color_get_blue8 (EaseColor* self) {
	guint8 result;
	g_return_val_if_fail (self != NULL, 0U);
	result = (guint8) (255 * self->priv->blue_priv);
#line 191 "ease-color.vala"
	return result;
#line 736 "ease-color.c"
}


void ease_color_set_blue8 (EaseColor* self, guint8 value) {
	g_return_if_fail (self != NULL);
#line 194 "ease-color.vala"
	if (value < 0) {
#line 196 "ease-color.vala"
		g_warning ("ease-color.vala:196: blue value must be >= 0, %f is not", (double) value);
#line 197 "ease-color.vala"
		self->priv->blue_priv = (double) 0;
#line 748 "ease-color.c"
	} else {
#line 199 "ease-color.vala"
		if (value > 255) {
#line 201 "ease-color.vala"
			g_warning ("ease-color.vala:201: blue value must be <= 255, %f is not", (double) value);
#line 202 "ease-color.vala"
			self->priv->blue_priv = (double) 1;
#line 756 "ease-color.c"
		} else {
#line 204 "ease-color.vala"
			self->priv->blue_priv = value / 255.0;
#line 760 "ease-color.c"
		}
	}
	g_object_notify ((GObject *) self, "blue8");
}


guint8 ease_color_get_alpha8 (EaseColor* self) {
	guint8 result;
	g_return_val_if_fail (self != NULL, 0U);
	result = (guint8) (255 * self->priv->alpha_priv);
#line 213 "ease-color.vala"
	return result;
#line 773 "ease-color.c"
}


void ease_color_set_alpha8 (EaseColor* self, guint8 value) {
	g_return_if_fail (self != NULL);
#line 216 "ease-color.vala"
	if (value < 0) {
#line 218 "ease-color.vala"
		g_warning ("ease-color.vala:218: alpha value must be >= 0, %f is not", (double) value);
#line 219 "ease-color.vala"
		self->priv->alpha_priv = (double) 0;
#line 785 "ease-color.c"
	} else {
#line 221 "ease-color.vala"
		if (value > 255) {
#line 223 "ease-color.vala"
			g_warning ("ease-color.vala:223: alpha value must be <= 255, %f is not", (double) value);
#line 224 "ease-color.vala"
			self->priv->alpha_priv = (double) 1;
#line 793 "ease-color.c"
		} else {
#line 226 "ease-color.vala"
			self->priv->alpha_priv = value / 255.0;
#line 797 "ease-color.c"
		}
	}
	g_object_notify ((GObject *) self, "alpha8");
}


guint16 ease_color_get_red16 (EaseColor* self) {
	guint16 result;
	g_return_val_if_fail (self != NULL, 0U);
	result = (guint16) (65535 * self->priv->red_priv);
#line 235 "ease-color.vala"
	return result;
#line 810 "ease-color.c"
}


void ease_color_set_red16 (EaseColor* self, guint16 value) {
	g_return_if_fail (self != NULL);
#line 238 "ease-color.vala"
	if (value < 0) {
#line 240 "ease-color.vala"
		g_warning ("ease-color.vala:240: red value must be >= 0, %f is not", (double) value);
#line 241 "ease-color.vala"
		self->priv->red_priv = (double) 0;
#line 822 "ease-color.c"
	} else {
#line 243 "ease-color.vala"
		if (value > 65535) {
#line 245 "ease-color.vala"
			g_warning ("ease-color.vala:245: red value must be <= 65535, %f is not", (double) value);
#line 246 "ease-color.vala"
			self->priv->red_priv = (double) 1;
#line 830 "ease-color.c"
		} else {
#line 248 "ease-color.vala"
			self->priv->red_priv = value / 65535.0;
#line 834 "ease-color.c"
		}
	}
}


guint16 ease_color_get_green16 (EaseColor* self) {
	guint16 result;
	g_return_val_if_fail (self != NULL, 0U);
	result = (guint16) (65535 * self->priv->green_priv);
#line 257 "ease-color.vala"
	return result;
#line 846 "ease-color.c"
}


void ease_color_set_green16 (EaseColor* self, guint16 value) {
	g_return_if_fail (self != NULL);
#line 260 "ease-color.vala"
	if (value < 0) {
#line 262 "ease-color.vala"
		g_warning ("ease-color.vala:262: green value must be >= 0, %f is not", (double) value);
#line 263 "ease-color.vala"
		self->priv->green_priv = (double) 0;
#line 858 "ease-color.c"
	} else {
#line 265 "ease-color.vala"
		if (value > 65535) {
#line 267 "ease-color.vala"
			g_warning ("ease-color.vala:267: green value must be <= 65535, %f is not", (double) value);
#line 268 "ease-color.vala"
			self->priv->green_priv = (double) 1;
#line 866 "ease-color.c"
		} else {
#line 270 "ease-color.vala"
			self->priv->green_priv = value / 65535.0;
#line 870 "ease-color.c"
		}
	}
}


guint16 ease_color_get_blue16 (EaseColor* self) {
	guint16 result;
	g_return_val_if_fail (self != NULL, 0U);
	result = (guint16) (65535 * self->priv->blue_priv);
#line 279 "ease-color.vala"
	return result;
#line 882 "ease-color.c"
}


void ease_color_set_blue16 (EaseColor* self, guint16 value) {
	g_return_if_fail (self != NULL);
#line 282 "ease-color.vala"
	if (value < 0) {
#line 284 "ease-color.vala"
		g_warning ("ease-color.vala:284: blue value must be >= 0, %f is not", (double) value);
#line 285 "ease-color.vala"
		self->priv->blue_priv = (double) 0;
#line 894 "ease-color.c"
	} else {
#line 287 "ease-color.vala"
		if (value > 65535) {
#line 289 "ease-color.vala"
			g_warning ("ease-color.vala:289: blue value must be <= 65535, %f is not", (double) value);
#line 290 "ease-color.vala"
			self->priv->blue_priv = (double) 1;
#line 902 "ease-color.c"
		} else {
#line 292 "ease-color.vala"
			self->priv->blue_priv = value / 65535.0;
#line 906 "ease-color.c"
		}
	}
}


guint16 ease_color_get_alpha16 (EaseColor* self) {
	guint16 result;
	g_return_val_if_fail (self != NULL, 0U);
	result = (guint16) (65535 * self->priv->alpha_priv);
#line 301 "ease-color.vala"
	return result;
#line 918 "ease-color.c"
}


void ease_color_set_alpha16 (EaseColor* self, guint16 value) {
	g_return_if_fail (self != NULL);
#line 304 "ease-color.vala"
	if (value < 0) {
#line 306 "ease-color.vala"
		g_warning ("ease-color.vala:306: alpha value must be >= 0, %f is not", (double) value);
#line 307 "ease-color.vala"
		self->priv->alpha_priv = (double) 0;
#line 930 "ease-color.c"
	} else {
#line 309 "ease-color.vala"
		if (value > 65535) {
#line 311 "ease-color.vala"
			g_warning ("ease-color.vala:311: alpha value must be <= 65535, %f is not", (double) value);
#line 312 "ease-color.vala"
			self->priv->alpha_priv = (double) 1;
#line 938 "ease-color.c"
		} else {
#line 314 "ease-color.vala"
			self->priv->alpha_priv = value / 65535.0;
#line 942 "ease-color.c"
		}
	}
}


void ease_color_get_clutter (EaseColor* self, ClutterColor* result) {
	ClutterColor _tmp0_ = {0};
	g_return_if_fail (self != NULL);
	*result = (_tmp0_.red = (guchar) ease_color_get_red8 (self), _tmp0_.green = (guchar) ease_color_get_green8 (self), _tmp0_.blue = (guchar) ease_color_get_blue8 (self), _tmp0_.alpha = (guchar) ease_color_get_alpha8 (self), _tmp0_);
#line 326 "ease-color.vala"
	return;
#line 954 "ease-color.c"
}


void ease_color_set_clutter (EaseColor* self, ClutterColor* value) {
	g_return_if_fail (self != NULL);
#line 330 "ease-color.vala"
	ease_color_set_red8 (self, (guint8) (*value).red);
#line 331 "ease-color.vala"
	ease_color_set_green8 (self, (guint8) (*value).green);
#line 332 "ease-color.vala"
	ease_color_set_blue8 (self, (guint8) (*value).blue);
#line 333 "ease-color.vala"
	ease_color_set_alpha8 (self, (guint8) (*value).alpha);
#line 968 "ease-color.c"
	g_object_notify ((GObject *) self, "clutter");
}


void ease_color_get_gdk (EaseColor* self, GdkColor* result) {
	GdkColor _tmp0_ = {0};
	g_return_if_fail (self != NULL);
	*result = (_tmp0_.pixel = (guint32) 0, _tmp0_.red = ease_color_get_red16 (self), _tmp0_.green = ease_color_get_green16 (self), _tmp0_.blue = ease_color_get_blue16 (self), _tmp0_);
#line 347 "ease-color.vala"
	return;
#line 979 "ease-color.c"
}


void ease_color_set_gdk (EaseColor* self, GdkColor* value) {
	g_return_if_fail (self != NULL);
#line 351 "ease-color.vala"
	ease_color_set_red16 (self, (*value).red);
#line 352 "ease-color.vala"
	ease_color_set_green16 (self, (*value).green);
#line 353 "ease-color.vala"
	ease_color_set_blue16 (self, (*value).blue);
#line 354 "ease-color.vala"
	ease_color_set_alpha (self, (double) 1);
#line 993 "ease-color.c"
	g_object_notify ((GObject *) self, "gdk");
}


static void ease_color_class_init (EaseColorClass * klass) {
	ease_color_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (EaseColorPrivate));
	G_OBJECT_CLASS (klass)->get_property = ease_color_get_property;
	G_OBJECT_CLASS (klass)->set_property = ease_color_set_property;
	G_OBJECT_CLASS (klass)->finalize = ease_color_finalize;
	/**
	 * The red value of this color, as a double from 0 to 1.
	 */
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_COLOR_RED, g_param_spec_double ("red", "red", "red", -G_MAXDOUBLE, G_MAXDOUBLE, 0.0, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
	/**
	 * The green value of this color, as a double from 0 to 1.
	 */
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_COLOR_GREEN, g_param_spec_double ("green", "green", "green", -G_MAXDOUBLE, G_MAXDOUBLE, 0.0, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
	/**
	 * The blue value of this color, as a double from 0 to 1.
	 */
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_COLOR_BLUE, g_param_spec_double ("blue", "blue", "blue", -G_MAXDOUBLE, G_MAXDOUBLE, 0.0, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
	/**
	 * The alpha (transparency) of this color, as a double from 0 to 1.
	 */
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_COLOR_ALPHA, g_param_spec_double ("alpha", "alpha", "alpha", -G_MAXDOUBLE, G_MAXDOUBLE, 0.0, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
	/**
	 * The red value of this color, as an 8-bit unsigned integer.
	 */
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_COLOR_RED8, g_param_spec_uchar ("red8", "red8", "red8", 0, G_MAXUINT8, 0, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
	/**
	 * The green value of this color, as an 8-bit unsigned integer.
	 */
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_COLOR_GREEN8, g_param_spec_uchar ("green8", "green8", "green8", 0, G_MAXUINT8, 0, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
	/**
	 * The blue value of this color, as an 8-bit unsigned integer.
	 */
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_COLOR_BLUE8, g_param_spec_uchar ("blue8", "blue8", "blue8", 0, G_MAXUINT8, 0, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
	/**
	 * The alpha (transparency) of this color, as an 8-bit unsigned integer.
	 */
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_COLOR_ALPHA8, g_param_spec_uchar ("alpha8", "alpha8", "alpha8", 0, G_MAXUINT8, 0, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
	/**
	 * A Clutter.Color representation of this color. Changes made to the
	 * the returned color are not reflected in this color.
	 */
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_COLOR_CLUTTER, g_param_spec_boxed ("clutter", "clutter", "clutter", CLUTTER_TYPE_COLOR, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
	/**
	 * A Gdk.Color representation of this color. Changes made to the returned
	 * color are not reflected in this color. Note that GDK colors do not
	 * support an alpha value. When being set, the alpha will be set to full,
	 * when retrieved, the alpha value will be ignored.
	 */
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_COLOR_GDK, g_param_spec_boxed ("gdk", "gdk", "gdk", GDK_TYPE_COLOR, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
}


static void ease_color_instance_init (EaseColor * self) {
	self->priv = EASE_COLOR_GET_PRIVATE (self);
}


static void ease_color_finalize (GObject* obj) {
	EaseColor * self;
	self = EASE_COLOR (obj);
	G_OBJECT_CLASS (ease_color_parent_class)->finalize (obj);
}


/**
 * Color abstraction, supporting Clutter, GDK, and Cairo colors.
 */
GType ease_color_get_type (void) {
	static volatile gsize ease_color_type_id__volatile = 0;
	if (g_once_init_enter (&ease_color_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (EaseColorClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) ease_color_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (EaseColor), 0, (GInstanceInitFunc) ease_color_instance_init, NULL };
		GType ease_color_type_id;
		ease_color_type_id = g_type_register_static (G_TYPE_OBJECT, "EaseColor", &g_define_type_info, 0);
		g_once_init_leave (&ease_color_type_id__volatile, ease_color_type_id);
	}
	return ease_color_type_id__volatile;
}


static void ease_color_get_property (GObject * object, guint property_id, GValue * value, GParamSpec * pspec) {
	EaseColor * self;
	ClutterColor boxed0;
	GdkColor boxed1;
	self = EASE_COLOR (object);
	switch (property_id) {
		case EASE_COLOR_RED:
		g_value_set_double (value, ease_color_get_red (self));
		break;
		case EASE_COLOR_GREEN:
		g_value_set_double (value, ease_color_get_green (self));
		break;
		case EASE_COLOR_BLUE:
		g_value_set_double (value, ease_color_get_blue (self));
		break;
		case EASE_COLOR_ALPHA:
		g_value_set_double (value, ease_color_get_alpha (self));
		break;
		case EASE_COLOR_RED8:
		g_value_set_uchar (value, ease_color_get_red8 (self));
		break;
		case EASE_COLOR_GREEN8:
		g_value_set_uchar (value, ease_color_get_green8 (self));
		break;
		case EASE_COLOR_BLUE8:
		g_value_set_uchar (value, ease_color_get_blue8 (self));
		break;
		case EASE_COLOR_ALPHA8:
		g_value_set_uchar (value, ease_color_get_alpha8 (self));
		break;
		case EASE_COLOR_CLUTTER:
		ease_color_get_clutter (self, &boxed0);
		g_value_set_boxed (value, &boxed0);
		break;
		case EASE_COLOR_GDK:
		ease_color_get_gdk (self, &boxed1);
		g_value_set_boxed (value, &boxed1);
		break;
		default:
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
		break;
	}
}


static void ease_color_set_property (GObject * object, guint property_id, const GValue * value, GParamSpec * pspec) {
	EaseColor * self;
	self = EASE_COLOR (object);
	switch (property_id) {
		case EASE_COLOR_RED:
		ease_color_set_red (self, g_value_get_double (value));
		break;
		case EASE_COLOR_GREEN:
		ease_color_set_green (self, g_value_get_double (value));
		break;
		case EASE_COLOR_BLUE:
		ease_color_set_blue (self, g_value_get_double (value));
		break;
		case EASE_COLOR_ALPHA:
		ease_color_set_alpha (self, g_value_get_double (value));
		break;
		case EASE_COLOR_RED8:
		ease_color_set_red8 (self, g_value_get_uchar (value));
		break;
		case EASE_COLOR_GREEN8:
		ease_color_set_green8 (self, g_value_get_uchar (value));
		break;
		case EASE_COLOR_BLUE8:
		ease_color_set_blue8 (self, g_value_get_uchar (value));
		break;
		case EASE_COLOR_ALPHA8:
		ease_color_set_alpha8 (self, g_value_get_uchar (value));
		break;
		case EASE_COLOR_CLUTTER:
		ease_color_set_clutter (self, g_value_get_boxed (value));
		break;
		case EASE_COLOR_GDK:
		ease_color_set_gdk (self, g_value_get_boxed (value));
		break;
		default:
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
		break;
	}
}


static void _vala_array_destroy (gpointer array, gint array_length, GDestroyNotify destroy_func) {
	if ((array != NULL) && (destroy_func != NULL)) {
		int i;
		for (i = 0; i < array_length; i = i + 1) {
			if (((gpointer*) array)[i] != NULL) {
				destroy_func (((gpointer*) array)[i]);
			}
		}
	}
}


static void _vala_array_free (gpointer array, gint array_length, GDestroyNotify destroy_func) {
	_vala_array_destroy (array, array_length, destroy_func);
	g_free (array);
}


static gint _vala_array_length (gpointer array) {
	int length;
	length = 0;
	if (array) {
		while (((gpointer*) array)[length]) {
			length++;
		}
	}
	return length;
}




