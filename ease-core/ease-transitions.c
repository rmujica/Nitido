/* ease-transitions.c generated by valac 0.10.0, the Vala compiler
 * generated from ease-transitions.vala, do not modify */

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
#include <stdlib.h>
#include <string.h>
#include <glib/gi18n-lib.h>


#define EASE_TYPE_TRANSITION (ease_transition_get_type ())
#define _g_free0(var) (var = (g_free (var), NULL))
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))

#define EASE_TYPE_TRANSITION_VARIANT (ease_transition_variant_get_type ())

typedef enum  {
	EASE_TRANSITION_NONE,
	EASE_TRANSITION_FADE,
	EASE_TRANSITION_SLIDE,
	EASE_TRANSITION_DROP,
	EASE_TRANSITION_PIVOT,
	EASE_TRANSITION_FLIP,
	EASE_TRANSITION_REVOLVING_DOOR,
	EASE_TRANSITION_REVEAL,
	EASE_TRANSITION_FALL,
	EASE_TRANSITION_SLATS,
	EASE_TRANSITION_OPEN_DOOR,
	EASE_TRANSITION_EXPLODE,
	EASE_TRANSITION_ASSEMBLE,
	EASE_TRANSITION_ZOOM,
	EASE_TRANSITION_PANEL,
	EASE_TRANSITION_INTERSPERSE_CONTENTS,
	EASE_TRANSITION_SPIN_CONTENTS,
	EASE_TRANSITION_SPRING_CONTENTS,
	EASE_TRANSITION_SWING_CONTENTS,
	EASE_TRANSITION_SLIDE_CONTENTS,
	EASE_TRANSITION_ZOOM_CONTENTS
} EaseTransition;

typedef enum  {
	EASE_TRANSITION_VARIANT_LEFT,
	EASE_TRANSITION_VARIANT_RIGHT,
	EASE_TRANSITION_VARIANT_UP,
	EASE_TRANSITION_VARIANT_DOWN,
	EASE_TRANSITION_VARIANT_BOTTOM,
	EASE_TRANSITION_VARIANT_TOP,
	EASE_TRANSITION_VARIANT_CENTER,
	EASE_TRANSITION_VARIANT_TOP_LEFT,
	EASE_TRANSITION_VARIANT_TOP_RIGHT,
	EASE_TRANSITION_VARIANT_BOTTOM_LEFT,
	EASE_TRANSITION_VARIANT_BOTTOM_RIGHT,
	EASE_TRANSITION_VARIANT_TOP_TO_BOTTOM,
	EASE_TRANSITION_VARIANT_BOTTOM_TO_TOP,
	EASE_TRANSITION_VARIANT_LEFT_TO_RIGHT,
	EASE_TRANSITION_VARIANT_RIGHT_TO_LEFT,
	EASE_TRANSITION_VARIANT_IN,
	EASE_TRANSITION_VARIANT_OUT
} EaseTransitionVariant;



GtkListStore* ease_transition_model (void);
GType ease_transition_get_type (void) G_GNUC_CONST;
char* ease_transition_get_name (EaseTransition self);
GtkListStore* ease_transition_variant_model (EaseTransition self);
GType ease_transition_variant_get_type (void) G_GNUC_CONST;
EaseTransitionVariant* ease_transition_variants (EaseTransition self, int* result_length1);
char* ease_transition_variant_get_name (EaseTransitionVariant self);
EaseTransition ease_transition_from_string (const char* str);
EaseTransitionVariant ease_transition_variant_from_string (const char* str);

static const EaseTransition EASE_TRANSITION_TRANSITIONS[17] = {EASE_TRANSITION_NONE, EASE_TRANSITION_FADE, EASE_TRANSITION_SLIDE, EASE_TRANSITION_DROP, EASE_TRANSITION_PIVOT, EASE_TRANSITION_FLIP, EASE_TRANSITION_REVOLVING_DOOR, EASE_TRANSITION_REVEAL, EASE_TRANSITION_FALL, EASE_TRANSITION_OPEN_DOOR, EASE_TRANSITION_ZOOM, EASE_TRANSITION_PANEL, EASE_TRANSITION_SPIN_CONTENTS, EASE_TRANSITION_SPRING_CONTENTS, EASE_TRANSITION_SWING_CONTENTS, EASE_TRANSITION_SLIDE_CONTENTS, EASE_TRANSITION_ZOOM_CONTENTS};


#line 68 "ease-transitions.vala"
GtkListStore* ease_transition_model (void) {
#line 97 "ease-transitions.c"
	GtkListStore* result = NULL;
	GtkListStore* store;
	GtkTreeIter itr = {0};
#line 70 "ease-transitions.vala"
	store = gtk_list_store_new (2, G_TYPE_STRING, EASE_TYPE_TRANSITION);
#line 103 "ease-transitions.c"
	{
		gint i;
#line 72 "ease-transitions.vala"
		i = 0;
#line 108 "ease-transitions.c"
		{
			gboolean _tmp0_;
#line 72 "ease-transitions.vala"
			_tmp0_ = TRUE;
#line 72 "ease-transitions.vala"
			while (TRUE) {
#line 115 "ease-transitions.c"
				char* _tmp1_;
#line 72 "ease-transitions.vala"
				if (!_tmp0_) {
#line 72 "ease-transitions.vala"
					i++;
#line 121 "ease-transitions.c"
				}
#line 72 "ease-transitions.vala"
				_tmp0_ = FALSE;
#line 72 "ease-transitions.vala"
				if (!(i < G_N_ELEMENTS (EASE_TRANSITION_TRANSITIONS))) {
#line 72 "ease-transitions.vala"
					break;
#line 129 "ease-transitions.c"
				}
#line 74 "ease-transitions.vala"
				gtk_list_store_append (store, &itr);
#line 75 "ease-transitions.vala"
				gtk_list_store_set (store, &itr, 0, _tmp1_ = ease_transition_get_name (EASE_TRANSITION_TRANSITIONS[i]), 1, EASE_TRANSITION_TRANSITIONS[i], -1);
#line 135 "ease-transitions.c"
				_g_free0 (_tmp1_);
			}
		}
	}
	result = store;
#line 78 "ease-transitions.vala"
	return result;
#line 143 "ease-transitions.c"
}


#line 81 "ease-transitions.vala"
GtkListStore* ease_transition_variant_model (EaseTransition self) {
#line 149 "ease-transitions.c"
	GtkListStore* result = NULL;
	GtkListStore* store;
	GtkTreeIter itr = {0};
#line 83 "ease-transitions.vala"
	store = gtk_list_store_new (2, G_TYPE_STRING, EASE_TYPE_TRANSITION_VARIANT);
#line 155 "ease-transitions.c"
	{
		gint _tmp0_;
		EaseTransitionVariant* variant_collection;
		int variant_collection_length1;
		int variant_it;
#line 86 "ease-transitions.vala"
		variant_collection = ease_transition_variants (self, &_tmp0_);
#line 163 "ease-transitions.c"
		variant_collection_length1 = _tmp0_;
		for (variant_it = 0; variant_it < _tmp0_; variant_it = variant_it + 1) {
			EaseTransitionVariant variant;
			variant = variant_collection[variant_it];
			{
				char* _tmp1_;
#line 88 "ease-transitions.vala"
				gtk_list_store_append (store, &itr);
#line 89 "ease-transitions.vala"
				gtk_list_store_set (store, &itr, 0, _tmp1_ = ease_transition_variant_get_name (variant), 1, variant, -1);
#line 174 "ease-transitions.c"
				_g_free0 (_tmp1_);
			}
		}
#line 86 "ease-transitions.vala"
		variant_collection = (g_free (variant_collection), NULL);
#line 180 "ease-transitions.c"
	}
	result = store;
#line 92 "ease-transitions.vala"
	return result;
#line 185 "ease-transitions.c"
}


#line 95 "ease-transitions.vala"
EaseTransition ease_transition_from_string (const char* str) {
#line 191 "ease-transitions.c"
	EaseTransition result = 0;
	const char* _tmp0_;
	GQuark _tmp1_;
	static GQuark _tmp1__label0 = 0;
	static GQuark _tmp1__label1 = 0;
	static GQuark _tmp1__label2 = 0;
	static GQuark _tmp1__label3 = 0;
	static GQuark _tmp1__label4 = 0;
	static GQuark _tmp1__label5 = 0;
	static GQuark _tmp1__label6 = 0;
	static GQuark _tmp1__label7 = 0;
	static GQuark _tmp1__label8 = 0;
	static GQuark _tmp1__label9 = 0;
	static GQuark _tmp1__label10 = 0;
	static GQuark _tmp1__label11 = 0;
	static GQuark _tmp1__label12 = 0;
	static GQuark _tmp1__label13 = 0;
	static GQuark _tmp1__label14 = 0;
	static GQuark _tmp1__label15 = 0;
	static GQuark _tmp1__label16 = 0;
	static GQuark _tmp1__label17 = 0;
	static GQuark _tmp1__label18 = 0;
	static GQuark _tmp1__label19 = 0;
	static GQuark _tmp1__label20 = 0;
#line 95 "ease-transitions.vala"
	g_return_val_if_fail (str != NULL, 0);
#line 218 "ease-transitions.c"
	_tmp0_ = str;
	_tmp1_ = (NULL == _tmp0_) ? 0 : g_quark_from_string (_tmp0_);
	if (_tmp1_ == ((0 != _tmp1__label0) ? _tmp1__label0 : (_tmp1__label0 = g_quark_from_static_string ("EASE_TRANSITION_NONE"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_NONE;
#line 100 "ease-transitions.vala"
			return result;
#line 228 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label1) ? _tmp1__label1 : (_tmp1__label1 = g_quark_from_static_string ("EASE_TRANSITION_FADE"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_FADE;
#line 102 "ease-transitions.vala"
			return result;
#line 237 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label2) ? _tmp1__label2 : (_tmp1__label2 = g_quark_from_static_string ("EASE_TRANSITION_SLIDE"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_SLIDE;
#line 104 "ease-transitions.vala"
			return result;
#line 246 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label3) ? _tmp1__label3 : (_tmp1__label3 = g_quark_from_static_string ("EASE_TRANSITION_DROP"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_DROP;
#line 106 "ease-transitions.vala"
			return result;
#line 255 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label4) ? _tmp1__label4 : (_tmp1__label4 = g_quark_from_static_string ("EASE_TRANSITION_PIVOT"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_PIVOT;
#line 108 "ease-transitions.vala"
			return result;
#line 264 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label5) ? _tmp1__label5 : (_tmp1__label5 = g_quark_from_static_string ("EASE_TRANSITION_FLIP"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_FLIP;
#line 110 "ease-transitions.vala"
			return result;
#line 273 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label6) ? _tmp1__label6 : (_tmp1__label6 = g_quark_from_static_string ("EASE_TRANSITION_REVOLVING_DOOR"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_REVOLVING_DOOR;
#line 112 "ease-transitions.vala"
			return result;
#line 282 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label7) ? _tmp1__label7 : (_tmp1__label7 = g_quark_from_static_string ("EASE_TRANSITION_REVEAL"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_REVEAL;
#line 114 "ease-transitions.vala"
			return result;
#line 291 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label8) ? _tmp1__label8 : (_tmp1__label8 = g_quark_from_static_string ("EASE_TRANSITION_FALL"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_FALL;
#line 116 "ease-transitions.vala"
			return result;
#line 300 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label9) ? _tmp1__label9 : (_tmp1__label9 = g_quark_from_static_string ("EASE_TRANSITION_SLATS"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_SLATS;
#line 118 "ease-transitions.vala"
			return result;
#line 309 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label10) ? _tmp1__label10 : (_tmp1__label10 = g_quark_from_static_string ("EASE_TRANSITION_OPEN_DOOR"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_OPEN_DOOR;
#line 120 "ease-transitions.vala"
			return result;
#line 318 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label11) ? _tmp1__label11 : (_tmp1__label11 = g_quark_from_static_string ("EASE_TRANSITION_EXPLODE"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_EXPLODE;
#line 122 "ease-transitions.vala"
			return result;
#line 327 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label12) ? _tmp1__label12 : (_tmp1__label12 = g_quark_from_static_string ("EASE_TRANSITION_ASSEMBLE"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_ASSEMBLE;
#line 124 "ease-transitions.vala"
			return result;
#line 336 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label13) ? _tmp1__label13 : (_tmp1__label13 = g_quark_from_static_string ("EASE_TRANSITION_ZOOM"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_ZOOM;
#line 126 "ease-transitions.vala"
			return result;
#line 345 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label14) ? _tmp1__label14 : (_tmp1__label14 = g_quark_from_static_string ("EASE_TRANSITION_PANEL"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_PANEL;
#line 128 "ease-transitions.vala"
			return result;
#line 354 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label15) ? _tmp1__label15 : (_tmp1__label15 = g_quark_from_static_string ("EASE_TRANSITION_INTERSPERSE_CONTENTS"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_INTERSPERSE_CONTENTS;
#line 130 "ease-transitions.vala"
			return result;
#line 363 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label16) ? _tmp1__label16 : (_tmp1__label16 = g_quark_from_static_string ("EASE_TRANSITION_SPIN_CONTENTS"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_SPIN_CONTENTS;
#line 132 "ease-transitions.vala"
			return result;
#line 372 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label17) ? _tmp1__label17 : (_tmp1__label17 = g_quark_from_static_string ("EASE_TRANSITION_SPRING_CONTENTS"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_SPRING_CONTENTS;
#line 134 "ease-transitions.vala"
			return result;
#line 381 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label18) ? _tmp1__label18 : (_tmp1__label18 = g_quark_from_static_string ("EASE_TRANSITION_SWING_CONTENTS"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_SWING_CONTENTS;
#line 136 "ease-transitions.vala"
			return result;
#line 390 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label19) ? _tmp1__label19 : (_tmp1__label19 = g_quark_from_static_string ("EASE_TRANSITION_SLIDE_CONTENTS"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_SLIDE_CONTENTS;
#line 138 "ease-transitions.vala"
			return result;
#line 399 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label20) ? _tmp1__label20 : (_tmp1__label20 = g_quark_from_static_string ("EASE_TRANSITION_ZOOM_CONTENTS"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_ZOOM_CONTENTS;
#line 140 "ease-transitions.vala"
			return result;
#line 408 "ease-transitions.c"
		}
	} else
	switch (0) {
		default:
		{
#line 142 "ease-transitions.vala"
			g_critical ("ease-transitions.vala:142: Invalid transition string: %s", str);
#line 416 "ease-transitions.c"
			result = EASE_TRANSITION_NONE;
#line 143 "ease-transitions.vala"
			return result;
#line 420 "ease-transitions.c"
		}
	}
}


#line 147 "ease-transitions.vala"
EaseTransitionVariant* ease_transition_variants (EaseTransition self, int* result_length1) {
#line 428 "ease-transitions.c"
	EaseTransitionVariant* result = NULL;
#line 149 "ease-transitions.vala"
	switch (self) {
#line 432 "ease-transitions.c"
		case EASE_TRANSITION_NONE:
		case EASE_TRANSITION_FADE:
		case EASE_TRANSITION_DROP:
		case EASE_TRANSITION_FALL:
		case EASE_TRANSITION_SLATS:
		case EASE_TRANSITION_OPEN_DOOR:
		case EASE_TRANSITION_EXPLODE:
		case EASE_TRANSITION_ASSEMBLE:
		case EASE_TRANSITION_SWING_CONTENTS:
		case EASE_TRANSITION_INTERSPERSE_CONTENTS:
		{
			EaseTransitionVariant* _tmp0_ = NULL;
			EaseTransitionVariant* _tmp1_;
			result = (_tmp1_ = (_tmp0_ = g_new0 (EaseTransitionVariant, 0), _tmp0_), *result_length1 = 0, _tmp1_);
#line 161 "ease-transitions.vala"
			return result;
#line 449 "ease-transitions.c"
		}
		case EASE_TRANSITION_REVOLVING_DOOR:
		case EASE_TRANSITION_REVEAL:
		case EASE_TRANSITION_SLIDE:
		case EASE_TRANSITION_PANEL:
		case EASE_TRANSITION_SLIDE_CONTENTS:
		{
			EaseTransitionVariant* _tmp2_ = NULL;
			EaseTransitionVariant* _tmp3_;
			result = (_tmp3_ = (_tmp2_ = g_new0 (EaseTransitionVariant, 4), _tmp2_[0] = EASE_TRANSITION_VARIANT_LEFT, _tmp2_[1] = EASE_TRANSITION_VARIANT_RIGHT, _tmp2_[2] = EASE_TRANSITION_VARIANT_UP, _tmp2_[3] = EASE_TRANSITION_VARIANT_DOWN, _tmp2_), *result_length1 = 4, _tmp3_);
#line 168 "ease-transitions.vala"
			return result;
#line 462 "ease-transitions.c"
		}
		case EASE_TRANSITION_PIVOT:
		{
			EaseTransitionVariant* _tmp4_ = NULL;
			EaseTransitionVariant* _tmp5_;
			result = (_tmp5_ = (_tmp4_ = g_new0 (EaseTransitionVariant, 4), _tmp4_[0] = EASE_TRANSITION_VARIANT_TOP_LEFT, _tmp4_[1] = EASE_TRANSITION_VARIANT_TOP_RIGHT, _tmp4_[2] = EASE_TRANSITION_VARIANT_BOTTOM_LEFT, _tmp4_[3] = EASE_TRANSITION_VARIANT_BOTTOM_RIGHT, _tmp4_), *result_length1 = 4, _tmp5_);
#line 175 "ease-transitions.vala"
			return result;
#line 471 "ease-transitions.c"
		}
		case EASE_TRANSITION_FLIP:
		{
			EaseTransitionVariant* _tmp6_ = NULL;
			EaseTransitionVariant* _tmp7_;
			result = (_tmp7_ = (_tmp6_ = g_new0 (EaseTransitionVariant, 4), _tmp6_[0] = EASE_TRANSITION_VARIANT_LEFT_TO_RIGHT, _tmp6_[1] = EASE_TRANSITION_VARIANT_RIGHT_TO_LEFT, _tmp6_[2] = EASE_TRANSITION_VARIANT_TOP_TO_BOTTOM, _tmp6_[3] = EASE_TRANSITION_VARIANT_BOTTOM_TO_TOP, _tmp6_), *result_length1 = 4, _tmp7_);
#line 181 "ease-transitions.vala"
			return result;
#line 480 "ease-transitions.c"
		}
		case EASE_TRANSITION_ZOOM:
		{
			EaseTransitionVariant* _tmp8_ = NULL;
			EaseTransitionVariant* _tmp9_;
			result = (_tmp9_ = (_tmp8_ = g_new0 (EaseTransitionVariant, 9), _tmp8_[0] = EASE_TRANSITION_VARIANT_CENTER, _tmp8_[1] = EASE_TRANSITION_VARIANT_TOP, _tmp8_[2] = EASE_TRANSITION_VARIANT_BOTTOM, _tmp8_[3] = EASE_TRANSITION_VARIANT_LEFT, _tmp8_[4] = EASE_TRANSITION_VARIANT_RIGHT, _tmp8_[5] = EASE_TRANSITION_VARIANT_TOP_LEFT, _tmp8_[6] = EASE_TRANSITION_VARIANT_TOP_RIGHT, _tmp8_[7] = EASE_TRANSITION_VARIANT_BOTTOM_LEFT, _tmp8_[8] = EASE_TRANSITION_VARIANT_BOTTOM_RIGHT, _tmp8_), *result_length1 = 9, _tmp9_);
#line 187 "ease-transitions.vala"
			return result;
#line 489 "ease-transitions.c"
		}
		case EASE_TRANSITION_SPIN_CONTENTS:
		{
			EaseTransitionVariant* _tmp10_ = NULL;
			EaseTransitionVariant* _tmp11_;
			result = (_tmp11_ = (_tmp10_ = g_new0 (EaseTransitionVariant, 2), _tmp10_[0] = EASE_TRANSITION_VARIANT_LEFT, _tmp10_[1] = EASE_TRANSITION_VARIANT_RIGHT, _tmp10_), *result_length1 = 2, _tmp11_);
#line 198 "ease-transitions.vala"
			return result;
#line 498 "ease-transitions.c"
		}
		case EASE_TRANSITION_SPRING_CONTENTS:
		{
			EaseTransitionVariant* _tmp12_ = NULL;
			EaseTransitionVariant* _tmp13_;
			result = (_tmp13_ = (_tmp12_ = g_new0 (EaseTransitionVariant, 2), _tmp12_[0] = EASE_TRANSITION_VARIANT_UP, _tmp12_[1] = EASE_TRANSITION_VARIANT_DOWN, _tmp12_), *result_length1 = 2, _tmp13_);
#line 202 "ease-transitions.vala"
			return result;
#line 507 "ease-transitions.c"
		}
		case EASE_TRANSITION_ZOOM_CONTENTS:
		{
			EaseTransitionVariant* _tmp14_ = NULL;
			EaseTransitionVariant* _tmp15_;
			result = (_tmp15_ = (_tmp14_ = g_new0 (EaseTransitionVariant, 2), _tmp14_[0] = EASE_TRANSITION_VARIANT_IN, _tmp14_[1] = EASE_TRANSITION_VARIANT_OUT, _tmp14_), *result_length1 = 2, _tmp15_);
#line 206 "ease-transitions.vala"
			return result;
#line 516 "ease-transitions.c"
		}
		default:
		{
			EaseTransitionVariant* _tmp16_ = NULL;
			EaseTransitionVariant* _tmp17_;
#line 210 "ease-transitions.vala"
			g_critical ("ease-transitions.vala:210: Undefined transition %i", (gint) self);
#line 524 "ease-transitions.c"
			result = (_tmp17_ = (_tmp16_ = g_new0 (EaseTransitionVariant, 0), _tmp16_), *result_length1 = 0, _tmp17_);
#line 211 "ease-transitions.vala"
			return result;
#line 528 "ease-transitions.c"
		}
	}
}


#line 215 "ease-transitions.vala"
char* ease_transition_get_name (EaseTransition self) {
#line 536 "ease-transitions.c"
	char* result = NULL;
#line 217 "ease-transitions.vala"
	switch (self) {
#line 540 "ease-transitions.c"
		case EASE_TRANSITION_NONE:
		{
			result = g_strdup (_ ("None"));
#line 220 "ease-transitions.vala"
			return result;
#line 546 "ease-transitions.c"
		}
		case EASE_TRANSITION_FADE:
		{
			result = g_strdup (_ ("Fade"));
#line 222 "ease-transitions.vala"
			return result;
#line 553 "ease-transitions.c"
		}
		case EASE_TRANSITION_SLIDE:
		{
			result = g_strdup (_ ("Slide"));
#line 224 "ease-transitions.vala"
			return result;
#line 560 "ease-transitions.c"
		}
		case EASE_TRANSITION_DROP:
		{
			result = g_strdup (_ ("Drop"));
#line 226 "ease-transitions.vala"
			return result;
#line 567 "ease-transitions.c"
		}
		case EASE_TRANSITION_PIVOT:
		{
			result = g_strdup (_ ("Pivot"));
#line 228 "ease-transitions.vala"
			return result;
#line 574 "ease-transitions.c"
		}
		case EASE_TRANSITION_FLIP:
		{
			result = g_strdup (_ ("Flip"));
#line 230 "ease-transitions.vala"
			return result;
#line 581 "ease-transitions.c"
		}
		case EASE_TRANSITION_REVOLVING_DOOR:
		{
			result = g_strdup (_ ("Revolving Door"));
#line 232 "ease-transitions.vala"
			return result;
#line 588 "ease-transitions.c"
		}
		case EASE_TRANSITION_REVEAL:
		{
			result = g_strdup (_ ("Reveal"));
#line 234 "ease-transitions.vala"
			return result;
#line 595 "ease-transitions.c"
		}
		case EASE_TRANSITION_FALL:
		{
			result = g_strdup (_ ("Fall"));
#line 236 "ease-transitions.vala"
			return result;
#line 602 "ease-transitions.c"
		}
		case EASE_TRANSITION_SLATS:
		{
			result = g_strdup (_ ("Slats"));
#line 238 "ease-transitions.vala"
			return result;
#line 609 "ease-transitions.c"
		}
		case EASE_TRANSITION_OPEN_DOOR:
		{
			result = g_strdup (_ ("Open Door"));
#line 240 "ease-transitions.vala"
			return result;
#line 616 "ease-transitions.c"
		}
		case EASE_TRANSITION_EXPLODE:
		{
			result = g_strdup (_ ("Explode"));
#line 242 "ease-transitions.vala"
			return result;
#line 623 "ease-transitions.c"
		}
		case EASE_TRANSITION_ASSEMBLE:
		{
			result = g_strdup (_ ("Assemble"));
#line 244 "ease-transitions.vala"
			return result;
#line 630 "ease-transitions.c"
		}
		case EASE_TRANSITION_ZOOM:
		{
			result = g_strdup (_ ("Zoom"));
#line 246 "ease-transitions.vala"
			return result;
#line 637 "ease-transitions.c"
		}
		case EASE_TRANSITION_PANEL:
		{
			result = g_strdup (_ ("Panel"));
#line 248 "ease-transitions.vala"
			return result;
#line 644 "ease-transitions.c"
		}
		case EASE_TRANSITION_INTERSPERSE_CONTENTS:
		{
			result = g_strdup (_ ("Intersperse Contents"));
#line 250 "ease-transitions.vala"
			return result;
#line 651 "ease-transitions.c"
		}
		case EASE_TRANSITION_SPIN_CONTENTS:
		{
			result = g_strdup (_ ("Spin Contents"));
#line 252 "ease-transitions.vala"
			return result;
#line 658 "ease-transitions.c"
		}
		case EASE_TRANSITION_SPRING_CONTENTS:
		{
			result = g_strdup (_ ("Spring Contents"));
#line 254 "ease-transitions.vala"
			return result;
#line 665 "ease-transitions.c"
		}
		case EASE_TRANSITION_SWING_CONTENTS:
		{
			result = g_strdup (_ ("Swing Contents"));
#line 256 "ease-transitions.vala"
			return result;
#line 672 "ease-transitions.c"
		}
		case EASE_TRANSITION_SLIDE_CONTENTS:
		{
			result = g_strdup (_ ("Slide Contents"));
#line 258 "ease-transitions.vala"
			return result;
#line 679 "ease-transitions.c"
		}
		case EASE_TRANSITION_ZOOM_CONTENTS:
		{
			result = g_strdup (_ ("Zoom Contents"));
#line 260 "ease-transitions.vala"
			return result;
#line 686 "ease-transitions.c"
		}
		default:
		{
#line 262 "ease-transitions.vala"
			g_critical ("ease-transitions.vala:262: Undefined transition %i", (gint) self);
#line 692 "ease-transitions.c"
			result = g_strdup (_ ("Undefined"));
#line 263 "ease-transitions.vala"
			return result;
#line 696 "ease-transitions.c"
		}
	}
}


/**
 * All transitions available in Ease
 */
GType ease_transition_get_type (void) {
	static volatile gsize ease_transition_type_id__volatile = 0;
	if (g_once_init_enter (&ease_transition_type_id__volatile)) {
		static const GEnumValue values[] = {{EASE_TRANSITION_NONE, "EASE_TRANSITION_NONE", "none"}, {EASE_TRANSITION_FADE, "EASE_TRANSITION_FADE", "fade"}, {EASE_TRANSITION_SLIDE, "EASE_TRANSITION_SLIDE", "slide"}, {EASE_TRANSITION_DROP, "EASE_TRANSITION_DROP", "drop"}, {EASE_TRANSITION_PIVOT, "EASE_TRANSITION_PIVOT", "pivot"}, {EASE_TRANSITION_FLIP, "EASE_TRANSITION_FLIP", "flip"}, {EASE_TRANSITION_REVOLVING_DOOR, "EASE_TRANSITION_REVOLVING_DOOR", "revolving-door"}, {EASE_TRANSITION_REVEAL, "EASE_TRANSITION_REVEAL", "reveal"}, {EASE_TRANSITION_FALL, "EASE_TRANSITION_FALL", "fall"}, {EASE_TRANSITION_SLATS, "EASE_TRANSITION_SLATS", "slats"}, {EASE_TRANSITION_OPEN_DOOR, "EASE_TRANSITION_OPEN_DOOR", "open-door"}, {EASE_TRANSITION_EXPLODE, "EASE_TRANSITION_EXPLODE", "explode"}, {EASE_TRANSITION_ASSEMBLE, "EASE_TRANSITION_ASSEMBLE", "assemble"}, {EASE_TRANSITION_ZOOM, "EASE_TRANSITION_ZOOM", "zoom"}, {EASE_TRANSITION_PANEL, "EASE_TRANSITION_PANEL", "panel"}, {EASE_TRANSITION_INTERSPERSE_CONTENTS, "EASE_TRANSITION_INTERSPERSE_CONTENTS", "intersperse-contents"}, {EASE_TRANSITION_SPIN_CONTENTS, "EASE_TRANSITION_SPIN_CONTENTS", "spin-contents"}, {EASE_TRANSITION_SPRING_CONTENTS, "EASE_TRANSITION_SPRING_CONTENTS", "spring-contents"}, {EASE_TRANSITION_SWING_CONTENTS, "EASE_TRANSITION_SWING_CONTENTS", "swing-contents"}, {EASE_TRANSITION_SLIDE_CONTENTS, "EASE_TRANSITION_SLIDE_CONTENTS", "slide-contents"}, {EASE_TRANSITION_ZOOM_CONTENTS, "EASE_TRANSITION_ZOOM_CONTENTS", "zoom-contents"}, {0, NULL, NULL}};
		GType ease_transition_type_id;
		ease_transition_type_id = g_enum_register_static ("EaseTransition", values);
		g_once_init_leave (&ease_transition_type_id__volatile, ease_transition_type_id);
	}
	return ease_transition_type_id__volatile;
}


#line 291 "ease-transitions.vala"
EaseTransitionVariant ease_transition_variant_from_string (const char* str) {
#line 719 "ease-transitions.c"
	EaseTransitionVariant result = 0;
	const char* _tmp0_;
	GQuark _tmp1_;
	static GQuark _tmp1__label0 = 0;
	static GQuark _tmp1__label1 = 0;
	static GQuark _tmp1__label2 = 0;
	static GQuark _tmp1__label3 = 0;
	static GQuark _tmp1__label4 = 0;
	static GQuark _tmp1__label5 = 0;
	static GQuark _tmp1__label6 = 0;
	static GQuark _tmp1__label7 = 0;
	static GQuark _tmp1__label8 = 0;
	static GQuark _tmp1__label9 = 0;
	static GQuark _tmp1__label10 = 0;
	static GQuark _tmp1__label11 = 0;
	static GQuark _tmp1__label12 = 0;
	static GQuark _tmp1__label13 = 0;
	static GQuark _tmp1__label14 = 0;
	static GQuark _tmp1__label15 = 0;
	static GQuark _tmp1__label16 = 0;
#line 291 "ease-transitions.vala"
	g_return_val_if_fail (str != NULL, 0);
#line 742 "ease-transitions.c"
	_tmp0_ = str;
	_tmp1_ = (NULL == _tmp0_) ? 0 : g_quark_from_string (_tmp0_);
	if (_tmp1_ == ((0 != _tmp1__label0) ? _tmp1__label0 : (_tmp1__label0 = g_quark_from_static_string ("EASE_TRANSITION_VARIANT_UP"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_VARIANT_UP;
#line 296 "ease-transitions.vala"
			return result;
#line 752 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label1) ? _tmp1__label1 : (_tmp1__label1 = g_quark_from_static_string ("EASE_TRANSITION_VARIANT_DOWN"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_VARIANT_DOWN;
#line 298 "ease-transitions.vala"
			return result;
#line 761 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label2) ? _tmp1__label2 : (_tmp1__label2 = g_quark_from_static_string ("EASE_TRANSITION_VARIANT_LEFT"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_VARIANT_LEFT;
#line 300 "ease-transitions.vala"
			return result;
#line 770 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label3) ? _tmp1__label3 : (_tmp1__label3 = g_quark_from_static_string ("EASE_TRANSITION_VARIANT_RIGHT"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_VARIANT_RIGHT;
#line 302 "ease-transitions.vala"
			return result;
#line 779 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label4) ? _tmp1__label4 : (_tmp1__label4 = g_quark_from_static_string ("EASE_TRANSITION_VARIANT_BOTTOM"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_VARIANT_BOTTOM;
#line 304 "ease-transitions.vala"
			return result;
#line 788 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label5) ? _tmp1__label5 : (_tmp1__label5 = g_quark_from_static_string ("EASE_TRANSITION_VARIANT_TOP"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_VARIANT_TOP;
#line 306 "ease-transitions.vala"
			return result;
#line 797 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label6) ? _tmp1__label6 : (_tmp1__label6 = g_quark_from_static_string ("EASE_TRANSITION_VARIANT_CENTER"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_VARIANT_CENTER;
#line 308 "ease-transitions.vala"
			return result;
#line 806 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label7) ? _tmp1__label7 : (_tmp1__label7 = g_quark_from_static_string ("EASE_TRANSITION_VARIANT_TOP_LEFT"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_VARIANT_TOP_LEFT;
#line 310 "ease-transitions.vala"
			return result;
#line 815 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label8) ? _tmp1__label8 : (_tmp1__label8 = g_quark_from_static_string ("EASE_TRANSITION_VARIANT_TOP_RIGHT"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_VARIANT_TOP_RIGHT;
#line 312 "ease-transitions.vala"
			return result;
#line 824 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label9) ? _tmp1__label9 : (_tmp1__label9 = g_quark_from_static_string ("EASE_TRANSITION_VARIANT_BOTTOM_LEFT"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_VARIANT_BOTTOM_LEFT;
#line 314 "ease-transitions.vala"
			return result;
#line 833 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label10) ? _tmp1__label10 : (_tmp1__label10 = g_quark_from_static_string ("EASE_TRANSITION_VARIANT_BOTTOM_RIGHT"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_VARIANT_BOTTOM_RIGHT;
#line 316 "ease-transitions.vala"
			return result;
#line 842 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label11) ? _tmp1__label11 : (_tmp1__label11 = g_quark_from_static_string ("EASE_TRANSITION_VARIANT_TOP_TO_BOTTOM"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_VARIANT_TOP_TO_BOTTOM;
#line 318 "ease-transitions.vala"
			return result;
#line 851 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label12) ? _tmp1__label12 : (_tmp1__label12 = g_quark_from_static_string ("EASE_TRANSITION_VARIANT_BOTTOM_TO_TOP"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_VARIANT_BOTTOM_TO_TOP;
#line 320 "ease-transitions.vala"
			return result;
#line 860 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label13) ? _tmp1__label13 : (_tmp1__label13 = g_quark_from_static_string ("EASE_TRANSITION_VARIANT_LEFT_TO_RIGHT"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_VARIANT_LEFT_TO_RIGHT;
#line 322 "ease-transitions.vala"
			return result;
#line 869 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label14) ? _tmp1__label14 : (_tmp1__label14 = g_quark_from_static_string ("EASE_TRANSITION_VARIANT_RIGHT_TO_LEFT"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_VARIANT_RIGHT_TO_LEFT;
#line 324 "ease-transitions.vala"
			return result;
#line 878 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label15) ? _tmp1__label15 : (_tmp1__label15 = g_quark_from_static_string ("EASE_TRANSITION_VARIANT_IN"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_VARIANT_IN;
#line 326 "ease-transitions.vala"
			return result;
#line 887 "ease-transitions.c"
		}
	} else if (_tmp1_ == ((0 != _tmp1__label16) ? _tmp1__label16 : (_tmp1__label16 = g_quark_from_static_string ("EASE_TRANSITION_VARIANT_OUT"))))
	switch (0) {
		default:
		{
			result = EASE_TRANSITION_VARIANT_OUT;
#line 328 "ease-transitions.vala"
			return result;
#line 896 "ease-transitions.c"
		}
	} else
	switch (0) {
		default:
		{
#line 330 "ease-transitions.vala"
			g_critical ("ease-transitions.vala:330: Invalid transition variant: %s", str);
#line 904 "ease-transitions.c"
			result = EASE_TRANSITION_VARIANT_UP;
#line 331 "ease-transitions.vala"
			return result;
#line 908 "ease-transitions.c"
		}
	}
}


#line 335 "ease-transitions.vala"
char* ease_transition_variant_get_name (EaseTransitionVariant self) {
#line 916 "ease-transitions.c"
	char* result = NULL;
#line 337 "ease-transitions.vala"
	switch (self) {
#line 920 "ease-transitions.c"
		case EASE_TRANSITION_VARIANT_UP:
		{
			result = g_strdup (_ ("Up"));
#line 340 "ease-transitions.vala"
			return result;
#line 926 "ease-transitions.c"
		}
		case EASE_TRANSITION_VARIANT_DOWN:
		{
			result = g_strdup (_ ("Down"));
#line 342 "ease-transitions.vala"
			return result;
#line 933 "ease-transitions.c"
		}
		case EASE_TRANSITION_VARIANT_LEFT:
		{
			result = g_strdup (_ ("Left"));
#line 344 "ease-transitions.vala"
			return result;
#line 940 "ease-transitions.c"
		}
		case EASE_TRANSITION_VARIANT_RIGHT:
		{
			result = g_strdup (_ ("Right"));
#line 346 "ease-transitions.vala"
			return result;
#line 947 "ease-transitions.c"
		}
		case EASE_TRANSITION_VARIANT_BOTTOM:
		{
			result = g_strdup (_ ("Bottom"));
#line 348 "ease-transitions.vala"
			return result;
#line 954 "ease-transitions.c"
		}
		case EASE_TRANSITION_VARIANT_TOP:
		{
			result = g_strdup (_ ("Top"));
#line 350 "ease-transitions.vala"
			return result;
#line 961 "ease-transitions.c"
		}
		case EASE_TRANSITION_VARIANT_CENTER:
		{
			result = g_strdup (_ ("Center"));
#line 352 "ease-transitions.vala"
			return result;
#line 968 "ease-transitions.c"
		}
		case EASE_TRANSITION_VARIANT_TOP_LEFT:
		{
			result = g_strdup (_ ("Top Left"));
#line 354 "ease-transitions.vala"
			return result;
#line 975 "ease-transitions.c"
		}
		case EASE_TRANSITION_VARIANT_TOP_RIGHT:
		{
			result = g_strdup (_ ("Top Right"));
#line 356 "ease-transitions.vala"
			return result;
#line 982 "ease-transitions.c"
		}
		case EASE_TRANSITION_VARIANT_BOTTOM_LEFT:
		{
			result = g_strdup (_ ("Bottom Left"));
#line 358 "ease-transitions.vala"
			return result;
#line 989 "ease-transitions.c"
		}
		case EASE_TRANSITION_VARIANT_BOTTOM_RIGHT:
		{
			result = g_strdup (_ ("Bottom Right"));
#line 360 "ease-transitions.vala"
			return result;
#line 996 "ease-transitions.c"
		}
		case EASE_TRANSITION_VARIANT_TOP_TO_BOTTOM:
		{
			result = g_strdup (_ ("Top to Bottom"));
#line 362 "ease-transitions.vala"
			return result;
#line 1003 "ease-transitions.c"
		}
		case EASE_TRANSITION_VARIANT_BOTTOM_TO_TOP:
		{
			result = g_strdup (_ ("Bottom to Top"));
#line 364 "ease-transitions.vala"
			return result;
#line 1010 "ease-transitions.c"
		}
		case EASE_TRANSITION_VARIANT_LEFT_TO_RIGHT:
		{
			result = g_strdup (_ ("Left to Right"));
#line 366 "ease-transitions.vala"
			return result;
#line 1017 "ease-transitions.c"
		}
		case EASE_TRANSITION_VARIANT_RIGHT_TO_LEFT:
		{
			result = g_strdup (_ ("Right to Left"));
#line 368 "ease-transitions.vala"
			return result;
#line 1024 "ease-transitions.c"
		}
		case EASE_TRANSITION_VARIANT_IN:
		{
			result = g_strdup (_ ("In"));
#line 370 "ease-transitions.vala"
			return result;
#line 1031 "ease-transitions.c"
		}
		case EASE_TRANSITION_VARIANT_OUT:
		{
			result = g_strdup (_ ("Out"));
#line 372 "ease-transitions.vala"
			return result;
#line 1038 "ease-transitions.c"
		}
		default:
		{
#line 374 "ease-transitions.vala"
			g_critical ("ease-transitions.vala:374: Undefined variant: %i", (gint) self);
#line 1044 "ease-transitions.c"
			result = g_strdup (_ ("Undefined"));
#line 375 "ease-transitions.vala"
			return result;
#line 1048 "ease-transitions.c"
		}
	}
}


/**
 * All transition variants available in Ease. Each transition uses a subset.
 */
GType ease_transition_variant_get_type (void) {
	static volatile gsize ease_transition_variant_type_id__volatile = 0;
	if (g_once_init_enter (&ease_transition_variant_type_id__volatile)) {
		static const GEnumValue values[] = {{EASE_TRANSITION_VARIANT_LEFT, "EASE_TRANSITION_VARIANT_LEFT", "left"}, {EASE_TRANSITION_VARIANT_RIGHT, "EASE_TRANSITION_VARIANT_RIGHT", "right"}, {EASE_TRANSITION_VARIANT_UP, "EASE_TRANSITION_VARIANT_UP", "up"}, {EASE_TRANSITION_VARIANT_DOWN, "EASE_TRANSITION_VARIANT_DOWN", "down"}, {EASE_TRANSITION_VARIANT_BOTTOM, "EASE_TRANSITION_VARIANT_BOTTOM", "bottom"}, {EASE_TRANSITION_VARIANT_TOP, "EASE_TRANSITION_VARIANT_TOP", "top"}, {EASE_TRANSITION_VARIANT_CENTER, "EASE_TRANSITION_VARIANT_CENTER", "center"}, {EASE_TRANSITION_VARIANT_TOP_LEFT, "EASE_TRANSITION_VARIANT_TOP_LEFT", "top-left"}, {EASE_TRANSITION_VARIANT_TOP_RIGHT, "EASE_TRANSITION_VARIANT_TOP_RIGHT", "top-right"}, {EASE_TRANSITION_VARIANT_BOTTOM_LEFT, "EASE_TRANSITION_VARIANT_BOTTOM_LEFT", "bottom-left"}, {EASE_TRANSITION_VARIANT_BOTTOM_RIGHT, "EASE_TRANSITION_VARIANT_BOTTOM_RIGHT", "bottom-right"}, {EASE_TRANSITION_VARIANT_TOP_TO_BOTTOM, "EASE_TRANSITION_VARIANT_TOP_TO_BOTTOM", "top-to-bottom"}, {EASE_TRANSITION_VARIANT_BOTTOM_TO_TOP, "EASE_TRANSITION_VARIANT_BOTTOM_TO_TOP", "bottom-to-top"}, {EASE_TRANSITION_VARIANT_LEFT_TO_RIGHT, "EASE_TRANSITION_VARIANT_LEFT_TO_RIGHT", "left-to-right"}, {EASE_TRANSITION_VARIANT_RIGHT_TO_LEFT, "EASE_TRANSITION_VARIANT_RIGHT_TO_LEFT", "right-to-left"}, {EASE_TRANSITION_VARIANT_IN, "EASE_TRANSITION_VARIANT_IN", "in"}, {EASE_TRANSITION_VARIANT_OUT, "EASE_TRANSITION_VARIANT_OUT", "out"}, {0, NULL, NULL}};
		GType ease_transition_variant_type_id;
		ease_transition_variant_type_id = g_enum_register_static ("EaseTransitionVariant", values);
		g_once_init_leave (&ease_transition_variant_type_id__volatile, ease_transition_variant_type_id);
	}
	return ease_transition_variant_type_id__volatile;
}




