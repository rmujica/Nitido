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
 * Undos the addition of an {@link Element} to a {@link Slide}.
 */
internal class Ease.ElementAddUndoAction : UndoItem
{
	/**
	 * The {@link Element} that was added.
	 */
	private Element element;
	
	/**
	 * Creates an ElementAddUndoAction.
	 *
	 * @param e The element that was added.
	 */
	internal ElementAddUndoAction(Element e)
	{
		element = e;
	}
	
	/**
	 * Applies the action, removing the {@link Element}.
	 */
	internal override UndoItem apply()
	{
		var action = new ElementRemoveUndoAction(element);
		element.parent.remove_actual(element, false);
		return action;
	}
}

/**
 * Undos the removal of an {@link Element} from a {@link Slide}.
 */
internal class Ease.ElementRemoveUndoAction : UndoItem
{
	/**
	 * The {@link Element} that was removed.
	 */
	private Element element;
	
	/**
	 * The {@link Slide} that the Element was removed from.
	 */
	private Slide slide;
	
	/**
	 * The index of the Element in the Slide's stack.
	 */
	int index;
	
	/**
	 * Creates an ElementRemoveUndoAction. Note that this method references
	 * {@link Element.parent}. Therefore, the action must be constructed
	 * before the Element is actually removed.
	 *
	 * @param e The element that was added.
	 */
	internal ElementRemoveUndoAction(Element e)
	{
		element = e;
		slide = e.parent;
		index = e.parent.index_of(e);
	}
	
	/**
	 * Applies the action, restoring the {@link Element}.
	 */
	internal override UndoItem apply()
	{
		slide.add_actual(index, element, false);
		return new ElementAddUndoAction(element);
	}
}

internal class Ease.ElementReorderUndoAction : UndoItem
{
	/**
	 * The {@link Element} that was reordered.
	 */
	private Element element;
	
	/**
	 * The {@link Slide} that the Element was reordered on.
	 */
	private Slide slide;
	
	/**
	 * The original index of the Element.
	 */
	private int index_orig;
	
	/**
	 * The new index of the Element.
	 */
	private int index_current;
	
	/**
	 * Creates an ElementReorderUndoAction.
	 *
	 * @param e The element that was added.
	 * @param orig The original index of the element.
	 * @param current The new index of the element.
	 */
	internal ElementReorderUndoAction(Element e, int orig, int current)
	{
		element = e;
		slide = e.parent;
		index_orig = orig;
		index_current = current;
	}
	
	/**
	 * Applies the action, restoring the {@link Element}.
	 */
	internal override UndoItem apply()
	{
		slide.reorder(element, index_current, index_orig);
		
		// swap the indicies, return the same undoitem
		var temp = index_current;
		index_orig = index_current;
		index_current = temp;
		
		return this;
	}
}

