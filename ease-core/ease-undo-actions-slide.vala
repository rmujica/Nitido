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
 * Undos the addition of an {@link Slide} to a {@link Document}.
 */
internal class Ease.SlideAddUndoAction : UndoItem
{
	/**
	 * The {@link Slide} that was added.
	 */
	private Slide slide;
	
	/**
	 * Creates an SlideAddUndoAction.
	 *
	 * @param s The slide that was added.
	 */
	internal SlideAddUndoAction(Slide s)
	{
		slide = s;
	}
	
	/**
	 * Applies the action, removing the {@link Slide}.
	 */
	internal override UndoItem apply()
	{
		var action = new SlideRemoveUndoAction(slide);
		slide.parent.remove_slide_actual(slide, false);
		return action;
	}
}

/**
 * Undos the removal of an {@link Slide} from a {@link Document}.
 */
internal class Ease.SlideRemoveUndoAction : UndoItem
{
	/**
	 * The {@link Slide} that was removed.
	 */
	private Slide slide;
	
	/**
	 * The {@link Document} that the Slide was removed from.
	 */
	private Document document;
	
	/**
	 * The index of the Slide in the Document.
	 */
	int index;
	
	/**
	 * Creates an SlideRemoveUndoAction. Note that this method references
	 * {@link Slide.parent}. Therefore, the action must be constructed
	 * before the Slide is actually removed.
	 *
	 * @param s The slide that was added.
	 */
	internal SlideRemoveUndoAction(Slide s)
	{
		slide = s;
		document = s.parent;
		index = s.parent.index_of(s);
	}
	
	/**
	 * Applies the action, restoring the {@link Slide}.
	 */
	internal override UndoItem apply()
	{
		document.add_slide_actual(index, slide, false);
		return new SlideAddUndoAction(slide);
	}
}


