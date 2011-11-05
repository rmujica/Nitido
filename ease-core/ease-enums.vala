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

namespace Ease
{
	/**
	 * The position of editing handles.
	 */
	public enum HandlePosition
	{
		TOP_LEFT = 0,
		TOP_RIGHT = 1,
		TOP = 2,
		LEFT = 3,
		RIGHT = 4,
		BOTTOM_LEFT = 5,
		BOTTOM_RIGHT = 6,
		BOTTOM = 7
	}
	
	/**
	 * The context of an {@link Actor}: presentation, editor, etc.
	 */
	public enum ActorContext
	{
		PRESENTATION,
		EDITOR,
		INSPECTOR
	}
	
	/**
	 * Key values.
	 */
	public enum Key
	{
		// arrow keys
		UP = 65362,
		DOWN = 65364,
		LEFT = 65361,
		RIGHT = 65363,
		
		BACKSPACE = 65288,
		DELETE = 65535,
		ESCAPE = 0xff1b,
		SPACE = 32,
		ENTER = 65293,
	}
}
