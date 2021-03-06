/* ease-close-confirm-dialog.c generated by valac 0.10.0, the Vala compiler
 * generated from ease-close-confirm-dialog.vala, do not modify */

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
#include <clutter/clutter.h>
#include <stdlib.h>
#include <string.h>
#include <glib/gi18n-lib.h>
#include <float.h>
#include <math.h>


#define EASE_TYPE_CLOSE_CONFIRM_DIALOG (ease_close_confirm_dialog_get_type ())
#define EASE_CLOSE_CONFIRM_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EASE_TYPE_CLOSE_CONFIRM_DIALOG, EaseCloseConfirmDialog))
#define EASE_CLOSE_CONFIRM_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EASE_TYPE_CLOSE_CONFIRM_DIALOG, EaseCloseConfirmDialogClass))
#define EASE_IS_CLOSE_CONFIRM_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EASE_TYPE_CLOSE_CONFIRM_DIALOG))
#define EASE_IS_CLOSE_CONFIRM_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EASE_TYPE_CLOSE_CONFIRM_DIALOG))
#define EASE_CLOSE_CONFIRM_DIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EASE_TYPE_CLOSE_CONFIRM_DIALOG, EaseCloseConfirmDialogClass))

typedef struct _EaseCloseConfirmDialog EaseCloseConfirmDialog;
typedef struct _EaseCloseConfirmDialogClass EaseCloseConfirmDialogClass;
typedef struct _EaseCloseConfirmDialogPrivate EaseCloseConfirmDialogPrivate;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))
#define _g_free0(var) (var = (g_free (var), NULL))

struct _EaseCloseConfirmDialog {
	GtkDialog parent_instance;
	EaseCloseConfirmDialogPrivate * priv;
	gint elapsed_seconds;
};

struct _EaseCloseConfirmDialogClass {
	GtkDialogClass parent_class;
};

struct _EaseCloseConfirmDialogPrivate {
	ClutterTimeline* counter;
	GtkLabel* bottom_label;
};


static gpointer ease_close_confirm_dialog_parent_class = NULL;

GType ease_close_confirm_dialog_get_type (void) G_GNUC_CONST;
#define EASE_CLOSE_CONFIRM_DIALOG_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), EASE_TYPE_CLOSE_CONFIRM_DIALOG, EaseCloseConfirmDialogPrivate))
enum  {
	EASE_CLOSE_CONFIRM_DIALOG_DUMMY_PROPERTY
};
#define EASE_CLOSE_CONFIRM_DIALOG_TOP_FORMAT "<b><big>%s</big></b>"
#define EASE_CLOSE_CONFIRM_DIALOG_TICK ((guint) 1000)
EaseCloseConfirmDialog* ease_close_confirm_dialog_new (const char* filename, gint seconds);
EaseCloseConfirmDialog* ease_close_confirm_dialog_construct (GType object_type, const char* filename, gint seconds);
static char* ease_close_confirm_dialog_top_label_text (const char* filename);
static char* ease_close_confirm_dialog_bottom_label_text (gint seconds);
static void ease_close_confirm_dialog_increment (EaseCloseConfirmDialog* self, ClutterTimeline* sender);
static void _ease_close_confirm_dialog_increment_clutter_timeline_completed (ClutterTimeline* _sender, gpointer self);
static void ease_close_confirm_dialog_real_destroy (GtkObject* base);
static void ease_close_confirm_dialog_finalize (GObject* obj);



/**
 * Creates a CloseConfirmDialog.
 *
 * @param filename The filename (with no extra path components) of the
 * document.
 * @param seconds The number of seconds since the document was last saved
 * (or was created, if it has not been saved).
 */
#line 118 "ease-close-confirm-dialog.vala"
static void _ease_close_confirm_dialog_increment_clutter_timeline_completed (ClutterTimeline* _sender, gpointer self) {
#line 92 "ease-close-confirm-dialog.c"
	ease_close_confirm_dialog_increment (self, _sender);
}


#line 56 "ease-close-confirm-dialog.vala"
EaseCloseConfirmDialog* ease_close_confirm_dialog_construct (GType object_type, const char* filename, gint seconds) {
#line 99 "ease-close-confirm-dialog.c"
	EaseCloseConfirmDialog * self;
	GtkImage* image;
	GtkLabel* top_label;
	char* _tmp0_;
	char* _tmp1_;
	char* _tmp2_;
	GtkLabel* _tmp3_;
	GtkVBox* vbox;
	GtkHBox* hbox;
	GtkWidget* _tmp4_;
	ClutterTimeline* _tmp5_;
#line 56 "ease-close-confirm-dialog.vala"
	g_return_val_if_fail (filename != NULL, NULL);
#line 113 "ease-close-confirm-dialog.c"
	self = g_object_newv (object_type, 0, NULL);
#line 58 "ease-close-confirm-dialog.vala"
	gtk_window_set_title ((GtkWindow*) self, _ ("Save before closing?"));
#line 59 "ease-close-confirm-dialog.vala"
	gtk_dialog_set_has_separator ((GtkDialog*) self, FALSE);
#line 60 "ease-close-confirm-dialog.vala"
	self->elapsed_seconds = seconds;
#line 63 "ease-close-confirm-dialog.vala"
	image = g_object_ref_sink ((GtkImage*) gtk_image_new_from_stock ("gtk-dialog-warning", GTK_ICON_SIZE_DIALOG));
#line 65 "ease-close-confirm-dialog.vala"
	gtk_misc_set_alignment ((GtkMisc*) image, 0.5f, (float) 0);
#line 68 "ease-close-confirm-dialog.vala"
	top_label = g_object_ref_sink ((GtkLabel*) gtk_label_new (""));
#line 69 "ease-close-confirm-dialog.vala"
	g_object_set (top_label, "wrap", TRUE, NULL);
#line 70 "ease-close-confirm-dialog.vala"
	gtk_label_set_use_markup (top_label, TRUE);
#line 71 "ease-close-confirm-dialog.vala"
	gtk_misc_set_alignment ((GtkMisc*) top_label, (float) 0, 0.5f);
#line 72 "ease-close-confirm-dialog.vala"
	gtk_label_set_selectable (top_label, TRUE);
#line 73 "ease-close-confirm-dialog.vala"
	g_object_set ((GtkWidget*) top_label, "can-focus", FALSE, NULL);
#line 74 "ease-close-confirm-dialog.vala"
	gtk_label_set_markup (top_label, _tmp1_ = g_strdup_printf (EASE_CLOSE_CONFIRM_DIALOG_TOP_FORMAT, _tmp0_ = ease_close_confirm_dialog_top_label_text (filename)));
#line 139 "ease-close-confirm-dialog.c"
	_g_free0 (_tmp1_);
	_g_free0 (_tmp0_);
#line 77 "ease-close-confirm-dialog.vala"
	self->priv->bottom_label = (_tmp3_ = g_object_ref_sink ((GtkLabel*) gtk_label_new (_tmp2_ = ease_close_confirm_dialog_bottom_label_text (seconds))), _g_object_unref0 (self->priv->bottom_label), _tmp3_);
#line 144 "ease-close-confirm-dialog.c"
	_g_free0 (_tmp2_);
#line 78 "ease-close-confirm-dialog.vala"
	g_object_set (self->priv->bottom_label, "wrap", TRUE, NULL);
#line 79 "ease-close-confirm-dialog.vala"
	gtk_misc_set_alignment ((GtkMisc*) self->priv->bottom_label, (float) 0, 0.5f);
#line 80 "ease-close-confirm-dialog.vala"
	gtk_label_set_selectable (self->priv->bottom_label, TRUE);
#line 81 "ease-close-confirm-dialog.vala"
	g_object_set ((GtkWidget*) self->priv->bottom_label, "can-focus", FALSE, NULL);
#line 84 "ease-close-confirm-dialog.vala"
	vbox = g_object_ref_sink ((GtkVBox*) gtk_vbox_new (FALSE, 12));
#line 85 "ease-close-confirm-dialog.vala"
	gtk_box_pack_start ((GtkBox*) vbox, (GtkWidget*) top_label, FALSE, FALSE, (guint) 0);
#line 86 "ease-close-confirm-dialog.vala"
	gtk_box_pack_start ((GtkBox*) vbox, (GtkWidget*) self->priv->bottom_label, FALSE, FALSE, (guint) 0);
#line 89 "ease-close-confirm-dialog.vala"
	hbox = g_object_ref_sink ((GtkHBox*) gtk_hbox_new (FALSE, 12));
#line 90 "ease-close-confirm-dialog.vala"
	gtk_container_set_border_width ((GtkContainer*) hbox, (guint) 5);
#line 91 "ease-close-confirm-dialog.vala"
	gtk_box_pack_start ((GtkBox*) hbox, (GtkWidget*) image, FALSE, FALSE, (guint) 0);
#line 92 "ease-close-confirm-dialog.vala"
	gtk_box_pack_start ((GtkBox*) hbox, (GtkWidget*) vbox, TRUE, TRUE, (guint) 0);
#line 94 "ease-close-confirm-dialog.vala"
	gtk_box_pack_start ((_tmp4_ = gtk_dialog_get_content_area ((GtkDialog*) self), GTK_IS_BOX (_tmp4_) ? ((GtkBox*) _tmp4_) : NULL), (GtkWidget*) hbox, TRUE, TRUE, (guint) 0);
#line 95 "ease-close-confirm-dialog.vala"
	gtk_widget_show_all ((GtkWidget*) hbox);
#line 98 "ease-close-confirm-dialog.vala"
	gtk_dialog_add_buttons ((GtkDialog*) self, _ ("Close _without Saving"), GTK_RESPONSE_NO, "gtk-cancel", GTK_RESPONSE_CANCEL, "gtk-save", GTK_RESPONSE_YES, NULL);
#line 103 "ease-close-confirm-dialog.vala"
	gtk_dialog_set_default_response ((GtkDialog*) self, (gint) GTK_RESPONSE_YES);
#line 106 "ease-close-confirm-dialog.vala"
	self->priv->counter = (_tmp5_ = clutter_timeline_new (EASE_CLOSE_CONFIRM_DIALOG_TICK), _g_object_unref0 (self->priv->counter), _tmp5_);
#line 107 "ease-close-confirm-dialog.vala"
	clutter_timeline_set_loop (self->priv->counter, TRUE);
#line 108 "ease-close-confirm-dialog.vala"
	g_signal_connect_object (self->priv->counter, "completed", (GCallback) _ease_close_confirm_dialog_increment_clutter_timeline_completed, self, 0);
#line 109 "ease-close-confirm-dialog.vala"
	clutter_timeline_start (self->priv->counter);
#line 184 "ease-close-confirm-dialog.c"
	_g_object_unref0 (hbox);
	_g_object_unref0 (vbox);
	_g_object_unref0 (top_label);
	_g_object_unref0 (image);
	return self;
}


#line 56 "ease-close-confirm-dialog.vala"
EaseCloseConfirmDialog* ease_close_confirm_dialog_new (const char* filename, gint seconds) {
#line 56 "ease-close-confirm-dialog.vala"
	return ease_close_confirm_dialog_construct (EASE_TYPE_CLOSE_CONFIRM_DIALOG, filename, seconds);
#line 197 "ease-close-confirm-dialog.c"
}


#line 112 "ease-close-confirm-dialog.vala"
static void ease_close_confirm_dialog_real_destroy (GtkObject* base) {
#line 203 "ease-close-confirm-dialog.c"
	EaseCloseConfirmDialog * self;
	self = (EaseCloseConfirmDialog*) base;
#line 114 "ease-close-confirm-dialog.vala"
	clutter_timeline_stop (self->priv->counter);
#line 115 "ease-close-confirm-dialog.vala"
	GTK_OBJECT_CLASS (ease_close_confirm_dialog_parent_class)->destroy ((GtkObject*) GTK_DIALOG (self));
#line 210 "ease-close-confirm-dialog.c"
}


#line 118 "ease-close-confirm-dialog.vala"
static void ease_close_confirm_dialog_increment (EaseCloseConfirmDialog* self, ClutterTimeline* sender) {
#line 216 "ease-close-confirm-dialog.c"
	char* _tmp0_;
#line 118 "ease-close-confirm-dialog.vala"
	g_return_if_fail (self != NULL);
#line 118 "ease-close-confirm-dialog.vala"
	g_return_if_fail (sender != NULL);
#line 120 "ease-close-confirm-dialog.vala"
	gtk_label_set_text (self->priv->bottom_label, _tmp0_ = ease_close_confirm_dialog_bottom_label_text (self->elapsed_seconds = self->elapsed_seconds + 1));
#line 224 "ease-close-confirm-dialog.c"
	_g_free0 (_tmp0_);
}


/**
 * Returns text for the bottom label.
 *
 * @param seconds The number of seconds since the document was last saved
 * (or was created, if it has not been saved).
 */
#line 129 "ease-close-confirm-dialog.vala"
static char* ease_close_confirm_dialog_bottom_label_text (gint seconds) {
#line 237 "ease-close-confirm-dialog.c"
	char* result = NULL;
	gint hours;
#line 131 "ease-close-confirm-dialog.vala"
	seconds = MAX (1, seconds);
#line 133 "ease-close-confirm-dialog.vala"
	if (seconds < 55) {
#line 244 "ease-close-confirm-dialog.c"
		result = g_strdup_printf (ngettext ("If you don't save, changes from the last second will be permanently lo" \
"st.", "If you don't save, changes from the last %i seconds will be permanentl" \
"y lost.", (gulong) seconds), seconds);
#line 135 "ease-close-confirm-dialog.vala"
		return result;
#line 248 "ease-close-confirm-dialog.c"
	}
#line 137 "ease-close-confirm-dialog.vala"
	if (seconds < 75) {
#line 252 "ease-close-confirm-dialog.c"
		result = g_strdup (_ ("If you don't save, changes from the last minute will be permanently lo" \
"st."));
#line 139 "ease-close-confirm-dialog.vala"
		return result;
#line 256 "ease-close-confirm-dialog.c"
	}
#line 141 "ease-close-confirm-dialog.vala"
	if (seconds < 110) {
#line 260 "ease-close-confirm-dialog.c"
		result = g_strdup_printf (ngettext ("If you don't save, changes from the last minute and %i second will be " \
"permanently lost.", "If you don't save, changes from the last minute and %i seconds will be" \
" permanently lost.", (gulong) (seconds - 60)), seconds - 60);
#line 143 "ease-close-confirm-dialog.vala"
		return result;
#line 264 "ease-close-confirm-dialog.c"
	}
#line 145 "ease-close-confirm-dialog.vala"
	if (seconds < 3600) {
#line 268 "ease-close-confirm-dialog.c"
		result = g_strdup_printf (ngettext ("If you don't save, changes from the last %i minute will be permanently" \
" lost.", "If you don't save, changes from the last %i minutes will be permanentl" \
"y lost.", (gulong) (seconds / 60)), seconds / 60);
#line 147 "ease-close-confirm-dialog.vala"
		return result;
#line 272 "ease-close-confirm-dialog.c"
	}
#line 149 "ease-close-confirm-dialog.vala"
	if (seconds < 7200) {
#line 276 "ease-close-confirm-dialog.c"
		gint minutes;
#line 151 "ease-close-confirm-dialog.vala"
		minutes = (seconds - 3600) / 60;
#line 152 "ease-close-confirm-dialog.vala"
		if (minutes < 5) {
#line 282 "ease-close-confirm-dialog.c"
			result = g_strdup (_ ("If you don't save, changes from the last hour will be permanently lost" \
"."));
#line 154 "ease-close-confirm-dialog.vala"
			return result;
#line 286 "ease-close-confirm-dialog.c"
		}
		result = g_strdup_printf (ngettext ("If you don't save, changes from the last hour and %i minute will be pe" \
"rmanently lost.", "If you don't save, changes from the last hour and %i minutes will be p" \
"ermanently lost.", (gulong) minutes), minutes);
#line 156 "ease-close-confirm-dialog.vala"
		return result;
#line 291 "ease-close-confirm-dialog.c"
	}
#line 159 "ease-close-confirm-dialog.vala"
	hours = seconds / 3600;
#line 295 "ease-close-confirm-dialog.c"
	result = g_strdup_printf (ngettext ("If you don't save, changes from the last %i hour will be permanently l" \
"ost.", "If you don't save, changes from the last %i hours will be permanently " \
"lost.", (gulong) hours), hours);
#line 160 "ease-close-confirm-dialog.vala"
	return result;
#line 299 "ease-close-confirm-dialog.c"
}


/**
 * Returns text for the top label
 *
 * @param filename The filename (with no extra path components) of the
 * document.
 */
#line 169 "ease-close-confirm-dialog.vala"
static char* ease_close_confirm_dialog_top_label_text (const char* filename) {
#line 311 "ease-close-confirm-dialog.c"
	char* result = NULL;
#line 169 "ease-close-confirm-dialog.vala"
	g_return_val_if_fail (filename != NULL, NULL);
#line 315 "ease-close-confirm-dialog.c"
	result = g_strdup_printf (_ ("Save changes to \"%s\" before closing?"), filename);
#line 171 "ease-close-confirm-dialog.vala"
	return result;
#line 319 "ease-close-confirm-dialog.c"
}


static void ease_close_confirm_dialog_class_init (EaseCloseConfirmDialogClass * klass) {
	ease_close_confirm_dialog_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (EaseCloseConfirmDialogPrivate));
	GTK_OBJECT_CLASS (klass)->destroy = ease_close_confirm_dialog_real_destroy;
	G_OBJECT_CLASS (klass)->finalize = ease_close_confirm_dialog_finalize;
}


static void ease_close_confirm_dialog_instance_init (EaseCloseConfirmDialog * self) {
	self->priv = EASE_CLOSE_CONFIRM_DIALOG_GET_PRIVATE (self);
}


static void ease_close_confirm_dialog_finalize (GObject* obj) {
	EaseCloseConfirmDialog * self;
	self = EASE_CLOSE_CONFIRM_DIALOG (obj);
	_g_object_unref0 (self->priv->counter);
	_g_object_unref0 (self->priv->bottom_label);
	G_OBJECT_CLASS (ease_close_confirm_dialog_parent_class)->finalize (obj);
}


/**
 * A "do you save before closing" dialog.
 */
GType ease_close_confirm_dialog_get_type (void) {
	static volatile gsize ease_close_confirm_dialog_type_id__volatile = 0;
	if (g_once_init_enter (&ease_close_confirm_dialog_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (EaseCloseConfirmDialogClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) ease_close_confirm_dialog_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (EaseCloseConfirmDialog), 0, (GInstanceInitFunc) ease_close_confirm_dialog_instance_init, NULL };
		GType ease_close_confirm_dialog_type_id;
		ease_close_confirm_dialog_type_id = g_type_register_static (GTK_TYPE_DIALOG, "EaseCloseConfirmDialog", &g_define_type_info, 0);
		g_once_init_leave (&ease_close_confirm_dialog_type_id__volatile, ease_close_confirm_dialog_type_id);
	}
	return ease_close_confirm_dialog_type_id__volatile;
}




