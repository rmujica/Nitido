/* ease-player.c generated by valac 0.10.0, the Vala compiler
 * generated from ease-player.vala, do not modify */

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
#include <gtk/gtk.h>
#include <ease-core.h>
#include <clutter/clutter.h>
#include <float.h>
#include <math.h>
#include <cairo.h>
#include <clutter-gtk/clutter-gtk.h>
#include <glib/gi18n-lib.h>


#define EASE_TYPE_PLAYER (ease_player_get_type ())
#define EASE_PLAYER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_PLAYER, EasePlayer))
#define EASE_PLAYER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_PLAYER, EasePlayerClass))
#define EASE_IS_PLAYER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_PLAYER))
#define EASE_IS_PLAYER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_PLAYER))
#define EASE_PLAYER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_PLAYER, EasePlayerClass))

typedef struct _EasePlayer EasePlayer;
typedef struct _EasePlayerClass EasePlayerClass;
typedef struct _EasePlayerPrivate EasePlayerPrivate;

#define EASE_TYPE_SLIDE_ACTOR (ease_slide_actor_get_type ())
#define EASE_SLIDE_ACTOR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_SLIDE_ACTOR, EaseSlideActor))
#define EASE_SLIDE_ACTOR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_SLIDE_ACTOR, EaseSlideActorClass))
#define EASE_IS_SLIDE_ACTOR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_SLIDE_ACTOR))
#define EASE_IS_SLIDE_ACTOR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_SLIDE_ACTOR))
#define EASE_SLIDE_ACTOR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_SLIDE_ACTOR, EaseSlideActorClass))

typedef struct _EaseSlideActor EaseSlideActor;
typedef struct _EaseSlideActorClass EaseSlideActorClass;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))
#define _cairo_pattern_destroy0(var) ((var == NULL) ? NULL : (var = (cairo_pattern_destroy (var), NULL)))
#define _cairo_destroy0(var) ((var == NULL) ? NULL : (var = (cairo_destroy (var), NULL)))

struct _EasePlayer {
	GtkWindow parent_instance;
	EasePlayerPrivate * priv;
};

struct _EasePlayerClass {
	GtkWindowClass parent_class;
};

struct _EasePlayerPrivate {
	EaseDocument* _document;
	gint _slide_index;
	ClutterStage* _stage;
	gboolean _can_animate;
	gboolean dragging;
	EaseSlideActor* current_slide;
	EaseSlideActor* old_slide;
	ClutterGroup* container;
	ClutterTimeline* advance_alarm;
	float scale;
	guint FOCUS_RADIUS;
	ClutterCairoTexture* focus_circle;
	cairo_pattern_t* radial;
	cairo_t* cr;
};


static gpointer ease_player_parent_class = NULL;

GType ease_player_get_type (void) G_GNUC_CONST;
GType ease_slide_actor_get_type (void) G_GNUC_CONST;
#define EASE_PLAYER_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), EASE_TYPE_PLAYER, EasePlayerPrivate))
enum  {
	EASE_PLAYER_DUMMY_PROPERTY,
	EASE_PLAYER_DOCUMENT,
	EASE_PLAYER_SLIDE_INDEX,
	EASE_PLAYER_STAGE
};
#define EASE_PLAYER_FADE_IN_TIME ((guint) 1000)
#define EASE_PLAYER_FOCUS_OPACITY ((guint) 150)
EasePlayer* ease_player_new (EaseDocument* doc);
EasePlayer* ease_player_construct (GType object_type, EaseDocument* doc);
void ease_player_set_document (EasePlayer* self, EaseDocument* value);
void ease_player_set_slide_index (EasePlayer* self, gint value);
void ease_player_set_stage (EasePlayer* self, ClutterStage* value);
ClutterStage* ease_player_get_stage (EasePlayer* self);
EaseDocument* ease_player_get_document (EasePlayer* self);
gboolean ease_player_on_key_press (EasePlayer* self, ClutterKeyEvent* event);
static gboolean _ease_player_on_key_press_clutter_actor_key_press_event (ClutterActor* _sender, ClutterKeyEvent* event, gpointer self);
gboolean ease_player_on_button_press (EasePlayer* self, ClutterButtonEvent* event);
static gboolean _ease_player_on_button_press_clutter_actor_button_press_event (ClutterActor* _sender, ClutterButtonEvent* event, gpointer self);
gboolean ease_player_on_motion (EasePlayer* self, ClutterMotionEvent* event);
static gboolean _ease_player_on_motion_clutter_actor_motion_event (ClutterActor* _sender, ClutterMotionEvent* event, gpointer self);
gboolean ease_player_on_button_release (EasePlayer* self, ClutterButtonEvent* event);
static gboolean _ease_player_on_button_release_clutter_actor_button_release_event (ClutterActor* _sender, ClutterButtonEvent* event, gpointer self);
gboolean ease_player_on_scroll_event (EasePlayer* self, ClutterScrollEvent* event);
static gboolean _ease_player_on_scroll_event_clutter_actor_scroll_event (ClutterActor* _sender, ClutterScrollEvent* event, gpointer self);
static void ease_player_set_can_animate (EasePlayer* self, gboolean value);
void ease_player_advance (EasePlayer* self);
static void ease_player_retreat (EasePlayer* self);
static gboolean ease_player_get_can_animate (EasePlayer* self);
gint ease_player_get_slide_index (EasePlayer* self);
static void ease_player_create_current_slide (EasePlayer* self, EaseSlide* slide);
static void ease_player_on_request_advance (EasePlayer* self, EaseElement* element);
static void _ease_player_on_request_advance_ease_slide_request_advance (EaseSlide* _sender, EaseElement* sender, gpointer self);
void ease_slide_actor_stack (EaseSlideActor* self, ClutterActor* container);
static void ease_player_animation_complete (EasePlayer* self);
static void _ease_player_animation_complete_clutter_timeline_completed (ClutterTimeline* _sender, gpointer self);
EaseSlide* ease_slide_actor_get_slide (EaseSlideActor* self);
void ease_slide_actor_transition (EaseSlideActor* self, EaseSlideActor* new_slide, ClutterGroup* container);
ClutterTimeline* ease_slide_actor_get_animation_time (EaseSlideActor* self);
EaseSlideActor* ease_slide_actor_new_from_slide (EaseDocument* document, EaseSlide* s, gboolean clip, EaseActorContext ctx);
EaseSlideActor* ease_slide_actor_construct_from_slide (GType object_type, EaseDocument* document, EaseSlide* s, gboolean clip, EaseActorContext ctx);
static void _lambda49_ (EasePlayer* self);
static void __lambda49__clutter_timeline_completed (ClutterTimeline* _sender, gpointer self);
static void ease_player_finalize (GObject* obj);
static void ease_player_get_property (GObject * object, guint property_id, GValue * value, GParamSpec * pspec);
static void ease_player_set_property (GObject * object, guint property_id, const GValue * value, GParamSpec * pspec);



#line 204 "ease-player.vala"
static gboolean _ease_player_on_key_press_clutter_actor_key_press_event (ClutterActor* _sender, ClutterKeyEvent* event, gpointer self) {
#line 141 "ease-player.c"
	gboolean result;
	result = ease_player_on_key_press (self, event);
	return result;
}


#line 159 "ease-player.vala"
static gboolean _ease_player_on_button_press_clutter_actor_button_press_event (ClutterActor* _sender, ClutterButtonEvent* event, gpointer self) {
#line 150 "ease-player.c"
	gboolean result;
	result = ease_player_on_button_press (self, event);
	return result;
}


#line 132 "ease-player.vala"
static gboolean _ease_player_on_motion_clutter_actor_motion_event (ClutterActor* _sender, ClutterMotionEvent* event, gpointer self) {
#line 159 "ease-player.c"
	gboolean result;
	result = ease_player_on_motion (self, event);
	return result;
}


#line 150 "ease-player.vala"
static gboolean _ease_player_on_button_release_clutter_actor_button_release_event (ClutterActor* _sender, ClutterButtonEvent* event, gpointer self) {
#line 168 "ease-player.c"
	gboolean result;
	result = ease_player_on_button_release (self, event);
	return result;
}


#line 178 "ease-player.vala"
static gboolean _ease_player_on_scroll_event_clutter_actor_scroll_event (ClutterActor* _sender, ClutterScrollEvent* event, gpointer self) {
#line 177 "ease-player.c"
	gboolean result;
	result = ease_player_on_scroll_event (self, event);
	return result;
}


#line 56 "ease-player.vala"
EasePlayer* ease_player_construct (GType object_type, EaseDocument* doc) {
#line 186 "ease-player.c"
	EasePlayer * self;
	GtkClutterEmbed* embed;
	ClutterActor* _tmp0_;
	gboolean _tmp1_ = FALSE;
	ClutterColor _tmp3_ = {0};
	ClutterColor _tmp4_;
	ClutterCairoTexture* _tmp5_;
	cairo_pattern_t* _tmp6_;
	ClutterGroup* _tmp7_;
	GtkAlignment* align;
	EaseColor* _tmp8_;
	GdkColor _tmp9_ = {0};
	GdkColor _tmp10_;
	EaseColor* _tmp11_;
	GdkColor _tmp12_ = {0};
	GdkColor _tmp13_;
#line 56 "ease-player.vala"
	g_return_val_if_fail (doc != NULL, NULL);
#line 205 "ease-player.c"
	self = g_object_newv (object_type, 0, NULL);
#line 58 "ease-player.vala"
	ease_player_set_document (self, doc);
#line 59 "ease-player.vala"
	ease_player_set_slide_index (self, -1);
#line 61 "ease-player.vala"
	embed = g_object_ref_sink ((GtkClutterEmbed*) gtk_clutter_embed_new ());
#line 62 "ease-player.vala"
	ease_player_set_stage (self, (_tmp0_ = gtk_clutter_embed_get_stage (embed), CLUTTER_IS_STAGE (_tmp0_) ? ((ClutterStage*) _tmp0_) : NULL));
#line 63 "ease-player.vala"
	clutter_actor_set_width ((ClutterActor*) self->priv->_stage, ease_document_get_width (self->priv->_document) * self->priv->scale);
#line 64 "ease-player.vala"
	clutter_actor_set_height ((ClutterActor*) self->priv->_stage, ease_document_get_height (self->priv->_document) * self->priv->scale);
#line 65 "ease-player.vala"
	clutter_stage_set_title (self->priv->_stage, _ ("Ease Presentation"));
#line 66 "ease-player.vala"
	clutter_stage_set_use_fog (self->priv->_stage, FALSE);
#line 69 "ease-player.vala"
	if (clutter_actor_get_width ((ClutterActor*) self->priv->_stage) < ease_document_get_width (self->priv->_document)) {
#line 69 "ease-player.vala"
		_tmp1_ = TRUE;
#line 227 "ease-player.c"
	} else {
#line 69 "ease-player.vala"
		_tmp1_ = clutter_actor_get_height ((ClutterActor*) self->priv->_stage) < ease_document_get_height (self->priv->_document);
#line 231 "ease-player.c"
	}
#line 69 "ease-player.vala"
	if (_tmp1_) {
#line 235 "ease-player.c"
		float x;
		float y;
		float _tmp2_ = 0.0F;
#line 71 "ease-player.vala"
		x = ((float) clutter_actor_get_width ((ClutterActor*) self->priv->_stage)) / ease_document_get_width (self->priv->_document);
#line 72 "ease-player.vala"
		y = ((float) clutter_actor_get_height ((ClutterActor*) self->priv->_stage)) / ease_document_get_height (self->priv->_document);
#line 74 "ease-player.vala"
		if (x < y) {
#line 74 "ease-player.vala"
			_tmp2_ = x;
#line 247 "ease-player.c"
		} else {
#line 74 "ease-player.vala"
			_tmp2_ = y;
#line 251 "ease-player.c"
		}
#line 74 "ease-player.vala"
		self->priv->scale = _tmp2_;
#line 255 "ease-player.c"
	}
#line 78 "ease-player.vala"
	g_signal_connect_object ((ClutterActor*) self->priv->_stage, "key-press-event", (GCallback) _ease_player_on_key_press_clutter_actor_key_press_event, self, 0);
#line 81 "ease-player.vala"
	g_signal_connect_object ((ClutterActor*) self->priv->_stage, "button-press-event", (GCallback) _ease_player_on_button_press_clutter_actor_button_press_event, self, 0);
#line 82 "ease-player.vala"
	g_signal_connect_object ((ClutterActor*) self->priv->_stage, "motion-event", (GCallback) _ease_player_on_motion_clutter_actor_motion_event, self, 0);
#line 83 "ease-player.vala"
	g_signal_connect_object ((ClutterActor*) self->priv->_stage, "button-release-event", (GCallback) _ease_player_on_button_release_clutter_actor_button_release_event, self, 0);
#line 84 "ease-player.vala"
	g_signal_connect_object ((ClutterActor*) self->priv->_stage, "scroll-event", (GCallback) _ease_player_on_scroll_event_clutter_actor_scroll_event, self, 0);
#line 89 "ease-player.vala"
	clutter_stage_set_color (self->priv->_stage, (_tmp4_ = (_tmp3_.red = (guchar) 0, _tmp3_.green = (guchar) 0, _tmp3_.blue = (guchar) 0, _tmp3_.alpha = (guchar) 255, _tmp3_), &_tmp4_));
#line 90 "ease-player.vala"
	clutter_grab_keyboard ((ClutterActor*) self->priv->_stage);
#line 93 "ease-player.vala"
	self->priv->focus_circle = (_tmp5_ = g_object_ref_sink ((ClutterCairoTexture*) clutter_cairo_texture_new ((guint) 1024, (guint) 768)), _g_object_unref0 (self->priv->focus_circle), _tmp5_);
#line 94 "ease-player.vala"
	clutter_actor_set_anchor_point_from_gravity ((ClutterActor*) self->priv->focus_circle, CLUTTER_GRAVITY_CENTER);
#line 95 "ease-player.vala"
	clutter_actor_set_opacity ((ClutterActor*) self->priv->focus_circle, (guint) 0);
#line 96 "ease-player.vala"
	clutter_actor_set_position ((ClutterActor*) self->priv->focus_circle, clutter_actor_get_width ((ClutterActor*) self->priv->_stage) / 2, clutter_actor_get_height ((ClutterActor*) self->priv->_stage) / 2);
#line 98 "ease-player.vala"
	self->priv->radial = (_tmp6_ = cairo_pattern_create_radial ((double) 0, (double) 0, (double) self->priv->FOCUS_RADIUS, (double) 0, (double) 0, (double) (2 * self->priv->FOCUS_RADIUS)), _cairo_pattern_destroy0 (self->priv->radial), _tmp6_);
#line 99 "ease-player.vala"
	cairo_pattern_add_color_stop_rgba (self->priv->radial, (double) 0, (double) 0, (double) 0, (double) 0, (double) 0);
#line 100 "ease-player.vala"
	cairo_pattern_add_color_stop_rgb (self->priv->radial, (double) 1, (double) 0, (double) 0, (double) 0);
#line 102 "ease-player.vala"
	clutter_container_add_actor ((ClutterContainer*) self->priv->_stage, (ClutterActor*) self->priv->focus_circle);
#line 103 "ease-player.vala"
	clutter_actor_set_clip ((ClutterActor*) self->priv->_stage, (float) 0, (float) 0, (float) ease_document_get_width (doc), (float) ease_document_get_height (doc));
#line 106 "ease-player.vala"
	self->priv->container = (_tmp7_ = g_object_ref_sink ((ClutterGroup*) clutter_group_new ()), _g_object_unref0 (self->priv->container), _tmp7_);
#line 107 "ease-player.vala"
	clutter_container_add_actor ((ClutterContainer*) self->priv->_stage, (ClutterActor*) self->priv->container);
#line 108 "ease-player.vala"
	g_object_set ((ClutterActor*) self->priv->container, "scale-x", (double) self->priv->scale, NULL);
#line 109 "ease-player.vala"
	g_object_set ((ClutterActor*) self->priv->container, "scale-y", (double) self->priv->scale, NULL);
#line 112 "ease-player.vala"
	clutter_actor_show_all ((ClutterActor*) self->priv->_stage);
#line 114 "ease-player.vala"
	align = g_object_ref_sink ((GtkAlignment*) gtk_alignment_new (0.5f, 0.5f, (float) 0, (float) 0));
#line 115 "ease-player.vala"
	gtk_widget_set_size_request ((GtkWidget*) embed, ease_document_get_width (self->priv->_document), ease_document_get_height (self->priv->_document));
#line 118 "ease-player.vala"
	gtk_widget_modify_bg ((GtkWidget*) align, GTK_STATE_NORMAL, (_tmp10_ = (ease_color_get_gdk (_tmp8_ = ease_color_get_black (), &_tmp9_), _tmp9_), &_tmp10_));
#line 305 "ease-player.c"
	_g_object_unref0 (_tmp8_);
#line 119 "ease-player.vala"
	gtk_widget_modify_bg ((GtkWidget*) self, GTK_STATE_NORMAL, (_tmp13_ = (ease_color_get_gdk (_tmp11_ = ease_color_get_black (), &_tmp12_), _tmp12_), &_tmp13_));
#line 309 "ease-player.c"
	_g_object_unref0 (_tmp11_);
#line 122 "ease-player.vala"
	gtk_container_add ((GtkContainer*) align, (GtkWidget*) embed);
#line 123 "ease-player.vala"
	gtk_container_add ((GtkContainer*) self, (GtkWidget*) align);
#line 124 "ease-player.vala"
	gtk_window_fullscreen ((GtkWindow*) self);
#line 125 "ease-player.vala"
	gtk_widget_show_all ((GtkWidget*) self);
#line 126 "ease-player.vala"
	gtk_window_present ((GtkWindow*) self);
#line 128 "ease-player.vala"
	ease_player_set_can_animate (self, TRUE);
#line 129 "ease-player.vala"
	ease_player_advance (self);
#line 325 "ease-player.c"
	_g_object_unref0 (align);
	_g_object_unref0 (embed);
	return self;
}


#line 56 "ease-player.vala"
EasePlayer* ease_player_new (EaseDocument* doc) {
#line 56 "ease-player.vala"
	return ease_player_construct (EASE_TYPE_PLAYER, doc);
#line 336 "ease-player.c"
}


#line 132 "ease-player.vala"
gboolean ease_player_on_motion (EasePlayer* self, ClutterMotionEvent* event) {
#line 342 "ease-player.c"
	gboolean result = FALSE;
#line 132 "ease-player.vala"
	g_return_val_if_fail (self != NULL, FALSE);
#line 134 "ease-player.vala"
	if (self->priv->dragging) {
#line 348 "ease-player.c"
		cairo_t* _tmp0_;
		cairo_t* _tmp1_;
#line 135 "ease-player.vala"
		clutter_cairo_texture_clear (self->priv->focus_circle);
#line 137 "ease-player.vala"
		self->priv->cr = (_tmp0_ = clutter_cairo_texture_create (self->priv->focus_circle), _cairo_destroy0 (self->priv->cr), _tmp0_);
#line 138 "ease-player.vala"
		cairo_translate (self->priv->cr, (double) (*event).x, (double) (*event).y);
#line 139 "ease-player.vala"
		cairo_set_source (self->priv->cr, self->priv->radial);
#line 141 "ease-player.vala"
		cairo_paint (self->priv->cr);
#line 142 "ease-player.vala"
		self->priv->cr = (_tmp1_ = NULL, _cairo_destroy0 (self->priv->cr), _tmp1_);
#line 143 "ease-player.vala"
		clutter_container_raise_child ((ClutterContainer*) self->priv->_stage, (ClutterActor*) self->priv->focus_circle, NULL);
#line 365 "ease-player.c"
	} else {
	}
	result = TRUE;
#line 147 "ease-player.vala"
	return result;
#line 371 "ease-player.c"
}


#line 150 "ease-player.vala"
gboolean ease_player_on_button_release (EasePlayer* self, ClutterButtonEvent* event) {
#line 377 "ease-player.c"
	gboolean result = FALSE;
#line 150 "ease-player.vala"
	g_return_val_if_fail (self != NULL, FALSE);
#line 152 "ease-player.vala"
	self->priv->dragging = FALSE;
#line 154 "ease-player.vala"
	clutter_actor_animate ((ClutterActor*) self->priv->focus_circle, (gulong) CLUTTER_LINEAR, (guint) 150, "opacity", 0, NULL);
#line 385 "ease-player.c"
	result = TRUE;
#line 156 "ease-player.vala"
	return result;
#line 389 "ease-player.c"
}


#line 159 "ease-player.vala"
gboolean ease_player_on_button_press (EasePlayer* self, ClutterButtonEvent* event) {
#line 395 "ease-player.c"
	gboolean result = FALSE;
	cairo_t* _tmp0_;
	cairo_t* _tmp1_;
#line 159 "ease-player.vala"
	g_return_val_if_fail (self != NULL, FALSE);
#line 161 "ease-player.vala"
	self->priv->dragging = TRUE;
#line 162 "ease-player.vala"
	g_debug ("ease-player.vala:162: Got a mouse click at %f, %f", (double) (*event).x, (double) (*event).y);
#line 164 "ease-player.vala"
	clutter_cairo_texture_clear (self->priv->focus_circle);
#line 166 "ease-player.vala"
	self->priv->cr = (_tmp0_ = clutter_cairo_texture_create (self->priv->focus_circle), _cairo_destroy0 (self->priv->cr), _tmp0_);
#line 167 "ease-player.vala"
	cairo_translate (self->priv->cr, (double) (*event).x, (double) (*event).y);
#line 168 "ease-player.vala"
	cairo_set_source (self->priv->cr, self->priv->radial);
#line 170 "ease-player.vala"
	cairo_paint (self->priv->cr);
#line 171 "ease-player.vala"
	self->priv->cr = (_tmp1_ = NULL, _cairo_destroy0 (self->priv->cr), _tmp1_);
#line 172 "ease-player.vala"
	clutter_container_raise_child ((ClutterContainer*) self->priv->_stage, (ClutterActor*) self->priv->focus_circle, NULL);
#line 173 "ease-player.vala"
	clutter_actor_animate ((ClutterActor*) self->priv->focus_circle, (gulong) CLUTTER_LINEAR, (guint) 150, "opacity", EASE_PLAYER_FOCUS_OPACITY, NULL);
#line 421 "ease-player.c"
	result = TRUE;
#line 175 "ease-player.vala"
	return result;
#line 425 "ease-player.c"
}


#line 178 "ease-player.vala"
gboolean ease_player_on_scroll_event (EasePlayer* self, ClutterScrollEvent* event) {
#line 431 "ease-player.c"
	gboolean result = FALSE;
	cairo_pattern_t* _tmp0_;
	cairo_t* _tmp1_;
	cairo_t* _tmp2_;
#line 178 "ease-player.vala"
	g_return_val_if_fail (self != NULL, FALSE);
#line 180 "ease-player.vala"
	g_debug ("ease-player.vala:180: Scrolling active.");
#line 181 "ease-player.vala"
	if ((*event).direction == CLUTTER_SCROLL_UP) {
#line 182 "ease-player.vala"
		self->priv->FOCUS_RADIUS = self->priv->FOCUS_RADIUS + ((guint) 10);
#line 444 "ease-player.c"
	} else {
#line 183 "ease-player.vala"
		if ((*event).direction == CLUTTER_SCROLL_DOWN) {
#line 184 "ease-player.vala"
			if (self->priv->FOCUS_RADIUS > 10) {
#line 185 "ease-player.vala"
				self->priv->FOCUS_RADIUS = self->priv->FOCUS_RADIUS - ((guint) 10);
#line 452 "ease-player.c"
			}
		}
	}
#line 189 "ease-player.vala"
	self->priv->radial = (_tmp0_ = cairo_pattern_create_radial ((double) 0, (double) 0, (double) self->priv->FOCUS_RADIUS, (double) 0, (double) 0, (double) (2 * self->priv->FOCUS_RADIUS)), _cairo_pattern_destroy0 (self->priv->radial), _tmp0_);
#line 190 "ease-player.vala"
	cairo_pattern_add_color_stop_rgba (self->priv->radial, (double) 0, (double) 0, (double) 0, (double) 0, (double) 0);
#line 191 "ease-player.vala"
	cairo_pattern_add_color_stop_rgb (self->priv->radial, (double) 1, (double) 0, (double) 0, (double) 0);
#line 193 "ease-player.vala"
	clutter_cairo_texture_clear (self->priv->focus_circle);
#line 194 "ease-player.vala"
	self->priv->cr = (_tmp1_ = clutter_cairo_texture_create (self->priv->focus_circle), _cairo_destroy0 (self->priv->cr), _tmp1_);
#line 195 "ease-player.vala"
	cairo_translate (self->priv->cr, (double) (*event).x, (double) (*event).y);
#line 196 "ease-player.vala"
	cairo_set_source (self->priv->cr, self->priv->radial);
#line 198 "ease-player.vala"
	cairo_paint (self->priv->cr);
#line 199 "ease-player.vala"
	self->priv->cr = (_tmp2_ = NULL, _cairo_destroy0 (self->priv->cr), _tmp2_);
#line 200 "ease-player.vala"
	clutter_container_raise_child ((ClutterContainer*) self->priv->_stage, (ClutterActor*) self->priv->focus_circle, NULL);
#line 476 "ease-player.c"
	result = TRUE;
#line 201 "ease-player.vala"
	return result;
#line 480 "ease-player.c"
}


#line 204 "ease-player.vala"
gboolean ease_player_on_key_press (EasePlayer* self, ClutterKeyEvent* event) {
#line 486 "ease-player.c"
	gboolean result = FALSE;
#line 204 "ease-player.vala"
	g_return_val_if_fail (self != NULL, FALSE);
#line 208 "ease-player.vala"
	g_debug ("ease-player.vala:208: Got a key press, keyval = %u", (*event).keyval);
#line 209 "ease-player.vala"
	switch ((*event).keyval) {
#line 494 "ease-player.c"
		case EASE_KEY_ESCAPE:
		{
#line 211 "ease-player.vala"
			g_debug ("ease-player.vala:211: Quitting player.");
#line 212 "ease-player.vala"
			g_signal_emit_by_name (self, "complete");
#line 213 "ease-player.vala"
			break;
#line 503 "ease-player.c"
		}
		case EASE_KEY_RIGHT:
		case EASE_KEY_DOWN:
		case EASE_KEY_ENTER:
		case EASE_KEY_SPACE:
		{
#line 218 "ease-player.vala"
			g_debug ("ease-player.vala:218: Advancing to next slide.");
#line 219 "ease-player.vala"
			ease_player_advance (self);
#line 220 "ease-player.vala"
			break;
#line 516 "ease-player.c"
		}
		case EASE_KEY_LEFT:
		case EASE_KEY_UP:
		case EASE_KEY_BACKSPACE:
		case EASE_KEY_DELETE:
		{
#line 225 "ease-player.vala"
			g_debug ("ease-player.vala:225: Retreating to previous slide");
#line 226 "ease-player.vala"
			ease_player_retreat (self);
#line 227 "ease-player.vala"
			break;
#line 529 "ease-player.c"
		}
		default:
		{
#line 229 "ease-player.vala"
			g_debug ("ease-player.vala:229: Key not handled.");
#line 230 "ease-player.vala"
			break;
#line 537 "ease-player.c"
		}
	}
	result = TRUE;
#line 232 "ease-player.vala"
	return result;
#line 543 "ease-player.c"
}


#line 352 "ease-player.vala"
static void _ease_player_on_request_advance_ease_slide_request_advance (EaseSlide* _sender, EaseElement* sender, gpointer self) {
#line 549 "ease-player.c"
	ease_player_on_request_advance (self, sender);
}


#line 327 "ease-player.vala"
static void _ease_player_animation_complete_clutter_timeline_completed (ClutterTimeline* _sender, gpointer self) {
#line 556 "ease-player.c"
	ease_player_animation_complete (self);
}


static gpointer _g_object_ref0 (gpointer self) {
	return self ? g_object_ref (self) : NULL;
}


#line 235 "ease-player.vala"
void ease_player_advance (EasePlayer* self) {
#line 568 "ease-player.c"
	gint _tmp1_;
	EaseSlide* slide;
#line 235 "ease-player.vala"
	g_return_if_fail (self != NULL);
#line 238 "ease-player.vala"
	if (!self->priv->_can_animate) {
#line 240 "ease-player.vala"
		return;
#line 577 "ease-player.c"
	}
#line 244 "ease-player.vala"
	if (self->priv->advance_alarm != NULL) {
#line 581 "ease-player.c"
		ClutterTimeline* _tmp0_;
#line 246 "ease-player.vala"
		clutter_timeline_stop (self->priv->advance_alarm);
#line 247 "ease-player.vala"
		self->priv->advance_alarm = (_tmp0_ = NULL, _g_object_unref0 (self->priv->advance_alarm), _tmp0_);
#line 587 "ease-player.c"
	}
#line 250 "ease-player.vala"
	_tmp1_ = self->priv->_slide_index;
#line 250 "ease-player.vala"
	ease_player_set_slide_index (self, _tmp1_ + 1);
#line 250 "ease-player.vala"
	_tmp1_;
#line 251 "ease-player.vala"
	if (self->priv->_slide_index == ease_iterable_list_store_get_size (ease_document_get_slides (self->priv->_document))) {
#line 253 "ease-player.vala"
		g_signal_emit_by_name (self, "complete");
#line 254 "ease-player.vala"
		gtk_widget_hide_all ((GtkWidget*) self);
#line 255 "ease-player.vala"
		return;
#line 603 "ease-player.c"
	}
#line 258 "ease-player.vala"
	slide = ease_document_get_slide (self->priv->_document, self->priv->_slide_index);
#line 261 "ease-player.vala"
	if (self->priv->_slide_index == 0) {
#line 609 "ease-player.c"
		ClutterTimeline* _tmp2_;
#line 263 "ease-player.vala"
		ease_player_create_current_slide (self, slide);
#line 264 "ease-player.vala"
		g_signal_connect_object (slide, "request-advance", (GCallback) _ease_player_on_request_advance_ease_slide_request_advance, self, 0);
#line 265 "ease-player.vala"
		ease_slide_actor_stack (self->priv->current_slide, (ClutterActor*) self->priv->container);
#line 266 "ease-player.vala"
		clutter_actor_set_opacity ((ClutterActor*) self->priv->current_slide, (guint) 0);
#line 267 "ease-player.vala"
		clutter_actor_animate ((ClutterActor*) self->priv->current_slide, (gulong) CLUTTER_EASE_IN_SINE, EASE_PLAYER_FADE_IN_TIME, "opacity", 255, NULL);
#line 270 "ease-player.vala"
		self->priv->advance_alarm = (_tmp2_ = clutter_timeline_new (EASE_PLAYER_FADE_IN_TIME), _g_object_unref0 (self->priv->advance_alarm), _tmp2_);
#line 271 "ease-player.vala"
		g_signal_connect_object (self->priv->advance_alarm, "completed", (GCallback) _ease_player_animation_complete_clutter_timeline_completed, self, 0);
#line 272 "ease-player.vala"
		clutter_timeline_start (self->priv->advance_alarm);
#line 274 "ease-player.vala"
		ease_player_set_can_animate (self, FALSE);
#line 629 "ease-player.c"
	} else {
		guint _tmp3_;
		EaseSlideActor* _tmp4_;
		gboolean _tmp5_ = FALSE;
#line 280 "ease-player.vala"
		g_signal_parse_name ("request-advance", EASE_TYPE_SLIDE, &_tmp3_, NULL, FALSE);
#line 280 "ease-player.vala"
		g_signal_handlers_disconnect_matched (ease_slide_actor_get_slide (self->priv->old_slide), G_SIGNAL_MATCH_ID | G_SIGNAL_MATCH_FUNC | G_SIGNAL_MATCH_DATA, _tmp3_, 0, NULL, (GCallback) _ease_player_on_request_advance_ease_slide_request_advance, self);
#line 281 "ease-player.vala"
		self->priv->old_slide = (_tmp4_ = _g_object_ref0 (self->priv->current_slide), _g_object_unref0 (self->priv->old_slide), _tmp4_);
#line 282 "ease-player.vala"
		ease_player_create_current_slide (self, slide);
#line 283 "ease-player.vala"
		g_signal_connect_object (slide, "request-advance", (GCallback) _ease_player_on_request_advance_ease_slide_request_advance, self, 0);
#line 284 "ease-player.vala"
		clutter_container_add_actor ((ClutterContainer*) self->priv->container, (ClutterActor*) self->priv->current_slide);
#line 286 "ease-player.vala"
		if (ease_slide_get_transition_time (ease_slide_actor_get_slide (self->priv->old_slide)) > 0) {
#line 287 "ease-player.vala"
			_tmp5_ = ease_slide_get_transition (ease_slide_actor_get_slide (self->priv->old_slide)) != EASE_TRANSITION_NONE;
#line 650 "ease-player.c"
		} else {
#line 286 "ease-player.vala"
			_tmp5_ = FALSE;
#line 654 "ease-player.c"
		}
#line 286 "ease-player.vala"
		if (_tmp5_) {
#line 289 "ease-player.vala"
			ease_slide_actor_transition (self->priv->old_slide, self->priv->current_slide, self->priv->container);
#line 290 "ease-player.vala"
			g_signal_connect_object (ease_slide_actor_get_animation_time (self->priv->old_slide), "completed", (GCallback) _ease_player_animation_complete_clutter_timeline_completed, self, 0);
#line 291 "ease-player.vala"
			ease_player_set_can_animate (self, FALSE);
#line 664 "ease-player.c"
		} else {
#line 295 "ease-player.vala"
			ease_player_animation_complete (self);
#line 668 "ease-player.c"
		}
	}
	_g_object_unref0 (slide);
}


#line 300 "ease-player.vala"
static void ease_player_retreat (EasePlayer* self) {
#line 677 "ease-player.c"
	gint _tmp0_;
	EaseSlide* _tmp1_;
#line 300 "ease-player.vala"
	g_return_if_fail (self != NULL);
#line 302 "ease-player.vala"
	if (self->priv->_slide_index == 0) {
#line 303 "ease-player.vala"
		return;
#line 686 "ease-player.c"
	}
#line 306 "ease-player.vala"
	if (ease_slide_actor_get_animation_time (self->priv->old_slide) != NULL) {
#line 307 "ease-player.vala"
		clutter_timeline_stop (ease_slide_actor_get_animation_time (self->priv->old_slide));
#line 692 "ease-player.c"
	}
#line 310 "ease-player.vala"
	_tmp0_ = self->priv->_slide_index;
#line 310 "ease-player.vala"
	ease_player_set_slide_index (self, _tmp0_ - 1);
#line 310 "ease-player.vala"
	_tmp0_;
#line 311 "ease-player.vala"
	ease_player_set_can_animate (self, TRUE);
#line 313 "ease-player.vala"
	clutter_group_remove_all (self->priv->container);
#line 314 "ease-player.vala"
	ease_player_create_current_slide (self, _tmp1_ = ease_document_get_slide (self->priv->_document, self->priv->_slide_index));
#line 706 "ease-player.c"
	_g_object_unref0 (_tmp1_);
#line 315 "ease-player.vala"
	ease_slide_actor_stack (self->priv->current_slide, (ClutterActor*) self->priv->container);
#line 316 "ease-player.vala"
	clutter_container_add_actor ((ClutterContainer*) self->priv->container, (ClutterActor*) self->priv->current_slide);
#line 712 "ease-player.c"
}


#line 319 "ease-player.vala"
static void ease_player_create_current_slide (EasePlayer* self, EaseSlide* slide) {
#line 718 "ease-player.c"
	EaseSlideActor* _tmp0_;
#line 319 "ease-player.vala"
	g_return_if_fail (self != NULL);
#line 319 "ease-player.vala"
	g_return_if_fail (slide != NULL);
#line 323 "ease-player.vala"
	self->priv->current_slide = (_tmp0_ = g_object_ref_sink (ease_slide_actor_new_from_slide (self->priv->_document, slide, TRUE, EASE_ACTOR_CONTEXT_PRESENTATION)), _g_object_unref0 (self->priv->current_slide), _tmp0_);
#line 726 "ease-player.c"
}


#line 340 "ease-player.vala"
static void _lambda49_ (EasePlayer* self) {
#line 341 "ease-player.vala"
	ease_player_advance (self);
#line 734 "ease-player.c"
}


#line 340 "ease-player.vala"
static void __lambda49__clutter_timeline_completed (ClutterTimeline* _sender, gpointer self) {
#line 740 "ease-player.c"
	_lambda49_ (self);
}


#line 327 "ease-player.vala"
static void ease_player_animation_complete (EasePlayer* self) {
#line 327 "ease-player.vala"
	g_return_if_fail (self != NULL);
#line 329 "ease-player.vala"
	clutter_group_remove_all (self->priv->container);
#line 331 "ease-player.vala"
	ease_player_set_can_animate (self, TRUE);
#line 332 "ease-player.vala"
	ease_slide_actor_stack (self->priv->current_slide, (ClutterActor*) self->priv->container);
#line 335 "ease-player.vala"
	if (ease_slide_get_automatically_advance (ease_slide_actor_get_slide (self->priv->current_slide))) {
#line 757 "ease-player.c"
		guint time;
		ClutterTimeline* _tmp0_;
#line 337 "ease-player.vala"
		time = (guint) (1000 * ease_slide_get_advance_delay (ease_slide_actor_get_slide (self->priv->current_slide)));
#line 339 "ease-player.vala"
		self->priv->advance_alarm = (_tmp0_ = clutter_timeline_new (time), _g_object_unref0 (self->priv->advance_alarm), _tmp0_);
#line 340 "ease-player.vala"
		g_signal_connect_object (self->priv->advance_alarm, "completed", (GCallback) __lambda49__clutter_timeline_completed, self, 0);
#line 343 "ease-player.vala"
		clutter_timeline_start (self->priv->advance_alarm);
#line 768 "ease-player.c"
	}
}


/**
 * This is requested by video actors that have finished playing. As the
 * calling function is on Slide, element plugins should never be aware
 * that this functionality exists.
 */
#line 352 "ease-player.vala"
static void ease_player_on_request_advance (EasePlayer* self, EaseElement* element) {
#line 352 "ease-player.vala"
	g_return_if_fail (self != NULL);
#line 352 "ease-player.vala"
	g_return_if_fail (element != NULL);
#line 354 "ease-player.vala"
	ease_player_advance (self);
#line 786 "ease-player.c"
}


EaseDocument* ease_player_get_document (EasePlayer* self) {
	EaseDocument* result;
	g_return_val_if_fail (self != NULL, NULL);
	result = self->priv->_document;
#line 26 "ease-player.vala"
	return result;
#line 796 "ease-player.c"
}


void ease_player_set_document (EasePlayer* self, EaseDocument* value) {
	EaseDocument* _tmp0_;
	g_return_if_fail (self != NULL);
	self->priv->_document = (_tmp0_ = _g_object_ref0 (value), _g_object_unref0 (self->priv->_document), _tmp0_);
	g_object_notify ((GObject *) self, "document");
}


gint ease_player_get_slide_index (EasePlayer* self) {
	gint result;
	g_return_val_if_fail (self != NULL, 0);
	result = self->priv->_slide_index;
#line 27 "ease-player.vala"
	return result;
#line 814 "ease-player.c"
}


void ease_player_set_slide_index (EasePlayer* self, gint value) {
	g_return_if_fail (self != NULL);
	self->priv->_slide_index = value;
	g_object_notify ((GObject *) self, "slide-index");
}


ClutterStage* ease_player_get_stage (EasePlayer* self) {
	ClutterStage* result;
	g_return_val_if_fail (self != NULL, NULL);
	result = self->priv->_stage;
#line 28 "ease-player.vala"
	return result;
#line 831 "ease-player.c"
}


void ease_player_set_stage (EasePlayer* self, ClutterStage* value) {
	ClutterStage* _tmp0_;
	g_return_if_fail (self != NULL);
	self->priv->_stage = (_tmp0_ = _g_object_ref0 (value), _g_object_unref0 (self->priv->_stage), _tmp0_);
	g_object_notify ((GObject *) self, "stage");
}


static gboolean ease_player_get_can_animate (EasePlayer* self) {
	gboolean result;
	g_return_val_if_fail (self != NULL, FALSE);
	result = self->priv->_can_animate;
#line 29 "ease-player.vala"
	return result;
#line 849 "ease-player.c"
}


static void ease_player_set_can_animate (EasePlayer* self, gboolean value) {
	g_return_if_fail (self != NULL);
	self->priv->_can_animate = value;
}


static void ease_player_class_init (EasePlayerClass * klass) {
	ease_player_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (EasePlayerPrivate));
	G_OBJECT_CLASS (klass)->get_property = ease_player_get_property;
	G_OBJECT_CLASS (klass)->set_property = ease_player_set_property;
	G_OBJECT_CLASS (klass)->finalize = ease_player_finalize;
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_PLAYER_DOCUMENT, g_param_spec_object ("document", "document", "document", EASE_TYPE_DOCUMENT, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_PLAYER_SLIDE_INDEX, g_param_spec_int ("slide-index", "slide-index", "slide-index", G_MININT, G_MAXINT, 0, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_PLAYER_STAGE, g_param_spec_object ("stage", "stage", "stage", CLUTTER_TYPE_STAGE, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
	g_signal_new ("complete", EASE_TYPE_PLAYER, G_SIGNAL_RUN_LAST, 0, NULL, NULL, g_cclosure_marshal_VOID__VOID, G_TYPE_NONE, 0);
}


static void ease_player_instance_init (EasePlayer * self) {
	self->priv = EASE_PLAYER_GET_PRIVATE (self);
	self->priv->dragging = FALSE;
	self->priv->scale = (float) 1;
	self->priv->FOCUS_RADIUS = (guint) 100;
}


static void ease_player_finalize (GObject* obj) {
	EasePlayer * self;
	self = EASE_PLAYER (obj);
	_g_object_unref0 (self->priv->_document);
	_g_object_unref0 (self->priv->_stage);
	_g_object_unref0 (self->priv->current_slide);
	_g_object_unref0 (self->priv->old_slide);
	_g_object_unref0 (self->priv->container);
	_g_object_unref0 (self->priv->advance_alarm);
	_g_object_unref0 (self->priv->focus_circle);
	_cairo_pattern_destroy0 (self->priv->radial);
	_cairo_destroy0 (self->priv->cr);
	G_OBJECT_CLASS (ease_player_parent_class)->finalize (obj);
}


/**
 * Presents a {@link Document}
 * 
 * The Ease Player uses ClutterGtk to create a stage floated in the center
 * of a fullscreen Gtk.Window.
 */
GType ease_player_get_type (void) {
	static volatile gsize ease_player_type_id__volatile = 0;
	if (g_once_init_enter (&ease_player_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (EasePlayerClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) ease_player_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (EasePlayer), 0, (GInstanceInitFunc) ease_player_instance_init, NULL };
		GType ease_player_type_id;
		ease_player_type_id = g_type_register_static (GTK_TYPE_WINDOW, "EasePlayer", &g_define_type_info, 0);
		g_once_init_leave (&ease_player_type_id__volatile, ease_player_type_id);
	}
	return ease_player_type_id__volatile;
}


static void ease_player_get_property (GObject * object, guint property_id, GValue * value, GParamSpec * pspec) {
	EasePlayer * self;
	self = EASE_PLAYER (object);
	switch (property_id) {
		case EASE_PLAYER_DOCUMENT:
		g_value_set_object (value, ease_player_get_document (self));
		break;
		case EASE_PLAYER_SLIDE_INDEX:
		g_value_set_int (value, ease_player_get_slide_index (self));
		break;
		case EASE_PLAYER_STAGE:
		g_value_set_object (value, ease_player_get_stage (self));
		break;
		default:
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
		break;
	}
}


static void ease_player_set_property (GObject * object, guint property_id, const GValue * value, GParamSpec * pspec) {
	EasePlayer * self;
	self = EASE_PLAYER (object);
	switch (property_id) {
		case EASE_PLAYER_DOCUMENT:
		ease_player_set_document (self, g_value_get_object (value));
		break;
		case EASE_PLAYER_SLIDE_INDEX:
		ease_player_set_slide_index (self, g_value_get_int (value));
		break;
		case EASE_PLAYER_STAGE:
		ease_player_set_stage (self, g_value_get_object (value));
		break;
		default:
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
		break;
	}
}




