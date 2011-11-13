/* source-list.c generated by valac 0.10.0, the Vala compiler
 * generated from source-list.vala, do not modify */

/*
 * Copyright (c) 2010, Nate Stedman <natesm@gmail.com>
 * 
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

#include <glib.h>
#include <glib-object.h>
#include <gtk/gtk.h>
#include <float.h>
#include <math.h>


#define SOURCE_TYPE_LIST (source_list_get_type ())
#define SOURCE_LIST(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), SOURCE_TYPE_LIST, SourceList))
#define SOURCE_LIST_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), SOURCE_TYPE_LIST, SourceListClass))
#define SOURCE_IS_LIST(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), SOURCE_TYPE_LIST))
#define SOURCE_IS_LIST_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), SOURCE_TYPE_LIST))
#define SOURCE_LIST_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), SOURCE_TYPE_LIST, SourceListClass))

typedef struct _SourceList SourceList;
typedef struct _SourceListClass SourceListClass;
typedef struct _SourceListPrivate SourceListPrivate;

#define SOURCE_TYPE_ITEM (source_item_get_type ())
#define SOURCE_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), SOURCE_TYPE_ITEM, SourceItem))
#define SOURCE_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), SOURCE_TYPE_ITEM, SourceItemClass))
#define SOURCE_IS_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), SOURCE_TYPE_ITEM))
#define SOURCE_IS_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), SOURCE_TYPE_ITEM))
#define SOURCE_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), SOURCE_TYPE_ITEM, SourceItemClass))

typedef struct _SourceItem SourceItem;
typedef struct _SourceItemClass SourceItemClass;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))

#define SOURCE_TYPE_BASE_GROUP (source_base_group_get_type ())
#define SOURCE_BASE_GROUP(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), SOURCE_TYPE_BASE_GROUP, SourceBaseGroup))
#define SOURCE_BASE_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), SOURCE_TYPE_BASE_GROUP, SourceBaseGroupClass))
#define SOURCE_IS_BASE_GROUP(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), SOURCE_TYPE_BASE_GROUP))
#define SOURCE_IS_BASE_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), SOURCE_TYPE_BASE_GROUP))
#define SOURCE_BASE_GROUP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), SOURCE_TYPE_BASE_GROUP, SourceBaseGroupClass))

typedef struct _SourceBaseGroup SourceBaseGroup;
typedef struct _SourceBaseGroupClass SourceBaseGroupClass;
typedef struct _SourceItemPrivate SourceItemPrivate;

struct _SourceList {
	GtkAlignment parent_instance;
	SourceListPrivate * priv;
};

struct _SourceListClass {
	GtkAlignmentClass parent_class;
};

struct _SourceListPrivate {
	GtkScrolledWindow* scroll;
	GtkVBox* box;
	GtkBin* bin;
	SourceItem* selected;
};

struct _SourceItem {
	GtkHBox parent_instance;
	SourceItemPrivate * priv;
	GtkAlignment* right_align;
	GtkWidget* widget;
};

struct _SourceItemClass {
	GtkHBoxClass parent_class;
};


static gpointer source_list_parent_class = NULL;

GType source_list_get_type (void) G_GNUC_CONST;
GType source_item_get_type (void) G_GNUC_CONST;
#define SOURCE_LIST_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), SOURCE_TYPE_LIST, SourceListPrivate))
enum  {
	SOURCE_LIST_DUMMY_PROPERTY
};
#define SOURCE_LIST_SHADOW GTK_SHADOW_NONE
#define SOURCE_LIST_H_POLICY GTK_POLICY_NEVER
#define SOURCE_LIST_V_POLICY GTK_POLICY_AUTOMATIC
#define SOURCE_LIST_PADDING 5
#define SOURCE_LIST_GROUP_PADDING 5
SourceList* source_list_new (GtkBin* linked_bin);
SourceList* source_list_construct (GType object_type, GtkBin* linked_bin);
GType source_base_group_get_type (void) G_GNUC_CONST;
void source_list_add_group (SourceList* self, SourceBaseGroup* group);
static void _lambda79_ (SourceItem* sender, SourceList* self);
void source_item_set_selected (SourceItem* self, gboolean value);
static void __lambda79__source_base_group_clicked (SourceBaseGroup* _sender, SourceItem* sender, gpointer self);
static void source_list_finalize (GObject* obj);



/**
 * Creates a Source.List and links it to a Gtk.Bin
 *
 * @param linked_bin The Gtk.Bin to link this Source.View with.
 */
static gpointer _g_object_ref0 (gpointer self) {
	return self ? g_object_ref (self) : NULL;
}


#line 86 "source-list.vala"
SourceList* source_list_construct (GType object_type, GtkBin* linked_bin) {
#line 125 "source-list.c"
	SourceList * self;
	GtkScrolledWindow* _tmp0_;
	GtkVBox* _tmp1_;
	GtkViewport* viewport;
	GtkBin* _tmp2_;
#line 86 "source-list.vala"
	g_return_val_if_fail (linked_bin != NULL, NULL);
#line 133 "source-list.c"
	self = g_object_newv (object_type, 0, NULL);
#line 89 "source-list.vala"
	self->priv->scroll = (_tmp0_ = g_object_ref_sink ((GtkScrolledWindow*) gtk_scrolled_window_new (NULL, NULL)), _g_object_unref0 (self->priv->scroll), _tmp0_);
#line 90 "source-list.vala"
	self->priv->box = (_tmp1_ = g_object_ref_sink ((GtkVBox*) gtk_vbox_new (FALSE, SOURCE_LIST_GROUP_PADDING)), _g_object_unref0 (self->priv->box), _tmp1_);
#line 91 "source-list.vala"
	viewport = g_object_ref_sink ((GtkViewport*) gtk_viewport_new (NULL, NULL));
#line 94 "source-list.vala"
	self->priv->bin = (_tmp2_ = _g_object_ref0 (linked_bin), _g_object_unref0 (self->priv->bin), _tmp2_);
#line 95 "source-list.vala"
	gtk_scrolled_window_set_shadow_type (self->priv->scroll, SOURCE_LIST_SHADOW);
#line 96 "source-list.vala"
	gtk_viewport_set_shadow_type (viewport, SOURCE_LIST_SHADOW);
#line 97 "source-list.vala"
	g_object_set (self->priv->scroll, "hscrollbar-policy", SOURCE_LIST_H_POLICY, NULL);
#line 98 "source-list.vala"
	g_object_set (self->priv->scroll, "vscrollbar-policy", SOURCE_LIST_V_POLICY, NULL);
#line 99 "source-list.vala"
	gtk_alignment_set ((GtkAlignment*) self, (float) 0, (float) 0, (float) 1, (float) 1);
#line 100 "source-list.vala"
	gtk_alignment_set_padding ((GtkAlignment*) self, (guint) SOURCE_LIST_PADDING, (guint) SOURCE_LIST_PADDING, (guint) SOURCE_LIST_PADDING, (guint) SOURCE_LIST_PADDING);
#line 103 "source-list.vala"
	gtk_container_add ((GtkContainer*) viewport, (GtkWidget*) self->priv->box);
#line 104 "source-list.vala"
	gtk_container_add ((GtkContainer*) self->priv->scroll, (GtkWidget*) viewport);
#line 105 "source-list.vala"
	gtk_container_add ((GtkContainer*) self, (GtkWidget*) self->priv->scroll);
#line 161 "source-list.c"
	_g_object_unref0 (viewport);
	return self;
}


#line 86 "source-list.vala"
SourceList* source_list_new (GtkBin* linked_bin) {
#line 86 "source-list.vala"
	return source_list_construct (SOURCE_TYPE_LIST, linked_bin);
#line 171 "source-list.c"
}


/**
 * Adds a group to the {@link Source.List}, automatically setting up click
 * signals.
 *
 * @param group The group to add.
 */
#line 118 "source-list.vala"
static void _lambda79_ (SourceItem* sender, SourceList* self) {
#line 183 "source-list.c"
	gboolean _tmp0_ = FALSE;
	SourceItem* _tmp1_;
#line 118 "source-list.vala"
	g_return_if_fail (sender != NULL);
#line 120 "source-list.vala"
	if (self->priv->selected != NULL) {
#line 120 "source-list.vala"
		_tmp0_ = self->priv->selected != sender;
#line 192 "source-list.c"
	} else {
#line 120 "source-list.vala"
		_tmp0_ = FALSE;
#line 196 "source-list.c"
	}
#line 120 "source-list.vala"
	if (_tmp0_) {
#line 122 "source-list.vala"
		source_item_set_selected (self->priv->selected, FALSE);
#line 202 "source-list.c"
	}
#line 125 "source-list.vala"
	if (sender->widget != NULL) {
#line 206 "source-list.c"
		GtkWidget* child;
#line 128 "source-list.vala"
		child = _g_object_ref0 (gtk_bin_get_child (self->priv->bin));
#line 129 "source-list.vala"
		if (child != NULL) {
#line 131 "source-list.vala"
			gtk_container_remove ((GtkContainer*) self->priv->bin, child);
#line 214 "source-list.c"
		}
#line 135 "source-list.vala"
		gtk_container_add ((GtkContainer*) self->priv->bin, sender->widget);
#line 136 "source-list.vala"
		gtk_widget_show ((GtkWidget*) self->priv->bin);
#line 137 "source-list.vala"
		gtk_widget_show (sender->widget);
#line 222 "source-list.c"
		_g_object_unref0 (child);
	}
#line 141 "source-list.vala"
	source_item_set_selected (sender, TRUE);
#line 142 "source-list.vala"
	self->priv->selected = (_tmp1_ = _g_object_ref0 (sender), _g_object_unref0 (self->priv->selected), _tmp1_);
#line 145 "source-list.vala"
	g_signal_emit_by_name (self, "clicked", sender);
#line 231 "source-list.c"
}


#line 118 "source-list.vala"
static void __lambda79__source_base_group_clicked (SourceBaseGroup* _sender, SourceItem* sender, gpointer self) {
#line 237 "source-list.c"
	_lambda79_ (sender, self);
}


#line 114 "source-list.vala"
void source_list_add_group (SourceList* self, SourceBaseGroup* group) {
#line 114 "source-list.vala"
	g_return_if_fail (self != NULL);
#line 114 "source-list.vala"
	g_return_if_fail (group != NULL);
#line 116 "source-list.vala"
	gtk_box_pack_start ((GtkBox*) self->priv->box, (GtkWidget*) group, FALSE, FALSE, (guint) 0);
#line 118 "source-list.vala"
	g_signal_connect_object (group, "clicked", (GCallback) __lambda79__source_base_group_clicked, self, 0);
#line 252 "source-list.c"
}


static void source_list_class_init (SourceListClass * klass) {
	source_list_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (SourceListPrivate));
	G_OBJECT_CLASS (klass)->finalize = source_list_finalize;
	/**
	 * Emitted when a {@link Source.Item} in this Source.List is clicked.
	 *
	 * @param sender The Source.Item that was clicked.
	 */
	g_signal_new ("clicked", SOURCE_TYPE_LIST, G_SIGNAL_RUN_LAST, 0, NULL, NULL, g_cclosure_marshal_VOID__OBJECT, G_TYPE_NONE, 1, SOURCE_TYPE_ITEM);
}


static void source_list_instance_init (SourceList * self) {
	self->priv = SOURCE_LIST_GET_PRIVATE (self);
}


static void source_list_finalize (GObject* obj) {
	SourceList * self;
	self = SOURCE_LIST (obj);
	_g_object_unref0 (self->priv->scroll);
	_g_object_unref0 (self->priv->box);
	_g_object_unref0 (self->priv->bin);
	_g_object_unref0 (self->priv->selected);
	G_OBJECT_CLASS (source_list_parent_class)->finalize (obj);
}


/**
 * A widget for switching between multiple data sources.
 *
 * Source.List contains {@link Source.Group}s, which in turn contain
 * {@link Source.Item}s. Each Source.Item is linked to a Gtk.Widget, which
 * is displayed in the Source.List's linked Gtk.Bin when clicked.
 *
 * For a simple Source.List next to bin implementation, use {@link Source.View}.
 */
GType source_list_get_type (void) {
	static volatile gsize source_list_type_id__volatile = 0;
	if (g_once_init_enter (&source_list_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (SourceListClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) source_list_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (SourceList), 0, (GInstanceInitFunc) source_list_instance_init, NULL };
		GType source_list_type_id;
		source_list_type_id = g_type_register_static (GTK_TYPE_ALIGNMENT, "SourceList", &g_define_type_info, 0);
		g_once_init_leave (&source_list_type_id__volatile, source_list_type_id);
	}
	return source_list_type_id__volatile;
}



