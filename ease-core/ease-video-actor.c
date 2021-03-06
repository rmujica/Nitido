/* ease-video-actor.c generated by valac 0.10.0, the Vala compiler
 * generated from ease-video-actor.vala, do not modify */

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
#include <clutter-gst/clutter-gst.h>
#include <stdlib.h>
#include <string.h>
#include <float.h>
#include <math.h>
#include <cairo.h>


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

#define EASE_TYPE_VIDEO_ACTOR (ease_video_actor_get_type ())
#define EASE_VIDEO_ACTOR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_VIDEO_ACTOR, EaseVideoActor))
#define EASE_VIDEO_ACTOR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_VIDEO_ACTOR, EaseVideoActorClass))
#define EASE_IS_VIDEO_ACTOR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_VIDEO_ACTOR))
#define EASE_IS_VIDEO_ACTOR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_VIDEO_ACTOR))
#define EASE_VIDEO_ACTOR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_VIDEO_ACTOR, EaseVideoActorClass))

typedef struct _EaseVideoActor EaseVideoActor;
typedef struct _EaseVideoActorClass EaseVideoActorClass;
typedef struct _EaseVideoActorPrivate EaseVideoActorPrivate;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))

#define EASE_TYPE_MEDIA_ELEMENT (ease_media_element_get_type ())
#define EASE_MEDIA_ELEMENT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_MEDIA_ELEMENT, EaseMediaElement))
#define EASE_MEDIA_ELEMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_MEDIA_ELEMENT, EaseMediaElementClass))
#define EASE_IS_MEDIA_ELEMENT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_MEDIA_ELEMENT))
#define EASE_IS_MEDIA_ELEMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_MEDIA_ELEMENT))
#define EASE_MEDIA_ELEMENT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_MEDIA_ELEMENT, EaseMediaElementClass))

typedef struct _EaseMediaElement EaseMediaElement;
typedef struct _EaseMediaElementClass EaseMediaElementClass;

#define EASE_TYPE_VIDEO_ELEMENT (ease_video_element_get_type ())
#define EASE_VIDEO_ELEMENT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_VIDEO_ELEMENT, EaseVideoElement))
#define EASE_VIDEO_ELEMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_VIDEO_ELEMENT, EaseVideoElementClass))
#define EASE_IS_VIDEO_ELEMENT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_VIDEO_ELEMENT))
#define EASE_IS_VIDEO_ELEMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_VIDEO_ELEMENT))
#define EASE_VIDEO_ELEMENT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_VIDEO_ELEMENT, EaseVideoElementClass))

typedef struct _EaseVideoElement EaseVideoElement;
typedef struct _EaseVideoElementClass EaseVideoElementClass;

#define EASE_TYPE_SLIDE (ease_slide_get_type ())
#define EASE_SLIDE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_SLIDE, EaseSlide))
#define EASE_SLIDE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_SLIDE, EaseSlideClass))
#define EASE_IS_SLIDE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_SLIDE))
#define EASE_IS_SLIDE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_SLIDE))
#define EASE_SLIDE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_SLIDE, EaseSlideClass))

typedef struct _EaseSlide EaseSlide;
typedef struct _EaseSlideClass EaseSlideClass;

#define EASE_TYPE_DOCUMENT (ease_document_get_type ())
#define EASE_DOCUMENT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_DOCUMENT, EaseDocument))
#define EASE_DOCUMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_DOCUMENT, EaseDocumentClass))
#define EASE_IS_DOCUMENT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_DOCUMENT))
#define EASE_IS_DOCUMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_DOCUMENT))
#define EASE_DOCUMENT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_DOCUMENT, EaseDocumentClass))

typedef struct _EaseDocument EaseDocument;
typedef struct _EaseDocumentClass EaseDocumentClass;
#define _g_free0(var) (var = (g_free (var), NULL))

#define EASE_TYPE_VIDEO_END_ACTION (ease_video_end_action_get_type ())
#define _cairo_destroy0(var) ((var == NULL) ? NULL : (var = (cairo_destroy (var), NULL)))

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

struct _EaseVideoActor {
	EaseActor parent_instance;
	EaseVideoActorPrivate * priv;
};

struct _EaseVideoActorClass {
	EaseActorClass parent_class;
};

struct _EaseVideoActorPrivate {
	ClutterGstVideoTexture* video;
	ClutterTexture* action_button;
	ClutterCairoTexture* gloss;
	ClutterGroup* group;
	ClutterTimeline* timeline;
	ClutterTimeline* timeline_in;
};

typedef enum  {
	EASE_VIDEO_END_ACTION_STOP,
	EASE_VIDEO_END_ACTION_LOOP,
	EASE_VIDEO_END_ACTION_CONTINUE
} EaseVideoEndAction;


static gpointer ease_video_actor_parent_class = NULL;
static ClutterMediaIface* ease_video_actor_clutter_media_parent_iface = NULL;

GType ease_actor_get_type (void) G_GNUC_CONST;
GType ease_element_get_type (void) G_GNUC_CONST;
GType ease_actor_context_get_type (void) G_GNUC_CONST;
GType ease_video_actor_get_type (void) G_GNUC_CONST;
#define EASE_VIDEO_ACTOR_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), EASE_TYPE_VIDEO_ACTOR, EaseVideoActorPrivate))
enum  {
	EASE_VIDEO_ACTOR_DUMMY_PROPERTY
};
#define EASE_VIDEO_ACTOR_PLAY_PATH (_tmp0_ = g_build_filename ("svg", "video-play-button.svg", NULL))
#define EASE_VIDEO_ACTOR_BUTTON_TIME 500
#define EASE_VIDEO_ACTOR_ALPHA_OPACITY CLUTTER_LINEAR
#define EASE_VIDEO_ACTOR_ALPHA_SCALE ((gint) CLUTTER_EASE_IN_BACK)
#define EASE_VIDEO_ACTOR_ALPHA_SCALE_IN ((gint) CLUTTER_EASE_OUT_BACK)
GType ease_media_element_get_type (void) G_GNUC_CONST;
GType ease_video_element_get_type (void) G_GNUC_CONST;
EaseVideoActor* ease_video_actor_new (EaseVideoElement* e, EaseActorContext c);
EaseVideoActor* ease_video_actor_construct (GType object_type, EaseVideoElement* e, EaseActorContext c);
EaseActor* ease_actor_construct (GType object_type, EaseElement* e, EaseActorContext c);
GType ease_slide_get_type (void) G_GNUC_CONST;
EaseSlide* ease_element_get_parent (EaseElement* self);
GType ease_document_get_type (void) G_GNUC_CONST;
EaseDocument* ease_slide_get_parent (EaseSlide* self);
const char* ease_document_get_path (EaseDocument* self);
const char* ease_media_element_get_filename (EaseMediaElement* self);
gboolean ease_video_element_get_mute (EaseVideoElement* self);
void ease_video_actor_set_audio_volume (EaseVideoActor* self, double volume);
gboolean ease_video_element_get_play_auto (EaseVideoElement* self);
static void ease_video_actor_create_paused_ui (EaseVideoActor* self, EaseVideoElement* e, gboolean active);
static gboolean _lambda40_ (ClutterActor* a, ClutterButtonEvent* event, EaseVideoActor* self);
static void _lambda41_ (EaseVideoActor* self);
static void __lambda41__clutter_timeline_completed (ClutterTimeline* _sender, gpointer self);
static gboolean __lambda40__clutter_actor_button_press_event (ClutterActor* _sender, ClutterButtonEvent* event, gpointer self);
static void _lambda42_ (ClutterMedia* v, EaseVideoActor* self);
GType ease_video_end_action_get_type (void) G_GNUC_CONST;
EaseVideoEndAction ease_video_element_get_end_action (EaseVideoElement* self);
void ease_video_actor_set_progress (EaseVideoActor* self, double progress);
void ease_element_request_advance (EaseElement* self);
static void __lambda42__clutter_media_eos (ClutterMedia* _sender, gpointer self);
float ease_element_get_width (EaseElement* self);
float ease_element_get_height (EaseElement* self);
float ease_element_get_x (EaseElement* self);
float ease_element_get_y (EaseElement* self);
void ease_actor_autosize (EaseActor* self, ClutterActor* actor);
char* ease_data_path (const char* path);
static gboolean _lambda38_ (ClutterActor* a, ClutterButtonEvent* event, EaseVideoActor* self);
static void _lambda39_ (EaseVideoActor* self);
static void __lambda39__clutter_timeline_completed (ClutterTimeline* _sender, gpointer self);
static gboolean __lambda38__clutter_actor_button_press_event (ClutterActor* _sender, ClutterButtonEvent* event, gpointer self);
double ease_video_actor_get_audio_volume (EaseVideoActor* self);
double ease_video_actor_get_buffer_fill (EaseVideoActor* self);
gboolean ease_video_actor_get_can_seek (EaseVideoActor* self);
double ease_video_actor_get_duration (EaseVideoActor* self);
gboolean ease_video_actor_get_playing (EaseVideoActor* self);
double ease_video_actor_get_progress (EaseVideoActor* self);
const char* ease_video_actor_get_subtitle_font_name (EaseVideoActor* self);
const char* ease_video_actor_get_subtitle_uri (EaseVideoActor* self);
const char* ease_video_actor_get_uri (EaseVideoActor* self);
void ease_video_actor_set_filename (EaseVideoActor* self, const char* filename);
void ease_video_actor_set_playing (EaseVideoActor* self, gboolean playing);
void ease_video_actor_set_subtitle_font_name (EaseVideoActor* self, const char* font_name);
void ease_video_actor_set_subtitle_uri (EaseVideoActor* self, const char* uri);
void ease_video_actor_set_uri (EaseVideoActor* self, const char* uri);
static void ease_video_actor_finalize (GObject* obj);



/**
 * Instantiates a new VideoActor from an Element.
 * 
 * The VideoActor's context is particularly important due to playback.
 * Playing back automatically in the editor would, of course, not be
 * desired.
 *
 * @param e The represented element.
 * @param c The context of this Actor (Presentation, Sidebar, Editor)
 */
#line 137 "ease-video-actor.vala"
static void _lambda41_ (EaseVideoActor* self) {
#line 138 "ease-video-actor.vala"
	clutter_actor_set_reactive ((ClutterActor*) self->priv->action_button, TRUE);
#line 242 "ease-video-actor.c"
}


#line 137 "ease-video-actor.vala"
static void __lambda41__clutter_timeline_completed (ClutterTimeline* _sender, gpointer self) {
#line 248 "ease-video-actor.c"
	_lambda41_ (self);
}


#line 127 "ease-video-actor.vala"
static gboolean _lambda40_ (ClutterActor* a, ClutterButtonEvent* event, EaseVideoActor* self) {
#line 255 "ease-video-actor.c"
	gboolean result = FALSE;
	ClutterTimeline* _tmp0_;
#line 127 "ease-video-actor.vala"
	g_return_val_if_fail (a != NULL, FALSE);
#line 128 "ease-video-actor.vala"
	clutter_actor_set_reactive ((ClutterActor*) self->priv->video, FALSE);
#line 129 "ease-video-actor.vala"
	clutter_media_set_playing ((ClutterMedia*) self->priv->video, FALSE);
#line 132 "ease-video-actor.vala"
	g_object_set ((ClutterActor*) self->priv->action_button, "scale-x", (double) 1, NULL);
#line 133 "ease-video-actor.vala"
	g_object_set ((ClutterActor*) self->priv->action_button, "scale-y", (double) 1, NULL);
#line 136 "ease-video-actor.vala"
	self->priv->timeline_in = (_tmp0_ = clutter_timeline_new ((guint) EASE_VIDEO_ACTOR_BUTTON_TIME), _g_object_unref0 (self->priv->timeline_in), _tmp0_);
#line 137 "ease-video-actor.vala"
	g_signal_connect_object (self->priv->timeline_in, "completed", (GCallback) __lambda41__clutter_timeline_completed, self, 0);
#line 140 "ease-video-actor.vala"
	clutter_timeline_start (self->priv->timeline_in);
#line 143 "ease-video-actor.vala"
	clutter_actor_animate ((ClutterActor*) self->priv->gloss, (gulong) EASE_VIDEO_ACTOR_ALPHA_OPACITY, (guint) EASE_VIDEO_ACTOR_BUTTON_TIME, "opacity", 255, NULL);
#line 144 "ease-video-actor.vala"
	clutter_actor_animate ((ClutterActor*) self->priv->action_button, (gulong) EASE_VIDEO_ACTOR_ALPHA_OPACITY, (guint) EASE_VIDEO_ACTOR_BUTTON_TIME, "opacity", 255, NULL);
#line 278 "ease-video-actor.c"
	result = TRUE;
#line 146 "ease-video-actor.vala"
	return result;
#line 282 "ease-video-actor.c"
}


#line 127 "ease-video-actor.vala"
static gboolean __lambda40__clutter_actor_button_press_event (ClutterActor* _sender, ClutterButtonEvent* event, gpointer self) {
#line 288 "ease-video-actor.c"
	gboolean result;
	result = _lambda40_ (_sender, event, self);
	return result;
}


#line 150 "ease-video-actor.vala"
static void _lambda42_ (ClutterMedia* v, EaseVideoActor* self) {
#line 297 "ease-video-actor.c"
	EaseElement* _tmp0_;
#line 150 "ease-video-actor.vala"
	g_return_if_fail (v != NULL);
#line 151 "ease-video-actor.vala"
	switch (ease_video_element_get_end_action ((_tmp0_ = ((EaseActor*) self)->element, EASE_IS_VIDEO_ELEMENT (_tmp0_) ? ((EaseVideoElement*) _tmp0_) : NULL))) {
#line 303 "ease-video-actor.c"
		case EASE_VIDEO_END_ACTION_STOP:
		{
#line 154 "ease-video-actor.vala"
			break;
#line 308 "ease-video-actor.c"
		}
		case EASE_VIDEO_END_ACTION_LOOP:
		{
#line 156 "ease-video-actor.vala"
			ease_video_actor_set_progress (self, (double) 0);
#line 157 "ease-video-actor.vala"
			clutter_media_set_playing ((ClutterMedia*) self->priv->video, TRUE);
#line 158 "ease-video-actor.vala"
			break;
#line 318 "ease-video-actor.c"
		}
		case EASE_VIDEO_END_ACTION_CONTINUE:
		{
#line 160 "ease-video-actor.vala"
			ease_element_request_advance (((EaseActor*) self)->element);
#line 161 "ease-video-actor.vala"
			break;
#line 326 "ease-video-actor.c"
		}
	}
}


#line 150 "ease-video-actor.vala"
static void __lambda42__clutter_media_eos (ClutterMedia* _sender, gpointer self) {
#line 334 "ease-video-actor.c"
	_lambda42_ (_sender, self);
}


static gpointer _g_object_ref0 (gpointer self) {
	return self ? g_object_ref (self) : NULL;
}


#line 95 "ease-video-actor.vala"
EaseVideoActor* ease_video_actor_construct (GType object_type, EaseVideoElement* e, EaseActorContext c) {
#line 346 "ease-video-actor.c"
	EaseVideoActor * self;
	ClutterGstVideoTexture* _tmp0_;
	char* _tmp1_;
	ClutterGroup* _tmp2_;
	ClutterActor* _tmp4_;
#line 95 "ease-video-actor.vala"
	g_return_val_if_fail (e != NULL, NULL);
#line 97 "ease-video-actor.vala"
	self = (EaseVideoActor*) ease_actor_construct (object_type, (EaseElement*) e, c);
#line 99 "ease-video-actor.vala"
	self->priv->video = (_tmp0_ = g_object_ref_sink ((ClutterGstVideoTexture*) clutter_gst_video_texture_new ()), _g_object_unref0 (self->priv->video), _tmp0_);
#line 100 "ease-video-actor.vala"
	clutter_media_set_filename ((ClutterMedia*) self->priv->video, _tmp1_ = g_build_filename (ease_document_get_path (ease_slide_get_parent (ease_element_get_parent ((EaseElement*) e))), ease_media_element_get_filename ((EaseMediaElement*) e), NULL));
#line 360 "ease-video-actor.c"
	_g_free0 (_tmp1_);
#line 102 "ease-video-actor.vala"
	self->priv->group = (_tmp2_ = g_object_ref_sink ((ClutterGroup*) clutter_group_new ()), _g_object_unref0 (self->priv->group), _tmp2_);
#line 103 "ease-video-actor.vala"
	clutter_container_add_actor ((ClutterContainer*) self->priv->group, (ClutterActor*) self->priv->video);
#line 106 "ease-video-actor.vala"
	if (c == EASE_ACTOR_CONTEXT_PRESENTATION) {
#line 368 "ease-video-actor.c"
		gint _tmp3_ = 0;
#line 109 "ease-video-actor.vala"
		if (ease_video_element_get_mute (e)) {
#line 109 "ease-video-actor.vala"
			_tmp3_ = 0;
#line 374 "ease-video-actor.c"
		} else {
#line 109 "ease-video-actor.vala"
			_tmp3_ = 1;
#line 378 "ease-video-actor.c"
		}
#line 109 "ease-video-actor.vala"
		ease_video_actor_set_audio_volume (self, (double) _tmp3_);
#line 112 "ease-video-actor.vala"
		if (ease_video_element_get_play_auto (e)) {
#line 114 "ease-video-actor.vala"
			clutter_media_set_playing ((ClutterMedia*) self->priv->video, TRUE);
#line 115 "ease-video-actor.vala"
			clutter_actor_set_reactive ((ClutterActor*) self->priv->video, TRUE);
#line 116 "ease-video-actor.vala"
			ease_video_actor_create_paused_ui (self, e, FALSE);
#line 390 "ease-video-actor.c"
		} else {
#line 121 "ease-video-actor.vala"
			clutter_media_set_playing ((ClutterMedia*) self->priv->video, TRUE);
#line 122 "ease-video-actor.vala"
			clutter_media_set_playing ((ClutterMedia*) self->priv->video, FALSE);
#line 123 "ease-video-actor.vala"
			ease_video_actor_create_paused_ui (self, e, TRUE);
#line 398 "ease-video-actor.c"
		}
#line 127 "ease-video-actor.vala"
		g_signal_connect_object ((ClutterActor*) self->priv->video, "button-press-event", (GCallback) __lambda40__clutter_actor_button_press_event, self, 0);
#line 150 "ease-video-actor.vala"
		g_signal_connect_object ((ClutterMedia*) self->priv->video, "eos", (GCallback) __lambda42__clutter_media_eos, self, 0);
#line 404 "ease-video-actor.c"
	} else {
#line 168 "ease-video-actor.vala"
		ease_video_actor_set_audio_volume (self, (double) 0);
#line 169 "ease-video-actor.vala"
		clutter_media_set_playing ((ClutterMedia*) self->priv->video, TRUE);
#line 170 "ease-video-actor.vala"
		clutter_media_set_playing ((ClutterMedia*) self->priv->video, FALSE);
#line 412 "ease-video-actor.c"
	}
#line 173 "ease-video-actor.vala"
	((EaseActor*) self)->contents = (_tmp4_ = _g_object_ref0 ((ClutterActor*) self->priv->group), _g_object_unref0 (((EaseActor*) self)->contents), _tmp4_);
#line 175 "ease-video-actor.vala"
	clutter_container_add_actor ((ClutterContainer*) self, ((EaseActor*) self)->contents);
#line 176 "ease-video-actor.vala"
	clutter_actor_set_width (((EaseActor*) self)->contents, ease_element_get_width ((EaseElement*) e));
#line 177 "ease-video-actor.vala"
	clutter_actor_set_height (((EaseActor*) self)->contents, ease_element_get_height ((EaseElement*) e));
#line 178 "ease-video-actor.vala"
	clutter_actor_set_x ((ClutterActor*) self, ease_element_get_x ((EaseElement*) e));
#line 179 "ease-video-actor.vala"
	clutter_actor_set_y ((ClutterActor*) self, ease_element_get_y ((EaseElement*) e));
#line 181 "ease-video-actor.vala"
	ease_actor_autosize ((EaseActor*) self, (ClutterActor*) self->priv->video);
#line 428 "ease-video-actor.c"
	return self;
}


#line 95 "ease-video-actor.vala"
EaseVideoActor* ease_video_actor_new (EaseVideoElement* e, EaseActorContext c) {
#line 95 "ease-video-actor.vala"
	return ease_video_actor_construct (EASE_TYPE_VIDEO_ACTOR, e, c);
#line 437 "ease-video-actor.c"
}


#line 227 "ease-video-actor.vala"
static void _lambda39_ (EaseVideoActor* self) {
#line 228 "ease-video-actor.vala"
	clutter_media_set_playing ((ClutterMedia*) self->priv->video, TRUE);
#line 229 "ease-video-actor.vala"
	clutter_actor_set_reactive ((ClutterActor*) self->priv->video, TRUE);
#line 447 "ease-video-actor.c"
}


#line 227 "ease-video-actor.vala"
static void __lambda39__clutter_timeline_completed (ClutterTimeline* _sender, gpointer self) {
#line 453 "ease-video-actor.c"
	_lambda39_ (self);
}


#line 223 "ease-video-actor.vala"
static gboolean _lambda38_ (ClutterActor* a, ClutterButtonEvent* event, EaseVideoActor* self) {
#line 460 "ease-video-actor.c"
	gboolean result = FALSE;
	ClutterTimeline* _tmp0_;
#line 223 "ease-video-actor.vala"
	g_return_val_if_fail (a != NULL, FALSE);
#line 224 "ease-video-actor.vala"
	clutter_actor_set_reactive ((ClutterActor*) self->priv->action_button, FALSE);
#line 225 "ease-video-actor.vala"
	clutter_actor_set_reactive ((ClutterActor*) self->priv->video, TRUE);
#line 226 "ease-video-actor.vala"
	self->priv->timeline = (_tmp0_ = clutter_timeline_new ((guint) EASE_VIDEO_ACTOR_BUTTON_TIME), _g_object_unref0 (self->priv->timeline), _tmp0_);
#line 227 "ease-video-actor.vala"
	g_signal_connect_object (self->priv->timeline, "completed", (GCallback) __lambda39__clutter_timeline_completed, self, 0);
#line 231 "ease-video-actor.vala"
	clutter_timeline_start (self->priv->timeline);
#line 232 "ease-video-actor.vala"
	clutter_actor_animate ((ClutterActor*) self->priv->gloss, (gulong) EASE_VIDEO_ACTOR_ALPHA_OPACITY, (guint) (EASE_VIDEO_ACTOR_BUTTON_TIME / 2), "opacity", 0, NULL);
#line 233 "ease-video-actor.vala"
	clutter_actor_animate ((ClutterActor*) self->priv->action_button, (gulong) EASE_VIDEO_ACTOR_ALPHA_OPACITY, (guint) EASE_VIDEO_ACTOR_BUTTON_TIME, "opacity", 0, NULL);
#line 235 "ease-video-actor.vala"
	clutter_actor_animate ((ClutterActor*) self->priv->action_button, (gulong) EASE_VIDEO_ACTOR_ALPHA_SCALE, (guint) EASE_VIDEO_ACTOR_BUTTON_TIME, "scale-x", 0, NULL);
#line 237 "ease-video-actor.vala"
	clutter_actor_animate ((ClutterActor*) self->priv->action_button, (gulong) EASE_VIDEO_ACTOR_ALPHA_SCALE, (guint) EASE_VIDEO_ACTOR_BUTTON_TIME, "scale-y", 0, NULL);
#line 483 "ease-video-actor.c"
	result = TRUE;
#line 239 "ease-video-actor.vala"
	return result;
#line 487 "ease-video-actor.c"
}


#line 223 "ease-video-actor.vala"
static gboolean __lambda38__clutter_actor_button_press_event (ClutterActor* _sender, ClutterButtonEvent* event, gpointer self) {
#line 493 "ease-video-actor.c"
	gboolean result;
	result = _lambda38_ (_sender, event, self);
	return result;
}


#line 184 "ease-video-actor.vala"
static void ease_video_actor_create_paused_ui (EaseVideoActor* self, EaseVideoElement* e, gboolean active) {
#line 502 "ease-video-actor.c"
	ClutterCairoTexture* _tmp0_;
	cairo_t* cr;
	char* _tmp1_;
	ClutterTexture* _tmp2_;
	ClutterTexture* _tmp3_;
	ClutterTexture* _tmp4_;
	GError * _inner_error_ = NULL;
#line 184 "ease-video-actor.vala"
	g_return_if_fail (self != NULL);
#line 184 "ease-video-actor.vala"
	g_return_if_fail (e != NULL);
#line 187 "ease-video-actor.vala"
	self->priv->gloss = (_tmp0_ = g_object_ref_sink ((ClutterCairoTexture*) clutter_cairo_texture_new ((guint) ((gint) ease_element_get_width ((EaseElement*) e)), (guint) ((gint) ease_element_get_height ((EaseElement*) e)))), _g_object_unref0 (self->priv->gloss), _tmp0_);
#line 188 "ease-video-actor.vala"
	clutter_cairo_texture_set_surface_size (self->priv->gloss, (guint) ((gint) ease_element_get_width ((EaseElement*) e)), (guint) ((gint) ease_element_get_height ((EaseElement*) e)));
#line 189 "ease-video-actor.vala"
	clutter_actor_set_opacity ((ClutterActor*) self->priv->gloss, (guint) 100);
#line 190 "ease-video-actor.vala"
	cr = clutter_cairo_texture_create (self->priv->gloss);
#line 193 "ease-video-actor.vala"
	cairo_save (cr);
#line 194 "ease-video-actor.vala"
	cairo_move_to (cr, (double) 0, (double) 0);
#line 195 "ease-video-actor.vala"
	cairo_line_to (cr, (double) ease_element_get_width ((EaseElement*) e), (double) 0);
#line 196 "ease-video-actor.vala"
	cairo_line_to (cr, (double) 0, (double) ease_element_get_height ((EaseElement*) e));
#line 197 "ease-video-actor.vala"
	cairo_close_path (cr);
#line 198 "ease-video-actor.vala"
	cairo_set_source_rgba (cr, (double) 0, (double) 0, (double) 0, 0.5);
#line 199 "ease-video-actor.vala"
	cairo_fill (cr);
#line 200 "ease-video-actor.vala"
	cairo_restore (cr);
#line 203 "ease-video-actor.vala"
	cairo_move_to (cr, (double) ease_element_get_width ((EaseElement*) e), (double) ease_element_get_height ((EaseElement*) e));
#line 204 "ease-video-actor.vala"
	cairo_line_to (cr, (double) ease_element_get_width ((EaseElement*) e), (double) 0);
#line 205 "ease-video-actor.vala"
	cairo_line_to (cr, (double) 0, (double) ease_element_get_height ((EaseElement*) e));
#line 206 "ease-video-actor.vala"
	cairo_close_path (cr);
#line 207 "ease-video-actor.vala"
	cairo_set_source_rgba (cr, (double) 0, (double) 0, (double) 0, 0.7);
#line 208 "ease-video-actor.vala"
	cairo_fill (cr);
#line 211 "ease-video-actor.vala"
	_tmp3_ = (_tmp2_ = g_object_ref_sink (clutter_texture_new_from_file (_tmp1_ = ease_data_path (EASE_VIDEO_ACTOR_PLAY_PATH), &_inner_error_)), _g_free0 (_tmp1_), _tmp2_);
#line 552 "ease-video-actor.c"
	if (_inner_error_ != NULL) {
		_cairo_destroy0 (cr);
		g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
		g_clear_error (&_inner_error_);
		return;
	}
#line 211 "ease-video-actor.vala"
	self->priv->action_button = (_tmp4_ = g_object_ref_sink (_tmp3_), _g_object_unref0 (self->priv->action_button), _tmp4_);
#line 214 "ease-video-actor.vala"
	g_object_set ((ClutterActor*) self->priv->action_button, "anchor-gravity", CLUTTER_GRAVITY_CENTER, NULL);
#line 215 "ease-video-actor.vala"
	clutter_actor_set_x ((ClutterActor*) self->priv->action_button, ease_element_get_width ((EaseElement*) e) / 2);
#line 216 "ease-video-actor.vala"
	clutter_actor_set_y ((ClutterActor*) self->priv->action_button, ease_element_get_height ((EaseElement*) e) / 2);
#line 219 "ease-video-actor.vala"
	clutter_container_add_actor ((ClutterContainer*) self->priv->group, (ClutterActor*) self->priv->gloss);
#line 220 "ease-video-actor.vala"
	clutter_container_add_actor ((ClutterContainer*) self->priv->group, (ClutterActor*) self->priv->action_button);
#line 223 "ease-video-actor.vala"
	g_signal_connect_object ((ClutterActor*) self->priv->action_button, "button-press-event", (GCallback) __lambda38__clutter_actor_button_press_event, self, 0);
#line 243 "ease-video-actor.vala"
	if (!active) {
#line 245 "ease-video-actor.vala"
		clutter_actor_set_opacity ((ClutterActor*) self->priv->action_button, (guint) 0);
#line 246 "ease-video-actor.vala"
		clutter_actor_set_opacity ((ClutterActor*) self->priv->gloss, (guint) 0);
#line 579 "ease-video-actor.c"
	} else {
#line 250 "ease-video-actor.vala"
		clutter_actor_set_reactive ((ClutterActor*) self->priv->action_button, TRUE);
#line 583 "ease-video-actor.c"
	}
	_cairo_destroy0 (cr);
}


#line 254 "ease-video-actor.vala"
double ease_video_actor_get_audio_volume (EaseVideoActor* self) {
#line 591 "ease-video-actor.c"
	double result = 0.0;
#line 254 "ease-video-actor.vala"
	g_return_val_if_fail (self != NULL, 0.0);
#line 595 "ease-video-actor.c"
	result = clutter_media_get_audio_volume ((ClutterMedia*) self->priv->video);
#line 256 "ease-video-actor.vala"
	return result;
#line 599 "ease-video-actor.c"
}


#line 259 "ease-video-actor.vala"
double ease_video_actor_get_buffer_fill (EaseVideoActor* self) {
#line 605 "ease-video-actor.c"
	double result = 0.0;
#line 259 "ease-video-actor.vala"
	g_return_val_if_fail (self != NULL, 0.0);
#line 609 "ease-video-actor.c"
	result = clutter_media_get_buffer_fill ((ClutterMedia*) self->priv->video);
#line 261 "ease-video-actor.vala"
	return result;
#line 613 "ease-video-actor.c"
}


#line 264 "ease-video-actor.vala"
gboolean ease_video_actor_get_can_seek (EaseVideoActor* self) {
#line 619 "ease-video-actor.c"
	gboolean result = FALSE;
#line 264 "ease-video-actor.vala"
	g_return_val_if_fail (self != NULL, FALSE);
#line 623 "ease-video-actor.c"
	result = clutter_media_get_can_seek ((ClutterMedia*) self->priv->video);
#line 266 "ease-video-actor.vala"
	return result;
#line 627 "ease-video-actor.c"
}


#line 269 "ease-video-actor.vala"
double ease_video_actor_get_duration (EaseVideoActor* self) {
#line 633 "ease-video-actor.c"
	double result = 0.0;
#line 269 "ease-video-actor.vala"
	g_return_val_if_fail (self != NULL, 0.0);
#line 637 "ease-video-actor.c"
	result = clutter_media_get_duration ((ClutterMedia*) self->priv->video);
#line 271 "ease-video-actor.vala"
	return result;
#line 641 "ease-video-actor.c"
}


#line 274 "ease-video-actor.vala"
gboolean ease_video_actor_get_playing (EaseVideoActor* self) {
#line 647 "ease-video-actor.c"
	gboolean result = FALSE;
#line 274 "ease-video-actor.vala"
	g_return_val_if_fail (self != NULL, FALSE);
#line 651 "ease-video-actor.c"
	result = clutter_media_get_playing ((ClutterMedia*) self->priv->video);
#line 276 "ease-video-actor.vala"
	return result;
#line 655 "ease-video-actor.c"
}


#line 279 "ease-video-actor.vala"
double ease_video_actor_get_progress (EaseVideoActor* self) {
#line 661 "ease-video-actor.c"
	double result = 0.0;
#line 279 "ease-video-actor.vala"
	g_return_val_if_fail (self != NULL, 0.0);
#line 665 "ease-video-actor.c"
	result = clutter_media_get_progress ((ClutterMedia*) self->priv->video);
#line 281 "ease-video-actor.vala"
	return result;
#line 669 "ease-video-actor.c"
}


#line 284 "ease-video-actor.vala"
const char* ease_video_actor_get_subtitle_font_name (EaseVideoActor* self) {
#line 675 "ease-video-actor.c"
	const char* result = NULL;
#line 284 "ease-video-actor.vala"
	g_return_val_if_fail (self != NULL, NULL);
#line 679 "ease-video-actor.c"
	result = clutter_media_get_subtitle_font_name ((ClutterMedia*) self->priv->video);
#line 286 "ease-video-actor.vala"
	return result;
#line 683 "ease-video-actor.c"
}


#line 289 "ease-video-actor.vala"
const char* ease_video_actor_get_subtitle_uri (EaseVideoActor* self) {
#line 689 "ease-video-actor.c"
	const char* result = NULL;
#line 289 "ease-video-actor.vala"
	g_return_val_if_fail (self != NULL, NULL);
#line 693 "ease-video-actor.c"
	result = clutter_media_get_subtitle_uri ((ClutterMedia*) self->priv->video);
#line 291 "ease-video-actor.vala"
	return result;
#line 697 "ease-video-actor.c"
}


#line 294 "ease-video-actor.vala"
const char* ease_video_actor_get_uri (EaseVideoActor* self) {
#line 703 "ease-video-actor.c"
	const char* result = NULL;
#line 294 "ease-video-actor.vala"
	g_return_val_if_fail (self != NULL, NULL);
#line 707 "ease-video-actor.c"
	result = clutter_media_get_uri ((ClutterMedia*) self->priv->video);
#line 296 "ease-video-actor.vala"
	return result;
#line 711 "ease-video-actor.c"
}


#line 299 "ease-video-actor.vala"
void ease_video_actor_set_audio_volume (EaseVideoActor* self, double volume) {
#line 299 "ease-video-actor.vala"
	g_return_if_fail (self != NULL);
#line 301 "ease-video-actor.vala"
	clutter_media_set_audio_volume ((ClutterMedia*) self->priv->video, volume);
#line 721 "ease-video-actor.c"
}


#line 304 "ease-video-actor.vala"
void ease_video_actor_set_filename (EaseVideoActor* self, const char* filename) {
#line 304 "ease-video-actor.vala"
	g_return_if_fail (self != NULL);
#line 304 "ease-video-actor.vala"
	g_return_if_fail (filename != NULL);
#line 306 "ease-video-actor.vala"
	clutter_media_set_filename ((ClutterMedia*) self->priv->video, filename);
#line 733 "ease-video-actor.c"
}


#line 309 "ease-video-actor.vala"
void ease_video_actor_set_playing (EaseVideoActor* self, gboolean playing) {
#line 309 "ease-video-actor.vala"
	g_return_if_fail (self != NULL);
#line 311 "ease-video-actor.vala"
	clutter_media_set_playing ((ClutterMedia*) self->priv->video, playing);
#line 743 "ease-video-actor.c"
}


#line 314 "ease-video-actor.vala"
void ease_video_actor_set_progress (EaseVideoActor* self, double progress) {
#line 314 "ease-video-actor.vala"
	g_return_if_fail (self != NULL);
#line 316 "ease-video-actor.vala"
	clutter_media_set_progress ((ClutterMedia*) self->priv->video, progress);
#line 753 "ease-video-actor.c"
}


#line 319 "ease-video-actor.vala"
void ease_video_actor_set_subtitle_font_name (EaseVideoActor* self, const char* font_name) {
#line 319 "ease-video-actor.vala"
	g_return_if_fail (self != NULL);
#line 319 "ease-video-actor.vala"
	g_return_if_fail (font_name != NULL);
#line 321 "ease-video-actor.vala"
	clutter_media_set_subtitle_font_name ((ClutterMedia*) self->priv->video, font_name);
#line 765 "ease-video-actor.c"
}


#line 324 "ease-video-actor.vala"
void ease_video_actor_set_subtitle_uri (EaseVideoActor* self, const char* uri) {
#line 324 "ease-video-actor.vala"
	g_return_if_fail (self != NULL);
#line 324 "ease-video-actor.vala"
	g_return_if_fail (uri != NULL);
#line 326 "ease-video-actor.vala"
	clutter_media_set_subtitle_uri ((ClutterMedia*) self->priv->video, uri);
#line 777 "ease-video-actor.c"
}


#line 329 "ease-video-actor.vala"
void ease_video_actor_set_uri (EaseVideoActor* self, const char* uri) {
#line 329 "ease-video-actor.vala"
	g_return_if_fail (self != NULL);
#line 329 "ease-video-actor.vala"
	g_return_if_fail (uri != NULL);
#line 331 "ease-video-actor.vala"
	clutter_media_set_uri ((ClutterMedia*) self->priv->video, uri);
#line 789 "ease-video-actor.c"
}


static void ease_video_actor_class_init (EaseVideoActorClass * klass) {
	ease_video_actor_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (EaseVideoActorPrivate));
	G_OBJECT_CLASS (klass)->finalize = ease_video_actor_finalize;
}


static void ease_video_actor_clutter_media_interface_init (ClutterMediaIface * iface) {
	ease_video_actor_clutter_media_parent_iface = g_type_interface_peek_parent (iface);
}


static void ease_video_actor_instance_init (EaseVideoActor * self) {
	self->priv = EASE_VIDEO_ACTOR_GET_PRIVATE (self);
}


static void ease_video_actor_finalize (GObject* obj) {
	EaseVideoActor * self;
	self = EASE_VIDEO_ACTOR (obj);
	_g_object_unref0 (self->priv->video);
	_g_object_unref0 (self->priv->action_button);
	_g_object_unref0 (self->priv->gloss);
	_g_object_unref0 (self->priv->group);
	_g_object_unref0 (self->priv->timeline);
	_g_object_unref0 (self->priv->timeline_in);
	G_OBJECT_CLASS (ease_video_actor_parent_class)->finalize (obj);
}


/**
 * {@link Actor} for videos
 *
 * VideoActor uses Clutter-GStreamer, and therefore supports any video
 * format supported by the GStreamer plugins on the user's system.
 *
 * VideoActor "implements" Clutter.Media by passing through all function calls
 * to its VideoTexture.
 */
GType ease_video_actor_get_type (void) {
	static volatile gsize ease_video_actor_type_id__volatile = 0;
	if (g_once_init_enter (&ease_video_actor_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (EaseVideoActorClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) ease_video_actor_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (EaseVideoActor), 0, (GInstanceInitFunc) ease_video_actor_instance_init, NULL };
		static const GInterfaceInfo clutter_media_info = { (GInterfaceInitFunc) ease_video_actor_clutter_media_interface_init, (GInterfaceFinalizeFunc) NULL, NULL};
		GType ease_video_actor_type_id;
		ease_video_actor_type_id = g_type_register_static (EASE_TYPE_ACTOR, "EaseVideoActor", &g_define_type_info, 0);
		g_type_add_interface_static (ease_video_actor_type_id, CLUTTER_TYPE_MEDIA, &clutter_media_info);
		g_once_init_leave (&ease_video_actor_type_id__volatile, ease_video_actor_type_id);
	}
	return ease_video_actor_type_id__volatile;
}




