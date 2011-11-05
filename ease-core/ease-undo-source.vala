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
 * Provides a signal to notify a controller of {@link UndoItem}s.
 */
public interface Ease.UndoSource : GLib.Object
{
	/**
	 * Classes that implement the UndoSource interface should use this signal
	 * to notify a parent controller (typically an EditorWindow) of a new
	 * UndoAction.
	 */
	public signal void undo(UndoItem action);
	
	/**
	 * Emitted when an UndoItem is forwarded.
	 */
	protected signal void forwarded(UndoItem action);
	
	/**
	 * Forwards an {@link UndoItem} downwards, to any object listening to this
	 * UndoSource's "undo" signal".
	 */
	protected void forward(UndoItem action)
	{
		undo(action);
		forwarded(action);
	}
	
	/**
	 * Listens for incoming UndoItems from the specified UndoSource, and
	 * {@link forward}s them downwards.
	 */
	protected void listen(UndoSource source)
	{
		source.undo.connect(forward);
	}
	
	/**
	 * Stops listening to an UndoSource.
	 */
	protected void silence(UndoSource source)
	{
		source.undo.disconnect(forward);
	}
}
