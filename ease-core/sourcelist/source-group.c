/* source-group.c generated by valac 0.10.0, the Vala compiler
 * generated from source-group.vala, do not modify */

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
#include <stdlib.h>
#include <string.h>


#define SOURCE_TYPE_BASE_GROUP (source_base_group_get_type ())
#define SOURCE_BASE_GROUP(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), SOURCE_TYPE_BASE_GROUP, SourceBaseGroup))
#define SOURCE_BASE_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), SOURCE_TYPE_BASE_GROUP, SourceBaseGroupClass))
#define SOURCE_IS_BASE_GROUP(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), SOURCE_TYPE_BASE_GROUP))
#define SOURCE_IS_BASE_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), SOURCE_TYPE_BASE_GROUP))
#define SOURCE_BASE_GROUP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), SOURCE_TYPE_BASE_GROUP, SourceBaseGroupClass))

typedef struct _SourceBaseGroup SourceBaseGroup;
typedef struct _SourceBaseGroupClass SourceBaseGroupClass;
typedef struct _SourceBaseGroupPrivate SourceBaseGroupPrivate;

#define SOURCE_TYPE_GROUP (source_group_get_type ())
#define SOURCE_GROUP(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), SOURCE_TYPE_GROUP, SourceGroup))
#define SOURCE_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), SOURCE_TYPE_GROUP, SourceGroupClass))
#define SOURCE_IS_GROUP(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), SOURCE_TYPE_GROUP))
#define SOURCE_IS_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), SOURCE_TYPE_GROUP))
#define SOURCE_GROUP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), SOURCE_TYPE_GROUP, SourceGroupClass))

typedef struct _SourceGroup SourceGroup;
typedef struct _SourceGroupClass SourceGroupClass;
typedef struct _SourceGroupPrivate SourceGroupPrivate;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))

struct _SourceBaseGroup {
	GtkAlignment parent_instance;
	SourceBaseGroupPrivate * priv;
	GtkAlignment* header_align;
	GtkAlignment* items_align;
};

struct _SourceBaseGroupClass {
	GtkAlignmentClass parent_class;
};

struct _SourceGroup {
	SourceBaseGroup parent_instance;
	SourceGroupPrivate * priv;
};

struct _SourceGroupClass {
	SourceBaseGroupClass parent_class;
};

struct _SourceGroupPrivate {
	GtkVBox* all_box;
};


static gpointer source_group_parent_class = NULL;

GType source_base_group_get_type (void) G_GNUC_CONST;
GType source_group_get_type (void) G_GNUC_CONST;
#define SOURCE_GROUP_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), SOURCE_TYPE_GROUP, SourceGroupPrivate))
enum  {
	SOURCE_GROUP_DUMMY_PROPERTY
};
SourceGroup* source_group_new (const char* title);
SourceGroup* source_group_construct (GType object_type, const char* title);
SourceBaseGroup* source_base_group_construct (GType object_type, const char* title);
static void source_group_finalize (GObject* obj);



/**
 * Create a new, empty, Source.Group.
 *
 * @param title The header of the Source.Group.
 */
#line 35 "source-group.vala"
SourceGroup* source_group_construct (GType object_type, const char* title) {
#line 98 "source-group.c"
	SourceGroup * self;
	GtkVBox* _tmp0_;
#line 35 "source-group.vala"
	g_return_val_if_fail (title != NULL, NULL);
#line 37 "source-group.vala"
	self = (SourceGroup*) source_base_group_construct (object_type, title);
#line 39 "source-group.vala"
	self->priv->all_box = (_tmp0_ = g_object_ref_sink ((GtkVBox*) gtk_vbox_new (FALSE, 0)), _g_object_unref0 (self->priv->all_box), _tmp0_);
#line 40 "source-group.vala"
	gtk_box_pack_start ((GtkBox*) self->priv->all_box, (GtkWidget*) ((SourceBaseGroup*) self)->header_align, FALSE, FALSE, (guint) 0);
#line 41 "source-group.vala"
	gtk_box_pack_start ((GtkBox*) self->priv->all_box, (GtkWidget*) ((SourceBaseGroup*) self)->items_align, FALSE, FALSE, (guint) 0);
#line 42 "source-group.vala"
	gtk_container_add ((GtkContainer*) self, (GtkWidget*) self->priv->all_box);
#line 113 "source-group.c"
	return self;
}


#line 35 "source-group.vala"
SourceGroup* source_group_new (const char* title) {
#line 35 "source-group.vala"
	return source_group_construct (SOURCE_TYPE_GROUP, title);
#line 122 "source-group.c"
}


static void source_group_class_init (SourceGroupClass * klass) {
	source_group_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (SourceGroupPrivate));
	G_OBJECT_CLASS (klass)->finalize = source_group_finalize;
}


static void source_group_instance_init (SourceGroup * self) {
	self->priv = SOURCE_GROUP_GET_PRIVATE (self);
}


static void source_group_finalize (GObject* obj) {
	SourceGroup * self;
	self = SOURCE_GROUP (obj);
	_g_object_unref0 (self->priv->all_box);
	G_OBJECT_CLASS (source_group_parent_class)->finalize (obj);
}


/**
 * A group in a {@link Source.List}.
 *
 * Source.Group can contain any amount of {@link Source.Item}s. Above these items,
 * a header is shown in order to categorize a {@link Source.List}.
 */
GType source_group_get_type (void) {
	static volatile gsize source_group_type_id__volatile = 0;
	if (g_once_init_enter (&source_group_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (SourceGroupClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) source_group_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (SourceGroup), 0, (GInstanceInitFunc) source_group_instance_init, NULL };
		GType source_group_type_id;
		source_group_type_id = g_type_register_static (SOURCE_TYPE_BASE_GROUP, "SourceGroup", &g_define_type_info, 0);
		g_once_init_leave (&source_group_type_id__volatile, source_group_type_id);
	}
	return source_group_type_id__volatile;
}




