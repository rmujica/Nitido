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
 * Abstract base class for undo actions.
 *
 * Subclasses should override apply() and add a constructor, as well as any
 * needed data fields.
 */
public abstract class Ease.UndoItem : GLib.Object
{
	/**
	 * Emitted after the item is applied.
	 */
	public signal void applied(UndoAction sender);
	
	/**
	 * Emitted befor the item is applied.
	 */
	public signal void pre_apply(UndoAction sender);
	
	/**
	 * Applies the {@link UndoItem}, restoring previous state.
	 *
	 * Returns an UndoItem that will redo the undo action.
	 */
	public abstract UndoItem apply();
	
	/**
	 * If the UndoItem contains the specified object. {@link UndoAction}
	 * overrides this in a useful way. In its base implementation, always
	 * returns false.
	 */
	public virtual bool contains(GLib.Object? obj)
	{
		return false;
	}
}
