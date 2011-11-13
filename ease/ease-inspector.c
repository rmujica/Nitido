/* ease-inspector.c generated by valac 0.10.0, the Vala compiler
 * generated from ease-inspector.vala, do not modify */

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
#include <stdlib.h>
#include <string.h>


#define EASE_TYPE_INSPECTOR (ease_inspector_get_type ())
#define EASE_INSPECTOR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_INSPECTOR, EaseInspector))
#define EASE_INSPECTOR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_INSPECTOR, EaseInspectorClass))
#define EASE_IS_INSPECTOR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_INSPECTOR))
#define EASE_IS_INSPECTOR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_INSPECTOR))
#define EASE_INSPECTOR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_INSPECTOR, EaseInspectorClass))

typedef struct _EaseInspector EaseInspector;
typedef struct _EaseInspectorClass EaseInspectorClass;
typedef struct _EaseInspectorPrivate EaseInspectorPrivate;

#define EASE_TYPE_INSPECTOR_PANE (ease_inspector_pane_get_type ())
#define EASE_INSPECTOR_PANE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_INSPECTOR_PANE, EaseInspectorPane))
#define EASE_INSPECTOR_PANE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_INSPECTOR_PANE, EaseInspectorPaneClass))
#define EASE_IS_INSPECTOR_PANE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_INSPECTOR_PANE))
#define EASE_IS_INSPECTOR_PANE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_INSPECTOR_PANE))
#define EASE_INSPECTOR_PANE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_INSPECTOR_PANE, EaseInspectorPaneClass))

typedef struct _EaseInspectorPane EaseInspectorPane;
typedef struct _EaseInspectorPaneClass EaseInspectorPaneClass;

#define EASE_TYPE_INSPECTOR_ELEMENT_PANE (ease_inspector_element_pane_get_type ())
#define EASE_INSPECTOR_ELEMENT_PANE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_INSPECTOR_ELEMENT_PANE, EaseInspectorElementPane))
#define EASE_INSPECTOR_ELEMENT_PANE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_INSPECTOR_ELEMENT_PANE, EaseInspectorElementPaneClass))
#define EASE_IS_INSPECTOR_ELEMENT_PANE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_INSPECTOR_ELEMENT_PANE))
#define EASE_IS_INSPECTOR_ELEMENT_PANE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_INSPECTOR_ELEMENT_PANE))
#define EASE_INSPECTOR_ELEMENT_PANE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_INSPECTOR_ELEMENT_PANE, EaseInspectorElementPaneClass))

typedef struct _EaseInspectorElementPane EaseInspectorElementPane;
typedef struct _EaseInspectorElementPaneClass EaseInspectorElementPaneClass;

#define EASE_TYPE_INSPECTOR_TRANSITION_PANE (ease_inspector_transition_pane_get_type ())
#define EASE_INSPECTOR_TRANSITION_PANE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_INSPECTOR_TRANSITION_PANE, EaseInspectorTransitionPane))
#define EASE_INSPECTOR_TRANSITION_PANE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_INSPECTOR_TRANSITION_PANE, EaseInspectorTransitionPaneClass))
#define EASE_IS_INSPECTOR_TRANSITION_PANE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_INSPECTOR_TRANSITION_PANE))
#define EASE_IS_INSPECTOR_TRANSITION_PANE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_INSPECTOR_TRANSITION_PANE))
#define EASE_INSPECTOR_TRANSITION_PANE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_INSPECTOR_TRANSITION_PANE, EaseInspectorTransitionPaneClass))

typedef struct _EaseInspectorTransitionPane EaseInspectorTransitionPane;
typedef struct _EaseInspectorTransitionPaneClass EaseInspectorTransitionPaneClass;

#define EASE_TYPE_INSPECTOR_SLIDE_PANE (ease_inspector_slide_pane_get_type ())
#define EASE_INSPECTOR_SLIDE_PANE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_INSPECTOR_SLIDE_PANE, EaseInspectorSlidePane))
#define EASE_INSPECTOR_SLIDE_PANE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_INSPECTOR_SLIDE_PANE, EaseInspectorSlidePaneClass))
#define EASE_IS_INSPECTOR_SLIDE_PANE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_INSPECTOR_SLIDE_PANE))
#define EASE_IS_INSPECTOR_SLIDE_PANE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_INSPECTOR_SLIDE_PANE))
#define EASE_INSPECTOR_SLIDE_PANE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_INSPECTOR_SLIDE_PANE, EaseInspectorSlidePaneClass))

typedef struct _EaseInspectorSlidePane EaseInspectorSlidePane;
typedef struct _EaseInspectorSlidePaneClass EaseInspectorSlidePaneClass;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))

struct _EaseInspector {
	GtkNotebook parent_instance;
	EaseInspectorPrivate * priv;
	EaseInspectorElementPane* element_pane;
};

struct _EaseInspectorClass {
	GtkNotebookClass parent_class;
};

struct _EaseInspectorPrivate {
	EaseInspectorTransitionPane* transition_pane;
	EaseInspectorSlidePane* slide_pane;
	EaseSlide* slide_priv;
};


static gpointer ease_inspector_parent_class = NULL;

GType ease_inspector_get_type (void) G_GNUC_CONST;
GType ease_inspector_pane_get_type (void) G_GNUC_CONST;
GType ease_inspector_element_pane_get_type (void) G_GNUC_CONST;
GType ease_inspector_transition_pane_get_type (void) G_GNUC_CONST;
GType ease_inspector_slide_pane_get_type (void) G_GNUC_CONST;
#define EASE_INSPECTOR_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), EASE_TYPE_INSPECTOR, EaseInspectorPrivate))
enum  {
	EASE_INSPECTOR_DUMMY_PROPERTY,
	EASE_INSPECTOR_SLIDE
};
#define EASE_INSPECTOR_REQUEST_WIDTH 200
#define EASE_INSPECTOR_REQUEST_HEIGHT 0
EaseInspector* ease_inspector_new (EaseDocument* document);
EaseInspector* ease_inspector_construct (GType object_type, EaseDocument* document);
EaseInspectorTransitionPane* ease_inspector_transition_pane_new (EaseDocument* d);
EaseInspectorTransitionPane* ease_inspector_transition_pane_construct (GType object_type, EaseDocument* d);
EaseInspectorElementPane* ease_inspector_element_pane_new (EaseDocument* d);
EaseInspectorElementPane* ease_inspector_element_pane_construct (GType object_type, EaseDocument* d);
EaseInspectorSlidePane* ease_inspector_slide_pane_new (EaseDocument* d);
EaseInspectorSlidePane* ease_inspector_slide_pane_construct (GType object_type, EaseDocument* d);
static void ease_inspector_append (EaseInspector* self, EaseInspectorPane* i, const char* stock_id);
EaseSlide* ease_inspector_get_slide (EaseInspector* self);
void ease_inspector_set_slide (EaseInspector* self, EaseSlide* value);
void ease_inspector_pane_set_slide (EaseInspectorPane* self, EaseSlide* value);
static void ease_inspector_finalize (GObject* obj);
static void ease_inspector_get_property (GObject * object, guint property_id, GValue * value, GParamSpec * pspec);
static void ease_inspector_set_property (GObject * object, guint property_id, const GValue * value, GParamSpec * pspec);



#line 46 "ease-inspector.vala"
EaseInspector* ease_inspector_construct (GType object_type, EaseDocument* document) {
#line 133 "ease-inspector.c"
	EaseInspector * self;
	EaseInspectorTransitionPane* _tmp0_;
	EaseInspectorElementPane* _tmp1_;
	EaseInspectorSlidePane* _tmp2_;
#line 46 "ease-inspector.vala"
	g_return_val_if_fail (document != NULL, NULL);
#line 140 "ease-inspector.c"
	self = g_object_newv (object_type, 0, NULL);
#line 48 "ease-inspector.vala"
	gtk_widget_set_size_request ((GtkWidget*) self, EASE_INSPECTOR_REQUEST_WIDTH, EASE_INSPECTOR_REQUEST_HEIGHT);
#line 50 "ease-inspector.vala"
	self->priv->transition_pane = (_tmp0_ = g_object_ref_sink (ease_inspector_transition_pane_new (document)), _g_object_unref0 (self->priv->transition_pane), _tmp0_);
#line 51 "ease-inspector.vala"
	self->element_pane = (_tmp1_ = g_object_ref_sink (ease_inspector_element_pane_new (document)), _g_object_unref0 (self->element_pane), _tmp1_);
#line 52 "ease-inspector.vala"
	self->priv->slide_pane = (_tmp2_ = g_object_ref_sink (ease_inspector_slide_pane_new (document)), _g_object_unref0 (self->priv->slide_pane), _tmp2_);
#line 55 "ease-inspector.vala"
	ease_inspector_append (self, (EaseInspectorPane*) self->priv->slide_pane, "gtk-page-setup");
#line 56 "ease-inspector.vala"
	ease_inspector_append (self, (EaseInspectorPane*) self->element_pane, "gtk-index");
#line 57 "ease-inspector.vala"
	ease_inspector_append (self, (EaseInspectorPane*) self->priv->transition_pane, "gtk-media-forward");
#line 58 "ease-inspector.vala"
	gtk_widget_show ((GtkWidget*) self->priv->slide_pane);
#line 59 "ease-inspector.vala"
	gtk_widget_show_all ((GtkWidget*) self->element_pane);
#line 60 "ease-inspector.vala"
	gtk_widget_show_all ((GtkWidget*) self->priv->transition_pane);
#line 162 "ease-inspector.c"
	return self;
}


#line 46 "ease-inspector.vala"
EaseInspector* ease_inspector_new (EaseDocument* document) {
#line 46 "ease-inspector.vala"
	return ease_inspector_construct (EASE_TYPE_INSPECTOR, document);
#line 171 "ease-inspector.c"
}


#line 63 "ease-inspector.vala"
static void ease_inspector_append (EaseInspector* self, EaseInspectorPane* i, const char* stock_id) {
#line 177 "ease-inspector.c"
	GtkImage* _tmp0_;
#line 63 "ease-inspector.vala"
	g_return_if_fail (self != NULL);
#line 63 "ease-inspector.vala"
	g_return_if_fail (i != NULL);
#line 63 "ease-inspector.vala"
	g_return_if_fail (stock_id != NULL);
#line 65 "ease-inspector.vala"
	gtk_notebook_append_page ((GtkNotebook*) self, (GtkWidget*) i, (GtkWidget*) (_tmp0_ = g_object_ref_sink ((GtkImage*) gtk_image_new_from_stock (stock_id, GTK_ICON_SIZE_SMALL_TOOLBAR))));
#line 187 "ease-inspector.c"
	_g_object_unref0 (_tmp0_);
}


EaseSlide* ease_inspector_get_slide (EaseInspector* self) {
	EaseSlide* result;
	g_return_val_if_fail (self != NULL, NULL);
	result = self->priv->slide_priv;
#line 38 "ease-inspector.vala"
	return result;
#line 198 "ease-inspector.c"
}


static gpointer _g_object_ref0 (gpointer self) {
	return self ? g_object_ref (self) : NULL;
}


void ease_inspector_set_slide (EaseInspector* self, EaseSlide* value) {
	EaseSlide* _tmp0_;
	g_return_if_fail (self != NULL);
#line 40 "ease-inspector.vala"
	self->priv->slide_priv = (_tmp0_ = _g_object_ref0 (value), _g_object_unref0 (self->priv->slide_priv), _tmp0_);
#line 41 "ease-inspector.vala"
	ease_inspector_pane_set_slide ((EaseInspectorPane*) self->priv->transition_pane, value);
#line 42 "ease-inspector.vala"
	ease_inspector_pane_set_slide ((EaseInspectorPane*) self->priv->slide_pane, value);
#line 216 "ease-inspector.c"
	g_object_notify ((GObject *) self, "slide");
}


static void ease_inspector_class_init (EaseInspectorClass * klass) {
	ease_inspector_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (EaseInspectorPrivate));
	G_OBJECT_CLASS (klass)->get_property = ease_inspector_get_property;
	G_OBJECT_CLASS (klass)->set_property = ease_inspector_set_property;
	G_OBJECT_CLASS (klass)->finalize = ease_inspector_finalize;
	/**
	 * The {@link Slide} that this Inspector is currently affecting.
	 */
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_INSPECTOR_SLIDE, g_param_spec_object ("slide", "slide", "slide", EASE_TYPE_SLIDE, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
}


static void ease_inspector_instance_init (EaseInspector * self) {
	self->priv = EASE_INSPECTOR_GET_PRIVATE (self);
}


static void ease_inspector_finalize (GObject* obj) {
	EaseInspector * self;
	self = EASE_INSPECTOR (obj);
	_g_object_unref0 (self->priv->transition_pane);
	_g_object_unref0 (self->priv->slide_pane);
	_g_object_unref0 (self->element_pane);
	_g_object_unref0 (self->priv->slide_priv);
	G_OBJECT_CLASS (ease_inspector_parent_class)->finalize (obj);
}


/**
 * Inspector widget for editing slide properties
 */
GType ease_inspector_get_type (void) {
	static volatile gsize ease_inspector_type_id__volatile = 0;
	if (g_once_init_enter (&ease_inspector_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (EaseInspectorClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) ease_inspector_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (EaseInspector), 0, (GInstanceInitFunc) ease_inspector_instance_init, NULL };
		GType ease_inspector_type_id;
		ease_inspector_type_id = g_type_register_static (GTK_TYPE_NOTEBOOK, "EaseInspector", &g_define_type_info, 0);
		g_once_init_leave (&ease_inspector_type_id__volatile, ease_inspector_type_id);
	}
	return ease_inspector_type_id__volatile;
}


static void ease_inspector_get_property (GObject * object, guint property_id, GValue * value, GParamSpec * pspec) {
	EaseInspector * self;
	self = EASE_INSPECTOR (object);
	switch (property_id) {
		case EASE_INSPECTOR_SLIDE:
		g_value_set_object (value, ease_inspector_get_slide (self));
		break;
		default:
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
		break;
	}
}


static void ease_inspector_set_property (GObject * object, guint property_id, const GValue * value, GParamSpec * pspec) {
	EaseInspector * self;
	self = EASE_INSPECTOR (object);
	switch (property_id) {
		case EASE_INSPECTOR_SLIDE:
		ease_inspector_set_slide (self, g_value_get_object (value));
		break;
		default:
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
		break;
	}
}




