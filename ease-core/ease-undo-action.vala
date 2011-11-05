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
 * Generic undo item, using object/property pairs.
 */
public class Ease.UndoAction : UndoItem
{
	internal Gee.LinkedList<UndoPair> pairs = new Gee.LinkedList<UndoPair>();
	
	/**
	 * Creates an UndoAction.
	 *
	 * This should be followed up with calls to add() if the action has
	 * multiple properties (or someone could figure out varargs in Vala).
	 *
	 * @param obj The first object.
	 * @param val The first property.
	 */
	public UndoAction(GLib.Object obj, string prop)
	{
		pairs.add(new UndoPair(obj, prop));
	}
	
	/**
	 * Adds an additional object/property pair.
	 *
	 * @param obj The first object.
	 * @param val The first property.
	 */
	public void add(GLib.Object obj, string prop)
	{
		pairs.add(new UndoPair(obj, prop));
	}
	
	/**
	 * Adds all properties of the given UndoAction to this action.
	 *
	 * @param action An UndoAction to add properties from.
	 */
	public void combine(UndoAction action)
	{
		foreach (var p in action.pairs) pairs.add(p);
	}
	
	/**
	 * Applies the {@link UndoAction}, restoring previous settings.
	 *
	 * Returns an UndoAction that will redo the undo action.
	 */
	public override UndoItem apply()
	{
		pre_apply(this);
		foreach (var pair in pairs) pair.apply();
		applied(this);
		return this;
	}
	
	/**
	 * Returns true if this action contains a property on the specified object.
	 */
	public override bool contains(GLib.Object? obj)
	{
		if (obj == null) return false;
		foreach (var pair in pairs)
		{
			if (pair.object == obj) return true;
		}
		return false;
	}
	
	/**
	 * Embedded class for storing object/property pairs in undo actions.
	 */
	internal class UndoPair
	{
		public string property;
		public GLib.Object object;
		public GLib.Value val;
		public GLib.Type type;
		
		public UndoPair(GLib.Object obj, string prop)
		{
			// basic properties
			object = obj;
			property = prop;
			
			// find the type and create a value
			type = obj.get_class().find_property(prop).value_type;
			val = GLib.Value(type);
			
			// fill in the GValue
			obj.get_property(prop, ref val);
		}
		
		/**
		 * Applies this UndoPair, restoring the property to its original value.
		 *
		 * The current (before restoration) value is then placed into this
		 * UndoPair, converting it into a "RedoPair" of sorts.
		 */
		public void apply()
		{
			// remember the current value so that it can be restored (redo)
			GLib.Value temp = GLib.Value(type);
			object.get_property(property, ref temp);
			
			// restore the old value
			object.set_property(property, val);
			
			// give the pair the old value so it can be used to revert
			val = temp;
		}
	}
}

