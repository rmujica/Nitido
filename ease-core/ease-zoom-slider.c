/* ease-zoom-slider.c generated by valac 0.10.0, the Vala compiler
 * generated from ease-zoom-slider.vala, do not modify */

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
#include <float.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>


#define EASE_TYPE_ZOOM_SLIDER (ease_zoom_slider_get_type ())
#define EASE_ZOOM_SLIDER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_ZOOM_SLIDER, EaseZoomSlider))
#define EASE_ZOOM_SLIDER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_ZOOM_SLIDER, EaseZoomSliderClass))
#define EASE_IS_ZOOM_SLIDER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_ZOOM_SLIDER))
#define EASE_IS_ZOOM_SLIDER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_ZOOM_SLIDER))
#define EASE_ZOOM_SLIDER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_ZOOM_SLIDER, EaseZoomSliderClass))

typedef struct _EaseZoomSlider EaseZoomSlider;
typedef struct _EaseZoomSliderClass EaseZoomSliderClass;
typedef struct _EaseZoomSliderPrivate EaseZoomSliderPrivate;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))

struct _EaseZoomSlider {
	GtkAlignment parent_instance;
	EaseZoomSliderPrivate * priv;
	gint* values;
	gint values_length1;
};

struct _EaseZoomSliderClass {
	GtkAlignmentClass parent_class;
	void (*change_zoom) (EaseZoomSlider* self, double value);
};

struct _EaseZoomSliderPrivate {
	GtkHScale* zoom_slider;
	GtkButton* zoom_in_button;
	GtkButton* zoom_out_button;
	gboolean buttons_shown_priv;
};


static gpointer ease_zoom_slider_parent_class = NULL;

GType ease_zoom_slider_get_type (void) G_GNUC_CONST;
#define EASE_ZOOM_SLIDER_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), EASE_TYPE_ZOOM_SLIDER, EaseZoomSliderPrivate))
enum  {
	EASE_ZOOM_SLIDER_DUMMY_PROPERTY,
	EASE_ZOOM_SLIDER_VALUE_POS,
	EASE_ZOOM_SLIDER_DIGITS,
	EASE_ZOOM_SLIDER_SLIDERPOS,
	EASE_ZOOM_SLIDER_UPDATE_POLICY,
	EASE_ZOOM_SLIDER_BUTTONS_SHOWN,
	EASE_ZOOM_SLIDER_ADJUSTMENT
};
EaseZoomSlider* ease_zoom_slider_new (GtkAdjustment* adjustment, gint* button_values, int button_values_length1);
EaseZoomSlider* ease_zoom_slider_construct (GType object_type, GtkAdjustment* adjustment, gint* button_values, int button_values_length1);
static gint* _vala_array_dup1 (gint* self, int length);
static void _lambda70_ (EaseZoomSlider* self);
static void __lambda70__gtk_range_value_changed (GtkRange* _sender, gpointer self);
static void _lambda71_ (EaseZoomSlider* self);
void ease_zoom_slider_zoom_in (EaseZoomSlider* self);
static void __lambda71__gtk_button_clicked (GtkButton* _sender, gpointer self);
static void _lambda72_ (EaseZoomSlider* self);
void ease_zoom_slider_zoom_out (EaseZoomSlider* self);
static void __lambda72__gtk_button_clicked (GtkButton* _sender, gpointer self);
static void ease_zoom_slider_buttons_show_handler (EaseZoomSlider* self, GtkWidget* sender);
static void _ease_zoom_slider_buttons_show_handler_gtk_widget_show (GtkWidget* _sender, gpointer self);
static char* _lambda73_ (double val, EaseZoomSlider* self);
static char* __lambda73__gtk_scale_format_value (GtkScale* _sender, double value, gpointer self);
double ease_zoom_slider_get_value (EaseZoomSlider* self);
void ease_zoom_slider_change_zoom (EaseZoomSlider* self, double value);
static void ease_zoom_slider_real_change_zoom (EaseZoomSlider* self, double value);
void ease_zoom_slider_set_sliderpos (EaseZoomSlider* self, double value);
GtkPositionType ease_zoom_slider_get_value_pos (EaseZoomSlider* self);
void ease_zoom_slider_set_value_pos (EaseZoomSlider* self, GtkPositionType value);
gint ease_zoom_slider_get_digits (EaseZoomSlider* self);
void ease_zoom_slider_set_digits (EaseZoomSlider* self, gint value);
double ease_zoom_slider_get_sliderpos (EaseZoomSlider* self);
GtkUpdateType ease_zoom_slider_get_update_policy (EaseZoomSlider* self);
void ease_zoom_slider_set_update_policy (EaseZoomSlider* self, GtkUpdateType value);
gboolean ease_zoom_slider_get_buttons_shown (EaseZoomSlider* self);
void ease_zoom_slider_set_buttons_shown (EaseZoomSlider* self, gboolean value);
GtkAdjustment* ease_zoom_slider_get_adjustment (EaseZoomSlider* self);
void ease_zoom_slider_set_adjustment (EaseZoomSlider* self, GtkAdjustment* value);
static void ease_zoom_slider_finalize (GObject* obj);
static void ease_zoom_slider_get_property (GObject * object, guint property_id, GValue * value, GParamSpec * pspec);
static void ease_zoom_slider_set_property (GObject * object, guint property_id, const GValue * value, GParamSpec * pspec);



/** 
 * Creates a new ZoomSlider.
 *
 * @param adjustment The Gtk.Adjustment to use.
 * @param button_values The values that the slider should stop on when the
 * zoom in and out buttons are pressed.
 */
static gint* _vala_array_dup1 (gint* self, int length) {
	return g_memdup (self, length * sizeof (gint));
}


#line 149 "ease-zoom-slider.vala"
static void _lambda70_ (EaseZoomSlider* self) {
#line 149 "ease-zoom-slider.vala"
	g_signal_emit_by_name (self, "value-changed");
#line 128 "ease-zoom-slider.c"
}


#line 149 "ease-zoom-slider.vala"
static void __lambda70__gtk_range_value_changed (GtkRange* _sender, gpointer self) {
#line 134 "ease-zoom-slider.c"
	_lambda70_ (self);
}


#line 151 "ease-zoom-slider.vala"
static void _lambda71_ (EaseZoomSlider* self) {
#line 151 "ease-zoom-slider.vala"
	ease_zoom_slider_zoom_in (self);
#line 143 "ease-zoom-slider.c"
}


#line 151 "ease-zoom-slider.vala"
static void __lambda71__gtk_button_clicked (GtkButton* _sender, gpointer self) {
#line 149 "ease-zoom-slider.c"
	_lambda71_ (self);
}


#line 153 "ease-zoom-slider.vala"
static void _lambda72_ (EaseZoomSlider* self) {
#line 153 "ease-zoom-slider.vala"
	ease_zoom_slider_zoom_out (self);
#line 158 "ease-zoom-slider.c"
}


#line 153 "ease-zoom-slider.vala"
static void __lambda72__gtk_button_clicked (GtkButton* _sender, gpointer self) {
#line 164 "ease-zoom-slider.c"
	_lambda72_ (self);
}


#line 163 "ease-zoom-slider.vala"
static void _ease_zoom_slider_buttons_show_handler_gtk_widget_show (GtkWidget* _sender, gpointer self) {
#line 171 "ease-zoom-slider.c"
	ease_zoom_slider_buttons_show_handler (self, _sender);
}


#line 158 "ease-zoom-slider.vala"
static char* _lambda73_ (double val, EaseZoomSlider* self) {
#line 178 "ease-zoom-slider.c"
	char* result = NULL;
	result = g_strdup_printf ("%i%%", (gint) val);
#line 159 "ease-zoom-slider.vala"
	return result;
#line 183 "ease-zoom-slider.c"
}


#line 158 "ease-zoom-slider.vala"
static char* __lambda73__gtk_scale_format_value (GtkScale* _sender, double value, gpointer self) {
#line 189 "ease-zoom-slider.c"
	char* result;
	result = _lambda73_ (value, self);
	return result;
}


#line 109 "ease-zoom-slider.vala"
EaseZoomSlider* ease_zoom_slider_construct (GType object_type, GtkAdjustment* adjustment, gint* button_values, int button_values_length1) {
#line 198 "ease-zoom-slider.c"
	EaseZoomSlider * self;
	gint* _tmp0_;
	gint* _tmp1_;
	GtkHBox* hbox;
	GtkHScale* _tmp2_;
	GtkButton* _tmp3_;
	GtkImage* _tmp4_;
	GtkButton* _tmp5_;
	GtkImage* _tmp6_;
	GtkAlignment* align;
	GtkAlignment* _tmp7_;
	GtkAlignment* _tmp8_;
#line 109 "ease-zoom-slider.vala"
	g_return_val_if_fail (adjustment != NULL, NULL);
#line 213 "ease-zoom-slider.c"
	self = g_object_newv (object_type, 0, NULL);
#line 111 "ease-zoom-slider.vala"
	self->values = (_tmp1_ = (_tmp0_ = button_values, (_tmp0_ == NULL) ? ((gpointer) _tmp0_) : _vala_array_dup1 (_tmp0_, button_values_length1)), self->values = (g_free (self->values), NULL), self->values_length1 = button_values_length1, _tmp1_);
#line 113 "ease-zoom-slider.vala"
	hbox = g_object_ref_sink ((GtkHBox*) gtk_hbox_new (FALSE, 5));
#line 116 "ease-zoom-slider.vala"
	self->priv->zoom_slider = (_tmp2_ = g_object_ref_sink ((GtkHScale*) gtk_hscale_new (adjustment)), _g_object_unref0 (self->priv->zoom_slider), _tmp2_);
#line 117 "ease-zoom-slider.vala"
	g_object_set ((GtkWidget*) self->priv->zoom_slider, "width-request", 200, NULL);
#line 118 "ease-zoom-slider.vala"
	gtk_scale_set_draw_value ((GtkScale*) self->priv->zoom_slider, FALSE);
#line 119 "ease-zoom-slider.vala"
	gtk_scale_set_digits ((GtkScale*) self->priv->zoom_slider, 0);
#line 122 "ease-zoom-slider.vala"
	self->priv->zoom_in_button = (_tmp3_ = g_object_ref_sink ((GtkButton*) gtk_button_new ()), _g_object_unref0 (self->priv->zoom_in_button), _tmp3_);
#line 123 "ease-zoom-slider.vala"
	gtk_container_add ((GtkContainer*) self->priv->zoom_in_button, (GtkWidget*) (_tmp4_ = g_object_ref_sink ((GtkImage*) gtk_image_new_from_stock ("gtk-zoom-in", GTK_ICON_SIZE_MENU))));
#line 231 "ease-zoom-slider.c"
	_g_object_unref0 (_tmp4_);
#line 125 "ease-zoom-slider.vala"
	gtk_button_set_relief (self->priv->zoom_in_button, GTK_RELIEF_NONE);
#line 128 "ease-zoom-slider.vala"
	self->priv->zoom_out_button = (_tmp5_ = g_object_ref_sink ((GtkButton*) gtk_button_new ()), _g_object_unref0 (self->priv->zoom_out_button), _tmp5_);
#line 129 "ease-zoom-slider.vala"
	gtk_container_add ((GtkContainer*) self->priv->zoom_out_button, (GtkWidget*) (_tmp6_ = g_object_ref_sink ((GtkImage*) gtk_image_new_from_stock ("gtk-zoom-out", GTK_ICON_SIZE_MENU))));
#line 239 "ease-zoom-slider.c"
	_g_object_unref0 (_tmp6_);
#line 131 "ease-zoom-slider.vala"
	gtk_button_set_relief (self->priv->zoom_out_button, GTK_RELIEF_NONE);
#line 134 "ease-zoom-slider.vala"
	align = g_object_ref_sink ((GtkAlignment*) gtk_alignment_new ((float) 0, 0.5f, (float) 1, (float) 0));
#line 135 "ease-zoom-slider.vala"
	gtk_container_add ((GtkContainer*) align, (GtkWidget*) self->priv->zoom_out_button);
#line 136 "ease-zoom-slider.vala"
	gtk_box_pack_start ((GtkBox*) hbox, (GtkWidget*) align, FALSE, FALSE, (guint) 0);
#line 138 "ease-zoom-slider.vala"
	align = (_tmp7_ = g_object_ref_sink ((GtkAlignment*) gtk_alignment_new ((float) 0, 0.5f, (float) 1, (float) 0)), _g_object_unref0 (align), _tmp7_);
#line 139 "ease-zoom-slider.vala"
	gtk_container_add ((GtkContainer*) align, (GtkWidget*) self->priv->zoom_slider);
#line 140 "ease-zoom-slider.vala"
	gtk_box_pack_start ((GtkBox*) hbox, (GtkWidget*) align, FALSE, FALSE, (guint) 0);
#line 142 "ease-zoom-slider.vala"
	align = (_tmp8_ = g_object_ref_sink ((GtkAlignment*) gtk_alignment_new ((float) 0, 0.5f, (float) 1, (float) 0)), _g_object_unref0 (align), _tmp8_);
#line 143 "ease-zoom-slider.vala"
	gtk_container_add ((GtkContainer*) align, (GtkWidget*) self->priv->zoom_in_button);
#line 144 "ease-zoom-slider.vala"
	gtk_box_pack_start ((GtkBox*) hbox, (GtkWidget*) align, FALSE, FALSE, (guint) 0);
#line 146 "ease-zoom-slider.vala"
	gtk_alignment_set ((GtkAlignment*) self, (float) 1, (float) 1, (float) 1, (float) 1);
#line 147 "ease-zoom-slider.vala"
	gtk_container_add ((GtkContainer*) self, (GtkWidget*) hbox);
#line 149 "ease-zoom-slider.vala"
	g_signal_connect_object ((GtkRange*) self->priv->zoom_slider, "value-changed", (GCallback) __lambda70__gtk_range_value_changed, self, 0);
#line 151 "ease-zoom-slider.vala"
	g_signal_connect_object (self->priv->zoom_in_button, "clicked", (GCallback) __lambda71__gtk_button_clicked, self, 0);
#line 153 "ease-zoom-slider.vala"
	g_signal_connect_object (self->priv->zoom_out_button, "clicked", (GCallback) __lambda72__gtk_button_clicked, self, 0);
#line 155 "ease-zoom-slider.vala"
	g_signal_connect_object ((GtkWidget*) self->priv->zoom_in_button, "show", (GCallback) _ease_zoom_slider_buttons_show_handler_gtk_widget_show, self, 0);
#line 156 "ease-zoom-slider.vala"
	g_signal_connect_object ((GtkWidget*) self->priv->zoom_out_button, "show", (GCallback) _ease_zoom_slider_buttons_show_handler_gtk_widget_show, self, 0);
#line 158 "ease-zoom-slider.vala"
	g_signal_connect_object ((GtkScale*) self->priv->zoom_slider, "format-value", (GCallback) __lambda73__gtk_scale_format_value, self, 0);
#line 277 "ease-zoom-slider.c"
	_g_object_unref0 (align);
	_g_object_unref0 (hbox);
	return self;
}


#line 109 "ease-zoom-slider.vala"
EaseZoomSlider* ease_zoom_slider_new (GtkAdjustment* adjustment, gint* button_values, int button_values_length1) {
#line 109 "ease-zoom-slider.vala"
	return ease_zoom_slider_construct (EASE_TYPE_ZOOM_SLIDER, adjustment, button_values, button_values_length1);
#line 288 "ease-zoom-slider.c"
}


#line 163 "ease-zoom-slider.vala"
static void ease_zoom_slider_buttons_show_handler (EaseZoomSlider* self, GtkWidget* sender) {
#line 163 "ease-zoom-slider.vala"
	g_return_if_fail (self != NULL);
#line 163 "ease-zoom-slider.vala"
	g_return_if_fail (sender != NULL);
#line 165 "ease-zoom-slider.vala"
	self->priv->buttons_shown_priv = TRUE;
#line 300 "ease-zoom-slider.c"
}


/** 
 * Returns the value of the zoom slider.
 */
#line 171 "ease-zoom-slider.vala"
double ease_zoom_slider_get_value (EaseZoomSlider* self) {
#line 309 "ease-zoom-slider.c"
	double result = 0.0;
#line 171 "ease-zoom-slider.vala"
	g_return_val_if_fail (self != NULL, 0.0);
#line 313 "ease-zoom-slider.c"
	result = gtk_range_get_value ((GtkRange*) self->priv->zoom_slider);
#line 173 "ease-zoom-slider.vala"
	return result;
#line 317 "ease-zoom-slider.c"
}


#line 176 "ease-zoom-slider.vala"
void ease_zoom_slider_zoom_out (EaseZoomSlider* self) {
#line 176 "ease-zoom-slider.vala"
	g_return_if_fail (self != NULL);
#line 325 "ease-zoom-slider.c"
	{
		gint i;
#line 178 "ease-zoom-slider.vala"
		i = self->values_length1 - 1;
#line 330 "ease-zoom-slider.c"
		{
			gboolean _tmp0_;
#line 178 "ease-zoom-slider.vala"
			_tmp0_ = TRUE;
#line 178 "ease-zoom-slider.vala"
			while (TRUE) {
#line 178 "ease-zoom-slider.vala"
				if (!_tmp0_) {
#line 178 "ease-zoom-slider.vala"
					i--;
#line 341 "ease-zoom-slider.c"
				}
#line 178 "ease-zoom-slider.vala"
				_tmp0_ = FALSE;
#line 178 "ease-zoom-slider.vala"
				if (!(i > (-1))) {
#line 178 "ease-zoom-slider.vala"
					break;
#line 349 "ease-zoom-slider.c"
				}
#line 180 "ease-zoom-slider.vala"
				if (gtk_range_get_value ((GtkRange*) self->priv->zoom_slider) > self->values[i]) {
#line 182 "ease-zoom-slider.vala"
					ease_zoom_slider_change_zoom (self, (double) self->values[i]);
#line 183 "ease-zoom-slider.vala"
					break;
#line 357 "ease-zoom-slider.c"
				}
			}
		}
	}
}


#line 188 "ease-zoom-slider.vala"
void ease_zoom_slider_zoom_in (EaseZoomSlider* self) {
#line 188 "ease-zoom-slider.vala"
	g_return_if_fail (self != NULL);
#line 369 "ease-zoom-slider.c"
	{
		gint i;
#line 190 "ease-zoom-slider.vala"
		i = 0;
#line 374 "ease-zoom-slider.c"
		{
			gboolean _tmp0_;
#line 190 "ease-zoom-slider.vala"
			_tmp0_ = TRUE;
#line 190 "ease-zoom-slider.vala"
			while (TRUE) {
#line 190 "ease-zoom-slider.vala"
				if (!_tmp0_) {
#line 190 "ease-zoom-slider.vala"
					i++;
#line 385 "ease-zoom-slider.c"
				}
#line 190 "ease-zoom-slider.vala"
				_tmp0_ = FALSE;
#line 190 "ease-zoom-slider.vala"
				if (!(i < self->values_length1)) {
#line 190 "ease-zoom-slider.vala"
					break;
#line 393 "ease-zoom-slider.c"
				}
#line 192 "ease-zoom-slider.vala"
				if (gtk_range_get_value ((GtkRange*) self->priv->zoom_slider) < self->values[i]) {
#line 194 "ease-zoom-slider.vala"
					ease_zoom_slider_change_zoom (self, (double) self->values[i]);
#line 195 "ease-zoom-slider.vala"
					break;
#line 401 "ease-zoom-slider.c"
				}
			}
		}
	}
}


#line 200 "ease-zoom-slider.vala"
static void ease_zoom_slider_real_change_zoom (EaseZoomSlider* self, double value) {
#line 200 "ease-zoom-slider.vala"
	g_return_if_fail (self != NULL);
#line 202 "ease-zoom-slider.vala"
	ease_zoom_slider_set_sliderpos (self, value);
#line 415 "ease-zoom-slider.c"
}


void ease_zoom_slider_change_zoom (EaseZoomSlider* self, double value) {
	EASE_ZOOM_SLIDER_GET_CLASS (self)->change_zoom (self, value);
}


GtkPositionType ease_zoom_slider_get_value_pos (EaseZoomSlider* self) {
	GtkPositionType result;
	g_return_val_if_fail (self != NULL, 0);
	result = gtk_scale_get_value_pos ((GtkScale*) self->priv->zoom_slider);
#line 35 "ease-zoom-slider.vala"
	return result;
#line 430 "ease-zoom-slider.c"
}


void ease_zoom_slider_set_value_pos (EaseZoomSlider* self, GtkPositionType value) {
	g_return_if_fail (self != NULL);
#line 36 "ease-zoom-slider.vala"
	gtk_scale_set_value_pos ((GtkScale*) self->priv->zoom_slider, value);
#line 438 "ease-zoom-slider.c"
	g_object_notify ((GObject *) self, "value-pos");
}


gint ease_zoom_slider_get_digits (EaseZoomSlider* self) {
	gint result;
	g_return_val_if_fail (self != NULL, 0);
	result = gtk_scale_get_digits ((GtkScale*) self->priv->zoom_slider);
#line 44 "ease-zoom-slider.vala"
	return result;
#line 449 "ease-zoom-slider.c"
}


void ease_zoom_slider_set_digits (EaseZoomSlider* self, gint value) {
	g_return_if_fail (self != NULL);
#line 45 "ease-zoom-slider.vala"
	gtk_scale_set_digits ((GtkScale*) self->priv->zoom_slider, value);
#line 457 "ease-zoom-slider.c"
	g_object_notify ((GObject *) self, "digits");
}


double ease_zoom_slider_get_sliderpos (EaseZoomSlider* self) {
	double result;
	g_return_val_if_fail (self != NULL, 0.0);
	result = gtk_range_get_value ((GtkRange*) self->priv->zoom_slider);
#line 53 "ease-zoom-slider.vala"
	return result;
#line 468 "ease-zoom-slider.c"
}


void ease_zoom_slider_set_sliderpos (EaseZoomSlider* self, double value) {
	g_return_if_fail (self != NULL);
#line 54 "ease-zoom-slider.vala"
	gtk_range_set_value ((GtkRange*) self->priv->zoom_slider, value);
#line 476 "ease-zoom-slider.c"
	g_object_notify ((GObject *) self, "sliderpos");
}


GtkUpdateType ease_zoom_slider_get_update_policy (EaseZoomSlider* self) {
	GtkUpdateType result;
	g_return_val_if_fail (self != NULL, 0);
	result = gtk_range_get_update_policy ((GtkRange*) self->priv->zoom_slider);
#line 62 "ease-zoom-slider.vala"
	return result;
#line 487 "ease-zoom-slider.c"
}


void ease_zoom_slider_set_update_policy (EaseZoomSlider* self, GtkUpdateType value) {
	g_return_if_fail (self != NULL);
#line 63 "ease-zoom-slider.vala"
	gtk_range_set_update_policy ((GtkRange*) self->priv->zoom_slider, value);
#line 495 "ease-zoom-slider.c"
	g_object_notify ((GObject *) self, "update-policy");
}


gboolean ease_zoom_slider_get_buttons_shown (EaseZoomSlider* self) {
	gboolean result;
	g_return_val_if_fail (self != NULL, FALSE);
	result = ease_zoom_slider_get_buttons_shown (self);
#line 76 "ease-zoom-slider.vala"
	return result;
#line 506 "ease-zoom-slider.c"
}


void ease_zoom_slider_set_buttons_shown (EaseZoomSlider* self, gboolean value) {
	g_return_if_fail (self != NULL);
#line 79 "ease-zoom-slider.vala"
	if (value == self->priv->buttons_shown_priv) {
#line 79 "ease-zoom-slider.vala"
		return;
#line 516 "ease-zoom-slider.c"
	}
#line 81 "ease-zoom-slider.vala"
	self->priv->buttons_shown_priv = value;
#line 82 "ease-zoom-slider.vala"
	gtk_widget_set_visible ((GtkWidget*) self->priv->zoom_in_button, value);
#line 83 "ease-zoom-slider.vala"
	gtk_widget_set_visible ((GtkWidget*) self->priv->zoom_out_button, value);
#line 524 "ease-zoom-slider.c"
	g_object_notify ((GObject *) self, "buttons-shown");
}


GtkAdjustment* ease_zoom_slider_get_adjustment (EaseZoomSlider* self) {
	GtkAdjustment* result;
	g_return_val_if_fail (self != NULL, NULL);
	result = gtk_range_get_adjustment ((GtkRange*) self->priv->zoom_slider);
#line 92 "ease-zoom-slider.vala"
	return result;
#line 535 "ease-zoom-slider.c"
}


void ease_zoom_slider_set_adjustment (EaseZoomSlider* self, GtkAdjustment* value) {
	g_return_if_fail (self != NULL);
#line 93 "ease-zoom-slider.vala"
	gtk_range_set_adjustment ((GtkRange*) self->priv->zoom_slider, value);
#line 543 "ease-zoom-slider.c"
	g_object_notify ((GObject *) self, "adjustment");
}


static void ease_zoom_slider_class_init (EaseZoomSliderClass * klass) {
	ease_zoom_slider_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (EaseZoomSliderPrivate));
	EASE_ZOOM_SLIDER_CLASS (klass)->change_zoom = ease_zoom_slider_real_change_zoom;
	G_OBJECT_CLASS (klass)->get_property = ease_zoom_slider_get_property;
	G_OBJECT_CLASS (klass)->set_property = ease_zoom_slider_set_property;
	G_OBJECT_CLASS (klass)->finalize = ease_zoom_slider_finalize;
	/** 
	 * The position of the zoom slider's value.
	 */
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_ZOOM_SLIDER_VALUE_POS, g_param_spec_enum ("value-pos", "value-pos", "value-pos", GTK_TYPE_POSITION_TYPE, 0, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
	/** 
	 * The number of digits that the zoom slider displays.
	 */
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_ZOOM_SLIDER_DIGITS, g_param_spec_int ("digits", "digits", "digits", G_MININT, G_MAXINT, 0, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
	/**
	 * The position of the zoom slider.
	 */
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_ZOOM_SLIDER_SLIDERPOS, g_param_spec_double ("sliderpos", "sliderpos", "sliderpos", -G_MAXDOUBLE, G_MAXDOUBLE, 0.0, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
	/**
	 * The update policy of the slider.
	 */
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_ZOOM_SLIDER_UPDATE_POLICY, g_param_spec_enum ("update-policy", "update-policy", "update-policy", GTK_TYPE_UPDATE_TYPE, 0, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
	/**
	 * If the + and - buttons should be shown. Defaults to true.
	 */
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_ZOOM_SLIDER_BUTTONS_SHOWN, g_param_spec_boolean ("buttons-shown", "buttons-shown", "buttons-shown", FALSE, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
	/**
	 * The adjustment of the slider.
	 */
	g_object_class_install_property (G_OBJECT_CLASS (klass), EASE_ZOOM_SLIDER_ADJUSTMENT, g_param_spec_object ("adjustment", "adjustment", "adjustment", GTK_TYPE_ADJUSTMENT, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE | G_PARAM_WRITABLE));
	/** 
	 * Fires when the value of the zoom slider changes.
	 */
	g_signal_new ("value_changed", EASE_TYPE_ZOOM_SLIDER, G_SIGNAL_RUN_LAST, 0, NULL, NULL, g_cclosure_marshal_VOID__VOID, G_TYPE_NONE, 0);
}


static void ease_zoom_slider_instance_init (EaseZoomSlider * self) {
	self->priv = EASE_ZOOM_SLIDER_GET_PRIVATE (self);
	self->priv->buttons_shown_priv = TRUE;
}


static void ease_zoom_slider_finalize (GObject* obj) {
	EaseZoomSlider * self;
	self = EASE_ZOOM_SLIDER (obj);
	_g_object_unref0 (self->priv->zoom_slider);
	_g_object_unref0 (self->priv->zoom_in_button);
	_g_object_unref0 (self->priv->zoom_out_button);
	self->values = (g_free (self->values), NULL);
	G_OBJECT_CLASS (ease_zoom_slider_parent_class)->finalize (obj);
}


/**
 * A zoom widget containing a Gtk.HScale and two (+/-) buttons.
 *
 * ZoomSlider uses ClutterAnimation to smoothly adjust the slider when th
 * zoom in or zoom out button is clicked.
 */
GType ease_zoom_slider_get_type (void) {
	static volatile gsize ease_zoom_slider_type_id__volatile = 0;
	if (g_once_init_enter (&ease_zoom_slider_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (EaseZoomSliderClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) ease_zoom_slider_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (EaseZoomSlider), 0, (GInstanceInitFunc) ease_zoom_slider_instance_init, NULL };
		GType ease_zoom_slider_type_id;
		ease_zoom_slider_type_id = g_type_register_static (GTK_TYPE_ALIGNMENT, "EaseZoomSlider", &g_define_type_info, 0);
		g_once_init_leave (&ease_zoom_slider_type_id__volatile, ease_zoom_slider_type_id);
	}
	return ease_zoom_slider_type_id__volatile;
}


static void ease_zoom_slider_get_property (GObject * object, guint property_id, GValue * value, GParamSpec * pspec) {
	EaseZoomSlider * self;
	self = EASE_ZOOM_SLIDER (object);
	switch (property_id) {
		case EASE_ZOOM_SLIDER_VALUE_POS:
		g_value_set_enum (value, ease_zoom_slider_get_value_pos (self));
		break;
		case EASE_ZOOM_SLIDER_DIGITS:
		g_value_set_int (value, ease_zoom_slider_get_digits (self));
		break;
		case EASE_ZOOM_SLIDER_SLIDERPOS:
		g_value_set_double (value, ease_zoom_slider_get_sliderpos (self));
		break;
		case EASE_ZOOM_SLIDER_UPDATE_POLICY:
		g_value_set_enum (value, ease_zoom_slider_get_update_policy (self));
		break;
		case EASE_ZOOM_SLIDER_BUTTONS_SHOWN:
		g_value_set_boolean (value, ease_zoom_slider_get_buttons_shown (self));
		break;
		case EASE_ZOOM_SLIDER_ADJUSTMENT:
		g_value_set_object (value, ease_zoom_slider_get_adjustment (self));
		break;
		default:
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
		break;
	}
}


static void ease_zoom_slider_set_property (GObject * object, guint property_id, const GValue * value, GParamSpec * pspec) {
	EaseZoomSlider * self;
	self = EASE_ZOOM_SLIDER (object);
	switch (property_id) {
		case EASE_ZOOM_SLIDER_VALUE_POS:
		ease_zoom_slider_set_value_pos (self, g_value_get_enum (value));
		break;
		case EASE_ZOOM_SLIDER_DIGITS:
		ease_zoom_slider_set_digits (self, g_value_get_int (value));
		break;
		case EASE_ZOOM_SLIDER_SLIDERPOS:
		ease_zoom_slider_set_sliderpos (self, g_value_get_double (value));
		break;
		case EASE_ZOOM_SLIDER_UPDATE_POLICY:
		ease_zoom_slider_set_update_policy (self, g_value_get_enum (value));
		break;
		case EASE_ZOOM_SLIDER_BUTTONS_SHOWN:
		ease_zoom_slider_set_buttons_shown (self, g_value_get_boolean (value));
		break;
		case EASE_ZOOM_SLIDER_ADJUSTMENT:
		ease_zoom_slider_set_adjustment (self, g_value_get_object (value));
		break;
		default:
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
		break;
	}
}




