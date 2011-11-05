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

/**
 * All transitions available in Ease
 */
public enum Ease.Transition
{
	NONE,
	FADE,
	SLIDE,
	DROP,
	PIVOT,
	FLIP,
	REVOLVING_DOOR,
	REVEAL,
	FALL,
	SLATS,
	OPEN_DOOR,
	EXPLODE,
	ASSEMBLE,
	ZOOM,
	PANEL,
	INTERSPERSE_CONTENTS,
	SPIN_CONTENTS,
	SPRING_CONTENTS,
	SWING_CONTENTS,
	SLIDE_CONTENTS,
	ZOOM_CONTENTS;
	
	// TODO: get rid of this, there is a vala bug for foreach on enums
	private const Transition[] TRANSITIONS = { NONE,
		                                       FADE,
		                                       SLIDE,
		                                       DROP,
		                                       PIVOT,
		                                       FLIP,
		                                       REVOLVING_DOOR,
		                                       REVEAL,
		                                       FALL,
		                                       //SLATS,
		                                       OPEN_DOOR,
		                                       //EXPLODE,
		                                       //ASSEMBLE,
		                                       ZOOM,
		                                       PANEL,
		                                       //INTERSPERSE_CONTENTS,
		                                       SPIN_CONTENTS,
		                                       SPRING_CONTENTS,
		                                       SWING_CONTENTS,
		                                       SLIDE_CONTENTS,
		                                       ZOOM_CONTENTS };
	
	public static Gtk.ListStore model()
	{
		var store = new Gtk.ListStore(2, typeof(string), typeof(Transition));
		Gtk.TreeIter itr;
		for(int i = 0; i < TRANSITIONS.length; i++)
		{
			store.append(out itr);
			store.set(itr, 0, TRANSITIONS[i].get_name(), 1, TRANSITIONS[i]);
		}
		
		return store;
	}
	
	public Gtk.ListStore variant_model()
	{
		var store = new Gtk.ListStore(2, typeof(string),
		                                 typeof(TransitionVariant));
		Gtk.TreeIter itr;
		foreach (var variant in this.variants())
		{
			store.append(out itr);
			store.set(itr, 0, variant.get_name(), 1, variant);
		}
		
		return store;
	}
	
	public static Transition from_string(string str)
	{
		switch (str)
		{
			case "EASE_TRANSITION_NONE":
				return NONE;
			case "EASE_TRANSITION_FADE":
				return FADE;
			case "EASE_TRANSITION_SLIDE":
				return SLIDE;
			case "EASE_TRANSITION_DROP":
				return DROP;
			case "EASE_TRANSITION_PIVOT":
				return PIVOT;
			case "EASE_TRANSITION_FLIP":
				return FLIP;
			case "EASE_TRANSITION_REVOLVING_DOOR":
				return REVOLVING_DOOR;
			case "EASE_TRANSITION_REVEAL":
				return REVEAL;
			case "EASE_TRANSITION_FALL":
				return FALL;
			case "EASE_TRANSITION_SLATS":
				return SLATS;
			case "EASE_TRANSITION_OPEN_DOOR":
				return OPEN_DOOR;
			case "EASE_TRANSITION_EXPLODE":
				return EXPLODE;
			case "EASE_TRANSITION_ASSEMBLE":
				return ASSEMBLE;
			case "EASE_TRANSITION_ZOOM":
				return ZOOM;
			case "EASE_TRANSITION_PANEL":
				return PANEL;
			case "EASE_TRANSITION_INTERSPERSE_CONTENTS":
				return INTERSPERSE_CONTENTS;
			case "EASE_TRANSITION_SPIN_CONTENTS":
				return SPIN_CONTENTS;
			case "EASE_TRANSITION_SPRING_CONTENTS":
				return SPRING_CONTENTS;
			case "EASE_TRANSITION_SWING_CONTENTS":
				return SWING_CONTENTS;
			case "EASE_TRANSITION_SLIDE_CONTENTS":
				return SLIDE_CONTENTS;
			case "EASE_TRANSITION_ZOOM_CONTENTS":
				return ZOOM_CONTENTS;
			default:
				critical("Invalid transition string: %s", str);
				return NONE;
		}
	}
	
	public TransitionVariant[] variants()
	{
		switch (this)
		{
			case NONE:
			case FADE:
			case DROP:
			case FALL:
			case SLATS:
			case OPEN_DOOR:
			case EXPLODE:
			case ASSEMBLE:
			case SWING_CONTENTS:
			case INTERSPERSE_CONTENTS:
				return {};
			
			case REVOLVING_DOOR:
			case REVEAL:
			case SLIDE:
			case PANEL:
			case SLIDE_CONTENTS:
				return { TransitionVariant.LEFT,
				         TransitionVariant.RIGHT,
				         TransitionVariant.UP,
				         TransitionVariant.DOWN };
			
			
			case PIVOT:
				return { TransitionVariant.TOP_LEFT,
				         TransitionVariant.TOP_RIGHT,
				         TransitionVariant.BOTTOM_LEFT,
				         TransitionVariant.BOTTOM_RIGHT };
				         
			case FLIP:
				return { TransitionVariant.LEFT_TO_RIGHT,
				         TransitionVariant.RIGHT_TO_LEFT,
				         TransitionVariant.TOP_TO_BOTTOM,
				         TransitionVariant.BOTTOM_TO_TOP };
			
			case ZOOM:
				return { TransitionVariant.CENTER,
				         TransitionVariant.TOP,
				         TransitionVariant.BOTTOM,
				         TransitionVariant.LEFT,
				         TransitionVariant.RIGHT,
				         TransitionVariant.TOP_LEFT,
				         TransitionVariant.TOP_RIGHT,
				         TransitionVariant.BOTTOM_LEFT,
				         TransitionVariant.BOTTOM_RIGHT };

			case SPIN_CONTENTS:
				return { TransitionVariant.LEFT,
				         TransitionVariant.RIGHT };
			
			case SPRING_CONTENTS:
				return { TransitionVariant.UP,
				         TransitionVariant.DOWN };
				         
			case ZOOM_CONTENTS:
				return { TransitionVariant.IN,
				         TransitionVariant.OUT };
			
			default:
				critical("Undefined transition %i", this);
				return {};
		}
	}
	
	public string get_name()
	{
		switch (this)
		{
			case NONE:
				return _("None");
			case FADE:
				return _("Fade");
			case SLIDE:
				return _("Slide");
			case DROP:
				return _("Drop");
			case PIVOT:
				return _("Pivot");
			case FLIP:
				return _("Flip");
			case REVOLVING_DOOR:
				return _("Revolving Door");
			case REVEAL:
				return _("Reveal");
			case FALL:
				return _("Fall");
			case SLATS:
				return _("Slats");
			case OPEN_DOOR:
				return _("Open Door");
			case EXPLODE:
				return _("Explode");
			case ASSEMBLE:
				return _("Assemble");
			case ZOOM:
				return _("Zoom");
			case PANEL:
				return _("Panel");
			case INTERSPERSE_CONTENTS:
				return _("Intersperse Contents");
			case SPIN_CONTENTS:
				return _("Spin Contents");
			case SPRING_CONTENTS:
				return _("Spring Contents");
			case SWING_CONTENTS:
				return _("Swing Contents");
			case SLIDE_CONTENTS:
				return _("Slide Contents");
			case ZOOM_CONTENTS:
				return _("Zoom Contents");
			default:
				critical("Undefined transition %i", this);
				return _("Undefined");
		}
	}
}

/**
 * All transition variants available in Ease. Each transition uses a subset.
 */
public enum Ease.TransitionVariant
{
	LEFT,
	RIGHT,
	UP,
	DOWN,	
	BOTTOM,
	TOP,
	CENTER,
	TOP_LEFT,
	TOP_RIGHT,
	BOTTOM_LEFT,
	BOTTOM_RIGHT,
	TOP_TO_BOTTOM,
	BOTTOM_TO_TOP,
	LEFT_TO_RIGHT,
	RIGHT_TO_LEFT,
	IN,
	OUT;
	
	public static TransitionVariant from_string(string str)
	{
		switch (str)
		{
			case "EASE_TRANSITION_VARIANT_UP":
				return UP;
			case "EASE_TRANSITION_VARIANT_DOWN":
				return DOWN;
			case "EASE_TRANSITION_VARIANT_LEFT":
				return LEFT;
			case "EASE_TRANSITION_VARIANT_RIGHT":
				return RIGHT;
			case "EASE_TRANSITION_VARIANT_BOTTOM":
				return BOTTOM;
			case "EASE_TRANSITION_VARIANT_TOP":
				return TOP;
			case "EASE_TRANSITION_VARIANT_CENTER":
				return CENTER;
			case "EASE_TRANSITION_VARIANT_TOP_LEFT":
				return TOP_LEFT;
			case "EASE_TRANSITION_VARIANT_TOP_RIGHT":
				return TOP_RIGHT;
			case "EASE_TRANSITION_VARIANT_BOTTOM_LEFT":
				return BOTTOM_LEFT;
			case "EASE_TRANSITION_VARIANT_BOTTOM_RIGHT":
				return BOTTOM_RIGHT;
			case "EASE_TRANSITION_VARIANT_TOP_TO_BOTTOM":
				return TOP_TO_BOTTOM;
			case "EASE_TRANSITION_VARIANT_BOTTOM_TO_TOP":
				return BOTTOM_TO_TOP;
			case "EASE_TRANSITION_VARIANT_LEFT_TO_RIGHT":
				return LEFT_TO_RIGHT;
			case "EASE_TRANSITION_VARIANT_RIGHT_TO_LEFT":
				return RIGHT_TO_LEFT;
			case "EASE_TRANSITION_VARIANT_IN":
				return IN;
			case "EASE_TRANSITION_VARIANT_OUT":
				return OUT;
			default:
				critical("Invalid transition variant: %s", str);
				return UP;
		}
	}
	
	public string get_name()
	{
		switch (this)
		{
			case TransitionVariant.UP:
				return _("Up");
			case TransitionVariant.DOWN:
				return _("Down");
			case TransitionVariant.LEFT:
				return _("Left");
			case TransitionVariant.RIGHT:
				return _("Right");
			case TransitionVariant.BOTTOM:
				return _("Bottom");
			case TransitionVariant.TOP:
				return _("Top");
			case TransitionVariant.CENTER:
				return _("Center");
			case TransitionVariant.TOP_LEFT:
				return _("Top Left");
			case TransitionVariant.TOP_RIGHT:
				return _("Top Right");
			case TransitionVariant.BOTTOM_LEFT:
				return _("Bottom Left");
			case TransitionVariant.BOTTOM_RIGHT:
				return _("Bottom Right");
			case TransitionVariant.TOP_TO_BOTTOM:
				return _("Top to Bottom");
			case TransitionVariant.BOTTOM_TO_TOP:
				return _("Bottom to Top");
			case TransitionVariant.LEFT_TO_RIGHT:
				return _("Left to Right");
			case TransitionVariant.RIGHT_TO_LEFT:
				return _("Right to Left");
			case TransitionVariant.IN:
				return _("In");
			case TransitionVariant.OUT:
				return _("Out");
			default:
				critical("Undefined variant: %i", this);
				return _("Undefined");
		}
	}
}

