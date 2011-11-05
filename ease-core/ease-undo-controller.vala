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
 * Controls undo and redo actions.
 *
 * Each EditorWindow has an UndoController that manages undo actions.
 */
public class Ease.UndoController : Object
{
	/**
	 * The undo queue.
	 */
	private Gee.LinkedList<UndoItem> undos = new Gee.LinkedList<UndoItem>();
	
	/**
	 * The redo queue.
	 */
	private Gee.LinkedList<UndoItem> redos = new Gee.LinkedList<UndoItem>();
	
	/**
	 * Allows debug messages to be printed every time an action is added.
	 */
	public static bool enable_debug { get; set; default = false; }
	
	/**
	 * Creates an UndoController. Used by EditorWindow.
	 */
	public UndoController() { }
	
	/**
	 * Returns true if there is an action available to undo.
	 */
	public bool can_undo()
	{
		return undos.size > 0;
	}
	
	/**
	 * Returns true if there is an action available to redo.
	 */
	public bool can_redo()
	{
		return redos.size > 0;
	}
	
	/**
	 * Undoes the first available {@link UndoItem} in the undo queue.
	 */
	public void undo()
	{
		add_redo_action(undos.poll_head().apply());
	}
	
	/**
	 * Redoes the first available {@link UndoItem} in the redo queue.
	 */
	public void redo()
	{
		add_action(redos.poll_head().apply());
	}
	
	/**
	 * Clears the redo queue.
	 */
	public void clear_redo()
	{
		redos.clear();
	}
	
	/**
	 * Adds a new {@link UndoItem} as the first action.
	 *
	 * @param action The new {@link UndoItem}.
	 */
	public void add_action(UndoItem action)
	{
		if (enable_debug)
		{
			if (action.get_type() == typeof(UndoAction))
			{
				stdout.printf("UNDO ACTION ADDED WITH THESE PROPERTIES:\n");
				foreach (var pair in (action as UndoAction).pairs)
				{
					stdout.printf("\t%s\n", pair.property);
				}
				stdout.printf("\n");
			}
		}
		undos.offer_head(action);
	}
	
	/**
	 * Adds a new {@link UndoItem} as the first action.
	 *
	 * @param action The new {@link UndoItem}.
	 */
	private void add_redo_action(UndoItem action)
	{
		if (enable_debug)
		{
			if (action.get_type() == typeof(UndoAction))
			{
				stdout.printf("REDO ACTION ADDED WITH THESE PROPERTIES:\n");
				foreach (var pair in (action as UndoAction).pairs)
				{
					stdout.printf("\t%s\n", pair.property);
				}
				stdout.printf("\n");
			}
		}
		
		redos.offer_head(action);
	}
}
